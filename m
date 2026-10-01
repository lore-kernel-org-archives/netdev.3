Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014ED432E95
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827981; cv=none; b=GEcPJpwkNPr7kfZZJUUSgtbb7477HOWgIAzapeTfmRqPr51VXVUfM46EpH8ptFP6sjsxVFKQA+TwFhNsxf4ZwnEB6Ay+y0ep6JALUbFMiRaqVIBhX5u5bKMBeZ0D79J7A/OxoY0fajfMY/Z9aw+tTGxWj+RA8Yw+kCRQFPCAVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827981; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtWwkqP/kJvWiGgK6/AodQoVHzZI43F7PkTZfCNQgUxa4lkMV00PHfl+pkFsjMcH66wHIFUtyUcSdYTgmndKChtp0RPMeyWVy/rQ2FeGnk6osl1K6beXcreHiXN/jR9+jXznXUg55E2RgsE8AYybpZlZN8hx0MK/RYQbxTo6T3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcFG0Cwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcFG0Cwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A081F0089B;
	Thu,  1 Oct 2026 04:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790827979;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcFG0Cwqmnc5kO+Ob37GXSkROkBoqftjQhbxHgtKwwifpRTViJZ3Li8BAKiGoO3f7
	 57vPD/7pc6ngYPdpzvjHv6ThAxcDrPBukL4Rl3Ysq4/IE1ECzuHRg+ryb95hPu3Edd
	 8IdDm6PKuvE7hJMO2HJIe143jA2JQIti6Dg9Hgjmfh3iQEfSAjhbeJe+NlJX01b5az
	 dTzk8ubq3FwFc4Bv5xq6DDca9+QhmvI5+S2b1dIylidCNVOnlYpO+r3YECFsuNvz9B
	 dJZrQzPwXFuicUtcAe5cgJqFIrbFArOTpn21a+/NCD8LItE+Sm7xLYYr79X7KVQnxn
	 QKQujhqW/qpiA==
From: netdev-bot+sinfo@kernel.org
To: quantumvoid <quantumvoid0@proton.me>
Cc: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: 
 Re: [PATCH] wireguard: allowedips: prevent stack overflow without DEBUG
Date: Thu, 01 Oct 2026 04:12:58 +0000
Message-ID: <179082797895.31693.1113127384991730242@kernel.org>
In-Reply-To: =?utf-8?q?=3CTaZxFNfdnpo-3szeC-LoWZBxj-6XGhXkdEqnQi6yyaOHXp8cw4?=
 =?utf-8?q?Xtksw07sYrIpludwvJQrukFoCGw3r9rXDcInkdB5QD2EswKPNsXMU3qMQ=3D=40pr?=
 =?utf-8?q?oton=2Eme=3E?=
References: =?utf-8?q?=3CTaZxFNfdnpo-3szeC-LoWZBxj-6XGhXkdEqnQi6yyaOHXp8cw4X?=
 =?utf-8?q?tksw07sYrIpludwvJQrukFoCGw3r9rXDcInkdB5QD2EswKPNsXMU3qMQ=3D=40pro?=
 =?utf-8?q?ton=2Eme=3E?=
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
