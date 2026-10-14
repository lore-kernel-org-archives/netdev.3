Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A42FBE;
	Wed, 14 Oct 2026 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937450; cv=none; b=T8+bN3/KFPT3bPkD2G6V7zm2UIfJiayVTMfAmnMBvaQc5YiKXCasGHDpoP1wrandfGvgpS6lZWv1UW3Touq0F2eBS+Q44wX1MCgXR1flwLge4YIuOLZcsrvcpiQi1ci2yFtf5p5nFN3UtDtu44KMu8427GCzKjLxaF2JaxwDApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937450; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDCL6WuH/euTBdR7woKccaU5wxXWkZHObvPXQoPRMh70/73aSsxcDBBpKX5LHe3MIoOllnBSQCOAZZzih+I4Y255mEOvfx6fNjiv+a68YddOdCuqbntafo1RLMaWv/XrlBB9osbXloW80OH7bG+chCfEvmdVc6seTUvnjXepYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdBeTzoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdBeTzoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1931F000FF;
	Wed, 14 Oct 2026 00:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791937448;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdBeTzoGP+6lFJrZ+Geh0DuT2zsgY9n5Ajbs1n7R2VgLVcmrix0rRTfjVfN4qtKpT
	 Vf74xM2T28rkHNtSZjHGcSwLzObmeHEnHx/2lDUR1Rij/EO4g23APwrcaLjxTlAipN
	 yPb9xhF2Xh8Sm25SPkv95yp6K1+HbvAQkt2YOAynydfOFixljPaTh+wkMWSA0fRL3Z
	 NXI4GuQY3If4TSQLAMm4L3PAp1sFXvzGHfNv6JAtlIMNHPSnyvwRGK02zABw51QHLK
	 iXTG5rhbB2HQiFE/2Xt3La/euBX5ZW4CFT7ljKrAuQu3+pLQF1AdpEVAgN2cWqt7fZ
	 bSTbb4DWA3jzQ==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: don't process RX with a zero NAPI budget
Date: Wed, 14 Oct 2026 00:24:07 +0000
Message-ID: <179193744747.160550.5149195491197564430@kernel.org>
In-Reply-To: <20261014001912.141532-1-rosenp@gmail.com>
References: <20261014001912.141532-1-rosenp@gmail.com>
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
