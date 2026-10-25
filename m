Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792927152;
	b=lLQoXng76EgC2h1UHHQ2/XrwjLIRF0jdvSFUG4NPD+92rvc7oT0uqxGHWWiygbBxin1G
	 oqI5XmZa9y73xIXAsA47fbnp31xMpsCwjqih2ywqrWcyMjWctZ2+gdaLYPkf3KRBGHEi5
	 gcz2oRpjtS5/Kz+MQv4gdJDyvehjBeJ3B2452A/YpTcgDuJdtm5EzRzgRCiJVqnBBm4jp
	 4pV2jOBEqRqzY6haV7LWar2JcEWJyTwYseBkkVH+BIHEdSp1K9UPBnlZiYJoJSqock2HD
	 7lXJZqq6YtmhXKtUWOhbHHl74FWFNA+5+k2jweeP1hVwcw5xZSX7r7CjZbt0KaNO4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792927152;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Icyxw/Y7tmxLQl0HivM3sVKqpdbnVUlAaBVaald5v4U=;
	b=ICBvtvPhYhlQxe16H65+v5edtF390Z1ALIAO+allaJ7ZbG0Rfxh99XYH0Li6JAX07xYb
	 6nAd9kFq1rPLFiCCPGAnUTBsAvcFMlMa/b8Wjd+G8o27qmBonp//OaLwAUyNNz+YutUPa
	 WIpOF9snhz5BQQHCnxU4bVKkXBHTCuFqIKFXxk2QVv69gn97sGZ3LgOlNdzs3OVAcGgsS
	 NbSRdUbtOK15YEeOJnPrqRYlNy0rQ11Fpr/UHMGzoDP/F9rd+FlsCe5iDzS08AqJLqh7l
	 +5VDFYslxIzPsw65rVjfe5jnTS1mBjhV2mlrpvMLjnIOFcEVWjqdWMbWmToAguMPRJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqcURr1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FC606A31A;
	Sun, 25 Oct 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqcURr1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3564C1F01828;
	Sun, 25 Oct 2026 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792927150;
	bh=Icyxw/Y7tmxLQl0HivM3sVKqpdbnVUlAaBVaald5v4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BqcURr1w1YtYxKaxN6avmz1gzoZxfbDuxcX0RuEiMPNclsx0UOcP3jcyeUPzHJ1Mq
	 BGH7blWvc+75el//KpmPhNPu7rcsFB4TSVr4lmO8JDO1TF5aIC5Dy3nyFLoNb+NxO0
	 xbbqF6EmE98n61z/O2cRRE0Ki1clCSwf8cr+0IGxkS2tsYRpuiNwD7+GZ6uXs5AA7S
	 0JTzgoEpO4oaStWDs4k78fR0yVlcwbUksBRU6MkbUm5zFZPEybwe6SjqfTVtHvXEDp
	 PVfHc+GNNQFnZ5KysjluhAYUBeRyiALlj1AcUblR15e25+UNGeUOsERgVbTgF7yt9q
	 8rukcNkFNdfOA==
Subject: Re: [PATCH net] octeontx2-af: Fix representor flow rule PF_FUNC mask
 and channel In representor mode, an AF-installed TX rule must still match on
 PF_FUNC, so do not clear the mask when rep_mode is set. Also, do not
 overwrite a channel already provided in the request when the rule comes from
 a representor device; only default to the PF/VF rx_chan_base when none is
 given.
From: netdev-bot+sashiko@kernel.org
To: kmahammadraf@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sgoutham@marvell.com,
 rkannoth@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, athapliyal@marvell.com
Date: Sun, 25 Oct 2026 11:19:09 +0000
Message-ID: <179292714974.3134.12015701378835588497@kernel.org>
In-Reply-To: <20261021091736.2406505-1-kmahammadraf@marvell.com>
References: <20261021091736.2406505-1-kmahammadraf@marvell.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The channel hunk in rvu_mbox_handler_npc_install_flow() (`if
  (from_rep_dev && !req->channel) req->channel = pfvf->rx_chan_base;`)…
- [Low] The commit bundles two unrelated fixes and gives them a single
  Fixes: tag that only matches one of them.
- [Low] The commit message has no blank line between subject and body.
- [Low] The comment above the changed condition in npc_update_tx_entry()
  still says 'If AF is installing then do not care about PF_FUNC in Send…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it stays in
  the representor TX path this patch is fixing.

--

octeontx2-af: Fix representor flow rule PF_FUNC mask and channel

When rvu->rep_mode is set, this patch keeps the PF_FUNC match on
AF-installed NPC TX rules instead of wildcarding it. It also changes
rvu_mbox_handler_npc_install_flow() for representor requests.
req->channel is now replaced with the target's rx_chan_base only when the
request leaves it at zero.

> octeontx2-af: Fix representor flow rule PF_FUNC mask and channel In representor mode, an AF-installed TX rule must still match on PF_FUNC, so do not clear the mask when rep_mode is set. Also, do not overwrite a channel already provided in the request when the rule comes from a representor device; only default to the PF/VF rx_chan_base when none is given.

[Severity: Low]
This isn't a bug, but there's no blank line between the subject and the
body. As a result, the whole paragraph becomes the subject line.

The first Signed-off-by is also:

  Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>

