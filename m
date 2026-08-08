Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17D411A0E;
	Sat,  8 Aug 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218518; cv=none; b=EzR6QelblGKpkdrVFUnfyu4RpzmUSaErqS7seJ9FCXo1acNue1TXoWqxHMSUKmJPoCMSAtVFv2l+LjISzXJj8Fa5Q+kNUtzHlzDCeZAqHKB+IotKw4W8fxrneqsiTAK+QdHmtHxVERjZ/WWaHBNASqJF/mDmWK10oMDGIO4iaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218518; c=relaxed/simple;
	bh=eFFUrRB2eKMRGI826EW8wtLESBysi71w7L/MJBTwQ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOdNngJACPBTZBAcIMPyQei4ZwOrRiMkfAea+NWA/9YJeSG+GTF/MLKub79bJgdrcQA26wx8+Tq6SMr7lCKElmspMlcn+DMNTh/2Im9QN+AxxW9m6813PExyiGtEzm+8m7n/sg3YghCmTOYAV3fjApNJX2ADlmtLw6byZ0xBVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjNOyQTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjNOyQTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FBA1F000E9;
	Sat,  8 Aug 2026 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218516;
	bh=HkG24IuS/cXRnM8AKVT21aew/klEJTV2R59N/Od1Fq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjNOyQTqrj24GngCi8H84lU8cq3jhzsLkPxlL5L3F1NIKwZUm9c4my/kZi+lfN/ik
	 gCEF6SYHHxbxxAx6ANhXv5K6R3jQ3rIr+rmos0BYmbhqWradGbiK8XUYA2mUlI0D1w
	 V/jKlOmS1Eb1C1NFUXRsMTJpixJWvxaM+IySgKfRXnMwqttl7BjK23/rI6JCY8hvA0
	 6Mhhd3Uj8JYjXUCLzS+V04wdkrogSOWTSSvV67ajizN2xYJ+G8JLdF+4b/eLVVjLl1
	 cCGbqMy1zaZxNbq2d8408zTc5PkcItHXpI36rsTH/gKGzqngJfJz7OQExSgCI3dulG
	 HcV9OANtjh+NQ==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 17/20] net: dsa: xilinx: opt into TX forwarding offload on bridge join
Date: Sat,  8 Aug 2026 12:48:35 -0700
Message-ID: <20260808194835.133470-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-18-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-18-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: xilinx: opt into TX forwarding offload on bridge join

The patch adds xlnx_tsn_port_bridge_join() which unconditionally sets
*tx_fwd_offload = true, so the bridge sends a single copy and relies on the
switch fabric for per-port replication.  It also sets ds->max_num_bridges
to 1 in xlnx_tsn_probe().

A few questions below.

> diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
> index e48c81f18d6e..9a4d4a2fb892 100644
> --- a/drivers/net/dsa/xilinx/xilinx_tsn.c
> +++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
> @@ -495,6 +495,19 @@ static int xlnx_tsn_port_set_mac_address(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static int xlnx_tsn_port_bridge_join(struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
> +{
> +	/* The switch fabric replicates flooded frames per egress port
> +	 * on its own, so the bridge does not need to clone-and-send.
> +	 */
> +	*tx_fwd_offload = true;

[Severity: High]
Does this drop PTP frames on all user ports but one?

The comment's premise does not seem to hold for the frame class the tagger
diverts.  In net/dsa/tag_xlnx_tsn.c, xlnx_tsn_xmit() takes untagged
ETH_P_1588 frames out of the fabric path entirely:

	if (eth_hdr(skb)->h_proto != htons(ETH_P_1588) ||
	    skb_vlan_tag_present(skb))
		return skb;

	tagger_data->ptp_tx(dp, skb);

	return NULL;

That handler, xlnx_tsn_ptp_tx() in
drivers/net/dsa/xilinx/xilinx_tsn_ptp.c, writes into the TX buffer of one
specific MAC:

	m = &sw->mac[dp->index];

so the frame goes into the per-port PTP TX FIFO of the single egress MAC
and never reaches the fabric that would replicate it.

Before this patch the bridge cloned a flooded frame once per member port,
so each clone landed in its own MAC's PTP FIFO.  With
BR_TX_FWD_OFFLOAD requested, net/bridge/br_switchdev.c suppresses the
remaining copies for the same hwdom:

	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
		set_bit(p->hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
	...
	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);

With br0 containing both swp1 and swp2, an untagged PTP frame flooded from
another bridge port then loads only one MAC's PTP FIFO and the other user
port transmits nothing, with no counter or log for the loss.  Should PTP
traffic be excluded from the offload, or should the tagger encode a flood
so the second copy is regenerated?

> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -786,6 +800,9 @@ static int xlnx_tsn_probe(struct platform_device *pdev)
>  	ds->phylink_mac_ops = &xlnx_tsn_phylink_mac_ops;
>  	ds->priv = sw;
>  
> +	/* The fabric offloads a single bridge across the user ports. */
> +	ds->max_num_bridges = 1;

[Severity: Medium]
The commit message says:

  "Set ds->max_num_bridges to 1 so the DSA core rejects a second bridge
  instead of silently merging the ports."

Does the core actually reject it?  In net/dsa/port.c,
dsa_port_bridge_create() only returns -EOPNOTSUPP when the bridge number
allocation comes back empty:

	bridge->num = dsa_bridge_num_get(br, ds->max_num_bridges);
	if (ds->max_num_bridges && !bridge->num) {
		NL_SET_ERR_MSG_MOD(extack,
				   "Range of offloadable bridges exceeded");
		kfree(bridge);
		return -EOPNOTSUPP;
	}

and dsa_user_changeupper() in net/dsa/user.c turns that into success:

			if (err == -EOPNOTSUPP) {
				NL_SET_ERR_MSG_WEAK_MOD(extack,
							"Offloading not supported");
				err = 0;
			}

So "ip link set swp2 master br1" succeeds and the port joins br1
unoffloaded with dp->bridge rolled back to NULL.  Since the driver
programs no hardware forwarding domain (the new
xlnx_tsn_port_bridge_join() touches no register and ignores its bridge
argument), and dsa_port_enable_rt() puts a non-bridged port into hardware
forwarding:

	if (!dp->bridge)
		dsa_port_set_state_now(dp, BR_STATE_FORWARDING, false);

both MACs stay forwarding and the fabric keeps bridging them.  Does this
mean the two L2 domains are merged in hardware anyway, which is the case
the commit message claims is prevented?  If rejection is the intent,
would the driver need to track the offloaded bridge in port_bridge_join
and return something other than -EOPNOTSUPP (for example -EBUSY) with an
extack?

[Severity: Medium]
Is max_num_bridges = 1 workable given the bridge number allocator is
system-global rather than per-switch?  In net/dsa/dsa.c,
dsa_bridge_num_get() picks the lowest free bit of the file-scope
dsa_fwd_offloading_bridges bitmap and compares that global index against
this driver's max:

		bridge_num = find_next_zero_bit(&dsa_fwd_offloading_bridges,
						DSA_MAX_NUM_OFFLOADING_BRIDGES,
						1);
		if (bridge_num > max)
			return 0;

With max == 1 the only acceptable global index is 1.  If any other DSA
switch, or a second instance of this platform driver, already holds global
bridge number 1, then the very first bridge on this switch gets index 2,
2 > 1, and dsa_port_bridge_create() returns -EOPNOTSUPP, so
xlnx_tsn_port_bridge_join() is never called and *tx_fwd_offload is never
set.  dsa_user_changeupper() rewrites the error to 0, so the join looks
successful while the bridge silently resumes clone-and-send and the wire
sees duplicated frames again.

Other drivers size max_num_bridges from a hardware resource count (for
example DSA_TAG_8021Q_MAX_NUM_BRIDGES or ds->num_ports).  Would that be
more appropriate here?
