Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561071;
	b=ZwhCnfsDfo3QO0c7qX+4uAoEtoMrMBLwAH7JaUFc9fO/wm8s3WU24Cm+90Omj32jelED
	 +yBtWytk1goQMZsLzrGFm54E+yfGesDfz13zDa4pm9ZthCzN0CcZd9MoVSDjGffZQB6N3
	 RjZoraft6uAdmD3YKN+5ZRfmkcOTnXhEqf8O/oQS9eg0PLGL5yJf6CUPuTtwW7c/on6Bi
	 CBGrqeAPKF4BLAsY8IPDIccrHsVXdSgzJE0qeCnT/qyIQAHALopFQTzhrSwB6fyl5SKvK
	 fzDpge6mMSASVuB55idGW1HsoO5oYfmwbJJj/AlKWVsHO702VKZyT3LqfzKwEqDediA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561071;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KlyDfe54iq4sq1MkkQDm5pwyuqCNG54DU3f11EW3AdA=;
	b=adhAPigUSEgD3TJccWbah3wKn8L5lz0H+n7COkbBepBU/uZSjnMywfFq2TvzJQ2MWeqo
	 6QoBPAGTX9vn57tQLe6mmrSmU1baDcg0ctc08Yf7RehBgn/WFf+Bx8CcEGX1pR081vflx
	 tL4GpfusOn8qYgXIB8uMaihc2S3r7Bjl+6hA+HURwjcIJoiR+Pz8QGiI9Mf3iozvL0Lg6
	 wrJZ4GAbXn6cFDJ9dXnMHUhqGphGnuvF3A2WNrjkD+sIM6rFPvxfnPFowKxd19uCQFur/
	 iHxmLCYD8X2w3tX94SIkWD8foApDf52xqx2F7YxCre/coWcaJ0BBYAvFhNZgLajeR3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSAIoFhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6972606A327;
	Sun,  1 Nov 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSAIoFhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B61F000C1;
	Sun,  1 Nov 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561070;
	bh=KlyDfe54iq4sq1MkkQDm5pwyuqCNG54DU3f11EW3AdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lSAIoFhJXN2dhUQvu3+QUuCIw4brTWBz/zI9TNf+bpy/PphIWDIbjk4F47r8z70kt
	 PvQhSEubDGMPkc52Rm55NymmLnSSGwSIPuLLv+DRolqH6GGW1kHG9VWzSgxDw67/Uc
	 G60XfQ+RXKnMil1qlQmC+BYNpTTuftG7Qu4FowlkYrlEA+4+aeHP4ggRYAwrM3a95n
	 CRxE1p6if/e6RWxKmk4ura0HTs0s4wNndhITsLckgUQ1q+jGTt+ndwnyt0rBasdN3D
	 RKUTnzPPmcd7reGj0rKcGm0pLb2l7ruECMLMuKZh22CeAsJtKITknNaNIpSpq01+BP
	 ztAxR6iW1/njA==
Subject: Re: [PATCH net v5] tcp: do not let tcp_collapse() drive
 sk_forward_alloc negative
From: netdev-bot+sashiko@kernel.org
To: tavip@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shakeel.butt@linux.dev, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 19:24:29 +0000
Message-ID: <179356106917.3131.8290319688981763696@kernel.org>
In-Reply-To: <20261028190820.2917252-1-tavip@google.com>
References: <20261028190820.2917252-1-tavip@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] The fix is incomplete.

--

tcp: do not let tcp_collapse() drive sk_forward_alloc negative

This patch makes tcp_collapse() call sk_forced_mem_schedule() before it
charges each newly allocated nskb with skb_set_owner_r(). Without that,
sk->sk_forward_alloc can go negative, because the new skbs are charged
before the skbs they replace are freed. A negative sk_forward_alloc can
make tcp_wmem_schedule() return a negative length, which trips the
WARN_ON_ONCE() in check_copy_size().

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 1ddce9c4b7e8c..e879bdfddf1ab 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5847,6 +5847,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  			__skb_queue_before(list, skb, nskb);
>  		else
>  			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
> +		/* nskb is charged before the skbs it replaces are freed.
> +		 * Make sure sk->sk_forward_alloc can not become negative.
> +		 */
> +		sk_forced_mem_schedule(sk, nskb->truesize);
>  		skb_set_owner_r(nskb, sk);
>  		mptcp_skb_ext_move(nskb, skb);

[Severity: High]
Does tcp_data_queue_ofo() in net/ipv4/tcp_input.c have the same problem?

