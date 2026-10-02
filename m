Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EED2BDC13;
	Fri,  2 Oct 2026 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903695; cv=none; b=mTGj3PV0dSNmc6a5nO7o2NHg2WUjBTrBOuWEj0Ku1I8LMCSTc+v0ctQKUluC36BR4+HtDpmLFJ0hVh7e7mb0zdBs0gx7P5/9EQ73q/8cTUSpKsHqS/eg2IavtjaYQ+6WpZ1cd5bFFyzv/TQNdy+dz0azBsV+qwDhRnIcKMhgGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903695; c=relaxed/simple;
	bh=kJeiPXEqqe2jBfpzVOQzJubu7bI6/1LxnAK03RogTOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuXyOhcdBo5chwzjhmaIsYqxVzsHJGi/5h0/VbFp4fMaTLkf/AOFc/pjeahe8SSqXSbfK5HrmbVKwVlPqfhOJaTr/16PNxPM30KMI4fIWy+0VVO1K8Jp/7z1mgUDHM3RjzJpjQgVcvFCfCjA5Gye7L1hSUVKz4YSEIbvua6PcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZLNUkVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZLNUkVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57B51F000FF;
	Fri,  2 Oct 2026 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790903694;
	bh=pN48guGyVZCLfN0dodsjvJRJb4LaHXzMzQ3TOQGn714=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mZLNUkVp2txF5p0tmVd1lXbE8VNf8RYs+aHb7FLAwBH0qzQtcskLyE6+qgc2csVhT
	 poW7isplHSQEc1C6KKT7iR7U+orxq2yEOFt+P4uzIallZQ1+veRqZ0gftgU8HioFyP
	 RqZLV5pq90rL/QsibgCTSLC8Cyz3uyApbmsglvlvvxI5Xh90rFFeFczgdkrhrUOOpk
	 LVlwLqlREGXxlxQKyB0L2BJG+08qkfkOgytrm+18vn1YnQWrbVRIRIq24TQll4oNXR
	 f0d1Vg4qyOthKABmZMCeQAadRpFlqBQfK9tYjgIVzT3Xdp1Obf5DSlizlSTSRpcDZP
	 Xx25j5MZpwSlA==
Date: Thu, 1 Oct 2026 18:14:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jianhui Xu
 <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v14 03/14] ax88179_178a: Fix endianness of
 pause watermark register
Message-ID: <20261001181453.23ffac71@kernel.org>
In-Reply-To: <20260929-ax88179a-v14-3-a1f2249e42ea@birger-koblitz.de>
References: <20260929-ax88179a-v14-0-a1f2249e42ea@birger-koblitz.de>
	<20260929-ax88179a-v14-3-a1f2249e42ea@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 05:18:51 +0200 Birger Koblitz wrote:
> The 16-bit pause watermark register is little endian as
> described in the ASIX 4.1.0 out-of-tree driver. Correct the
> register byte sequence but also swap the configuration values
> used in the code in order to keep the current behaviour.
> 
> The endianness is relevant for 16-bit writes to the register.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/usb/ax88179_178a.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 81d8412ce8e2fac981df076ea1385e6e87525cfe..2ed46ab62c0065d32040439f31d44f118d7e9952 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -32,8 +32,8 @@
>  #define AX_ACCESS_EEPROM			0x04
>  #define AX_ACCESS_EFUS				0x05
>  #define AX_RELOAD_EEPROM_EFUSE			0x06
> -#define AX_PAUSE_WATERLVL_HIGH			0x54
> -#define AX_PAUSE_WATERLVL_LOW			0x55
> +#define AX_PAUSE_WATERLVL_LOW			0x54
> +#define AX_PAUSE_WATERLVL_HIGH			0x55
>  
>  #define PHYSICAL_LINK_STATUS			0x02
>  	#define	AX_USB_SS		0x04
> @@ -1619,11 +1619,10 @@ static int ax88179_reset(struct usbnet *dev)
>  	dev->rx_urb_size = 1024 * 20;
>  
>  	*tmp = 0x34;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH, 1, 1, tmp);
>  
>  	*tmp = 0x52;
> -	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_HIGH,
> -			  1, 1, tmp);
> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
>  
>  	/* Enable checksum offload */
>  	*tmp = AX_RXCOE_IP | AX_RXCOE_TCP | AX_RXCOE_UDP |
> 

Looks like I already applied this as commit a4e22e9253e7ed ?
Please rebase on latest net-next it should drop you, and then repost
