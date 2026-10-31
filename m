Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484919;
	b=tYgGweDwEumIts+pZFxTbOGo+/xR2ADRj1ROaAmm5Gw2f2pHhM+YvMZiaYSYw+FasNmg
	 MpBPhQYjwKqp8KW/10OlBZSaSADyUrRs3V0ub9Zlps5WBBN0rqGqIDIn9augcJWbmAhJi
	 BW7VRbMLWiuIUL7wOHggN0y4OkSgAwWtHihhmxIGgQ4AUG+SLwRkjVBHCwTFBCdtNy842
	 +IrAC7EGm8sDGOsF/m3gj8e5JFLFruftETN3JzoWqFG7+bc5Ud/RtBZ35DYepVzPLLzcC
	 vSJbdT7D1XrK+iHSOiSkG+ytjOWOQNHSf9iYd83zLZNAAiZWBZrA4P1KMW/110XX6Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484919;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=eEDZVJa6rECx46xFFyMmTNRNAdijfZTVObHJQWnV0yk=;
	b=4y3Ckx4c/1h/T7egpi5IC43H+6kqj68/meBLUfeMle5EO0RhWdR2I1X0rYona/SlmRX/
	 MR4g0WSfp7KiIHwyGSVeU6jvnLHnDVwGp3yjdGpTAvntCDvkrnb4x2vv0tEPQmJhMXWRR
	 Dw2DRUhS3i2ziELYLhoAclU4MjgIVoAI+oBK8kiR27gXDVCnkeAw6bs5vEb07LblHQ4nq
	 +w6GpnOkYXEPrYScp+3yanm2TjfUQTAnWt8hpKw9p0iact68PAUITgXbQSozP2kkGHxoh
	 uqnKgulz9Bqxd8chu3klT3wc7T440a/pA/+SQLxAl4e5RZvgnFlT2f/8xyDEozl9LaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=XwUhQb+D;
	arc=none smtp.remote-ip=195.10.208.51
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69A606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 22:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC69A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=XwUhQb+D
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4jHC2L56h0zbv;
	Sat, 31 Oct 2026 23:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793484906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEDZVJa6rECx46xFFyMmTNRNAdijfZTVObHJQWnV0yk=;
	b=XwUhQb+D1UyAxEn5cnnh1lrDGtdXr9HkAQogoDodQLIBfIA+5SrZ/AdUvWUtrpaRq1fia2
	HIv8cVtQ1XjTZepbqmIdzPB6QHHoIBeqaNXPJOL1nTUQQI17iW+NXYl6o1MinslbpK1kOx
	lTe6TX8ox/zdSJVlCMBG1qKfwTt6IsLCMV9bud3FbgmrpcRXnvq1Ohtxx6Uy3fujh8HiWK
	WSKHDfFiKro8sVni7ayq6SYK7oHYZtbHZDefwI6WFIknaToYj0vJzdCLXDL2vU92LdFr0R
	cGua8UtaGeP+T+pyE3AMDbfST+5JS/mM7+OPVdJkVeVVTKzD4/04n5sLkzxPbw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <790874fd-0c02-4e70-9aa6-4fa0bb2857f2@mandelbit.com>
Date: Sat, 31 Oct 2026 23:15:04 +0100
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
Subject: Re: [PATCH net v2] tun: bound the NAPI receive queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20261030152540.1409884-1-antonio@mandelbit.com>
 <willemdebruijn.kernel.1805eb8882e13@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <willemdebruijn.kernel.1805eb8882e13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jHC2L56h0zbv

Hi Willem,

thanks a lot for the review. See below:

On 30/10/2026 22:52, Willem de Bruijn wrote:
> Antonio Quartulli wrote:
[...]>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 770b8fe085c3..1ace0c1f22f2 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -60,6 +60,7 @@
>>   #include <linux/rcupdate.h>
>>   #include <net/net_namespace.h>
>>   #include <net/netns/generic.h>
>> +#include <net/hotdata.h>
>>   #include <net/rtnetlink.h>
>>   #include <net/sock.h>
>>   #include <net/xdp.h>
> 
> Keep alphebetical order

ACK, will fix in v3.

> 
> 
>> @@ -1856,6 +1857,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>   			zerocopy = true;
>>   	}
>>   
>> +	/* In NAPI mode packets are queued here and processed by the NAPI
>> +	 * poll, possibly in a kthread or ksoftirqd. Bound that queue like
>> +	 * the per-CPU backlog, and drop before allocating and copying.
>> +	 */
>> +	if (tfile->napi_enabled && !frags && !msg_control &&
> 
> Why disable if frags? That is still using NAPI scheduling.

Right, the exclusion doesn't help much.
In frags mode tun_get_user() processes the packet synchronously
with napi_gro_frags() and never queues to sk_write_queue, so the
check could only fire if something else filled that queue.
tun_xdp_one() can, on the same tfile, therefore I'll drop the
exclusion and also bounds tun_xdp_one() in v3.

> 
> Same for msg_control. tun_chr_write_iter calls with NULL msg_control.
> 
>> +	    unlikely(skb_queue_len_lockless(&tfile->sk.sk_write_queue) >=
>> +		     READ_ONCE(net_hotdata.max_backlog))) {
> 
> Nit: consider > instead of >=, same as enqueue_to_backlog
> 

ACK

>> +		dev_core_stats_rx_dropped_inc(tun->dev);
>> +		return total_len;
>> +	}
> 
> also best effort: more robust would require retesting once holding
> the lock.

I see.
In v3 I'll keep the lockless check before allocating and copying, and
recheck under the queue lock before __skb_queue_tail(), in both
tun_get_user() and tun_xdp_one().
Similarly to what enqueue_to_backlog() does.


Regards,

> 
>> +
>>   	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>>   		/* For the packet that is not easy to be processed
>>   		 * (e.g gso or jumbo packet), we will do it at after
>> -- 
>> 2.56.0
>>
> 

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

