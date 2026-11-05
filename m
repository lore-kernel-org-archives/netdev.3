Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894680;
	b=Mg+RPsW9dJRQkZohnkHMQiU5DZAQOfZnnqGhGZT359ywsL/FAUM5fbAmXIb7PjvwExy8
	 n6AIS6i05zZZ/UwURExBGFV/2ccJ23WmtBmUjmEYlCR/Mm0E1xYNxvBT9ui6Da9Dtptni
	 Pn7cKqKahGuLiCbAOYBo90RsKKFeYrHYVRJPyMiImF7SR1PjoxMkp3k/lAww0w/HEX8QD
	 WlXDBrX2xI4VPUqs9fGjoOZf/rKSuQDWQlkP57tDY2S/D5eWGkliLds1cXDi30VCaR337
	 TLypwPn097xEccFBeIVe5ncqFGTWvb6FEaMkC/5IJYWiXcMfNqnkhBqdElARj8j8kKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894680;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BZCCivNGZkxh65c7HiyfjMALKY8nITg+wkkERgqmnDg=;
	b=YmTTqXVFH96uZt6OGfSh1kwWyE2N0NNrIjiEAgG6P6AAgYX1MqBY04zXbaDc726u/01E
	 hT6L/O0QXAzaUoCEeyPso2f+oy+gxZpl4L2aXltmesWmh9siBZcDXXGumwWzeWLvbFzCi
	 c69kfdgjNRiM7kcs+Nhj+Kjkc3zzq4NmZG8H07SRcF/x8RMsEkbvMVX4Y3rawBaAcnHtF
	 Pqhs99XeB6L4Eshf7ilGpimPw/ElZx2SJ4Rus9jJRbqBdUMczeZEIglByxZClX7rh8UEP
	 3+l0Pq6GcDu8i9bfC5sMi8Hg25wSVqelvvLvN3qMfG9+Je4qoVyBWiC3JQLl+gRg1OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bCWePtko;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F4606A32F;
	Thu,  5 Nov 2026 16:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E6F4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=bCWePtko
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BZCCivNGZkxh65c7HiyfjMALKY8nITg+wkkERgqmnDg=; b=bC
	WePtkoReN5eCTkBPQqrB0/3rsiawggNO0Q+ohlmuKYzY7U0OH9W1fwfzGRswOApvgWZfG1As4WIwt
	LGV89MCibauYyPBFMRh7byPWBksqYhXtRZ/f2bT4j8RdsWQ6tg9UndvkDZ90gwMLHqCIa14jx8P5x
	EQPw7mvQaZ13vjk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOzwt-00EbQa-5u; Thu, 05 Nov 2026 17:04:23 +0100
Date: Thu, 5 Nov 2026 17:04:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	edumazet@kernel.org, pabeni@redhat.com, nichen@iscas.ac.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: adi: adin1110: mask the RX IRQ of
 the port being stopped
Message-ID: <b8f6cb77-2e36-48d6-b8c5-95e734054930@lunn.ch>
References: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>

> v2:
> - Cc the netdev maintainers, as flagged by the cc_maintainers CI check on v1.

./scripts/get_maintainer.pl drivers/net/ethernet/adi/adin1110.c 
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@kernel.org> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS,commit_signer:1/3=33%)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS,commit_signer:1/3=33%)
"Nuno Sá" <nuno.sa@analog.com> (commit_signer:1/3=33%)
Heiner Kallweit <hkallweit1@gmail.com> (commit_signer:1/3=33%,authored:1/3=33%,added_lines:1/5=20%,removed_lines:1/2=50%)
Chen Ni <nichen@iscas.ac.cn> (commit_signer:1/3=33%,authored:1/3=33%,added_lines:3/5=60%)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)

Since this is an analogue devices device, don't you think Cc:ing
"Nuno Sá" <nuno.sa@analog.com> would be good?

    Andrew

---
pw-bot: cr
