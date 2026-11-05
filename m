Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875436;
	b=kWyObikN+zx7gNoTGHSQnOlRathTN9ARrMAfcS0Rng+T+H7RtUiZxAiFNhSBfWgabKjs
	 GMnNgkJxEE4VHbUE8KVb1HMHNTKaZAlgaZtWYma8b8zf9q9dO6Vo7Tl1YrPJJqphpCieE
	 QO1zUT159r47R1cOTcH8X7V3y2iR5YsZUd+u8mLngP7eiIeA/p1ssC3XQHHzOA3y9Lpfb
	 TnDHASxrq7t86FmRv10C7leZXg7Ih38XeRYPRBVibfdUYsfOYoan9932dJjwHU8uJvMxD
	 w3wdFjfoxSG+7LYMO4vmG979TIXo1ClaMG8rGDs1ktvX32C9psPDzDgBn8T/CkyEXsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875436;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QArlAi6MbjfVU6KOdHDQA66AQpnhOjn4lV2l5iq9aZM=;
	b=KRXdJAUK8vtQvC0GnM4YISG5Dc9ah/xpppnC029wcrCBMzoJlrvJPG4YHVKOX3m7d5JI
	 FO0Ih9lWqMIy5SPoZCXrLdEmQwp7wf+BU6nFA685tz+r/52ZMJvtXFMk6g7mU5YlHEl8r
	 K4ZDM4A/irRMKPxE90q9jkIyfmFj+JvpItsqf1nCL1IB9grCP89ql26QDTSLlpPtDdi3/
	 0PJ3cvJ+ttQsXzG1TOWyY594moIg0Q5CBxUt1EsjCjFYxdrmbmtA4S2WL0mTjJMClKHcG
	 fsRy86NuKU4OR67/No085Fxzw6hy1b8Ldn00/EQrST0YfgSALXa4FF8mBlDz4cyaKqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+e5XU+M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4795606EE8E;
	Thu,  5 Nov 2026 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+e5XU+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F3D1F0093A;
	Thu,  5 Nov 2026 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793875435;
	bh=QArlAi6MbjfVU6KOdHDQA66AQpnhOjn4lV2l5iq9aZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f+e5XU+MbWyZunSuDip9m3QvXk8fBw3HkL9gyXdGkNsjBKpl6THC5MAXqE5pZMgjm
	 TQ+Bl9McH2nFfySR4NsUA1tvD78J1DYL4qF3ccckJFxadUBv9ij4V7wxjNww2vQha5
	 BFUba+fQYSG6Yl3Pr5vC98YETV3Wk4OzrUyb1TSdU6GXCsOZO+uwKHBnqQAknEveVF
	 b6tOGz0du8vpwZdqlRhfTdrecidanmLu4nV5hnpEGLA7j9thN6KgrNHpzGrruGWjm5
	 j4/R3pubYxToMu4e8VDbK8DaHoPLYG/UNASnO6o63mCkv+/azG3ePBkzmQOJ9+WLLx
	 BWPRfy+WFBXBg==
Subject: Re: [PATCH net] net: rionet: clear peer->res after releasing the
 outbound doorbell
From: netdev-bot+sashiko@kernel.org
To: fourier.thomas@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alexandre.bounine@idt.com,
 akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 10:43:54 +0000
Message-ID: <179387543447.488856.14627265384044267768@kernel.org>
In-Reply-To: <20261104094811.19446-2-fourier.thomas@gmail.com>
References: <20261104094811.19446-2-fourier.thomas@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix NULLs peer->res after the release in rionet_close() but
  does not fix the acquire/release mismatch that causes the bug.
- [Low] The commit message understates the bug it fixes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but rionet_close()
  clears nets[netid].active[destid] for every active peer…

--

net: rionet: clear peer->res after releasing the outbound doorbell

This patch sets peer->res to NULL after rionet_close() releases the
outbound doorbell resource. The goal is to stop rionet_remove_dev() from
releasing the same resource a second time.

> rionet_close() releases peer->res with rio_release_outb_dbell(), but
> leaves peer->res set. rionet_remove_dev() can releases peer->res again.
>
> Clear peer->res once it has been released.
>
> This bug was found statically and is theoretical.

[Severity: Low]
Is "theoretical" accurate here?

