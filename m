Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065140;
	b=vye3TtyQ/8oRcKUYimWX1AwfVJeK2hsEqhj6GOYYjkfqH1GzCIxFhouuQvc09JQEuGUx
	 TB+CWeeyTjM4xdYHG8LIu2GL51s9WLIFl/bqEQ4TjjGbahJwQtAU0lcztMhdW174OIZOO
	 jxxkx3DGCMBEIxwnT9OKM+eNh78pRJ7PUKzyAPV5y07I2RAdTMVW5AuqimxIqi1ulgv8n
	 wgBADS4EY/4nWMorNPv8MDfftt+4QRJER4tiFLLn8QKvYyz/6YORQa93cepCP3c8cc7eu
	 XXHIgbVE7fIz4hbQO/PgKPkBjEiu967ux/mWBu8FwlyH4sOk80LH/6MrYfKHLwkIgbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065140;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EGZZxRv4iS7nfn58YHPsPMrErZTvelJOr3tVu6GnuA4=;
	b=R3C7KHzhwnRc+gHGZO3P6ChDu7bdY76LHUJtWo9Mst/4IxEqwYGgNlDEdE2iAxtfwcrH
	 PbgEKOLyzYjzh3exDTDd5+WtseqFF7nyGnevCKmwaWUUdCBBYqpZ+R/k2KmM7Cje4cj5L
	 P1MkK9MmRAFsvdwWcckEAW+HpMOlEDC83u4xdzOdkt6S8FRZ4Li3kL2R3+S10osxfjR5i
	 dA7AovRlG9+vWDKRbHcsLqVMlBvAb69yHezcEJZv330UJNXMg6uYSvV6+NPuwjPDZ6SV+
	 Efqzd2clIpnIo/vbmq8vyHhZLNIjlMmEQPRffSAjw7hL3lFD9h4vVtUCN5tK/dV7PGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpDHSTeB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A6606A31B;
	Tue, 27 Oct 2026 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpDHSTeB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C741F01829;
	Tue, 27 Oct 2026 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065140;
	bh=EGZZxRv4iS7nfn58YHPsPMrErZTvelJOr3tVu6GnuA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bpDHSTeBEI0yhHUmpw8NehZAkdrs0awlo6SXidZtszVGzrAos7nlkZAPjCfz0Qx5p
	 w9hxsw62N76IRw86JHgk+8gmegSZyoCRJ2fMmApi8G6NcSMJtnkiCT0H7a//MSCC6V
	 ld/HQEkeXdqFKOgQgmsFCgvVGNDJGrlG+9lRNZ5V5oqXKNmZ6/rl10xOMOMZb+WGzy
	 J5MdU0L4WF43Zf1/fd7dmokUEqQ+Qgxt3UqT4lBZKEaFUrHSAyjpgw5zU9x6yNZz8p
	 e/usB+sW1lQW95+uUzlMlRRZ9B5YL9FsM/CYMjesjJHdUsUl87TdQmFy2fdoO0KmJJ
	 +xwXYDZZIWMxg==
Subject:
 Re: [PATCH net] net: ethernet: mediatek: preserve sibling PPE bindings
From: netdev-bot+sashiko@kernel.org
To: alex@goodkind.io
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 tarick@bedeir.com
Date: Tue, 27 Oct 2026 01:38:58 +0000
Message-ID: <179306513862.3134.14236907013127690482@kernel.org>
In-Reply-To: <20261023012529.5994-1-alex@goodkind.io>
References: <20261023012529.5994-1-alex@goodkind.io>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the L2_SUBFLOW branch of
  __mtk_ppe_check_skb()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but L2 (bridge)
  flows never get the 0xffff 'unbound' sentinel in entry->hash.
- [Medium] This problem wasn't introduced by this patch, but
  mtk_flow_offload_stats() reads entry->hash without ppe_lock: once for…
- [Medium] This problem wasn't introduced by this patch, but the MIB read
  sequence in mtk_mib_entry_read() is not serialized.

--

net: ethernet: mediatek: preserve sibling PPE bindings

This commit changes the regular flow branch of __mtk_ppe_check_skb() so
that entry->hash is reset to 0xffff only when it matches the slot being
checked. The goal is to stop flows bound to sibling hardware slots in the
same software bucket from losing their slot association. That loss made
mtk_flow_offload_stats() skip their counter updates.

Link: https://github.com/openwrt/openwrt/pull/26107

> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index 8451dc3fd00aa..5fd1828401b47 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -764,7 +764,7 @@ void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 hash)
>  		}
>  
>  		if (found || !mtk_flow_entry_match(ppe->eth, entry, hwe)) {
> -			if (entry->hash != 0xffff)
> +			if (entry->hash == hash)

[Severity: High]
Does the L2_SUBFLOW branch just above this need the same treatment?

The commit message says that __mtk_ppe_check_skb() "clears entry->hash for
flows bound to other hardware slots in the same software hash bucket". The
patch only changes the regular flow branch, though. The subflow branch in
the same loop still does this:

drivers/net/ethernet/mediatek/mtk_ppe.c:__mtk_ppe_check_skb() {
    ...
	if (FIELD_GET(MTK_FOE_IB1_STATE, hwe->ib1) == MTK_FOE_STATE_BIND)
		goto out;

	hlist_for_each_entry_safe(entry, n, head, list) {
		if (entry->type == MTK_FLOW_TYPE_L2_SUBFLOW) {
			if (unlikely(FIELD_GET(MTK_FOE_IB1_STATE, hwe->ib1) ==
				     MTK_FOE_STATE_BIND))
				continue;

			entry->hash = 0xffff;
			__mtk_foe_entry_clear(ppe, entry);
			continue;
		}
    ...
}

The earlier goto out already guarantees that hwe at slot hash is not bound,
so the inner BIND check can never be true. As a result, every subflow in
foe_flow[hash / hash_offset] gets removed. That includes subflows whose own
entry->hash is a sibling slot that is still bound.

entry->hash is set to 0xffff before __mtk_foe_entry_clear() is called, so
the hardware invalidation in that function is skipped:

drivers/net/ethernet/mediatek/mtk_ppe.c:__mtk_foe_entry_clear() {
    ...
	hlist_del_init(&entry->list);
	if (entry->hash != 0xffff) {
		struct mtk_foe_entry *hwe = mtk_foe_get_entry(ppe, entry->hash);

		hwe->ib1 &= ~MTK_FOE_IB1_STATE;
		hwe->ib1 |= FIELD_PREP(MTK_FOE_IB1_STATE, MTK_FOE_STATE_INVALID);
		...
	}
    ...
	hlist_del_init(&entry->l2_data.list);
	kfree(entry);
}

The sibling slot then stays in MTK_FOE_STATE_BIND, and no software entry
tracks it anymore. mtk_flow_entry_update_l2() only walks the parent's
l2_flows, so the parent's idle time no longer reflects that traffic.

When the tc rule is deleted later:

mtk_flow_offload_destroy()
  mtk_foe_entry_clear()
    __mtk_foe_entry_clear()    /* walks entry->l2_flows */

the orphaned slot is never invalidated.

Can the PPE keep bridging that flow with the deleted rule's L2 rewrite data
and egress port for as long as traffic keeps the slot from aging out?

Freeing the subflow only takes an unbound packet that arrives at a sibling
slot in the same bucket and is handled from NAPI through
mtk_ppe_check_skb(). hash_offset is 2 on v1 SoCs and 4 on NETSYS v2 and
later.

Should the subflow branch also act only when entry->hash == hash, or check
the state of the subflow's own slot?

>  				entry->hash = 0xffff;
>  			continue;
>  		}

[Severity: Medium]
This is a pre-existing issue, but since this patch is about which
entry->hash values mtk_flow_offload_stats() trusts: do L2 (bridge) flows
ever get the 0xffff sentinel?

mtk_flow_offload_replace() allocates the entry with kzalloc_obj(), so
entry->hash starts at 0. For bridge flows, mtk_foe_entry_commit() returns
before it sets the sentinel:

drivers/net/ethernet/mediatek/mtk_ppe.c:mtk_foe_entry_commit() {
    ...
	if (type == MTK_PPE_PKT_TYPE_BRIDGE)
		return mtk_foe_entry_commit_l2(ppe, entry);

	hash = mtk_ppe_hash_entry(ppe->eth, &entry->data);
	entry->hash = 0xffff;
    ...
}

mtk_flow_offload_stats() then treats hash 0 as a bound slot:

	if (entry->hash != 0xFFFF &&
	    mtk_foe_entry_get_mib(eth->ppe[entry->ppe_index], entry->hash,
				  &diff)) {

mtk_ppe_start() enables MTK_PPE_MIB_CFG_RD_CLR, so each stats query on an
L2 rule read-clears MIB slot 0.

Does this credit the L2 flow with slot 0's traffic, and take those counts
away from the flow that is really bound at slot 0?

[Severity: Medium]
This isn't a bug introduced by this patch, but is it safe for
mtk_flow_offload_stats() to read entry->hash without ppe_lock?

The stats path holds only mtk_flow_offload_mutex. It reads entry->hash
twice: once for the 0xFFFF check and once as the index (see the snippet
above). __mtk_ppe_check_skb() writes entry->hash from NAPI while holding
only ppe_lock, so the two paths share no lock.

Suppose a concurrent rebind moves entry->hash from X to Y, or resets it to
0xffff in the branch changed here. The stats path can then read MIB slot X
after another flow has been committed there. Because the read clears the
counter, that other flow loses its counts.

There is also no READ_ONCE(). If the compiler reloads entry->hash between
the check and the call and sees 0xffff, mtk_foe_entry_get_mib() runs this
with index 0xffff:

drivers/net/ethernet/mediatek/mtk_ppe.c:mtk_foe_entry_get_mib() {
    ...
	acct = ppe->acct_table + index * size;

	acct->bytes += bytes;
	acct->packets += packets;
    ...
}

acct_table only has MTK_PPE_ENTRIES entries. Could this write past the end
of acct_table?

[Severity: Medium]
This is also a pre-existing issue, but is the MIB read sequence in
mtk_mib_entry_read() serialized against concurrent callers?

drivers/net/ethernet/mediatek/mtk_ppe.c:mtk_mib_entry_read() {
    ...
	val = FIELD_PREP(MTK_PPE_MIB_SER_CR_ADDR, index) | MTK_PPE_MIB_SER_CR_ST;
	ppe_w32(ppe, MTK_PPE_MIB_SER_CR, val);

	ret = mtk_ppe_mib_wait_busy(ppe);
	...
	cnt_r0 = readl(ppe->base + MTK_PPE_MIB_SER_R0);
    ...
}

There are two callers:

  - mtk_flow_offload_stats(), under mtk_flow_offload_mutex
  - mtk_ppe_debugfs_foe_show(), with no driver lock:

	acct = mtk_foe_entry_get_mib(ppe, i, NULL);

If the two calls interleave between the SER_CR write and the SER_R* reads,
can one caller get another slot's counters? The read is read-clear, so
those counts would also be lost for the slot that was actually requested.

The unlocked acct->bytes and acct->packets updates in
mtk_foe_entry_get_mib() also race with the zeroing that
__mtk_foe_entry_clear() does under ppe_lock:

	acct = ppe->acct_table + entry->hash * sizeof(*acct);
	acct->packets = 0;
	acct->bytes = 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023012529.5994-1-alex%40goodkind.io
