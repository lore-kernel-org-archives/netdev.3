Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741733;
	b=Xex8HSu3UDwytLLTCqx+w5xCVIg5SagfnhpEnNCIqljQc/rWzYt3A3uMasCBPSvOE1wj
	 TlEDtmEGFx9c0fkkzMcizL1mjFW4SKJi/KMG7tBc/o7OOKg3nSrRWS5uN+TCTFZtM7CWZ
	 jK9mbzulAu3sBYLQx+oiztAc4cQvV+N1ECahxzR7svHPT8lKG1yMfNkO30ojCfc8adlmK
	 4Lh3aroq4neiXWYHTGbazUzKUGZDiQHa3KszBiTO5JmM2cyNqBF+B8hJO6VTVp9abpGDC
	 xexTeHwrzBLT/YO6/NFVfk0i5tPSrRkI/9uMUEUw5LuiaXUu2Kw4YJC+lEGYr8KLeJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e8koCkEU5Xws8Ans7cyALf0MAvBOqOWplSAl1+xI/fE=;
	b=d0Wsk6/3hq9ejS2VCKpAavu7Mjz7UWYpSdE6T+i+tfEcldbtnQIs2Xu4JIIsfbym0Byd
	 WPcuS6w6XbqELNmuHB4cQhfSChFY8Szhbxa6ksDUYFvmzUV+lkNuuKoXxrshQqva7jav8
	 8Cr5FhzOPOXO1E0CESXVUvjGacLQlqk2EQXJjKbhDVCU+T0Yaegvv5R2VOHIxlQrxtC9V
	 7m4qYW+lHEj3MwrliBwgDGCZWI458cyqQryT8eGtSIfuo3KsCqfOHg5+b15XkOa/2Mdz+
	 /nNgbTg28lqSwJHXPHOG7kn42kUejJa6aJXv8JskVCgauFDaQuMYYYmgYLopQFYm2Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CdVLtxsf;
	arc=none smtp.remote-ip=209.85.214.195
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271C606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4271C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CdVLtxsf
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2e9ae391a05so3467925ad.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741733; x=1793346533; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8koCkEU5Xws8Ans7cyALf0MAvBOqOWplSAl1+xI/fE=;
        b=CdVLtxsfJzL24K7+joitQJSKPHh7sbUF0mQaG0jywqo9OdS1N4xG1/Oqg12uKWMBMb
         GpsRyecv4Lbe7bvGgzMcWsJgaZ+pzp0N6s1UoADn1prAzV6wbXWvHzWv21BU/g0m19gs
         sIDDi1kmwHLbPEVNm27SYIhovJGSBy9lyz13sIueyR1u+v3oCHO/K6GbGXSmG/Q+vB9P
         1/JFI7DoXDhlZVsQBbXkbOISfOyJyU72PHt3yF1HtGJ3+yfij8o/0FQPupuXCUH9DQt6
         EuG/O1AbkG8BFY7/JNW2r5E5c2g39ovsGUYBbS1lFii0rd0+WbDCg0thXnop7eug7a0D
         aPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741733; x=1793346533;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8koCkEU5Xws8Ans7cyALf0MAvBOqOWplSAl1+xI/fE=;
        b=B4HqEQoyA8j4o+miAgqJRUjuN7szEwz8KAVjFFB9YJdB4lA4d5Q2BcgOKvDSbuxgCi
         VyvtaO/c7nrEls1XrQZuBQ73GwAug3MJ1oDi2jNsA2Ewx2LfePVQOXtKWiuoXUSWZ6LV
         iyz3Q06+zazYkDF5kmrMMvNCBU44rGUicHmOKnKs/ZIhZnXEyxaRooBOSDWpLWiPZgoZ
         OmG1xuRl+FCON2cYYlFCzVl+5biaBEgjYxaGWLLsIgyTnoLx/Ih3JC7ANDpCi5snab1w
         bCKmEwuuTyERiNvq+0r7PNGh+l9vBlPMcKnkmSGIvTwnXj/zP7/JhJGdM8Zq5RCOyfn+
         jJPA==
X-Gm-Message-State: AFq9FYJwenL4pW+QKdHznwstV47Q4hk4EcvpPKNx94Vwz9FbeuOCt56a
	vOtrF1oe+41fBI96/geD4w9mgFxlgj2BYFOItSgebJyf2BgrWoxl3uv/6+OYmYX2NvFrhw==
