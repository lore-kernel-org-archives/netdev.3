Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9D36B938
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478525; cv=none; b=AWYi1vVgtJwHHS7s0sHUDuRFYwKJfQhkCYsBDwoXoOr4LlTU/pmKn1KPDs33lUP/UJTbbpAwFYRSHqtqVBkGIrnUcrdPTrY5NDYx1sehN6su8dblLIxlUHBWSWcCogWciPFGKd7Mi/rA3c8BPwszXERym3Y/Fx9lWEYZOMl+CgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478525; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdD2PsKcPO7Nt3A0Kr8ZkPqbIVDLsaYF1DlxhQkCICEIr7TOqH3i1Xi+s6ivoLjaAhXjgM7wGCSp3SPCAxxLAokg8F0ZWB91ptegeyjaHkW+60pnprWSL1enE8PkjWBH0gpndmOYJik4i07ufvbqV5kOsub0iWWFz2LZk/l4WTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxapToAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxapToAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDED1F000FF;
	Thu,  8 Oct 2026 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791478524;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxapToASquyWRY+rTU5Gomq/bLuM9jZSAFY4uB86vLOTITCZft0or2RWgfoRgMV9m
	 h1gybCOsZ6DCnDvY2nNiOJ1dm1jMBXKqSYvlfsTeQx/nNAp9nfEZx4osDxmSMa7edz
	 h4UvkrsGsryMvmNS5tnHVpP2XE7XLq84Q7UPFWICamLZmKfBF/poBIaiSIKBDInZIR
	 yYvCKlJIz3K7V2qWXcM/nVeoRD3sP8wFrqHybVZvVvcTuydB5zLt89Pb1wYtrqWbEa
	 syAzj9F2mCQWMuj6EDGYMHWW7hsF3Z6o/hpClrzVAVPk5FWjzCqShskjMFFU5OruDC
	 pGssRPRl6VlKg==
From: netdev-bot+sinfo@kernel.org
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, joe@wand.net.nz, ast@kernel.org, kafai@fb.com,
 vega@nebusec.ai, fmancera@suse.de, petalzu987@gmail.com
Subject: Re: [PATCH net v3 0/1] ipv6: defrag: orphan skb before queuing
Date: Thu, 08 Oct 2026 16:55:23 +0000
Message-ID: <179147852303.2527009.9777399974849684897@kernel.org>
In-Reply-To: <cover.1791008591.git.petalzu987@gmail.com>
References: <cover.1791008591.git.petalzu987@gmail.com>
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
