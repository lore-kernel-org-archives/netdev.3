Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572935DA47
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187988; cv=none; b=f5+vJMUKvYILhIEXkFqpofFB/fnrki+MTA3qskU02zeDumdRv//fVYx/YuTsjxauMOoHuFSM8355kFsqJ4aTNROf8xGPCjhyqZf3ixBMB1erNaSq2zPe65YHmfbzH2j06lpelG3aaor0hMUBPZHgYy5vnt96yfYeUah5bYN9qJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187988; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLkrzuSeSoe5lJ0Lz4PeZh4Kw+sMsRsvnNuYfdVE8Qb4pAxM6725d/5hpwPdWFRsP6bj/bhK5CzqZr+dsQwlqr8lKI3ZBs54EsW84eZRUTXGXzQJtILd2R1ZDT19ijl2dga6sTDTp0kcotfbXiq8B7eXQG/rnWZwAEjq7eTpn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/+McXrI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/+McXrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36AE1F000FF;
	Mon,  5 Oct 2026 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187987;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/+McXrI/vIahDkaWRmWg2qkjYMubKGdTmVTplBucoCiMlW34vm5/yPlpqNu1taca
	 o9ZQLOwyC4eqOaM3s87hie7OfjgNOwFJ4/FasFjRaxnva+tcVGJ2A+PFFpJMkaO9PW
	 bkht54uJDQHXVPdGRO4WSrBWFhTs+hT9ONquY0rZ0DmPRlu3NwrldUkv17loyje0LM
	 mKr9DA0bIVXAOK4WnX2Scfg3SL8GjxRd04bDSWFcOmQY3Q8m17r4WHall+XFQFHaQW
	 /K6AoPboOG5SqmZB1euOzWpYE7bslp2V6hpoBGqQjZ3KnuAWp+pLgOrgP5z1z36Dux
	 SNzeB/XIY36zw==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Date: Mon, 05 Oct 2026 08:13:06 +0000
Message-ID: <179118798620.1402591.3969606322694204017@kernel.org>
In-Reply-To: 
 <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
References: 
 <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
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
