Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A504C9E12
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729737; cv=none; b=n9f88EJAIORJEaXrGOrGl1UoRD5wuBUK4u7LEU1s5gLst8q9lsr0rpUKBX0hRC+dkuYcDXzB4DZiiA4LfstU+sFsLZvjZaTjNsVeT0O5thKjJHR1b0z7VuOwjzuCkz/97ORFtnvEmJtfh5yp/edpA2wV5vUtsNDOwOfwB/8JywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729737; c=relaxed/simple;
	bh=sslNITJJg/n0vGSApv1wDUjXtnC83sFb6UiaQ/kY1lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbX5Zw7hvUEiJdZVUX91oTM6y72Ip5UXn2g/42EdrDsrBo4ysfFk+ShCIrB86xA52FdLbik/cwiRtoEOoq/AMCqGcTdFTwM/EOxU12eax51PtJDPZdmodxJfIAF2eiXjmt9aU2cKmzVpZ6Jkee7faI3u3n9RKJG5o/iSOWvmMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so2505695e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729733; x=1790334533;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDax31aHUfOIC3Q4klFWnDLFVi3Jz6lE6y25Cbtyo8s=;
        b=Z0TH//02P0bfPRIVDRQ4D9GXjSnyXSRJzI+47nrZbVXq0qUM5zM19OB4b6VnLVG3fr
         K5+55rE1nYkQnkOdrKE5WqMSP5Juitw7wYTmoYwIQC0XP4i6ERkTPw8ABFMJhC7Nq1Xl
         j7W7SsBaEjJU2UHAt8IclbHRZHaI5Yz266YvWrbZSR8SuwSLFMHJVTpKQyEWpdEDsMn2
         Z0dGYDtYESyWjhJi/8h1p6TvQLD+80M1z+H9ji8cokyi1W31Hn3oZG+NdFHeIvVVtY25
         gZZjfLZ7iFxnTszm+jxK6TOJbezdOaqNi9vDj1P4OGuet0FeV8e53T8T1jykA6xgMIdW
         dkNg==
X-Forwarded-Encrypted: i=1; AKwUvBwGRkzEIWxPhaEzhuEn8oCTxXsJ7nBNj/ur6ZKU8dx1sTDj7MBTIF9rhj61Sd43R0XOQDUx7oc=@vger.kernel.org
X-Gm-Message-State: AFuF++nFAkCBGtLoe5KhT3wc++cp6+JGTUn0RjoS14P9rK28jVHx7r4U
	lMyFEdqZxgchSEa9AkBFR266EteNsudtkZ6IyVNWeGFwc0UfDuLvyWAQ
X-Gm-Gg: AYBFou2W5uv3oxzVIA3TQ4QEZ1I8XsUi473Bjz1kBIuDIkc6Sq+TTS4+UuIC8aU9C9k
	zL+0Zu8nF/JXld2R0tN5po5sd7OtmCncC49bxciLNHwklOnqf6wrtV3Q/MNwh5FUGoFHAI1uyut
	DeZrUPVd2CapIfKFX/dTCXCOicTjYIwkUT25GDA9xCvIWpr0XomarmiHn40WqsvZ0uOy3ZoMv7y
	mmBihVM8kNJtUOMpGsohoDSuXhwHbuYv9phJiuqjUOp1+8r2z026L1zCxZaggaYiRn08z1vYa7Q
	ATHubVjclOOTUbsODrpgDTJFb48itv8qVW1MjhzbvifhySRow4f5rTWwjatUCAJB8iBBw4OaCux
	aHxzsakrDZSw9FKeFWRET8/Su8nHxLfP6HOyglPkRl40OVRTSDoipzx3dXYaW7tGZF0j+bzY3TI
	pQj5Z/4O6AJa/MRTGlcGve86drJvXmj02y3PjJVDbRPpQ1z6Pa2fJjcILKv+PielOEA/gv9GuU5
	tDoTq0yGKCGB9p+oc2gdkXaso7zBlFSDy3w2LxYvJ0f+XlGE7d7
