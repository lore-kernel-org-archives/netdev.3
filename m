Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80957489870
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411647; cv=none; b=gberag50if42yVw+y4Gwxd/Q4VgOf/kEid2JoYajyhe3xqIQCIWNN213prr7WkjasGBqEOtIlch+2614IAYpJCTfluvrCDBWkRftr87NGi9hSgNiR6HMsWLScj1C8t8qbB7L+MRrqjFwPTL/lkw1kb1KWVFCi/uZvDawWd0bnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411647; c=relaxed/simple;
	bh=5EeGMrAsCpw9KLiFBdAH7cfrZSInvMZCL+zG2v3Hoq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAJ0BK+XmY1/w0SKdMZRMrmXbpRqp4xDE88gC8YXDdmmF/gzNMRyRk08982xNAqE1vGON8qlv+4cthauv2ZIy/DOF0l5r/Itm3+Tqa6St4TqDdHEvf1bNsJFfhjL++Jy/oMxQC7cZ4C5R/6CoHFHefXDbv9Jee9aiGX1VrMLWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=EoClMdU8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blZYukza; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="EoClMdU8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blZYukza"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 980F7EC03D9;
	Thu, 30 Jul 2026 07:40:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1785411643; x=1785498043; bh=9N/AMR16sM0XVvoNp7G+e
	al43KUlJyKWhtZk7LOV0ok=; b=EoClMdU8bO0lDUPlxTIwVdp+o032Ea6BYNi3+
	yGi15KJpg7kWLkrgf175hT1pkRcO5/kwieBV+3OPa0L7bUCgs8Xm1JBRZf3W8NAz
	3J647oUy2DRfNhsuDXEaMFwk4cqJpS6V0U8Wp1AB6ascST/AB0SgqQmWCzYTJnTy
	OgU3Ca8wdFYOUg7e12Ftd1VlfV2K1oqlj1axSIaI5xbhHsiHpr5WjXKpWM+rZpKQ
	IboZPzKmBIn6mvyhsuSGuBPKO0/A0RMkESWIOXneDcajbQUzweigbIxaW2pqGsz9
	Y0geZuP4bzT8/sUIKsY8Ok8i6KxZCatWh19ZMw2ItMOwaUt9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785411643; x=1785498043; bh=9N/AMR16sM0XVvoNp7G+eal43KUlJyKWhtZ
	k7LOV0ok=; b=blZYukzaHjfLyPoB1ysD/j0kJ81+YAvwFLhvajSDek3h5qcdltn
	68AU9kW+0GDJ9OTQD6YqcGtPmQmbO5+gC0M6sGsRROo+x3q8WsGe8ad49zl2hNKL
	XxjOqltuG1JWVlspfuagAChdNse4P8y4b4RB9TIkSeJ1i60kvyAN6L1uaQ+PBjzs
	aGDiCGRqMI4DOHB2gyz6dIdPxBlR0pdOQDqGx2Rg5rQTWkoYqLXej3zE1BiJ7oPr
	4PXYS570FlFm8qwiwW2eNK+6PhwT970Rdcsl5ED7ASzjlFmqIE1eofixE/yifyz9
	+ZYLCdrvMrZfVjY72ZviLsLrQOLBbDcu/NA==
X-ME-Sender: <xms:Ojhraga7Mogh0jP55T_-d3zkn9hslgTDt4HZU6ss7KkW-x8xW2sD3Q>
    <xme:Ojhrar27ykDAJCKMLG-Hh3tKMfJ0U90pDBYsggylBAEbzur2m5ag6YiCBGdNUgv2U
    YE47Og12UHY1vlcdfSkon6ftENHlgtT2NoEfxLShi5IhtMf5lP2FsY>
