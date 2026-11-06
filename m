Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997145;
	b=AfyVvt9g16+k2kXiltuUV4KFv52Auod4rEbb0yWEJgvkY/OMxoO5tELBnVb1cF0Makht
	 Ezd1xXxc72SKR4lidlIPVxbpCR7VZ23l3uM0FnUg49ZlPDzR9i+TC4NOa4EgNmvp6jNje
	 eOQafJFA4LbVGne913GvV+jEyrILvkMoBDVwFY6vOjrRrLcjcoKjEbTl6EHZC0kOzCqjI
	 xdF1icDzp5UXmJFlycZMTJtF3j7wSFpyCqNcZWdI6+8tE5HyVTpRS75Xsk50rY4nNjbqm
	 p+fCcK74GFPBNbzYq3cX/xiVd971u885jT8Yos5AqZYW32P1H6H/VwM5hUuXsTrNFLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=fyqezZdzG1aFem7Bek1is6aR6GTMR2cWu8NupY+s2qv2jVRs97sF5Z4/qjFk7evNkra+
	 lwdOG3B7CtQmxDz7P1OuudI+l06zq1G0uVYAw2nNUZvM8smJg2kWc4d7L7FnAttQRN+0G
	 jy/lMYt4WeXpLzsEHmIZw6MBCDBdv8HUd8GmakZvruUclT/yxsDrmHjyoH9YU9kp1GyS4
	 hxS3i/MPDx37G3a3pnY0bTwRulgAwLvIjEIoCFdI3SDgDd1Rn7RxGZ1SBWRf4yo5wWGxM
	 regamaMupxRZ5UWEXy1CRW1PrRXpvN9b2rTuwypxqWmsAiPN4BGNHAb1tbscg+D5XbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H6UlpI/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0077606A326;
	Fri,  6 Nov 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6UlpI/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0339F1F008A1;
	Fri,  6 Nov 2026 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997144;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6UlpI/zsdQgmwz4ga+Nlz6rvJk47AKnH6EFRT/MBA5lAO1GWXAob69Iz19KY/xG2
	 pVriwdQ0Fy+lQ9eXrQW7HEC5v+1iGBauQLR9eiYpGDMusDYk6itf5oGyUefPESxYkL
	 bCOzuAfIgahIzjl4PQ8O+3qJlzVbpbIm7vx48KAuc388mXWnclHjMkzo9xnbU5X/bW
	 zqLd+qzduUKjVglDpfzEeTPMCifuBtLhvFf1LCf/TztDtzzN9SEdQnM+A6pnydUTBq
	 vofqFxpbc/U1MNaZobjOz0Kpn77N3Qw8k0KsyMOSnM4MkgtTJBfIU2R60DBatuw9R/
	 uRjhsiPTC4edw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Fri, 06 Nov 2026 20:32:23 +0000
Message-ID: <179399714352.488859.10880078884152350202@kernel.org>
In-Reply-To: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261106202910.723098-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
