Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF3381B0A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881213; cv=none; b=BSPqjM1Hr2LebG+iSuxPhKHlWp3gCRQbfgmF+E/xmf2vAsFY2IIQ/BnLk5CT0Aao7FLmNTyZN/h8BXZ4ZNLtyud6Mv5G4fE1QBcIWzIU404pWXgfhZdO6erbLB2oQrZ3lSR9AT6FcxTN7SPEi1sXJq9ErhubwXiMaJwxRZFApnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881213; c=relaxed/simple;
	bh=VQaH1wvSCcUtVwxxxrJu7Tdk9Yv26o0XHxhe+r5CnPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP19iooh/8e96VbTHhnEA1+yKskgraBxyrfzuD2BySUCeFTCQiJJSM7XAZdMVZ9584Cv9nG4Wefo/TEWNvdGDsnTKnjozLhbSp8eniB5KD4tsnh+pY2UgIxsBuvofu8Eok8oxjPDgsHXyYL+LxoP0/7E2eDM6jOq93HkjVyJtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKoDilM2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKoDilM2"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c89ab9a9f6cso1302111a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881211; x=1782486011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uXujLL2+ngck/ILaxQvK6OxWBpJRclqR1IeaIZXkpg=;
        b=tKoDilM2jWAD/Ic4U7oWLx1hQZ1tx/+/OVZOWQWFadPycKBayOKBdHzJAWyvzC2Dvy
         8sqXGwuLoJnTEJjEyyAzgWGGjgmpLBuLrwEbljXOlQmJP1kVwKrBWaFra6Z+q3+scVfi
         N1DA1zD8UhvEQD9zqIxBA0WKHl/bzYehGa74ZnWTdhWmKxWD68BGMibn/N75cLbj3ybd
         uSumgxj8sX91gbNx0QU1G2faMhQ3epqOLEDDJqkn5PeTGpP3/mtNGAnDhvAo63aq9jmc
         eBjSHYGZOyuG+eLsyUeMniyFGu9Y6e1d3dxsZSpqRzOnSotzLlT65BcrVjk0Nsbt4yqA
         TNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881211; x=1782486011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uXujLL2+ngck/ILaxQvK6OxWBpJRclqR1IeaIZXkpg=;
        b=DzxgC079UMs3STZGv7cQNk4Q19mQqNEuMMyiBhrK8rU24Tbm/ITudWd3y6rtO6X0Mc
         neDv7lMuzOdC8hnfhau3AGk3JKri5kQ12ZaxNOeIxclW4+LSGW6Q3HdGgsOjdPE2yy5k
         J6d0xYzEjmUBeRcg6eAKfEZvA0aFHNg6z/KFRezgPSkJg0ZGziHcxRmEgi4wGuCy55rQ
         ZGXbRyMGqCqPQpRsMaWiqaJOGUgyJkr8b301FqHhu+zU90gqb8Qz1R0Psu5qxbiDiYGv
         NGsp8dEj340HonV8Ki2pit1nsgD86XJnLWREp27zL7qW6LE/zNkf66hueJJbMZwzovFy
         I7cw==
X-Forwarded-Encrypted: i=1; AFNElJ+8S9mTRlvk08si2Od8eD5KQAkfQiXAfavkbssTgugg82aWl+ca94IaAK/6PNXbIOFpxfH8mqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWzqJFRXqjL41SkVYucvGrp0+HE98uCEG+SARF629uxFN58TC
	qRScL3Zr/+JPC863qZHMX2S9QjM5/KxkkdI0PuSdbhKj7+bqBhGL9/g+
X-Gm-Gg: AfdE7cly695gnrBG0UOkfMip5LVRuQfhqYGm10Pj6uTYfFyAp2CgdQWW9G7PXOHvAN7
	4KxpSNS1R/AiP8ndczJGL9+hpKtVccepruq6L6HJqiY/ZKash3sLg04G3Ky4QLBz54g6LEQzYfh
	+geuAyiphSjAF2vvQQP1HEgCXvrSlTH7SGcoPWTmXutmFEa0aHhDXeXzb2K1D9VXW30mTqR6Te1
	ueWzg9UtMv1pC0Talb/ttHvnHgyByyCGUm5OJnW57rg8aEG8y47m+swIITmMbvRxiCcQYfslIxD
	XugqrPMOu5yv9C0/RPR23Q1Cqj+hxUBZYuT5loVUPW0kcSoir2pphAsIjSTqZ3UbyBGipBaqF9C
	xdWfSWFQdpUDM4X3auftG2ovip5yzqKTczKXKm7jGZS5Ef34IVNOO7d20uFsD1W3oXYg5f0idrO
	qOTbCrsNrdR/grDcR2965azzRyFT0a/igiu/etz6AD/lB6eUXw