X-Gm-Gg: AYBFou1okZGAb8HA03jstMZOu4+e5MwaoZp8zD+3xvYoEhlb0dax08RruDPQDbUL/8v
	x99TOSi7DMVRPtIzKK+dVcwYR1yLEQuyKXysgLxn0AzdRjJ6PnI+AscQH6k6gb9+hmt2EjrW8+S
	Zyaf/XXfax3T/t9zfBL1ZXUPRAMjB5tf/KuwKvvp65ZHJXroz1st1wpQENVh7PRJCMuwYPmGImA
	pfVyGtFxRFzvvXG9cdjllU6NRmzXaGrR3UBMpE/gfMyzLXqy/Kj73V40GKPLqxm9t06zqAwN/CF
	pyTrTa/o/zENdNEEgrPtwkqGcT7SikazRrMJY6tHjVi/nv9lsB7EtkF1Ho81FkY6lfNgoTeZe3Z
	scci1OZAiRvlkTWKi5JyuUkaHP9EEUuuoG78JDFY7nKIjXThpwD6gB6J6CC93V0eXoZ1s7/mDVu
	+PjimiIseS8awK3pvxHKQBJPJuj6CwLhEvPbSOMmeXrNSTxLtqBhnl/utIfnYQVhVwbJ5FQRZmp
	SmaBCgAPw92C6nemwEm02/JnbFaB5GF/48VtkJjNtPBBQBn3k9gJOIXAlZPW2KH5adhh/o=
X-Received: by 2002:a17:903:1207:b0:2e9:b831:29ea with SMTP id d9443c01a7336-2ea62b85c61mr29688545ad.40.1792741732222;
        Fri, 23 Oct 2026 00:48:52 -0700 (PDT)
