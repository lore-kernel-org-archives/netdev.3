Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67542E1EE0
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051038; cv=pass; b=NQtwYUT47drbKvulcv3AQWE2566136QJQy4ZSuC6otQwRHO3/GQpzhMGwOp0rOJUSD88Q4Mb2RryYCbIv/Ze8NZjptKSvwEDjjbXsUbp5HfgC3aZVmLDkVycqdEylR3XwkJJnLXwdk9+0kjl97eCd5bv8qtCIRh6l18jaCyu38A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051038; c=relaxed/simple;
	bh=7f7sfQlh7zgWV+V7b3mXETPDQ22iJskv8tJ/E7Q5QQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZGfWuZbysr7wtAVhuyRVBL1Pm8XxOd/rW8TOBDXXhSfnyXCFZYJZL/md6LEpBNtiGmdEGWEV2F757ZnDwaRo08gZN9nPN8fO74jqrE3dBrtG4oxqVkhra+744wT6fq+8EqMDc+/OR459cT9eWvNJ6hIFThLB5MrWEQWGdH1znY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uml93ON1; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uml93ON1"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2657a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792051033; cv=none;
        d=google.com; s=arc-20260327;
        b=Kr8qv8HRJo6JkVb2+M+5qCRKIGUp5haXYCDMgEnba6WBvdiN8ZWU/D3Ie8aojY8+Od
         Q4KOpqFDdP4KptwvjL9rxl9xPN9HMENjaKzqstmayPh+KKNxsD9wKPF8vdE0UjDQdp1W
         OLajOpiy9ZDF0O6bHmiW0iHBSiIte+WQuATcUzql0+6WOafPR90a0gbhgaAsKqAbe9z/
         N2Vyq86QrO5GZgEO1Equqo5Ju+0Yii/SM0Ii0tAdjpCLi2CMTkaerg/808RUS4ko1ZpL
         gM+ltuj+8DyRT94151g43kv3y0hR6dKXd1cz2lbreJsaD82luhOaqf6hpROexe1C+Va1
         Yj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RKkl1w7R6dA7DfPVUlzZJ5GxAp+b4J3TCzk6G6Mb5QE=;
        fh=3Fwtc1nULzKGtKhLqhB76g85VvQMgLW8mKeBK/P76oA=;
        b=VKEVNrUdf9FC1TmNmC+3w/Ax5PC0mMkZ5vdvv0FFVnhbZ3NBBPwLSp/O2L50d/pvGM
         sgMrI68AJ7e9PFYBLcEmpeQpkauMXdPCjy1eJOQNFHfd6qYZlr4gxljjLESHJd/BLcYi
         5t8nhxe/OxVpt2tuAFq4nBe8wyn9AhxyiveamKkI7o+CTK2ACjrxNlgCuUDaJ929wl3U
         eclOkXHQ+yK7xsv3mn97DeXEKYgBqy1MOEEgp75exgJmuQOSYZkLqSAENyrKZWxZhVJN
         1p1WcCozs0BnHbWPZNhHGpRgqrq2yykOH5wY0pasybBbOzdSWREx4JxpQGIV51HUp4o4
         2mxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792051033; x=1792655833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RKkl1w7R6dA7DfPVUlzZJ5GxAp+b4J3TCzk6G6Mb5QE=;
        b=Uml93ON1Tzn2hcTxdrArA+/Qx/yBGQVJlqVdNd4J7ScPDWt1IWm0m20rCKX/qQsd0c
         dyytDdX328Rlmjc3o7eaaYhO3GEzQ5gRjTA0bgBNN/4ze26JkmTxbbEH4Yvc/sduf4i8
         DXdt56mlZsGS2p5Utr03NLfDvsEEEjmRPzjA4Iue/pVUrIQ3+XBMH2uRS6qtqxSxdDTW
         PPxSPIwTZLvKdst6OAUSHqQk9r7RgEaXpsY20a+Z/FntLC4qs2pB9kWjZ4rhcOPhDhv6
         tIPNw2pkQMrhH7C9WSRgbo/JpPKPXDx2bpbLPboh6opxnqASJAcMN11lC2gANy5npC2a
         Xz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051033; x=1792655833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKkl1w7R6dA7DfPVUlzZJ5GxAp+b4J3TCzk6G6Mb5QE=;
        b=PUKP8Ej3Mbx39O+nk4BzB8SJRWNEZqUwZ1nXK+8HA20Q7XqV5YNnGke/G8qfUK5tBr
         EkXeSDxT/eakjeJS/by10fj23jEHJsAxnIa08t9iPYudkGG3TmlSX+nU6kl2wb9SYkLa
         mnaLrJE9Jn3pgRaU9MJZ3wQUDbFSi5vS3R3f1oYTh29B0M2d6Wj95BgjrvibE4IIxaRh
         g3kYDMPrXT03IN8vlftQSoLvSvxjQs7dIIBFCf9Su+vzlw+YCziVkKoYHf1gt4Oh5m+7
         ANbYfuXHMXAZr+vpkCMDhCC13jpKgcdrgD134JMEKs0GKyRNHEXWFRkIATGnzzHOy6Bh
         z5aw==
