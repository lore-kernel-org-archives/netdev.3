Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6837A839
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133073; cv=none; b=OxLlAPYxd/5yLz7+E1OX1r8KA4ahxphJ4yS0Icr4BhM2xr7a1nii8MPl70efmV0Np1PovnupNS5q/qklDENf3rbKMyO9u+HpPJoFlLSYa7EYCV/oKCezu6XspLlohlEV9ENHsEV6Fs3GPBI8ipkGiyptrtGngiv07MrkuIQVYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133073; c=relaxed/simple;
	bh=9qZzTEEAYNgTZaYyGLaq+9MynJ8VKyO3a4wiXxircrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI1ibo3LmrsLcEBWnu2t37nNqzhwLwFmnIr3yto67Q4GX5GH9EEygq2I7sbyN50LZJjm2bOQiTDrYTHR8XmV9aTajtRDQcVBnurIqnrp0hxeWprbUxHIh7DzYb+ywH6ENeGHhBl+qlWWZsbqBfidTV9SI5tebzWL6pxVTIM4rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pgjyAci0; arc=none smtp.client-ip=95.215.58.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pgjyAci0"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9qZzTEEAYNgTZaYyGLaq+9MynJ8VKyO3a4wiXxircrM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787133069; v=1; x=1787737869;
 b=pgjyAci0jatN18UN3KzJ5QuZYkdu4J1gGNW3ZFJBq14RVsUajsSg2FFLhQrjCJHoinlKjBHK
 wVrbbHxDSZeMoX/kNVGudMplRsGPXt+dcfTcdTCGBQpe9BvMKjXUauVmCxcV+QgnHJdzbsIgvD1
 3srWlwhamT/6cyOy289O+ctI=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id c2ee0f981de47df9;
	Wed, 19 Aug 2026 09:51:09 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 17:51:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aoV8hvRlyRrFQobA@fedora>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
 <aoUP0sLeEhCPxukB@fedora>
 <aoUQdublxcfZzqzE@fedora>
 <1ebd9c8a-5b7e-4ebb-9c7d-5b2b2fe4a675@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebd9c8a-5b7e-4ebb-9c7d-5b2b2fe4a675@blackwall.org>

On Wed, Aug 19, 2026 at 11:35:29AM +0300, Nikolay Aleksandrov wrote:
> hmm why don't you change the way the reset is done? *untested* but in theory
> you could just record the values at a reset "moment" in reset unbalanced and
> just use the delta, so it becomes a reader and there is only 1 writer left (tx).
> Keep the counters only increasing (important), only record a snapshot at a reset
> moment, count current total bytes (sum all per-cpu data), decrement the previous
> total from it and use that as the "interval bytes" to div.

Oh, you mean add another variable to track the total unbalanced load? e.g.

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 659a77323444..a65be54049d3 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1546,10 +1546,10 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 	return bond_do_alb_xmit(skb, bond, tx_slave);
 }
 
-static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
+static u64 reset_unbalanced_load(struct bonding *bond, struct alb_bond_info *bond_info)
 {
 	struct unbalanced_load_stats *p;
-	u64 tx_bytes, total_bytes = 0;
+	u64 delta, tx_bytes, total_bytes = 0;
 	unsigned int start;
 	int i;
 
@@ -1560,14 +1560,15 @@ static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
 			tx_bytes = u64_stats_read(&p->tx_bytes);
 		} while (u64_stats_fetch_retry(&p->syncp, start));
 
-		u64_stats_update_begin(&p->syncp);
-		u64_stats_set(&p->tx_bytes, 0);
-		u64_stats_update_end(&p->syncp);
-
 		total_bytes += tx_bytes;
 	}
 
-	return div_u64(total_bytes, BOND_TLB_REBALANCE_INTERVAL);
+	spin_lock_bh(&bond->mode_lock);
+	delta = total_bytes - bond_info->total_unbalanced;
+	bond_info->total_unbalanced = total_bytes;
+	spin_unlock_bh(&bond->mode_lock);
+
+	return div_u64(delta, BOND_TLB_REBALANCE_INTERVAL);
 }
 
 void bond_alb_monitor(struct work_struct *work)
@@ -1612,7 +1613,7 @@ void bond_alb_monitor(struct work_struct *work)
 		bond_for_each_slave_rcu(bond, slave, iter) {
 			tlb_clear_slave(bond, slave, 1);
 			if (slave == rcu_access_pointer(bond->curr_active_slave))
-				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond_info);
+				SLAVE_TLB_INFO(slave).load = reset_unbalanced_load(bond, bond_info);
 		}
 		atomic_set(&bond_info->tx_rebalance_counter, 0);
 	}
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 51c083c76115..9d3877644286 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -131,6 +131,7 @@ struct unbalanced_load_stats {
 struct alb_bond_info {
 	struct tlb_client_info	*tx_hashtbl; /* Dynamically allocated */
 	struct unbalanced_load_stats __percpu	*unbalanced_load;
+	u64			total_unbalanced;
 	atomic_t		tx_rebalance_counter;
 	int			lp_counter;
 	/* -------- rlb parameters -------- */

This looks like an easy update :) Hope I didn't miss anything.

Thanks
Hangbin