Received: from [192.168.43.2] ([119.234.41.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b4fa14asm6757475ad.69.2026.10.23.00.48.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:48:51 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: netdev@vger.kernel.org
Subject: Re: [PATCH] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
Date: Fri, 23 Oct 2026 15:48:53 +0800
Message-ID: <179274173336.25452.8875482521023474377@gmail.com>
In-Reply-To: <6adad51d.8fc0b0c9.1ec657.1868@mx.google.com>
References: <6adad51d.8fc0b0c9.1ec657.1868@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

As a follow-up to my earlier patch, I performed some additional dynamic
validation of the reported stale-route use-after-free. I was able to reproduce
the same issue with KASAN on Linux 7.3, 7.2.12, and 6.18.58. I hope these
additional results are helpful.

I also found one correction to the affected-range analysis in my original
message. Commit a8e3e1a9f020 ("net: l3mdev: Add hook to output path") added
the generic L3-master output hook, but it did not by itself make this IPv6
VRF path reachable. The vulnerable combination was completed by:

  4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out =
hook")

That commit connected the IPv6 VRF output handler and added the destination
replacement which releases the original skb destination. Therefore, the
appropriate Fixes tag should be:

  Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook =
to out hook")

I apologize for the incorrect introduction commit in my original message.
Linux v4.8 does not contain the complete vulnerable path. A tag-by-tag source
check found the sequence in v4.9-rc1, every final upstream release from v4.9
through v7.3, and Torvalds' mainline commit
734bef548a96e8774d6eef5dfa2026c6edc4e80b (2026-10-22). This is a source-level
affected-range assessment; dynamic KASAN reproduction was performed only on
v6.18.58, v7.2.12, and v7.3. Vendor kernels may differ because of backports.

The common test environment was QEMU/KVM x86_64 with four vCPUs,
KASAN_GENERIC/KASAN_INLINE, CONFIG_NET_VRF=3Dy, CONFIG_IPV6=3Dy,
CONFIG_NET_SCH_FQ=3Dy, and CONFIG_DUMMY=3Dy. The kernels were booted with
preempt=3Dfull and rcupdate.rcu_expedited=3D1. The reproducer sent raw IPv6
IP_HDRINCL packets through a dummy interface enslaved to a VRF whose root
qdisc was fq.

For convenience, I have included the detailed KASAN reports inline below. The
KASAN sections are copied directly from the captured serial logs. The final
reproducer-summary line following each report is labeled separately. I
apologize for the length of the message, but I thought the complete diagnosti=
cs
might be useful.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 7.3 (commit c03c1a14507dfaf8b856c2608f9ac216021fc222)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   18.595533] BUG: KASAN: slab-use-after-free in rawv6_sendmsg+0x2f12/0x35f0
[   18.595669] Read of size 8 at addr ffff88800f91d9d0 by task repro/101
[   18.595671]=20
[   18.595784] CPU: 0 UID: 0 PID: 101 Comm: repro Tainted: G        W        =
   7.3.0 #1 PREEMPT(full)=20
[   18.595791] Tainted: [W]=3DWARN
[   18.595797] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
13.0-1ubuntu1.1 04/01/2014
[   18.595810] Call Trace:
[   18.595842]  <TASK>
[   18.595844]  dump_stack_lvl+0x55/0x70
[   18.595890]  print_report+0x10d/0x5d0
[   18.595934]  ? rawv6_sendmsg+0x2f12/0x35f0
[   18.595936]  kasan_report+0x96/0xd0
[   18.595938]  ? rawv6_sendmsg+0x2f12/0x35f0
[   18.595940]  rawv6_sendmsg+0x2f12/0x35f0
[   18.595948]  ? update_load_avg+0x156/0x30e0
[   18.595978]  ? __pfx_rawv6_sendmsg+0x10/0x10
[   18.595980]  ? __switch_to+0x58a/0xdd0
[   18.596004]  ? __pfx_vrf_output6+0x10/0x10
[   18.596043]  ? __pfx_vrf_output6+0x10/0x10
[   18.596045]  ? __schedule+0x123d/0x3e60
[   18.596055]  ? __pfx_dst_output+0x10/0x10
[   18.596057]  ? update_se+0x33f/0x1380
[   18.596059]  ? __pfx_sock_has_perm+0x10/0x10
[   18.596081]  ? irqentry_exit+0x10e/0x6e0
[   18.596083]  ? timerqueue_linked_add+0x1fb/0x3f0
[   18.596089]  ? irqentry_exit+0x10e/0x6e0
[   18.596091]  ? selinux_socket_sendmsg+0x8a/0x290
[   18.596097]  ? __pfx_inet_sendmsg+0x10/0x10
[   18.596131]  ? __sock_sendmsg+0x135/0x180
[   18.596154]  ? __pfx_inet_sendmsg+0x10/0x10
[   18.596155]  __sock_sendmsg+0x135/0x180
[   18.596157]  __sys_sendto+0x1ed/0x2d0
[   18.596159]  ? __pfx___sys_sendto+0x10/0x10
[   18.596160]  ? finish_task_switch+0x1d4/0x9a0
[   18.596169]  ? __hrtimer_run_queues+0x2a5/0x580
[   18.596191]  ? __pfx___schedule+0x10/0x10
[   18.596193]  __x64_sys_sendto+0xdc/0x1b0
[   18.596194]  ? fpregs_assert_state_consistent+0x5e/0xf0
[   18.596209]  do_syscall_64+0xee/0x500
[   18.596215]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   18.596221] RIP: 0033:0x4071a4
[   18.596227] Code: f2 fc ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54=
 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d=
 00 f0 ff ff 77 30 89 ef 48 89 44 24 08 e8 18 fd ff ff 48 8b
