Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD947DF96
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937840; cv=none; b=sPqUdjhQVXfL2WAydLYtwQNwjZt64SHUfk2L4IZPnNLkSFsfL51mjsfF5pIe3mIvpr0QKCA2VSGlD2V1lnL8A0J1Z4B+yZ01EmqRoJ5RNwkdCRGEac3Lhn9HWntCi7gZlwRJJEnfC27R8ZWVM6DbNoBJJjdoUrFibWmb00TO1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937840; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jUu4fnJumu6WFZR0RgKnrFmMKCnvE2LBIP9IKpVfaj1brJkL+RmjZ97qvmpAq1iB6MSMgcnVoINaxv8COs7FutwX5c9pH1ZbV2qnhSqUELjOF/YrvzZ9Esq/keRsVwxlbhk+leDP29+/FAPIGTUx89GYFQTN+5X3yEgAV+h+CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIR15wHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIR15wHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121B1F000FF;
	Fri,  2 Oct 2026 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937838;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIR15wHiYZiY34E1o2sMCBcTHueo2onmVlE9AJyntqY9Z6GuOeV9rEeFKelWW7eoj
	 NKJIecG71cAU/Bt91bZTaLjXf2wgNNoKHQv0WyWiz295QBWNLvcyo/rDbo5Lgq1f6e
	 9uGOuVvXj+hacqpO9iobknLHQyHjPstI7NtTVttK+dVZg5yNnS3IQLMZjzMHgmuesw
	 gWO5rsZeHYcfudSNTY/uV4F422OcF03lPJQDR2MK6upAq9T4QmVG5XvhdWkD+g/EJu
	 1oiZI4bc4Q4iLnuqw+C13FXMW0BPHQ88eeOGUnE1kS+QTGvBUccwRVT+cizmXZcH1x
	 XY49Cxj7yOK/Q==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: serialize PTP timestamping configuration
 with priv->lock
Date: Fri, 02 Oct 2026 10:43:57 +0000
Message-ID: <179093783778.1402591.4305443516462782245@kernel.org>
In-Reply-To: 
 <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
References: 
 <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
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
