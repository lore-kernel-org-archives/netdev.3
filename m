Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8913D79E9
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645034; cv=none; b=kpQ79Bo7IsmxSBXRfeRwhMMUHYsaAeeuaH01BbLeLvNmkXsi36M2jd+wpTzOzG/rZGaQ4PekGDskeVzPMcLrBOwQ3n7cZxtZJPHeQI1lxMN5RLHvdUbJA+ziKocVuPmCNaeKq+Xh6xmIpz9xP3E2NrPrYsszqYJxrhbHA86N7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645034; c=relaxed/simple;
	bh=h6jeY6kUt05J87fFLVEavDXhYt+yiXHgVOp+BHg7Xuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za5uVM04BE13+TThxY8HIgDxy0mOeWMC6+rsjaPfWa1x7p7S4a3sBeRNN3sw/vdwY3+wMOZOHn+hYoh8nDRxP2sFDvE77GHtjtpbuFOVC55e3VvCxdM4zpqqCaiv71wrgyi6QykCToG9uDhAisA1W/pUQRdNqFfyp5k3T89V9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF/VtgxY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbEk0HSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF/VtgxY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbEk0HSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787645031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
	b=hF/VtgxYRzaSfzkIZ33A1y30JIJoJqa2djVyCCsnzZQX9UPEDirm/Kvry5so7b2gzzPbbm
	LdmUTq/3SJ94HBX9/3whTmo8Pwur7tpyL4tk4UOn2gJOXP/JVKvcD6751GsNWMNv8n5xkh
	wN+ruCLI3mp11cxSXENXO79iZTKvMZ4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IZZYD0BMNuumV5seRJ0Lag-1; Tue, 25 Aug 2026 04:03:45 -0400
X-MC-Unique: IZZYD0BMNuumV5seRJ0Lag-1
X-Mimecast-MFC-AGG-ID: IZZYD0BMNuumV5seRJ0Lag_1787645024
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e555a164so49943966b.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787645024; x=1788249824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
        b=IbEk0HSZv3WUK7S6137xw+H9HYR4S/dRu/l+C6U1h//F6PWg1W4LvbTkJ0QH0Pg9MK
         wq4CWu9H2+FGhScBhYs3nCnJEvpr+I0qQ9Cjj5+zO6bCPJ8ae5s9JM2JiixhEJnkiQmv
         FtpyKifMuKVMj5Lc86OIVt+iBij5FiI7rf0905UDH/CTGjzvvVk6mhQAz8uNDdmDvRlb
         OhOgrF4RIWS1ks3yGgfCBOF0CYaPdC5UygXZpmOVTHkRahDkgLwUZGMkUVnO7GwtXfgF
         Gd7LHPTJA39QTAGFBR2ppaGVLDWf8UQfCXbYwhV5UkO+bR4WEz4bN8SBJ/zy24ZymCnT
         aVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645024; x=1788249824;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4t5HTh+6lmJKuFy4RSIDMrUEkIcD/jxh7XivmoZM5sU=;
        b=hKt+tWW6u3Ewhc4354QgojckZxObReU0mFiakAMq5QVZ8ZWurAMEFA4d9xKft+tdHj
         4A4CpaTA5pn9/EfguAcsF1Gm5cQs8AlAn21+nQOmrzep7/5atVKYJ8obLYoGHPXHlduS
         e3WNL1PUGcW1sErsCbSuzBVRPNMGymztbnu29tbPbLC2bTlGL+XSK9s0QJfk2Qn4qRmA
         SBGlcpx8asWSQVE013wkZpXajc3YXZ/yhwajvDv1nGhUUi7PVjM/y32vzozX/OEBrNp1
         hsjYK0wtCecoayQ37hD5xQ+bKu2TSK62PR0N+M2J+Nd2j7/2Gk9XIKoqKlmik4WmPSBk
         q/1A==
X-Forwarded-Encrypted: i=1; AHgh+RqkOPbx5jbEyTDV52TSk+J5GyBQFdzoYdIYbpWUusnaNH0vfzWzf5JF3yeCBX5rrz58OF2HSkw=@vger.kernel.org
X-Gm-Message-State: AFuF++kdZxAYEwL0JvdZEbHm7VlN2+/dqn42xVddiWezFNWYgKNSd5m2
	zsCPIlngsIMwrZ2Dn7TX0/w7odc3JlNIg12WnsI3mGl0g3IxrNQg8g+pEU0SphJyZNER8ojn6uI
	wqnSHELmf/cBMwaov4WJX9ibGt+xrdrA8W3+P/LRMHn4w9+Tkdxwlif+HfQ==