That doesn't look like a real name, and it isn't the author. If
kmahammadraf co-developed the patch, should there be a Co-developed-by:
tag next to it? If kmahammadraf is the original author, should the From:
line say so?

> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")

[Severity: Low]
The channel override does come from 6c40ca957fe5. Is that also the right
target for the PF_FUNC mask change?

The AF TX rules that need the PF_FUNC match were added in
rvu_rep_install_tx_rule() by commit 683645a2317e ("octeontx2-af: Add
packet path between representor and VF"). Those rules are installed with
req.hdr.pcifunc = 0, and only PF_FUNC tells them apart. The wildcard
itself goes back to commit fa2bf6baf2b1 ("octeontx2-af: Enable transmit
side LBK link").

Would it be cleaner to split this into two patches, each with its own
Fixes: tag? 683645a2317e and 6c40ca957fe5 went in on the same day, so
stable selection is probably not affected.

The commit message also doesn't describe the symptom. Before this patch,
the rte=true TX rule from rvu_rep_install_tx_rule() had no features and a
wildcarded PF_FUNC. It therefore matched every TX packet on that NIX TX
interface, and the first such entry (PF1) sent all PF/VF egress to the
LBK channel with PF1's VLAN tag.

Could the commit message mention that?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index d422bdd5e8f80..a569a63a21d9d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1397,7 +1397,7 @@ static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
>  	/* If AF is installing then do not care about
>  	 * PF_FUNC in Send Descriptor
>  	 */
> -	if (is_pffunc_af(req->hdr.pcifunc))
> +	if (is_pffunc_af(req->hdr.pcifunc) && !rvu->rep_mode)
>  		mask = 0;

[Severity: Low]
This isn't a bug, but the comment above still says AF-installed rules
don't care about PF_FUNC. When rep_mode is set, AF-installed TX rules now
match on PF_FUNC (mask = ~0ULL, value htons(target)), and
rvu_rep_install_tx_rule() relies on that.

Could the comment mention the rep_mode exception?

>  
>  	npc_update_entry(rvu, NPC_PF_FUNC, mdata, (__force u16)htons(target),

[Severity: High]
This is a pre-existing issue, but it remains in the representor TX path
this patch is fixing. PF_FUNC is now the only matched TX key field. Do all
the rte=false rules from rvu_rep_install_tx_rule() then end up with the
same MCAM key?

drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:rvu_rep_install_tx_rule() {
    ...
	req.hdr.pcifunc = 0; /* AF is requester */
	if (rte) {
		req.vf = pcifunc;
	} else {
		req.vf = rvu->rep_pcifunc;
		req.packet.sq_id = vlan_tci;
		req.mask.sq_id = 0xffff;
	}
    ...
}

No req.features are set, so npc_update_flow() returns before it programs
anything from req->packet:

	if (!features)
		return;

Nothing in af/ appears to put sq_id into the key either; there is no
NPC_SQ_ID key field. The only match left is PF_FUNC =
htons(rvu->rep_pcifunc), and that is the same for every representee.

rvu_rep_install_mcam_rules() installs one rte=false TX entry per
representee, in index order. rvu_mbox_handler_npc_install_flow() always
enables TX rules.

Assuming the lowest-index entry wins when several match, wouldn't egress
from every representor netdev hit the first enabled rte=false entry? It
would then get that representee's vtag0_def VLAN, go out on
RVU_SWITCH_LBK_CHAN, and be delivered to that single representee.

For example, frames that a bridge forwards to the Rpf1vf2 representor
would seem to reach a different function.

[ ... ]

> @@ -1846,7 +1846,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
>  
>  	pfvf = rvu_get_pfvf(rvu, target);
>  
> -	if (from_rep_dev)
> +	if (from_rep_dev && !req->channel)
>  		req->channel = pfvf->rx_chan_base;

[Severity: Medium]
Which representor requester sends a non-zero channel here? The only
in-tree sender seems to be otx2_tc_add_flow(). It is reached through
rvu_rep_setup_tc_cb(), which reuses the representor PF's otx2_nic:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:otx2_tc_add_flow() {
    ...
	req->channel = nic->hw.rx_chan_base;
    ...
}

rx_chan_base never seems to be set for the representor PF.
rvu_mbox_handler_nix_lf_alloc() jumps past nix_interface_init(), which is
the only place pfvf->rx_chan_base is assigned:

	if (is_rep_dev(rvu, pcifunc)) {
		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
		pfvf->tx_chan_cnt = 1;
		goto exit;
	}

So the rx_chan_base returned to the PF, which is copied into
hw.rx_chan_base, is 0. Every representor TC request still arrives with
channel == 0. It is still replaced with the representee's rx_chan_base,
as before this patch.

Does this hunk change anything for in-tree callers?

Can 0 safely mean "not provided"? NIX_CHAN_LBK_CHX(0, 0) evaluates to 0,
and CN10K uses it as hw->lbk_chan_base, so 0 is a valid LBK channel.
struct npc_install_flow_req also has no flag a caller could use to ask
for channel 0 explicitly.

If the representor PF ever reports a non-zero rx_chan_base, wouldn't
representee RX rules then match the representor PF's own channel rather
than the representee's? That would weaken the override that 6c40ca957fe5
added.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021091736.2406505-1-kmahammadraf%40marvell.com
