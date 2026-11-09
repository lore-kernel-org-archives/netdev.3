Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264952;
	b=tQuBQgiPd5U5QUlnGg4GpsGwsb9cNgLSgfZuf9M/6BX6TXmYGS31GApV704iF3GTFtiS
	 wkSkPKj6vxOQ+8eUCDG08TOlA12wQgPXPMLz16r0kMGOMrQZkYD1QCK/dReV5Sin0szBo
	 ICueWq0nc5Dpv3KXu5m0+eH0Tf+muPzbmg8Id0K0adBkxA50pbEaPNuA8d0oofzSrLMHH
	 RfyjJd8CgHr48ygzEhnFTGBU5OvAUqZL27Ne5CDy9kaC7ZqY8yGOcixLcxGGtrskKBrDC
	 N+OeN3geG0egA0iiUvgdScgajZ+c5UdyFtz2XVvqaUW8ctE7+J+7ncHZjrwUWsZmb+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264952;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ImeEDHaB+XS6wUTw+1kKzQqldTYlcuwNvWFpvEdWs6Q=;
	b=HHgWbsgMwuxUOi3JtLCbQrw1V4K3miKuM1Q2hSfhdX4t6lWJu37mqUNKm9HPuviClaUZ
	 TuF8cowF60ZILcfO2U9xeMHRwYj4PbE52f8IyHnmw9myNDv20+qedAEjPsINwAEHPvtbj
	 clPdy4A5jDrs6ehDkVcWfjpsiIPIcwABZ+XZlfdVyuMrzUszOaLCkeXtlkTzVCsWUwZ7L
	 KLua1hJg49xt+0StcDx/FUCpQOcSfL4MUV87YDh5AzbeZua5mZR2qJZWYdpd/FMwkpJRH
	 fKu+PqfFTt/qw0IdGa8GWBSQe2AmxXp8BdH7rJebuGeCaBHvdUoQ3qtvYnkZ1SsrbGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUDAjU4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99254606A31C;
	Mon,  9 Nov 2026 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUDAjU4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D231F008A5;
	Mon,  9 Nov 2026 22:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264951;
	bh=ImeEDHaB+XS6wUTw+1kKzQqldTYlcuwNvWFpvEdWs6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hUDAjU4xqfOvnnLZ3b3iIQA8uEn7Gv1cK46gzD/hoxI/3O1UzNuf/8LMaSn+hwi/b
	 S43FWUME4lYFudFZWt1fjAu6vUfb36TmVZL3PAr2GpO31I5eN02j2pPoZ+23mLO+G4
	 FpjPdKRDa8al53IgUNJmfyR6yqKwxRyg14PgN4+S+K6SPnKN3vm8ensMrRpcNzu23q
	 vABQDHF9c7RlMO+79geW6ZZeDOFztMBbbY4ttunovqYfOsHRGnKOdp7WH8aMN1JbLm
	 JmyAzWXpZmLMfa6hgi9YSp1POAOEB1MxsWCULqbnWr2cVGyZYu1nIxt92Wq+poTXGo
	 DgAQnhDuLqqWA==
Subject: Re: [PATCH] tipc: bound reassembly size in tipc_buf_append()
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:55:50 +0000
Message-ID: <179426495025.994134.5478434430372728777@kernel.org>
In-Reply-To: <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me>
References: <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In tipc_buf_append() (net/tipc/msg.c), the new size check is
  placed in the FIRST_FRAGMENT branch and reads `head->len`.
- [High] The fix does not achieve its stated purpose.
- [Medium] The chosen limit does not match TIPC's own definition of a
  maximum message.
- [Medium] Bounding only the byte length of the reassembled data does not
  bound the memory a reassembly pins.
- [Low] The submission has form problems.
- [Low] The new error path in tipc_buf_append() leaks the fragment skb.

--

tipc: bound reassembly size in tipc_buf_append()

This patch adds a size check to tipc_buf_append() to limit the total size
of a TIPC message being reassembled from fragments. The aim is to stop a
remote peer from growing the reassembly skb without limit by sending a
first fragment and then an endless stream of in-sequence fragments.

> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>

[Severity: Low]
This isn't a bug, but there's no Signed-off-by line, only a Reported-by
from the same person, so the patch can't be applied as is. Could a Fixes:
tag also be added, since this is meant to fix long-standing code?

The body also reads like an email report rather than a changelog
("Hello,", "Please treat this as a report for verification", and the
notes about AI-assisted review). It also says the patch hasn't been
compiled or runtime tested.

Could this be rewritten as a normal changelog?

> diff --git a/net/tipc/msg.c b/net/tipc/msg.c
> index 39dfd33c8eecc..b37db2cbcc8fb 100644
> --- a/net/tipc/msg.c
> +++ b/net/tipc/msg.c
> @@ -145,6 +145,13 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
>  		if (skb_has_frag_list(frag) && __skb_linearize(frag))
>  			goto err;
>  		*buf = NULL;
> +
> +		/* Bound the reassembled message size: a peer that never sends
> +		 * the last fragment could otherwise grow the head skb (and its
> +		 * frag list) without any limit.
> +		 */
> +		if (head->len + frag->len > TIPC_MAX_USER_MSG_SIZE)

