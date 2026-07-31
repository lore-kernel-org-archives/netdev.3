Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1C2BE621;
	Fri, 31 Jul 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524942; cv=none; b=EsRIH4XKrmOoFKR7XyT8HHjlWuKE9Pm4AwSpidOoCz3Vfdx7ZR0Vsa465MVUJCJdrmuObW04V+eIye85x1eRujwO8IAkEQrbqjDU6CTRgeonMLRZPwGVswSQimO3OJSVArDdiwKSnmqXHg0VnFt0nR22yaXo8Nag7myF4o/QRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524942; c=relaxed/simple;
	bh=rTg6GaAhjekN7k5mja18HB808thxPrL/m9yl7VnyaQk=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HfkqkyWn7Rg5UVfQYY1pAYjgq0MzxPr6weUjtwG4XTvowLit8NaR4iRQysCsRO32HDwRPXiBDZ5TyAjKEjb1rw90N7umLaG4A6MiToDOInIhaS2y6M/VWK42j1WQcO6ojusEMyLvVvhJYVETaH3RrvVtumqNyq/upJDcf1uZ8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=xfxcDOIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNEl45UK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="xfxcDOIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNEl45UK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 391CA14000F0;
	Fri, 31 Jul 2026 15:08:59 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Fri, 31 Jul 2026 15:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785524939;
	 x=1785611339; bh=Rl6Oy9MlEoseWbt0qpe1VZdG6fw4dgvs1zp/Au0L7pA=; b=
	xfxcDOIwqA5V6IXxG33dNJcQtLv37zwSV1JTgfjk+RwSF0abtv0Yv3EdK0YSBwBP
	T5Rh3Wpa4ZMtKAYIF5SvAJ99bswF+FsKoY+IllMPDuTZv3HdvTeGndNnXzd2SZ+z
	6jAsZBLwrx3lBnO+caJGcWL4ApvcE4cGoqxpbQ0PaIrXQ0cL43xKlg/pupnC00I2
	AElh9m1DHc9IgV9+cUWkPjjLKs0HFb6zKIX8aokzTetcIWa1uJl3dTw7tYJJRgqA
	eNG95H0CgaQvkYU3ZXwG7W796ZYapEv5jR+iuWq9T4HOBQWjR+QN50ziCcruenLf
	m62dxOg8etRvJUAFB7lfxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785524939; x=1785611339; bh=R
	l6Oy9MlEoseWbt0qpe1VZdG6fw4dgvs1zp/Au0L7pA=; b=rNEl45UK2lDQUNBBv
	EjfRlCgexU1uOB9GryRfw3s0gcd2Yvqk0DHGb9qNykl0BxZw6vYRl7fOkfmeaepF
	jbVtEq96lEZDJkXig25eZavSE2vDX3+XXekhQUeqYglHPGOrDBPFq2pXGz4t5o5c
	VjeAPzXME4oJEjjY+e20W/s7LDa19Zu+SSR0rNrAc/hAI30O6Qv1HMf8EZpd+9RL
	qX4SgxY3JBV6sMYHvRro5ulv9Vha/2Namzu/1AolGb11kp9ZRWspn6+Tdsi4ljp6
	Iyg0pTrl3VVQEapV5PffY8ISjFDT1+5OFidpZj25HX3wkFO1fBAOLzytDE3UKj8k
	8uBhQ==
X-ME-Sender: <xms:yvJsahMTn0XTOUO6jp45XYcAxujN-JBb-2kKoA2zosPfG9GmDypIZw>
    <xme:yvJsauwE8XqodE9gCKTs8ehNl-JO3CbxkKd7eOcBJrdYLd2UuUJB-CXknvv7_W7W9
    NqekjYK-nvcAanryGTqe6vZem9idzprWCwUgLjtfFDRKQ8sdVtfKuc>
