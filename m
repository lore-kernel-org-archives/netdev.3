Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539727;
	b=AafUkoXgQGxsuCB5gZjv7uuKz7pxid4WUcgzQzELhpuquElRrDKsqO1SJu0BtPlFyBJc
	 ka2Tk4ez0xT9Fp0EbcR+LBrVCZbWnsaGiOyFVWKC8W4Ou0Ry/PYO0QA/O/IkudQs2uXiS
	 IhhDoj7NiPyZB4Yb0hbN9x6zG7YEY+12Uwsyx6Yr/xfr2nFSHkr2RtH6wQ6q7YFic8fOc
	 Z8RwDumjP+xH6Mzt36R+AfrplJeoJvO1A9cN6oh/9aDirdF8pNMvERbu8J83dR2tqwfp8
	 RYkn7uMBNWhlZ9f8Ze0iRTK3mS4JcUc17wNT2H3zZwpl4X5Vv7x3kQqnNMtF/Q4toDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539727;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=NUQqWLjqLzFKrbniyXv7MMJD6K+Mtw8+CZE5qpBnnAA=;
	b=bDnYehuCzsP+xKCznEdZk6pFJCbY1RIE43BVwyjp4LfvGpmdcKwXF4dBv+XHbgojiwQR
	 uNmwIBl41hCd4KDOMqoyYJ5rNGHHMawgDZTG0y+VbbiWS0JqfXuKY3L47zHAGNcVq06Ai
	 bM8kCiuZSCSywwbUoldw23d1yz9NbNktf1HOKwBHii1xoXPqnpMBk6u1rF8cqBQ+2gAcV
	 osrWaTsinPjhbYJ70D2UG1G3t2jsGcZSElW8C+qUaPW+QFKqxCp7ocz3q5YUGgKb+Kaxc
	 iOLr9Au7keDW6u7Xb0JCklOJGdX7Of9uzWgrF+uFW9PJfJzPHxtBw2m6kTp7xzfIEhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=Gbzxmxq1;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=rI2E+4Lc;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F0606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359F0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=Gbzxmxq1;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=rI2E+4Lc
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69KNfDlW030731;
	Wed, 21 Oct 2026 01:41:18 +0200
Received: from lubuntu-18.04 (host-79-32-222-240.retail.telecomitalia.it [79.32.222.240])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id D2CA7120EB3;
	Wed, 21 Oct 2026 01:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1792539669; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUQqWLjqLzFKrbniyXv7MMJD6K+Mtw8+CZE5qpBnnAA=;
	b=Gbzxmxq1H/hRk5BHu9by2wzyN2c3b2lVPR1EOmfmjZOQkNQDe+Ae7aFv+3VW2NiHcUCeNk
	TouuLPP3qXPZcSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1792539669; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUQqWLjqLzFKrbniyXv7MMJD6K+Mtw8+CZE5qpBnnAA=;
	b=rI2E+4LcESFIFuB/6KF2AYpyHLCM638Hb8mvHnucm/O18yQIYAOdKpDIZ4yv5XTTslzsLE
	i1Ly6Dde7RdRGqfqc5834GQ7sj0WhDta5mVPMsBX74/SC/1WCETJ1G9mwAFWW616bwhJwA
	W0R69CRb4YyR8ER/ppyEYY0DjhYx232RX4HWP1TiQdnmc3ogLui8I4rwyLMnUsLC5aT56m
	5DN8bYcKalzdHS7LME1lUfkG7kwlGl2wRzLFTazDNyFnaa7xnwgv06LvHyu9/nrWwo+m8l
	WnXAFaxhMago/60UpsQpTigBw/KK2n6sdSVCuSF8O5EHEwAP+se1FrqnyZbtLg==
Date: Wed, 21 Oct 2026 01:41:08 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        contact@proelbtn.com, pablo@netfilter.org, hangbin.liu@linux.dev,
        vega@nebusec.ai, sashiko-bot@kernel.org, petalzu987@gmail.com,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 1/1] seg6: validate state in netfilter
 continuations
Message-Id: <20261021014108.8b2236c36695389fb835b766@uniroma2.it>
In-Reply-To: <ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>
References: <cover.1792230570.git.petalzu987@gmail.com>
	<ec7399b424e82f050a1ff5dc79537aee1d93723a.1792230570.git.petalzu987@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sun, 18 Oct 2026 14:27:29 +0800
Ren Wei <weir@nebusec.ai> wrote:

Hi,

Thanks for the v2.

> From: Zixuan Chai <petalzu987@gmail.com>
>
> Netfilter hooks can drop or replace skb_dst() while an SRv6 packet is
> queued for continuation. The End.DX4 and End.DX6 finish callbacks and
> the seg6local input continuation currently dereference the destination's
> lwtstate without validating it. The seg6_iptunnel input and output
> continuations make the same assumption after POST_ROUTING hooks.
>
> Validate skb_valid_dst(), a non-NULL lwtstate, and the expected
> LWTUNNEL_ENCAP_SEG6_LOCAL or LWTUNNEL_ENCAP_SEG6 type before using the
> state. Drop the skb when validation fails. This check is by type, not by
> identity of the original state. It does not walk through an XFRM dst or
> take an additional lwtstate reference. Retain the loop-detection
> explanation for saving the lwtstate address in seg6_input_core().

