Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08F524AF4
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687693; cv=none; b=WEEWhZkc+u8KPvHJCwIn+ScK9VemrYS2bseVRczC5pS6nIu6fP8jyg4Fijk7PjhfJFwXNjBWSX3i+SWCWQELsRajaXdsCkS7QbB5dQuwKd/UnjZgdNXYN0iN10YGVlzrNaJmyK5EuebUaLm2Xyzkk7GO7PMm8+fBN+oBbHUfOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687693; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjfONZEHUuKRZaYNr5vYjC964QbnMQvc+HlpszFyDBNB0syMt811T4TGKM4dDDOmnioWf73KH4BgRLnreqMbwT2diNlXVg1M05rMfRc2OTsFiYK2PcUZgRQYqodxaKpKw95txby0u77OrTSP/oeNCQ48M+acnEylyJ1Gx6LOxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaOLiz/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaOLiz/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E791F000FF;
	Tue, 29 Sep 2026 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687691;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SaOLiz/P4QD/1jWp3xRrQOu8XJphhx/BdMpkQNQOX3+mkiZkQg4BkPvmvL57yXfYK
	 u2iAtsiM6mNzKOyKD4g2nd91CwQXWGXw7wVvHyH6liP/8lpgPK5O01G1uOa+pqM7Pe
	 CLt4AVcZj+eosxPCk/HYVPGlBBHiEAN7+WtPclD499vr18ETJL26iGeNp/qdE1zTYy
	 iFxJDkMq46ZzowfTy9gdCKVh1IgXxzL713ZAVGcdJCiyCYTDtt97K96u4hCnT+nmDk
	 9L2Yr1rxi+NfDKl/h0Y6q82Yz+Q1psVKtr6wcobB88D/cEjKsV/iKN8B/xykxlep1s
	 Mu+fE7ApLYg9A==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
Date: Tue, 29 Sep 2026 13:14:50 +0000
Message-ID: <179068769042.31693.17699965363723906103@kernel.org>
In-Reply-To: 
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
References: 
 <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
