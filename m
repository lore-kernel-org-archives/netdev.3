Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83742DA21
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526957; cv=none; b=Wk7j6AG2vZXdY0wy7rqAbLkeHIuYb+A3gVlq0v+/gi8La31UuxzAbGixsUJaJVde4hfacF5shCo8Aen4kfTsGa/uk2uJi/JwfqdZKXdHVkkRzvB9OBs5ntYBcnxKy4gxj+9XOgKYo8FP80LW8UJKDhDvVo3d0TJ1pFMS7b+qwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526957; c=relaxed/simple;
	bh=a7YbAaIGaqoFyyt1jW80/8TJK8l8T6HYSxQjJAVrIFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmDRZiIijWLWk1rOk2MiwB42uzC+/E6hPgHYgkHc7qaOKSyjKvT9xmKkwv1I8so6nHfaX/fU1AgTEboMAk9PC1LIctZPVD8jTCEy++NMVeeyV1zvAQEc3jX9o77UouWukPmgehOUH7Ln4iAp5lDou032lWZKUA+LrsgQH8ANd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EkMxC/Tc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EkMxC/Tc"
Message-ID: <bc16e45e-32ef-45d8-99af-14f088733ab3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783526944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIqh8CyA/K+7MkR+6EBi84I08B2cgVZ2eMAGxfb8AQI=;
	b=EkMxC/Tc5vkol0ln5AuU4I8ZAmvZGMEuq7v6xODCedS+yacW9sCZQ0jf2rpHxebGAjhLhO
	wVgSgW3JSxiIHUTDlptuJHNn4c57Dwv/ukrto5h80Y377ubUKaa/uw6SMEK0AnPZTn19/H
	ORJvJHtehXSGjIXoXAuec861XhKj39o=
Date: Wed, 8 Jul 2026 17:08:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: use sync wakeups for socket error reports
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
 kernel-team@meta.com
References: <20260708133815.3419465-1-usama.arif@linux.dev>
 <ak5rH-SWjiqR6MVe@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ak5rH-SWjiqR6MVe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 08/07/2026 16:25, Breno Leitao wrote:
> On Wed, Jul 08, 2026 at 06:38:15AM -0700, Usama Arif wrote:
>> Measured on a 176-core EPYC 9D64 host running a Meta production
>> workload, bpftrace on tracepoint:ipi:ipi_send_cpu with a kstack filter
>> attributed the sock_def_error_report -> ep_poll_callback ->
>> try_to_wake_up -> ttwu_queue_wakelist -> __smp_call_single_queue
>> chain to 16,326 IPIs/min.
> 
> I am interested in why so many sock_def_error_report().
> 
> That's seems a lot for genuine socket errors (RST/ICMP) on a healthy
> host, so I suspect these aren't errors at all?
> 
> Can you share the full stack above sock_def_error_report()?


I ran this bpftrace script the host now (results added at the end):

sudo bpftrace -e '
  kprobe:sock_def_error_report
  {
    @wake_src[kstack()] = count();
  }
  interval:s:60
  {
    print(@wake_src, 5);
    exit();
  }'


The biggest source is tcp_sendmsg -> __skb_tstamp_tx, which as you said
is not an actual error. __skb_tstamp_tx clones the outgoing skb, tags it
with ee_origin = SO_EE_ORIGIN_TIMESTAMPING and ee_errno = ENOMSG, enqueues
it on sk->sk_error_queue via sock_queue_err_skb, and calls sk_error_report
so epoll raises EPOLLERR. Userspace then reads it with recvmsg(MSG_ERRQUEUE)
to get the SND/ACK timestamp.

So the workload has SO_TIMESTAMPING enabled on its TCP sockets, and every
packet completion and every ACK triggers a timestamp delivery through the
error-queue path, which is why sock_def_error_report fires.



Attached 2 probes
@wake_src[
        sock_def_error_report+1
        sk_error_report+17
        sock_queue_err_skb+285
        __skb_tstamp_tx+903
        tcp_ack+3399
        tcp_rcv_established+1630
        tcp_v6_do_rcv+372
        tcp_v6_rcv+4748
        ip6_protocol_deliver_rcu+653
        ip6_input_finish+79
        ip6_input+43
        ipv6_list_rcv+4339
        __netif_receive_skb_list_core+244
        netif_receive_skb_list_internal+433
        napi_complete_done+149
        bnxt_poll_p5+499
        net_rx_action+513
        irq_exit_rcu+312
        common_interrupt+62
        asm_common_interrupt+34
]: 1812
@wake_src[
        sock_def_error_report+1
        sk_error_report+17
        sock_dequeue_err_skb+194
        ipv6_recv_error+74
        bpf_trampoline_6442598004+73
        ____sys_recvmsg.llvm.18251018526254450710+168
        ___sys_recvmsg+312
        __x64_sys_recvmsg+95
        do_syscall_64+316
        entry_SYSCALL_64_after_hwframe+75
]: 8045
@wake_src[
        sock_def_error_report+1
        sk_error_report+17
        sock_queue_err_skb+285
        __skb_tstamp_tx+903
        tcp_ack+3399
        tcp_rcv_established+1258
        tcp_v6_do_rcv+372
        tcp_v6_rcv+4748
        ip6_protocol_deliver_rcu+653
        ip6_input_finish+79
        ip6_input+43
        ipv6_list_rcv+4339
        __netif_receive_skb_list_core+244
        netif_receive_skb_list_internal+433
        napi_complete_done+149
        bnxt_poll_p5+499
        net_rx_action+513
        irq_exit_rcu+312
        common_interrupt+125
        asm_common_interrupt+34
        cpuidle_enter_state+202
        cpuidle_enter+40
        cpu_startup_entry+497
        ap_starting+0
        common_startup_64+318
]: 12603
@wake_src[
        sock_def_error_report+1
        sk_error_report+17
        sock_queue_err_skb+285
        __skb_tstamp_tx+903
        tcp_ack+3399
        tcp_rcv_established+1258
        tcp_v6_do_rcv+372
        tcp_v6_rcv+4748
        ip6_protocol_deliver_rcu+653
        ip6_input_finish+79
        ip6_input+43
        ipv6_list_rcv+4339
        __netif_receive_skb_list_core+244
        netif_receive_skb_list_internal+433
        napi_complete_done+149
        bnxt_poll_p5+499
        net_rx_action+513
        irq_exit_rcu+312
        common_interrupt+62
        asm_common_interrupt+34
]: 19314
@wake_src[
        sock_def_error_report+1
        sk_error_report+17
        sock_queue_err_skb+285
        __skb_tstamp_tx+903
        bnxt_start_xmit+1769
        dev_hard_start_xmit+160
        sch_direct_xmit+165
        __qdisc_run+714
        __dev_queue_xmit+2052
        skb_do_redirect+2531
        netkit_xmit+715
        dev_hard_start_xmit+160
        __dev_queue_xmit+1049
        ip6_finish_output2+848
        ip6_finish_output+213
        ip6_output+86
        ip6_xmit+933
        inet6_csk_xmit+163
        __tcp_transmit_skb+2733
        tcp_write_xmit+2948
        __tcp_push_pending_frames+46
        tcp_sendmsg_locked+4187
        tcp_sendmsg+40
        __x64_sys_sendmsg+567
        do_syscall_64+316
        entry_SYSCALL_64_after_hwframe+75
]: 33514