The last two sentences seem to repeat the "Changes in v2" entries. What
changed from the previous version goes only below the "---".

>
> The End.DX4 reproducer creates a SEG6_LOCAL End.DX4 SID, enables
> nf_hooks_lwtunnel, installs an IPv4 PREROUTING DNAT rule, and injects an
> outer IPv6/inner IPv4 frame through AF_PACKET from a non-root user in a
> fresh user/network namespace. DNAT drops skb_dst() before
> input_action_end_dx4_finish() resumes.
>
> A separate root-only reproducer exercises seg6_output_core(): an SRv6
> encap route, POST_ROUTING SNAT, and an ESP transport policy replace the
> route destination before the continuation resumes.
>
> On a clean KASAN kernel, the End.DX4 reproducer triggered a NULL pointer
> dereference in input_action_end_dx4_finish from packet_sendmsg(). On the
> patched kernel, the End.DX4 reproducer completed with exit status 0. The
> SNAT+ESP/XFRM reproducer ran twice; one run returned exit status 0. No
> target KASAN report, Oops, or kernel panic was found on the patched
> guest. Tests used QEMU TCG because KVM was unavailable to the test user.

The message gives the clean-kernel result only for End.DX4. What does the
SNAT+ESP/XFRM reproducer do there?

> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Closes: https://bugtracker.nebusec.ai/f/11977

As Hangbin noted, this link is not public: it asks for a login. A
Closes: tag should point to a public report. The Reported-by can stay.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
>
> ---
> Changes in v2:
> - Add unlikely() to the new checks.
> - Validate the current dst/lwtstate type in both seg6local and
>   seg6_iptunnel continuations; drop invalid state.
> - Do not walk through XFRM dsts or take an extra lwtstate reference.
> - Retain the seg6_input_core() loop-detection comment.
> - Document both reproducer setups and clean/patched KASAN results.
> - v1 Link: https://lore.kernel.org/all/cover.1790748418.git.petalzu987@gmail.com/
>
> [snip]
>
> @@ -557,7 +573,6 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
>  static int seg6_input_core(struct net *net, struct sock *sk,
>  			   struct sk_buff *skb)
>  {
> -	struct dst_entry *orig_dst = skb_dst(skb);
>  	struct dst_entry *dst = NULL;
>  	struct lwtunnel_state *lwtst;
>  	struct seg6_lwt *slwt;
> @@ -568,7 +583,11 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>  	 * need the address of its lwtstate. So, save the address of lwtstate
>  	 * now and use it later as a comparison.
>  	 */
> -	lwtst = orig_dst->lwtstate;
> +	lwtst = seg6_lwt_state_from_skb(skb);
> +	if (unlikely(!lwtst)) {
> +		err = -EINVAL;
> +		goto drop;
> +	}

The first line of this comment still names orig_dst, but this patch
removes orig_dst.

[snip]

One more point, on where the check runs. Checking the state and dropping
the packet looks fine. The same check can also live in the okfn passed to
NF_HOOK(). There it runs only when nf_hooks_lwtunnel is on, which is when
a hook can change the dst. With End.DX4 as an example:

  Before this patch, nf_hooks_lwtunnel off (the default): no check.

  This patch, nf_hooks_lwtunnel off:

    lwtunnel_input()                  [dispatch on lwtstate->type]
      seg6_local_input()
        seg6_local_input_core()       [check 1: same dst, cannot fail]
          input_action_end_dx4()
            input_action_end_dx4_finish()
                                      [check 2: same dst, cannot fail]

  Check in the okfn, nf_hooks_lwtunnel on:

    lwtunnel_input()                  [dispatch on lwtstate->type]
      seg6_local_input()
        NF_HOOK(LOCAL_IN)             [dst may change]
          okfn: check, then seg6_local_input_core()
            input_action_end_dx4()
              NF_HOOK(PRE_ROUTING)    [dst may change]
                okfn: check, then input_action_end_dx4_finish()

  Check in the okfn, nf_hooks_lwtunnel off: no check, as before this patch.

seg6_input_core() and seg6_output_core() are in a similar situation.
Before this patch, the nf_hooks_lwtunnel_enabled static key kept the
netfilter code off this path. Without CONFIG_NETFILTER the sysctl that
turns the key on is not even built, and the checks added by this patch
still run on every packet.

In code, for End.DX4, something like (just an example):

	static int input_action_end_dx4_finish_nf(struct net *net,
						  struct sock *sk,
						  struct sk_buff *skb)
	{
		if (unlikely(!seg6_local_lwt_from_skb(skb))) {
			kfree_skb(skb);
			return -EINVAL;
		}

		return input_action_end_dx4_finish(net, sk, skb);
	}

input_action_end_dx4_finish() itself does not change, and the price is
one tiny wrapper like this for each of the five core functions, in place
of the check at the top of each of them.

With the check inside the core functions, it runs on every path, also
where it cannot fail. With the wrapper, it runs only on the NF_HOOK()
path. I would like to hear your opinions on this.

Thanks,

Ciao,
Andrea
