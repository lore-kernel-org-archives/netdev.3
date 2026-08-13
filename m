Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB037E2FC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593706; cv=none; b=EY/kPC9xmLKA+BVJlY924ss36UNFGL3SP6gorO3Po4VhIvT8z3GXvVbgaryy9pEmKu2JamnEMzmFkzAe8Z1Hd+oIQ7XMMJaQdAJZ6fT0nOv7U288KCyc5cVawX3dIVd58DS6/8LChpSjG0Oz4JX4Uodp3y/Ep678c8wNGqGOMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593706; c=relaxed/simple;
	bh=4qKjZjOc0c1ec0as+J+OJ2yurnlovYpLxMU0t9SpwY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWTTW7t6pZgB/4GoSn6sAjVZfti4hZW8iASTyS80YG7xFPUWTNMvZtF4tuWK73ar7j3fbgyigG7KlWr6OEWGx29VOly6jkv/b01M+AsyyUHzXZo+2EWAI2GGhWRxgqESEGBiWJfHOuRcvWdPFolOA+MENjtCCYg8enIewmhyLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uja5GolH; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uja5GolH"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4qKjZjOc0c1ec0as+J+OJ2yurnlovYpLxMU0t9SpwY8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786593701; v=1; x=1787198501;
 b=Uja5GolHnkT3SpC+rTWBmocIF3PTIV6aIjKlAiadcaATmGMbAoC6bXs+Ql1AsSArGGqwuoS5
 uTb4rObGkpl+/TaVzdknkowpYOQqmVGLYHjHV5MWTUfLtN5LomBh/idCxf3Zm9ZJCYGcvwFObEl
 89NOpnyAaOqGpWU+i7iEDFws=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2408:820c:270a:28e1:8433:35c1:bd48:d3f9] (2a14:7586:6109:1::198)
	by smtp.migadu.com with ESMTPS id 16511daa73eac615;
	Thu, 13 Aug 2026 04:01:31 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <8e8206d5-a63b-497f-baf6-2e9863872e2f@linux.dev>
Date: Thu, 13 Aug 2026 12:01:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pppox: drain queued packets on channel handoff
To: Jakub Kicinski <kuba@kernel.org>
Cc: pali@kernel.org, linux-ppp@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, arnd@arndb.de,
 gnault@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260811035314.302878-1-qingfang.deng@linux.dev>
 <20260813001532.2234258-1-kuba@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260813001532.2234258-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/8/13 8:15, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> pppox: drain queued packets on channel handoff
