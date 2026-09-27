Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8437C930;
	Sun, 27 Sep 2026 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489188; cv=none; b=mHhi7cSRWqr0SAdmlinxdESKz5b0GvHCKNpRfvBfXFndbPaCreMB2wtEaByKVobfLFx27szxQ3cBSLm9BLEkWnpZIRuF9mwgYiaKXKUYoHZ5Ep77fsUehGOjvimzlErnRMwv5CE+Qqv1gE4uNB4WYNO3PxommwgSQJ5vqCSLWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489188; c=relaxed/simple;
	bh=vqluyjUDjjPS1d26/NhrEmw/bt+QWJPFTpoCkzCn/B0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/W64R/lsY5WnuLMKhwnxXyeiyrXySf0OghzVSn/yjoVu5VXcsNNhekgxif6o+v70/WVnXSAzmHR0LoorRde7ahZytHEwTRqSIIIAMt11Eq1ij/22gmmoQdzaas0yZNckYQ/nzzDs75FPPyKMBnngXRzflKLd6heVEqwOlMLiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSIkkNix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSIkkNix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D941F000FF;
	Sun, 27 Sep 2026 06:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790489186;
	bh=CeOOtOyN4WzxpSwJoycJ9k8ofbO1qBAtgd/EJRBu2+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nSIkkNixML1XwG8cKWIMg4emdCF5TVXn8CaEoW2QgC4tKDFn01pj7dsezR+8nxGfU
	 +ulvN8aALtMumdKqyIC+9XMw/epENCWz2JDXYOCOhtfrqqVah97Zn/y/mDuujNl1H1
	 nto5c90nVZXH0GVpsf1ce1y7n04ZDGQefTxgO8QPXTuqVcElVZB2tDes3zEHbS1fi2
	 WxxC57965auxEEJqmjZWfksNtbPshEQEuopJldIQDQSh3rUir1EmdaXmt6JjpkvBbr
	 2Vy3z9rQT8Mzw0rIoTE/P0RYc1W1AytYHx+sjJReLuAr43euORsLYqRnXdRVzL3RTt
	 Lw3LYoTUJDlmw==
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: use consistent egress tag
 for trapped link-local frames
From: netdev-bot+sashiko@kernel.org
To: gongtao0607@gmail.com
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lorenzo@kernel.org,
 arinc.unal@arinc9.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi@oss.qualcomm.com
Date: Sun, 27 Sep 2026 06:06:25 +0000
Message-ID: <179048918513.2160803.6391099514443466480@kernel.org>
In-Reply-To: <20260923055103.949540-2-gongtao0607@gmail.com>
References: <20260923055103.949540-2-gongtao0607@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's justification is contradicted by code
  already in the tree.
- [Medium] Setting BPC, RGAC1 and RGAC2 EG_TAG to
  MT7530_VLAN_EG_CONSISTENT in mt753x_trap_frames() probably breaks…

--

net: dsa: mt7530: use consistent egress tag for trapped link-local frames

This commit changes the EG_TAG attribute for trapped link-local frames in
the BPC, RGAC1 and RGAC2 registers from MT7530_VLAN_EG_DISABLED to
MT7530_VLAN_EG_CONSISTENT. The goal is to keep untagged BPDUs from
reaching the CPU with the PVID tag stacked on when a VLAN-aware bridge is
in use, while still preserving the VLAN tags of frames that arrive tagged.

> Because BPDUs arrive at the CPU with a VLAN tag (EtherType 0x8100
> at offset 12 instead of 802.3 length <= 1500), userspace STP daemons
> (such as ustpd) and the kernel bridge drop or ignore them, breaking
> STP convergence.

[Severity: Medium]

Can this failure happen on the current tree? Both mt7530_setup() and
mt7531_setup_common() already set:

	ds->untag_vlan_aware_bridge_pvid = true;

