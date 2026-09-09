Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFD59D636
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989053; cv=none; b=Rp4TooJPqcWmLVRWcOyxPhGVRcCL1PwGGce79Cmp80IxOM/SfSleRc/nJhqFHGF13FARfuuw1eCfNWdnbdZNyIveMvA5qKvKZt6LFbPHS/aq9Y/L7bcEi9UEPt4k39RGttw0GCuuLBbfLJWQI2EZv68TDb9iK38RhGeLMpuQUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989053; c=relaxed/simple;
	bh=CZjG2Cm4beBlXwkRf0BZXKtwcXcjdcZtdHsTnzgexlw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jopjGlGS31zYg3usyEVJys3SSv+Qe4fIjMZ89XwSGslsyTZDB7GWxpKyr4tisXyE6KzCyEn2bVsxDDyN2Ct8P+DpocoFeOQDZTTl3JYQGzCnkl7V3+ptq442dkR0JlKf8SCSZVkGK56mituqYef5RXlpqC3HsUCrNNL8+rWMbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyjJhho/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyjJhho/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFBD1F000FF;
	Wed,  9 Sep 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989043;
	bh=Cs7ZKNpKePbZjILhCM495ioiKqg/0FHnDvE1Uh07vHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nyjJhho/ARXaUgNWXFvXq7DSfysk83GqxEYvRJtOS5/XGzTDzO8Q7q7Kygf0lx5SE
	 +YzYZoI8YEa8KF9JNjA+gYR5tmmHdXYn6Bh5svZplHiL8nxOGfUr8UOD9A5VUgd2RZ
	 L2sz4KJqmR5YzOWIJyuK54x5GxHl1uwbc+DMLgdrBPrbMEZuHGn7BzjQOM/P29M0Vn
	 Emk70F8kFbCOT+j9+Godv55KBfMJbvA4bVg9FMoI0eK5qYHLUE0PxM80qbjC9CW97l
	 P80dYiI7c50FzAkEqFsD+7jheeNMtqbpCBnfPw95JKSwpchdzrAJfFIvR4TTZbfKO1
	 3t2KIxY2Jj0rg==
Subject: Re: [PATCH] net: prestera: validate num_counters in counter response
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: enachman@marvell.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Date: Wed, 09 Sep 2026 21:24:02 +0000
Message-ID: <178898904299.219967.14214566618811763209@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001CC8A4737B0CC46F41DDFC8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001CC8A4737B0CC46F41DDFC8B22=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete bounds check: prestera_hw_counters_get()
  (drivers/net/ethernet/marvell/prestera/prestera_hw.c:2327) validates…

--

net: prestera: validate num_counters in counter response

This adds a check in prestera_hw_counters_get() that rejects a firmware
counter response whose num_counters field exceeds the number of counters
that were requested, returning -EINVAL instead of iterating over the
response.

> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> index 7695cbb2ce626..c4cb5f22893c9 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> @@ -2324,6 +2324,11 @@ int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
>  	if (err)
>  		goto free_buff;
>  
> +	if (__le32_to_cpu(resp->num_counters) > *len) {
> +		err = -EINVAL;
> +		goto free_buff;
> +	}
> +

[Severity: High]
The commit message says this closes "out-of-bounds writes to the caller
stats array", but does *len actually describe the capacity of stats[]?

The only caller is prestera_counter_stats_work() in prestera_counter.c,
which always requests a fixed chunk size and passes a pointer into the
middle of block->stats:

	u32 count = COUNTER_BULK_SIZE;
	...
	err = prestera_hw_counters_get(counter->sw, counter->total_read,
				       &count, &done,
				       &block->stats[counter->total_read]);

COUNTER_BULK_SIZE is 256, while block->stats is allocated with exactly
block->num_counters elements in prestera_counter_block_get():

	err = prestera_hw_counter_block_get(counter->sw, client,
					    &block->id, &block->offset,
					    &block->num_counters);
	...
	block->stats = kzalloc_objs(*block->stats, block->num_counters);

block->num_counters also comes from the firmware, so it can be smaller
than 256 and need not be a multiple of 256.

Can stats[] still be overflowed with this check in place?  If firmware
reports num_counters = 10 for the block and then answers the
COUNTER_GET with resp->num_counters = 256, the new test (256 > 256) is
false and the loop below writes stats[0..255] into a 10 element array.
Similarly, with block->num_counters = 300, the second poll iteration
passes &block->stats[256] which has only 44 slots left, yet *len is
still 256, so any reply in the range 45..256 passes.

Would clamping the requested count in prestera_counter_stats_work() to
block->num_counters - counter->total_read, or passing the remaining
capacity down to prestera_hw_counters_get(), be a better place for the
bound?  The helper as written never learns the size of the destination
array.

>  	for (i = 0; i < __le32_to_cpu(resp->num_counters); i++) {
>  		stats[i].packets += __le64_to_cpu(resp->stats[i].packets);
>  		stats[i].bytes += __le64_to_cpu(resp->stats[i].bytes);

[Severity: High]
Related to the above: on success *len is set to resp->num_counters, and
prestera_counter_stats_work() then does:

	counter->total_read += count;
	if (!done || counter->total_read < block->num_counters) {
		resched_time = COUNTER_RESCHED_TIME;
		goto resched;
	}

Can counter->total_read end up larger than block->num_counters here?  If
so, and the same reply has done == 0, the work is rescheduled and the
next invocation forms &block->stats[counter->total_read], which is
already past the end of the array before any write happens.

The out-of-bounds read of resp->stats[] does look addressed by this
check, since the response buffer is allocated with
struct_size(resp, stats, *len).  Would it be worth splitting the commit
message so it only claims the read side, or extending the fix to cover
the write side too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001CC8A4737B0CC46F41DDFC8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