[   18.596228] RSP: 002b:00007ffe0499c770 EFLAGS: 00000293 ORIG_RAX: 00000000=
0000002c
[   18.596257] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000407=
1a4
[   18.596258] RDX: 0000000000000028 RSI: 00007ffe0499c810 RDI: 0000000000000=
003
[   18.596259] RBP: 0000000000000000 R08: 00007ffe0499c7f0 R09: 0000000000000=
01c
[   18.596260] R10: 0000000000000040 R11: 0000000000000293 R12: 00007ffe0499c=
7f0
[   18.596266] R13: 0000000000000000 R14: 0000000000016762 R15: 00007ffe0499c=
810
[   18.596268]  </TASK>
[   18.596281]=20
[   18.596281] Allocated by task 101:
[   18.596303]  kasan_save_stack+0x24/0x50
[   18.596310]  kasan_save_track+0x14/0x30
[   18.596311]  __kasan_slab_alloc+0x59/0x70
[   18.596312]  kmem_cache_alloc_noprof+0x133/0x390
[   18.596324]  dst_alloc+0x75/0x150
[   18.596335]  ip6_dst_alloc+0x1e/0x90
[   18.596344]  ip6_rt_cache_alloc.isra.0+0x167/0x620
[   18.596346]  ip6_pol_route+0x8a0/0xae0
[   18.596347]  fib6_rule_action+0x22c/0x900
[   18.596363]  fib_rules_lookup+0x3a2/0xab0
[   18.596381]  fib6_rule_lookup+0x16c/0x610
[   18.596382]  ip6_route_output_flags+0x21a/0x360
[   18.596385]  ip6_dst_lookup_tail+0x26f/0xdf0
[   18.596389]  ip6_dst_lookup_flow+0xf5/0x1e0
[   18.596391]  rawv6_sendmsg+0xa10/0x35f0
[   18.596392]  __sock_sendmsg+0x135/0x180
[   18.596394]  __sys_sendto+0x1ed/0x2d0
[   18.596395]  __x64_sys_sendto+0xdc/0x1b0
[   18.596395]  do_syscall_64+0xee/0x500
[   18.596397]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   18.596398]=20
[   18.596398] Freed by task 102:
[   18.596399]  kasan_save_stack+0x24/0x50
[   18.596400]  kasan_save_track+0x14/0x30
[   18.596401]  kasan_save_free_info+0x3a/0x60
[   18.596403]  __kasan_slab_free+0x43/0x70
[   18.596404]  kmem_cache_free+0x1cf/0x3c0
[   18.596406]  dst_destroy+0x181/0x1f0
[   18.596407]  rcu_core+0x5af/0x1820
[   18.596420]  handle_softirqs+0x17f/0x5b0
[   18.596432]  irq_exit_rcu+0x69/0x150
[   18.596433]  sysvec_apic_timer_interrupt+0x39/0x80
[   18.596435]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   18.596436]=20
[   18.596437] Last potentially related work creation:
[   18.596438]  kasan_save_stack+0x24/0x50
[   18.596439]  kasan_record_aux_stack+0x89/0xa0
[   18.596440]  __call_rcu_common.constprop.0+0x70/0x890
[   18.596442]  vrf_l3_out+0x950/0xb40
[   18.596443]  rawv6_sendmsg+0x2743/0x35f0
[   18.596445]  __sock_sendmsg+0x135/0x180
[   18.596446]  __sys_sendto+0x1ed/0x2d0
[   18.596447]  __x64_sys_sendto+0xdc/0x1b0
[   18.596448]  do_syscall_64+0xee/0x500
[   18.596449]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   18.596451]=20
[   18.596451] The buggy address belongs to the object at ffff88800f91d900
[   18.596451]  which belongs to the cache ip6_dst_cache of size 224
[   18.596460] The buggy address is located 208 bytes inside of
[   18.596460]  freed 224-byte region [ffff88800f91d900, ffff88800f91d9e0)
[   18.596462]=20
[   18.596463] The buggy address belongs to the physical page:
[   18.596478] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0=
 pfn:0xf91c
