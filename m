Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753586;
	b=VBs4JFydJwXMbzbWv0/d2KyU1Lb3KaWyx3QWEPJ3hYErK69ewgFwHpdCEG3CbcNWXMTF
	 4M+yA86HAU8fg5E+H7d2uqhRWsAZgMBDdC8fXmD7JgpXzfiNR/UP8cUCAf+ffQxWheVV9
	 QqaWde2YTX7n52VdbabIm27Zt9Yim+IGM6Vgl8Z7ZBl8ZN8qs9WV7u9M8SV5AtjnIuXGM
	 4N3uEHjdTY2WtX3U4fs6AZMHU9QAH3lVvnCegO2YkNQnTle3qbx7JmyMsG5KOzHKNhQFk
	 SOU/eMhzUyGZNXir0V3AH6Ud53K94dJWgfQpAjKa8PPIOdqDbJpbItjOVL1AXDurPgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=l+iWzgroRtSkNG2o+6RatZ1trdsq9Jo4HoVrOf3QdUpz3c8Y9TCCx/hg8vtZP3xoZiIn
	 KwTwXDmi/hMCfzSUd+GBTLz5ShsvBSEprIGQPs0zjXbyPyhtxzieyTq2icULm4OYY39qQ
	 +9IeEByt5NkprPVbp8ljjo66p5xfyZNx4h6NdNo+RUF1IPu1iTCy+4IT5guG2Q/21AHBS
	 WiOqrQJl2wP1KWplCYHgbcxqf2JvcNRXuwQMLBlSWEOFS+ktUwd+u0VNQk96AgCKINcuy
	 YDR5E7zBHgucBxPePtP5JY3opeyRHuvShvIzbef/RpG6uycmOxqbs2Uq/4JNiJcLwow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKzGFutf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5755606A31A;
	Fri, 23 Oct 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKzGFutf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EB21F01825;
	Fri, 23 Oct 2026 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753585;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TKzGFutfO1lg/aJLhMLaUX7a9nX2D93vLj8T7SC80HN3wa86LwzMObtgQ49gk8mHc
	 g/OOtkO6XezoVHpgYI2SeGY2X5LXZrio/KuHUdp603syZ3+jZ14KgCykY50deTsdEI
	 i0lrqu+MKNKQ6J+Tb0wXwXxY4xtdJYM/75PbqzRt4ZV5mW/NAfVvfxdK0BRMMTVu47
	 t5QxlDYwTNM4WZ1s1a57fothwXAL0cwO+UTmnDeOykmfdTXaSBk4BBwoCWDoJLPg76
	 pQ0gqovNSrdnNEEW1bBMWa5bpZYWBSbhV016CFyu2d879pjOFAiMOUkXH/hPycqYl0
	 t5nyPYs/41pjA==
From: netdev-bot+sinfo@kernel.org
To: Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf messages
Date: Fri, 23 Oct 2026 11:06:24 +0000
Message-ID: <179275358416.3327.10205293492560698598@kernel.org>
In-Reply-To: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
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
