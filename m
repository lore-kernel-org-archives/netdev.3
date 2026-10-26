Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.149.7.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003749;
	b=W251cEceVANGrJzfpppK6n9qxUfFuNTISjP9gSDWgBFXPm93NT+doEGXb8lhzw5n7+4T
	 7zO+ghLXRkvTT4MHXhLoEuLXF6Xq/UiWGxEHjtyfW3nMavPKEUu1IJJiqcFat/wwm/FCL
	 OqpQhHCPrmkAO1aDo1vjCZpMEE2Dotm/Z9kVsLkNjfyXNyVj/LgMYTx89JOrjhhr47BYH
	 BZBIfPu0cRlbG/WtFTJBxD2R4gSUWftCerOB7pwuBIhgSqTaU9lFGn8Jul6mIA6H9b5vy
	 xaZIRqhmfdgqlHWooUWXRXX9kfQdbOrWBUjf5NrPP63W/NTo2U/dPkHc/zpK7ioPypQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003749;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=t5aVGQFnIo2fbR/ym25z3W3C+Yluhz2Oy30vSlBhxGY=;
	b=uuz7TFPQUj2eA/6hwbbG65KMQNRHMcmKZ0hjmMJhJORCdPSo8E20+Nv3ScDjO/CxwcIv
	 N+OGMlQ8HHB6+2CchxeVl1SOgTLza7sVEw0cjSSWweSvK3I4swM10oe+Qr7kR9o1EeT91
	 hVUTcUjem08QiM1IvdEgPPMEInZFig6/v5WQMZgsZQgntlmVcHdjGk40Voae6/LBIY0hj
	 sD1W/B/U5WGZN0k/MRvgytwRK20CYtK9HH1D10Ah/FwS7MxiQ05HekO+lBRhoBABleKn3
	 79R6WjHljqhNfgpric/Y2MAi2AOQd+Txj+gYDMRcbcMo3GoqfNFkwydiQB9VhCn5u7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-berlin.de;
	spf=pass smtp.mailfrom=tu-berlin.de;
	dkim=pass header.d=tu-berlin.de header.i=@tu-berlin.de header.a=rsa-sha256 header.s=dkim-tub26 header.b=ECK0mPRH;
	arc=none smtp.remote-ip=130.149.7.70
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B4606A31A;
	Mon, 26 Oct 2026 08:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tu-berlin.de header.i=@tu-berlin.de header.a=rsa-sha256 header.s=dkim-tub26 header.b=ECK0mPRH
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1793003747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t5aVGQFnIo2fbR/ym25z3W3C+Yluhz2Oy30vSlBhxGY=;
  b=ECK0mPRHOPAqkif+dngu8d1bwJcbU0Cnc1kUsZCko/WMNudnIzX4vW/+
   ydhHrshryg+WGlvRTL1mFAHu7Zf8bKbq/EgjjQUnjJpbNx+uHWh+M27Da
   fycJkfCqLOeo2HcxyjyvCigqmKrgWDLS5CHCxtUMvRDsr8Oma5q+JskUw
   RmiCEpCM6UXEl3lIAx41wcH2TuWwQHuFz29LUprv4k11ARqcDxYFQax+A
   zFEkotYWEOf8730jT0FXixRHOBGEEBnsW5xIBx3TYe/LkbKp5XVV4v4qm
   /6hZSR+agKzxmSSP7ZloqioBZtdUgcfej//MBCQo1ENt71gQElOoYe3kC
   w==;
X-CSE-ConnectionGUID: zBdUs2ZiRfO1z7KXzqHd4w==
X-CSE-MsgGUID: jEwqq7qaS4yR3m1RQByAfA==
X-IronPort-AV: E=Sophos;i="6.27,179,1787004000"; 
   d="scan'208";a="53777538"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 26 Oct 2026 09:35:39 +0100
Message-ID: <3625cee3-3643-4ef8-808d-2fe8267593fd@tu-berlin.de>
Date: Mon, 26 Oct 2026 09:35:37 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: sch_cake: skip redundant cake_mq rate updates
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
CC: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261025-net_sched_sch_cake-v1-1-5165c924a590@gentwo.org>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <20261025-net_sched_sch_cake-v1-1-5165c924a590@gentwo.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 9:38 PM, Shubhang Kaushik (Ampere) wrote:
> cake_mq periodically counts active child qdiscs in cake_dequeue() and
> derives an effective per-child shaper rate. cake_dequeue() currently
> reconfigures every tin after each scan, even when that effective rate
> is unchanged.
> 
> The dequeue-time call chain is:
> 
>    cake_dequeue()
>      -> cake_configure_rates(..., true)
>        -> cake_config_*()
>          -> cake_set_rate()
> 
> With rate_adjust=true, cake_set_rate() only refreshes rate-derived
> state. Tin 0 records the unscaled rate argument in every supported
> CAKE tin mode, so its installed rate identifies whether this call chain
> would change any state.
> 
> Skip the reconfiguration when the effective rate is already installed,
> while continuing to update the activity-sampling timestamp and
> active-queue statistic.
> 
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-instances of cake_mq")
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
> Tested on an 80-core SMP, non-SMT Ampere Altra system (aarch64)
> The test used a 32-TX-queue veth pair, with cake_mq
> bandwidth 2gbit on the transmit side and the peer in a network
> namespace. The workload was:
> 
>    iperf3 -c 198.18.0.2 -P 32 -t 30
> 
> Validation against mainline commit a32e63a613aa80, the patched kernel
> reduced cake_configure_rates() calls by 99.99% (2,477,627 to 206) and
> aggregate helper time by 99.986% (3.477 s to 0.498 ms), while retaining
> approximately 1.91 Gbit/s aggregate throughput (baseline:
> 1.91-1.92 Gbit/s). A separate per-child trace observed no
> same-effective-rate calls on the patched kernel (@unchanged: 0).
> Changing cake_mq bandwidth from 2Gbit to 1Gbit and back invoked
> cake_configure_rates() 64 times, matching all 32 child CAKE qdiscs
> updated for each of the two control-plane changes.
> ---
>   net/sched/sch_cake.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index aa4043d662c1cc18858d3f9c80f9d9b281f26f72..dd2539cb472087af9a96b74f2ac571eb8b0a8a27 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -2052,7 +2052,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
>   		if (num_active_qs > 1)
>   			new_rate = div64_u64(new_rate, num_active_qs);
>   
> -		cake_configure_rates(sch, new_rate, true);
> +		if (new_rate != READ_ONCE(q->tins[0].tin_rate_bps))
> +			cake_configure_rates(sch, new_rate, true);
Thanks! Yes, I think the idea is right. I think we could even omit the
READ_ONCE.

Best
Jonas>   		q->last_checked_active = now;
>   		WRITE_ONCE(q->active_queues, num_active_qs);
>   	}
> 
> ---
> base-commit: a32e63a613aa80dfdb9acc0a09efab940e96054f
> change-id: 20261025-net_sched_sch_cake-e6653fd393d6
> 
> Best regards,

