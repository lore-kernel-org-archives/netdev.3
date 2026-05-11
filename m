Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368D4D8D81;
	Mon, 11 May 2026 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527090; cv=none; b=ISdxI1uuNg414H/ORrC/MaoAY65s0cy8AyPThYFLMznRF2CSOGMw5v8TFeKCe3oa05luMbzJai3BcbzLpad417+Kr9Wc7To3DSyZzwFPB8juYcK8v5SSA9G253eepQpYw/xSE1E4rsnSgntaqmW/kzjFws9/eS2oFfrkKgWH0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527090; c=relaxed/simple;
	bh=JRV6r7xS/dNctECUIlJuh5zg8xY/1Yt0t6jSeBsZn4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKviGEkUcYsIt+HAdjrLm8j3WiEih9UbfI71W3c1Qw0eFVP0YSpvaqWJJAAS6vWtiy3xc9m88SizGuX4Ihx5eJeb3xtF8riwhU8whYHa3qztlx/bsZIfkGAWfnnRkP2al7xW8SMyx2elHiV/rch+HtIuWVcN728qKTzMltAA9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aDoFJWDw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aDoFJWDw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eNe1epfriBR2JOEYrHdS/ZnZjoGzOogHWVsDHH2toTs=; b=aDoFJWDwt7EasLl7Yzinghrc4Y
	AxQN8RchKgN8fr2wC1eclLn9rE1X6hAtKHfVYImr114JCHFbQ1CaLmh5h/bWXkJqWt3UN3cSX+10G
	QOvq4Zd0FX2XUidlE/yw+WdKx6SgLsZ14pVHusAuVfMYK98JCYA0CgfKtOHaGBJcK0ew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMW8c-002Qd9-5Z; Mon, 11 May 2026 21:17:58 +0200
Date: Mon, 11 May 2026 21:17:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/9] net: phy: ncn26000:
 bugfixes/improvements to NCN26000 PHY driver
Message-ID: <73bcf5d3-c77e-432e-802c-f867d7fef8e8@lunn.ch>
References: <CY8PR02MB9249D9892B00F7B7C10EEF0883382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249D9892B00F7B7C10EEF0883382@CY8PR02MB9249.namprd02.prod.outlook.com>

On Mon, May 11, 2026 at 06:19:04PM +0000, Selvamani Rajagopal wrote:
> Proprietary, noise immunity bit is set when PLCA is enabled
> Link status bit was wrong. Fixed now
> MAINTAINER's new email ID updated

Please don't mix multiple things in one patch.

> @@ -108,7 +130,7 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
>  	ret = phy_read(phydev, NCN26000_REG_IRQ_STATUS);
>  
>  	// check only link status changes
> -	if (ret < 0 || (ret & NCN26000_REG_IRQ_STATUS) == 0)
> +	if (ret < 0 || (ret & NCN26000_IRQ_LINKST_BIT) == 0)

If this is a fix, please base it on net, and add a Fixes: tag.

    Andrew

---
pw-bot: cr
