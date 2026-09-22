Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D0549374
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091675; cv=none; b=p5SFCCC4KhuxUPSRxodwZgmVzXlhfY3tJ+fyqeRP8eiOlIzFtur7nklgSuMI8RxDaHVkYNhxRVls3iQmTREeyD5cy8DGh+EozdhK/yHpYny5h4xZnMlymDsk5VFEkFxspgserkJQXkKVDFALI/gZxvfnvcSVvRVqqWwIgPDhkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091675; c=relaxed/simple;
	bh=dHMxnUNtaUY6rvFit1CCqRauzQAmyxSzNleLDs0LNWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7NIjNZyQ7ARyvdYyLLXLRFRea02tlvO8bSOoTAhYrBig7/f5tMMyTnoaDKBOzhIMBiPtleO0D7wld0z5kfVEFOHr8H1HQ/TPi+fgWH+wonk2fUWQTLF+3kBNkNqKwb+AbHkg6paTnQe7mS643TSP1QMfbp2da5gYa521Vl8ckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7Apm4g2; arc=none smtp.client-ip=91.218.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7Apm4g2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dHMxnUNtaUY6rvFit1CCqRauzQAmyxSzNleLDs0LNWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790091670; v=1; x=1790696470;
 b=d7Apm4g2R0FwIFu07jchxmzS7ZOXTEE77/GgfPL01lg5M903E01xpwO7VMJXby1m7QE53d+u
 n2ZysCCo4JfZb22OQFEW362NyRSUHmcNXKuC1n1PX3d/Sy0oAI4Ol8q90vIQ/VF7tYty4c16Lx2
 7cmiHSerCQNpza94h9+/veY0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c035e23439589bfb;
	Tue, 22 Sep 2026 15:41:00 +0000
X-Mizu-Trace-ID: c035e23439589bfb
X-Migadu-Flow: FLOW_OUT
Message-ID: <e56bce9d-ddfb-4ff3-ab14-4dc3778e2337@linux.dev>
Date: Tue, 22 Sep 2026 23:40:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: cpumap: fix use-after-free of dev_rx on
 netdev unregister
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 mason@kernel.org
References: <20260922121022.256777-1-jiayuan.chen@linux.dev>
 <f6e17da46b7895d19df3b379a6e879cd0ff237c50dc387127c87c6f48a48a7d1@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <f6e17da46b7895d19df3b379a6e879cd0ff237c50dc387127c87c6f48a48a7d1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/26 9:36 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 5e59ab896f058..0c9647f28034d 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
> [ ... ]
>
>> @@ -832,3 +879,39 @@ void __cpu_map_flush(struct list_head *flush_list)
>>   		wake_up_process(bq->obj->kthread);
>>   	}
>>   }
>> +
>> +/* Frames in the ring and skbs in GRO hold a raw pointer to the ingress
>> + * device, make every kthread consume them before the device is freed.
>> + */
>                                     ^^^
>
> The BPF subsystem requires multi-line comments to have the opening /*
> on its own line, with text starting on the next line. This is a newly
> added comment. Should it be reformatted like this?
>
> /*
>   * Frames in the ring and skbs in GRO hold a raw pointer to the ingress
>   * device, make every kthread consume them before the device is freed.
>   */
>
>> +static int cpu_map_netdev_event(struct notifier_block *nb,
>> +				unsigned long event, void *ptr)
>> +{
>> +	struct bpf_cpu_map_entry *rcpu;
>> +
>> +	if (event != NETDEV_UNREGISTER)
>> +		return NOTIFY_OK;
>> +
>> +	mutex_lock(&cpu_map_mutex);
>> +	list_for_each_entry(rcpu, &cpu_map_list, list) {
>> +		/* the whole ring, plus a batch already pulled out */
>> +		WRITE_ONCE(rcpu->drain_left, rcpu->queue->size + CPUMAP_BATCH);
>> +		wake_up_process(rcpu->kthread);
>> +	}
>> +	list_for_each_entry(rcpu, &cpu_map_list, list)
>> +		wait_event(rcpu->drain_wq, !READ_ONCE(rcpu->drain_left));
>> +	mutex_unlock(&cpu_map_mutex);
>> +
>> +	return NOTIFY_OK;
>> +}
> NETDEV_UNREGISTER notifiers run with RTNL held:
> call_netdevice_notifiers_info() contains ASSERT_RTNL(), and the call
> site in unregister_netdevice_many_notify() also does ASSERT_RTNL() at
> entry.
>
> The wait_event() holds RTNL until every cpumap kthread in the system
> has consumed rcpu->queue->size + CPUMAP_BATCH frames. The ring size is
> bounded only by the 16384 sanity limit in cpu_map_update_elem(), and
> the countdown is decremented by frames actually consumed, so a ring
> that is continuously fed by a different, still-registered device forces
> the full 16392-frame count to be pushed through before returning.
>
> unregister_netdevice_many_notify() calls the notifier once per device
> in the batch, so a batched teardown such as netns exit with many veths
> multiplies this: N devices x 16392 frames of RTNL-held work,
> serialized.
>
> The commit message addresses the bound ("The work is bounded by the
> ring size, and the frames had to be consumed anyway") but not the fact
> that RTNL is held for the whole drain. Also, the "frames had to be
> consumed anyway" statement is only true for frames already queued - the
> size+BATCH countdown can force consumption of many newly produced
> frames belonging to unrelated devices.
>
> This is not a deadlock (the drain is bounded and the kthread cannot
> block indefinitely since its work runs under local_bh_disable()), but
> could this cause latency or stall issues on systems with many devices
> or large ring sizes?
>
> [ ... ]


The concern is an unbounded wait under RTNL. It is bounded: qsize is
capped at 16384 in cpu_map_update_elem(), so each entry consumes at
most one ring plus a GRO flush, and the kthreads do that in parallel.

Those frames had to be consumed anyway, the drain only moves that
work before free_netdev(). We can't tell which ring holds frames of
the device without tracking it per frame, and that would touch the
fast path.


>> -    Fixes: 9c270af37bb6 ("bpf: XDP_REDIRECT enable use of cpumap")
>> +    Fixes: 70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame")
>>       Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> The Fixes tag points to commit 9c270af37bb6 ("bpf: XDP_REDIRECT enable
> use of cpumap"), but is this the right commit?
>
> That commit (October 2017) introduced the cpu_map_enqueue() function
> signature but did not store dev_rx anywhere - it used data_hard_start
> as a void pointer with a comment saying "Followup patch will generalize
> this".
>
> The actual storage of the device pointer without a reference
> (xdpf->dev_rx = dev_rx;) was added 6 months later in commit
> 70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame", April
> 2018) when the code was converted to use the generic xdp_frame
> structure. This is where the use-after-free bug was introduced.
>
> Should the Fixes tag be:
>
>    Fixes: 70280ed91cb8 ("bpf: cpumap convert to use generic xdp_frame")


Right, 9c270af37bb6 only added the dev_rx argument. The pointer is

stored and used from 1c601d829ab0 ("bpf: cpumap xdp_buff to skb

conversion and allocation").

pw-bot: cr


Sorry for the noise

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35727192473
