Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302372;
	b=2huO0LPAwNVyObR34wkKrcX/DoiMVKM1BVSq+c3WoFRoDsx0nDfWZZ1dYPqK16E3vnkJ
	 6dAOLDxJceYi2YKAfDeNFofEKB1JSJl+VV/3QVJuQ3rDtQdS/9MxsvJtHCrFL6eqFKrxt
	 OeRLFJNUzyOqL7cn6+glB09TOObwhKeZh2ImncVUHSra/dbUs3mv47IYXd1CKx6mdt1NB
	 /B4riEyqrWDi1Qvl1Jvoe0TCilz2TdUMuaautvwz6ZKUsG9rtl+YJAsrXstlFMDthXue4
	 VUAFIg6sTfqqe+sngEvsF83NustoV4so2W2xWvX4A5yAG8KgNwydM+TuLTfAvd+eLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302372;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RqKb78p7qpWJlKAs1Itlkd98Zkf/qvmrWv/pFqO1J5I=;
	b=LtloZVQnbJMMfkobXV3UtxJJLRJ5ZWstGtbSN0RkQ/lpISg6832vpSPS9lGCY6oeuJdP
	 Tg6M8wVRsOdr9JlueRHSP2O40O/LA2AXJYE6uBD/WWzAbUrRmT0ZJroaO7+t6NEwLnzrw
	 Nj/XZ4dHUCMH466cIVA6fc+GJHcMCgMTRaPAUuhUXDlN2fUCQGARm1tk7IgnLetLtyLw+
	 CzaKVPIB6NmLZmngCiRN7tLbV7Kvphdi2mNDP+7gwIoDD+IsaAdb1xdr+Ws7m3KtpCeqH
	 8Li0hiXP3w4FTzOMHmj8up7tNKEMPjqRUJWbgk/o+XQNyoypFcTNxbqOSHIBsxitmwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=GXKfaXPR;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982460A380A;
	Tue, 10 Nov 2026 09:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C982460A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=GXKfaXPR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794302365;
	bh=kQBTjdYh2JWmkBfDmSwwc/2rdQED1OQpth8b7MZf1hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=GXKfaXPRHbJgZTRCX20dK30P3/GvXQmtvZc5FWdvRQYvseCs/iN8D2DltZjpckMND
	 plrKIspEqStfKqIIwcFNS+L57fFJJp7Jp7msEezv965i8O9VHmFJGXa3ZJ/UqREdDF
	 8ur0jpgCMdGqXZZFAFQoFe8QuuKWT2g9YlOd9uDMAD2bO35/gpCm893tOKykrkqX5Z
	 Jy+qwEQskvlv9wV/VytJzBIdi3t8oZS8kZ+D3IlMJXWky0S3fl3/88FHl0/4TWymBT
	 Fj75cIZkA6javPnvgswqBP4SeSP2FuxgkIIq1Ni+RaDTG0m4gNhIRbbbVOMlk8BGK9
	 fTKTKh6jisY2w==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 515E781428; Tue, 10 Nov 2026 09:19:25 +0000 (UTC)
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
Date: Tue, 10 Nov 2026 06:19:01 -0300
Message-ID: <20261110091901.7080-1-magnusleatti@kernelriot.com>
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

> Since RBU and RPS were enabled only for statistics, was masking them in
> multi-MSI mode considered as an alternative?

Hi Maxime,

Tested that route on dwmac4 (YT6801, 7.3.3) next to v2.

Stock 7.3.3 dies in 4s under a 4x 64B UDP flood (122k irq/s storm).
Both v2 and dropping RBU from the abnormal mask survive with the same
~3M RX frames within noise (3 runs each, alternating), but:

                 v2 (A)        no RBU irq (B)
  MAC irqs:      18k - 43k     0
  rx_buf_unav:   9k - 21k      0
  %irq CPU:      3.9 - 7.1     1.1 - 1.5
  RX frames:     2.5M - 3.0M   2.8M - 3.2M

Same on 8x UDP + TCP TX (30s): both stay up, A takes up to 33k MAC
irqs, B takes 0.

Caveats for B:
- Core is a 5.2, so only the 4.10 mask was exercised.
- RPS never fired, so this doesn't test the RPS storm fix from v2.
- rx_buf_unav_irq stays at 0 (pre-1b9707e6f1a9).

Want RBU dropped from the dwmac4 mask too? Can send a patch or you can
fold it into v3.

Magnus
