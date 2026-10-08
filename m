Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0993644C4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437753; cv=none; b=Za6ryZPRoQtl3ahPXQx6jCbrVjPEZViL5mjywdhTXDFWWD65fDh4WnQer3x0D4HWUfp3/qAxY1qelE49PqvCTWcbHknNrt/VN1YK1qiIDmi/a6kVc3N5kQINIXwiCIImQj/1zAthR7N6cZwQoZriBORIPiA+J88j0u6rXeoPQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437753; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akd3lARkDmwePIZlrtVrbo5vD7kBo8wbd3zuds18rg0kyxla7ysM2AsOaE491vm8D5Cn8zYsWgXcfOPii7BXdCbzzo9Fv3/v3ux5V1xVHHlwHUxZfuCejsL/BfR6TQaoCCn9/qrCjMLhvkfbQBSVwas/K0vxKqUHVmbYs/xvJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfWuOhrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfWuOhrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDCC1F000FF;
	Thu,  8 Oct 2026 05:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791437752;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfWuOhrp92jq2hHr5zjQbrhBCDzszLSECaZ1IeJxJLO/npUeQa/lGZrdOrufpRLhq
	 JW3/UQbk2gFULZOqXotQ0KAe89W1HRpXuh3yrzgWXj8SybWjHPS0O6zhkkFAtevnNf
	 84/9QeCFR3Oe6whEV9t0mhnGuOOQR9QAIy2stQm6kwBf/zPMOA3OI5HF7FQ3Br8tm2
	 y34I0X1/fGafLXwfS1CeY88x9PDutIqq4ACAM/rbbW1SNMkxYAN3Ocy36Him6DNzXS
	 oftA8S0Gzv+LMjS2xbc0Fo123XXsijI8mxI15AsI/3VsRoyZBvK5e7oOUFFE067APm
	 0VYhuMDzn5LAw==
From: netdev-bot+sinfo@kernel.org
To: Zihan Xi <zihanx@nebusec.ai>
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Subject: Re: [PATCH net v8 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Thu, 08 Oct 2026 05:35:51 +0000
Message-ID: <179143775146.2527009.3109321224299351978@kernel.org>
In-Reply-To: <cover.1791428529.git.zihanx@nebusec.ai>
References: <cover.1791428529.git.zihanx@nebusec.ai>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
