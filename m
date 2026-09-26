Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB254707C;
	Sat, 26 Sep 2026 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383646; cv=none; b=Nnv+cs435+eAiRwgPTM020AXAzYSz+Va4Pzu+foJhh1T1iefOXpEhBcT4omqIyGGlUdDAZabwRh1j6yV4zCBTc9xJ3t+f3wgGd9cuypC/CGhizosgcWQKWqd8KNmBS6htUVspRMPj1vc17YISnME1okTDHUXZMP7ykPl6qfUCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383646; c=relaxed/simple;
	bh=23bO/+CLdPu0CYpM8HNui2BgcbOaRyhBzz1tK1366Qo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=am72vwvlyKasijdpVEtWOqoikBcQE2M/judwHRmFpDF7gnuOn4OFhJxPCwDrM7ZGDLQIgUivxysTovSEuw8sIUUi8kcBU8QwjqmlrjP3rQxowDAUss3NIYOWR431GIqWj9K9il0bBcUnuqLffflocSnvg1L23A5fsqQnvMoqQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT3Befrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT3Befrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC431F000FF;
	Sat, 26 Sep 2026 00:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383645;
	bh=hAbNAe0Okm/8bA/d3euW48Qlo++Q3cBgINH96kw8ZTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eT3BefrfK7VfmxcECvlTzwCwv56aqkkPzOsexHi6qjsOP55XOub0iBnAA6pJOjGda
	 HvOgepbFfmY6mpfavbejXoNIioBOLEhUT3nZRolJgkq76xogecyUXTIYt6+QPRHq7r
	 mJYTD8b9WwW4ftze27CWNXzH7D3SdVToq6TnkGTd9+05T+iMSgV42OHBhcuMQyJsji
	 TBTKkFgrfkt3cgSTFdzzXmdDoaGkh8I6Mx4zEDPjFve7npZefYVzRvsKneNGh0Ljr4
	 EtPAjxpNAsS68wMXbFElvt08IJKmYZksSzOtJA2fPfv9iQ4e+R5+X6CVuHk3X3EmHu
	 xqJ/YoNVoWKCQ==
Subject:
 Re: [PATCH net v2] amt: do not store tunnel pointer in skb control block
From: netdev-bot+sashiko@kernel.org
To: cenzhang@linux.microsoft.com
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com
Date: Sat, 26 Sep 2026 00:47:23 +0000
Message-ID: <179038364383.2160803.12085088814406803245@kernel.org>
In-Reply-To: <20260922214150.13970-1-cenzhang@linux.microsoft.com>
References: <20260922214150.13970-1-cenzhang@linux.microsoft.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new identity-based re-lookup in amt_dev_xmit() can return
  a tunnel object that amt_request_handler() has published to the RCU…

Pre-existing issues:
- [High] amt_dev_stop() mutates amt->tunnel_list without holding
  amt->lock, racing with amt_tunnel_expire() which mutates the same list…
- [Medium] amt_dev_xmit() counts successfully transmitted packets as TX
  drops.

--

amt: do not store tunnel pointer in skb control block

This replaces the raw struct amt_tunnel_list pointer kept in skb->cb with
the tunnel identity (ip4 + source_port), and re-looks-up the tunnel under
RCU in amt_dev_xmit() so that an skb outliving its tunnel in a qdisc no
longer dereferences freed memory.  A few questions about the new lookup and
about surrounding code it now depends on.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index bddc24e1856de..b660cebf2484c 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -791,6 +791,18 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
>  	rcu_read_unlock();
>  }
>  
> +static struct amt_tunnel_list *amt_lookup_tunnel(struct amt_dev *amt,
> +						 __be32 ip4, __be16 source_port)
> +{
> +	struct amt_tunnel_list *tunnel;
> +
> +	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> +		if (tunnel->ip4 == ip4 && tunnel->source_port == source_port)
> +			return tunnel;
> +
> +	return NULL;
> +}
> +

[Severity: High]
This is a pre-existing issue and not introduced here, but since this new
lockless walk now depends on the integrity of amt->tunnel_list, is the list
actually consistently protected?

amt_tunnel_expire() deletes under amt->lock:

drivers/net/amt.c:amt_tunnel_expire() {
	spin_lock_bh(&amt->lock);
	rcu_read_lock();
	list_del_rcu(&tunnel->list);
	amt->nr_tunnels--;
	amt_clear_groups(tunnel);
	rcu_read_unlock();
	spin_unlock_bh(&amt->lock);
	kfree_rcu(tunnel, rcu);
}

amt_dev_stop() deletes the same entries with no lock at all, and only
cancels the per-tunnel gc work after it has already unlinked and while
other tunnels' gc works can still be running:

