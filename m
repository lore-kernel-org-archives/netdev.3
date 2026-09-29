Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBC265621
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644736; cv=none; b=ONUKmjy9eQUjQeAAOlnGWEFaAVltJXSjHKE0jXD0a3h9DtAEqR01putyeEOu5OA9d9A8r+gtTkyXnjUs5Nx8Pa8sbzcELngolIJ334U/PhnOn6xJfXIloM0Tzm0u0b02E5ZBFWu1BUa1HgLoF1lELERh1+Lj50mJC/BujqVQKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644736; c=relaxed/simple;
	bh=5M0xIXhEvWP3kL75d0cEOdbsBIdYagM6gsnJA5+Zkig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfbVmT+zZGhOfVUXcIr8HpUgZFBkI++oqcd8l0JJVjU1X5VZgu0wUJ0zmOlyM+p92dsarxAPXApz/iVqjabmC7p4Q2P3hrsQDNK29Rd+yqJqJn886C7/mTNCb1OcvITb2avlxHnvJGi4FcA6dtTakteMUfmu4ZpbStSOr7OTFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa6672t5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa6672t5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73061F00899;
	Tue, 29 Sep 2026 01:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644735;
	bh=IFNTTg6J1zQ2IzlB4vH1Uc9ety2ixf0jz9nORFvYBhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oa6672t5/BfBfTrC5Z8VDtlsKdDlwGVtU38lPvT8Atoja6PVLenquY5a2osVrLHDJ
	 L6HR2ktqg/4ITKcgaNXseN55ms94N3vr9PjR9XRp2xE1h7yMC1ihHwgEHQgkqNovBj
	 Yx9MBSPNkrbZ68cwZZVJKV7XbPqjDIXadYcOcS5tA5A7jbaxLa5aK8IMWqc0pwvzvS
	 NoqSMKm5F+AqojQ76SJgoytTLZw96rspeFrPmE1mDeBZj+1hYD1pqYYMtTIGWR/HU+
	 VfMG6ATS55Wz8XlZ//uaDVQ1n+ip3FD7qxGykDpSx7Mh8RAV9GIMr2iLAy2MIvNYfi
	 X1l+t1GRspfnQ==
Date: Mon, 28 Sep 2026 18:18:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/9] tcp: avoid struct socket cache line
 miss in tcp_check_space()
Message-ID: <20260928181854.0b520fcf@kernel.org>
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
References: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 13:47:20 +0000 Eric Dumazet wrote:
> tcp_check_space() is called on every incoming ACK and every transmitted
> packet, and tests SOCK_NOSPACE in sk->sk_socket->flags.  Because struct
> socket lives in its own cache line and the TCP fast paths do not touch
> it for anything else, that test pulls in an extra cache line that is
> cold when the working set of active sockets is large.
> 
> This series mirrors SOCK_NOSPACE into a new u8 field, tp->tcp_nospace,
> placed right after tp->chrono_type in the tcp_sock_write_tx cache line
> group (fitting in an existing 3-byte hole before chrono_start, so no
> other field moves and sizeof(struct tcp_sock) is unchanged).  Both the
> transmit and ACK fast paths already touch that cache line, making the
> fast-path test in tcp_check_space() free of extra cache misses while
> keeping __tcp_check_space() authoritative on SOCK_NOSPACE.

Please resend this and CC the maintainers of the code we're about 
to change.
-- 
pw-bot: cr