Before this patch, rionet_open() never requested peer->res again. A plain
ifup, ifdown, ifup, ifdown sequence made the second rionet_close() see the
stale pointer and call rio_release_outb_dbell() on it again:

drivers/rapidio/rio.c:rio_release_outb_dbell() {
	int rc = release_resource(res);

	kfree(res);
	...
}

That is a use-after-free in release_resource(), followed by a double
kfree().

An ifdown followed by rmmod rionet reaches the same release. rionet_exit()
calls subsys_interface_unregister() first, and that runs
rionet_remove_dev() for every peer.

The commit message only mentions the close->remove_dev path. Could it also
describe the close->close path, and say that the result is a
use-after-free and a double free? That would help with stable triage.

> diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
> index 64b5d0a8ae4a4..f8a7a778f2831 100644
> --- a/drivers/net/rionet.c
> +++ b/drivers/net/rionet.c
> @@ -387,8 +387,10 @@ static int rionet_close(struct net_device *ndev)
>  			rio_send_doorbell(peer->rdev, RIONET_DOORBELL_LEAVE);
>  			nets[netid].active[peer->rdev->destid] = NULL;
>  		}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Should
nets[netid].nact be decremented here too?

rionet_remove_dev() and the LEAVE branch of rionet_dbell_event() both
decrement nact when they clear the slot:

	nets[netid].active[rdev->destid] = NULL;
	nets[netid].nact--;

On the next rionet_open(), a JOIN doorbell goes out to every peer. Each
peer that answers reaches this code in rionet_dbell_event(), where
active[sid] is already NULL:

	if (!nets[netid].active[sid]) {
		...
			nets[netid].active[sid] = peer->rdev;
			nets[netid].nact++;

So every ifdown/ifup cycle increases nact by the number of active peers,
and it never comes back down.

rionet_start_xmit() uses nact as add_num for multicast and broadcast
frames:

	if (is_multicast_ether_addr(eth->h_dest))
		add_num = nets[rnet->mport->id].nact;

	if ((rnet->tx_cnt + add_num) > RIONET_TX_RING_SIZE) {
		netif_stop_queue(ndev);
		...
		return NETDEV_TX_BUSY;
	}

Once nact grows past RIONET_TX_RING_SIZE (128 by default), can any
broadcast such as ARP or IPv6 ND stop the queue even when tx_cnt is 0?

With nothing in flight, rionet_outb_msg_event() never runs to call
netif_wake_queue(). rionet_netdev_ops also has no ndo_tx_timeout. So TX
would seem to stay stalled until the next broadcast after every re-open.

rionet_remove_mport() also looks like it would trigger
WARN(nets[id].nact, ...) after any close done while peers were active.
rionet_remove_dev() only decrements nact for slots that are still active.

> -		if (peer->res)
> +		if (peer->res) {
>  			rio_release_outb_dbell(peer->rdev, peer->res);
> +			peer->res = NULL;
> +		}

[Severity: High]
Does this leave every peer without its outbound doorbell reservation after
the first ifdown?

peer->res is requested only once per peer, in rionet_add_dev():

	peer->res = rio_request_outb_dbell(peer->rdev,
					RIONET_DOORBELL_JOIN,
					RIONET_DOORBELL_LEAVE);

rionet_open() does not request it again. Its peer loop only sends JOIN:

	list_for_each_entry(peer, &nets[netid].peers, node) {
		/* Send a join message */
		rio_send_doorbell(peer->rdev, RIONET_DOORBELL_JOIN);
	}

After close and then open, the peer is still on nets[netid].peers and
keeps sending JOIN and LEAVE doorbells, but peer->res is NULL. The
JOIN..LEAVE range in rdev->riores[RIO_DOORBELL_RESOURCE] is free again,
so another request for it would succeed. rionet_remove_dev() then skips
the release without any warning.

rionet seems to be the only in-tree caller of rio_request_outb_dbell().
So nothing crashes today, but the resource ownership tracking is wrong.

Commit 34ed2ebb65b0 moved the request into rionet_add_dev() and added the
matching release in rionet_remove_dev(). It left the old release in
rionet_close().

Would it be more correct to remove the rio_release_outb_dbell() call from
rionet_close() entirely, so that rionet_remove_dev() does the only
release? That would also fix the double release, and peer->res would stay
held for as long as the peer exists.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104094811.19446-2-fourier.thomas%40gmail.com
