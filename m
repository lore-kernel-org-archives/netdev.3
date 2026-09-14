Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9979479887
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417629; cv=none; b=L4yZxwzfsBYjNZ6W5npkv/OydnIZzs/Q4RmrYPQCnD314AGZ+adzwTfkIG+X3b+IN9mahmNL3STtmicdpUpmDyJ7dLYO45kb/fPqOJbutRnaTPqEhAc9Qg0BwvMFUJFyVLcSwkftot1zOUz/N4qcfmO8cm8LHBQ740uYIBJdPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417629; c=relaxed/simple;
	bh=Zp9TFGRZWV+78amEmdJx4dX/lk32OgNNHOUGXprLXkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3w0gMFgeNPmZPUfwUIaaLO9GLBNZzwrdka5A3eyrVNYjtRlGjQRVyxkUNjohvNC1c1h9b3uOWKXbulHXkDuXe8sOnHfZ6GcAmXqDJSHlCBwR5hU1xzNXF6Ojozggr9fCgfK6oxMyAOqTfMwazUkyI+eQo6EmM7GCG/Z4QQ6v+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so4116945e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417626; x=1790022426;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ssx9UZlN7ZyzQZsDMB/To4LWrTGH6EjqFiYfgiMZAUw=;
        b=pRRrCDzm2lvhyi41YDvsfAlBb/q8tR2lNyCIz5dKLGGnjeYVACYomAyo6jY/BuuMR+
         RXcewFLJ37RHF9mJpXomKZk6ux67CHoresdBLBrgvmxW94mXbBhVwRz3aWnSLHRUNyy7
         9RQXKIR3RvyR36Rl452BEctaMCC/mVUZL1icyruwhUaiDXS5xLigs1WZc3jYs/GG+JjM
         /M/yb70HRfBYsmVNFp8bYZsIlvqxAlGDAKaogQhFKfKi1JmeMxY0/Eeo5neve7UwNKSQ
         rQUZGjRWHy/hWLKzTDiWpblcQYjcPqs2c8kK2PL4AUEcLE2TrWma/16NO4Ta7Gcr3o3D
         OJwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQzslEsxCoy2k4zSJPgdajACQ2XpVrsFccvgx3xIg/6REQVyoSSy43SMOHFHXL81HVy/RJdrI=@vger.kernel.org
X-Gm-Message-State: AFuF++mI/eK1Rg6e6aSkkT+BJYoLLHWU2h66wPVeAHZTrvp0VJ+5PwUC
	7GAhsX9ZFZ1YUGkhOnRyVR+1hiWrOjHz0y301wjCVI4Mh9pp7EruFPKp
X-Gm-Gg: AYBFou1D0lqY8splfs3mOcmIQnD6r7ZjSlYo1xoqsjGIyceZrh2oWI3Za6JN3wN/pDE
	8pYJUy4J9FNEpVAAtYcTGQbXvxwKj+f6VaYK9fB3RQrkFfS4etMB+b+kAPA4T7Sj8Yy6W3YSWao
	PzlU0qlpjwGlHPACDXk+GCFafjFcRwp4qZ6AsjA8hpNGz0xtsG7dg3o2zl7R/oTMyIV6zaOmMJ1
	k7Hqz6zsfSataLz2q8gpOSHgyivCaaEhYfXVF2k/3rz00UTVhqT+lNPt8OfdKZoKmXjY8ka2P91
	p0zIsomAbfEeoCQc1pA3I4wip9lgo3lLPPIzvxKtItL/AIhS/6aolXd1lUaNb2MM4XKN2KJA1Oq
	KrqjZiN4P4riILefGJzT0y1TH0L2SgqcH+zsRQoQNkUhXEZaVNBmAbBjQ/hqmQvVqyPO1XCWZJs
	HQW0jz3Tg0uc3xv4ZKhfmuVBZ5lVjJzLz2umKkfxjpRPDV2kPxArhHZoq/XtcetIMWBzK1idkb6
	sPNDkrOkdyp5Ry/kudKjQ0flhpjrcsmvC5TVZwj4w+kk81uRQ==