>
> PPPIOCGCHAN marks an AF_PPPOX socket as bound to generic PPP as a side
> effect of returning the channel index. This patch adds a synchronize_net()
> after setting PPPOX_BOUND and then drains sk->sk_receive_queue into
> ppp_input(), since a bound socket is no longer readable from userspace.
>
> A few questions about the new code below.
>
>> diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
>> index 5861a2f6ce3e6..a6f72c813bef9 100644
>> --- a/drivers/net/ppp/pppox.c
>> +++ b/drivers/net/ppp/pppox.c
> [ ... ]
>
>> @@ -85,7 +87,22 @@ int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>>   			break;
>>   
>>   		rc = 0;
>> +		/* PPPIOCGCHAN historically marks the userspace handoff to
>> +		 * generic PPP; pppd then attaches the returned channel to
>> +		 * /dev/ppp.
>> +		 */
>>   		sk->sk_state |= PPPOX_BOUND;
>> +		/* Let lockless receive paths finish queueing against the old
>> +		 * state.
>> +		 */
>> +		synchronize_net();
> [Severity: Medium]
> Should this skip the grace period when PPPOX_BOUND is already set?
>
> The only gate before it in pppox_ioctl() is:
>
> 	rc = -ENOTCONN;
> 	if (!(sk->sk_state & PPPOX_CONNECTED))
> 		break;
>
> so every repeated PPPIOCGCHAN on the same connected socket re-sets
> PPPOX_BOUND and runs another full RCU grace period. Neither pppox_create()
> nor pppox_ioctl() has a capability check, and pppoe_connect() only needs a
> session tuple plus an up device, so an ordinary local process can loop the
> ioctl and drive grace periods back to back.
This is theoretically possible, but in practice pppd does not ioctl 
PPPIOCGCHAN twice on the same socket.
> [Severity: Medium]
> Can this reorder frames for the pppol2tp transport?
>
> PPPOX_BOUND becomes visible before the sleep, but the already-queued frames
> are only delivered after it. Meanwhile pppol2tp_recv() reads the state
> under rcu_read_lock() only, with no socket lock:
>
> net/l2tp/l2tp_ppp.c:pppol2tp_recv() {
> 	...
> 	if (sk->sk_state & PPPOX_BOUND) {
> 		struct pppox_sock *po;
>
> 		po = pppox_sk(sk);
> 		ppp_input(&po->chan, skb);
> 	} else {
> 	...
> }
>
> So for the length of the grace period newly arriving frames go straight to
> ppp_input() while the older ones still sit in sk->sk_receive_queue, and get
> injected only afterwards. PPP receive processing is stateful (VJ header
> decompression, CCP/MPPE history and sequence numbers, multilink
> reassembly) - would injecting the stale frames after the newer ones
> desynchronize that state?
> Would draining before publishing PPPOX_BOUND, or draining under the
> receive queue lock in the same critical section that sets the state, avoid
> the inversion?
Neither suggested change alone is sufficient:
- Draining before publishing PPPOX_BOUND does not eliminate the window 
between CONNECTED and BOUND.

- Holding sk_receive_queue.lock while setting the state and draining 
does not help because the bound branch never takes that lock. A receiver 
that already chose the unbound branch can also block inside 
sock_queue_rcv_skb() and enqueue after the critical section.

If out-of-order is not acceptable, dropping them seems to be much easier.


>
>> +		/* Drain packets queued before the handoff because a bound
>> +		 * socket is no longer readable.
>> +		 */
>> +		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
>> +			skb_orphan(skb);
>> +			ppp_input(&po->chan, skb);
>> +		}
> [Severity: Medium]
> Does this feed raw PPTP-GRE frames into ppp_input()?
>
> pppox_ioctl() is also the .ioctl of pptp_ops, and pptp queues frames that
> are not yet decapsulated:
>
> drivers/net/ppp/pptp.c:pptp_rcv_core() {
> 	...
> 	if (!(sk->sk_state & PPPOX_CONNECTED)) {
> 		if (sock_queue_rcv_skb(sk, skb))
> 			goto drop;
> 		return NET_RX_SUCCESS;
> 	}
> 	...
> }

This has been fixed by "pptp: drop packets received before connect".


>
> [Severity: Medium]
> Does the socket lock actually exclude concurrent readers here?
>
> recvmsg() consumes the same queue without lock_sock():
>
> drivers/net/ppp/pppoe.c:pppoe_recvmsg() {
> 	...
> 	if (sk->sk_state & PPPOX_BOUND)
> 		return -EIO;
>
> 	skb = skb_recv_datagram(sk, flags, &error);
> 	...
> }
>
> net/l2tp/l2tp_ppp.c:pppol2tp_recvmsg() is the same shape. Only the receive
> queue spinlock is shared with the drain, and the PPPOX_BOUND test is a
> check-then-act.
I may add a socket lock in recvmsg, but again this is only theoretically 
possible. There are no concurrent readers in practice.
>
> Three things seem to follow:
>
> A reader that passed the PPPOX_BOUND test just before the ioctl set it can
> dequeue a packet the drain meant to hand to PPP, so the PPP session loses
> it silently.
>
> The drain can also steal the packet a blocking recvmsg() was woken for.
> __skb_wait_for_more_packets() watches the queue, socket errors and
> shutdown, but not PPPOX_BOUND, so the waiter finds an empty queue and
> sleeps again - and since PPPOX_BOUND is now set nothing is ever queued
> again, leaving a recvmsg() with no timeout asleep indefinitely. Is that
> possible?
This is also a pre-existing issue. The ioctl does not wake up blocking 
readers which are already waiting in recvmsg().
>
> With MSG_PEEK, __skb_try_recv_from_queue() bumps skb->users and leaves the
> skb linked. The drain's skb_dequeue() then unlinks the skb the reader is
> still copying from, skb_orphan() runs sock_rfree() and clears skb->sk, and
> ppp_input() mutates the buffer (ppp_decompress_proto() pull/push, then
> skb_queue_tail() to pch->file.rq or netif_rx()) while userspace copies from
> it. Should the drain check skb_shared()/skb_cloned(), or otherwise exclude
> peeking readers, before handing the skb on?
>
