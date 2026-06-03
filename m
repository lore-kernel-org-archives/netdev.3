Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FA47F2E6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491742; cv=none; b=XQbBaRJ83I5ojqLxuZ8tDdrk66m/Q7j7Q35LeFcALFTAJ55TgxFqXuLFndkQW8zksxgwhn5+dIjI/32pRmkqObx9NBTz73XQ5qhbLxVoAtJLbFRBhuTVl1KMCryX3AIpQv9Pvi9B2OcY2YylV1yxNijw8jwPTqYnZj/GIfVdYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491742; c=relaxed/simple;
	bh=bxo9SHrUXJGyZkFMOpAmRk2SB3YPqnmSBwAGKofz5+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBh2QR9XpKr3jhgoDJ4cYl3PIJusJaBuO3n/7Nqen/gh4QUKfT0iB6tDFAvfGAGv5aUB0FL/YeMUTdovW9IfcOsPXjfNbcSZRdGMi5vYDxHVkSOQZqSRcgNfaILzNCx7gowvdxD0EaVV0i+ouRbLCH8aogDCu+BrtCrtz+qP3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FGJZjsOe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FGJZjsOe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h3aEZcwJGvorZvWFjRBgAcDT0jUMCioc99jyI5R2qXY=; b=FGJZjsOe9LpQgMTvk+L4K5gfPG
	KFWHQYsgy92q8YFIJZI5z/75F3+sRxwyUDgAeVf05WuwKSlGgsRAfCaSGNLzWntftaLvPD+KkAR/N
	VCYDs0cN+GC4NP8d1+/ec0TtcDwNdZ9oFrbDDNmlwPSxck2+oQPJLjyq0KsXIcQHupRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUlEf-005sav-TK; Wed, 03 Jun 2026 15:02:17 +0200
Date: Wed, 3 Jun 2026 15:02:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH net] net: ena: PHC: Add missing barriers
Message-ID: <3e241945-b0b4-4426-9863-02c25e6d6ac4@lunn.ch>
References: <20260603065532.13260-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603065532.13260-1-akiyano@amazon.com>

On Wed, Jun 03, 2026 at 06:55:30AM +0000, Arthur Kiyanovski wrote:
> Add dma_rmb() barriers after both req_id completion checks in
> ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> payload fields may be read before req_id is observed as updated.
> 
> Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 43 +++++++++++++++--------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 8c86789d867a..79cfcd87d4bf 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -1822,23 +1822,31 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
>  				   "PHC get time request 0x%x failed (device error)\n",
>  				   phc->req_id);
>  			phc->stats.phc_err_dv++;
> -		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
> -			/* Device updated req_id during blocking time but got
> -			 * a PHC error, this occurs if device:
> -			 * - exceeded the get time request limit
> -			 * - received an invalid timestamp
> -			 */
> -			netdev_err(ena_dev->net_device,
> -				   "PHC get time request 0x%x failed (error 0x%x)\n",
> -				   phc->req_id,
> -				   resp->error_flags);
> -			phc->stats.phc_err_ts += !!(resp->error_flags &
> -				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
>  		} else {
> -			/* Device updated req_id during blocking time
> -			 * with valid timestamp
> +			/* Ensure PHC payload is read after req_id update
> +			 * is observed
>  			 */
> -			phc->stats.phc_exp++;
> +			dma_rmb();
> +
> +			if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
> +				/* Device updated req_id during blocking
> +				 * time but got a PHC error, this occurs
> +				 * if device:
> +				 * - exceeded the get time request limit
> +				 * - received an invalid timestamp
> +				 */
> +				netdev_err(ena_dev->net_device,
> +					   "PHC get time request 0x%x failed (error 0x%x)\n",
> +					   phc->req_id,
> +					   resp->error_flags);
> +				phc->stats.phc_err_ts += !!(resp->error_flags &
> +					ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
> +			} else {
> +				/* Device updated req_id during blocking
> +				 * time with valid timestamp
> +				 */
> +				phc->stats.phc_exp++;
> +			}

This is a rather big hunk just to add a dma_rmb(). Please could you
try to minimise the patch.

    Andrew
