Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C53B42C5;
	Wed, 30 Sep 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753958; cv=none; b=qMklpTxtUvr1qTQ/Kh+g7T8ryfMCIKUIEu0/4J/c6lXvGaSmQ5aYFeI2DorcWE83NyFDX5Z6Qzcsaz4pfW2S0HmrsKXAV/q6B0F9cJUgReX+gQdHNizyEYxTiQy5lWLOfU5Rcj1JeGuGI2ejWhmY/HVXHoydca5bxTSfyjAQ6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753958; c=relaxed/simple;
	bh=/4KiCWLH+o8fxrrhBQAB7Wsx93BHLb9+XPn4yW1wY+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=esYX70F66mN8H3oSf7LoS7vvncPkRLpIn4Qe1G2s94lkmZUUiMTjnOW1Lm0zGOd9pCIuypsyREAlml8zae7kjX+JwvQIxEuZDp45fetZBj3YCC4eqiAqHpxij7wq7cvs44zl9JXnjT3Wm2PWIOKPz4gzv1he+RsgCQsVhKAlSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=CUKoqtaQ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="CUKoqtaQ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x8xmPNLop5MFL0VSwJns1DfWSQ+a6UAGPh5kJmJ5lQE=;
	b=CUKoqtaQbHZtOkYVBtCwfrXKhx6RfMfiO+FTBZgrOLfkBmnVMixIMGGUBt0glLmn4A7ko8VXV
	NtETXU70MePgOvUrBSsYzQQ+G5nMpgI7WpbVCFHPF9QH2XGsXepgvK74F17Kb3k4124AglJdg+b
	9iUn8QHzrzEdbHurIZckT+0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvmny6mx3znTVd;
	Wed, 30 Sep 2026 15:27:02 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DE1540578;
	Wed, 30 Sep 2026 15:39:03 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 30 Sep 2026 15:39:02 +0800
Message-ID: <fa84ace1-f28e-406c-8c1f-8dd2c600ac40@h-partners.com>
Date: Wed, 30 Sep 2026 15:39:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: tun: fix race condition between tun_attach
 and tun_get_user with XDP
To: <netdev-bot+sashiko@kernel.org>
CC: <willemdebruijn.kernel@gmail.com>, <jasowangio@gmail.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <huyizhen2@huawei.com>,
	<gaoxingwang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260920030240.443223-1-xietangxin@h-partners.com>
 <178995923435.2160803.18166174326002943726@kernel.org>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <178995923435.2160803.18166174326002943726@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 9/21/2026 10:53 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Incomplete fix: the new "publish tfile->tun last" ordering is a
>   no-op on the TUNSETQUEUE/IFF_ATTACH_QUEUE re-attach path, so the…
> 
> Pre-existing issues:
> - [Medium] Mirror-image ordering problem on the detach path is untouched
>   and reproduces the same netif_get_rxqueue() WARN_ONCE.
> - [Medium] tun_set_real_num_queues() (drivers/net/tun.c:526-530) is void
>   and discards the documented error returns of…
> 
> --
> 
> net: tun: fix race condition between tun_attach and tun_get_user with XDP
> 
> This moves the rcu_assign_pointer(tfile->tun, tun) publication in
> tun_attach() to after tun_set_real_num_queues(), so that
> dev->real_num_rx_queues is raised before a concurrent writer can observe
> the newly attached tun_file.  The intent is to stop the WARN_ONCE in
> netif_get_rxqueue() that fires when a recorded rx queue index is not
> below dev->real_num_rx_queues.
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 5a302709a68a..2dfca25b86e9 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -811,11 +811,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  	 * initialized tfile; otherwise we risk using half-initialized
>>  	 * object.
>>  	 */
>> -	if (publish_tun)
>> -		rcu_assign_pointer(tfile->tun, tun);
>>  	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>>  	tun_set_real_num_queues(tun);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the new ordering guarantee
> now rests on tun_set_real_num_queues() having actually taken effect, and
> that function drops both return values:
This is a pre-existing issue unrelated to the race being fixed.
Maybe address it in a separate follow-up patch.
> 
> drivers/net/tun.c:
> static void tun_set_real_num_queues(struct tun_struct *tun)
> {
> 	netif_set_real_num_tx_queues(tun->dev, tun->numqueues);
> 	netif_set_real_num_rx_queues(tun->dev, tun->numqueues);
> }
> 
> For an already registered device, netif_set_real_num_rx_queues() returns
> early without assigning dev->real_num_rx_queues:
> 
> net/core/dev.c:netif_set_real_num_rx_queues() {
> 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
> 						  rxq);
> 		if (rc)
> 			return rc;
> 	}
> 
> 	dev->real_num_rx_queues = rxq;
> }
> 
> and net_rx_queue_update_kobjects() can fail on rx_queue_add_kobject():
> 
> net/core/net-sysfs.c:net_rx_queue_update_kobjects() {
> 		error = rx_queue_add_kobject(dev, i);
> 		if (error) {
> 			new_num = old_num;
> 			break;
> 		}
> }
> 
> In that case tun_attach() has already published tun->tfiles[] and bumped
> tun->numqueues, and then publishes tfile->tun and returns 0.  Does that
> leave tfile->queue_index == dev->real_num_rx_queues permanently, so that
> every write() on that queue going through the generic XDP path hits the
> same netif_get_rxqueue() warning the commit message is trying to remove?
> Should the error be propagated and the numqueues/tfiles publication
> unwound instead?
> 
> [Severity: Medium]
> This is a pre-existing issue and the patch does not touch __tun_detach(),
> but the decreasing direction looks like the same mismatch.  In
> __tun_detach() the surviving queue's index is lowered and numqueues is
> decremented well before the real queue count is reduced:
>
This is a deterministic bug (no race needed).
The XDP path in tun_get_user() lacks a tfile->detached check,
Write on a detached fd records a stale queue_index via
skb_record_rx_queue(), then enters do_xdp_generic() which calls
netif_get_rxqueue() with a stale index and trigger same WARN_ONCE.