X-ME-Proxy-Cause: dmFkZTFu/gP3rxRHc79k/LdSOM4JSiKq521ODbDjiXyKWouCQI9WC1OQeNZZD9bX32Rze3
    6hN3C4vUDWBm5wMs1MDlTx+FzjWYq1KK8vvBcuSqQo+uttiK0ZHL/w+vozhepxuORBxTQp
    Tr5XjJG3sbMPWY8zQXT0W56Z/g0huidWQG4LjCYce7JeOlgNqnQMc35nWy5bnCBMThySGp
    9v5w953sYcRWQPQfR8/BnL50t8JAM7M3NXePTQtikF59Fc+0jB6+Ko4xwug20BPfZZklK6
    Xsarje7E/rMn/rZCWxQUWGFilXhmIdcyf95BUoPmJL2/GVx+tmS2FKG+kNrzoZ+q2VNnWN
    0X1phmWZxKFlLpA0y3n4vh9tsNWn53H3j5VlK+aTmOESjgCw0M8ISR5DQRclbIZ8q2+2U3
    S7PdE+wayiTh6b7h4KC9REy+gpratf3xPtdDOj1Ie1ZjkHNCkLFTfDlklkCtcMomX+9SM/
    w5nny+kwFFfBCItXSRr2F50c/09MZsFqvw7N+ITz15Z3XT/ujeEKR51bNCYaKUbGXpo+wK
    fujrJgz9L8OQhSHDcbMzrv2VU90M2MwlMKWtYq2n0eLPPKllKMojnXLKBb+Q+8uxts6lzU
    d+Z1UYVxfevw/Vwb2zY3HaSPnKtPVT+JjMW0vH//ZTSyaBQDeWq8+Nc/7e7g
X-ME-Proxy: <xmx:yvJsanyMmzVXg3kg_KC1_kp0a0A8Dpp-0dxpuJ_VqisDYxf_f-K0Lg>
    <xmx:yvJsandJNGC_PdcADuDFeG67apNgssgL-uSF5lwTAP3WgvL7afBDiQ>
    <xmx:yvJsas7zcmV_NEKW-alAP84VWdCdlxpEIu97itvw459pkWyEyYi1FQ>
    <xmx:yvJsasJoXUFQimvtoRRh2xskpb8YK29cuviqC5jr8s6SAGoqqyK8ww>
    <xmx:y_JsauxwwvXcZ8LTUBt_76GoG2_ddE8ZRnkx8B59duAmRkxFR3Clv1VL>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EEFB18E006C; Fri, 31 Jul 2026 15:08:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3p-4s_5lx0N
Date: Fri, 31 Jul 2026 22:08:38 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 syzbot <syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Paolo Abeni" <pabeni@redhat.com>,
 syzkaller-bugs@googlegroups.com
Message-Id: <2e9985d0-74a1-423d-8b95-c0dff0413668@app.fastmail.com>
In-Reply-To: <willemdebruijn.kernel.35c8c21f85396@gmail.com>
References: <6a6a966c.86abc875.e5c3d.0054.GAE@google.com>
 <willemdebruijn.kernel.1cc6c160b4b5d@gmail.com>
 <willemdebruijn.kernel.35c8c21f85396@gmail.com>
