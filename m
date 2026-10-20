Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518178;
	b=mH8vgoyXzB5CxJYbRHr6IPxeg32E0aZqC6NEUpxGOlq5a4fvPcBKBzedelQi1UJIwCbX
	 rFOk7b2Ahz8TnhlIIOOdAQ1qt577LYiTKeQNaKgL9RdRYVKCCe773UoyWG5T+8TA04s4e
	 KSz1k+58xL3FNwCegm/A9RR1n1W11ALjiLVvf26G+mavliFtUpVrtRynG/UMPbsS2w3PF
	 n8isNOCp8UMMCFbDpetDCL1OaUHzK/yK+2YOsnU9Dcky1DAJ0JE9eSBKs9Q5yCWH5Ki6B
	 pENPcM3asA80PHoYbJIEm6zf8f2igToILlGPCUa5jRpvxJjNYkwtu5pycCwVtzP2c7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518178;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EWYQHSdXSBcCbe7Yu0WqEtQUDsnPPm5Pe7P1Fry4b2k=;
	b=dnM8Buczp99X1p+6QsmT1hBlHGc28rw2tvyy7F/5SJueh3LcRNh6XuoqBHTE3CAYLmcn
	 iBnQYlmqFhxzJybFqmPU/pQKctULTRLy2xvmnOiaa1fxg4cWhEVuFf0U85gCJV6WwvLLg
	 i0X8KIsImIilT3jvuXlncfW8ShnKxTRT8U8Afn6zBqCasjugDjgsotV7SXnFG2iRm/Cs5
	 JHHnFb8rcuxq6HkGuKVBa+r1RWch1PVFU5q/gfPB41NppDL4bx6pxjZHZ7v1eEenRvWgp
	 GLBCYKr/97KIj47Dp3XI24reueuuyGTtYf+lyhyGJMqEnWAN5satG+ONK4zMBMrnSUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E630606A32C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E630606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v8 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
 <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
Date: Tue, 20 Oct 2026 19:42:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fqy0tgip.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The Fix:
> with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> splits a GSO skb into segments it accounts individually. Key extraction
> must run on the unsegmented skb -- skb_gso_segment() can rewrite an
> encapsulated packet's headers to the inner ones -- and the resolution
> must wait until the packet is admitted, since it commits the
> set-associative tags, host indices and way counters that a later
> rejection would leave mutated (a GSO skb whose segmentation fails was
> dropped with that state already committed).
>
> Split cake_hash() into a side-effect-free cake_hash_keys(), run on the
> unsegmented skb, and cake_hash_resolve(), run only once the packet is
> admitted. Move the split-GSO path ahead of the resolution: sum the
> segment list, test the total against the ceiling before linking any
> segment, and drop the whole list on rejection so no persistent state is
> committed. The list is deferred to to_free so the tail segment's
> sock_wfree() never runs under the qdisc lock.
>
> Tag every deferred segment with QDISC_DROP_OVERLIMIT: __skb_gso_segment()
> keeps SKB_GSO_CB at cb offset 32, aliasing tc_skb_cb.drop_reason, and
> __copy_skb_header() copies it into every segment, so tagging only the
> head left the rest with GSO scratch (a headroom-sized value) as their
> drop reason, which __tcf_kfree_skb_list() would report as an unrelated
> core reason.
>
> Read q->config->flow_mode once with READ_ONCE() in cake_enqueue() and
> pass that value to both cake_hash_keys() and cake_hash_resolve().
> cake_config_change() writes the mode before cake_change() takes
> sch_tree_lock(), and the split introduced two separate loads with the
> segmentation work between them; a concurrent reconfiguration could
> extract keys in one mode and resolve them in another.
>
> Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@=
kernel.org/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thank you for sticking with the series! :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
