Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993E522EFD;
	Tue, 29 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685298; cv=none; b=mJT6b8n2nIBRkvmTfScstYjtlkv04csh4rOCuhlIESDh7eD3GEjmYFkEDxe1/M+zwJuF1vIWzgan6xeVsy91MQ2mh+xVw6408UUkK5lqwF4v7KitVEKjEbWJGDEbdyCMi82GfZOK/0fvFPa98fOHtxRqeax+RUNMbEa0nFkek7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685298; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OOvtkMg6NDwjFGJtHRViatQUhiYKZLuhh+DBHlmHoYirMHtOMyUFsGjUO8I8xklH1cvJccl+hVP0b9YrAjb0iZUnVN+OU2ndj561O73cg67GylWx1yhD4vieSPo58VoSUiDDi2LzPj5r6Ma+u3OaXVEW1w6zOYjhyyzVpm5gJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCY7iyvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCY7iyvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0CA1F000FF;
	Tue, 29 Sep 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685297;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCY7iyvEndClxYVNSOfvofhJ13wixKKmNTn9iQbVmfC6mX9Pc0Yf0io2RRDUtd+hz
	 NebDQinSDEXLRK2dmF4BO/dqZQDv3Mj6MXTfUfYBcT8C8g2u5v2sjIAQ2++LaV70U8
	 gMRuEEkkVDApygS7jHuKbdkb17LRgahgHkj6HXRqx4/gBKzwdur001SCLTeA+6gKvl
	 Oi2Au22EWzBf51csipP5AZ/fC/CG4/nOBgtImYZ8DF5YgnpgT+tiOyDWvLfuJRCB5L
	 hl12RwbNv2pWGTnY8xpRV4Tix+/ciBAbTUNC+yI+XRZoqacsDEx/+//jqY0dDefxM+
	 Oa+DuROgyOKIg==
From: netdev-bot+sinfo@kernel.org
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: stmmac: Disable unsolicited checksum insertion for AF_XDP TX
Date: Tue, 29 Sep 2026 12:34:56 +0000
Message-ID: <179068529630.31693.11109741808641823424@kernel.org>
In-Reply-To: <20260929121032.20835-1-jszhang@kernel.org>
References: <20260929121032.20835-1-jszhang@kernel.org>
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
