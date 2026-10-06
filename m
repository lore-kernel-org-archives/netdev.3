Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54473472F82
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297083; cv=none; b=Yw9CIWH/LTxdpEr+hSM+4xlJcecBxt60MBcmpXIy/gGl+GReztIE66/KvswN3OnKFRopyl0AFrFz9VlQ66IQHRA5jxk6tTSaogW+stmZyeodj3F+LlJPtAugApYtX7k1B/Y9c23IdpXDaj7/13AgIKgIZGDreo7zmqJkJumARTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297083; c=relaxed/simple;
	bh=BEnnUqotV2OTv1CciEnY2AJgr24Mf+9OnUiKyoEFEW4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwtTzIRnbjr+jYpNAlxM+g/Ykosx1lae1opVVcuRsWwsqkFyfx+a3O4Gw9gU+hX5kn5+b3B9ZlLw/QsqNRE1MeH6wpzDiLd4PsQyA/eJSZh+tuM5By7v0nCW+oTawFl2QXKr+Ex+TXPiQCPjIZ+MZpZ/WBUa6/f4d+3CGYxb4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am0X0LG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am0X0LG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1C71F0089C;
	Tue,  6 Oct 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297082;
	bh=DNM4LQ+HHTz4cognnPEsFOWHhAAgtNL5YRTucyclzOs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Am0X0LG818jjcmk5Oz3SM4zalLcbGw4JxrRPaBm/HjLtRgQeOHPV3mUxim6JDzAzG
	 M1OMUdLqK5eKQKxTQtuGpXUTeKzEGKC9Wh7D/heHTCm2Oxi0KmAdS5bOrwaRDl3CRV
	 En1eK5B3WL0/b0Z/ENd8EgEzHqwvB2et+AEUI0J1m4XABDVpohMZLUSESlKP1uqSfz
	 Atb3g9mJ7tGsqjCf11kkaTcscajVuRrWq4FHdZbmgX4o1hpux995HJxIP0euZwZT/h
	 0d566wvosmF0PP0PZ8b+coRtEptt1v6C5QePTic7VigzLsYiy7gwBp/XmOKQ/L3GOB
	 GqrRh3SJ1OKSw==
Subject: Re: [PATCH net-next v8 6/8] hsr: Assign a socket for cloned skbs
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 edumazet@google.com, fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com,
 pabeni@redhat.com, praneeth@ti.com, pratheesh@ti.com,
 richardcochran@gmail.com, horms@kernel.org, vigneshr@ti.com,
 willemdebruijn.kernel@gmail.com
Date: Tue, 06 Oct 2026 14:31:20 +0000
Message-ID: <179129708052.434549.14508967433709198337@kernel.org>
In-Reply-To: <20261002-hsr_ptp-v8-6-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-6-60dabc07e554@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix covers only the HSR implementation of the shared
  `create_tagged_frame` callback.
- [Medium] The patch calls `skb_set_owner_w(clone, frame->skb_std->sk)`
  in both `hsr_create_tagged_frame()` and `hsr_forward_do()`.
- [Low] The commit message says, without qualification, that the cloned
  skb loses the original's socket and that the patch assigns the…

--

hsr: Assign a socket for cloned skbs

This commit gives the cloned skb that is actually transmitted the socket
of the original skb, so that requested TX timestamps reach the user. It
does this in hsr_create_tagged_frame() for frames that request a TX port,
and in the foreign header path of hsr_forward_do().

> The cloned skb does not have a socket information recorded of
> the original skb. The original skb is never submitted. This means the
> requested timestamp information gets lost.
>
> Assign the socket of the original skb to the clone so the timestamp is
> forwarded to the user.

[Severity: Low]
Could the commit message say that this only covers port-directed PTP
frames?

hsr_create_tagged_frame() only assigns the socket when
frame->req_tx_port != HSR_PT_NONE. hsr_dev_xmit() only moves tx_port away
from HSR_PT_NONE for ETH_P_1588 frames that carry the inline HSR header.
The has_foreign_header path in hsr_forward_do() also needs a port.