X-Received: by 2002:a05:600c:8b6a:b0:49f:bc43:9e8e with SMTP id 5b1f17b1804b1-49fc5741199mr25966035e9.26.1789729732650;
        Fri, 18 Sep 2026 04:08:52 -0700 (PDT)
Received: from [192.168.88.241] (37-48-42-237.nat.epc.tmcz.cz. [37.48.42.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48720072efcsm3240917f8f.25.2026.09.18.04.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 04:08:52 -0700 (PDT)
Message-ID: <6e04b4f9-2a3c-4f5d-b630-07f2333ba9ab@ovn.org>
Date: Fri, 18 Sep 2026 13:08:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] openvswitch: fix soft lockup in the netlink flow dump
To: "Denis V. Lunev" <den@openvz.org>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20260915122401.3910188-1-den@openvz.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260915122401.3910188-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 2:24 PM, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> A production compute node carrying a few thousand datapath flows hit a
> soft lockup inside a single netlink flow dump and panicked.
> 
> ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
> emits, and that releases stats->lock with spin_unlock_bh() once per
> CPU that has touched the flow. Every release is a local_bh_enable(),
> and each one runs the pending softirq backlog in the dumping thread's
> own context.
> 
> The skb bounds how many flows one callback emits, and a large but
> sparse table adds only a walk over empty buckets, so no dumper carries
> a budget of its own. Neither bounds the softirq work the callback
> absorbs. On a CPU that carries the box's packet load the backlog
> refills as fast as it drains, so the dumping thread becomes that CPU's
> softirq engine. It never sleeps and it has no reschedule point, so
> under voluntary preemption nothing can take the CPU away from it:
> neither the ksoftirqd the kernel woke to take the work over, nor the
> stopper thread the softlockup detector dispatches to refresh its
> timestamp.
> 
> Hold BH off across the whole callback instead, the way
> ctnetlink_dump_table() does, so the nested spin_unlock_bh() stop
> draining softirqs. The loop already runs under rcu_read_lock() and
> cannot sleep. What it gives up is preemption under CONFIG_PREEMPT,
> since a BH-off region is not preemptible outside PREEMPT_RT. That
> region is bounded by the skb and the table size, where the softirq
> backlog it used to absorb is not.

Sashiko argues that the table size is not really bounded, which is
fair, so it may be good to try and reword the argument a bit.  Maybe
point again to the fact that these buckets are empty and the walk
should be fast enough.  Not very important, only asking because there
is a couple of things to change below anyway.

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
> v2:
> - leave ovs_vport_cmd_dump() alone: nsid_lock has not been BH-safe
>   since commit aed4969f2bdf ("net: net->nsid_lock does not need BH
>   safety"), so the vport dump never drained softirqs
> - disable BH before the table dereference and say in a comment that
>   the region is not there for safety
> - drop the ovs_flow_stats_get() history, note the empty-bucket walk
>   and the lost CONFIG_PREEMPT preemption in the message
> - move the Cc list out of the commit message, add the net prefix

You say here that the net prefix was added, but it wasn't.  It should
be '[PATCH net v2]'.  But also, if you're targeting the net tree then,
as also noted by the sashiko, you need a Fixes tag (63e7959c4b9b would
work, I suppose) and the Cc for stable in the commit message tag section.

Also, please, add links to previous versions of the patch here in the
changelog section.  Especially if you're renaming the patch between
versions.

> 
>  net/openvswitch/datapath.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 631a03136fa1..a80bac81c043 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1532,6 +1532,11 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Not needed for safety. Stops every spin_unlock_bh() in
> +	 * ovs_flow_stats_get() from running the softirq backlog here.

The word 'here' reads strange, I'd suggest removing it.

> +	 */
> +	local_bh_disable();

Since the comment only applies to the local_bh_disable(), I'd suggest
having an empty line here.

>  	ti = rcu_dereference(dp->table.ti);
>  	for (;;) {
>  		struct sw_flow *flow;
> @@ -1552,6 +1557,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		cb->args[0] = bucket;
>  		cb->args[1] = obj;
>  	}

And an empty line here for symmetry.

> +	local_bh_enable();
>  	rcu_read_unlock();
>  	return skb->len;
>  }

