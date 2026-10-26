Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034057;
	b=lmJBstg/nu2eU8jSQA/6HmPeGm96MizAJrzyG7b0/SmMNylTr3qSMy3YxzzIdJAEr6rw
	 GBlTkG6GM7OluBaHVKwJeVD+zhxGwFW0dHNk4nAfWcEPDasi84dJbmQ/QkBkbwbCwb72a
	 l7GBgfAkG+ucwsbH8LuW2IN5xHjNKPtlO+uLE1UIeKnUxV0exiNLYZ88y4pOuVo01BHbQ
	 wJ/DhMR5jauIc2crIDJkeOCnpcVEfrTURjo2I01HDLN2z+nGTGA+NIsk+OwAhSkJ6M1zj
	 VVOMvpGMkL87RC9k4OXp8/g+K344JKXnb4U6xzm9Bl/oDDXRHOS4N5g6KNG64LTh/Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=5HQ9FyFN6hNHmlUBl0gpcj4ziO79DsN2Skm/oOYMFnWlCM3gxy2qkGCNGt5pC7e8aviQ
	 9hKhHCCa2QhpVtCT789EoEid6DtePZGYfnNtBV1z9BKKe86zrQf4gYQVP0N2MsduC9pOu
	 h1SJm1+IeE8XKaV5CbLhN6+fVzIKIYWcRTJ2/ChLoxOzmspsC4nCnt7s1MNCPR5qy0XMb
	 Wa3zQBgYxOnezLcmfWJGOZTJZZuV9mWLBC97ujowdl36b24dmrZVhx6Nu2+CPOxk1ustS
	 cY13LuJxqve0SzRutZ76SUBP+CABpaodm1WjvHUzpDWVilDFx+2XBpE0WETuZRDtXDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef1oLSkC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF0606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef1oLSkC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5FE1F01825;
	Mon, 26 Oct 2026 17:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793034056;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef1oLSkCt8aX5JQdrJUpCoYYWU3gtpGQlEqkLpTBsGra9JpKJsyeM7A1sIpgKCuWU
	 OgaQxTBucA6dtRzBAzKHdkx16H+Abyf5qZSzVR9rVuTRhrs9DPTOyT4wCt4f7GEFmq
	 tId57QxGu3eal6P7GEAMiA0odz8/lL8LGn9tZoTpB7wJPmnj7hhKjQlgfA4uWBvHu5
	 NXpLd1j2J2W9GeziiHjh9FPScsToZNT5wcXsXS3t0dA/QSQqBh+nihvibM7d3vB/X/
	 2i2o7Nh1Oa6KMWP1VAuc0oYyTy4k6MZ+XIneq90F4i7YO8OYRWbfk46ZiqKKX7KhCS
	 lbx8Yw1qTw2mA==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net v4 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Date: Mon, 26 Oct 2026 17:00:54 +0000
Message-ID: <179303405498.3327.6709797406209936415@kernel.org>
In-Reply-To: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
