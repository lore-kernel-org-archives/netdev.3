Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858E38AC88;
	Fri, 24 Jul 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921925; cv=none; b=IsqsxpXcWdmBKF3S1KsGDCAWsbVfUjtixnban9iz6NXI5itK1czz2l5evo8YgWQzLNUjU0pGB+wos8kkWpLWk+BzV85kD3fJd1aBOSfYh4/JhgUAo9GGyezY4A/HZUZMnc/wVUPFNvZ07A01UYlAmUyPzBpWG1llgv5SeDNbaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921925; c=relaxed/simple;
	bh=IK/gubsrkTl9f26OmUApjm8X3dZtSFv74y9wmmU5LJY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=l9ga0EmaHDl/HuIccbh0SUQYObkPTAG7qN318DHkRFCrPHTi3+Xaj5jsDha5IC9O7f9gXYNcbB7tVPJs4KtI3Bc5JEw2AvoLiUSE/xOV+etp1ji1dij5BxzzzLrRhMdHu7Pj+IdnYuL/9LDYPyrzH0jpGQ3buGLARlBBwWtDXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=eTf1cyBU; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="eTf1cyBU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74403A0291;
	Fri, 24 Jul 2026 21:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784921919; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zX9IqcnSTirOprj0aekNnHHoXry4vULMBvCiZUQOkG4=;
	b=eTf1cyBU1XZtb57bMDNOv+zqoeaPY5Cu47YAUVR2IkpDrpK1/ZPw5mZQjfWpiN4C6OwTQU
	dqd35qDsuHQ/TYbR0KZcszFpWGr7uAoeEyeZicfQX4VAjZ/HFvcuXF4a98eLlpyttZlvpJ
	vz4pAfRYttSsySgtcWopFJ4tCnehndpQoZrHRgBWFifPA/uR2TOjiZpvw7LCZs2CE2gbui
	yqewmMbh3YP63kIITXX/SY2+IBDtJUmjHBG/+g3DHEQVCGSmU0W9IeQXmANyjOtjzqz0I+
	VBqol2huiZPxmnw88E2ZRNHKwI+FQJvyyCE1psP3hkmHDY4Smt02/465j4x66g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 21:38:38 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 14/15] net: macb: use context swapping in
 .set_ringparam()
In-Reply-To: <20260724-macb-context-v5-14-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-14-569b1852bc7f@bootlin.com>
Message-ID: <31f655fd86080b11680196301bc4f6c0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.7.2026 17:29, Théo Lebrun wrote:
> ethtool_ops.set_ringparam() is implemented using the primitive close /
> update ring size / reopen sequence. Under memory pressure this does not
> fly: we free our buffers at close and cannot reallocate new ones at
> open. Also, it triggers a slow PHY reinit.
> 
> Instead, exploit the new context mechanism and improve our sequence to:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass buffer pointers to the hardware
>  - start interface
>  - free old context.
> 
> The HW disable sequence is inspired by macb_reset_hw() but avoids
> (1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.
> 
> The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
> over register writes which would be redundant (because values have not
> changed).
> 
> The generic context swapping parts are isolated into helper functions
> macb_context_swap_start|end(), reusable by other operations 
> (change_mtu,
> set_channels, etc).
> 
> Introduce a new locking primitive (mac_cfg_lock mutex) to serialise 
> swap
> with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
> retrain. Those callbacks grab phydev->lock if it exists so we could
> imagine grabbing that from the swap op, but phydev->lock doesn't exist
> in the SFP case.
> 
> AT91 EMAC is handled differently as their buffer management is separate
> and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
> context swapping for them.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
