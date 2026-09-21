Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE432B108
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004857; cv=none; b=q84IB51my5xoi8qdkpJkGUsQJ2gper6ZwyieokJ4pk6x2gsPfwIBcemhH6xIUaLFUrNfGW1bvBvjXEBPUVLoQ49WA7pL1iPJw2MPOIhYExqRa47NgtiOUiqW/s1L7UdSlODYWQwyeq9tXxFxG7tgV4pTo1dM8Qs7e13gmt6KWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004857; c=relaxed/simple;
	bh=/2N4NpSJppaA67KSj0Z5/YwtgigrT4cAL+Z+ZzBKIrA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl/Yhcd//eIUjbgVRuH4S/PSVaDj0JNFcInNbZSxdYUfa16P9FR/D4hpY4hlRgSGJvqao4XiM6aadsEkN+mqiOE8P1uIzR2bzEEuGEI7gpx3foLAb9T9t9JN4nbDeW2YhBWeYfKFcIUL+lhU6Q7N+8GJCfvGpvSZrntTaxdluPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OauUfE1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OauUfE1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5391B1F000FF;
	Mon, 21 Sep 2026 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004855;
	bh=Rs48qZO+9zz7ILWPdAjUHo8vXvHAznm5eMrq/kpfxdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OauUfE1vefFzgP9F/RJgXbBZlqiwrpij/QMr05BP6Rd65mAKAyejO/1BZgz/hcLyT
	 bj/RfRRPBRDrgDUyy1I5SwvsCEk2ahb0zchfFvCpIVBsmcebPT3L1aCB+mBZrk1Op8
	 PCgsY176JV2DsYemNou4J5zJfofEnPiKibMcZFWpRpeuWUMCB511U2r7HAzhGIMQ4j
	 pjB8DQqRBZfmHwrgAndXbSSyut8HA9WjyqtRy/oGOJn7emTuGCXoXSQK/LZsOgzIqt
	 jkSCyoDj7NEHe3P2WRq353rNtV0d9PfJyAEnZQfOTq+u5YftOSntUVOwf2pl8Wu+WU
	 dfVOraOiyfRWQ==
Subject:
 Re: [PATCH net v2] tcp: preserve timestamps across receive queue collapse
From: netdev-bot+sashiko@kernel.org
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org
Date: Mon, 21 Sep 2026 15:34:14 +0000
Message-ID: <179000485484.2160803.6557708738361294569@kernel.org>
In-Reply-To: <20260917132742.87117-1-kerneljasonxing@gmail.com>
References: <20260917132742.87117-1-kerneljasonxing@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: a fully-covered (zero-contribution) source skb
  can still leave the collapsed skb with TCP_SKB_CB(nskb)->has_rxtstamp…
- [Low] Commit message does not describe the actual code placement or the
  resulting user-visible semantics.

--

tcp: preserve timestamps across receive queue collapse

When tcp_collapse() rebuilds receive queue skbs under memory pressure, the
cb memcpy carries has_rxtstamp over to the new skb but leaves nskb->tstamp
and the hwtstamps at zero.  This patch copies tstamp and hwtstamp from the
source skb while data is being copied into the new skb.

Link: https://lore.kernel.org/all/20260916124153.43457-1-kerneljasonxing@gmail.com/

A couple of questions below.

> tcp: preserve timestamps across receive queue collapse
[ ... ]
> Fix this by copying both tstamp and hwtstamp to the new skb right
> after the initialization.

[Severity: Low]
Does this sentence match where the code actually landed?  The copy is not
placed after the initialization block:

	memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
	skb_copy_decrypted(nskb, skb);
	TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;

but instead inside the inner "while (copy > 0)" data copy loop, right after
TCP_SKB_CB(nskb)->end_seq += size.

That difference is user visible: since the assignment runs once per source
skb merged into nskb, the collapsed skb reports the timestamp of the last
contributing skb rather than the first.  That matches tcp_add_backlog() in
net/ipv4/tcp_ipv4.c and tcp_try_coalesce(), and the V2 note below the
scissors says as much ("use the same semantic as tcp_add_backlog which is
to sync the last skb"), but everything under "---" is dropped when the
patch is applied.

Could the changelog say that the timestamp of the last merged segment is
the one kept, and drop the "right after the initialization" wording?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92bc60716f33d..bcb3861a38b9c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5854,6 +5854,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
>  					BUG();
>  				TCP_SKB_CB(nskb)->end_seq += size;
> +				if (TCP_SKB_CB(skb)->has_rxtstamp) {
> +					TCP_SKB_CB(nskb)->has_rxtstamp = true;
> +					nskb->tstamp = skb->tstamp;
> +					skb_hwtstamps(nskb)->hwtstamp =
> +						skb_hwtstamps(skb)->hwtstamp;
> +				}

[Severity: Medium]
Can nskb still end up with has_rxtstamp set while both timestamps stay
zero, which is the state the changelog says is being fixed?

The new block only runs under "if (size > 0)", but the flag also arrives
unconditionally through the earlier cb copy at the top of the outer loop:

	memcpy(nskb->cb, skb->cb, sizeof(skb->cb));

If the previous nskb filled up exactly at a source skb boundary, the inner
loop already advanced skb via tcp_collapse_one() before exiting, so the
next outer iteration can seed nskb->cb from an skb whose

	int size = TCP_SKB_CB(skb)->end_seq - start;

is <= 0, i.e. a fully covered skb that contributes no bytes.  Its
has_rxtstamp bit is inherited, the new copy is skipped, and if the skbs
that actually supply the data have has_rxtstamp == false, nskb keeps
flag = true with tstamp and hwtstamp at zero.

Fully covered skbs do stay in the ofo tree, which tcp_collapse() itself
notes with "No new bits? It is possible on ofo queue."  One way to reach it
is tcp_data_queue_ofo() coalescing into a non-last predecessor:

	} else if (tcp_ooo_try_coalesce(sk, skb1,
					skb, &fragstolen)) {
		goto coalesce_done;
	}

which extends skb1->end_seq and jumps past the merge_right loop that would
otherwise drop the now covered successor.

Downstream, tcp_recvmsg_locked() then acts on the inherited flag:

	if (TCP_SKB_CB(skb)->has_rxtstamp) {
		tcp_update_recv_tstamps(skb, tss);
		*cmsg_flags |= TCP_CMSG_TS;
	}

and tcp_update_recv_tstamps() overwrites unconditionally:

	tss->ts[0] = skb->tstamp;
	tss->ts[2] = skb_hwtstamps(skb)->hwtstamp;

so zeros replace timestamps already collected from earlier skbs in the same
recvmsg(), and tcp_recv_timestamp() emits nothing because it is gated on
"if (tss->ts[0] | tss->ts[2])".

Would clearing TCP_SKB_CB(nskb)->has_rxtstamp right after the cb memcpy,
so the new in-loop block is the only place that sets it, close this corner
too?

>  				copy -= size;
>  				start += size;
>  			}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917132742.87117-1-kerneljasonxing%40gmail.com
