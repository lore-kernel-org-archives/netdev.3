Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD4366051;
	Thu,  1 Oct 2026 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829182; cv=none; b=KNJGHdWpE2Bq2tpvK5okWtRo2rHCTjaxb5MgOOH4QgQ6Eki0CC+EoR0ra5W80/29ANDtaj4kdiKP2cRn2kTtC37XCGrijgpnSO8i/dbF019DCxa39LPqrENSHtybgUMgL/6a9KtRnZMmciyPfw2e2yZBGIYc4HmN6VZ4ZNnbKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829182; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMxGsE/5xX9OEVvma1ZUHLESlc3ZFOYT6wNWGrOkAVwabjDY4BND0lmxaj/nPY/db1Nw/apOUrl0prSVkUaDs8XRmc0BISC8wH0EusWsAPjTZFdJLTdLxVyrPuHybhI4pCbQpLl6OAl7kdEfhm6cEpdUTDjCZu0p1eygWI4+4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVRCDdf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVRCDdf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536C71F000FF;
	Thu,  1 Oct 2026 04:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829181;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVRCDdf0/1T8kSqaKwEzdCIoYR6HU5BI7iyh2jOl+PXmpwZbt8o9DhW4p24oGXdpN
	 /PTZ+SsBkJPIsIPvDcoTwm9LfB+asS5Hkkq+HJ5ww2TizYYZW3JxVe0CpFBnmZ+N2S
	 A/WPfA1LU5Jq42mqez/7H5iC90o5GKWpWO7nRNhKIMcZDqZw16FfPEEWFd+Gcr2hdX
	 pVNKUqvOSttOHiJkesISfQ47cwgLhzDtaU91wkM1PVkjRdIaFo6iRD8IM3G21heegY
	 jhvxjJh+lFi6qCfHAMo4MfsYy4gZbU8pYYjopnmrvatStYYBV24maw5iXQNStyzunG
	 SNgp3Dt1tfiKQ==
From: netdev-bot+sinfo@kernel.org
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
Date: Thu, 01 Oct 2026 04:32:59 +0000
Message-ID: <179082917987.31693.16306963663623790870@kernel.org>
In-Reply-To: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com>
References: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com>
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
