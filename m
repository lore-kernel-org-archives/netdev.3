Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045748;
	b=P9S2q6LaGt+EJrNLY4LR7Fq4jgb8/9hwm5HXymPUFjOMv2l7TWO27dMATfpEB0Q0vAFf
	 /exgCutrWtoRHBCkY5DOBrJaAC9ehIxXAU05EjANDF14NPZ7ROjzYBX1ctrkrZE6Vo7Jc
	 qPB7t5suZyGp3e9qxQjuptZHigcHOiDyWKoKQ6bSuXNa4uytazvZbFe2x5HB/sXyrt9Ux
	 nhhNntskRWz0eu7pg25NoEXIFV5PEcuRl6XLBkfpDH0oLExwFp1E+wgdS/oWfEB2rE/49
	 ZKfHe8/NwgIx8hSs4SR5K9jOG16Tyynh0i42VHn6F/ayuvyHBQvknuZZQTUc6CKg2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045748;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TjMdFk8RF2kaRdnGIftRqRXHaK9TIJqelTHCSWvnKbg=;
	b=D7yz3vl7pUwRg3vphWjNCEkgelCIvPfkfgzPmVVQCaBOmnQqFv5OzOrfm62BDMyMKOrj
	 2hY3Q3uzfrC7cft3ruaMIQ+XAavBjiqX8yCAvIbU9Gv9cWV2pWLlYNmDEyYLaiD2KdjgY
	 6Dk8dNcQNFcfg8lFmYL68UWOoKCiOaPZ+dyUFtekpNs2lvjOQjMWWNlWELSh/jSFjUmwO
	 m+eTkVe/EE0qjoJRXTB8ELJbui2D5hTxP7mHUvzDkgYSzO52J5C+ImmWbkI3S9GjHvIYX
	 NuiW477vkbt3CACp82OsghM+DuR6OJDTnEEsW+6B0lYgyMbI3KFDacHh7i1CfNrTkzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=YA3oaAqq;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4D606A32F;
	Sat,  7 Nov 2026 10:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B4D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=YA3oaAqq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794045741;
	bh=+/ah8vkaUP87DIJHEblp3tls1hoAvi5cG63uzTk2jyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=YA3oaAqqZeN6mMwRbLlWFxUHJTOS/YV5Tf0YMXVoJGIeGL1kBg3ADZFfe5MNss8vE
	 MIEoobu/aDKNIrDejwSZFcURBEatbOt+BAIuzjkZ12NRCYmeGkrHMnGDIOSWsNpEGL
	 MLf7cp1GrS1iC0Gx4bH5sxaEq5fH4DhVKFjeqsM2x7fbVWaYgtZRG2Ft0H2JG9ORJ6
	 zI2LEmpGjLw+Yx/XISWN6bbUKkyzu/ViR20cEfpKUwmyJpEkeI11ITx49iO45mk6sZ
	 XwvkqaG4hxP0HO+2XeRh9sURl+EKV0txlu5rE6XO/0QqJ00xhuY0DmB5bfzSISoDvF
	 lMG6KdXpegkHw==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 3E6128147A; Sat,  7 Nov 2026 10:02:21 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel interrupts
Date: Sat,  7 Nov 2026 07:01:40 -0300
Message-ID: <20261107100140.8279-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179379704484.488856.2140619507341432623@kernel.org>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com> <179379704484.488856.2140619507341432623@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Should the Fixes: tag point at 1b9707e6f1a9 instead, or also include it?
> As written, stable may backport this to 5.13+ trees that cannot hit these
> storms.

A data point for the RBU case from the YT6801, same 64-byte UDP RX
flood, all on the same 7.0.13 kernel:

  stmmac from 7.0.13 (has 6ccf12ae111e, not 1b9707e6f1a9):
    no storm; the MAC interrupt never fires (4 streams for 10 s,
    and 8 streams plus TX for 30 s)
  stmmac from 7.2.11, built for 7.0.13:
    storm, the machine hangs
  the same, with only 1b9707e6f1a9 reverted:
    no storm

So on this hardware the RBU storm needs 1b9707e6f1a9. I did not test
the RPS case.

> Since RBU and RPS were enabled only for statistics, was masking them in
> multi-MSI mode considered as an alternative?

For reference, d3265c19b35d ("net: stmmac: xgmac2: disable RBUE in
default RX interrupt mask") took that route for xgmac2.

Magnus