[   18.596491] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 p=
incount:0
[   18.596492] flags: 0x100000000000040(head|node=3D0|zone=3D1)
[   18.596507] page_type: f5(slab)
[   18.596520] raw: 0100000000000040 ffff888006e00500 dead000000000100 dead00=
0000000122
[   18.596522] raw: 0000000000000000 0000000000190019 00000000f5000000 000000=
0000000000
[   18.596527] head: 0100000000000040 ffff888006e00500 dead000000000100 dead0=
00000000122
[   18.596541] head: 0000000000000000 0000000000190019 00000000f5000000 00000=
00000000000
[   18.596542] head: 0100000000000001 ffffffffffffff81 00000000ffffffff 00000=
000ffffffff
[   18.596543] head: 0000000000000000 0000000000000000 00000000ffffffff 00000=
00000000000
[   18.596544] page dumped because: kasan: bad access detected
[   18.596544]=20
[   18.596545] Memory state around the buggy address:
[   18.596545]  ffff88800f91d880: fb fb fb fb fc fc fc fc fc fc fc fc fc fc f=
c fc
[   18.596546]  ffff88800f91d900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb
[   18.596547] >ffff88800f91d980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc f=
c fc
[   18.596548]                                                  ^
[   18.596549]  ffff88800f91da00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb f=
b fb
[   18.596550]  ffff88800f91da80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb
[   18.596550] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   18.616663] Disabling lock debugging due to kernel taint
Reproducer summary: sends=3D906284 errors=3D0 pulses=3D4214

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 7.2.12 (commit cc9de5d4b5ab6459f5774946aa3195ad51236fa8)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    6.731112] BUG: KASAN: slab-use-after-free in rawv6_sendmsg+0x324d/0x3630
[    6.734083] Read of size 8 at addr ffff88800972fb10 by task repro/85
[    6.737864]=20
[    6.739614] CPU: 0 UID: 0 PID: 85 Comm: repro Not tainted 7.2.12 #1 PREEMP=
T(full)=20
[    6.739672] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
13.0-1ubuntu1.1 04/01/2014
[    6.739726] Call Trace:
[    6.739787]  <TASK>
[    6.739791]  dump_stack_lvl+0x55/0x70
[    6.739815]  print_report+0x10d/0x5d0
[    6.739919]  ? rawv6_sendmsg+0x324d/0x3630
[    6.739950]  kasan_report+0x96/0xd0
[    6.739956]  ? rawv6_sendmsg+0x324d/0x3630
[    6.739963]  rawv6_sendmsg+0x324d/0x3630
[    6.739970]  ? kvm_clock_read+0x14/0x30
[    6.740047]  ? __pfx_rawv6_sendmsg+0x10/0x10
[    6.740054]  ? __schedule+0x1238/0x3e60
[    6.740081]  ? __pfx_vrf_output6+0x10/0x10
[    6.740181]  ? __pfx_vrf_output6+0x10/0x10
[    6.740189]  ? preempt_schedule_irq+0x49/0x80
[    6.740195]  ? irqentry_exit+0x10e/0x6e0
[    6.740217]  ? __pfx_rawv6_sendmsg+0x10/0x10
[    6.740224]  ? __pfx_inet_sendmsg+0x10/0x10
[    6.740288]  ? __sock_sendmsg+0x135/0x180
[    6.740385]  ? __pfx_inet_sendmsg+0x10/0x10
[    6.740390]  __sock_sendmsg+0x135/0x180
[    6.740398]  __sys_sendto+0x1ed/0x2d0
[    6.740404]  ? __pfx___sys_sendto+0x10/0x10
[    6.740410]  ? __schedule+0x1238/0x3e60
[    6.740414]  ? __hrtimer_run_queues+0x26e/0x580
[    6.740479]  ? fdget_pos+0x392/0x4c0
[    6.740516]  ? fput+0x25/0x70
[    6.740533]  ? ksys_write+0x189/0x1c0
[    6.740536]  ? __pfx_ksys_write+0x10/0x10
[    6.740538]  __x64_sys_sendto+0xdc/0x1b0
[    6.740541]  ? fpregs_assert_state_consistent+0x5e/0xf0
[    6.740581]  do_syscall_64+0x104/0x5c0
[    6.740586]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    6.740599] RIP: 0033:0x4071a4
[    6.740634] Code: f2 fc ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54=
 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d=
 00 f0 ff ff 77 30 89 ef 48 89 44 24 08 e8 18 fd ff ff 48 8b
