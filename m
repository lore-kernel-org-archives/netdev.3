Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7234BA28;
	Wed, 22 Jul 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727624; cv=none; b=tMTCI5UNfbcKGN/XCrwn35Zz8DlKUSPUy8kOmWU3zvErfSxv/3gnC5oQs0fIC8Jq0zW2n3Khr041/kAeX00Phgjb4LKx8qrIkAF/AXG7sFbHuAwpQrnNjCtEBa8W5bYyjJggESUgrF6jdSZ+m+AEL7PAiUEwQtKRdMimqxqct+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727624; c=relaxed/simple;
	bh=ZQuVDc/+OBaWXo/Gi2DEdPXXuHY0SoJ+sR65W5z1oaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2PeU25wud15IhaLtZQFjTapN3tLcLk1f/QQBnbL7KRWwT/qFAKe4Liqe4M9iGbbfC8keP0KptnE5lGpv/E9kvQLIHa5FNDVs0p98gYGbc7QW1UgRkIBhjeXU9bQ2GFjIrDnZOW+3/JlRmw1hPlYGP2fbLeV5d1cWhXgVAoik1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OOO99RNA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OOO99RNA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DDF581A116B;
	Wed, 22 Jul 2026 13:40:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF3F360388;
	Wed, 22 Jul 2026 13:40:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A6DF11BD03C7;
	Wed, 22 Jul 2026 15:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784727617; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wr+ewd5waDN6ADYJpilEPIvuynye3ldhe8wIwOoFlp0=;
	b=OOO99RNAiChT0FMMosou7lSmLXLDP2UqgctMVht4RjYFcfQT7iyB40FxEX3mU5geMkypIb
	DfHxt/nFmORYZW78euYSK+LtlO7jR+8+WCMRCIQScXtCGzq8cCer3VmZlefHDrPVq2lWv3
	HbHK14gYV7Ep0bfNoyAuhcS/h5J7hkLpoWXrO7sUh+PeomdeGuVibTTtxdF2MuHWDfEsBW
	O/dxLhbSoT518ME6bO3dNotb5WdC8As/hP8tF9qL8zxysD7/ly/B2Xww4nwVrZto7Yr2bA
	xm+rp+LruZ5H1Bo65teOA3GqnS/hNg+6E4MvNDvreYCI1cLHfmH7OXuKXMDiBQ==
Message-ID: <b8f125be-e91f-4b44-8664-5746edb28f33@bootlin.com>
Date: Wed, 22 Jul 2026 15:40:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Skip PHY attach if custom PCS is in use
To: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
References: <20260722131918.685761-1-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260722131918.685761-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

+Mohd

On 7/22/26 15:19, Zxyan Zhu wrote:
> When a platform provides a custom PCS via the pcs_init callback
> (e.g., for USXGMII with in-band autoneg), the MAC's phylink_pcs
> is already configured. In this case, phylink validates against
> the PCS's supported interfaces and manages link state through
> the PCS, so no traditional PHY device is needed.
> 
> Without this, stmmac_init_phy() falls through to the
> no-phy-node path and errors out with "no phy found" when
> the DT has no phy-handle for such interfaces.
> 
> Skip the PHY attach when priv->hw->phylink_pcs is already set
> and no phy-handle is specified in the device tree, allowing
> platform PCS implementations to handle the link autonomously.

Hmpf this bug again...

There have been multiple attempts at solving this, cf this thread :

https://lore.kernel.org/netdev/E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk/

Now, there wasn't any conclusion on that, but I _think_ the proper
solution is to re-apply Russell's original patch (the one in the link above)
and to add this current patch on top of it.

Russell states that this may (will ?) break qcom-ethqos, but OTOH
we're in need for a solution here, and with the pace of PCS-related
work that impacts stmmac, there's going to be a point where we may
need to think about compatibility.

TBF I don't understand the qcom-ethqos issue, maybe Mohd can help
with testing here ?

Maxime