X-ME-Received: <xmr:Ojhrarq5QHxcfz3CdpNdMbf0hRfe1YJUe8ZPtkohoVeObV05MGdUkGWd_0dh2lz0ufK-lWQtew>
X-ME-Proxy-Cause: dmFkZTGoMU5TTcOZXYk+ttQQqvoCX/AMOmbfebdDfqYfcx2uC1aTYAJUVNAWHhs4hWuXFr
    jD78QYQD2jFXcnIMAHdmjB6B2MDG/WpkUQknbjZY13K8lCzx7Udbdjrig8xXCW5Mp7DVC8
    UKdEzdp8xanfjzb9zLSz5NKWdRQ+9aJadRCPjVHSfWb1qTD9kzx4JC02bK429m+ATZDrV2
    g5SvuX8+7S5XHmAzB2rTUZo0lPRfIWl43rDijRLcjzVoq4mMzL1DeHf9hmq7LjmokwSzjY
    zxxhqajV32z4DSMsEBxav15mQ2v+Z+uh7XOgSG14bhg3UMt249PiHXs4nz65ST3uNWictJ
    wKy6WFb6/gn9MWltFz+l4n/nxEO4FQISp7cUjX5o8qHQJMZiUBJVbm3pCCBTvyciNbGr8n
    p93G7jIt2wNmklqAGBZXJF9upgg9pc/qbcVkNQj1WOjkVE47TpZ/YZ3iHnsfGuFHlEwBhz
    OPTOXAqnRdJhzPzARXx3xzqKzm0ZYatRjylSjKH1AxUsMCd1Lid9fOu2MTh+fw5I8qGVxD
    jch0Jl9aRz4g8NPv6PiaGYk3vNj84wUR3XXnC75+ax+ZdEw5d5JM8d0HmNrSOsM6YxpgJN
    gJ8z11MloWH0j9K48HKuZ3mVgcP5bRMkTtTzFhhGSoVERdqkoT2SGpi6W8mg
X-ME-Proxy: <xmx:OjhraiMXsAkym2jc_Dn3Wxiom_SC4c3672O39kPPO3yaw2Qj-Pqipw>
    <xmx:OjhrasqErXYr2Zr1QYf9NYE6pSsHbGMyb1tWsSYi5JFQMnp1TVCwTg>
    <xmx:OjhralsH3DMStLsm5bzWcmhvPVewIaAHLyZJm_K6knbfc2GmgMl-AQ>
    <xmx:Ojhrar27TNFmHfWaTcsrZTHXy2h6kJkymdV6NF9y-pTklpXKLCi_8Q>
    <xmx:Ozhrah7XmL8pO5yvsLTnc1ChgEKXw5byEcBfrzGBHc3aQdSfCZ1PYBSF>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 07:40:39 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Siwei Zhang <fourdizhang@tencent.com>
