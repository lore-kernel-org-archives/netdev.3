Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530337;
	b=jET0dlUz2aYMAG+bV01olQrnAeZD1H9xD77ummY5H02jPfo1ytYaTznHaAIbWL2JRUYS
	 wmZmNq4xOEGNdmla6Yxa3WrsOV2fWpcb+ndxePRLNd9dzan1yokHpEFlwDj8zy1pzLWtk
	 6J5t9te5qN6+B/NWKRydOyihEbwd3UPEgPQI9Vn/g2H7ZWfyRYoQP8NO5Msxx94537uS7
	 e/Gbo0Qfyme222SPOSgHJG3odpHYR3FV4ISyT4xHzUO4VSepHpXoCq5teeFHes2DpJnVd
	 8ffOjsp9+jsHXuCVi0ye/cQBiql6rHMYG4VuWCFyUz1uQKDGYSelt2aN0a9boEHeE2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530337;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eMqMFwpTpqN2HVxCs4u1Rwn8A+RwwZ+HmzQanCZlbz8=;
	b=vRnrnEIDTG94hpoLHYNBR5eSIxKXYkfxIkvEihl4mNsxGblIX66lumzzs9665r5KkxGi
	 01wdXxyKGBUqtqLstnDkQ/+rLiUG3pKe6bYETukXLGKIvSVbaFw89xT8TWe3b/Pi3AnvS
	 30p9S+FjIC2f+fZ6WF1qsZdja8EYNF9ZtdSj8rrtZrsh5OrYnuV60JjVkB9zIGnj5PMPR
	 NASu6yFuLcGcdcdY4LNTVrr0rK2euiZ4TXgU1LCHlU6MmMXwqw+s4ybVEUhBLZ3so9Prw
	 x4oKouvd1vckDvvbsePZbHtXT/6Zf/DLyPfF+TxDH0z7OnTivf2ya6QOi0pK3osPw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JDkvzPaB;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CD606A31A;
	Tue, 20 Oct 2026 21:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JDkvzPaB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eMqMFwpTpqN2HVxCs4u1Rwn8A+RwwZ+HmzQanCZlbz8=; b=JDkvzPaBGFYP/YGilqnwS/4V7d
	cQEL59YkU01AvJpJspB2yA2HPmO+upPkeQOxWljn4yzebKeoo5pwhFvlR9KAkAHk7JlsLeo55Jfo2
	bJTyVQ0WMl9kwqb5sS0y0tPbL2nEdteYIgHBInrDPBh2sw+rhXkbbuIKZi/7m0/evMGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJH1H-00BvdT-Be; Tue, 20 Oct 2026 23:05:15 +0200
Date: Tue, 20 Oct 2026 23:05:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix error handling in
 lan78xx_open()
Message-ID: <1449a6a1-670c-4d1d-bb98-51f92e32d848@lunn.ch>
References: <20261020202614.30277-1-stefanomunari.sm@gmail.com>
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
In-Reply-To: <20261020202614.30277-1-stefanomunari.sm@gmail.com>

On Tue, Oct 20, 2026 at 10:26:14PM +0200, Stefano Munari wrote:
> A failed interrupt URB submission leaves NAPI enabled and EVENT_DEV_OPEN
> set. A subsequent open enables NAPI again, triggering BUG_ON() in
> napi_enable().
> 
> Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.
> 
> Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
> With the fix, the injected allocation failure returns -ENOMEM and a
> subsequent open succeeds. Verified connectivity with ping and SSH.

Memory allocations for small blocks generally don't fail, so this is
theoretical, and very unlikely to happen. Please target net-next, and
drop the Fixes tag.

    Andrew

---
pw-bot: cr
