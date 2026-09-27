

--Cleaning Data in SQL Queries

select *
from PortFolioProject..NashvilleHousing
order by 1,2 

-- 1)Standarize Data Format 

select SaleDate
from PortFolioProject..NashvilleHousing

select SaleDate, SaledDateConverted, CONVERT(Date, SaleDate)
from PortFolioProject..NashvilleHousing

Update NashvilleHousing
set SaleDate = CONVERT(Date, SaleDate) 

--kan wxa waaye in date ka la hagaajiyo, time aala socdo so date lee sida loogo reebi lhaay 
--alter mean to create a cloumn, and now the coloumn we created is SaledDateConverted
ALTER TABLE NashvilleHousing
add SaledDateConverted Date; 

Update NashvilleHousing
set SaledDateConverted = CONVERT(Date, SaleDate)


-- 2) populate property address data

select *
from PortFolioProject..NashvilleHousing
--where PropertyAddress is not null
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull( a.PropertyAddress,b.PropertyAddress) 
from PortFolioProject..NashvilleHousing a 
join PortFolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is not  null

update a
set PropertyAddress = isnull( a.PropertyAddress,b.PropertyAddress) 
from PortFolioProject..NashvilleHousing a 
join PortFolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is  null


-- Breaking Out Adress Into indivitual (Adress, City, State)

select PropertyAddress
from PortFolioProject..NashvilleHousing


/*   
note 
CHARINDEX wxa waaye mrkii aad rbtit inaa waxtirtit then meesha aad rbtit ilaa inaa tittit meesha aa ku sheegi laheed aa wxa la dhaha CHARINDEX. 
-1 is to remove the coma from the adress becasuse when we said CHARINDEX(',') that mean it includes the coma.

the syntax is 
SUBSTRING(expression, start_position, length)

expression: PropertyAddress
start_position: 1 (start from the first character)
length: CHARINDEX(',', PropertyAddress) (stop before the comma position)
*/

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress ) -1) as Adress,

SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress ) +1, LEN(PropertyAddress)) as Adress

from PortFolioProject..NashvilleHousing


ALTER TABLE NashvilleHousing
add PropertySplitAddress nvarchar(255); 

Update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress ) -1)


ALTER TABLE NashvilleHousing
add PropertySplitCity nvarchar(255); 

Update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress ) +1, LEN(PropertyAddress))



select OwnerAddress
from PortFolioProject..NashvilleHousing

-- this is an easy way to spilit inside the column rather than substring

select 
PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 1)
from PortFolioProject..NashvilleHousing
where OwnerAddress is not null

ALTER TABLE NashvilleHousing
add OwnerSplitAddress nvarchar(255); 

Update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 3)

ALTER TABLE NashvilleHousing
add OwnerSplitCity nvarchar(255); 

Update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 2)

ALTER TABLE NashvilleHousing
add OwnerSplitState nvarchar(255); 

Update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.' ), 1)


select *
from PortFolioProject..NashvilleHousing



-- change Y and N to yes in ''solid as vacant' field


select	Distinct(SoldAsVacant), count(SoldAsVacant)
from PortFolioProject..NashvilleHousing
group by SoldAsVacant
order by 2




select SoldAsVacant,
case 
	when SoldAsVacant = 'y' then 'Yes'
	when SoldAsVacant = 'n' then 'No'
	else SoldAsVacant
end
from PortFolioProject..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = case 
	when SoldAsVacant = 'y' then 'Yes'
	when SoldAsVacant = 'n' then 'No'
	else SoldAsVacant
end




-- REMOVING DUPLICATE

with RowNumCTE AS (

select *,
	ROW_NUMBER() over (
	partition by ParcelID,
				 PropertyAddress,
				 SaleDate,
				 SalePrice,
				 LegalReference
				 order by 
				 UniqueID
				 ) row_num

from PortFolioProject..NashvilleHousing
--order by ParcelID
)
--DELETE -- this deletes the duplicate when you used it insteed of select*
select *
from RowNumCTE
where row_num > 1
order by PropertyAddress


-- Deleting unused coloumn


select *
from PortFolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, SaleDate

ALTER TABLE NashvilleHousing
DROP COLUMN TaxDistrict, OwnerAddress