Subject: Re: [syzbot] [net?] WARNING in udp_v6_send_skb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 30, 2026, at 17:10, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> syzbot wrote:
>> > Hello,
>> > 
>> > syzbot found the following issue on:
>> > 
>> > HEAD commit:    04026c998c24 net/rds: use krealloc_array() for iovector gr..
>> > git tree:       net-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=163a6499580000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f592a4e0cc86da
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=ce13c07d96d04716eaa2
>> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
>> > 
>> > Unfortunately, I don't have any reproducer for this issue yet.
>> > 
>> > Downloadable assets:
>> > disk image: https://storage.googleapis.com/syzbot-assets/4f82b6352d02/disk-04026c99.raw.xz
>> > vmlinux: https://storage.googleapis.com/syzbot-assets/9b29e52c71b2/vmlinux-04026c99.xz
>> > kernel image: https://storage.googleapis.com/syzbot-assets/0b1e84e828d6/bzImage-04026c99.xz
>> > 
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
>> > 
>> > ------------[ cut here ]------------
>> > len >= 65536u
>> > WARNING: ./include/linux/udp.h:49 at udp_set_len_short include/linux/udp.h:49 [inline], CPU#0: syz.4.4430/24120
>> > WARNING: ./include/linux/udp.h:49 at udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375, CPU#0: syz.4.4430/24120
>> > Modules linked in:
>> > CPU: 0 UID: 0 PID: 24120 Comm: syz.4.4430 Not tainted syzkaller #0 PREEMPT(full) 
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
>> > RIP: 0010:udp_set_len_short include/linux/udp.h:49 [inline]
>> > RIP: 0010:udp_v6_send_skb+0xd3b/0x13a0 net/ipv6/udp.c:1375
>> > Code: 42 0f b6 04 38 84 c0 0f 85 37 06 00 00 41 0f b7 1e e9 60 f3 ff ff e8 04 c3 43 f7 90 0f 0b 90 e9 02 f4 ff ff e8 f6 c2 43 f7 90 <0f> 0b 90 e9 e9 f4 ff ff e8 e8 c2 43 f7 90 0f 0b 90 e9 94 f5 ff ff
>> > RSP: 0018:ffffc9000e0a74c8 EFLAGS: 00010287
>> > RAX: ffffffff8a833e8a RBX: ffff8880355e4a00 RCX: 0000000000080000
>> > RDX: ffffc900100ca000 RSI: 00000000000049e3 RDI: 00000000000049e4
>> > RBP: 000000000000244c R08: ffff888049ed5d00 R09: 0000000000000003
>> > R10: 000000000000000b R11: 0000000000000002 R12: dffffc0000000000
>> > R13: ffff888027cb0c80 R14: 0000000000010000 R15: ffff8880355e4a02
>> > FS:  00007f2d4a07b6c0(0000) GS:ffff888124f54000(0000) knlGS:0000000000000000
>> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > CR2: 0000200000010000 CR3: 0000000029d28000 CR4: 00000000003526f0
>> > Call Trace:
>> >  <TASK>
>> >  udp_v6_push_pending_frames+0xa2/0x140 net/ipv6/udp.c:1451
>> >  udpv6_sendmsg+0xfa0/0x2610 net/ipv6/udp.c:1740
>> >  sock_sendmsg_nosec+0x90/0x180 net/socket.c:775
>> >  __sock_sendmsg net/socket.c:790 [inline]
>> >  ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
>> >  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
>> >  __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
>> >  __do_sys_sendmmsg net/socket.c:2854 [inline]
>> >  __se_sys_sendmmsg net/socket.c:2851 [inline]
>> >  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
>> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>> >  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> > RIP: 0033:0x7f2d4919de99
>> 
>> Interesting trigger of the recently added DEBUG_NET_WARN_ON_ONCE in
>> udp_set_len_short called in udp_v6_send_skb.
>> 
>> No reproducer yet, so probably not very actionable at this point.

I got an [AI-generated] reproducer, please expect a fix early next week.

>> A mostly straightforward looking ipv6 udp sendmsg path.
>
> Actually, this may just be a valid UDP_SEGMENT skb with max payload:
>
>     IP6_MAX_MTU (0xFFFF + sizeof(struct ipv6hdr))
>
> This is what __ip6_append_data checks on egress
>
>     mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
>
> Not sure whether UDP_SEGMENT can legitimately build even larger
> BIG-TCP variants of UDP_SEGMENT skbs at this point too today.

My reproducer sends a regular UDP datagram, no UDP_SEGMENT:

1. Set device MTU > IP6_MAX_MTU. cork->base.fragsize will be set to MTU
   in ip6_setup_cork.
2. setsockopt IPV6_MTU_DISCOVER to IPV6_PMTUDISC_DO. It lets
   maxnonfragsize be set to device MTU (cork->fragsize) in
   __ip6_append_data, rather than to IP6_MAX_MTU=65575.
3. Send 65528 bytes of payload + 8 bytes of UDP header + 40 bytes of
   IPv6 header. Device MTU allows it (one byte bigger than IP6_MAX_MTU),
   and UDP length is 65536, triggering the WARN.

It shouldn't be possible with UDP_SEGMENT, because mtu (and then
maxnonfragsize) is set to IP6_MAX_MTU in __ip6_append_data if
cork->gso_size is set.
