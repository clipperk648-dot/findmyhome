import React from 'react'
import {
  Card,
  CardContent,
  CardMedia,
  Typography,
  Box,
  IconButton,
  Chip,
  Stack,
} from '@mui/material'
import {
  Favorite,
  FavoriteBorder,
  Share,
  LocationOn,
  Bed,
  Bathtub,
  SquareFoot,
} from '@mui/icons-material'

interface Property {
  id: string | number
  title: string
  price: string
  location: string
  bedrooms: number
  bathrooms: number
  area: number
  status: string
  isFavorite: boolean
  images: string[]
  propertyType: string
}

interface PropertyCardProps {
  property: Property
  onTap?: () => void
  onFavorite?: () => void
  onShare?: () => void
}

const PropertyCard: React.FC<PropertyCardProps> = ({
  property,
  onTap,
  onFavorite,
  onShare,
}) => {
  const imageUrl = property.images && property.images.length > 0
    ? property.images[0]
    : "https://images.unsplash.com/photo-1560518883-ce09059eeffa?auto=format&fit=crop&w=1200&q=80"

  return (
    <Card
      sx={{
        mx: 2,
        my: 1.5,
        borderRadius: 3,
        boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
        cursor: 'pointer',
        transition: 'transform 0.2s',
        '&:hover': {
          transform: 'translateY(-2px)',
        },
      }}
      onClick={onTap}
    >
      {/* Image Section */}
      <Box sx={{ position: 'relative' }}>
        <CardMedia
          component="img"
          height="200"
          image={imageUrl}
          alt={property.title}
          loading="lazy"
          referrerPolicy="no-referrer"
          onError={(e: any) => { e.currentTarget.src = "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80"; }}
          sx={{ borderRadius: '12px 12px 0 0' }}
        />
        
        {/* Favorite Button */}
        <IconButton
          sx={{
            position: 'absolute',
            top: 12,
            right: 12,
            backgroundColor: 'rgba(255, 255, 255, 0.9)',
            '&:hover': {
              backgroundColor: 'rgba(255, 255, 255, 1)',
            },
          }}
          onClick={(e) => {
            e.stopPropagation()
            onFavorite?.()
          }}
        >
          {property.isFavorite ? (
            <Favorite sx={{ color: 'red' }} />
          ) : (
            <FavoriteBorder />
          )}
        </IconButton>

        {/* Status Badge */}
        <Chip
          label={property.status}
          size="small"
          sx={{
            position: 'absolute',
            top: 12,
            left: 12,
            backgroundColor: 'primary.main',
            color: 'white',
            fontWeight: 600,
            fontSize: '12px',
          }}
        />
      </Box>

      {/* Content Section */}
      <CardContent sx={{ p: 2 }}>
        {/* Price and Share */}
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 1 }}>
          <Typography
            variant="h6"
            sx={{
              color: 'primary.main',
              fontWeight: 700,
              fontSize: '18px',
            }}
          >
            {property.price}
          </Typography>
          <IconButton
            size="small"
            sx={{
              border: '1px solid rgba(0,0,0,0.12)',
              borderRadius: 1,
              p: 0.5,
            }}
            onClick={(e) => {
              e.stopPropagation()
              onShare?.()
            }}
          >
            <Share sx={{ fontSize: 16 }} />
          </IconButton>
        </Box>

        {/* Title */}
        <Typography
          variant="subtitle1"
          sx={{
            fontWeight: 600,
            mb: 0.5,
            display: '-webkit-box',
            WebkitLineClamp: 2,
            WebkitBoxOrient: 'vertical',
            overflow: 'hidden',
          }}
        >
          {property.title}
        </Typography>

        {/* Location */}
        <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
          <LocationOn sx={{ fontSize: 16, color: 'text.secondary', mr: 0.5 }} />
          <Typography
            variant="body2"
            color="text.secondary"
            sx={{
              overflow: 'hidden',
              textOverflow: 'ellipsis',
              whiteSpace: 'nowrap',
            }}
          >
            {property.location}
          </Typography>
        </Box>

        {/* Feature Chips */}
        <Stack direction="row" spacing={1}>
          <Chip
            icon={<Bed sx={{ fontSize: 14 }} />}
            label={`${property.bedrooms} Beds`}
            size="small"
            variant="outlined"
            sx={{
              borderColor: 'rgba(0,0,0,0.12)',
              '& .MuiChip-label': { fontSize: '11px' },
              '& .MuiChip-icon': { color: 'text.secondary' },
            }}
          />
          <Chip
            icon={<Bathtub sx={{ fontSize: 14 }} />}
            label={`${property.bathrooms} Baths`}
            size="small"
            variant="outlined"
            sx={{
              borderColor: 'rgba(0,0,0,0.12)',
              '& .MuiChip-label': { fontSize: '11px' },
              '& .MuiChip-icon': { color: 'text.secondary' },
            }}
          />
          <Chip
            icon={<SquareFoot sx={{ fontSize: 14 }} />}
            label={`${property.area} sqft`}
            size="small"
            variant="outlined"
            sx={{
              borderColor: 'rgba(0,0,0,0.12)',
              '& .MuiChip-label': { fontSize: '11px' },
              '& .MuiChip-icon': { color: 'text.secondary' },
            }}
          />
        </Stack>
      </CardContent>
    </Card>
  )
}

export default PropertyCard
