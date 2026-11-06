Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980557;
	b=DYbBK4BZ60k3n6kXgqAevR7lzc6BGUlNiqFDmVWLjzubNC/0glOzrTQKcchRCuC7UCjG
	 xhR0q78HFk8aYrRGEHOTGRUB66rgubnkxvKBdMPecQOqR2+1TLM5D/5C8lahpJzZ5cXx+
	 ZQWj2YphUw4Wn8uA8A17sQWjyDG+6oqDOdiA1asfqI3VImBnbxPrvDPxEUGmRNeRDg+GT
	 XIVdGiOrnt6r6C4ohz/wqERZdRZZwWws4JnMUKoOSjeCaWQ1TKvUt0Oiio/uX6q1B8krK
	 dw65gwa830BLYT4MDrEdUjn0O8R6BWtA2jSOC36hr/6OZX3YT78nYcAvB41em8D0kZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980557;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BCioul3B6OdYvFh9JZhAwvMgFeXlmvL+TKu9XvZlfGg=;
	b=JP7R/F0blMAEA/fHYmLFQn8c5UkvBxKMCBxft2fRuhbEUzr+VnFN0FjoZJZkWnnI2YLw
	 rz8fe+6k123eT7dEpx5Gfvkx97m3weSN8aAUVCaKzBn3m7A9LN2aCcE8NVpwSFUu/vcdN
	 nK5IPMt3VLoblNzeCXncmt/02dbD7PRuw037J8jVkCn9c/vPFhmfGnM4zzsgO3U3kqnnv
	 A1ZzOtFoAxtgxxvDKNnxGQ5AQHGwZcNQPfpZzy0L3zBkxzf18vSKS8vUAEGuS/ScILNxT
	 /aNxvxSdvADVZuh+B8PW4sFg0vOrXu7lpDF9hMOIe54VRh54bGKXv2TboZtj+Ip0sxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JrgZiFs7;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD9606A329;
	Fri,  6 Nov 2026 15:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDD9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JrgZiFs7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BCioul3B6OdYvFh9JZhAwvMgFeXlmvL+TKu9XvZlfGg=; b=JrgZiFs7WDRFq9M7AGZBt8AcxS
	REpmImLbWhal0W9riTLTJk7DNQE/OQcuDDLWjVHzbsTXyLwfKP9hAe/SNkrv883pvFT287Mp6uNKq
	K4R1kEvxErlJdK/+Zs6eRcXJoB8+vrQaI58sXp2BCHzLXl7AUGPucHlk9crAN4ywvoxo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPMI4-00EoZW-0R; Fri, 06 Nov 2026 16:55:44 +0100
Date: Fri, 6 Nov 2026 16:55:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Eric Dumazet <edumazet@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Jianhui Xu <neuromoments@gmail.com>,
	Emir Beganovic <beganovic.emir@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
Message-ID: <1bcae18f-ca18-44bc-980f-ed34e87db5a7@lunn.ch>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
 <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
 <69be2cfe-e296-4f90-ad19-0bd48a83e287@bootlin.com>
 <27119213-dccc-4c17-bf7e-b39a038038cf@birger-koblitz.de>
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
In-Reply-To: <27119213-dccc-4c17-bf7e-b39a038038cf@birger-koblitz.de>

On Fri, Nov 06, 2026 at 04:32:30PM +0100, Birger Koblitz wrote:
> Thanks Maxime for reviewing!
> 
> On 06/11/2026 11:11 am, Maxime Chevallier wrote:
> 
> > > +/**
> > > + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
> > > + * @pl: a pointer to a &struct phylink returned from phylink_create()
> > > + *
> > > + * Passes a link-change interrupt received by the MAC to phylib.
> > > + * This function may be called in interrupt context, and therefore cannot take
> > > + * a mutex. However, it is safe to assume that the reference to phy does not
> > > + * disappear during the call, as only an SFP module may be unplugged to make a
> > > + * PHY disappear. SFP modules however do not support interrupts.
> > 
> > I don't see the relevance of PHY SFP supporting interrupts or not here,
> > this just re-triggers the PHY state machine. Looks like a comment to
> > make sashiko happy.
> Indeed, this is for sashiko. Unfortunately it followed up with: "The
> function comment notes that SFP modules do not support interrupts. However,
> when an SFP module is physically unplugged, the electrical link drops. Could
> this link drop trigger the MAC interrupt being handled here?", which is
> equally irrelevant, I believe.

It does appear the LLM does not understand what an SFP is and how it
operates.

We should just accept the LLM is wrong, and don't add too many
comments to try to correct it.

The danger is, this code gets merged, and LLM kiddies come along,
there LLM thinks it is broken, they try to fix it and submit
patches. But lets see if that actually happens.

	Andrew
