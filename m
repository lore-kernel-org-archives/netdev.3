Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E393266581;
	Wed,  1 Jul 2026 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893546; cv=none; b=HWEjFEcPdSdivYOcu0hc6hrWajiSiUXx8iXec1HXAnZE+8fuuXr2qdfnJJvisrFSPO0rEwB2IaEIT20tjbuWn1ssjI5IlsgG3SvKJNLhUNDRfuS7S1Kevebh6yN5xnWw1JsAJfk+yavHtPdLMhsCHzoeG+aw7EnaMtc08FrGCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893546; c=relaxed/simple;
	bh=dnTBwMaWuMHTaR3/bJ/PyY+98lVg0sMedIPX7wWnC6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEf7RwBUg93we4MWdCWZS+DvBkgm/Ynh2VpgYfwMHRklLAQc38GCUIhC9vw95vk8NN/JkrVOtsuFA+gqknjeMg9d8QPze93JT8qG9ZQAv8tKBJt4sTatxdLu2Y7nvwxmsgGbNhvNO5yS5RnqGfGfPpoFMc7dMXyMenePzvhan+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tVsFeyyB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tVsFeyyB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o6RBggN3Hgiu6z0GFAxZZZJunuE0PHxzZTI4tyLYr88=; b=tVsFeyyBVFkimBhFb35JSufVFl
	+3YtGEG7ygHb86xkHu+wNINyhoVZa2szN7HACC3vj4bvYKWQTJ1VDTPI/Mg/U3jxLdqBKK1PpK2XA
	XuGaslu42uOzHYc0hP5EJJhIrh74NfPOhVUEF8lcN1+0PKCoj8jMq9WH26QsZuMgMEG0qh6Gt0ovq
	W6RNlvR/ch87c+ioBOUIX3tr+S7g217SK0nuoA12yC2SBe3AtaXgt+cdT8LxGNPN8hOOkAEG6aOGJ
	u0pxN5ayzPHkcLFIDVKQ289ft4o8rsQPv+pBv4y2/BwyjvCd1f2o8swA2ZMghzJtiJltaPjKLfAwF
	JkHrH5lg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weq32-007hg0-1Y;
	Wed, 01 Jul 2026 08:11:56 +0000
Date: Wed, 1 Jul 2026 01:11:51 -0700
From: Breno Leitao <leitao@debian.org>
To: xiaoning.wang@oss.nxp.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, xiaoning.wang@nxp.com
Subject: Re: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <akTLmyF0r70Jyn9m@gmail.com>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
X-Debian-User: leitao

On Wed, Jul 01, 2026 at 03:57:30PM +0800, xiaoning.wang@oss.nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> driver uses phydrv->features. Drivers that implement .get_features are
> responsible for reading the EEE abilities themselves.
> 
> yt8521_get_features() does not do this, so phydev->supported_eee stays
> empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> not supported", even though the PHY has the standard EEE capability
> registers.
> 
> Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
> to populate supported_eee.
> 
> Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/net/phy/motorcomm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index b49897500a59..46efa3406841 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -2439,6 +2439,9 @@ static int yt8521_get_features(struct phy_device *phydev)
>  		/* add fiber's features to phydev->supported */
>  		yt8521_prepare_fiber_features(phydev, phydev->supported);
>  	}
> +
> +	genphy_c45_read_eee_abilities(phydev);

Don't you want to return error if genphy_c45_read_eee_abilities() fails?
