Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D941EFFA1
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407115; cv=none; b=nLid57V4228jG0rmSEeUMAAQaHZfafVVWviWojNv28b+A5d5pRo/wqWO0fOUW4rVPxE/wpogFzdMm3cpgUbTB3sZ0nsaZb0+B/BGARMokOOkKHZWlN3EYAWUDew9OwIuX5WOYaPe9rQfylFNKfPv9FfmNLfpcDZ+3zoc4Rk/ax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407115; c=relaxed/simple;
	bh=fjMnuF/yy1Sdajs8Y9bR74Tb8JFR3c5/lRgsF47yHxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OskTedUZTqlCmk+ET0ucSsrwbHifBM7q8pL32QXU5DbptGIg4xIZCDTPoXf1vqmSfEZV/GX5y0aKYMusT/f+89ulm4tsy0hbznKw72SOL9iyrTIKybxYFErtfE2xiHyDHGLS+ytWVFXmzDr1+wItCL4doj1HyKTZ80ZIwMcaVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIzCetK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIzCetK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692F81F000E9;
	Tue, 11 Aug 2026 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407113;
	bh=jEVlw1uMI17FWXTs1lZQL6MBsxmiuelaJ8qGdmrVejk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIzCetK9RlatfUXaZ9rvWOd24GIsOtz+XvOLRsD9t2Yr9JYIkbvrinuVeWR0IZ1b3
	 CIhjDrjsS4GKG/cOKGcktw98ijOvTjd3o2dic8wDuv+i4VIAEJWxSMRNDdZo/P7424
	 NQB+qu6mMFptUoUbpNmyDipjgE9N/DvLut2e6DoSMdWFD49MckMjLC66eP8xim2ay2
	 p5M+VI9t0XGshTlQolN1l+MpC+JsPCDTvTvM8+sL4ZoDQOOq42nyKBFy+syFVE3AUp
	 Gs4WPQKnxOatNYxOkx4eGtMJmeec3qjhckr3Bf3T2SWGzwD5aTUwGsWJadlOOs0GlD
	 wUEUKX6QzLiRw==
From: Jakub Kicinski <kuba@kernel.org>
To: victor@mojatatu.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	bestswngs@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_teql: restore skb->dev on the slave failure path
Date: Mon, 10 Aug 2026 17:11:50 -0700
Message-ID: <20260811001150.1034738-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807133155.1242599-1-victor@mojatatu.com>
References: <20260807133155.1242599-1-victor@mojatatu.com>
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
net/sched: sch_teql: restore skb->dev on the slave failure path

teql_master_xmit() used to leave skb->dev pointing at a slave after that
slave's ndo_start_xmit() failed, so the skb could end up queued on a later
slave's neighbour arp_queue while referring to the earlier slave.  The
patch restores skb->dev to the master device at the end of each slave
iteration.

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 5c42a29a981c..9e52afc2d980 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -377,6 +377,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			nores = 1;
>  			break;
>  		}
> +		skb->dev = dev;

[Severity: High]
This isn't a bug introduced by this patch, but does it leave a smaller
version of the same dangling skb->dev behind, with the master netdev in
place of the previous slave?

After the restore, skb->dev is the teql master, and the skb can still be
parked on the arp_queue of a neighbour that belongs to a slave device.  On
the second pass (skb_res == skb after the goto restart), teql_resolve() ->
__teql_resolve() creates the neighbour on the slave because dst->dev is the
master:

net/sched/sch_teql.c:__teql_resolve() {
	...
	if (dst->dev != dev) {
		struct neighbour *mn;

		mn = __neigh_lookup_errno(n->tbl, n->primary_key, dev);
	...
	if (neigh_event_send(n, skb_res) == 0) {
	...
	} else {
		err = (skb_res == NULL) ? -EAGAIN : 1;
	}
}

__neigh_event_send() then keeps the skb:

net/core/neighbour.c:__neigh_event_send() {
	...
		skb_dst_force(skb);
		__skb_queue_tail(&neigh->arp_queue, skb);
	...
}

teql_master_xmit() returns NETDEV_TX_OK for the err == 1 case and loses
ownership.  At that point the queued skb's skb->dev (master) is not the
neighbour's device (slave), so the arp_queue flushing done by
arp_ifdown()/neigh_ifdown() for the master's device never sees this skb.
skb->dev also takes no netdev reference.

Is the held dst enough to pin the master here?  On NETDEV_UNREGISTER,
rt_flush_dev() and dst_dev_put() swap dst->dev to blackhole_netdev via
netdev_ref_replace(), which drops the master's refcount, so
netdev_wait_allrefs() does not hold off free_netdev().  The master has no
rtnl_link_ops, so the free comes from teql_exit():

net/sched/sch_teql.c:teql_exit() {
	...
		unregister_qdisc(&master->qops);
		unregister_netdev(master->dev);
		free_netdev(master->dev);
	...
}

which means rmmod sch_teql after the last teql qdisc is deleted, racing a
pending neighbour resolution (the retransmit window is multiple seconds by
default).  The next use of the queued skb dereferences the freed master
through the same path as the KASAN report quoted in the commit message,
neigh_invalidate() -> arp_error_report() -> dst_link_failure() ->
ipv4_link_failure() -> __icmp_send():

net/ipv4/icmp.c:__icmp_send() {
	...
	if (!(skb_in->dev && (skb_in->dev->flags&IFF_LOOPBACK)) &&
	      !icmpv4_global_allow(net, type, code, &apply_ratelimit))
	...
}

and on the successful resolution path,
neigh_update_process_arp_queue() -> n1->output() -> dev_queue_xmit() uses
the freed device's netdev_ops and _tx.

Would setting skb->dev to the device of the neighbour that actually takes
the skb (the slave used by __teql_resolve()), or declining to hand the skb
to a neighbour whose device differs from skb->dev, close the remaining
window?

> \t\t__skb_pull(skb, skb_network_offset(skb));
>  	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
>
-- 
pw-bot: cr