Other traffic that asks for TX timestamps still reaches the slaves as
clones with skb->sk == NULL. One example is a UDP socket using
SO_TIMESTAMPING over hsr0. For those clones, __skb_tstamp_tx() returns
early:

	if (!sk)
		return;

The restriction looks deliberate, since it avoids one timestamp per slave
and double charging. The message, though, reads as if it applies to all
cloned skbs.

The message also leaves out the side effects of skb_set_owner_w(). The
clone is now charged to the sender's sk_wmem_alloc, and its skb->hash and
ooo_okay now come from the socket.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 562802ddff003..46f9bd5039821 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -348,6 +349,9 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  	if (!skb)
>  		return NULL;
>  
> +	if (frame->req_tx_port != HSR_PT_NONE && frame->skb_std->sk)
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +
>  	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
>  		return skb;
>  

[Severity: High]
Does the timestamp still get lost on PRP devices?

HSR and PRP masters share hsr_dev_xmit(). Both accept the ETH_P_1588
inline header, and tx_port is set without checking prot_version. On a
PRP master the frame takes this path:

hsr_dev_xmit()
  hsr_forward_skb()
    prp_fill_frame_info()
      handle_std_frame()      /* sets frame->skb_std */
    hsr_forward_do()
      hsr->proto_ops->create_tagged_frame()  /* prp_create_tagged_frame */

prp_create_tagged_frame() is not changed by this patch:

	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
		return skb_clone(frame->skb_std, GFP_ATOMIC);
	}

	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
			      skb_tailroom(frame->skb_std) + HSR_HLEN,
			      GFP_ATOMIC);

With NETIF_F_HW_HSR_TAG_INS, the clone keeps the timestamp request flags
in the shared skb_shinfo. Its skb->sk is NULL, though, so
__skb_tstamp_tx() returns early.

In the skb_copy_expand() case, skb_copy_header() copies only the gso
fields from shinfo. Both tx_flags and the socket are lost.

hsr_forward_skb() just frees the original skb_std. A PTP application
sending through a PRP master with the inline header would therefore still
not get its TX timestamp.

None of the later patches in this series seem to touch
prp_create_tagged_frame(). Should it get the same change? Or should
hsr_dev_xmit() reject the inline header on PRP?

[ ... ]

> @@ -581,6 +585,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		 */
>  		if (frame->has_foreign_header && frame->skb_std) {
>  			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			if (skb && frame->skb_std->sk)
> +				skb_set_owner_w(skb, frame->skb_std->sk);
>  			goto inject_into_stack;
>  		}

[Severity: Medium]
Is it safe to call skb_set_owner_w() here, and in
hsr_create_tagged_frame(), without checking how the original skb holds
skb_std->sk?

skb_set_owner_w() adds the clone's truesize to sk->sk_wmem_alloc. It does
not take an sk_refcnt reference. That is fine when the original skb is
owned through sock_wfree, which is the usual AF_PACKET case, because that
charge keeps the socket alive. For comparison, skb_clone_sk() calls
refcount_inc_not_zero() on sk_refcnt.

An egress skb can carry a socket that nothing pins, though.
bpf_sk_assign() at TC ingress does:

	skb->sk = sk;
	skb->destructor = sock_pfree;

It takes no reference for SOCK_RCU_FREE sockets. The tcx ingress redirect
path and __bpf_tx_skb() do not orphan the skb before dev_queue_xmit().
hsr_dev_xmit() accepts any ETH_P_1588 skb with the inline magic,
whatever its destructor.

Suppose that socket is being closed at the same time and sk_wmem_alloc
has already reached zero. Could skb_set_owner_w() then add to a zero
refcount? After the clone leaves the RCU section through the slave qdisc
or driver, could its sock_wfree() touch the freed socket?

Triggering this needs CAP_BPF or CAP_NET_ADMIN and a narrow close race,
and the full race has not been shown in practice.

Would it make sense to transfer ownership only when
frame->skb_std->destructor == sock_wfree, like the copy_dtor check in
UDP GSO? ip_frag_next() calls skb_set_owner_w(skb2, skb->sk)
unconditionally, so similar exposure exists elsewhere in the kernel.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-hsr_ptp-v8-0-60dabc07e554%40linutronix.de