[    6.740636] RSP: 002b:00007ffe6facd9a0 EFLAGS: 00000293 ORIG_RAX: 00000000=
0000002c
[    6.740696] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000407=
1a4
[    6.740705] RDX: 0000000000000028 RSI: 00007ffe6facda40 RDI: 0000000000000=
003
[    6.740708] RBP: 0000000000000000 R08: 00007ffe6facda20 R09: 0000000000000=
01c
[    6.740709] R10: 0000000000000040 R11: 0000000000000293 R12: 00007ffe6facd=
a20
[    6.740711] R13: 0000000000000000 R14: 0000000000000639 R15: 00007ffe6facd=
a40
[    6.740715]  </TASK>
[    6.740716]=20
[    6.853371] Allocated by task 85:
[    6.855389]  kasan_save_stack+0x24/0x50
[    6.856865]  kasan_save_track+0x14/0x30
[    6.859773]  __kasan_slab_alloc+0x59/0x70
[    6.863568]  kmem_cache_alloc_noprof+0x130/0x370
[    6.866803]  dst_alloc+0x75/0x150
[    6.869696]  ip6_dst_alloc+0x1e/0x90
[    6.871296]  ip6_rt_cache_alloc.isra.0+0x167/0x620
[    6.873879]  ip6_pol_route+0x89f/0xae0
[    6.875869]  fib6_rule_action+0x22c/0x900
[    6.878115]  fib_rules_lookup+0x3a2/0xab0
[    6.880533]  fib6_rule_lookup+0x16c/0x610
[    6.882609]  ip6_route_output_flags+0x21a/0x360
[    6.884676]  ip6_dst_lookup_tail+0x26f/0xdf0
[    6.886338]  ip6_dst_lookup_flow+0xf5/0x1e0
[    6.888399]  rawv6_sendmsg+0xa09/0x3630
[    6.889974]  __sock_sendmsg+0x135/0x180
[    6.892257]  __sys_sendto+0x1ed/0x2d0
[    6.894648]  __x64_sys_sendto+0xdc/0x1b0
[    6.896700]  do_syscall_64+0x104/0x5c0
[    6.898730]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    6.901488]=20
[    6.902490] Freed by task 86:
[    6.905179]  kasan_save_stack+0x24/0x50
[    6.908564]  kasan_save_track+0x14/0x30
[    6.910957]  kasan_save_free_info+0x3a/0x60
[    6.913588]  __kasan_slab_free+0x43/0x70
[    6.915634]  kmem_cache_free+0x1cf/0x3b0
[    6.917181]  dst_destroy+0x181/0x1f0
[    6.919826]  rcu_core+0x56f/0x1740
[    6.921735]  handle_softirqs+0x187/0x5b0
[    6.924720]  irq_exit_rcu+0x67/0x140
[    6.927768]  sysvec_apic_timer_interrupt+0x39/0x80
[    6.930184]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    6.933566]=20
[    6.934335] Last potentially related work creation:
[    6.937187]  kasan_save_stack+0x24/0x50
[    6.940412]  kasan_record_aux_stack+0x89/0xa0
[    6.941939]  __call_rcu_common.constprop.0+0x70/0x880
[    6.944256]  vrf_l3_out+0x625/0x7a0
[    6.945714]  rawv6_sendmsg+0x2680/0x3630
[    6.947458]  __sock_sendmsg+0x135/0x180
[    6.949629]  __sys_sendto+0x1ed/0x2d0
[    6.951775]  __x64_sys_sendto+0xdc/0x1b0
[    6.953956]  do_syscall_64+0x104/0x5c0
[    6.957564]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    6.960614]=20
[    6.961357] The buggy address belongs to the object at ffff88800972fa40
[    6.961357]  which belongs to the cache ip6_dst_cache of size 224
[    6.966491] The buggy address is located 208 bytes inside of
[    6.966491]  freed 224-byte region [ffff88800972fa40, ffff88800972fb20)
[    6.973695]=20
[    6.974831] The buggy address belongs to the physical page:
[    6.977004] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0=
 pfn:0x972e
