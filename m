Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846798;
	b=4r2QqSnorMIwJesnsV91A2ZXRxpnKevzJ6ko9uUXXbjcKpABzAiQoY63bvNyk1r7RpGH
	 4BByhiGRZ2JJEYnwxarnQJu6OPgcavZRH0Y6TnP/55mTNoYfPxF7KNCRDPgM3xLqpVENJ
	 g29Z/a/GLoO8QwY6H/BQCx7xTlGGSa6+epQwFtkEBzbSWjpcnkv2FqEUb9vJbbLW5XL2c
	 WqAeH0TJSyedyAcmsuoG4BUVmjHtLEmLgjhpucQNpL9/bae1SZVhzO5tMz0IlKdSUcazq
	 0pqjEWE2i1460a0SHRbdKDxltmjgUL95+PSFvCFQ+cNtUewAtr4c86dJzOVHEk2O04A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=5em+QLHP4vjojAbWoAlHURTvOBibFzayJT4PMOrW8t+CJ8tbsuf2g8c5scdOVl7LqdP7
	 PrPD8U/BgK15jmx6Et1BiSg5K66wYEN1L432+3zz9M7EH09XUeyEbmXfNYROe+km2wXor
	 Z3ZBmlMb6CzpnuOtJh2jKsS8dchAIAC5LRwIBVMXIK/J035LcHlS/d9mMFK69bpaLKvo5
	 g3imKmb0JdqPwHt9L3gI3lazGP1G6zgMI4cq6ZsI303AquppvlDxPrdMaSqSXUjFvtWKL
	 yEBAaHV1iG7LS+tgA0gclhyRRcI5M94V8XJxHtVS4vRBN3xEk0DDcuV0UZIQh0o51fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmYTJwb7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276D606A31A;
	Sat, 24 Oct 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmYTJwb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65131F01825;
	Sat, 24 Oct 2026 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792846798;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmYTJwb7w7rRS4pYGBBRh7aNjEqprBbNUYzQhc1e3yUs4apfdrkVh53uUrbcciAwJ
	 UQSJamyCV+2oXse3n4MZIbo44wmApspYtoGQIyezup/7U+Oms5hcCrlhIQM2C3Mqpn
	 SRfBMVZKSeXA1hsxg/fy2fqPO3rdi7abIiT/3CnCYvaIEuvJy3WaM1RGfov4ADWpul
	 61cyNULoOxPLE/ZPP7IfMRWgy2SnCAfPeJzkbpRwI7KL68OPH61nSBfQAMAcASuJep
	 X4Lzw3Zq2iy+Y71Y0GVb9C5WhcMTlc8wtaJric3aMVAF32kvFnI5d4IZVsVRyXPbhZ
	 c3IONRjCijVXw==
From: netdev-bot+sinfo@kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Claude Code <noreply@anthropic.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] skbuff: keep accesses through unset transport header
 in bounds
Date: Sat, 24 Oct 2026 12:59:57 +0000
Message-ID: <179284679712.3327.6571506927008039055@kernel.org>
In-Reply-To: 
 <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
References: 
 <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
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
