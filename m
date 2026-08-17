Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040F448BB2
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991850; cv=none; b=Ac9G6shg4eoOE3BguC1lVD1WByr+RDAmdHOC4hNDk/Nw5KdA8YYdIgQmGB0HCaFmgeFrTX0wtMQ+AFkPJbyZWFm5Hwzj8DpTRpX9P+RdBBXCvuwkkTgNMDNi4ZiheM36fjUYevLZ4ewKg4Wl0zZdAbpBc0MpVXQFAKn17EBuIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991850; c=relaxed/simple;
	bh=uUOTxIb/LkCnu0msMm5jknr+Dxe9i+iM7h+2G52pl8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhFPTNz0D5/ETV3+VuUI8491d/JqXIrFhlINEjjQmD2H2DJPPUgmdsk8+zPtVRD3nXByU7AsvFD+KkJ4xGSuZgpsCy34JHT5t5XnSPPwPb5BnzlXIdkN+J82Vw865DhyWLhoXSDdphHMM+s9Fm+JkhgwkIhyp13pkcaQKbfhLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso1589736f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 11:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786991847; x=1787596647;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7N1a70NPY5gig9o+ND4UsutG7dfLN3lOwMbMvRcMCw=;
        b=nj1Cj5PsqxywRRWjigWq8vqsInYF/hx5XHgh4V6arIaOxW1Je53Lr8OBs/X50LVe6F
         vh4Lh1IM7KUHRPDwaY/ikUkv5YmraYinIzAcjeMj6bcBDLqfLMTCnBEZsT72oqTBmmgE
         EGlL2MIHnhR/ZRXLFvhFlFZn5Y7x+ubv7VhchokmPzBLIN7TEvYtHHrY6Wk3jZ8abtDh
         RqV4FVqy9nT5PuU0q/v3LZVj/Q/8y/1j1XSPcs8bVj84ejyMS9UhQaoJe87R3AgWH91d
         DQ5zRy7njT3ykSki4G9c5aHfOi1ZK2dRYbFgcEUWaP1qIod9s9DL+H03gdAz4oSl2eyc
         MrGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4DSU3E5DTszevIZMd58u2J6cJ0IW9bGg13ohbWYix9IA891BheCNay7K1goeoj+8Kjecqtrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDgGHJiwnT1as+UnOjFYYVyAwldJqE4yReS6wXjofSGJU6FSA
	wrVFYUuwlHbxgocvovOOczayOH4bOyMjLi2CD+uC3kYB0RcPvFgVweEe
X-Gm-Gg: AR+sD10zJXePrT56zijr5O/BwlkHlZrunA2qCbNFICN5rbaJQXIZQXL1NsmA2Btn5mn
	l14ZVwBNh3B6Y4J/I6Rh2BZf+k32/2vuwRe66/phLybMZDGOjticaYZz4XqHa7As2hayOY8tItK
	vVzQ0e5uxaXlXtQVab5Is2UHy18dUhyOWBdKt32ZfbktNIfJMYNhP0im5HjMQTW8AJh1HAZ0M3N
	TGnN0ODCHOLRdFNhfrHZ/pu5cowUuUiOOlfPp/ZOB/e1HBtMShigDpH0VkAqJ5ZTQBdPimqogOZ
	r9tXDFLypbGknRtz/kv42bS/QxGMyJ4voMn/DakpawiAuI9TKm8WOQEvDuQGlg0FHIlSh4KKDX6
	OWbi1w1lSitHDwkuTFRcYCt8gSNMJrHpVmEelAQhz5zGq0RhWzYtZvjNujFYW1ZJ9q7Y+YABX+x
	036l30Pa9Va8VcQlxVJCT1Csl//E7Gl6qtCkQAE/tb+1rsnX+kZkEjFwl6uDy1mUJLz0Fykf7TL
	7fmZOP10gx7nEZT
X-Received: by 2002:a5d:5686:0:b0:47f:77a4:fd0 with SMTP id ffacd0b85a97d-4816076561amr32698999f8f.22.1786991846506;
        Mon, 17 Aug 2026 11:37:26 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm5448887f8f.27.2026.08.17.11.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 11:37:26 -0700 (PDT)
