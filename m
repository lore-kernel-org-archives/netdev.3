Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41B477281
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795978; cv=none; b=Vx2KOeJ62/tTFg/Ei7BlgfhAEqbHHReeL7yqe5LDaoj0niyiQSfLRnPY8uoFvteitorP96Uxk69g+6PBIe9zttECAL5eyRNFdFlVvaXem3ZyuBvmcjGHWtceA/xLbXDeImNCTAa9YNM/PUxGH1Iui09pfKILvxLSXe8iAhBTIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795978; c=relaxed/simple;
	bh=oQPBRAe9OPGAk4GrHZ+ZHhRQxdYSj+QM8N1aMXvyjjo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AH3Wwn7P4+EAFqhdzlhtM8JqHxqETEMgqkC3FFE/p7oKgz2GLoCJllHV6V2T/hq18NKFHwEuT+17qwg8qLY3rifSUeSmGbCRzilxNROqy5pCAzvt8eqI9zgA6wgWgzV2yEUxdwczrxfQOmdqNWkD6vDXJKaZLDWGkXjn1g8P7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROprIvcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROprIvcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980391F0089B;
	Mon, 12 Oct 2026 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795976;
	bh=tNVfYFqUQQ79c62yg7xF+W9zvW6Z+23ubhFAp9TN8QQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ROprIvcvENLp8bNoZBZTn8snyr3mN/lK2tjHjuFYc+/CAxsv2T/vupJPxZmiGq61F
	 m1hiCcb6EFstcPfUVoNTBHH5p/pNbqo8b0z1V2+hzoMQrw4foemOG78Ms7RdmWZAaG
	 9UXNiojPlhQ5g0eQNxaNzfs2QsdSTbLJqt2bo00egUhCXj5dknjVhZq84r1HineI4T
	 3JsMUN8d3GA0c5NG/mzUjD0ZlEWQylYXSR9PaP8YHO8JcvylzunSIY1bRJ15Q6MIZz
	 6Gxn0xnuLp4cfvgyAhlp8fFEE38TdBLMwAYXPq5qTEVFx89wtlAto0VbOH7o935KUA
	 xuM07SqYugGSg==
Subject: Re: [PATCH net] macsec: ignore inactive receive secure channels
From: netdev-bot+sashiko@kernel.org
To: tjdqudcks0424@naver.com
Cc: sd@queasysnail.net, netdev@vger.kernel.org, kuba@kernel.org
Date: Mon, 12 Oct 2026 09:06:16 +0000
Message-ID: <179179597621.434549.15908000438396641185@kernel.org>
In-Reply-To: <20261008082612.350120-1-tjdqudcks0424@naver.com>
References: <20261008082612.350120-1-tjdqudcks0424@naver.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the md_dst offload path, frames that the hardware has already
  decrypted are now passed in plaintext to the lower (uncontrolled)…
