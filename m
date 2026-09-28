Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8D4D1784;
	Mon, 28 Sep 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603164; cv=none; b=fxXnLSVISBrED3VEVTol+LiGv+APNTYd4Ee+IvwU+xh0tcA5yFDIpd/1EfhlAH3K2JJHGC1JYUl+aSrF5uIIlFd86QyflvTNNXygFFrwtaWxqgzzoSkAbkKMz+Ty8lZsACarEDi0Ii7SnOGqQXpiRKe3BFAlZL0RRaTiOJqMpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603164; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arTlNodemgJvDszbBz+tMXREtqUQRf1Aj9NpGb0DfqfUT4jLk0bioe8LSBxDVEl71G0I9PKYKGNDzhBkensgS26pE8g527wp93QXth6fdfvRQAMlPmWUe4YbirRn8MBCdEXPdlIF6/aMGqaNZhFKqTAZbZKVAjB2YnwA85YUARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCh1KKb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCh1KKb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C411F000FF;
	Mon, 28 Sep 2026 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603162;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCh1KKb4QcLoxQZQHTBmzV3EDqDB5dWr7P6aa/f8YqTLY77ZkNom3ObgPlGG6PGp6
	 MN6pGhAJrS70mlLKJYXavOWBRIouS22Uez2llczbC+gppcz6Htczhv27ML5jCiqIA6
	 38mdAKbyBBChj0nm+vBZV6tIif8aRcIkKslvSEWCLhtLBCtTwuY/ulqpNiKn/3zjnr
	 oSMN/l2q8C9pOJHcSz8AqGfg528rFP8tMH4I/2ERt609XmFT9iIVpP+9xx8+fPqUMP
	 Znpj5C8wTQ8gKrFYXucCyLkk6Rre/ox7pnbPp4/01pbid/rS6agf0j8r17ZwYhECpv
	 3pucFJZ5gQnIQ==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: 
 Re: [PATCH net] net: octeontx2-af: quiesce devlink health work on teardown
Date: Mon, 28 Sep 2026 13:46:01 +0000
Message-ID: <179060316141.31693.9693184518346169092@kernel.org>
In-Reply-To: <20260928134129.145-1-getshell@seu.edu.cn>
References: <20260928134129.145-1-getshell@seu.edu.cn>
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
