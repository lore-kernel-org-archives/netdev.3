Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA709239567;
	Mon, 27 Jul 2026 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134973; cv=none; b=Mwr/fKWaSCYiTj5Qjpa4sMb9Hb2ODd55GYwCtT2DrwmUEJil2ha3HOIaN8CmIBRBIQwJWLDLBXkPb7kbakE+K0zD0G9nNb+SCRkENFZPbXDYxCPLbyGEJPf2Ytd8uOA1//9HJkasCUnxKQ4Q19yCdI6NceXO2FYzKl085NF5AzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134973; c=relaxed/simple;
	bh=gJLb5pbOx70sjQqvKL+K78XbG72qx/1AjLlfUbNsINY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bymJFBXi5f7YF2Y93QVH3xfFT/tXJsKgupvl8a1du9t/se+b1bolMi0X8ehNIcN9xJzJpb0/JH2qRXwyXkNh7+VmymarRDM/nj/9GYfjlPogBsY7LDHL8ae7GtWxnLqnT8uu56e/DGVrOptyo0djWPTf6Xq6EARV3HS3AvjzbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0/6VQATy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0/6VQATy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8D20D4E40F92;
	Mon, 27 Jul 2026 06:49:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43113601BE;
	Mon, 27 Jul 2026 06:49:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC97D11C1205D;
	Mon, 27 Jul 2026 08:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785134957; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=L3skZsSAWHWds/Pvaes0a2uYpJ5JahEApGQi1xCYVmE=;
	b=0/6VQATyYeKE4urAK9n+dItmhfCVw/3COJXVsJL3ynqnTquInpzp1c37NZki8Xg5Dl9Lq7
	BzGCUA/tBnHLP+G6VJhwP0ymg+sMBH6CDo+IXjyYOVn++MYVxGO2ZvXIrcV/heWrCdk9Hr
	ufpuDArirUX0lJ0RCkymckijtF0Acc6SWx+eIqw1fTxaeKBKCKzkw+RskNCUhJckD0NHqO
	9VSlEgefgCgemycRjqZ8ZZnWeem01fa/cn/Fpi4Zbs0auY+brJceRf2lKFVvjG11k2MhBB
	gcLJ4sxlVRUboGtBMU4aaSEGO6z4HkopkxHlOg4TO5dA6m9b7Y06vC9HW7bbmA==
Message-ID: <f14a1712-8315-4e64-b23b-ac00d7f82c3a@bootlin.com>
Date: Mon, 27 Jul 2026 08:49:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Fix PHY attach when custom
 PCS is in use
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
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260726132618.3580612-1-zxyan0222@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260726132618.3580612-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/26/26 15:26, Zxyan Zhu wrote:
> This series fixes the issue where stmmac platforms using a custom PCS
> via the pcs_init callback fail to probe when no phy-handle is specified
> in the device tree.
> 
> Patch 1 is Russell King's phylink patch that relaxes phylink_expects_phy()
> to allow PHYs to be attached in 802.3z inband mode.
> 
> Patch 2 skips the PHY attach in stmmac when a custom PCS is already
> configured via priv->hw->phylink_pcs, avoiding the "no phy found" error
> for platforms that manage link state entirely through the PCS.

I've tested this series on the board that saw the regression from Russell's
first attempt, and now with the associated stmmac patch, it works :)

Thanks for that, for the series :

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