X-Received: by 2002:a05:6a20:db97:b0:3bb:78b:9dcb with SMTP id adf61e73a8af0-3bb3486bb3cmr4411766637.42.1781881209586;
        Fri, 19 Jun 2026 08:00:09 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bbffc2329sm86900a12.0.2026.06.19.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:00:08 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:59:48 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, 
	Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, 
	Guvenc Gulce <guvenc@linux.ibm.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read in
 smc_clcsock_data_ready()
Message-ID: <k4p7go5fz7wx2gp6tp5rqawrpwdiouiyzgw3tf3u3sygxuivnq@eeo7qi5ym47e>
References: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
 <20260616071639.GA104390@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260616071639.GA104390@j66a10360.sqa.eu95>

On Tue, Jun 16, 2026 at 03:16:39PM +0800, D. Wythe wrote:
>On Sun, Jun 14, 2026 at 12:09:30PM +0000, Sechang Lim wrote:
>> smc_clcsock_data_ready() is installed on the listen socket and reads its
>> sk_user_data as an smc_sock. A passive-open child inherits this callback,
>> but sk_clone_lock() clears the child's sk_user_data because it is tagged
>> SK_USER_DATA_NOCOPY. smc_tcp_syn_recv_sock() restores the child's af_ops,
>> but the inherited sk_data_ready() is left in place until accept.
>>
>> In that window the child is established. A cgroup sock_ops program can run
>> bpf_sock_hash_update() on it from tcp_init_transfer(); sk_psock_init()
>> stores a sk_psock in the NULL sk_user_data. The inherited callback then
>> reads sk_user_data via smc_clcsock_user_data(), which masks only
>> SK_USER_DATA_NOCOPY, mistakes the sk_psock for an smc_sock, and reads a
>> callback pointer past the end of the sk_psock:
>>
>>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>>    <IRQ>
>>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>>    ip_protocol_deliver_rcu+0x226/0x420 net/ipv4/ip_input.c:207
>>    ip_local_deliver_finish+0x35a/0x5f0 net/ipv4/ip_input.c:241
>>    __netif_receive_skb_one_core+0x1e5/0x210 net/core/dev.c:6216
>>    process_backlog+0x631/0x1470 net/core/dev.c:6682
>>    __napi_poll+0xb3/0x320 net/core/dev.c:7749
>>    net_rx_action+0x4fa/0xcb0 net/core/dev.c:7969
>>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>>    </IRQ>
>>
>>   Allocated by task 67930:
>>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>>    sock_map_link+0x646/0xdf0 net/core/sock_map.c:279
>>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>>    tcp_rcv_state_process+0x241e/0x4940 net/ipv4/tcp_input.c:7231
>>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>>
>> Restore the inherited sk_data_ready() in smc_tcp_syn_recv_sock(), where the
>> child's sk_user_data is already cleared, rather than only at accept.
>>
>> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>>  net/smc/af_smc.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index b5db69073e20..152971e8ad17 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>>  	if (child) {
>>  		rcu_assign_sk_user_data(child, NULL);
>>
>> +		/*
>> +		 * the child inherited the listen-specific sk_data_ready();
>> +		 * restore it here, as sk_user_data may be reused before accept
>> +		 */
>> +		child->sk_data_ready = smc->clcsk_data_ready;
>
>One concern:
>
>smc_clcsock_user_data_rcu() together with refcount_inc_not_zero() only
>pins the smc_sock; it does not guarantee anything about the lifetime or
>consistency of smc->clcsk_data_ready. In the listen-close path,
>smc_clcsock_restore_cb() clears that field under sk_callback_lock,
>while smc_tcp_syn_recv_sock() reads it without any lock. These are
>independent protection domains. If close wins the race,
>child->sk_data_ready can end up NULL and the next data arrival will
>crash.
>

will drop the syn_recv restore in v2. Thanks for your review.

>Also, I don't object to this fix, but I'd rather see the underlying cause
>addressed directly. The real issue seems to be the conflict between
>SMC's sk_user_data and sk_psock. Maybe there is a cleaner solution, e.g.
>always setting user_data.
>

Agreed. 

Thanks, will send v2.

Best,
Sechang