> drivers/net/tun.c:__tun_detach() {
> 		spin_lock(&ntfile->tx_ring.consumer_lock);
> 		ntfile->queue_index = index;
> 		ntfile->xdp_rxq.queue_index = index;
> 		...
> 		WRITE_ONCE(tun->numqueues, tun->numqueues - 1);
> 		...
> 		synchronize_net();
> 		...
> 		tun_set_real_num_queues(tun);
> }
> 
> The moved tfile keeps its ->tun published, and the queue_index sample in
> tun_get_user() happens before the rcu_read_lock() around the XDP call:
> 
> 	skb_record_rx_queue(skb, tfile->queue_index);
> 
> 	if (skb_xdp) {
> 		...
> 		local_bh_disable();
> 		rcu_read_lock();
> 
> so the synchronize_net() above does not fence a writer that already
> sampled the old, higher index.  Can a write() racing with
> TUNSETQUEUE|IFF_DETACH_QUEUE reach do_xdp_generic() after
> dev->real_num_rx_queues has shrunk and hit the same WARN_ONCE?  Also, for
> the clean == false case, tun_disable_queue() never clears tfile->tun and
> the stale queue_index stays in place while the fd is still writable.
> Should the commit message scope its claim to the attach path, or should
> the detach direction be handled too?
> 
>> +	if (publish_tun)
>> +		rcu_assign_pointer(tfile->tun, tun);
>>  out:
>>  	return err;
>>  }
> 
> [Severity: High]
> Is this reordering effective on the TUNSETQUEUE re-attach path?  A queue
> detached with IFF_DETACH_QUEUE goes through __tun_detach(tfile, false),
> where clearing tfile->tun only happens in the clean case:
> 
Correct. __tun_detach(clean=false) does not clear tfile->tun,
so rcu_assign_pointer(tfile->tun, tun) writes the same pointer value that
readers already observe -- the v2 publish ordering has no effect.
Another reattach and tun_get_user race issue:
  CPU 0 (re-attach)             CPU 1 (tun_get_user)
  // tfile->tun isn't null
  tfile->queue_index = 2
  tun_enable_queue(tfile)
    tfile->detached = NULL
                                skb_record_rx_queue(skb, 2)
                                do_xdp_generic()
                                  netif_get_rxqueue()
                                  // index(2) >= real(2) -> WARN
  tun_set_real_num_queues()
    real_num_rx_queues = 3

pw-bot: cr
> drivers/net/tun.c:__tun_detach() {
> 		if (clean) {
> 			RCU_INIT_POINTER(tfile->tun, NULL);
> 			sock_put(&tfile->sk);
> 		} else {
> 			tun_disable_queue(tun, tfile);
> 			tun_napi_disable(tfile);
> 		}
> }
> 
> So on that fd tfile->tun stays non-NULL and visible.  tun_set_queue()
> then re-attaches with publish_tun = true:
> 
> 		ret = tun_attach(tun, file, false, tun->flags & IFF_NAPI,
> 				 tun->flags & IFF_NAPI_FRAGS, true);
> 
> and tun_attach() writes the new, higher index long before the queue count
> is raised:
> 
> 	spin_lock(&tfile->tx_ring.consumer_lock);
> 	tfile->queue_index = tun->numqueues;
> 	spin_unlock(&tfile->tx_ring.consumer_lock);
> 
> Since the moved rcu_assign_pointer(tfile->tun, tun) stores a value that
> readers can already see, does it order anything for them on this path?  A
> concurrent write() on the same fd still passes tun_get(), records the new
> index and calls into XDP:
> 
> 	skb_record_rx_queue(skb, tfile->queue_index);
> 
> 	if (skb_xdp) {
> 
> reaching net/core/dev.c:netif_get_rxqueue():
> 
> 		if (unlikely(index >= dev->real_num_rx_queues)) {
> 			WARN_ONCE(dev->real_num_rx_queues > 1,
> 
> which is the warning quoted in the commit message, plus the silent
> fallback to dev->_rx[0] so the program runs against the wrong
> netdev_rx_queue.  The window is not small either, because
> netif_set_real_num_rx_queues() does GFP_KERNEL sysfs work.  Would either
> clearing tfile->tun on the non-clean detach, or publishing
> tfile->queue_index only after tun_set_real_num_queues(), close the attach
> path in all cases rather than only when tfile->tun transitions from NULL?
> 

-- 
Best regards,
Tangxin Xie

