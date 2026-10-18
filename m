Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10723DB33F;
	Sun, 18 Oct 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365510; cv=none; b=ATtTPcNhqScq86aWKETS75Im2dvG1GzEMMoaJY4QG4T2aohlA5jXSPEzJsXA7Cq42r7Qyno/CNJvg6LWNFZufhgNxMWS5r0HPxI+mtZx59TEhFUCUfkDuAcbdGs74+sen9pYTNW0g8xJK0NW5ShCT3auurqrXqucgKVUHgsLbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365510; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWree8Mj/rFmKriQYaCM0mDjJ2KCZhE3Y5D2CF3PJjXKV7/lw837nd/sWiI6DLs+ud6uBSIOs86jjl9R5eBNv9y2+TtVJUkDJxZMOPsWJE2YXaQ2yhunlEmxmEnNBamFaeOLvacIZ9NY4HjmpsX77pe/AtaCrHZwhqAnBEHExls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBJ9+S49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBJ9+S49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CBE1F000C4;
	Sun, 18 Oct 2026 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792365509;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TBJ9+S49PC1xLpxMAM7add17/ZqegNnZVuugKzzTGx1eYHFmXA91cRCm3ginTJOPL
	 GyUgAzcED54XrNGfgfvAp0jKmERyqq509+fnmQpSwfFXMrrWy0H9GvquuNvZ/oO44w
	 zyGlIbqx5YxVJjERXmbdZOLSr2pzdKwlKLC2YsluQQ+OtZUTkcMDry5ijQ2J1LiYLn
	 tydraczmOUeNt0CbZPgMSRemPcWkjAdbga/mEJqSi6mmio0L7JDmh5ofa8kxkI+oAo
	 VfQjdE2Ey5qxDYX8KQa0HHnOvfpq7pUaaiLeSQBLOzU+LRwonYA0e03oYDrMskceFG
	 W6MEnrKOyoRLQ==
From: netdev-bot+sinfo@kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: bgmac: fix TX DMA unmapping on fragment mapping failure
Date: Sun, 18 Oct 2026 23:18:28 +0000
Message-ID: <179236550812.3290.9443229332836486177@kernel.org>
In-Reply-To: <20261018231348.36884-1-rosenp@gmail.com>
References: <20261018231348.36884-1-rosenp@gmail.com>
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
