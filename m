Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209840B116;
	Wed, 16 Sep 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586711; cv=none; b=DK1Ymt6xqVTUGR/Jvg7EPGxp5oGFcNTug/mM+P5v6hAx/zV/uAATVt5MipoFhIYuDLAMSdKm1SWqD74ibGdvoSsQzt3w71m4ZwAnQBU2LpndKOPSnqxYNn2nRVO2WQtKrZx6iaYKda5CcYbukJdNkYYJXA3s2N2UPbUC/SXQr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586711; c=relaxed/simple;
	bh=vBLWiwsvcrO2QTp/Qkh5PZXG+Y2wDOEwySNTzXkON5c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTMJAWcJDbgQTX8JuM4QzmGEAlk5lyZ8lkFS5L9PE9dI2SJP8gwo2yNNOt9B4jUxvo4Zxp6ebIr9Ewque6CHMOjA6Qja8J9Io1yLL3jseDWRB0zjHAl6AItU/fjpHX0a4jdX/lwNXKZKMx8h4tpFUT+QfCLbVnmK+/pz314Plkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AujQkcLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AujQkcLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602CB1F00893;
	Wed, 16 Sep 2026 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586705;
	bh=oSJ4At+/bKyZm3/c0BeAcv+TQwh0u1yTXsJ1f6zkWGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AujQkcLT6a3xSAZouOMSWDO1CPqpS0cACsSo1hZxIUQI+4faiO9GRHiyEP1NGsGOC
	 9lCwV9ZKw4uMDOUuv3gD/1Iz9anxIkyRK75y3C6ua5aGDJudRxTVr3YcboJDuP4UAg
	 bvdfsaGF43MzVmismA/J45ItMuFM/TDFYliqBJrVaawPWEerv7DNGffUenlfe7u76C
	 FoaHhiuggfgzPdDxd86KT5CCFEBGBEPBYnOmcpMx2nSVK6UHWTcua6XkSU9BccLXR9
	 SM4L6s4r1OUS7eRedi2XYljKzPQRPyazkfUHgr7Rx9G2fdzyQFnPgq361JgsxS4mbr
	 jN5lk91uOVupA==
Subject:
 Re: [PATCH net v2] net: prestera: validate num_counters in counter response
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: enachman@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vmytnyk@marvell.com,
 serhiy.boiko@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 19:25:03 +0000
Message-ID: <178958670391.22033.8038941818788955835@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001EE76C8EC41B2CEFAE213C8BB2=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001EE76C8EC41B2CEFAE213C8BB2=40AS8P251MB0?=
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

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

