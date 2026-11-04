Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825807;
	b=SioBlFHzvXucKZSuWvptJk/F/huszxx5gipT6brTIDxNFKwh4CmZFoi6cEdxS4l2kna4
	 Teo13bDzNT5IJuIZgQgHUJ2ePOZOyZtxXbDfcnekwpGSaqa4JmtagxxAsMN2Vpq3B2Ojd
	 P0O60+StDn/HCdo587J1FO+/zMboYfLiHDc0q/Le1lRIn7lhgykLbWY0LeqLluesEJAEV
	 JKiSlHSsL/PNn8eYOkeq7AUcCaTK9Qvojwn3mP62NpiT2zn8xNAKruym0HYO5De/4l1we
	 gfmVWCD4o/62zY9DFlRLkGf+mzu/jUqyKm/kL17iqiSSIF45YpB7SGpQGCpoS+w1/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825807;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=aT59RqPPXneyKB2jjsHTsRzCsHVLOHKqmGVlxOGkRWE=;
	b=ZRarBe15qaxy7RvumXLcASitYF1yRD1vAVq3KnidwhOfj0Q6aJBylgzkXHa5K83iP/hE
	 MBhRQuXD40BY41MtHlOFAxlctfH4roBzdQqZm85HKZBo/EwtAFFfBIaCoe9ME/CvXAQUb
	 9OXjjug8dEtrIjg/PcqglVXEcGHOuwn3DmIgb6zBRgVMaxnuJQdpEzprp8Sb2DfhQ9nDc
	 2IZvMdEfmP/nTsG0saaoC9D/gO+ETKLGikWkNNm0mclb/gKPNYEAq7ySE6jFtMWg3IXVG
	 C5rYEKdt/tjDSGnYcfEFl5PBWsuwgCZNvc0XK4tJUkbRIoe5gl3FjZIncgwqiE8jsXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MlPK7uAH;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C2609C59C;
	Wed,  4 Nov 2026 20:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09C2609C59C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=MlPK7uAH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aT59RqPPXneyKB2jjsHTsRzCsHVLOHKqmGVlxOGkRWE=; b=MlPK7uAH3bIp0l9Xu0yU0NYT/x
	JW3zlB0+WS2+jqhjyGFLH0zUYcXlHjqmU+ZVguAL2jrva2MyhUIO5tTxIwSytiP/ZtWOqlwJ4N7NX
	VzyNyd3Uw9an5w5GyS3pcHXrxerr3zrO1t4+ETPSY5KG25ZjBWbFIEmJbxCH3GY6XrB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOi28-00ENzC-Mu; Wed, 04 Nov 2026 21:56:36 +0100
Date: Wed, 4 Nov 2026 21:56:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next v5] net: phy: aquantia: Add support for 5GbaseR
Message-ID: <b14d40a3-0a57-4e0c-9cd5-2ac15d6e1b5c@lunn.ch>
References: <20261104-aquantia-support-5gbaser-v5-1-9adc0f538d66@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-aquantia-support-5gbaser-v5-1-9adc0f538d66@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 05:57:52PM +0800, Hongmei Xu wrote:
> Aquantia PHYs can operate with a 5G USX interface between the PHY
> and MAC, reported as interface type 12 in the PHYXS vendor interface
> status register (MDIO_PHYXS_VEND_IF_STATUS_TYPE_USX_5G).
> 
> Without this change, aqr_gen1_read_status() falls through to the
> default case and sets phydev->link = false when the interface type
> is USX 5G, preventing 5G links from coming up.
> 
> Add the missing PHY_INTERFACE_MODE_5GBASER handling in three places:
> 
> - aqr_gen1_read_status(): map USX 5G interface type to
>   PHY_INTERFACE_MODE_5GBASER so the link is correctly reported
> - aqr_gen1_config_init(): accept PHY_INTERFACE_MODE_5GBASER as a
>   valid interface mode, otherwise the PHY is rejected with -ENODEV
> - aqr_gen2_get_rate_matching(): return RATE_MATCH_PAUSE for
>   PHY_INTERFACE_MODE_5GBASER, consistent with 10GBASER and 2500BASEX,
>   since the MAC-side interface runs at a fixed rate and the PHY handles
>   rate adaptation via pause frames
> 
> Co-developed-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
> Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
