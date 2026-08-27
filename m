Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73B299922;
	Thu, 27 Aug 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837310; cv=none; b=Mt6RT5LKrEbqourQvmlacl39gpTsSpO4MIGjrvGvxNBw3ebwMzKa5B2+W1Yz/GrLLEbEFH8Lwo8jVJ6fQ3gBAsefr9agNEudaDpGFFZHFvZ4QXef4fmJaSAHrqlbZqqa5zDoyMmRGTUpB+M9mSDSmhpREUeMjnaPnjyPmFt2BaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837310; c=relaxed/simple;
	bh=GaprarrX/Hu5FNhAbH8ouyOT7Ma8w6ym53WxEk/42ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N72lK3F2f6lDCk5LzfUfcKnFI0j+cRsLLnguaPckXremKG39g/kexCxLvbZR95ukIW+qfmeApKxYWNq/kjkdjJEXbCpVYTPm9jlJ5Q6c/lUNf0dsgTmfA0TNej0akNsYJBeIq6OfbUiumWlQf9U+I8OGzWJxo3bEL6ldHmR6bZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbZNSEOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbZNSEOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAF41F000E9;
	Thu, 27 Aug 2026 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837302;
	bh=Wfbt9FdAIskXDj0zssRilPrFLn0V1tVO14o+L9rnNos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nbZNSEOL+SKVTNrDJkClzkwQgFzbPuRQftnxOzrPG5yrzAIjCmJrbHlqkBqOHRY2n
	 KHWo7iXfbd1Om4bVehvhtWAnorazhuMddC4npXfeoykAabTAT+Z1x3CsK+eN4/93KX
	 fwAamkDqzQqdSCmsoYLNHIksJLvY3aEG0mQ9zLVCsd1ghaPbZ+E+zkuiT9Ah/q6e7k
	 qe23BgsgCpfEMnZzBt/k/cTc8nfR3BqqQ2pK7vU/RYgAE4mY3ak287cbPz5igY17Jw
	 D7hpDH/MrvidKDlpX+c3xRffmaS5K32Q5x0nuYNkZ7oWcNNISLzpfhPiJb1+R0Tktz
	 Ea13wMtUL/JPg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B52B0979E5E; Thu, 27 Aug 2026 15:28:19 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ramses de Norre via B4 Relay
 <devnull+ramses.well-founded.dev@kernel.org>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau
 <kafai@fb.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ramses de Norre <ramses@well-founded.dev>
Subject: Re: [PATCH net] wireguard: queueing: preserve tstamp_type in
 wg_reset_packet()
In-Reply-To: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>
References: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 27 Aug 2026 15:28:19 +0200
Message-ID: <87a4q74rrg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ramses de Norre via B4 Relay
<devnull+ramses.well-founded.dev@kernel.org> writes:

> From: Ramses de Norre <ramses@well-founded.dev>
>
> Sending traffic through a wireguard tunnel on a host using the fq
> qdisc fills the log with:
>
>   fq: likely mono tstamp with tstamp_type 0
>
> An skb carries a timestamp in skb->tstamp and, separately, a
> skb->tstamp_type field recording which clock that timestamp came from.
> The two have to agree.
>
> When wireguard encapsulates a packet it calls wg_reset_packet(), which
> clears the fields that must not leak from the inner packet into the
> tunnel packet. It does so in two steps:
>
>   skb_scrub_packet(skb, true);
>   memset(&skb->headers, 0, sizeof(skb->headers));
>
> skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
> monotonic timestamp: that value is the time the packet is scheduled to
> be sent, and the qdisc still needs it. The memset then zeroes
> skb->tstamp_type, because that field sits inside the headers group
> while skb->tstamp does not. The packet therefore leaves wireguard
> carrying a monotonic timestamp labelled as a realtime one.
>
> Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
> skb->tstamp if not monotonic"): fq used to assume every timestamp was
> monotonic. It now consults tstamp_type, spots the mismatch, warns, and
> falls back to treating the value as monotonic. Pacing still ends up
> correct, so the log spam is the actual problem.
>
> Save tstamp_type before the memset and restore it when encapsulating,
> next to the hash fields that are already carried over this way. When
> decapsulating it stays zeroed, which is right: an incoming packet's
> timestamp is a realtime receive timestamp.
>
> Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono delive=
ry_time")
> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>

Seems reasonable:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
