Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D171BD9C9
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978763; cv=none; b=cEHaT7lvpY3yeyldlduM64nhgyNt9E+KWGlHaaAfbSXK7TiMXJJL6YyYfqZ7FAfI2ZLAY5Ycy+UdNirtSH696RXALxthwz/720u9BWPOzhSq/jh/JlOBmbdA4DO35NjXU8Ow29PZsz1KwML4FyzHOVyTLXLD6LuvL0NDtb7sg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978763; c=relaxed/simple;
	bh=s7Bo83O5em3tjtopKKH+dRT37w6jA7s/YyF/qP61njk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbJaVlXyGd/RS9piaS43gKAubzai3AlFkdHew8ACZ4EpPFbc99aXoU7pcDpSYmQqi22xC6H4NFdlT4N8VOLgmQC88igV+1GXHdUsrZ0b2gFMargPRtUdLTe3gs3VxyR1NDFhWgiPGVa29y0O6RnuHlam6eGaIIgjSyLDhSVnpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSG8u/Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSG8u/Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F91F00893;
	Wed, 14 Oct 2026 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791978756;
	bh=uWdwI+LXWRE6Szw7LiP+O43KJhCmxa+gq/rSeRFRhGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WSG8u/Yq1BuSGa3URFeqz27uzZVPrmux6+vn/TdShfiiHcVzVGD+W+Nt/qd0dywVl
	 8u+zEyfuu7QVqu2GaW7sPeNff8kbatf5AwHkcxY6Wtmn7G4b7/7Py/MzTgMn7wscBI
	 0eOsOTxIlH/xP+AsU5DWniEHvdt222BeAhYYPbHgyaqyHAXclNhyLgepoq+cT6Y+cQ
	 h4L4tHMbAG2wCvDrJVy68lgWuWsS63G4tu0awoOmwwZDqSMoZCLED9zuuY9EX5kYJN
	 qnHnW7LzW4FatFsv9xGXFaCtND3h05ArVR7Byn3tk3ealW+cq/ftibUljgfaOzAx3p
	 nKCxnQDjVhSyw==
Subject:
 Re: [PATCH net v4] vlan: restore HW VLAN tag insertion with reorder_hdr off
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, sairon@sairon.cz, stefan@agner.ch,
 hitchin999@users.noreply.github.com, hkallweit1@gmail.com
Date: Wed, 14 Oct 2026 11:52:35 +0000
Message-ID: <179197875524.434549.17569544478935275137@kernel.org>
In-Reply-To: <20261013115022.1043024-1-edumazet@kernel.org>
References: <20261013115022.1043024-1-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not cover stacked vlans (Q-in-Q) whose lower vlan
  has reorder_hdr=off on a real device that can insert tags in hardware.

--

vlan: restore HW VLAN tag insertion with reorder_hdr off

This patch keeps vlan_dev_hard_header() pushing an in-band tag when
reorder_hdr is off. In vlan_dev_hard_start_xmit(), when the frame
carries our protocol in-band and the real device can insert tags, the
tag is moved to skb->vlan_tci with __skb_vlan_pop(). The goal is to
fix NETDEV WATCHDOG stalls on r8169/r8152 introduced by 447cbe95ebb9.

Closes: https://lore.kernel.org/netdev/CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com/
Closes: https://github.com/home-assistant/operating-system/issues/5019

> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index c949c6a829456..2d775b4c84ce6 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c

[ ... ]

> @@ -121,10 +123,39 @@ static netdev_tx_t vlan_dev_hard_start_xmit(struct sk_buff *skb,
>  		vlan_tci = vlan->vlan_id;
>  		vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
>  		__vlan_hwaccel_put_tag(skb, vlan->vlan_proto, vlan_tci);
> +	} else if (skb_headlen(skb) >= VLAN_ETH_HLEN + sizeof(__be16) &&
> +		   !skb_shared(skb) && !skb_vlan_tag_present(skb) &&
> +		   !skb_metadata_len(skb) &&
> +		   (skb->ip_summed != CHECKSUM_PARTIAL ||
> +		    skb_checksum_start_offset(skb) >= VLAN_ETH_HLEN) &&
> +		   vlan_hw_offload_capable(READ_ONCE(vlan->real_dev->features),
> +					   vlan->vlan_proto)) {

[Severity: High]
Does this fix cover stacked vlans where the lower vlan has reorder_hdr
off?

Take this stack: U (802.1Q, id 10) on L (802.1ad, id 100) on eth0. eth0
supports CTAG and STAG TX offload, and L was created with reorder_hdr
off.

Since 447cbe95ebb9, L always uses vlan_header_ops. So the upper device's
dev_hard_header() call reaches L's header op, which pushes L's tag as
the outermost tag:

vlan_dev_hard_header(U)
  dev_hard_header(L, ...)
    vlan_dev_hard_header(L)
      vhdr = skb_push(skb, VLAN_HLEN);    /* 88a8/100, outermost */

When vlan_dev_hard_start_xmit(U) runs, veth->h_vlan_proto holds L's
0x88a8, not U's 0x8100. It takes the first branch and sets hwaccel
8100/10, so the new pop branch is never reached.

Next comes dev_queue_xmit(L)->validate_xmit_skb()->validate_xmit_vlan().
L has no NETIF_F_HW_VLAN_*_TX, so this pushes U's tag in front of L's
in-band tag:

net/core/dev.c:validate_xmit_vlan() {
	if (skb_vlan_tag_present(skb) &&
	    !vlan_hw_offload_capable(features, skb->vlan_proto))
		skb = __vlan_hwaccel_push_inside(skb);
}

vlan_dev_hard_start_xmit(L) then sees an outer 0x8100 instead of its own
0x88a8, so it adds hwaccel 88a8/100 again.

Wouldn't the frame then go on the wire with its tags in the wrong order
and L's tag duplicated? If U also has reorder_hdr off, U's tag would be
duplicated as well.

eth0 would also still get a frame with in-band tags while checksum/TSO
offload is requested. That looks like the r8169 condition this patch
targets. The same sequence seems to happen with U reorder_hdr on and L
reorder_hdr off.

Before 447cbe95ebb9, L used vlan_passthru_header_ops on an
offload-capable eth0, so it never pushed an in-band tag at hard_header
time.

The commit message says the in-band header:

  "is relied upon by stacked vlans (Q-in-Q)"

When the lower vlan has reorder_hdr off, isn't that in-band header what
produces the wrong tag layout? U's xmit runs after L's tag is already
outermost and reads it as a foreign tag. So can this case be fixed from
the xmit path at all, or does it need a change in vlan_dev_hard_header()?

> +		u16 vlan_tci;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013115022.1043024-1-edumazet%40kernel.org