drivers/net/amt.c:amt_dev_stop() {
	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
		list_del_rcu(&tunnel->list);
		amt->nr_tunnels--;
		cancel_delayed_work_sync(&tunnel->gc_wq);
		amt_clear_groups(tunnel);
		kfree_rcu(tunnel, rcu);
	}
}

amt_dev_stop() does not disable the gc_wq of any tunnel before the loop
(only req_wq, discovery_wq, secret_wq and event_wq are cancelled earlier),
so a gc timer firing while the device is being brought down runs
amt_tunnel_expire() concurrently.  Can that give two list_del_rcu() calls
on the same entry, where the second __list_del_entry() writes through
LIST_POISON2, plus a double kfree_rcu() of the same tunnel?  And can the
concurrent unsynchronized list and nr_tunnels updates leave a stale next
pointer for amt_lookup_tunnel() and for the data-forwarding
list_for_each_entry_rcu() walk in amt_dev_xmit() to follow?

Would taking amt->lock around the amt_dev_stop() removals (and stopping the
gc work before unlinking) be the right fix?

[ ... ]

> @@ -1262,15 +1276,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto unlock;
>  	} else if (amt->mode == AMT_MODE_RELAY) {
>  		if (query) {
> -			tunnel = amt_skb_cb(skb)->tunnel;
> -			if (!tunnel) {
> -				WARN_ON(1);
> -				goto free;
> -			}
> -
> +			rcu_read_lock();
> +			tunnel = amt_lookup_tunnel(amt,
> +						   amt_skb_cb(skb)->tunnel_ip4,
> +						   amt_skb_cb(skb)->tunnel_port);

[Severity: Medium]
Can this lookup return a tunnel that amt_request_handler() has published but
not finished initializing?

amt_request_handler() sets only source_port and ip4 before publishing, and
writes nonce/mac after dropping amt->lock, at the send: label:

drivers/net/amt.c:amt_request_handler() {
	tunnel->source_port = udph->source;
	tunnel->ip4 = iph->saddr;
	...
	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
	tunnel->key = amt->key;
	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
	amt->nr_tunnels++;
	mod_delayed_work(amt_wq, &tunnel->gc_wq,
			 msecs_to_jiffies(amt_gmi(amt)));
	spin_unlock_bh(&amt->lock);

send:
	tunnel->nonce = amtrh->nonce;
	...
	tunnel->mac = mac >> 16;
}

amt_lookup_tunnel() matches purely on ip4 + source_port, and both are
already visible at list_add_tail_rcu() time.  So if an older query skb for
an expired tunnel is still sitting in a qdisc (the netem case from the
commit message) and the same gateway re-sends a Request from the same UDP
source port, can the dequeue on another CPU match the new, half-initialized
tunnel and build the query from the kzalloc'ed zeros?

drivers/net/amt.c:amt_send_membership_query() {
	amtmq->nonce	= tunnel->nonce;
	amtmq->response_mac = tunnel->mac;
	...
	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
}

The gateway then discards such a query:

drivers/net/amt.c:amt_membership_query_handler() {
	if (amtmq->nonce != amt->nonce)
		return true;
}

while the relay has already moved that tunnel to AMT_STATUS_SENT_QUERY.
Would completing the tunnel initialization (key, nonce, mac) before
list_add_tail_rcu(), or carrying the nonce as part of the identity stored in
skb->cb, close this window?

>  			/* Do not forward unexpected query */
> -			if (amt_send_membership_query(amt, skb, tunnel, v6))
> +			if (!tunnel ||
> +			    amt_send_membership_query(amt, skb, tunnel, v6)) {
> +				rcu_read_unlock();
>  				goto free;
> +			}
> +			rcu_read_unlock();
>  			goto unlock;

[Severity: Medium]
This isn't a bug introduced by this patch, but this goto unlock is the
success exit of the path being rewritten here, and it lands on the drop
counter:

drivers/net/amt.c:amt_dev_xmit() {
free:
	dev_kfree_skb(skb);
unlock:
	dev->stats.tx_dropped++;
	return NETDEV_TX_OK;
}

The free: label falls through into the same increment, so a query that was
successfully handed to udp_tunnel_xmit_skb() is counted as tx_dropped, the
same as one that was thrown away.  The gateway report path reaches the same
label after amt_send_membership_update() succeeds.  Since tx_dropped in
struct rtnl_link_stats64 is defined as packets dropped on their way to
transmission, and tx_packets/tx_bytes are never incremented for these
paths, should the success exits use a separate label that skips the
tx_dropped increment?

>  		}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922214150.13970-1-cenzhang%40linux.microsoft.com
