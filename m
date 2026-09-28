Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C145382F1F;
	Mon, 28 Sep 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619605; cv=none; b=L9AbvAZ1O2EbM6dEk90lneumD2NO8FB+XdITlR8Cjbhs4qSz3BNswvlbmXohVYiANovSKbl6C/BZVzUospsgbO1sNMhzQ8lx5BeAf6H7VDw+fWLV0t60lnBebJCKSRBYSgGmG/l8s+8tspZwgGaP3IhKBugevPBXM1V1U66eL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619605; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ci8rH4ixfgYc52Spdqe0UZpug/5BAiyCyZrH7GzbX4ysQywhp8bfFbn6SFVxKsMMOFhVLd17y3U9NEz9aznGDOpkIOhY1zfeUuv+jfflV00kE0+I9YWe0sLemtKvxL3ZHkRyTS8RB9v/TG3c2RHfqExhGFyLEbi6rxN8PVj1Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFKa5NrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFKa5NrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014251F000FF;
	Mon, 28 Sep 2026 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790619604;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFKa5NrY9wdYgtAaZJ/hKxsL2vH+Gluacpa/+IbMQj1swbywMvwtoM9IpYQS71CdI
	 xIP6Jjq+g0ELAUqBwVTPNQdoVhRIO/k8qqgH0cpmMmqslBHwnoRTSTlVDuD0XqSZvR
	 nzJbIG7uoMa4uMThKxrzj2TYL+wRKuVjbtGckYQGJ5Ek0D2cqm++YuulkamxnWy4ph
	 WFcsrK+7DRmNHkuF2VCFKfGwnGiAyjPnTA5E7DVdPQ+M+jEKBcqaRZyYDTGHK6fxE8
	 zGtmhetFpfs+n8h/fVnldHvSc8q98plC+W9/hNzKipfkqW6mDxjdxJoT2FDOdcmjZf
	 xH0rJpQR9yyMg==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header
 in amt_parse_type()
Date: Mon, 28 Sep 2026 18:20:03 +0000
Message-ID: <179061960357.31693.937915571809434718@kernel.org>
In-Reply-To: <20260928181557.85796-1-omar@blockcast.net>
References: <20260928181557.85796-1-omar@blockcast.net>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
