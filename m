Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999474;
	b=KGRqYZtaWqNQATDDj5bxP33mUqUKh9pJwq6oeDg92JQgMCkim1D0RctA3lEKSzsJRSIa
	 Gi8+XUiisfN3UmG3c9Zv24ASfe13k4fK7p+0R3i51uSoMBIpIKB3jANgGm6nbnGsnMVO+
	 KjIeciS864jda20xpjG5yfrNhZU2wBULCr8oDAnnVP4gv3qlsdj8DYzalxiOmO9+H5QOB
	 958jVZmM57StF/+c8ufqtaXv0PL4eaDDfS35BQ02X+WmjVk5nX57zkvFTqNk0zUasbPgP
	 1nMuC2xmzTZW7I1PmdwtOaY6rVNPUv4eMKEiTtvQb1IPzZExIkr6dzvSMjEkF/SUmzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999474;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RZGpFzKZl+KjUUy06+TwAJ42tacxdNOCCa1aBYxsIy8=;
	b=wow9VDpriHZTPSnhK0+0dd64Z/Nar681eiEhfXVpnZrU6nEZbMgbHwcvDU1aUE6kRT3e
	 9PRF4u+pIGhWkoUL12skxGhJxGOOk9VuVznmMJrvjjchz9p0PfR5LgiOcFCzppT0+d53n
	 HHNBsM97skfYuRwKcRlFuS0LTTYFescD2XOoiYKK1LaIpysKqgqwGoiPD3TAUYj2OYbB1
	 H/IIy82gEmi7YW38HxqnGSnUmbz+vFN/RSIUYu8AM8kSAqayTENE8nWTb9fLgh01hWWC+
	 FEF2/YbUMqhfUSaJ45o2hH1madeiK72G0D7L2PfsuCKAXp1ENBfrsZpZ/nI0ZcC7nLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvV8R9CB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCB606A31B;
	Mon, 26 Oct 2026 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvV8R9CB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8689F1F01825;
	Mon, 26 Oct 2026 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999474;
	bh=RZGpFzKZl+KjUUy06+TwAJ42tacxdNOCCa1aBYxsIy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CvV8R9CBR1eYI+aWr6Qp6lof4Wke04swz3qvCZ7iSvAEGD6f68s313+uMhuAciwek
	 a1HO2DPG8IsRpfVHxEyBXyTBTSFSNkjwNVh87klHXBVWq7eWFX33s+OQtheKLeXZcx
	 l+KnDFUL/24gSdLYZnNJ9enW+ZTedg20nm3NoYJdSikiIQ1L3Zs/DwnomXZDptKaH8
	 7rS8tJyp6Z+tLYagPakbex259rUfXm9IB31fH3R08ea1q0RsP5ubYj6fawjosKBWQo
	 F6RpRRd8ntWmRmBW3teWLHW/59Zs4/GAmjpoiYqlZDRCF5E/D5LwM7htoqRHU9KzzA
	 PuXiTDxJKUUWQ==
Subject:
 Re: [PATCH net] net: dsa: clear the conduit RX queue on user port receive
From: netdev-bot+sashiko@kernel.org
To: dencity7@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 07:24:33 +0000
Message-ID: <179299947310.3134.16517017879498438401@kernel.org>
In-Reply-To: <20261025072203.1519561-1-dencity7@gmail.com>
References: <20261025072203.1519561-1-dencity7@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "TX queue selection is unaffected: the
  user port's own netdev_pick_tx() sets queue_mapping again before the…
- [Medium] The fix is incomplete because one delivery path in
  dsa_switch_rcv() skips it.

--

net: dsa: clear the conduit RX queue on user port receive

This commit resets skb->queue_mapping to 0 in dsa_switch_rcv() before the
skb is handed to the user port. Without the reset, the RX queue index
recorded by a multi-queue conduit makes get_rps_cpu() skip RPS on the
single-RX-queue user port.

> Clear the queue mapping when the skb is handed to the user port. TX
> queue selection is unaffected: the user port's own netdev_pick_tx() sets
> queue_mapping again before the conduit transmits.

[Severity: Medium]
Does this hold for skbs that arrive on a user port and are then forwarded
by a software bridge or by routing?

