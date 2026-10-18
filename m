Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1E336884;
	Sun, 18 Oct 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792314825; cv=none; b=DImwBZoXT++gryhArR4TXQidmoRSeqHfVCGTbY3c38gSGPIPumEEoAhnAWuSx3aFAZ8MyzB2lbqsNjL4ZL4L/E91wSKiP/feYL745KacFkg3SsMoIOmXJR1UsCo2wbR4AuPG/odKz/pgZEinJ0IixwOx+7JoRsCDDLUwz1pgtKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792314825; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwccVs0JYlLwChcXsKNcQkxJkp8y72iJlLc5DXSH+EbiIDL0/eTp6vdR2S0bHOQCFpdGN49jKSnw17n4lDLCMyy/gwxX+cZKsNrKSrUCv/yHAHvQoegxNeDo+h9XxEHNCK8eH+oxcjKAfrLaI0yuE6WPWKXYEhQGu0CjFCTmDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcC/CRMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcC/CRMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9401F000C4;
	Sun, 18 Oct 2026 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792314823;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YcC/CRMlbdrNoBOsxWMROWN7nQZulnTydm8z3uPTfzRVyF30s6D5C1OtQQQip/Alt
	 Jatov2JKcw/KYkBcD+kLOjaV5k/JoT4aqGVmwuNskI5K1B4LLRq7BcuvfwlN4VO8WU
	 9cR+S/RmSpHT5cZPHn6InzT6gqUKcbHM67vTukf2gRG0wmQGkVHRvjHrHYpth6CgAb
	 u2F2QqsvmW5K42FJPwg0NBrfOVraPCsFFCJvu4yVmwERmGViV3zBZ99gi181EmxGER
	 2Wu0R9bjcfUnGOVg6DnfYcmKp3PvFVtLzWN/iXd66rCrGZGwqHx5Jp0ke7/p3Nw+E0
	 toUoZb338Jsww==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] xfrm: fix vti tunnel device use-after-free
 across async crypto resumption
Date: Sun, 18 Oct 2026 09:13:42 +0000
Message-ID: <179231482261.3290.7078045556661069694@kernel.org>
In-Reply-To: <20261018090638.55686-1-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-1-q.h.hack.winter@gmail.com>
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