Message-ID: <2a44f5b3-d0cb-4333-829d-6a1f77c811ff@ovn.org>
Date: Mon, 17 Aug 2026 20:37:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: fix flow mask use-after-free on
 flow deletion
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815005915.1097270-1-i.maximets@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <20260815005915.1097270-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/26 2:58 AM, Ilya Maximets wrote:
> The commit in the Fixes tag below made so flow->mask free is scheduled
> via RCU right after it is removed from the flow table.  The pointer
> stays in the flow structure and it can be accessible while in the same
> RCU critical section.  This is done to avoid requiring ovs_mutex for
> the ovs_flow_free().
> 
> However, while removing the flow during processing of CMD_DEL, we do
> not take RCU read lock before the removal, and ovs_flow_cmd_fill_info()
> uses the flow->mask pointer afterwards.  The RCU read lock is taken,
> but it's already late at that point.  The comment on that line
> acknowledges that the lock is cosmetic and doesn't serve a real purpose.
> 
> This leads to use-after-free if the RCU grace period passes between
> removal and the filling.  It is a short race window, but it is there
> and can lead to a real crash in case memory allocation for the info
> takes a bit longer:
> 
>  BUG: KASAN: slab-use-after-free in __ovs_nla_put_key
>              net/openvswitch/flow_netlink.c:1996
>  BUG: KASAN: slab-use-after-free in ovs_nla_put_key+0x2463/0x2e30
>              net/openvswitch/flow_netlink.c:2250
>  Read of size 4 at addr ffff88801ee89970 by task ovs_flow_del_ec/9487
> 
>  Call Trace:
>   <TASK>
>   __ovs_nla_put_key net/openvswitch/flow_netlink.c:1996
>   ovs_nla_put_key+0x2463/0x2e30 net/openvswitch/flow_netlink.c:2250
>   ovs_flow_cmd_fill_info+0x420/0x9c0 net/openvswitch/datapath.c:930
>   ovs_flow_cmd_del+0x53a/0x970 net/openvswitch/datapath.c:1467
>   ...
>   netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556
>   </TASK>
> 
>  Allocated by task 9487:
>   mask_alloc net/openvswitch/flow_table.c:967
>   flow_mask_insert net/openvswitch/flow_table.c:1012
>   ovs_flow_tbl_insert+0xea2/0x1a90 net/openvswitch/flow_table.c:1084
>   ovs_flow_cmd_new+0x7e3/0xd90 net/openvswitch/datapath.c:1086
>   ...
>   netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2556
> 
>  Freed by task 9485:
>   rcu_free_sheaf+0x1e/0x100 mm/slub.c:5978
>   rcu_do_batch kernel/rcu/tree.c:2645
>   rcu_core+0x59c/0x10c0 kernel/rcu/tree.c:2897
>   handle_softirqs+0x1e4/0x9a0 kernel/softirq.c:622
>   ...
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062
> 
> ovs_flow_tbl_remove() must be called after the ovs_flow_cmd_fill_info()
> to avoid this race.  This also helps with cleaning up the forced cast
> and the cosmetic RCU read lock.  Before the commit in the Fixes tag the
> order did not matter as long as the flow object itself was not freed.
> 
> A wider RCU critical section could be another option, but we have a
> GFP_KERNEL allocation in the way.
> 
> Reported by Trend Micro's Zero Day Initiative as ZDI-CAN-32042.
> 
> Fixes: 56c19868e115 ("openvswitch: Make flow mask removal symmetric.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
Sashiko complains:

> Does this reordering drop the final packet and byte counts for packets
> that hit the flow between the snapshot and the unlink?
> ovs_flow_cmd_fill_info() -> ovs_flow_cmd_fill_stats() -> ovs_flow_stats_get()
> now serializes the counters while the flow is still linked in dp->table,
> and ovs_flow_tbl_remove() only runs afterwards.  The datapath writer runs
> in softirq context and takes only the per-CPU stats lock, never ovs_mutex:
> net/openvswitch/flow.c:ovs_flow_stats_update() {
> 	...
> 	stats = rcu_dereference(flow->stats[cpu]);
> 	/* Check if already have CPU-specific stats. */
> 	if (likely(stats)) {
> 		spin_lock(&stats->lock);
> 	...
> 	stats->packet_count++;
> 	stats->byte_count += len;
> 	...
> }
> So ovs_dp_process_packet() -> ovs_flow_tbl_lookup_stats() still finds the
> flow and bumps flow->stats[cpu] during that window.  Those increments are
> then discarded by:
> 	ovs_flow_free(flow, true);
> Since OVS_FLOW_ATTR_STATS in the DEL reply/notification is the last place
> user space can collect a flow's final counters, would those packets be
> lost from accounting?  Before the patch the unlink preceded the snapshot,
> so no new lookup could match the flow after the counters were read.
> The window here is bounded by the remaining nla_put work in
> ovs_flow_cmd_fill_actions() plus any preemption of the deleting task, not
> by a sleeping allocation, since ovs_flow_cmd_alloc_info() with GFP_KERNEL
> now runs before ovs_flow_cmd_fill_info().  Would it be worth mentioning
> this trade-off in the commit message?

This is not a new issue.  The race window is a bit different, but it was
there before the change.  The datapath processing is only protected by RCU
and we're not synchronizing it between removal and reading the stats.
So, there will always be a chance to not account for some of the packets.

That said, this is also not a concern for any real setup as ovs-vswitchd
doesn't delete active flows under normal circumstances.

Best regards, Ilya Maximets.