Subject: [PATCH net v2 0/1] xfrm: use hlist_del_init_rcu for state_cache and state_cache_input
Date: Thu, 30 Jul 2026 19:40:07 +0800
Message-ID: <20260730114028.1077499-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <fourdizhang@tencent.com>

 Following use after free read and write has been found and the latest kernel does not have the fixes:

 [  836.156394][    C0] ==================================================================
 [  836.156968][    C0] BUG: KASAN: slab-use-after-free in xfrm_input_state_lookup+0xa40/0xbb0
 [  836.157498][    C0] Read of size 2 at addr ff1100013a523442 by task probef-fuzzer-1/15903
 [  836.158005][    C0] 
 [  836.158158][    C0] CPU: 0 UID: 0 PID: 15903 Comm: probef-fuzzer-1 Not tainted 6.19.14 #3 PREEMPT(voluntary) 
 [  836.158171][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-4.tl4 04/01/2014
 [  836.158177][    C0] Call Trace:
 [  836.158182][    C0]  <IRQ>
 [  836.158186][    C0]  dump_stack_lvl+0xca/0x120
 [  836.158203][    C0]  print_address_description.constprop.0+0x2c/0x350
 [  836.158223][    C0]  ? xfrm_input_state_lookup+0xa40/0xbb0
 [  836.158240][    C0]  print_report+0xb9/0x2b0
 [  836.158254][    C0]  ? __virt_addr_valid+0x208/0x410
 [  836.158273][    C0]  ? kasan_addr_to_slab+0xd/0x70
 [  836.158287][    C0]  kasan_report+0xe0/0x110
 [  836.158303][    C0]  ? xfrm_input_state_lookup+0xa40/0xbb0
 [  836.158323][    C0]  xfrm_input_state_lookup+0xa40/0xbb0
 [  836.158341][    C0]  ? trace_kmem_cache_alloc+0x28/0xb0
 [  836.158358][    C0]  ? __pfx_xfrm_input_state_lookup+0x10/0x10
 [  836.158378][    C0]  ? xfrm_parse_spi+0x57/0x510
 [  836.158391][    C0]  xfrm_input+0x934/0x36d0
 [  836.158405][    C0]  ? __pfx_xfrm_input+0x10/0x10
 [  836.158417][    C0]  ? __pfx_raw_v4_input+0x10/0x10
 [  836.158434][    C0]  ? lock_is_held_type+0x9e/0x110
 [  836.158449][    C0]  xfrm4_esp_rcv+0xa2/0x2a0
 [  836.158460][    C0]  ? __pfx_xfrm4_esp_rcv+0x10/0x10
 [  836.158471][    C0]  ip_protocol_deliver_rcu+0x443/0x4c0
 [  836.158485][    C0]  ip_local_deliver_finish+0x3bb/0x6c0
 [  836.158498][    C0]  ip_local_deliver+0x1b5/0x5b0
 [  836.158509][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
 [  836.158521][    C0]  ? lock_is_held_type+0x9e/0x110
 [  836.158542][    C0]  ? ip_rcv_finish_core+0x5cb/0x14d0
 [  836.158554][    C0]  ? __pfx_ip_local_deliver+0x10/0x10
 [  836.158566][    C0]  ip_rcv+0x6e4/0x7a0
 [  836.158577][    C0]  ? __pfx_ip_rcv+0x10/0x10
 [  836.158588][    C0]  ? __lock_acquire+0x679/0xd50
 [  836.158602][    C0]  ? __pfx_ip_rcv+0x10/0x10
 [  836.158613][    C0]  __netif_receive_skb_one_core+0x197/0x1e0
 [  836.158632][    C0]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
 [  836.158650][    C0]  ? lock_acquire+0x164/0x2f0
 [  836.158661][    C0]  ? process_backlog+0x3f5/0x14a0
 [  836.158670][    C0]  ? __lock_release.isra.0+0x65/0x170
 [  836.158681][    C0]  ? process_backlog+0x3f5/0x14a0
 [  836.158690][    C0]  __netif_receive_skb+0x1d/0x160
 [  836.158706][    C0]  process_backlog+0x447/0x14a0
 [  836.158718][    C0]  __napi_poll.constprop.0+0xb3/0x580
 [  836.158730][    C0]  net_rx_action+0x517/0xf20
 [  836.158740][    C0]  ? __lock_release.isra.0+0x65/0x170
 [  836.158752][    C0]  ? __pfx_net_rx_action+0x10/0x10
 [  836.158763][    C0]  ? __lock_acquire+0x679/0xd50
 [  836.158779][    C0]  ? mark_held_locks+0x49/0x80
 [  836.158790][    C0]  handle_softirqs+0x1fc/0x830
 [  836.158807][    C0]  ? __pfx_handle_softirqs+0x10/0x10
 [  836.158823][    C0]  ? __dev_queue_xmit+0x8ef/0x1f00
 [  836.158839][    C0]  do_softirq+0x42/0xa0
 [  836.158853][    C0]  </IRQ>
 [  836.158856][    C0]  <TASK>
 [  836.158859][    C0]  __local_bh_enable_ip+0xf1/0x110
 [  836.158873][    C0]  ? __dev_queue_xmit+0x8ef/0x1f00
 [  836.158888][    C0]  __dev_queue_xmit+0x904/0x1f00
 [  836.158905][    C0]  ? csum_and_copy_from_iter_full+0x3eb/0x1bc0
 [  836.158923][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
 [  836.158939][    C0]  ? __lock_acquire+0x679/0xd50
 [  836.158949][    C0]  ? __pfx_csum_and_copy_from_iter_full+0x10/0x10
 [  836.158963][    C0]  ? __kasan_slab_alloc+0x89/0x90
 [  836.158978][    C0]  ? find_held_lock+0x2b/0x80
 [  836.158994][    C0]  ? mark_held_locks+0x49/0x80
 [  836.159005][    C0]  neigh_hh_output+0x291/0x440
 [  836.159021][    C0]  ip_finish_output2+0x90a/0x19e0
 [  836.159036][    C0]  ? lock_release+0x79/0x140
 [  836.159045][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
 [  836.159060][    C0]  ? __pfx_ip_dst_mtu_maybe_forward+0x10/0x10
 [  836.159078][    C0]  __ip_finish_output+0x64f/0x9a0
 [  836.159093][    C0]  ip_finish_output+0x35/0x380
 [  836.159109][    C0]  ip_output+0x228/0x940
 [  836.159123][    C0]  ? __pfx_ip_output+0x10/0x10
 [  836.159137][    C0]  ? __ip_make_skb+0x1106/0x1db0
 [  836.159154][    C0]  ? ip_append_data+0x12c/0x1b0
 [  836.159169][    C0]  ? __pfx_ip_output+0x10/0x10
 [  836.159184][    C0]  ip_push_pending_frames+0x2a0/0x310
 [  836.159200][    C0]  raw_sendmsg+0x984/0x1f10
 [  836.159217][    C0]  ? __pfx_raw_sendmsg+0x10/0x10
 [  836.159231][    C0]  ? try_to_wake_up+0x7a8/0xf00
 [  836.159241][    C0]  ? __lock_release.isra.0+0x65/0x170
 [  836.159258][    C0]  ? lock_acquire+0x164/0x2f0
 [  836.159268][    C0]  ? find_held_lock+0x2b/0x80
 [  836.159283][    C0]  ? lock_release+0x79/0x140
 [  836.159292][    C0]  ? __might_fault+0xc8/0x180
 [  836.159309][    C0]  ? __might_fault+0x139/0x180
 [  836.159324][    C0]  ? __pfx_raw_sendmsg+0x10/0x10
 [  836.159338][    C0]  inet_sendmsg+0x11c/0x140
 [  836.159355][    C0]  __sys_sendto+0x41b/0x4b0
 [  836.159369][    C0]  ? __pfx_inet_sendmsg+0x10/0x10
 [  836.159385][    C0]  ? __pfx___sys_sendto+0x10/0x10
 [  836.159399][    C0]  ? sigprocmask+0x22e/0x330
 [  836.159410][    C0]  ? __lock_release.isra.0+0x65/0x170
 [  836.159423][    C0]  ? sigprocmask+0xef/0x330
 [  836.159434][    C0]  ? __pfx_sigprocmask+0x10/0x10
 [  836.159449][    C0]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
 [  836.159462][    C0]  ? lock_release+0x79/0x140
 [  836.159473][    C0]  __x64_sys_sendto+0xe0/0x1c0
 [  836.159488][    C0]  ? trace_irq_enable.constprop.0+0xd4/0x110
 [  836.159501][    C0]  do_syscall_64+0xc1/0x3a0
 [  836.159516][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 [  836.159527][    C0] RIP: 0033:0x8116ec
 [  836.159540][    C0] Code: 3a 6c fd ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 80 6c fd ff 48 8b
 [  836.159550][    C0] RSP: 002b:00007f3dbbcfc780 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
 [  836.159561][    C0] RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00000000008116ec
 [  836.159568][    C0] RDX: 000000000000002c RSI: 00007f3dbbcfc870 RDI: 00000000000001fd
 [  836.159574][    C0] RBP: 0000000000000000 R08: 00007f3dbbcfc830 R09: 0000000000000010
 [  836.159580][    C0] R10: 0000000000000040 R11: 0000000000000293 R12: 00000000000001fd
 [  836.159587][    C0] R13: 000000000000002c R14: 0000000000000040 R15: 00007f3dbbcfc830
 [  836.159599][    C0]  </TASK>
 [  836.159602][    C0] 
 [  836.193879][    C0] Allocated by task 17462 on cpu 1 at 836.153818s:
 [  836.194266][    C0]  kasan_save_stack+0x33/0x60
 [  836.194562][    C0]  kasan_save_track+0x17/0x60
 [  836.194852][    C0]  __kasan_slab_alloc+0x89/0x90
 [  836.195152][    C0]  kmem_cache_alloc_noprof+0x22a/0x6c0
 [  836.195482][    C0]  xfrm_state_alloc+0x23/0x5c0
 [  836.195784][    C0]  xfrm_state_construct+0x31/0x2240
 [  836.196100][    C0]  xfrm_add_sa+0x183/0x530
 [  836.196373][    C0]  xfrm_user_rcv_msg+0x41c/0xa30
 [  836.196686][    C0]  netlink_rcv_skb+0x152/0x3f0
 [  836.196984][    C0]  xfrm_netlink_rcv+0x71/0x90
 [  836.197275][    C0]  netlink_unicast+0x5aa/0x870
 [  836.197578][    C0]  netlink_sendmsg+0x8f7/0xdd0
 [  836.197875][    C0]  ____sys_sendmsg+0x901/0xa50
 [  836.198168][    C0]  ___sys_sendmsg+0x134/0x1d0
 [  836.198461][    C0]  __sys_sendmsg+0x16d/0x220
 [  836.198747][    C0]  do_syscall_64+0xc1/0x3a0
 [  836.199029][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 [  836.199384][    C0] 
 [  836.199536][    C0] Freed by task 84 on cpu 1 at 836.156326s:
 [  836.199891][    C0]  kasan_save_stack+0x33/0x60
 [  836.200180][    C0]  kasan_save_track+0x17/0x60
 [  836.200470][    C0]  kasan_save_free_info+0x3b/0x60
 [  836.200781][    C0]  __kasan_slab_free+0x5f/0x80
 [  836.201076][    C0]  kmem_cache_free+0x2e2/0x6a0
 [  836.201370][    C0]  xfrm_state_gc_task+0x58d/0x820
 [  836.201688][    C0]  process_one_work+0x91e/0x1ad0
 [  836.201992][    C0]  worker_thread+0x690/0xed0
 [  836.202274][    C0]  kthread+0x388/0x730
 [  836.202527][    C0]  ret_from_fork+0x556/0x690
 [  836.202821][    C0]  ret_from_fork_asm+0x1a/0x30
 [  836.203116][    C0] 
 [  836.203263][    C0] The buggy address belongs to the object at ff1100013a523300
 [  836.203263][    C0]  which belongs to the cache xfrm_state of size 920
 [  836.204075][    C0] The buggy address is located 322 bytes inside of
 [  836.204075][    C0]  freed 920-byte region [ff1100013a523300, ff1100013a523698)
 [  836.204879][    C0] 
 [  836.205027][    C0] The buggy address belongs to the physical page:
 [  836.205406][    C0] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13a520
 [  836.205933][    C0] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 [  836.206430][    C0] ksm flags: 0x17ffe0000000040(head|node=0|zone=2|lastcpupid=0x3fff)
 [  836.206913][    C0] page_type: f5(slab)
 [  836.207161][    C0] raw: 017ffe0000000040 ff11000101cc0a00 ffd40000047dda00 0000000000000003
 [  836.207672][    C0] raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
 [  836.208178][    C0] head: 017ffe0000000040 ff11000101cc0a00 ffd40000047dda00 0000000000000003
 [  836.208694][    C0] head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
 [  836.209205][    C0] head: 017ffe0000000002 ffd4000004e94801 00000000ffffffff 00000000ffffffff
 [  836.209720][    C0] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
 [  836.210226][    C0] page dumped because: kasan: bad access detected
 [  836.210609][    C0] 
 [  836.210756][    C0] Memory state around the buggy address:
 [  836.211090][    C0]  ff1100013a523300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [  836.211569][    C0]  ff1100013a523380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [  836.212042][    C0] >ff1100013a523400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [  836.212513][    C0]                                            ^
 [  836.212884][    C0]  ff1100013a523480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [  836.213355][    C0]  ff1100013a523500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [  836.213831][    C0] ==================================================================
 [  836.215344][    C0] Disabling lock debugging due to kernel taint

 [   59.646908][ T1914] ==================================================================
 [   59.647395][ T1914] BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0xa12/0xa30
 [   59.647893][ T1914] Write of size 8 at addr ff1100011f4d4d20 by task probef-fuzzer-4/1914
 [   59.648378][ T1914] 
 [   59.648542][ T1914] CPU: 1 UID: 0 PID: 1914 Comm: probef-fuzzer-4 Not tainted 6.19.14 #3 PREEMPT(voluntary) 
 [   59.648555][ T1914] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-4.tl4 04/01/2014
 [   59.648561][ T1914] Call Trace:
 [   59.648565][ T1914]  <TASK>
 [   59.648568][ T1914]  dump_stack_lvl+0xca/0x120
 [   59.648584][ T1914]  print_address_description.constprop.0+0x2c/0x350
 [   59.648603][ T1914]  ? __xfrm_state_delete+0xa12/0xa30
 [   59.648619][ T1914]  print_report+0xb9/0x2b0
 [   59.648634][ T1914]  ? __virt_addr_valid+0x208/0x410
 [   59.648651][ T1914]  ? kasan_addr_to_slab+0xd/0x70
 [   59.648666][ T1914]  kasan_report+0xe0/0x110
 [   59.648682][ T1914]  ? __xfrm_state_delete+0xa12/0xa30
 [   59.648702][ T1914]  __xfrm_state_delete+0xa12/0xa30
 [   59.648720][ T1914]  xfrm_state_delete+0x22/0x40
 [   59.648736][ T1914]  xfrm_del_sa+0x182/0x410
 [   59.648747][ T1914]  ? __pfx_xfrm_del_sa+0x10/0x10
 [   59.648756][ T1914]  ? cap_capable+0xf5/0x3e0
 [   59.648771][ T1914]  ? lock_release+0x79/0x140
 [   59.648781][ T1914]  ? __nla_validate_parse+0xe3/0x4b0
 [   59.648796][ T1914]  ? __nla_parse+0x40/0x60
 [   59.648807][ T1914]  ? __pfx_xfrm_del_sa+0x10/0x10
 [   59.648818][ T1914]  xfrm_user_rcv_msg+0x41c/0xa30
 [   59.648843][ T1914]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 [   59.648862][ T1914]  ? stack_trace_save+0x8e/0xc0
 [   59.648873][ T1914]  ? __pfx_stack_trace_save+0x10/0x10
 [   59.648883][ T1914]  ? stack_depot_save_flags+0x40/0x670
 [   59.648899][ T1914]  ? stack_trace_save+0x8e/0xc0
 [   59.648920][ T1914]  ? __lock_acquire+0x679/0xd50
 [   59.648931][ T1914]  ? trace_contention_end+0xdd/0x110
 [   59.648942][ T1914]  ? __mutex_lock+0x25e/0x1c50
 [   59.648957][ T1914]  netlink_rcv_skb+0x152/0x3f0
 [   59.648975][ T1914]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 [   59.648993][ T1914]  ? __pfx_netlink_rcv_skb+0x10/0x10
 [   59.649014][ T1914]  ? __lock_release.isra.0+0x65/0x170
 [   59.649025][ T1914]  ? netlink_deliver_tap+0x19d/0x510
 [   59.649043][ T1914]  xfrm_netlink_rcv+0x71/0x90
 [   59.649059][ T1914]  netlink_unicast+0x5aa/0x870
 [   59.649077][ T1914]  ? __pfx_netlink_unicast+0x10/0x10
 [   59.649094][ T1914]  ? __lock_acquire+0x679/0xd50
 [   59.649107][ T1914]  netlink_sendmsg+0x8f7/0xdd0
 [   59.649126][ T1914]  ? __pfx_netlink_sendmsg+0x10/0x10
 [   59.649143][ T1914]  ? __import_iovec+0x1dd/0x650
 [   59.649156][ T1914]  ? __pfx_netlink_sendmsg+0x10/0x10
 [   59.649173][ T1914]  ____sys_sendmsg+0x901/0xa50
 [   59.649187][ T1914]  ? copy_msghdr_from_user+0x10a/0x160
 [   59.649204][ T1914]  ? __pfx_____sys_sendmsg+0x10/0x10
 [   59.649222][ T1914]  ___sys_sendmsg+0x134/0x1d0
 [   59.649240][ T1914]  ? __pfx____sys_sendmsg+0x10/0x10
 [   59.649262][ T1914]  ? find_held_lock+0x2b/0x80
 [   59.649283][ T1914]  __sys_sendmsg+0x16d/0x220
 [   59.649293][ T1914]  ? __pfx___sys_sendmsg+0x10/0x10
 [   59.649310][ T1914]  do_syscall_64+0xc1/0x3a0
 [   59.649326][ T1914]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 [   59.649337][ T1914] RIP: 0033:0x811ded
 [   59.649345][ T1914] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ea 6c fd ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 3e 6d fd ff 48
 [   59.649355][ T1914] RSP: 002b:00007f16bfffbb60 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
 [   59.649366][ T1914] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000811ded
 [   59.649373][ T1914] RDX: 0000000000000040 RSI: 00007f16bfffbba8 RDI: 00000000000001b7
 [   59.649379][ T1914] RBP: 0000000000010000 R08: 0000000000000000 R09: 0000000000000007
 [   59.649386][ T1914] R10: 0000000000000008 R11: 0000000000000293 R12: 00000000000001b7
 [   59.649392][ T1914] R13: 00007f16bfffbc00 R14: 00007f16bfffbea4 R15: 0000000000000001
 [   59.649404][ T1914]  </TASK>
 [   59.649408][ T1914] 
 [   59.669742][ T1914] Allocated by task 1913 on cpu 1 at 59.636016s:
 [   59.670122][ T1914]  kasan_save_stack+0x33/0x60
 [   59.670411][ T1914]  kasan_save_track+0x17/0x60
 [   59.670700][ T1914]  __kasan_slab_alloc+0x89/0x90
 [   59.671003][ T1914]  kmem_cache_alloc_noprof+0x22a/0x6c0
 [   59.671332][ T1914]  xfrm_state_alloc+0x23/0x5c0
 [   59.671625][ T1914]  xfrm_state_construct+0x31/0x2240
 [   59.671947][ T1914]  xfrm_add_sa+0x183/0x530
 [   59.672219][ T1914]  xfrm_user_rcv_msg+0x41c/0xa30
 [   59.672525][ T1914]  netlink_rcv_skb+0x152/0x3f0
 [   59.672821][ T1914]  xfrm_netlink_rcv+0x71/0x90
 [   59.673117][ T1914]  netlink_unicast+0x5aa/0x870
 [   59.673413][ T1914]  netlink_sendmsg+0x8f7/0xdd0
 [   59.673709][ T1914]  ____sys_sendmsg+0x901/0xa50
 [   59.674007][ T1914]  ___sys_sendmsg+0x134/0x1d0
 [   59.674299][ T1914]  __sys_sendmsg+0x16d/0x220
 [   59.674579][ T1914]  do_syscall_64+0xc1/0x3a0
 [   59.674866][ T1914]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 [   59.675220][ T1914] 
 [   59.675366][ T1914] Freed by task 84 on cpu 1 at 59.641719s:
 [   59.675712][ T1914]  kasan_save_stack+0x33/0x60
 [   59.676006][ T1914]  kasan_save_track+0x17/0x60
 [   59.676294][ T1914]  kasan_save_free_info+0x3b/0x60
 [   59.676598][ T1914]  __kasan_slab_free+0x5f/0x80
 [   59.676897][ T1914]  kmem_cache_free+0x2e2/0x6a0
 [   59.677189][ T1914]  xfrm_state_gc_task+0x58d/0x820
 [   59.677499][ T1914]  process_one_work+0x91e/0x1ad0
 [   59.677799][ T1914]  worker_thread+0x690/0xed0
 [   59.678084][ T1914]  kthread+0x388/0x730
 [   59.678333][ T1914]  ret_from_fork+0x556/0x690
 [   59.678616][ T1914]  ret_from_fork_asm+0x1a/0x30
 [   59.678914][ T1914] 
 [   59.679060][ T1914] The buggy address belongs to the object at ff1100011f4d4cc0
 [   59.679060][ T1914]  which belongs to the cache xfrm_state of size 920
 [   59.679863][ T1914] The buggy address is located 96 bytes inside of
 [   59.679863][ T1914]  freed 920-byte region [ff1100011f4d4cc0, ff1100011f4d5058)
 [   59.680650][ T1914] 
 [   59.680796][ T1914] The buggy address belongs to the physical page:
 [   59.681176][ T1914] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f4d4
 [   59.681692][ T1914] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 [   59.682190][ T1914] flags: 0x17ffe0000000040(head|node=0|zone=2|lastcpupid=0x3fff)
 [   59.682644][ T1914] page_type: f5(slab)
 [   59.682892][ T1914] raw: 017ffe0000000040 ff11000101c88a00 ffd40000047d3700 0000000000000002
 [   59.683393][ T1914] raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
 [   59.683899][ T1914] head: 017ffe0000000040 ff11000101c88a00 ffd40000047d3700 0000000000000002
 [   59.684408][ T1914] head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
 [   59.684919][ T1914] head: 017ffe0000000002 ffd40000047d3501 00000000ffffffff 00000000ffffffff
 [   59.685430][ T1914] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
 [   59.685938][ T1914] page dumped because: kasan: bad access detected
 [   59.686313][ T1914] 
 [   59.686458][ T1914] Memory state around the buggy address:
 [   59.686789][ T1914]  ff1100011f4d4c00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 [   59.687264][ T1914]  ff1100011f4d4c80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 [   59.687735][ T1914] >ff1100011f4d4d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [   59.688208][ T1914]                                ^
 [   59.688513][ T1914]  ff1100011f4d4d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [   59.688997][ T1914]  ff1100011f4d4e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 [   59.689466][ T1914] ==================================================================
 [   59.690008][ T1914] Disabling lock debugging due to kernel taint


Siwei Zhang (1):
  xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.7

