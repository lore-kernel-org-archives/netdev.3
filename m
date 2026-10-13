Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6973264F4;
	Tue, 13 Oct 2026 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862529; cv=none; b=W+mvoTiBSBlDB8RbWJTAbUSXECuvT4/nb+QqEn2v1NQ7qCoro4J9NMY2ilCUCvn6jyWXLk0OCxAsiDmRDLVz7lBCp4167spCADl9b/Z8qMhLvYkw0S0BqO2kKa7s/5x3j4eRgmmAH1H9QsmpNmgKwXRRFEOtu50xXGXYGC/Bzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862529; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wi+BidOtJZFnDjmKNm/ZtJuIuZeKeWi8hO1Pc45h5mjnrnGxbslAWaeOmu7FzOqeKtrCUj0Orve2JXMMIksiBWNsQPEFXhT6vdiME+ZG6WLC6XhB0begupDFPmWSK6ni3lkIpKPCcxaLKrfgRGkvzI/UomSSTTlT2+muPPjnSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZs/kjZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZs/kjZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30981F000FF;
	Tue, 13 Oct 2026 03:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791862528;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CZs/kjZ7jcoKPf+cXcBgrB8NxAisaSe9ecoO8t6iqWXhdwLveEGgvOIguo6hW0OPm
	 SNAuZg4GhTTvMH+VyZTO86Wy+yL4Yylxn+gzejLPjqn404zIuD7eMoC+UIemNNvQLr
	 yQJpQbn6uQC/6/HcRJCxsM3jyp1VWlESvBt31H6ow81d0KUcWLnvf+UoFyGYMft4fI
	 DVZrKy/rJXChGPi95bjk0Qr9vUnRJSzQbZdyS//qDeNdhkSQefmkuuZ5MM5vKcz3e7
	 kZnlebzOIEGrrfUMCKLi/soMVLS5YZ6II9csoNf2s6WD88eHev7pr4bvdbAA7GTO8k
	 h5gJN06hHtC/Q==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Date: Tue, 13 Oct 2026 03:35:27 +0000
Message-ID: <179186252726.2527009.521907325702590777@kernel.org>
In-Reply-To: <20261013033207.1684328-1-zxyan0222@gmail.com>
References: <20261013033207.1684328-1-zxyan0222@gmail.com>
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
