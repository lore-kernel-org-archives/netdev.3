Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C55221FE;
	Mon,  7 Sep 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788805064; cv=none; b=kxqzOgTRsaoHBHjuc/lSlXIMr3PrPNKiWsCkm6wT5E77aGjThx0fuj8E6S318NA6Yd+Sg+lYA+8iXsxHZGxl2ve3EZYzCPWknSoEGVdL/G8HM9YLbgMm7S58f3T3rQ1ERShUT11UiZcHvFWYvVLUh+kjhmfGWIreawwqZlyLATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788805064; c=relaxed/simple;
	bh=IWOMb7hwqMsfDpwsNERDjpOyzOO+yk3WzBm0jST49Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSkUcs3CTQuF8xrCaegcOJ4dHZ4xzSOS+YNQ/PI1ZSOjjp880uSkeAwGe82EwQrI/HriRQw4ZIavPJPk/R5HbR0d++5XoEivpGHuQZQuBsOOu6/OFlPpP6MGBxeUaErQl14ENPZtPZ7DPmp2ZLK+dsHzyaGyaQQpXwDAmLkpOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m5sR9Aq5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m5sR9Aq5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ArBAXM44Bbh18dFjDRQ+FQUmtL3Zx68izL7mK9iVvSo=; b=m5sR9Aq5fc7SFalKTduERx8gxc
	JZBRoMEOedQpLqIhepSbzOHT0/OZmhLd9U/VGaOitPrH99OufH2u0/bdxTFQUHY4lDdvMHllVeHNB
	XpFGxcj6QdCZTmvlPX+U2JkYTfI7mFskMp71SBelPHwOvrSzYEAc0ZQteMnuIsTIq598=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3duF-003alA-Rx; Mon, 07 Sep 2026 20:17:23 +0200
Date: Mon, 7 Sep 2026 20:17:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oliver Neukum <oliver@neukum.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Subject: Re: [PATCH 1/2] net: usb: cdc_ether: add NCSI passthrough support
Message-ID: <08083379-6eb9-441e-a656-0066c9006dd7@lunn.ch>
References: <20260907-ncsi-over-usb-v1-0-6b74d2f1196c@gmail.com>
 <20260907-ncsi-over-usb-v1-1-6b74d2f1196c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-ncsi-over-usb-v1-1-6b74d2f1196c@gmail.com>

> +/* NCSI operates at 100 Mbps */
> +#define NCSI_SPEED_BPS		(100 * 1000000)

Why 100Mbps? RGMII is often used, running at 1G.

> +struct cdc_ncsi_priv {
> +	struct ncsi_dev *ndev;
> +	struct net_device_ops netdev_ops;
> +	const struct net_device_ops *orig_netdev_ops;
> +};
> +
> +static int cdc_ncsi_open(struct net_device *net);
> +static int cdc_ncsi_stop(struct net_device *net);

No forward declarations. Move the code around so they are not needed.

   Andrew