- [High] In prestera_counter_stats_work() the new capacity value is
  computed as an unguarded u32 subtraction, `remaining =…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  block->counter_flag, allocated with kcalloc(block->num_counters, 1) in…
- [Medium] prestera_hw_counters_get() derives resp->num_counters,
  resp->done and every resp->stats[i] entry from a buffer allocated with…

--

net: prestera: validate num_counters in counter response

The patch adds a stats_len parameter to prestera_hw_counters_get() and
rejects a firmware reply whose num_counters exceeds either the requested
bulk count or the space left in the caller's stats array.  The only caller,
prestera_counter_stats_work(), computes that space as
block->num_counters - counter->total_read.

> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_counter.c b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
> index 3a762d17ba6c6..f261104729e91 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_counter.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_counter.c
> @@ -342,6 +342,7 @@ static void prestera_counter_stats_work(struct work_struct *work)
>  	u32 resched_time = COUNTER_POLL_TIME;
>  	u32 count = COUNTER_BULK_SIZE;
>  	bool done = false;
> +	u32 remaining;
>  	int err;
>  	u32 i;
>  
> @@ -368,10 +369,12 @@ static void prestera_counter_stats_work(struct work_struct *work)
>  		goto resched;
>  	}
>  
> +	remaining = block->num_counters - counter->total_read;

[Severity: High]
Can this u32 subtraction underflow, and if so does the new bound still
protect block->stats[]?

counter->total_read and counter->is_fetching live in struct
prestera_counter and survive across work invocations, but the block
reference is dropped on every reschedule:

  resched:
  	if (block)
  		prestera_counter_block_put(counter, block);
  	schedule_delayed_work(&counter->stats_dw, resched_time);

If the last counter of that block is released in the meantime, the
refcount-zero path in prestera_counter_block_put() clears the list slot
and frees the block:

  	for (i = 0; i < counter->block_list_len; i++) {
  		if (counter->block_list[i] &&
  		    counter->block_list[i]->id == block->id) {
  			counter->block_list[i] = NULL;
  			break;
  		}
  	}

prestera_counter_block_list_add() then reuses the first NULL slot, so a
different block, with its own firmware-reported num_counters, can end up
at the same index.  prestera_counter_block_get_by_idx() re-resolves purely
by index:

  	if (idx >= counter->block_list_len)
  		return NULL;
  	...
  	if (!counter->block_list[idx] ||
  	    !prestera_counter_block_incref(counter->block_list[idx])) {

There is no check that this is the same block the in-progress fetch
started on, so the next poll continues with the old total_read.  When
total_read is larger than the new block->num_counters, remaining wraps to
near 4G and &block->stats[counter->total_read] is already past the end of
the smaller allocation.

Should total_read be validated or clamped against block->num_counters
here, or should the fetch state (is_fetching/total_read) be made
per-block, rather than deriving the bound from it?

>  	prestera_counter_block_lock(block);
>  	err = prestera_hw_counters_get(counter->sw, counter->total_read,
>  				       &count, &done,
> -				       &block->stats[counter->total_read]);
> +				       &block->stats[counter->total_read],
> +				       remaining);
>  	prestera_counter_block_unlock(block);
>  	if (err)
>  		goto abort;

The commit message says:

    Pass the remaining capacity down and reject a reply that exceeds the
    request or the space left. This also keeps counter->total_read within
    block->num_counters, so the next poll cannot start past the array.

Does that invariant hold only while the block instance at curr_idx stays
the same?  If the block can be replaced between polls, the "next poll
cannot start past the array" claim looks like it needs qualifying.

> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> index 7695cbb2ce626..2e5cffefea701 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_hw.c
> @@ -2324,6 +2325,11 @@ int prestera_hw_counters_get(struct prestera_switch *sw, u32 idx,
>  	if (err)
>  		goto free_buff;
>  
> +	if (__le32_to_cpu(resp->num_counters) > min(*len, stats_len)) {
> +		err = -EINVAL;
> +		goto free_buff;
> +	}
> +
>  	for (i = 0; i < __le32_to_cpu(resp->num_counters); i++) {
>  		stats[i].packets += __le64_to_cpu(resp->stats[i].packets);
>  		stats[i].bytes += __le64_to_cpu(resp->stats[i].bytes);

[Severity: Medium]
This isn't a bug introduced by this patch, but the new check relates
resp->num_counters to the requested count and the destination capacity,
never to the number of bytes the device actually wrote.

The reply buffer in prestera_hw_counters_get() comes from kmalloc(), not
kzalloc(), and prestera_fw_cmd_send() only bounds the reply length from
above and copies exactly that many bytes:

  drivers/net/ethernet/marvell/prestera/prestera_pci.c:prestera_fw_cmd_send() {
  	ret_size = prestera_fw_read(fw, PRESTERA_CMDQ_RCV_LEN_REG(qid));
  	if (ret_size > out_size) {
  	...
  	memcpy_fromio(out_msg, prestera_fw_cmdq_buf(fw, qid) + in_size, ret_size);
  }

ret_size is not propagated back, and prestera_cmd_ret() validates only the
ACK type and status, which sit in the first bytes of the reply.  For a
short but ACKed reply, num_counters, done and stats[] would be stale heap
content, and a garbage count within min(*len, stats_len) passes the new
test, so uninitialised bytes get accumulated with += into block->stats[]
and later reported to userspace via prestera_counter_stats_get() ->
prestera_acl_rule_get_stats().

Would using kzalloc() for the reply buffer, or plumbing ret_size out of
the send path so the reply length can be checked against
struct_size(resp, stats, resp->num_counters), be worth doing while this
area is being touched?

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but since
it is in the same block lifecycle the patch relies on: does
prestera_counter_block_put() leak block->counter_flag?

prestera_counter_block_get() allocates it:

  	block->counter_flag = kcalloc(block->num_counters,
  				      sizeof(*block->counter_flag),
  				      GFP_KERNEL);

and the refcount-zero teardown frees everything else:

  	prestera_hw_counter_block_release(counter->sw, block->id);
  	idr_destroy(&block->counter_idr);
  	mutex_destroy(&block->mtx);
  	kfree(block->stats);
  	kfree(block);

The only kfree(block->counter_flag) in the driver is on the err_list_add
unwind path in prestera_counter_block_get(), so every block create/destroy
cycle driven by tc flower rule add/delete appears to lose num_counters
bytes.  Should a kfree(block->counter_flag) be added next to
kfree(block->stats)?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001EE76C8EC41B2CEFAE213C8BB2%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
