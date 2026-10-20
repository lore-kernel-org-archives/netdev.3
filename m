Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487727;
	b=PmGltNKWoUJ95UWJ8Ovp0NyLdiBBBZWkV2ALsSHkrxn/bTqFD1PtE/QpYTX5k4wEfeaP
	 D2z+aHUcJSHmPTp+v/AAj5ZiT8mKFAOQ6q2/NOE7wKFfS4fZQV9Zemdqva6qOC3n0qBSs
	 FV1h98tWkwKPjiMJlSDTw3AFk80vvU1f/jRveQMQLIBRwt0Oh41vwnwR2HtifBC2pr7P/
	 XNycSWj7+lc76oaD+vZSrHMOkNox4gpOA2RH+/iA5T6kRmr+mtsjU5aCyPFIMNDfWehKS
	 A12gFOyNZdxT8N/aWA2DrB2dcjdKK/U1lFv0JE/Y3wfFTztvcHaGlAaz94GUoYRMbPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487727;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=3fZFaomKLWvXOGLrVyrii/Wn33bpKfsaF9RKLcePpZo=;
	b=OL2nxlwdGkyL7i5Fqjlds43KrLdTe3qa4rSQ0NWTubGqo/FI3t+KUPpox35dwVI/mJzZ
	 nW9apPbewKEwgGCiEQOl9yn+VhEJ76B4x1biFIwhT69xGV78wh8HQUB1sDRzdo1mjxEVr
	 FmpIyLMcAJo9QwZulbDhqTzTEPjxJhNYOyN2tUHUJRa2WOY0uMgBE5LXlAQpDNLuHy/xr
	 +8mhCt9EQp26db6mEDT4aj5+R/RRmtuan3AGvMraY4lRG6Vmu1FxQH2Db657lafdc2Jx5
	 i5Va33DdsI0WmryLxoPl2niav/esV5bkb3yFBJig8SvPXZNbG0hspQTn7lniJY4iipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RqiCIZ1V;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3B606A31D;
	Tue, 20 Oct 2026 09:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F3B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RqiCIZ1V
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF7104E4122B;
	Tue, 20 Oct 2026 09:15:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94CF460393;
	Tue, 20 Oct 2026 09:15:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF63103289A8;
	Tue, 20 Oct 2026 11:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792487722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3fZFaomKLWvXOGLrVyrii/Wn33bpKfsaF9RKLcePpZo=;
	b=RqiCIZ1VGeW06L64sT6IzotR2GLPFXJsSQAq1ZRcyhqSGLpvfMVRc1jUH0TrWuigTLiawd
	+kNPpFMl3os4bCraJfrJt2IQn2BA1DYejnhyiQy/r6DUWMPcKLM0chmRcV+dUL9sKnf2Qz
	zTYgRab6rcV/46pvORmcdb9o/PCyT+uFBZQ+t+kpVoMU1IcLfAUU8+zhiUnhvdQzofg7bs
	O4oIhaJvgwZBsFse5W/WM2ysoza+1b/WjIZ2XqInEm0PDvuAC/7s+kXRNuP03vG3M7yAgM
	uESb+JCYCzmi1EXWfTV67cjcuNDdCL2d6HC9buCyPB7i8OVBdRKsMqHA2bhp9Q==
Message-ID: <5b63ae66-551e-40ed-81ad-fbc52b93e24f@bootlin.com>
Date: Tue, 20 Oct 2026 11:15:17 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 1/2] net: pse-pd: si3474: keep detection enabled on
 the other PIs
To: Piotr Kubik <piotr@kubik.pl>, netdev@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Carlo Szelinsky <github@szelinsky.de>
References: <20261019162453.1244120-1-piotr@kubik.pl>
 <20261019162453.1244120-2-piotr@kubik.pl>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261019162453.1244120-2-piotr@kubik.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/19/26 18:24, Piotr Kubik wrote:
> DETECT_CLASS_ENABLE holds the detection and classification bits of
> all four channels of a quad. si3474_pi_enable() wrote the register
> with the bits of its own PI only, so it cleared them for the other PI
> of the quad. In AUTO mode that PI keeps its admin state and a PD that
> already has power keeps it, but the port runs no new detection: a PD
> plugged in later, or one waiting for detection when the other PI is
> enabled, gets no power.
> 
> Read the register and set the PI bits, as the PORT_MODE update above
> already does.
> 
> Discovered by an AI code review agent. Confirmed on an SDG-9000 board
> (MediaTek MT7988A, two Si3474 in AUTO pin mode) with Linux 6.18:
> with both PIs of one quad disabled, enabling PI A and then PI B left
> DETECT_CLASS_ENABLE with the bits of PI B only, and a PD on PI A never
> got power. No kernel change was needed to reproduce it.
> 
> Tested on the same board with the same sequence in both orders:
> DETECT_CLASS_ENABLE keeps the bits of both PIs, and the PD gets power.
> No kernel selftest covers PSE hardware.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