X-Gm-Gg: AR+sD13or3LPZ0kE3vgYa2ZYyRIGnBiszzMWbiw+QOlWpc9+5KTnEC2IU5ePxCgJrbw
	Dc9rVSIRhml4FXRen7vCKnPtlz4aVcEukL25KsbqUtBzcR5na1ebswK93hzqI/X6OZO8LjpDEGa
	766q34os1vxaHXDPYqK9Np2ti6q18/QOFF9VdmXFo4/kei84yUZgkoGtDexd2MbzRckjWzfJmZ7
	EvSpmnxPrvqTnJZ3zR85Wio/wzg0LiKBIBMv30baMZqy+TTo+JBcVOUwe36iZpdjK06wYzM2qXi
	9LJxpf6dhUkfIwOPF0ykrv5746UJ55TIkLY+LCoXjUWWhzqTiNF83TE4+3MMqdNRFylZpxkV1Q4
	XOSdwH1/OOK4CEOnglJqU0vtysHHSPvgIcaRYotQAnakuhcCB6xXgdgXfkaFRkkNbdHc/8Ea7
X-Received: by 2002:a17:907:e98a:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c24e3005531mr482562666b.16.1787645023570;
        Tue, 25 Aug 2026 01:03:43 -0700 (PDT)
X-Received: by 2002:a17:907:e98a:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c24e3005531mr482547766b.16.1787645022908;
        Tue, 25 Aug 2026 01:03:42 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e19a05bsm18230076a12.17.2026.08.25.01.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:03:39 -0700 (PDT)
Message-ID: <b1ede30d-5c03-4514-980f-c656acf3bc13@redhat.com>
Date: Tue, 25 Aug 2026 10:03:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] tls: device: fix out-of-bounds write in
 tls_append_frag()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Ilya Lesokhin <ilyal@mellanox.com>,
 Aviad Yehezkel <aviadye@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-kernel@vger.kernel.org
References: <20260823084758.20936-1-jiayuan.chen@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260823084758.20936-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 10:47 AM, Jiayuan Chen wrote:
> Found with syzkaller and a local syzbot instance running on top of a
> netdevsim TLS offload emulation; tls_device.c is otherwise only reachable
> on a machine with a NIC that implements the offload.
> 
> tls_push_data() only checks whether the open record still has room for
> another frag at the bottom of its loop, and the MSG_MORE early break
> skips that check.  The record survives to the next syscall with the frag
> count it already had, and tls_append_frag() does not check either, so
> with TLS_TX_ZEROCOPY_RO every splice(SPLICE_F_MORE) of a byte or two adds
> a non-coalescing pipe page and num_frags walks off the end of
> tls_record_info.frags[MAX_SKB_FRAGS].  Once the record is pushed,
> tls_push_record() runs the same index over sg_tx_data[MAX_SKB_FRAGS] and
> the sg_set_page() writes land on the destruct_work that follows it, which
> the workqueue then calls.
> 
> The byte limit is fine because copy drops to 0 and the loop falls through
> to the same check; the frag count has no such feedback.
> 
> Push the record rather than keep a full one open, which is what a plain
> TCP socket does - tcp_sendmsg_locked() uses tcp_mark_push() and
> new_segment in both the copy and the MSG_SPLICE_PAGES paths, and tls_sw
> already sets full_record when the sk_msg ring fills up, MSG_MORE or not.
> 
>   BUG: KASAN: slab-out-of-bounds in tls_append_frag ( net/tls/tls_device.c:269)
>   Write of size 8 at addr ffff8881104d1530 by task tls_oob/450
> 
>   CPU: 2 UID: 0 PID: 450 Comm: tls_oob Not tainted 7.2.0-rc7+ #329 PREEMPT
>   Call Trace:
>    <TASK>
>    dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
>    print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
>    kasan_report (mm/kasan/report.c:595)
>    tls_append_frag (net/tls/tls_device.c:269)
>    tls_push_data (net/tls/tls_device.c:518)
>    tls_device_sendmsg (net/tls/tls_device.c:583)
>    inet_sendmsg (net/ipv4/af_inet.c:865)
>    sock_sendmsg (net/socket.c:775 net/socket.c:790 net/socket.c:813)
>    splice_to_socket (fs/splice.c:884)
>    do_splice (fs/splice.c:936 fs/splice.c:1349)
>    __do_splice (fs/splice.c:1431)
>    __x64_sys_splice (fs/splice.c:1634 fs/splice.c:1616)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>    </TASK>
> 
> and, once the record is pushed:
> 
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:300:24
>   index 18 is out of range for type 'skb_frag_t [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:301:41
>   index 18 is out of range for type 'scatterlist [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:302:39
>   index 18 is out of range for type 'scatterlist [17]'
>   UBSAN: array-index-out-of-bounds in net/tls/tls_device.c:307:38
>   index 26 is out of range for type 'scatterlist [17]'
> 
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffea000411a680
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0011) - permissions violation
>   Oops: Oops: 0011 [#1] SMP KASAN PTI
>   Workqueue: ktls_device_destruct 0xffffea000411a680
>   RIP: 0010:0xffffea000411a680
>   Call Trace:
>    <TASK>
>    worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    </TASK>
> 
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> Hope to get capture attention
> 
> netdevsim + tls (revised a lot locally):
> https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/
I must admit that RFC series have low chances of getting full attention
these days, due to constant flood situation.

Could you please re-submit that series formally?

Thanks,

Paolo