X-Received: by 2002:a05:600c:a103:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49e7d472b16mr24757995e9.12.1789417625693;
        Mon, 14 Sep 2026 13:27:05 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm29450928f8f.11.2026.09.14.13.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 13:27:04 -0700 (PDT)
Message-ID: <0655dc38-4817-4577-849b-376d192da66f@ovn.org>
Date: Mon, 14 Sep 2026 22:27:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] openvswitch: disable BH once per netlink dump instead
 of per item
To: "Denis V. Lunev" <den@openvz.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260909171920.1001074-1-den@openvz.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260909171920.1001074-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 7:19 PM, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> ovs_flow_cmd_dump() and ovs_vport_cmd_dump() release a BH-disabling
> spinlock once per item they emit: stats->lock in ovs_flow_stats_get()
> for every CPU that has touched the flow, and nsid_lock in
> peernet2id_alloc() for every vport that lives in a foreign netns.

This doesn't seem to be the case since last year:
  aed4969f2bdf ("net: net->nsid_lock does not need BH safety")

> Every release is a local_bh_enable(), and each one runs the pending
> softirq backlog in the dumping thread's own context.
> 
> The skb bounds how much work a dump callback does, which is why no
> dumper carries a budget of its own, but it does not bound the softirq
> work the callback absorbs. On a CPU that carries the box's packet load
> the backlog refills as fast as it drains, so the dumping thread becomes
> that CPU's softirq engine. It never sleeps and it has no reschedule
> point, so under voluntary preemption nothing can take the CPU away from
> it: neither the ksoftirqd the kernel woke to take the work over, nor
> the stopper thread the softlockup detector dispatches to refresh its
> timestamp. The watchdog then panics a node that has enough flows and
> ports to keep the dump running.
> 
> ovs_flow_stats_get()

ovs_flow_cmd_dump ?

> used to do exactly this. One local_bh_disable()
> around the whole per-CPU walk was added by commit 4f647e0a3c37
> ("openvswitch: fix a possible deadlock and lockdep warning") to close
> an ABBA deadlock between two CPUs reading each other's stats.
> Commit 63e7959c4b9b ("openvswitch: Per NUMA node flow stats.") dropped
> that region the same day while reworking the stats layout, and replaced
> it with a spin_lock_bh() per item. The deadlock stayed fixed; the
> single region did not come back.

"used to do exactly this" is not a valid argument as it never actually
did this in reality.  Patches you mentioned were developed more or less
together with all parties aware of each other's work and applied within
a short window.

> 
> Hold BH off across the whole callback instead, the way
> ctnetlink_dump_table() does. Both loops already run under
> rcu_read_lock() and cannot sleep, so this forbids nothing that was
> allowed before, and the nested spin_unlock_bh() in the callees stop
> draining softirqs.

This sounds fine to me, though as mentioned above, the vport dump
doesn't need the change, AFAIU.

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Aaron Conole <aconole@redhat.com>
> CC: Eelco Chaudron <echaudro@redhat.com>
> CC: Ilya Maximets <i.maximets@ovn.org>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Simon Horman <horms@kernel.org>
> ---
>  net/openvswitch/datapath.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 631a03136fa1..ae2c9924aeb0 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1533,6 +1533,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  	}
>  
>  	ti = rcu_dereference(dp->table.ti);
> +	local_bh_disable();

I'd put this before the dereference to avoid breaking the logical
block.  It may also be good to add a small comment on why it is
done here, as it is not needed for safety.

>  	for (;;) {
>  		struct sw_flow *flow;
>  		u32 bucket, obj;
> @@ -1552,6 +1553,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		cb->args[0] = bucket;
>  		cb->args[1] = obj;
>  	}
> +	local_bh_enable();
>  	rcu_read_unlock();
>  	return skb->len;
>  }
> @@ -2565,6 +2567,7 @@ static int ovs_vport_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		rcu_read_unlock();
>  		return -ENODEV;
>  	}
> +	local_bh_disable();
>  	for (i = bucket; i < DP_VPORT_HASH_BUCKETS; i++) {
>  		struct vport *vport;
>  
> @@ -2585,6 +2588,7 @@ static int ovs_vport_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		skip = 0;
>  	}
>  out:
> +	local_bh_enable();
>  	rcu_read_unlock();
>  
>  	cb->args[0] = i;