[Severity: Critical]
Can head be anything other than NULL here? This is the FIRST_FRAGMENT
branch, and just above the hunk tipc_buf_append() already bails out if
head is set:

	if (fragid == FIRST_FRAGMENT) {
		if (unlikely(head))
			goto err;

head is only assigned further down:

		head = *headbuf = frag;

So it looks like every first fragment dereferences a NULL head. That
includes ordinary, legitimate fragmented messages.

On the receive side this runs in softirq with le->lock held:

tipc_rcv()
  spin_lock_bh(&le->lock)
  tipc_link_rcv()
    tipc_link_input()
      tipc_buf_append()

The tunnel reassembly in link.c hits it the same way. Local senders do
too, for example tipc_mcast_xmit()->tipc_msg_reassemble() for multicast
messages with local destinations that exceed the MTU, and
tipc_msg_build()->tipc_msg_assemble() or
tipc_lxc_xmit()->tipc_msg_assemble().

Would this oops on any peer that sends a message larger than the bearer
MTU?

[Severity: High]
Even with the NULL dereference fixed, does this check bound the
reassembly at all? Nothing has been accumulated yet in the
FIRST_FRAGMENT branch.

The growth described in the changelog happens later in tipc_buf_append(),
on the FRAGMENT/LAST_FRAGMENT path:

	if (skb_try_coalesce(head, frag, &headstolen, &delta)) {
		kfree_skb_partial(frag, headstolen);
	} else {
		...
		head->truesize += frag->truesize;
		head->data_len += frag->len;
		head->len += frag->len;
		...
	}

That path still has no size check. A peer that never sends LAST_FRAGMENT
can still grow head without limit.

Should the check be done before appending on the non-first path instead,
perhaps against the first fragment's declared inner msg_size()?

[Severity: Medium]
Is TIPC_MAX_USER_MSG_SIZE the right limit to compare head->len against?
tipc_buf_append() only pulls the outer fragmenter header, so the
reassembled skb holds the inner header plus the payload.
TIPC_MAX_USER_MSG_SIZE is a payload-only limit everywhere else:

net/tipc/msg.c:tipc_msg_validate() {
	...
	if (unlikely((msz - hsz) > TIPC_MAX_USER_MSG_SIZE))
		return false;
	...
}

net/tipc/msg.h:
#define MAX_MSG_SIZE (MAX_H_SIZE + TIPC_MAX_USER_MSG_SIZE)

The socket send paths only reject dlen > TIPC_MAX_USER_MSG_SIZE, and
tipc_msg_build() fragments msz = mhsz + dsz.

If the check moves to the append path and keeps this constant, would
valid messages with a payload near 66000 bytes get rejected? On unicast
links, a reassembly failure makes tipc_link_input() reset the link:

	} else if (!*reasm_skb && !link_is_bc_rcvlink(l)) {
		pr_warn_ratelimited("Unable to build fragment list\n");
		return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);

Would MAX_MSG_SIZE, or the first fragment's msg_size(), be a more
consistent bound?

[Severity: Medium]
Is a length-only bound enough to cap the memory one reassembly pins?
Once skb_try_coalesce() fails, each fragment skb is chained whole with
head->truesize += frag->truesize. Nothing limits the truesize or the
number of fragments.

A peer could send many in-sequence fragments that each carry about one
byte of payload. Each one passes the per-packet ratio check in
tipc_msg_validate():

	if (unlikely(skb->truesize / buf_roundup_len(skb) >= 4)) {

but still costs roughly 1-4 KB of truesize.

With a 66000-byte length cap, one reassembly could hold tens of
thousands of skbs. That GFP_ATOMIC memory isn't charged to any memcg,
and the attack can be repeated per link and per tunnel reassembly. The
aggregate truesize is only checked when LAST_FRAGMENT arrives.

Should the accumulated truesize or the fragment count also be bounded?

> +			goto err;

[Severity: Low]
Does this error path leak frag? *buf was already set to NULL above. In
the FIRST_FRAGMENT branch *headbuf is also NULL, so the err label frees
nothing:

err:
	kfree_skb(*buf);
	kfree_skb(*headbuf);
	*buf = *headbuf = NULL;

The skb_unclone_full() failure path just below is fine, because
skb_unclone_full() frees the original skb itself. This new branch
doesn't free frag.

On MMU systems, the NULL dereference on the previous line hides this
today. A respin that only fixes the dereference would expose the leak,
unless the check moves before *buf = NULL or frag is freed explicitly.

>  		frag = skb_unclone_full(frag, GFP_ATOMIC);
>  		if (unlikely(!frag))
>  			goto err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg%3D%40proton.me