[    6.981375] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 p=
incount:0
[    6.985797] flags: 0x100000000000040(head|node=3D0|zone=3D1)
[    6.987956] page_type: f5(slab)
[    6.989989] raw: 0100000000000040 ffff888004d8de00 dead000000000100 dead00=
0000000122
[    6.992064] raw: 0000000000000000 0000000000190019 00000000f5000000 000000=
0000000000
[    6.996358] head: 0100000000000040 ffff888004d8de00 dead000000000100 dead0=
00000000122
[    6.999999] head: 0000000000000000 0000000000190019 00000000f5000000 00000=
00000000000
[    7.004644] head: 0100000000000001 ffffffffffffff81 00000000ffffffff 00000=
000ffffffff
[    7.007746] head: 0000000000000000 0000000000000000 00000000ffffffff 00000=
00000000000
[    7.010232] page dumped because: kasan: bad access detected
[    7.012455]=20
[    7.013256] Memory state around the buggy address:
[    7.015472]  ffff88800972fa00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb f=
b fb
[    7.019411]  ffff88800972fa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb
[    7.023552] >ffff88800972fb00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc f=
c fc
[    7.026528]                          ^
[    7.028532]  ffff88800972fb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb
[    7.032466]  ffff88800972fc00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc f=
c fc
[    7.036695] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    7.060645] Disabling lock debugging due to kernel taint
Reproducer summary: sends=3D664388 errors=3D0 pulses=3D4245

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux 6.18.58 (commit 2926d88bb7fc4608fd942453d929c39e4e5ec006)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.346892] BUG: KASAN: slab-use-after-free in rawv6_sendmsg+0x3148/0x3640
[    3.348258] Read of size 8 at addr ffff888008d220d0 by task repro/84
[    3.349556]=20
[    3.350404] CPU: 0 UID: 0 PID: 84 Comm: repro Not tainted 6.18.58 #1 PREEM=
PT(full)=20
[    3.350413] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
13.0-1ubuntu1.1 04/01/2014
[    3.350424] Call Trace:
[    3.350446]  <TASK>
[    3.350448]  dump_stack_lvl+0x55/0x70
[    3.350482]  print_report+0xcf/0x610
[    3.350522]  ? rawv6_sendmsg+0x3148/0x3640
[    3.350524]  ? rawv6_sendmsg+0x3148/0x3640
[    3.350526]  kasan_report+0xb8/0xf0
[    3.350528]  ? rawv6_sendmsg+0x3148/0x3640
[    3.350530]  rawv6_sendmsg+0x3148/0x3640
[    3.350533]  ? finish_task_switch+0x139/0x710
[    3.350563]  ? __switch_to+0x5be/0xe50
[    3.350587]  ? switch_mm_irqs_off+0x43e/0x830
[    3.350607]  ? __pfx_rawv6_sendmsg+0x10/0x10
[    3.350609]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    3.350626]  ? n_tty_write+0x839/0x1020
[    3.350659]  ? sched_clock+0x10/0x30
[    3.350669]  ? __pfx_inet_sendmsg+0x10/0x10
[    3.350686]  ? __sock_sendmsg+0x135/0x180
[    3.350713]  __sock_sendmsg+0x135/0x180
[    3.350715]  __sys_sendto+0x201/0x2e0
[    3.350721]  ? __pfx___sys_sendto+0x10/0x10
[    3.350723]  ? fdget_pos+0x392/0x4c0
[    3.350737]  ? fput+0x25/0x70
[    3.350742]  ? ksys_write+0x189/0x1c0
[    3.350748]  ? __pfx_ksys_write+0x10/0x10
[    3.350750]  __x64_sys_sendto+0xdc/0x1b0
[    3.350752]  ? switch_fpu_return+0xdf/0x1e0
[    3.350755]  do_syscall_64+0xac/0x310
[    3.350761]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    3.350768] RIP: 0033:0x4071a4
[    3.350775] Code: f2 fc ff ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54=
 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d=
 00 f0 ff ff 77 30 89 ef 48 89 44 24 08 e8 18 fd ff ff 48 8b
[    3.350776] RSP: 002b:00007ffd69690bb0 EFLAGS: 00000293 ORIG_RAX: 00000000=
0000002c
[    3.350807] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000407=
1a4
[    3.350815] RDX: 0000000000000028 RSI: 00007ffd69690c50 RDI: 0000000000000=
003
[    3.350816] RBP: 0000000000000000 R08: 00007ffd69690c30 R09: 0000000000000=
01c
[    3.350817] R10: 0000000000000040 R11: 0000000000000293 R12: 00007ffd69690=
c30
[    3.350818] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffd69690=
c50
[    3.350824]  </TASK>
[    3.350825]=20
[    3.392704] Allocated by task 84:
[    3.393375]  kasan_save_stack+0x24/0x50
[    3.394086]  kasan_save_track+0x14/0x30
[    3.395143]  __kasan_slab_alloc+0x59/0x70
[    3.395850]  kmem_cache_alloc_noprof+0x114/0x4e0
[    3.396785]  dst_alloc+0x75/0x150
[    3.397805]  ip6_dst_alloc+0x1e/0x90
[    3.398760]  ip6_rt_cache_alloc.isra.0+0x167/0x620
[    3.399676]  ip6_pol_route+0x89f/0xae0
[    3.400454]  fib6_rule_action+0x22c/0x900
[    3.401268]  fib_rules_lookup+0x3a2/0xab0
[    3.401866]  fib6_rule_lookup+0x16c/0x610
[    3.402493]  ip6_route_output_flags+0x21a/0x360
[    3.403285]  ip6_dst_lookup_tail+0x26f/0xdf0
[    3.404019]  ip6_dst_lookup_flow+0x82/0x190
[    3.404678]  rawv6_sendmsg+0xab1/0x3640
[    3.405768]  __sock_sendmsg+0x135/0x180
[    3.408038]  __sys_sendto+0x201/0x2e0
[    3.408739]  __x64_sys_sendto+0xdc/0x1b0
[    3.409399]  do_syscall_64+0xac/0x310
[    3.410049]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    3.410973]=20
[    3.411360] Freed by task 85:
[    3.412056]  kasan_save_stack+0x24/0x50
[    3.412857]  kasan_save_track+0x14/0x30
[    3.413500]  __kasan_save_free_info+0x3a/0x60
[    3.414532]  __kasan_slab_free+0x43/0x70
[    3.415230]  kmem_cache_free+0x2ba/0x560
[    3.416195]  dst_destroy+0x181/0x1f0
[    3.417005]  rcu_core+0x642/0x19e0
[    3.417610]  handle_softirqs+0x16a/0x550
[    3.418393]  irq_exit_rcu+0xaf/0xe0
[    3.418943]  sysvec_apic_timer_interrupt+0x39/0x80
[    3.420078]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    3.420966]=20
[    3.421367] Last potentially related work creation:
[    3.422342]  kasan_save_stack+0x24/0x50
[    3.424121]  kasan_record_aux_stack+0x89/0xa0
[    3.424963]  __call_rcu_common.constprop.0+0x70/0x800
[    3.426010]  vrf_l3_out+0x619/0x800
[    3.426701]  rawv6_sendmsg+0x25d2/0x3640
[    3.427741]  __sock_sendmsg+0x135/0x180
[    3.428425]  __sys_sendto+0x201/0x2e0
[    3.428996]  __x64_sys_sendto+0xdc/0x1b0
[    3.429661]  do_syscall_64+0xac/0x310
[    3.430257]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    3.431259]=20
[    3.431519] The buggy address belongs to the object at ffff888008d22000
[    3.431519]  which belongs to the cache ip6_dst_cache of size 224
[    3.433503] The buggy address is located 208 bytes inside of
[    3.433503]  freed 224-byte region [ffff888008d22000, ffff888008d220e0)
[    3.435379]=20
[    3.435690] The buggy address belongs to the physical page:
[    3.436706] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0=
 pfn:0x8d22