That line came from commit 4cb3cd670b2a ("net: dsa: mt7530: untag
VLAN-aware bridge PVID"). It was part of the same series as 3ac85bcfd404
and handles this same hardware behaviour.

With the flag set, every received frame goes through the software untag
path, including trapped link-local frames:

dsa_switch_rcv()
  dsa_software_vlan_untag()
    dsa_software_untag_vlan_aware_bridge()

The PVID tag is then cleared here:

net/dsa/tag.h:dsa_software_untag_vlan_aware_bridge() {
    ...
	if (vid == pvid && skb->vlan_proto == htons(proto))
		__vlan_hwaccel_clear_tag(skb);
}

The kernel-doc for that helper says it exists because "Software like
STP/PTP may not" handle tagged packets.

The VID that the switch inserts is the bridge port PVID.
mt7530_port_vlan_add() stores vlan->vid in priv->ports[port].pvid, and
mt7530_port_set_vlan_aware() programs G0_PORT_VID(priv->ports[port].pvid).
An untagged BPDU stacked with the PVID tag should therefore reach
br_handle_frame(), and packet sockets on the user port, untagged.

Which condition stops this untagging for trapped frames? If the breakage
was seen on a backport that has 3ac85bcfd404 but not 4cb3cd670b2a, or with
an 802.1ad bridge, could the commit message say so? As written, it isn't
clear whether the STP breakage exists on mainline at all, and that affects
the Fixes: tag and stable backports.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3e61eb3c2b1e2..20bb07fac0f7b 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1309,39 +1309,39 @@ static void
>  mt753x_trap_frames(struct mt7530_priv *priv)
>  {

[ ... ]

>  	mt7530_rmw(priv, MT753X_BPC,
>  		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
>  			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
> -		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
> +		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
>  			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
> -			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
> +			   BPDU_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
>  			   TO_CPU_FW_CPU_ONLY);

[Severity: Medium]

Does this bring back the problem that 3ac85bcfd404 fixed? That problem
was VLAN-tagged link-local frames (STP, LLDP, PTP, as exercised by the
local_termination selftest) arriving on VLAN-aware user ports.

Commit e8bf353577f3 ("net: dsa: mt7530: fix link-local frames that ingress
vlan filtering ports") says the per-frame EG_TAG in BPC, RGAC1 and RGAC2
takes priority over the VLAN table. It describes CONSISTENT like this:

    CONSISTENT means frames egress exactly as they ingress. [...]
    Although link-local frames are not supposed to be transmitted
    VLAN-tagged, if they are done so, when egressing through a CPU
    port, the special tag field will be broken.

Its captures show that stack mode keeps a separate 802.1Q header after
the special tag. Tagged mode instead merges the TCI into the special tag,
with no 0x8100 TPID:

    stacked: 0001 0000 8100 0001
    tagged:  0001 0001 0026 4242

For these frames, CONSISTENT now overrides the stack rule that
mt7530_hw_vlan_add() sets for the CPU port:

	val = MT7530_VLAN_EGRESS_STACK;

mt7530_port_set_vlan_aware() configures VLAN-aware user ports with
VLAN_ATTR(MT7530_VLAN_USER), so the switch parses their ingress tags. A
tagged BPDU, LLDP or PTP frame received on such a port would then leave
the CPU port in the merged tagged format.

mtk_tag_rcv() always strips MTK_HDR_LEN bytes as a separate special tag:

	skb_pull_rcsum(skb, MTK_HDR_LEN);

	dsa_strip_etype_header(skb, MTK_HDR_LEN);

Wouldn't that discard the VLAN TCI and deliver the frame to the base user
netdev instead of the VLAN upper?

The commit message says "VLAN-tagged frames preserve their original VLAN
tag". Is there a capture or datasheet reference showing that CONSISTENT
gives the stacked format at the CPU port, unlike what e8bf353577f3
observed?

The next patch in the series, "net: dsa: mt7530: trap frames to conduit in
MFC on EN7581 and AN7583", does not touch mt753x_trap_frames(). If this is
a problem, it is still there at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923055103.949540-1-gongtao0607%40gmail.com
