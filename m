Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971738;
	b=ekMvhZSiL1DbHu4iwhUaQy5AYgWRrzGGOlGAvpjzJ3HdUHKDCEEXufmYyAebhb/GE1+i
	 PTfVkOQqO4KNtyaQuEEYcXC/Lwt6IvcOShpgNkuLISKh8UFeBDqpLrJA4/exvCRJ7LF1X
	 EPuZ62jtuRL7kErVbMMcuzYM1yqL3ZFfhtpY8LXabHmBv55GSE9Wfb9TLA2ErWlVAjgwO
	 oxw/1klcAWWt+rN+LzvYshFQWrxDauWUIAZLyal38qea59gUmN03uP7MWZvo17FlLte8B
	 FnINBWO+XR6xIVGMegIdrzj+x4WtiG7eU4xtoCe8TOwKPXD1iwX0IDxdXza0q9RP82w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971738;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/P432aImU9M5+AgzPTvcGtwexqx2Fz0lLbSjYe0pWoo=;
	b=ztMiBTaozbOzbBcO/G9lzv+pjEM5VuLTq7vMaT+XWbihDYWnPJOD1Zzr1VWWmRll9C95
	 oBLy27NGrgKRak2rHHinWklLPKW7sVmgEONDzD7A3TonQmCv3WXJj5+lI48ayu7whsT9E
	 a8j2pUhhMuqa31zx6BUAHcNK6vJJ322Y5BicTUohrt+BoMKI4nIYBSlBhy2l8/u/f/7zu
	 a4RtjyxoEyqygmGfXwEeRhyO99e4ZmAQAYBLznwBja4gCfCHpn+2ux8TRAxl5rFH3OzY1
	 ksB/nSLBWU6mrtTJgoyH4BhNF3i5wPEk0PMhljrpOVcI9HxapTbNrnQh0AvRzPpt61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5nXakqc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F21606D803
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5nXakqc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAA91F008A5
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971737;
	bh=/P432aImU9M5+AgzPTvcGtwexqx2Fz0lLbSjYe0pWoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c5nXakqch5G6zlAiXCylNW7cCz8/twj4/3JWc9haXlHBNkZScMvB0IdgdeW3nqG07
	 dfKFqGCrCkY/8ar033h0ukckVhvNf407SEsOXmQZTH55Mq/oGQnGaZ/pkC2lYQyont
	 hASMbq9BF6YpENylceJqWqS5IKkdnIBFEW79UMTysVw4N+7mAosu0kKGBACg2jDeL1
	 WXBHvhTmSUaL84r+qt6UsNU7tEYxJ2ngpV/umdDJ86LjToNg5U1+GDSPeYMsmuR4+h
	 jCSoQylMEOxgHpAofpRT0j7ejVWkbTNUaxPBtJtyvVcWvqxzuofuGrIlDGS7AWyiGZ
	 w8lV1dG3IRuZw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-56431524c22so206779b6e.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 05:28:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByDbH3T9OjpSz+mBamxJQfQnaiYhWAE41OjHVVNbbA4wHMPG//NPkEPxFBtRFljI6+G6e+sXm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xeSCuD7lR0VzU/SGvejGyyHatIhRHi0GZdkkeQGiRstMB3vH2
	1jizJBN+4EHhWSAsxC6dq61bHtsRLmjng1w6QjPG6c2dJF5RIS1d7WBBOWYytdLaYl+9OTcL7t9
	zynKdFV8uLjcMFvJaUkJCo1oULhDeScw=
X-Received: by 2002:a05:6808:c165:b0:4ce:a4fc:a848 with SMTP id
 5614622812f47-567e0f14889mr1664126b6e.6.1793971737143; Fri, 06 Nov 2026
 05:28:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <au3HMfqNW3_DRMqS@v4bel>
In-Reply-To: <au3HMfqNW3_DRMqS@v4bel>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 14:28:45 +0100
X-Gmail-Original-Message-ID: <CAL4WiioDCs_mksvfJu0Svr+bx3NXm35VWhYAD7h=vqaLFPbShQ@mail.gmail.com>
X-Gm-Features: AclHuK8WMljdlOeXf4mKIBJOmRy-GSlb6oKZabvG_whwfNM14esefy99z9jHyEg
Message-ID: <CAL4WiioDCs_mksvfJu0Svr+bx3NXm35VWhYAD7h=vqaLFPbShQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: do not coalesce segments after FIN
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com, sd@queasysnail.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 13:25, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9c=
rit :
>
> A FIN consumes a sequence number. If another FIN segment is coalesced
> into an skb that already carries FIN, end_seq advances to account for
> the additional FIN, but tcp_flags still contains only one FIN bit.
>
> When the preceding gap is filled and tcp_ofo_queue() processes the
> coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
> path consumes all data in the skb, copied_seq advances by the data
> length and one sequence number for FIN. If three or more FIN segments
> have been coalesced into one skb, tcp_inq() can still return a positive
> value after the receive queue becomes empty and the SOCK_DONE adjustment
> is applied.
>
> TCP_ZEROCOPY_RECEIVE is another consumer affected by this state.
> tcp_zerocopy_receive() takes its length from tcp_inq() and follows
> skb->next without checking for the end of the receive queue.
>
> Software kTLS receive is one consumer affected by this state. When
> strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
> tcp_read_done() to consume the current TLS record. In the reproducer,
> tcp_read_done() consumed the record data and one FIN before freeing the
> receive skb.
>
> When kTLS looked for the next record, tcp_inq() reported at least
> TLS_HEADER_SIZE bytes even though the receive queue was empty.
> tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
> WARN_ON_ONCE() and returned without updating the anchor.
>
> Since tcp_inq() had reported at least TLS_HEADER_SIZE,
> tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
> skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
> skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
> the stale pointer, causing a use-after-free.

...

>
> In tcp_try_coalesce(), skip coalescing when the destination skb already
> carries FIN. tcp_add_backlog() calls skb_try_coalesce() directly instead
> of using this helper, so add the same check there. Since both paths check
> only the destination skb, a final segment carrying data and FIN can still
> be coalesced into an skb without FIN when the other coalescing checks pas=
s.
>
> Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
> Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks.
