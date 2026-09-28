Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847E4D1781;
	Mon, 28 Sep 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603172; cv=none; b=oqj0P3xfnBcnH67q141DfBQWnadSKWMIXFYXpOyjYL3UIeJRxrIWY1FVAmgVd+a1H4wVWexB7pQU0W44E+vyBU+5kgkQSvGVTxlA5pdV0rRCdbEr3BflRAFv76PRNdIRD3Q3bdVZ/lFpn1B7pWXjEBXfk9OEL5NpcWgMfgZnJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603172; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFnFjF0JnJMlqmQLezfN4/WzrYsQ+9dnv0I0h/hzWMRiKnxNf0GrBL1aTBrdyzhuoa+txsIg1p0JfZEka46JqaGG/CtO0cibgPSb9uCDYQJtOREADlqGfCLr/iWLSqZtNOrwR77LcO3/OFtSAb6JjttsXiOO8/goqHvlo8VFO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPzT9Olp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPzT9Olp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87EF1F000FF;
	Mon, 28 Sep 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603171;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPzT9OlpZ/+lk/Ptrvbc/ffrAEOrz6tXgWiCXvYl0+V+7T3WNrnnChIiWf7fHdaqG
	 UUz1a7jvGLE9aroeB7aq+FU/PJn59yILXFajNBPHF4oz5+2m1llU+rbnXoxqxPjbgV
	 1ohCbaCImEGz4fq63Um7nC4e69jjIkZEtjxOUYYy6zsz6XmFZMzkjWuWc40J1Im/oK
	 6XMiDyk4wQpfil2K5S4ZNDeDFm4LQ1Yg5T9N5OHRl6+JZvIqh0LXD8zK9628uaEsEI
	 rY5ook47DQaeHnBzlp3R3Ax+sYZ2ZlJcLZ6TllddVxTN/zKt+S3CQh4dYLH8Lt3Zpz
	 Lw8+SNto8khKA==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: 
 Re: [PATCH net] net: plip: quiesce private work when stopping the interface
Date: Mon, 28 Sep 2026 13:46:10 +0000
Message-ID: <179060317028.31693.7593520343375109759@kernel.org>
In-Reply-To: <20260928134136.1213-1-getshell@seu.edu.cn>
References: <20260928134136.1213-1-getshell@seu.edu.cn>
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
