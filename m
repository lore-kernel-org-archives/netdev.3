Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F443CE6B;
	Wed, 19 Aug 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131691; cv=none; b=G43/0xEJBVA2mHAJGqzzBwPbT9Fh0307YkDiehh7nKdvxa7DBYbanVRCqCSCNvgNYYv8T6clnVl9+yId5k7bAIkC6AcL353+EWBbVz3DCCD5HHWdb6eQ8VPN5Zimv6zmVLsng0jRAaM3jz37jd2e2Vaajw3GncHM86MhjdcIbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131691; c=relaxed/simple;
	bh=Kdiry360maskP1kDFZ2XR+YZxWWtUmc/HNSOHF5jRBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVOfUV66f0lALEUkWxJ7nAzZ7x/VqLLcCb80kMz+LDrsO31E1OFeeKGYS9UUC4pI3AmFYIlMcjQJ+nStlnv6SDXiHBviQxvCC9Iapz8bcEcq9DzYBIvNpxMB6JtHkH6NLCDareGLo5vdr4LP7Yd/NNntS596pxAG4TRrR6Q23Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B+qRn2Jr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B+qRn2Jr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E0D441A1730;
	Wed, 19 Aug 2026 09:28:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B24865FF42;
	Wed, 19 Aug 2026 09:28:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56EBD11C715B7;
	Wed, 19 Aug 2026 11:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787131677; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=W1qFZS1D3CTj+QPyVvNL/7z+Oy9Qe7Q4XLdaC857DYw=;
	b=B+qRn2JrZpjrTdFwNpG53nY3lEv7CGtB+6xhHYOO5wMEVtm7ft7zqG6n5Z4Z4J2DtyKUwl
	sVu6ceIwimQqDh7X4osA9oA5TCxNMiLlNrzbA9LQPxaqBkW/aQtiovN+1ipYXx1tzll7Rq
	0KnuMOeHDR+lM4DmRzPihYgBXgOc+dy+TzqLiS49VE1Pn0K48lQS0IoXSVG+RoKcQm9udt
	y8YpF4fsV8FmQKBWGgMap3HB/0pGzy9XH+ASb8qLJ03WoCvQkgsr/ac4YD99r2w0PWw3if
	Hg7IItkVa60gkUFWE/s7nDBlZbst+YIOFTfPeRbs1aY1FzNSal9xfcDvYhIS9g==
Message-ID: <9458a186-0f62-434d-9602-522500e9340c@bootlin.com>
Date: Wed, 19 Aug 2026 11:27:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 5/5] net: phy: propagate errors from default port
 setup
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 kuba@kernel.org, andrew@lunn.ch
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-6-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260819060236.24665-6-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/19/26 08:02, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_default_setup_single_port() ignores errors from phy_add_port() and
> always reports success. If a PHY driver attach_mdi_port() callback fails,
> the phy_port is leaked and PHY probing continues without the expected
> default port.
> 
> Destroy the port and return the error.
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com

Maxime

> ---
>  drivers/net/phy/phy_device.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 77318659ff985..22a5af92c620a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3458,6 +3458,7 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
>  {
>  	struct phy_port *port = phy_port_alloc();
>  	unsigned long mode;
> +	int ret;
>  
>  	if (!port)
>  		return -ENOMEM;
> @@ -3484,9 +3485,11 @@ static int phy_default_setup_single_port(struct phy_device *phydev)
>  		port->pairs = max_t(int, port->pairs,
>  				    ethtool_linkmode_n_pairs(mode));
>  
> -	phy_add_port(phydev, port);
> +	ret = phy_add_port(phydev, port);
> +	if (ret)
> +		phy_port_destroy(port);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int of_phy_ports(struct phy_device *phydev)

