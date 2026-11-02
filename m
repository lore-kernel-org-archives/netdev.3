Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641454;
	b=JKJJIdLQ0102z0UnmBAXJdBShu2vD1P3/8AvaJTHnibSGtbwSE+YvgCE+74maFipeeA5
	 8+IVISlJ04yova+1Qy0YnbKLgOGd6jI4wvoG3yhHtlKrj9K27c+7EhSp1a9zOkBkwVwuK
	 xhujDJXzo0IlZ5vFF+Ltz6/GgIfOh3VUargGJ6x7s91k4lyaSzxNwSLUVZdc4kVUP/+Wz
	 9jlulnCNwYJFKIae75gh7f288f4aOwfamTgP6Sd6zU8AsTbSKbnRnyCgxDknFtgch2RzA
	 4eNxg0GMeIZz2tfctia1yKvfNEPFd/ddO8G0uAQA2JvadHX6rNGliEa8qVSUDONqGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=BQEYNtnZjp1iISiFeOHvGklXpzNFhZRiClVam2KI+XE5cGAZBJ8lwxdTzOVEWJlrPEAq
	 rzJVpZUk0i+ODWF1h2D/yYmUmXKye1KXBpwYEDJTxW3OZMGYo/RMMZqCB4+K0rl37ug2P
	 jBYv4Bh06kqr7psaUjGNlklayIvXx9QgaiKAbGn4gFH+4MKIeSIMlHTab4gLHFbRcuANA
	 FV0Qh77bkEEvWMBgD8lnIgGMctfhB71ZeXLKp/ZSUNtKr33m4V/5L5c9XhnshonM02Cmb
	 o4lIGmrOK9zvwNavOuighRcuuL6sKbIM0wHdhmlvVM2HGKufsJHmcMHFOjEh4+/xKhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFH+9lDm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46C606B1C8
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFH+9lDm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED11F00A1A;
	Mon,  2 Nov 2026 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641454;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CFH+9lDmIhi1EcXtrYDQT2aON1nue/8zrLRncLS1d18qQhA+b53bkrPU0jp9JHYEX
	 TIwvNW3yrxuazH8Fw9mYNH2UZA65kFCo0Xjnei3jFlJ2qQrtrzdV55O0MTv4YD9cCI
	 /oriMynOIlayxRjN2t/VoSw0Hrs3wgdrZrAqe3DZ8zdR1kD+TSLq3UuSiCNUPEYFDo
	 0JgA/8gLlillxhNlDPR+gKt7tV1kc/kJ2l6SsqNN6UydlhiFAnm6FFhNha4g9Idboh
	 MWC9jQHL9oGMxrmcSXihcLvk8Z8CUMUdJUM99AeYJgJi+DQ7YORF7k+WUzphxrMJ0k
	 0vjsMMtPP2ibA==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: 
 Re: [PATCH net] net: stmmac: keep est_lock across PTP clock adjustment
Date: Mon, 02 Nov 2026 17:44:12 +0000
Message-ID: <179364145292.3286.14851003961835841774@kernel.org>
In-Reply-To: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
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
