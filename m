Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B613E44F6;
	Mon, 15 Jun 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522489; cv=none; b=anbEELIpi1WxWONvr4eUebuiS+J/T6t+2HK5ZX3vFIyxGqgx6jSX24B+s3p2vl3omoP9m99yKnBPGY5bcEYLSyFHGLD8zQ7LCPUQxB4Eu5P7WE6JU7gJxwqiWxhwW49VRuu+gUkGracwbKONLjjZCBvWcSPshylP67Nm2BHBJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522489; c=relaxed/simple;
	bh=eEo+7lV/KNOEviIFhDhv4I6Js9iYIGQ1LsUHg0MJPpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kx8NKKMaZgpKCPv3Gi7lyoJj+qfi5AXt1Iib+9fcAfOriACZc1bdKo3mZ1tPlpPA9ETaED/GDOi7q+VZqDCXH5EsFnpunS/fJ7nXypk5S84CZPSDghQqknj28t1qZ546JRQorVKVJ+J7KjtTWjCkf3dcNH3XFJCQIcHwu1J0pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Jakub Kicinski <kuba@kernel.org>, Samuel Moelius
 <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "moderated list:CAKE QDISC"
 <cake@lists.bufferbloat.net>, "open list:TC subsystem"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
In-Reply-To: <20260613142626.1b2183eb@kernel.org>
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
 <20260613142626.1b2183eb@kernel.org>
Date: Mon, 15 Jun 2026 13:21:12 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wlw0gic7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
>> +static const struct netlink_range_validation_signed cake_overhead_range = {
>> +	.min = -64,
>> +	.max = 256,
>
> Both Sashiko's complain - these values are neither safe nor sufficient.
>
> How was the -64 chosen? It looks suspiciously close the min ethernet
> frame length. But in that case (a) FCS doesn't count so 60, and 
> (b) even IPv4 TCP packets can be shorter (at qdisc layer) than 64B
> leading to underflow...
>
> I see min rate in cake is 64 but I don't see any other meaning of the
> 64 literal.
>
> Toke, WDYT? Should we use a smaller constant (ETH_HLEN?) or do the
> check on the datapath?

Hmm, we do actually have a check on the datapath already, so just
amending that like the second Sashiko suggestion should add no
additional runtime overhead. In which case there's no reason to add the
policy at all, I suppose.

So basically:

diff --git i/net/sched/sch_cake.c w/net/sched/sch_cake.c
index a3c185505afc..259e4b8d09c5 100644
--- i/net/sched/sch_cake.c
+++ w/net/sched/sch_cake.c
@@ -1389,10 +1389,7 @@ static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
        if (qd->min_netlen > len)
                WRITE_ONCE(qd->min_netlen, len);
 
-       len += q->rate_overhead;
-
-       if (len < q->rate_mpu)
-               len = q->rate_mpu;
+       len = max((s32)len + q->rate_overhead, (s32)q->rate_mpu);
 
        if (q->atm_mode == CAKE_ATM_ATM) {
                len += 47;

(Sashiko suggests using max_t, but that seems a bit redundant when
there's already casts in the operands, no?)

-Toke
