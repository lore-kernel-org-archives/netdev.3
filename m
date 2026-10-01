Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E534DE725
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849452; cv=none; b=pdx3I3kpwCNO61c77dwumkArSRMK0NR7CemgDDSPMxhuIyLrG9dU4dc3vfNbeayldsXW2lZ9aIVegoqBPE2d2ATM3tCJmwmOYZYqR84+ZYzv2QJq9F0sff6Pmi6Er4ydTwLtLNbW6pDwRNzsiZrSeCO8M2em2EZqe7NZSS9yeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849452; c=relaxed/simple;
	bh=qnl7VcWvHoUapi+jRBSd/YRNmFF7+tpX379eCe68dZY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGlS5sWJm8xgoIUhlJ25En8O3gxS6CUhmkLj7d9NNQqVwsfN9mlpAo7kMcPWywPVwXjDILQMUe6bxk5MWoqYLl8Ya4OVFJ2yMw8JmbSFwpsnL9mf04/kqQcoxJyOvsWQr6ufMmjnuILfrM/qYwc8gM/NY48T3xyK8ZQ7SOVLNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqYMfoNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqYMfoNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3058C1F0089C;
	Thu,  1 Oct 2026 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849432;
	bh=fpMTds00sH4UMw/mn/QzuCbttCqJBlbEwZkibMryaZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZqYMfoNGYZIH9AfdkSLRBqsKQ65nyCDUzTl/sIAOykz30OjPDqZsurzd/NXe/f3uI
	 NaOXGz8scYF5v2rgA/duP3AUI69CVMET4Ezor4YeJhYOTJBbWRvGFFIZPktbdU7ncw
	 3NGaT4rvUt6VzWFf/6lGvKNyvRcFSOcQWVj0oEo1WwjyVF6kLI2SSSxzDFo45Gq8WZ
	 P/2fGS3OXBp4uw1+S1bPfIotGV3ZVkEggGXHDhq7OF8cnLYyiuxSZjfnBanOtLhh8V
	 zTstkoxdK31DJl3uCOQBxU/S2jycHtiCtl6w+AvQFumG9YHsnCrcHu0EzAXYqUeOZg
	 xy163+cWFN2Yw==
Subject: Re: [PATCH net-next 8/9] batman-adv: tt: reject VLAN/TT entries
 before reaching size limit
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:31 +0000
Message-ID: <179084943174.434549.11209044496055868169@kernel.org>
In-Reply-To: <20260930094558.3723766-9-sw@simonwunderlich.de>
References: <20260930094558.3723766-9-sw@simonwunderlich.de>
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

- [Medium] batadv_tt_local_reserve() (net/batman-adv/translation-
  table.c:290) grows the new u16 counters bat_priv->tt.reserved_entries…
- [Low] The commit fixes a user-visible protocol failure but has no
  Fixes: tag and no stable Cc.

--

batman-adv: tt: reject VLAN/TT entries before reaching size limit

This commit replaces the unlocked size check in batadv_tt_local_create()
with a spinlock-protected reservation of room for VLANs and local TT
entries. The goal is that the local translation table always fits in a
full table response. VLAN creation in batadv_meshif_create_vlan() now also
has to reserve room, and it fails with -EMSGSIZE when no room is left.

> When enough VLANs + TT entries are created in parallel, then the TT will
> need more room then allowed for a full translation table reply. Other
> originators will then send regularly requests for a table sync but never
> get a reply.

[ ... ]

> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

[Severity: Low]
Should this have a Fixes: tag, and maybe a Cc to stable?

The racy check replaced in batadv_tt_local_create() only moved there with
the recent split of the local entry allocation. The check itself goes back
to when batman-adv first limited the local TT size and made TT VLAN-aware.

Other fixes in this series carry Fixes: tags, for example
"batman-adv: tt: queue local DEL event under bucket lock".

A backport of this patch would also depend on the batadv_tt_local_create()
split and on scoped_guard(). Could the commit message mention that as well?

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 481dc6afaaba1..3349376a9087d 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -234,6 +234,162 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,

[ ... ]

> +static bool batadv_tt_local_reserve(struct batadv_priv *bat_priv, u16 num_vlan,
> +				    u16 num_entries, int *table_size)
> +{
> +	int packet_size_max = READ_ONCE(bat_priv->packet_size_max);
> +
> +	scoped_guard(spinlock_bh, &bat_priv->tt.reserve_lock) {
> +		bat_priv->tt.reserved_vlans += num_vlan;
> +		bat_priv->tt.reserved_entries += num_entries;
> +
> +		*table_size = batadv_tt_local_transmit_size(bat_priv->tt.reserved_vlans,
> +							    bat_priv->tt.reserved_entries);
> +		if (*table_size <= packet_size_max)
> +			return true;

[Severity: Medium]
Can bat_priv->tt.reserved_entries wrap here?

The new counters in struct batadv_priv_tt are u16. The only bound on them
is packet_size_max, and nothing caps packet_size_max at what a single TT
TVLV can hold. When fragmentation is disabled, batadv_hardif_min_mtu()
skips the clamp:

net/batman-adv/hard-interface.c:batadv_hardif_min_mtu() {
	int min_mtu = INT_MAX;
	...
	if (READ_ONCE(bat_priv->fragmentation) == 0)
		goto out;
	...
out:
	...
	WRITE_ONCE(bat_priv->packet_size_max, min_mtu);
	...
}

In that case packet_size_max is INT_MAX when no hard interface is active.
Otherwise it is the raw MTU of the hard interface, which can be above
65535 (dummy has an unlimited max_mtu, for example).

Untrusted source MACs can create local entries, because
batadv_interface_tx() calls batadv_tt_local_add() for every non-multicast
source address:

batadv_interface_tx()
  batadv_tt_local_add()
    batadv_tt_local_create()
      batadv_tt_local_reserve_entry()
        batadv_tt_local_reserve()

If packet_size_max is above roughly 65535, the table can still grow past
what batadv_tt_prepare_tvlv_local_data() can build, because tvlv_len is a
u16:

	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
		tvlv_len = 0;
		*tt_len = 0;
		goto out;
	}

batadv_send_my_tt_response() then never sends the full table. Isn't that
the same "never get a reply" condition the commit message describes?

If packet_size_max is at least batadv_tt_local_transmit_size(v, 65535),
about 786KB (INT_MAX qualifies), the 65536th reservation wraps
reserved_entries to 0. From then on the counter holds the real count
modulo 65536, so the check keeps granting entries. If packet_size_max
later drops, the check also admits new entries that should be refused.

batadv_tt_local_table_transmit_size(), which
batadv_tt_local_resize_to_mtu() uses, also sums into a u16 and can wrap
the same way.

Would capping the limit at the u16 capacity of the TVLV, and saturating
or widening the counters, make the guarantee in the commit message hold?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
