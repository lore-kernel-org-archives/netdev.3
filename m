Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239763B8BA4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475672; cv=none; b=XRuCNAFj23niiIbHO06wyRHhutMjJLlrfhdhevqm9YNcnMhfvUDsIoIz7PBjHnEchEG3gsN0dSEEJ6pQOtacIafiZ4PlGl1mtazE+hnetlSkR6z9RwLCeoPJh/NchpMPeELiY1vj5a/2mCbFBlf8ZBH1JnPTE02qxHAezH/bkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475672; c=relaxed/simple;
	bh=OJMb8+kSmjnilK3L4bk+RoN5qnBsXE87kcO/1+97EYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/hWq73KbnWUW+oCabQ6yETfz40LZNx0dv0UhD8NhVG+FNA3asGy3AkCFsEnaiiuNWLhSjahWIrjIdQ2oXS+Vgp9AX2PZHu7xxpyTNSvavtyoCnWyHa663AaIpcKjiuZ7z08z+0P4tE/8RvxGRe/WB5dtZmOcMARCwc9O9S677o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZP2EOMQP; arc=none smtp.client-ip=91.218.175.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZP2EOMQP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OJMb8+kSmjnilK3L4bk+RoN5qnBsXE87kcO/1+97EYk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789475669; v=1; x=1790080469;
 b=ZP2EOMQPWn4P9PTmZ482XnXWojT7vIWvLDIancH3AUz6PPgIbX8Y/KZhCatHCX693eLxnyAW
 OZgRx4/WuU4WI56v+fZfYUMLYbOXKN0iwnvxcBAA6VcCyd1gO4yu/9d7c8yF8lGNL9VeDSOjzkL
 5aLxFeNlKj6c1pSttdQQJ12Y=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f2c905f45e48e2e;
	Tue, 15 Sep 2026 12:34:29 +0000
X-Mizu-Trace-ID: 4f2c905f45e48e2e
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ec16cd0-5fef-4068-9317-1ade03c0ded6@linux.dev>
Date: Tue, 15 Sep 2026 20:34:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: gro_cells: move backlog drop handling
 outside the local lock
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dong Chenchen <dongchenchen2@huawei.com>, David Ahern <dsahern@kernel.org>,
 Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260915121458.214961-1-xuanqiang.luo@linux.dev>
 <CANn89i+d4ny7K0QV-v+ZY6Kj735tPVrrzd0AzwRqe4vvu5r=aw@mail.gmail.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89i+d4ny7K0QV-v+ZY6Kj735tPVrrzd0AzwRqe4vvu5r=aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/15 20:26, Eric Dumazet 写道:
> On Tue, Sep 15, 2026 at 5:16 AM Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>>
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> When the GRO cell queue length exceeds max_backlog, gro_cells_receive()
>> holds bh_lock while updating the RX drop counter and freeing the rejected
>> skb. The skb has not been queued, and the counter is updated with
>> this_cpu_inc(), so neither operation requires the queue lock.
>>
>> Release bh_lock before accounting for and freeing the dropped skb to
>> shorten the critical section.
> 
> local_lock_nested_bh() is only a real lock on PREEMPT_RT. On other
> kernels it is a lockdep assertion, so this patch generates the same
> code. And this is the backlog overflow path: by definition we are
> already dropping packets there. Shortening this "critical section"
> buys nothing measurable, and there is no benchmark in the changelog.
> 
> Also, the result is harder to read than what it replaces: a label
> named "unlock" that actually drops the skb, falling through into
> "drop:", and a backward goto past the return. Three labels for a
> 20-line function.
> 
> If you want to improve gro_cells_receive(), please add drop reasons
> instead: SKB_DROP_REASON_DEV_READY for the !IFF_UP case and
> SKB_DROP_REASON_CPU_BACKLOG for the overflow one. That actually helps
> people tracking down drops.
> 

Thank you for the quick reply!

I see your point. I'll take another look.

Thanks,
Xuanqiang

> 
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   net/core/gro_cells.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
>> index d8c0a28671201..f46cecd246aab 100644
>> --- a/net/core/gro_cells.c
>> +++ b/net/core/gro_cells.c
>> @@ -14,7 +14,6 @@ struct gro_cell {
>>   int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>>   {
>>          struct net_device *dev = skb->dev;
>> -       bool have_bh_lock = false;
>>          struct gro_cell *cell;
>>          int res;
>>
>> @@ -26,32 +25,33 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>>
>>          if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>>                  res = netif_rx(skb);
>> -               goto unlock;
>> +               goto out_rcu;
>>          }
>>
>>          local_lock_nested_bh(&gcells->cells->bh_lock);
>> -       have_bh_lock = true;
>>          cell = this_cpu_ptr(gcells->cells);
>>
>> -       if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
>> -drop:
>> -               dev_core_stats_rx_dropped_inc(dev);
>> -               kfree_skb(skb);
>> -               res = NET_RX_DROP;
>> +       if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog))
>>                  goto unlock;
>> -       }
>>
>>          __skb_queue_tail(&cell->napi_skbs, skb);
>>          if (skb_queue_len(&cell->napi_skbs) == 1)
>>                  napi_schedule(&cell->napi);
>>
>> +       local_unlock_nested_bh(&gcells->cells->bh_lock);
>>          res = NET_RX_SUCCESS;
>>
>> -unlock:
>> -       if (have_bh_lock)
>> -               local_unlock_nested_bh(&gcells->cells->bh_lock);
>> +out_rcu:
>>          rcu_read_unlock();
>>          return res;
>> +
>> +unlock:
>> +       local_unlock_nested_bh(&gcells->cells->bh_lock);
>> +drop:
>> +       dev_core_stats_rx_dropped_inc(dev);
>> +       kfree_skb(skb);
>> +       res = NET_RX_DROP;
>> +       goto out_rcu;
>>   }
>>   EXPORT_SYMBOL(gro_cells_receive);
>>
>>
>> base-commit: 1142eb185b05db61a78130890fc4ed268f4cb4e6
>> --
>> 2.43.0
>>

