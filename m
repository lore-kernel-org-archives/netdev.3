Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793035973;
	b=ZTb7i9Go0rfkufxoMBWNpPQSoVx2xhvKhdNNXnLKAmyamzbw2MASHkn0uztgy1ZQ//BP
	 1LYHiW2xRWsnZ3au3dhw9xZcQc9mPLrX1rategKXC3zN8mzDkeRiGnfcrUJysakLkw6d0
	 F7c3d8vc5aY0OxbSO84s3hG0bC8E+/frEuaJriEIFqViwGsEbrXLczduDRTiw2L5SN8CT
	 WSlMIny9gzD4JcvK97xL6O7YWPT/y8oguz1/34WS0eA1HsTTcxG5cC+W2izvrD6DxYE5z
	 lS77i/o4zVfRZY5eE+AkSQUXZ6gYt/J3+JWSir5f937e4rPvob8flhU01gSaQA7ntbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035973;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=m21+6xwsTas/4aG1GnIOqBxWmhfu5Hmar62qCJvzW0Y=;
	b=vSRKEDyv8tMXVtA4PJhCpxrjxZWoFMm/tv1GZmhsEkJaTeF+4ZjGPdrk4s7n3BSZvCnK
	 dCXekNXRGN5QDLk2O4ScEVoc87ORrQZE7eiVQeShOVnH5m+8LglcnZR2cAElaq4E4WghK
	 G0MDdE98bM4H5ZdpXpHrdQqAvlDOHC6n10l4u9n3dKlLKjZhn5vvUhR08hXoMxt7iPUY1
	 o+UAv49gGXD2dlxdV36VZTCT0mYTp7lczR+GfP611hFQFq1Ws6CNrXt8tHz1Lnuq7Z4tR
	 S+O7GLNpV5jladgL5fbjiuQ/bOslZc9CKKKsyNO8u7L93ra2ym987tEMXcuw2+Kp0xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=L4B9SDM2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD0606A31A;
	Mon, 26 Oct 2026 17:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54FD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=L4B9SDM2
ARC-Seal: i=1; a=rsa-sha256; t=1793035938; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=L4zQ3u3Gh1/7EhzANUJon02xknPj3GiVgg4ZS0UxAbpSBG3w65jqGNeozU9TGhN5ddGM/1bLqnvOnZWFX87gH7Oaq4FdiDDhXR79wY+0+Mg3gFDo6xycPHWn3/e54VX5CXlNouVacY7sXdE2TJc/MnaGk7CPvBBLHwr7eDJ1K/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793035938; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m21+6xwsTas/4aG1GnIOqBxWmhfu5Hmar62qCJvzW0Y=; 
	b=IZO9T7/N/eOCy0jaC29UtkZmDSKqbPk3XXDzZJSrn9HC0dk/sgxTzDMirfbx8SO4F2rqmwF5jtmn5MumsZDiugnLRu+c0o0xZhEbVLygo5eiCO2skCw3XgF/3ppsclAwAYHCNmMZwtg6PJoKopIG/z3gbS6J3vHbKHUJ8q2Su7M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793035938;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m21+6xwsTas/4aG1GnIOqBxWmhfu5Hmar62qCJvzW0Y=;
	b=L4B9SDM2cdS9Q7k+OkzkqgqYuPMF+hd+yoekcQcM57YAYK1l8dWh3QwXuE0ZBku7
	x2V2qDOioR+uHpGrbrPzJXG+JbK2bt32byxKSexnZJLa5xupW73zSUgs3poLkvPsfiT
	OKfPiduLZOZEKpaOTQqf60FBNuskYqk+taKAiYsg=
Received: by smtp.zoho.eu with SMTPS id 179303593657064.19003206138837;
	Mon, 26 Oct 2026 18:32:16 +0100 (CET)
Date: Mon, 26 Oct 2026 19:32:15 +0200
From: Igor Velkov <iav@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, Paul Barker <paul@pbarker.dev>, Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, Thangaraj Samynathan <Thangaraj.S@microchip.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH net v2 1/2] net: phy: move irq_suspended and irq_rerun out of the bitfield
Message-ID: <20261026-phylib-v2-lock-reply-1@iav.lv>
In-Reply-To: <b99454f1-9c3e-42eb-ad03-3941015879a2@lunn.ch>
References: <20261026045343.837889-1-iav@iav.lv> <20261026045343.837889-2-iav@iav.lv> <b99454f1-9c3e-42eb-ad03-3941015879a2@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026, Andrew Lunn wrote:
> As you say, it is an IRQ thread. Because interrupt handlers might need
> to access the PHY, which is a blocking operation,
> request_threaded_irq() is used in phy_request_interrupt(). So you can
> just take the mutex and make the RMW thread atomic.

The lock in phy_interrupt() only orders against writers that hold it.
phy_suspend() writes wol_enabled and suspended unlocked, e.g. from
phy_stop() in the MAC's suspend while the link-down interrupt may set
irq_rerun, and it cannot take the lock: phy_may_wakeup() can call
phy_ethtool_get_wol(), which takes it. mdio_bus_phy_suspend() and
phy_config_interrupt() write that word unlocked too. As bools,
irq_suspended and irq_rerun share it with none of them.
Would you still prefer the lock?