- [High] The revocation the commit claims ('An active child RXSA can
  therefore authenticate and deliver frames after userspace has…
- [Medium] An inactive RXSC is sent to the unknown-SCI ('nosci') fallback
  and is not dropped against the SecY that owns it.
- [Low] The patch adds a marked lockless read, `READ_ONCE(rx_sc->active)`
  in find_rx_sc() (drivers/net/macsec.c:992), on the RCU/softirq receive…
- [Low] The AI-assistance tag does not use the documented format.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but offload
  drivers that walk secy->rx_sc use `rx_sc && rx_sc->active` as the for-…

--

macsec: ignore inactive receive secure channels

This commit makes find_rx_sc() return an RXSC only when its active flag
is set. The goal is that frames for an RXSC disabled by userspace are no
longer authenticated and delivered. The RTNL configuration lookup is
left unchanged.

> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Assisted-by: OpenAI Codex

[Severity: Low]
This isn't a bug, but Documentation/process/coding-assistants.rst gives
the tag format as:

  Assisted-by: LLM [TOOL1] [TOOL2]

The optional entries are analysis tools such as coccinelle, sparse,
smatch or clang-tidy. Should the tag follow that format?

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 78a19b1346321..02157c97e0004 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -989,7 +989,7 @@ static struct macsec_rx_sc *find_rx_sc(struct macsec_secy *secy, sci_t sci)
>  	struct macsec_rx_sc *rx_sc;
>  
>  	for_each_rxsc(secy, rx_sc) {
> -		if (rx_sc->sci == sci)
> +		if (rx_sc->sci == sci && READ_ONCE(rx_sc->active))

[Severity: High]
find_rx_sc() has a second caller, the md_dst offload branch of
handle_not_macsec(). Before this patch, NULL there meant the SCI did not
belong to this SecY. Now it also means the SecY owns the SCI but the
RXSC is inactive:

drivers/net/macsec.c:handle_not_macsec() {
    ...
			if (is_macsec_md_dst) {
				...
				rx_sc = find_rx_sc(&macsec->secy,
						   md_dst->u.macsec_info.sci);
				if (!rx_sc)
					continue;
				/* device indicated macsec offload occurred */
				skb->dev = ndev;
				...
				ret = RX_HANDLER_ANOTHER;
				goto out;
			}
    ...
}

When no SecY matches, ret stays RX_HANDLER_PASS and the skb goes up the
lower device. On mlx5 the NIC has already decrypted that skb and
stripped the SecTAG and ICV.

Can this deliver decrypted plaintext on the uncontrolled port, possibly
in a different netns, instead of on the macsec netdev? No MACsec counter
would record it.

The NIC seems to keep decrypting for an inactive RXSC.
mlx5e_macsec_add_rxsa() installs the decrypt rule based only on the RXSA
active flag:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:mlx5e_macsec_add_rxsa() {
    ...
	rx_sc->rx_sa[assoc_num] = rx_sa;
	if (!rx_sa->active)
		goto out;
	...
	err = mlx5e_macsec_init_sa(ctx, rx_sa, true, false, &rx_sc->sc_xarray_element->fs_id);
    ...
}

mlx5e_macsec_upd_rxsa() calls macsec_rx_sa_active_update() with
ctx_rx_sa->active and also ignores the parent RXSC.
mlx5e_macsec_offload_handle_rx_skb() attaches rx_sc->md_dst based only
on the fs_id lookup.

So if the RXSC is created off (or set off) and an RXSA is then added or
enabled, a hardware decrypt rule stays live. Its output would now reach
the lower device.

There is also a window in macsec_upd_rxsc(). It stores

		rx_sc->active = new;

before mdo_upd_rxsc() removes the hardware rules. Frames already in the
RX rings at that point would take the same path.

Would it be better to leave find_rx_sc() alone for this caller? Known
but inactive SCs could be dropped and counted instead, or the active
check could be applied only in the software decrypt lookup in
macsec_handle_frame().

The commit message describes the change as limited to "the receive-only
RCU lookup" and does not mention the offload datapath.

[Severity: Medium]
In macsec_handle_frame(), a NULL return for the inactive RXSC leaves
secy NULL, so the frame takes the unknown SCI path:

	if (!secy)
		goto nosci;
	...
nosci:
	/* 10.6.1 if the SC is not found */
	cbit = !!(hdr->tci_an & MACSEC_TCI_C);
	if (!cbit)
		macsec_finalize_skb(skb, MACSEC_DEFAULT_ICV_LEN,
				    macsec_extra_len(macsec_skb_cb(skb)->has_sci));

	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
		...
		if (cbit ||
		    macsec->secy.validate_frames == MACSEC_VALIDATE_STRICT) {
			...
			secy_stats->stats.InPktsNoSCI++;
			...
			continue;
		}
		...
		nskb = skb_clone(skb, GFP_ATOMIC);
		...
		macsec_reset_skb(nskb, macsec->secy.netdev);

		ret = __netif_rx(nskb);
		...
			secy_stats->stats.InPktsUnknownSCI++;
		...
	}
	...
	return RX_HANDLER_PASS;

Take validate_frames set to check or disabled and a frame with C=0. Is
such a frame for a disabled SC now de-tagged and delivered with no ICV
or replay check to every non-strict SecY on the lower device, not only
the owner? It would also be passed to the uncontrolled port.

The commit message says "All three fixed runs rejected the frame". That
seems true only for the default strict mode.

The InPktsNoSCI and InPktsUnknownSCI uAPI counters, and rx_errors, would
also be bumped on every SecY sharing the lower device. That traffic is
for an SC that is configured, and nothing is counted against the owning
RXSC.

Implicit SCI frames are handled differently. macsec_active_sci() maps a
single inactive RXSC to sci 0, which leads to a hard drop via
drop_nosc:

		return (rx_sc->active) ? rx_sc->sci : 0;

Explicit SCI frames for the same channel go to nosci instead and may be
delivered.

Could macsec_handle_frame() detect the known but inactive SC and handle
it against the owning SecY?

[Severity: High]
The commit message says:

  An active child RXSA can therefore authenticate and deliver frames
  after userspace has administratively disabled the RXSC.

Is this closed for offload devices that don't use md_dst? For them,
handle_not_macsec() moves frames to the macsec netdev by DMAC,
multicast or promisc matching and never calls find_rx_sc(). Enforcement
is then left to the driver's hardware SC tables.

In atlantic, aq_set_rxsc() always marks the SC record valid and never
reads rx_sc->active:

	sc_record.valid = 1;
	sc_record.fresh = 1;

aq_mdo_upd_rxsc() just calls aq_set_rxsc(). So "ip macsec set ... rx sci
X off" seems to succeed in software while the hardware keeps validating
and delivering SC X.

In mscc, vsc8584_macsec_add_rxsc() ignores ctx->rx_sc->active:

static int vsc8584_macsec_add_rxsc(struct macsec_context *ctx)
{
	/* Nothing to do */
	return 0;
}

vsc8584_macsec_add_rxsa() then calls vsc8584_macsec_flow_enable()
unconditionally. An RXSC created off with an active RXSA would still
have its traffic validated and delivered. vsc8584_macsec_upd_rxsc()
returns -EOPNOTSUPP, so disabling an existing RXSC is rolled back.

The core also passes RXSAs under an inactive RXSC to mdo_add_rxsa and
mdo_upd_rxsa without masking their active state.

Should the fix cover these offload paths, or should the commit message
be limited to the software datapath?

[Severity: Low]
This isn't a bug, but this READ_ONCE() has no matching WRITE_ONCE().
create_rx_sc() and macsec_upd_rxsc(), including its cleanup rollback,
all write the field with plain stores under RTNL:

	rx_sc->active = active;
	...
		rx_sc->active = new;
	...
	rx_sc->active = was_active;

macsec_active_sci(), the other lockless reader on the RX path, still
uses a plain load:

		return (rx_sc->active) ? rx_sc->sci : 0;

Should the writers use WRITE_ONCE(), and macsec_active_sci() use
READ_ONCE(), so the field is marked the same way everywhere?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
it also involves the RXSC active flag. Several offload drivers use
rx_sc->active as the loop condition when walking secy->rx_sc. The first
inactive RXSC therefore ends the walk instead of being skipped:

drivers/net/ethernet/aquantia/atlantic/aq_macsec.c:aq_apply_secy_cfg() {
    ...
	for (rx_sc = rcu_dereference_bh(secy->rx_sc); rx_sc && rx_sc->active;
	     rx_sc = rcu_dereference_bh(rx_sc->next)) {
    ...
}

cn10k_mcs_secy_rx_cfg() and cn10k_mcs_disable_rxscs() in cn10k_macsec.c
use the same pattern:

	for (sw_rx_sc = rcu_dereference_bh(secy->rx_sc); sw_rx_sc && sw_rx_sc->active;
	     sw_rx_sc = rcu_dereference_bh(sw_rx_sc->next)) {

create_rx_sc() inserts at the list head, so one inactive RXSC hides
every older RXSC. That has three effects:

- After link down and up, aq and cn10k would not reprogram the active
  RXSCs behind it.
- On cn10k mdo_stop, those RXSCs would stay enabled in hardware.
- On cn10k mdo_del_secy with delete=true, their hardware SC entries and
  mcs_rx_sc structs do not appear to be freed.

Should these loops skip inactive entries with continue instead?

>  			return rx_sc;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008082612.350120-1-tjdqudcks0424%40naver.com
