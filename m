Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B454B1C6
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989017; cv=none; b=p+ScCSqReV6KnqKC29CHcGaQZiSM9u0Oyyy+fxLsC4ub9bI1MY0C8DbfgcSdrJUNDhYU5ba69u+d1Wv1joc0K+EK5L9U5Ycm/Dcs7ZstmHL42Yvv9fyJW2kR2kHHHB/z3h9SiAC9lORPOuZvMC8CKIaFZS9Mvly4e+t9S3web8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989017; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VL7qbgpimvGbJvQr9wgjfOgCFMSOSSUzxEVmwzq9RM2t3VDeSI0t0oZimVGaFMTEqt9XRYj235kkt7uPK/8xIWRUnRP05OdFuJDBU2PAYKPa/1I/Sk88WMSkOv1cAxtix/W5jgJi1jSJK8tUgseSkYO2BgUSkI/KsJNGRIvJDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHrhcy8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHrhcy8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB121F000C4;
	Wed, 14 Oct 2026 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989014;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHrhcy8ffdbYgPUA1irFHbjbLKA2t3BqDpdZtRRwtZxbyIPq2WPsWRcx1rBQTc3kP
	 MvTB6DG3iaLmB0ns3OWtCOpeCog3X2GB0sVbDz8PQ8tO6Lh6ZqlyF+2AKMUweN7rXb
	 3HGS8aLLgu2xocRYC9nE415FETFzTHa7ZncxGxoPam98gzZozUbZmIU7Y4biC1yvKp
	 SyGVNrfj1RISdLK7OPakZ52rUNdpXNJgMJJswbFMQt+u2LCWs1jR/B6pGjZd1c7inZ
	 oyNwuhU5hoJjvIkqPUecYFRN404k7CHGIf8HN4jwua9IiCgB3wnkuPW08svTYPCLLv
	 ow6Zs469ttjsA==
From: netdev-bot+sinfo@kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net v4] team: reject CAN, IEEE 802.15.4 and 6LoWPAN
 devices in team_port_add
Date: Wed, 14 Oct 2026 14:43:33 +0000
Message-ID: <179198901397.399038.11366807934508541241@kernel.org>
In-Reply-To: <20261014143309.284388-1-socketcan@hartkopp.net>
References: <20261014143309.284388-1-socketcan@hartkopp.net>
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
