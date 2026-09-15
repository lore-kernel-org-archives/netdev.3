Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4F38D404;
	Tue, 15 Sep 2026 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436902; cv=none; b=mqXPUKXiXSkBNL2fZjAGvSRxMMcEgJMYbZ0NlltIbGYpkcCwSsY6OAPkwYkdMVkxdWNajqktxCLo9apYOrOTShziv6CtkjEzIganp2cri5bCqoxKV/lPBYGxVwvxxL7/Hk+8KD41TC1HzEEhG7S9ch/4Smwp3jYXJBCHR7l/B28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436902; c=relaxed/simple;
	bh=hUIfNnou6ovFMDLs5yxlmM6lO/lTTNtR0RNXvTC1+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGTWQqTS4Oluw4yBwzr+RRI39avQQRtl0QM6yXHPh2SwAXuxowZ8tb3mfyI5X2OnufX9oFqcqekfxAa2iPNL/gDbAcs4LoC+sLKeSPGCADAW0Wo5WzQz9uNgDoPjfVQGkVoN+Ldlr8bxhon8lRWKy4SWFTyI17+mhJ2owyEzNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R4AktlDL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4AktlDL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C2ySufB8qIgdFzFi9UXQjn6aj3wZMisMNSVvEPIZl4Y=; b=R4AktlDLsKmuMDDJ06eEePYthH
	gV4WWWPMyBUj1MS+xpS6pMCPl5kR6hVF35757qNAqQ9B8b5yMwgTkBX2lujIHsrL8YnmK10nHlzzp
	7SVlCMFFC0gKR9wYztA8IDCicj/n3jWoDxYmT5Ag0uzF0NKdgbVL8cYvC4Kuc2Zj3lSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6IHL-005ANR-3f; Tue, 15 Sep 2026 03:48:11 +0200
Date: Tue, 15 Sep 2026 03:48:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v17 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <03664dd8-8f95-4ee3-8237-3c64febd90c3@lunn.ch>
References: <20260912065224.2723883-1-kyle.switch@motor-comm.com>
 <20260912065224.2723883-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912065224.2723883-3-kyle.switch@motor-comm.com>

> +struct yt8824_shared_priv {
> +	unsigned int interface_mode;

phy_interface_t

> +	if (!of_property_read_string(np, "phy-mode",
> +				     &interface_mode_name)) {
> +		if (!strcasecmp(interface_mode_name,
> +				phy_modes(PHY_INTERFACE_MODE_USXGMII))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_USXGMII;
> +		} else if (!strcasecmp
> +				(interface_mode_name,
> +				 phy_modes(PHY_INTERFACE_MODE_INTERNAL))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +	} else {
> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n",
> +			    __func__);
> +	}

Please don't reinvent the wheel. Look around to find an existing
wheel.

> +/**
> + * genphy_c45_template_testmode - configure template testmode registers
> + * @phydev: target phy_device struct
> + * @test_mode: testmode includes Normal to Test mode 7
> + *
> + * Description: Set template testmode include Normal to Test mode 7
> + *
> + * Return: 0 on success, or a negative error code on failure (e.g. register
> + *	read/write error).
> + */
> +int genphy_c45_template_testmode(struct phy_device *phydev, int test_mode)
> +{
> +	int ctrl = 0;
> +
> +	switch (test_mode) {
> +	case 0:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_NORMAL;
> +		break;
> +
> +	case 1:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_1;
> +		break;
> +
> +	case 2:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_2;
> +		break;
> +
> +	case 3:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_3;
> +		break;
> +
> +	case 4:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_4;
> +		break;
> +
> +	case 5:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_5;
> +		break;
> +
> +	case 6:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_6;
> +		break;
> +
> +	case 7:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_7;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBT_TESTMODE,
> +			      MDIO_PMA_10GBT_TESTMODE_MASK, ctrl);
> +}
> +EXPORT_SYMBOL_GPL(genphy_c45_template_testmode);

It would be normal to put this in a patch of its own. We just need to
see a user of it within the same patchset.


    Andrew

---
pw-bot: cr
