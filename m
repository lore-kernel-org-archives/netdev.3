Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951423;
	b=NbcrB3mzPjDfxdiDH+2RMlplAJmHlDk2QrhS66hHUqhBX07PYUdyMK3GbMLxh6GGp3xt
	 0VVemjissQvMhxvCtkdQOnmugvH2Atws51OItr+350uOgnNZc1+WTMMnYl55IKfyOnJTw
	 g7crzuvzv3XzxveRrFmEkMAd/36pnZLksdwDUeyjywgkBeo7jK4/SrMs2UzBf3ZeDhx6j
	 MjW6TrJJjVh8XeByetN9TRGaeNeG3SFsNfH5vPMIMwR0Aygv8L0U7DspW6/QZA8JD9ue2
	 1nbG01MhivvO4fM6HeJgtg/jvYB+apRjFldLZ7v1StXcmBA3lYfBwB7AFadKWMKh57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951423;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=0WPYejdlZaNbGWqikmEW2WWog+lfVYOfd9tK6fXAjJM=;
	b=zNxokWgjaLA6WeYn8PmXr1cObaEpv9xWwwi+2bMuE7vXgv56PkhLFDzgRTKSWdepQguU
	 +DoPHDNCrYAsRNePwpRZq5tlxtPsK3HDcDc/5Kchw906y4y/KiIO+u8zm6k4PUUXmwreK
	 gc6A9oPbisMjcJ2CY29bGIxyMID4b8aphEO0Vo0cXIw5xGJgmMt6qFk34uZr1NK6mBOIV
	 +GUxFnIhKyIBRMedxTBL+euGZ/7qo7Kdc0VOkj9gTsslDKGWgsma6Eckzhwf7iXAyxPaN
	 JsVhiBkZJgRDkSS8Sn9H3p2dV7w/baXVBoQILDLvDZtqMoerfO0xb4hetkByRpjqbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=q+71oVcA;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA3606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31FA3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=q+71oVcA
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5CBC820870;
	Fri,  6 Nov 2026 08:50:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VskECbvq89cT; Fri,  6 Nov 2026 08:50:19 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A3ADA2074F;
	Fri,  6 Nov 2026 08:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A3ADA2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793951419;
	bh=0WPYejdlZaNbGWqikmEW2WWog+lfVYOfd9tK6fXAjJM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=q+71oVcAHQrvZo+4515Bkjs3Y+6OOPKM6EWCrxg/uU0OX3UhoflwaY90dV3zyPsaI
	 iUOu+ORwP00o9ZHVGPwNyw4sXGivkYzwXBQx/diYt/WPTedUaIg238jxSDLUUeI0+9
	 zzsecN7wOCROcWbizs7dEpYpUf7Vv+0MsiWwVoxbvhdat2EBGv3Q+MUTgvVCOiXAld
	 7QeLeCwJ1CUizuPrYjDWc5kGYbdrkyTAY3R0o4XSGEC3Bqoo6KQnvzNMgSdLS3iXPV
	 6jsU2GTtxjbi4A5MQfTUuCPu9uAnQxbQ8rydCcVu6yHvbZCAjO8IO3FdxNeibxYgz2
	 e0QqtywrZ3QMA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 6 Nov
 2026 08:50:18 +0100
Received: (nullmailer pid 3071058 invoked by uid 1000);
	Fri, 06 Nov 2026 07:50:17 -0000
Date: Fri, 6 Nov 2026 08:50:17 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cen Zhang <zzzccc427@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <baijiaju1990@gmail.com>, <jjzuming@gmail.com>
Subject: Re: [PATCH ipsec] xfrm: keep the mode module pinned until
 destroy_state returns
Message-ID: <au2GuZzD5np1nwiY@gauss4>
References: <pm-xfrm-core-objects-candidate-0003-v3-3f3e13b81234df0bb10f@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <pm-xfrm-core-objects-candidate-0003-v3-3f3e13b81234df0bb10f@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 29, 2026 at 11:19:11AM +0800, Cen Zhang wrote:
> An IPTFS state keeps its mode module referenced while mode_data exists.
> However, iptfs_destroy_state() drops that reference before returning to
> xfrm_state_gc_destroy(), which has no reference covering the callback's
> return path.
> 
> With CONFIG_XFRM_IPTFS=m and module unloading enabled, deleting the last
> IPTFS SA can overlap with ordinary module removal in this order:
> 
>   XFRM GC worker                      rmmod xfrm_iptfs
>   iptfs_destroy_state()
>     free mode_data
>     module_put(owner)
>     <preempted>
>                                       delete_module()
>                                         xfrm_iptfs_fini()
>                                           unregister mode callbacks
>                                         free_module()
>     resume in freed module text
> 
> An unload started after the put can finish before the callback resumes.
> GC invokes the callback outside an RCU read-side critical section, after
> its grace period. The RCU waits in mode unregistration and module
> freeing therefore do not protect the callback. The GC mutex only
> serializes GC with device state flushes. Resuming the callback can cause
> an instruction-fetch fault in the freed module text.
> 
> The Oops below was observed on an earlier kernel with scheduling probes
> holding the worker in module_put() after the decrement until ordinary
> rmmod completed. The fixture created and deleted the SA over
> NETLINK_XFRM.
> 
> Take an additional reference to the already pinned owner before calling
> destroy_state(), and release it in XFRM core after the callback returns.
> Cache the owner before the call so releasing the extra reference does
> not need to access the callback table after the callback has finished.
> 
> Oops report as below:
>     BUG: unable to handle page fault for address: ffffffffc0407455
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     PGD 80a9067 P4D 80a9067 PUD 80ab067 PMD 0 
>     Oops: Oops: 0010 [#1] SMP KASAN NOPTI
>     CPU: 3 UID: 0 PID: 53 Comm: kworker/3:1 Not tainted 7.2.0-rc5-pmb-xfrm-functional-v1+ #11 PREEMPT(lazy) 
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     Workqueue: events xfrm_state_gc_task
>     RIP: 0010:0xffffffffc0407455
>     Code: Unable to access opcode bytes at 0xffffffffc040742b.
>     RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
>     RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
>     RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
>     RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
>     R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
>     R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
>     FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      ? pmbd_gate_maybe+0x47/0x60
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_is_held_type+0x8f/0x100
>      xfrm_state_gc_task+0x17e/0x790
>      ? lock_acquire+0x17b/0x2f0
>      ? __pfx_xfrm_state_gc_task+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_release+0xc8/0x280
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      process_one_work+0x908/0x19c0
>      ? __pfx_process_one_work+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_is_held_type+0x8f/0x100
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      worker_thread+0x65c/0xe40
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __kthread_parkme+0x175/0x220
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x34f/0x460
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x659/0x940
>      ? __pfx_ret_from_fork+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __switch_to+0x74f/0xf80
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     Modules linked in: [last unloaded: xfrm_iptfs]
>     CR2: ffffffffc0407455
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:0xffffffffc0407455
>     Code: Unable to access opcode bytes at 0xffffffffc040742b.
>     RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
>     RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
>     RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
>     RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
>     R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
>     R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
>     FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Kernel panic - not syncing: Fatal exception
>     Kernel Offset: disabled
> 
> Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM

Applied, thanks a lot!