X-Forwarded-Encrypted: i=1; AKwUvBzJ1Gdcew5fWjv/J+aL/O8t+l21tIhmc3OyeSKF6tkACMvxWJ2TpUVDmkWu0JK8BuNIhtLtd9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq9VOMsd5CEiM1aySlnDOuQ5+HuEGz4AmaxWQxg0s6NGp4gy8Q
	IwvcglPjmgr/Ft2pwCyHhw5hg6enQHTS4zka2ot5b1cLchdX4GZmWiq+DihuI/HfiOZGI5GU8VE
	YYDkVGYNndi2gNPiqD/wWcCIn5wuhQLbLPZo87HW9
X-Gm-Gg: AYBFou1dOCPR99Q5cpUFFbP1tmcI1RhKT7H9/xFUqk5NCArHtdfjzoMnl0bQoiuOWFi
	/wb09L029Jo9vPEpdsbZwo06OactZo4XkyYXJyPNHedDNBav3lINWwZXRjg/9jaGjLiIleoAB0W
	ZlCN3VC4MuqWygmz0c5QaPe9uzIntxykYx9ILbJXmpSqfejmaLY2QT1TwhyGI27T8cbX9G04Oi1
	amSaZqpFa53N1JWqPOjaOZGZUkA+AdDL9znkNOfTzMpAcKCWZJt1NQSuCrhRlCqAwMWR8CJGiaX
	zrUmDeWh12FI/MuP5yR6R/86gyzKi8l3C+XdGY6I9doHhFpQNHx1J3aJ6xUFK7DK6VNpKVQ7D1L
	g7h416+K8qD2CVg==
X-Received: by 2002:a05:6402:a6c2:10b0:6af:8433:3c7e with SMTP id
 4fb4d7f45d1cf-6b32bb8bfcemr13427a12.2.1792051031273; Thu, 15 Oct 2026
 00:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015073736.2944215-1-tavip@google.com> <179205021846.408196.14808616314279740107@kernel.org>
In-Reply-To: <179205021846.408196.14808616314279740107@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Thu, 15 Oct 2026 00:56:58 -0700
X-Gm-Features: AclHuK8v7XQtgecDV0jsO__BHD8YwxutmfG-K5IsGFWan04ZMe1cAcKU4mLeRAA
Message-ID: <CAGWr4cS1rmo9+6gT==D1FGb34K9KW+uPO=se8-WV8YE-SJP8pw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:43=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>

The issue was discovered in production, here is an example warning:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 939331 at include/linux/thread_info.h:249
tcp_sendmsg+0x10c1/0x1530
Modules linked in: kvm_amd hdi2_standard_ftl hdi2_megablocks hdi2
xenolith stg elephant_dev_num nv_p2p_glue vfat fat livepatch_v1(OEK)
k10temp i2c_piix4 i2c_via_ipmi i2c_mux_ltc4306 google_bmc_usb gq
cdc_acm xhci_pciJun 18 01:48:26.051200 rdht15 kernel: [66690.105140]
CPU: 1 UID: 368767421 PID: 939331 Comm: DefaultEventMan Kdump: loaded
Tainted: P S      W  OE K     6.12.63-smp-1400.86.0.0 #1
Tainted: [P]=3DPROPRIETARY_MODULE, [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN,
[O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE, [K]=3DLIVEPATCH
Hardware name: Google, Inc.
           Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-0 01/25/2026
RIP: 0010:tcp_sendmsg+0x10c1/0x1530
Code: ee 44 8b 64 24 3c 0f 84 ae f5 ff ff 48 8b 7c 24 48 e8 f3 a7 23
00 41 be f2 ff ff ff 4c 8b 6c 24 10 44 8b 24 24 e9 4a 03 00 00 <0f> 0b
31 c0 e9 7e f5 ff ff 41 80 8f 84 00 00 00 01 e9 00 f6 ff ff
RSP: 0018:ffffbaff64a6fc38 EFLAGS: 00010282
RAX: 0000000000000062 RBX: ffff9c45670d3c00 RCX: 25c2e5210d8ebf01
RDX: 0000000000600000 RSI: 00000000fff8427f RDI: ffff9c43f2fc0062
RBP: ffffffffffe4b17f R08: 0000000000000000 R09: 0000000000000002
R10: ffff9c4c187b6200 R11: 00000000000001b6 R12: 0000000000000000
R13: ffff9c4383ffc1e8 R14: 00000000ffe4b17f R15: ffff9c40fe838600
FS:  00007fe39fbaf700(0000) GS:ffff9c874ce40000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000010986487a238 CR3: 0000000973fb8006 CR4: 0000000000f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 [<ffffffffa5c218a2>] __sys_sendmsg+0x292/0x490
 [<ffffffffa5c6281f>] ? restore_sigcontext+0x15f/0x1c0
 [<ffffffffa5c6e1d0>] ? __pfx_flush_tlb_func+0x10/0x10
 [<ffffffffa5c6e965>] ? flush_tlb_local+0x285/0x2a0
 [<ffffffffa5ba1b29>] ? sched_clock+0x9/0x10
 [<ffffffffa5bd7900>] ? sched_clock_cpu+0x10/0x180
 [<ffffffffa5be362a>] ? generic_smp_call_function_single_interrupt+0x19a/0x=
430
 [<ffffffffa5f51848>] do_syscall_64+0x88/0x340
 [<ffffffffa6000136>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x5580e3f28a3d.
