Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA333DEE6;
	Wed, 29 Jul 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345768; cv=none; b=R4gAgqS9Gp1tMxqZHrJ/3dx5j8fxPqBIdAdCAb5PM/SQ+g3fuxQMNuRPAPAmICjIazTwI1GJbI6QXuK4kcRHbzgZCVNtsp36blIkcM0OnJ5CZKCCFndggeUL2/idVIv7fAmMo5Rg1H3kMYt9cwKlVTngeQmiehr4PlZA3nsv9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345768; c=relaxed/simple;
	bh=rKwwbbeUhYJYWtqvfZI94lJBYyOS0Gf7tjoXONG1z2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcvLRWRRyEcHYX8iJHNif1H8D1B8lGvqubiMx6Kw0Wc7oDbMs4qfgloF0jaxeZg6Pvj2cXpVLsfMiX30petv3dPZtaRpmWrPfBwfw8ITl60CBSBWo2sv3TmU2XDRq/9Sl9Ih5wJtNZG+MGbxhO7iTER4+mtOMYxt1HFjXb9jRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UQH+2+fT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UQH+2+fT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9fPk+ekSPojXSzMMxvbRxnaMQS/1Or1+tzZjym+mrQw=; b=UQH+2+fTr5y9NBm9iSO5MY0U/w
	E8pRe0E5DDnZYLukXtgCxqahz7f7Qiiamox/jsDS1kgrMmz7FiqP4okR+UAu5pelwx64FdOfgYfm1
	5+/Qz1LBuYYDHI/WzjaGPfqlejK8KkkN8SjWa2Ne1SonTzHN/3ZkSQhJx1L6F+tL4Nug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp7zK-00EqxX-Fv; Wed, 29 Jul 2026 19:22:38 +0200
Date: Wed, 29 Jul 2026 19:22:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 3/4] net: dsa: Add support for SoC-e SDSA tags
Message-ID: <df7e7e04-80fc-4b80-9afd-0e9bc14a759f@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-3-be569dae1b20@linutronix.de>

> @@ -98,6 +98,12 @@ config NET_DSA_TAG_EDSA
>  	  Say Y or M if you want to enable support for tagging frames for the
>  	  Marvell switches which use EtherType DSA headers.
>  
> +config NET_DSA_TAG_SDSA
> +	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  SoC-e switches.
> +

These entries are sorted, so it probably should be between
NET_DSA_TAG_RZN1_A5PSW and NET_DSA_TAG_LAN9303.

> @@ -23,6 +23,7 @@ dsa_core-y += \
>  obj-$(CONFIG_NET_DSA_TAG_AR9331) += tag_ar9331.o
>  obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
>  obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
> +obj-$(CONFIG_NET_DSA_TAG_SDSA) += tag_sdsa.o
>  obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o

Also sorted, and this is the wrong spot.

> +#define SDSA_HLEN	8
> +
> +#define SDSA_NAME	"sdsa"

Does SDSA mean anything? Or have you taken net/dsa/tag_dsa.c, and just
changed edsa to sdsa?

> +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	u8 *sdsa_header;
> +
> +	if (skb_cow_head(skb, SDSA_HLEN) < 0)
> +		return NULL;
> +
> +	skb_push(skb, SDSA_HLEN);
> +	dsa_alloc_etype_header(skb, SDSA_HLEN);
> +
> +	/* Construct the FROM_CPU DSA tag. */

Is FROM_CPU a concept for this device? Are there other types of tag?

> +	sdsa_header = dsa_etype_header_pos_tx(skb);
> +	sdsa_header[0] = (ETH_P_SDSA >> 8) & 0xff;
> +	sdsa_header[1] = ETH_P_SDSA & 0xff;
> +	sdsa_header[2] = 0x00; /* reserved */
> +	sdsa_header[3] = 0x00; /* reserved */
> +	sdsa_header[4] = FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, 1) |
> +			 FIELD_PREP(SDSA_TAG_PORT_HI_MASK, dp->index >> 5);
> +	sdsa_header[5] = FIELD_PREP(SDSA_TAG_PORT_MASK, dp->index);
> +	sdsa_header[6] = 0x00; /* VLAN not supported */
> +	sdsa_header[7] = 0x00; /* VLAN not supported */
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	u8 *sdsa_header;
> +	int source_port;
> +	u8 frame_type;
> +
> +	if (unlikely(!pskb_may_pull(skb, SDSA_HLEN)))
> +		return NULL;
> +
> +	sdsa_header = dsa_etype_header_pos_rx(skb);
> +
> +	/* Check that the frame type is TO_CPU. */
> +	frame_type = FIELD_GET(SDSA_TAG_FRAME_TYPE_MASK, sdsa_header[4]);
> +	if (frame_type != 0)

#define for TO_CPU?

	Andrew
