Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261F3F23D7;
	Thu,  4 Jun 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563434; cv=none; b=K2+kfVS2LWM0ejtvwVFfeacs1Zgie+IvD4fc5FEahqAWpJFHVq8fWNrDp6kC2mAjHR1SuCfjtB8H17XN/B6A1/mOZwn6WB09ruQ4PpQCZBtoCQiDxxBWUqxGPMz/CjV2tmEOQeo3R1Zq8Ir86YSY8PkU2r5d+kwyD9nr+kRQ+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563434; c=relaxed/simple;
	bh=cujquTacYS0SyI/O00lZ117HDJtHKItexeInz5hUx+8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eDESNaCkz8ZajVWOD8o2QPCkrvkLdkrtcz0dmYp+RvvL45Il1UC1UuEdcJ+tF5qmCcKlXv0iX5RDiPKKmo9IXxNUrJVRxDgI26QFY1m9XfDQXBIQ7XONUYRTLP7d6s/ISyFq5jHg02vMvUxyytnEkUCq4BSVzv+AoyyRjg1GIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XNTfI1hb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XNTfI1hb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EDAAA4BA0;
	Thu,  4 Jun 2026 10:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780563430; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lTuCvk0QyaGOhkLATuC+pQdtUcUwnJUH6ax50eJJVXg=;
	b=XNTfI1hb7nPiWWBh5K6F45NKgd530joprylAeTNLo8of2KV8psUcTPJ6/0Dsd9Zsy8MPOt
	N7d9fwcyBnu0BZSQIjf/juGT4AGvDvfzLs8xT1erEKKvUk0sMR8Y3+qVpAdzlgt7JX5lkr
	pe1Z3uoVe+SzY9780uXODEJid5+Ip1UsF2E81C6h/uz1Vo9ClaCkpXa/3Hz2cpXZNhl27d
	zSDUScsyobGur6ahuoBIQZXPtsZW1IWtcnYYu9aVdE0PNx3PFgDa0aN6lL3r88IjE+1Cbj
	vrhdWDuuvwMT1wkR0/hqRA6fP0RDAip/mxxBCxw0WPoOCULBfRDv3fUTCoH9oA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:57:09 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 3/4] net: phy: realtek: add support for
 RTL8261C_CG
In-Reply-To: <20260604074209.93-4-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-4-javen_xu@realsil.com.cn>
Message-ID: <94d987457c307b11316cdd49ede213b0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove RTL8261D, only support RTL8261C_CG
>  - remove speed 500, rarely used
>  - add helper function, genphy_c45_soft_reset() and 
> genphy_c45_config_master_slave()
> ---
>  drivers/net/phy/realtek/realtek_main.c | 178 +++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c

> [...]

> +
> +#define RTL8261C_CE_MODEL		0x00
> +#define RTL8261X_GBCR_REG		0xa412

IMHO this is just RTL822X_VND2_C22_REG(MII_CTRL1000) (= 0xa412), already
used elsewhere in the file. Drop the define and reuse the macro, as
Aleksander suggested on v1.

> [...]

> +struct rtl8261x_priv {
> +	u8 sub_phy_id;
> +};

sub_phy_id is only written, never read. Andrew already asked about the
unused priv fields on v1. A local in probe() is enough, drop the field?

> [...]

> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			      phydev->advertising))
> +		adv_1g = ADVERTISE_1000FULL;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
> +				     RTL8261X_GBCR_REG,
> +				     ADVERTISE_1000FULL, adv_1g);

See above and replace with RTL822X_VND2_C22_REG(MII_CTRL1000).

The aneg-restart handling looks correct now, thanks for picking up the 
v1
comment.

> [...]

Thanks,
Nicolai