The v5 notes say this change makes it so "sk_forward_alloc cannot become
negative in the first place". The out-of-order queue path seems to do
things in the same order as tcp_collapse(): it frees older charged skbs
and then charges the new one.

First, it reserves the truesize of the incoming skb:

net/ipv4/tcp_input.c:tcp_data_queue_ofo() {
    ...
	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
    ...
}

Before the incoming skb is charged, any OFO skbs it covers are dropped.
This happens both in the "skb covers skb1" replace branch and in the
merge_right loop:

		tcp_drop_reason(sk, skb1, SKB_DROP_REASON_TCP_OFOMERGE);

Each skb1 still has sock_rfree() as its destructor, so this goes through
sock_rfree()->sk_mem_uncharge()->sk_mem_reclaim(). With sk_reserved_mem
== 0, sk_mem_reclaim() gives back every whole page, including the pages
that were just reserved for the incoming skb.

The incoming skb is then charged without a new reservation:

end:
	if (skb) {
		...
		skb_condense(skb);
		skb_set_owner_r(skb, sk);
	}

This leaves sk_forward_alloc at ((F + T1) mod PAGE_SIZE) - T, where F is
the old sk_forward_alloc, T1 is the truesize of the freed skb and T is
the truesize of the incoming skb. For example, F = 0, T1 = 2000 and
T = 3000 give -1000. The result is always negative when T > PAGE_SIZE,
for example with a GRO skb that skb_condense() leaves alone.

The peer controls the OFO layout. It only needs to send a segment that
starts at the same sequence as a queued OFO segment, or one that covers
later OFO segments.

Suppose tcp_sendmsg_locked() runs after this while sk_wmem_schedule() is
failing (memcg charge failure or tcp_mem limits) and sk_wmem_queued >=
tcp_wmem[0]. Can tcp_wmem_schedule() still return a negative value here?

net/ipv4/tcp.c:tcp_wmem_schedule() {
    ...
	return min(copy, sk->sk_forward_alloc);
}

That would reach WARN_ON_ONCE(bytes > INT_MAX) in check_copy_size()
through skb_copy_to_page_nocache()->copy_from_iter_full_nocache().

Would it make sense to also call sk_forced_mem_schedule(sk, skb->truesize)
before skb_set_owner_r() in tcp_data_queue_ofo()? Two alternatives are
charging the skb before the covered skbs are dropped, or keeping the
sink-side clamp in tcp_wmem_schedule().

[Severity: High]
Can sk_forward_alloc also go negative through the non-pure MSG_ZEROCOPY
path in tcp_sendmsg_locked()?

v5 replaced the v4 clamp in tcp_wmem_schedule() with this source-side
fix. That leaves this return in tcp_wmem_schedule() relying on
sk_forward_alloc >= 0:

	return min(copy, sk->sk_forward_alloc);

When the tail skb is not pure zerocopy, tcp_sendmsg_locked() only
schedules copy bytes:

			if (!skb_zcopy_pure(skb)) {
				copy = tcp_wmem_schedule(sk, copy);
				if (!copy)
					goto wait_for_space;
			}

Next, the call chain
skb_zerocopy_iter_stream()->__zerocopy_sg_from_iter()->zerocopy_fill_skb_from_iter()
grows truesize by whole pages:

net/core/datagram.c:zerocopy_fill_skb_from_iter() {
    ...
		skb->truesize += PAGE_ALIGN(copied + start);
    ...
}

__zerocopy_sg_from_iter() then charges that truesize without scheduling
it:

		if (!skb_zcopy_pure(skb))
			sk_mem_charge(sk, truesize);

Take sk_forward_alloc = 3000, copy = 2000 and a user buffer at page
offset 3000. The data spans two pages, so 8192 bytes are charged and
sk_forward_alloc ends up at -5192. Several small iovecs on different
pages make the overcharge larger.

Suppose a later sk_wmem_schedule() fails while sk_wmem_queued >=
tcp_wmem[0]. Then tcp_wmem_schedule() returns a negative value, and the
if (!copy) checks in tcp_sendmsg_locked() do not catch it.

On the copy path, that reaches the same check_copy_size() WARN that the
commit message describes. On the non-pure zerocopy path, the negative int
becomes a huge size_t length in __zerocopy_sg_from_iter() and bypasses
size_goal. On the MSG_SPLICE_PAGES path, skb_splice_from_iter() is given
a negative maxsize.

Should the v4 sink-side guard in tcp_wmem_schedule() be kept along with
this tcp_collapse() change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028190820.2917252-1-tavip%40google.com