skb_set_queue_mapping(skb, 0) marks the skb as having no recorded RX
queue. That is not the same as skb_record_rx_queue(skb, 0).

On the egress device, netdev_pick_tx() falls back to skb_tx_hash() when
there is no socket queue and no XPS choice. skb_tx_hash() uses the
recorded RX queue when there is one:

net/core/dev.c:skb_tx_hash() {
    ...
	if (skb_rx_queue_recorded(skb)) {
		DEBUG_NET_WARN_ON_ONCE(qcount == 0);
		hash = skb_get_rx_queue(skb);
		...
		return hash + qoffset;
	}

	return (u16) reciprocal_scale(skb_get_hash(skb), qcount) + qoffset;
}

dsa_user_create() allocates user ports with ds->num_tx_queues TX queues,
and user ports have no ndo_select_queue. So forwarded flows now pick their
egress TX queue by flow hash, not by the conduit RX ring.

Several taggers write skb_get_queue_mapping() into the switch tag:
tag_brcm, tag_ksz, tag_sja1105, tag_ocelot_8021q, tag_netc and
tag_vsc73xx_8021q. For those, the switch egress queue changes too.

Socket RX queue tracking also looks affected. With
CONFIG_SOCK_RX_QUEUE_MAPPING, __sk_rx_queue_set() only updates
sk_rx_queue_mapping when an RX queue is recorded:

include/net/sock.h:__sk_rx_queue_set() {
	if (skb_rx_queue_recorded(skb)) {
		u16 rx_queue = skb_get_rx_queue(skb);
	...
}

After this change, sockets fed by user ports never get an RX queue
recorded. That includes traffic from conduit queue 0, which used to record
rxq 0, and it changes XPS rxqs selection.

The new behaviour may well be better. Since the patch has a Fixes: tag and
will probably be backported, could the changelog describe these side
effects? Could it also say why "not recorded" was chosen over recording
queue 0?

> diff --git a/net/dsa/tag.c b/net/dsa/tag.c
> index 6a5aa7fc331c3..ecd4d86696acc 100644
> --- a/net/dsa/tag.c
> +++ b/net/dsa/tag.c
> @@ -115,6 +115,12 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
>  		skb = nskb;
>  	}
>  
> +	/* The conduit's RX queue index means nothing on the user port, which
> +	 * has a single RX queue, and get_rps_cpu() skips RPS when the index
> +	 * is out of range.
> +	 */
> +	skb_set_queue_mapping(skb, 0);

[Severity: Medium]
Is the case where skb->dev is not a DSA user port missed here? Earlier in
dsa_switch_rcv(), this branch returns before the reset is reached:

	if (unlikely(!dsa_user_dev_check(skb->dev))) {
		/* Packet is to be injected directly on an upper
		 * device, e.g. a team/bond, so skip all DSA-port
		 * specific actions.
		 */
		netif_rx(skb);
		return 0;
	}

For trunk-tagged frames, dsa_rcv_ll() in net/dsa/tag_dsa.c sets skb->dev
straight to the LAG netdev:

		lag = dsa_lag_by_id(cpu_dp->dst, source_port + 1);
		skb->dev = lag ? lag->dev : NULL;

Take a multi-queue conduit such as fec, which calls
skb_record_rx_queue(skb, rxq->bd.qid) in fec_enet_rx_queue(). The skb
reaches netif_rx() on the bond/team with the conduit's RX queue index
still set.

get_rps_cpu() then compares that index against the bond/team's
real_num_rx_queues. That value is set separately (numrxqueues, default
16) and has nothing to do with the conduit.

There are three possible outcomes:

- RPS is skipped silently, the same symptom this patch fixes for user
  ports.
- If the bond has more than one RX queue but fewer than the conduit ring
  index, the WARN_ONCE in get_rps_cpu() fires.
- Otherwise, the RPS map of whichever bond/team rx-N queue matches the
  conduit ring number gets used.

Would moving the reset to right after skb = nskb, before the
dsa_user_dev_check() branch, cover both paths?

> +
>  	dev_sw_netstats_rx_add(skb->dev, skb->len + ETH_HLEN);
>  
>  	if (dsa_skb_defer_rx_timestamp(p, skb))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025072203.1519561-1-dencity7%40gmail.com
