Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EE13DBBD
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999447; cv=none; b=JSx6czC4veDGZjDlWlkHxEEE7UgY97lf7RyvboYLefzHb/UVgqbHh9BxdVSojTPkRnqBTVCAZvNyJMc9LgSSUG8dugDhnsH/iVl/z6zXI7//yg8U8oJCnV+nqgHbg4Tl1Fm27rQ7Wy5Cmp3qvn4oLTKxklm6l++dFtBm8d+DGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999447; c=relaxed/simple;
	bh=Dd01nnMKsHbYG+fFuE5n8+Giv9U50m3XC6VHvdUuQ4Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gm/u1KaRfy6v1rslT1viLhSqdK0SHyScU8L2JcdydzE2lVxrLJldXKpQHIH0enmMrV+ckE0oj0r3G/V4dPZ3jvzt7xqTmFG7ltapEdvkYkSKijYD/bJCtSjaLe6zn/v48n6TJLSKqDNpqreQvbS98PeAMd3cD3FCq7Tr9PKXh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z82W8czO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z82W8czO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7B1F000FF;
	Thu, 10 Sep 2026 00:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999445;
	bh=wIcRVzykZl8RJaae6g9uy6+6Xtg29raxO7H6vqgnhx8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z82W8czOrGu0XRy9czqGTmobs31bx2ZKnWK6p3anbgUSJ0Ef4UNg7ZIJsqDIHrUi0
	 LlnAihpyhG5Oyn7o6P8a1PiApopibDB1tQBHOCSizJBLoCpnEH5Z/rqvKVWKH3sGCG
	 9ICuWgGSjbd5QkwLZb2XenHMAoxwadK0n+HVzcExdmLxhX3bxUE4amULu8plN7rJjq
	 HdyHrjtl0JChB4RsHmGtvzzi5aArOxoNH9pv5IaGGCI6c+tLIbYrGZuePJqJxBJWPr
	 B80wRE+rYkrUpndFKp/f3X4/BkSyDg3FhJVSXxl/Ej/rZz874pLpU1QfK/pfdYSNpX
	 24D1Kg4U1AXxQ==
Subject:
 Re: [PATCH net-next v1 1/6] net: dsa: mt7628: rework vlan block allocator
From: netdev-bot+sashiko@kernel.org
To: joey@tinyisr.com
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
 andrew@lunn.ch
Date: Thu, 10 Sep 2026 00:17:24 +0000
Message-ID: <178899944436.219967.14304454101193605482@kernel.org>
In-Reply-To: <20260906171625.533915-2-joey@tinyisr.com>
References: <20260906171625.533915-2-joey@tinyisr.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The tag_8021q VLAN-entry reservation in mt7628_setup()
  (drivers/net/dsa/mt7628.c:511-520) hard-codes…

--

net: dsa: mt7628: rework vlan block allocator

This reworks the MT7628 VLAN hardware entry allocator into
find/alloc/join/leave helpers, replaces the per-entry active flag with
vid == 0, and reserves the first six VLAN table entries for tag_8021q
use so the remaining entries can later serve VLAN filtering.

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> index fb63f6f644b9e..990556cc2f655 100644
> --- a/drivers/net/dsa/mt7628.c
> +++ b/drivers/net/dsa/mt7628.c

[ ... ]

> @@ -383,6 +390,82 @@ static void mt7628_esw_set_vub(struct mt7628_esw *esw, unsigned int vlan,
> +static struct mt7628_vlan *mt7628_alloc_vlan_block(struct dsa_switch *ds,
> +						   u16 vid, unsigned int type)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct mt7628_vlan *vlan;
> +	int i;
> +
> +	for (i = 0; i < MT7628_NUM_VLANS; i++) {
> +		vlan = &esw->vlans[i];
> +		if (vlan->vid)
> +			continue;
> +		if (vlan->type != type)
> +			continue;
> +		vlan->vid = vid;
> +		return vlan;
> +	}
> +
> +	return NULL;
> +}

[ ... ]

> @@ -425,6 +508,17 @@ static int mt7628_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Dedicate the first num_user_ports + 1 VLAN slots for tag_8021q.
> +	 * Since bridges are only offloaded when they have at least one member
> +	 * port, the worst case entry requirement is 1 per port. The extra slot
> +	 * is needed because when changing the configuration, tag_8021q adds a
> +	 * new VLAN before removing the old one. The rest of the VLAN slots can
> +	 * be used for filtering.
> +	 */
> +	for (int i = 0; i < MT7628_ESW_NUM_USER_PORTS + 1; i++)
> +		esw->vlans[i].type = MT7628_VLAN_TYPE_UNAWARE;
> +

[Severity: Medium]
Is the worst case really one entry per local user port plus one?

tag_8021q VIDs are not only generated for this switch's own ports.
dsa_tag_8021q_bridge_join() adds the bridge VID with broadcast = true:

net/dsa/tag_8021q.c:dsa_tag_8021q_bridge_join() {
	...
	err = dsa_port_tag_8021q_vlan_add(dp, bridge_vid, true);
	if (err)
		return err;

	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
	...
}

which reaches dsa_broadcast(), documented as notifying all DSA trees in
the system, and the per-port match is:

net/dsa/tag_8021q.c:dsa_port_tag_8021q_vlan_match() {
	return dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp) || dp == info->dp;
}

so this switch's CPU port installs an entry for every foreign bridge VID
and for every peer switch standalone VID in the same tree as well.

With the five local standalone VIDs from dsa_tag_8021q_port_setup()
occupying five slots and one foreign VID taking the sixth, does
mt7628_alloc_vlan_block() then return -ENOSPC for the next tag_8021q VID
even though ten hardware entries are still free?  The type match:

	if (vlan->type != type)
		continue;

prevents a tag_8021q request from ever falling back to the entries typed
MT7628_VLAN_TYPE_AWARE, and up to DSA_TAG_8021Q_MAX_NUM_BRIDGES == 7
distinct bridge VIDs can be broadcast.  Before this patch,
mt7628_dsa_8021q_vlan_add() could use any of the 16 entries, so the
reachable pool for these callbacks shrinks from 16 to 6.

Along the same lines, the commit message says:

    6 VLAN table entries are reserved for tag_8021q use and the rest are
    left for the upcoming VLAN filtering support. No functional change
    intended.

Given the reduced pool, is "no functional change intended" accurate for
configurations with a second tag_8021q tree or a cross-chip peer?

Would it make sense to derive the reservation from the ports DSA actually
instantiates (dsa_switch_for_each_user_port) and to let tag_8021q
requests fall back to unused entries of the other type, rather than
keying it off the constant MT7628_ESW_NUM_USER_PORTS while ds->num_ports
is MT7628_ESW_NUM_PORTS?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906171625.533915-1-joey%40tinyisr.com
