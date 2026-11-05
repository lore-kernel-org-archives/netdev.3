Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897571;
	b=f5QR7FO86bfDwtVOn4/0ZHtCrMOeqIKKmHqC2KC/MzzKuv90WVGKkOy0YxZLdfU1glrJ
	 GgWQaTHkuaAfrb6lvvVLxWDJ3ob1evs7gJZLtQxR7xOrcDOw6qITy67tOWv4IQOoLDuxI
	 AgKdrZgZ7h8K2kjaoExA+ONsQA7qYQXKVV8XUGTybS9HZoNV7XrVH4RBnDpuQMzXZDiUk
	 LBRiaGlJgQI3ZhEyplt1TDPNgbay11IvX4gHht+PqC6T8R6MV9KNldpyXOUzqR6FimBUj
	 WCC4N/S+nninYJF2Skyvdxk5kyrfZqkwQ0nf5Xw/Nq7ZO7OQjDn+gfAQoexpO0tGH6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=UdyfdI6SGZqMgENgr6ZUeYV4atAIFdHQ6SNcYsQfijic3LnwpLf8lrQEg2tJ09RuPXcN
	 1yWAhvBg4lz5r4rpvmpUxVC47+p6waOBLU7KsqqvwgPpTstuQrnQ4ezBwqO9sFKh0n+ya
	 adiQTTJ6cRezPmd6SBYzHCCNQEnN3VAbMRBTjpiASKHJtHYEQYGcf60Q4ujVtGvQJIpVB
	 nHDa0x1ec+w2pW7ChMgMelEHysEm5UIAt9hg97XP9w8z/FOx41xSMKfY2vpJdwslZc+nL
	 ScGrfZlDS8UpnH8TK2bpf1r48ukYxVqb9tT2x0GbpWUbMueJtOheqEnln5i5pxTQiVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfvaeL+6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AD606A335
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfvaeL+6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283421F00A1B;
	Thu,  5 Nov 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897570;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfvaeL+65A9o7CggaSQZ6f8GwVE1xnOo+1BrnUjBWKga98Nr+G9dkNqkFy4mlJYNM
	 FmJmd+ltqGdDJTjKXj81iZdNCt8yR3KX+8LPxtZC/w94SJJ4eJ/BmmwpkPtsqmivun
	 puN/c338qvTiMyQK/ow3w/K/zwvMb7ueYeCQ4xF+LATScjZ9Be9d96rcUSy0XZgNBz
	 IE3ANZ8n/5b73wqXpuI3uJWxg4VxdJ/ZCFxw8LacHIHWSIhfmOdc3tUYgCeEbvFTvp
	 IdApPyIsz6CWeiQcF2n4Xm5vUuZYU6pnKUdIkSid6MZTEe519JNXwJU0XaGcc7ce/q
	 BhV6qai6G+y6A==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net] tcp: do not resurrect a former listener with
 SO_ATTACH_REUSEPORT_[CE]BPF
Date: Thu, 05 Nov 2026 16:52:49 +0000
Message-ID: <179389756967.488859.18255444203780437873@kernel.org>
In-Reply-To: <20261105164830.1682714-1-edumazet@kernel.org>
References: <20261105164830.1682714-1-edumazet@kernel.org>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
