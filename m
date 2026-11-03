Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674518;
	b=X2AeA5wAW4/5UOE/mRlNI6da8wpc6c7cttqP+qQEgFzqwYLdQujFL61YfMdpfxnlVgqK
	 o1T7AEWktA6/rPnoexfEZLQdEGA8tto0gLc1H8DRU33aAnN71PwDrHxtevDAtgvzbYiUJ
	 Ye32W7z4AiMnLcKJyU/BFJ1wrkHmHBj301PttSEM0zsu+pF3qGNcNrDEd1ZgSEu8Yh1kE
	 cztIkSkfmsBbHibVFRBELw9TGOnPSmxUZLIJJO3UkNuBtIcbfdt7+EVx/+lk7Z5zdgycW
	 QCpOji5cnlEsynBgsA05Pg8FIKAcMDq0+rjGvuTOQ+dRwSIe7uKbB6uFHMU5faP4duw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674518;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=M4IsPAVHTXvNhsayZrPE1EGmAc2003EPnpM+czZUcl4=;
	b=UOgF38gopW2FIiruis7ahzwTmkJzo7TP2wI/jNvP3BScPUvlQQqDtfXVr8FIRq38HBCi
	 1Bjoyb/pzfQYfWRlxR/iGgSwTzQNLCFL+e5yMSHg0CTetQqMqKW4qfktJ6uyCVZ4hO65B
	 YH5VDOen27tma6PmZMgwQM5Bg4zqqaeMyM1VAekE3kaP5tAET9bXL0JVkwpS04fWVykK+
	 hTeBUxNOoSgOY7gylIBkQx02mht/ciRARWsIFlH4DBHjhO/L6TEPKRTZ5lgV2ew0DAozY
	 fbiWUzkVxk1lJtGplcsVD0RznpAoGtvGZiihB6u9MVBjUFCiIPZ+FTYeFR5M2+yNSnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FYu2Qtdz;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7C606A327;
	Tue,  3 Nov 2026 02:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F7C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FYu2Qtdz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M4IsPAVHTXvNhsayZrPE1EGmAc2003EPnpM+czZUcl4=; b=FYu2QtdzFEaA+ec/ojb84UyEp+
	WS6yJQohOv0GfKGDl/6dDbX6yHLTk3aSt0BJAL6gfK0O9wg6uV4bTbPosNceYft1tzzDHPJIzGLcr
	ZMjCKcYKDjBryxvFFUAR4AnxVZMHoHNXsdA3HoNKWHps+fdTqtPfffwWXqvJC+gVMkmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xO4fp-00DwWH-71; Tue, 03 Nov 2026 03:54:57 +0100
Date: Tue, 3 Nov 2026 03:54:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
Message-ID: <48cb8a9d-622f-497c-a13e-bc679c764ce0@lunn.ch>
References: <20261029094916.3127193-2-coiaprant@gmail.com>
 <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
 <1B8D463D-1295-4BF0-972D-859C342E49F5@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B8D463D-1295-4BF0-972D-859C342E49F5@gmail.com>

> Hi Maxime,
> 
> You're right that for modes the PCS does implement, the limit belongs
> on the MAC side. The complication is that the compat table describes
> the whole Synopsys IP set, while a given XPCS instance only implements
> a subset of it. That is a historical design issue in pcs-xpcs: the
> table mixes C73, C37, 2500BASE-X and 10GBASE-X entries, but different
> integrations implement different subsets.
> 
> On RK3568 the XPCS instance is wired up for the C37 SGMII path only.
> 1000BASE-X is part of the same C37 core, but I don't have a PHY to test
> it against. QSGMII is not implemented in this core. 2500BASE-X and
> 10GBASE-X are separate modes the shared table carries, and neither is
> implemented on this SoC. C73 is not wired up either.
> 
> Trimming the mask is not limiting the PCS, it is cutting the shared
> table down to what this instance actually implements. A
> platform-specific glue is the right place to do that.

Are there any registers which describe how the PCS was configured at
syntheses time?

	Andrew