[    3.437835] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 p=
incount:0
[    3.440582] flags: 0x100000000000040(head|node=3D0|zone=3D1)
[    3.441332] page_type: f5(slab)
[    3.441936] raw: 0100000000000040 ffff888005d90f00 dead000000000122 000000=
0000000000
[    3.443581] raw: 0000000000000000 0000000080190019 00000000f5000000 000000=
0000000000
[    3.445077] head: 0100000000000040 ffff888005d90f00 dead000000000122 00000=
00000000000
[    3.446780] head: 0000000000000000 0000000080190019 00000000f5000000 00000=
00000000000
[    3.448036] head: 0100000000000001 ffffea0000234881 00000000ffffffff 00000=
000ffffffff
[    3.449428] head: 0000000000000000 0000000000000000 00000000ffffffff 00000=
00000000000
[    3.451070] page dumped because: kasan: bad access detected
[    3.452250]=20
[    3.452846] Memory state around the buggy address:
[    3.453879]  ffff888008d21f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc
[    3.456019]  ffff888008d22000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b fb
[    3.457694] >ffff888008d22080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc f=
c fc
[    3.459558]                                                  ^
[    3.460775]  ffff888008d22100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc
[    3.462146]  ffff888008d22180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc
[    3.463323] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.545228] Disabling lock debugging due to kernel taint
Reproducer summary: sends=3D995434 errors=3D0 pulses=3D4207

The reports show the same object lifetime on all three kernels. The route obj=
ect
is allocated through the IPv6 route-cache lookup path, freed through
dst_destroy() in an RCU callback, and the related RCU work is created from
vrf_l3_out() before rawv6_sendmsg() performs the stale read. This is consiste=
nt
with the source-level issue described in the original patch: the VRF redirect
replaces and releases skb->dst while rawv6_send_hdrinc() retains and later
dereferences the original rt pointer.

These results confirm a real kernel use-after-free on all three tested versio=
ns.
They do not, by themselves, demonstrate an unprivileged trigger, privilege
escalation, or an arbitrary read/write primitive. The current reproducer uses
CAP_NET_ADMIN to configure the VRF and qdisc, CAP_NET_RAW to open the raw
socket, and CAP_SYS_NICE only for the scheduling amplifier used to make the
race reliable.

If I have misunderstood any part of the affected path or proposed fix, I would
be grateful for any corrections. Please also let me know if the kernel
configurations, standalone reproducer, or any additional validation would be
useful; I would be happy to provide them.

Thank you very much for your time and consideration.

Best regards,
Zhou Qiuyue
