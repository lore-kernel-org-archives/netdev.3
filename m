Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22E38B12F;
	Fri, 16 Oct 2026 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124097; cv=none; b=oSkJSrux4imUrsVJWIL5zWha8eg/aJh/ipZMdQhu2FRqyiABBxRyN4PrtmYtBXYHMzE2jDkCBGy53oatksvE2vdjU9ma4vYdSJSyrzCCu1si2nmZdYRe/iCEZHReFMdbn2tVdLGqjP4ixIvWg5NSCjhgkfdrUYGWqbeO3DhVJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124097; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSLFk9hQ/oIfjJTfzoKGBCLUgtIMXUgsmXmWvF0Fmo7uC8nBCpM+tNdl9FTpHKEBIRJAGMDrDWidQlMgDQen026EoSMO41Hj78u0y0rWBkmfbzLCF69+3sXNSVgaOsSrX6qz0qgi3Ff+/eaOG08BnlStRLr/upcuYOZTjkspVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDKzJwlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDKzJwlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC11F000C4;
	Fri, 16 Oct 2026 04:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792124095;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDKzJwlm8kfWLQ3R+EOWe8r0DtoHGrtMg0/8E3L3Z6SQmxl6F40vaQ48ShcTFCOFG
	 tCcChcs9WE7Psnxk6HPAJ5ZaVAbkZ4GyXaTUZNLWK9y4oASTlB5PJcMO5cok9pIM8K
	 n0iGbgdFl6jILTqTt/FRW1BPiqnlCap3e8he4stKnRrTK2RE4F18LDhUKfLCztrRYd
	 6+NO59oaT4XWZH0dKjqI8XYAVTj5LRDjhxIHJeFRcWF2+uuYybrIIhMyAzTd23eJMO
	 4dF45T0dpKmi4bn0iGVXynEjlJk83fobdkhAezWQJv8F/j8en+7eLOjGdBBCnbdJrA
	 nkt4vG1gpclzQ==
From: netdev-bot+sinfo@kernel.org
To: Liu Chao <liuc63@xiaopeng.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: ipconfig: fix OOB read in DHCP option parsing
Date: Fri, 16 Oct 2026 04:14:54 +0000
Message-ID: <179212409440.408196.7891381020957974753@kernel.org>
In-Reply-To: <20261016041152.2294843-1-liuc63@xiaopeng.com>
References: <20261016041152.2294843-1-liuc63@xiaopeng.com>
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
