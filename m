Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF433624AB;
	Wed, 30 Sep 2026 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739584; cv=none; b=piA4WYgnwtmLp6UqxjmtFA92S+ZwKNYzgD25pV2IQA56pn9as9bLAS8AL9KAuOuT3mDjNFQ7HnHyuoeYxBmChBTPyFc4i8R+f0LSFznRnRimIbJwbvsLO2heyHG31ssI4seA6peURGFHtse2ykrVKC7yVinh47A1nV7V+tMPEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739584; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fS/Hecgj2EH6trJwSQfbNQ6nqStEZN7bjQ4OoYA98/3Lf6pC82jiRlQR+6Qh+7u6hVBx41fl0gWEVVqnFWPhC2gD2Ykt6eDLIMe+n7eWH19dTLGy78Oai32kH9/F7+QbT4uhLgDlaZxHXcaAbI+HPXuleHoNN2gtm7KojYyWma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdwryBlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdwryBlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420F21F000FF;
	Wed, 30 Sep 2026 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790739582;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdwryBlgok4SCxcphBAf3luTsYdrcAHZHDHZlS9LGLA8mgSfGdmUSYsmfgKWl+b4N
	 I5Bdw0hdFTAVdRN3mlePXqLqOzpdqFWUannm1RanVa/AXOVg41LUxf8AXiyf/7bT1Q
	 TvqZrSN4UktGEEfGcb4oj/3r82kwhPiD4n7vCPE/E6HoGimZDiX0+FPQodujmbAl1J
	 qVsBFRnBfT/UKpSs9ZTkY1RHLCbJgrcA0iTNwMAYNEuM/+HDjrPlHtXjeQD+A919J9
	 H43foJHfw3FDLVUyEYMzuqB2geENMatnXXtbjLNc+riAzvbjO46YLjBFN2beWb7MtE
	 Woa/sAr6I79LA==
From: netdev-bot+sinfo@kernel.org
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] net: dsa: push hwaccel VLAN tag into payload in
 dsa_user_xmit()
Date: Wed, 30 Sep 2026 03:39:41 +0000
Message-ID: <179073958170.31693.9874606328740414287@kernel.org>
In-Reply-To: <20260930033239.57093-1-singh.amitesh@gmail.com>
References: <20260930033239.57093-1-singh.amitesh@gmail.com>
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
