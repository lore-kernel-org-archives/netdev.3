Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B018859B;
	Fri,  9 Oct 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791509257; cv=none; b=okO7HnYHTmigHjrYUqy7PnoinNLTjXE+hPW/Y8y4ueybnTiORFom1SKBN/omXh2k/y/f9XqG4UrUqMkYjAaHb2vemlX7uNi6gd5vFkEU3C1UdsX6Il03giWSFSZBw2Eprx5g58GIz9TMOyEDmYMOEgjnhNJn0DpmZFQlF7z5Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791509257; c=relaxed/simple;
	bh=Ti0gNoT+2F5zJ+Z0iIoiDmVEGOryiPokJE5D/Lslj+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSI80RNP1JD2ahls6VfaiigQ8PVh2q+xUMRcvpVYJjZa2l/UIaXVHuGdclvAlK1aRMm93/1lwHlqJCwVs8XF7Vi+qyreO2/ZCPxRUfWu2cCPidrF/Cew9j6lwWkOUlR+K1Hn1+ixF4xsPNRisSgdUg8+KEgVRSrxBC4Lz2bKz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2wnHQepP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2wnHQepP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dw5ebkUEZYN/o691XouQG0ZrARfZ7nxdbZY4Hy1N37s=; b=2wnHQepPcGO6w6SQ8aqQ9bGqiY
	zK4oXVjMWb9GcYDRM3uwe66TL4hJ5luErk5y7sDxi/MDH+2Lu710AWgwqNHnPUnDkrdI0655Ujxqq
	RDiAS6LJdQPYOHwRKdhJY0pi2u6VWknT3ipg7ZlGdzmQOOIM8vGG88IqUO2iLThuz/88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEzOP-009iDt-Tj; Fri, 09 Oct 2026 03:27:25 +0200
Date: Fri, 9 Oct 2026 03:27:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: netdev@vger.kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nisar Sayed <Nisar.Sayed@microchip.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: reject invalid EEPROM write
 requests
Message-ID: <cc1a471e-ba76-4fe5-a982-0cbe1775c915@lunn.ch>
References: <20261009005702.164936-1-stefanomunari.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009005702.164936-1-stefanomunari.sm@gmail.com>

On Fri, Oct 09, 2026 at 02:57:02AM +0200, Stefano Munari wrote:
> The runtime PM handling removed the -EINVAL return for invalid
> EEPROM/OTP write requests. These requests now return zero from a
> successful usb_autopm_get_interface() call, even though no data is
> written.
> 
> Set ret to -EINVAL for invalid requests while preserving the runtime
> PM reference release.
> 
> Fixes: 8a7ffeb795f8 ("lan78xx: Fix for eeprom read/write when device auto suspend")
> Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
> ---
> Tested on a Raspberry Pi 3 Model B+ with the onboard Ethernet
> controller, using raspberrypi/linux commit bba53a117a4a on the
> rpi-6.6.y branch as the baseline.
> 
>   ethtool -E eth0 magic 0 offset 0 length 1 value 0
> 
> The command succeeds without the patch and reports "Invalid argument"
> with the patch applied.
> ---
>  drivers/net/usb/lan78xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f1478..7ac263454d45 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1719,6 +1719,8 @@ static int lan78xx_ethtool_set_eeprom(struct net_device *netdev,
>  		 (ee->len == 512) &&
>  		 (data[0] == OTP_INDICATOR_1))
>  		ret = lan78xx_write_raw_otp(dev, ee->offset, ee->len, data);
> +	else
> +		ret = -EINVAL;

It might be the nested if's without {} which caused the broken patch?

Maybe add some brackets to make it clearer?

      Andrew
