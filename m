Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52B3CC9F6;
	Fri, 14 Aug 2026 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749249; cv=none; b=ptnt75/Iwk2rgb/THwk2BXLiIwnBBK0aBJhy+J0qCJuiD/u8aubbA0u+eUfvJrOmBRfIQrnJ+ExPP6VcFAh/zHIz7cPb/4umDGLaVPdc+TQGpB41Z9skwtN11Kb65Hxpkqt9VcAd1CxTJv7wwtP81S1j5lSHkQRrXq566LRi8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749249; c=relaxed/simple;
	bh=7g70WS7KVvUZdaETpp1ZPBCKFcqThIwbwcg0uOFU8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9MDmqoefxkWjitlZFzQ4fWa0yRGr8RPpyAPzsXV99bvOcnLaP/sHrqsTnvG6EoIE89Ml85WfwtMj+vfclXMnTBsazLEJ1cSu3Vx5vgNFMLDYFRqtCjo0vfTfjnek25aLoUJuHfIGhwZJ7mKbpQbIshv+gpPhLGpOsXqS4kT8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=b9nlvx/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqO8gJXB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="b9nlvx/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqO8gJXB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E2D814000F1;
	Fri, 14 Aug 2026 19:14:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 14 Aug 2026 19:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1786749244; x=1786835644; bh=2maQtjbzSY0fif66GOBMQzYy3A7PMOQU
	N8uytFVAt1U=; b=b9nlvx/y+wv0ZI0oXiDDhghiuED8gE8k5+1W84cFSeGRVeMn
	rJlBl8y4MXtlHhqjXHxe7yyO0Nz8yOJgradc6PTfMpkjXpenkYgSnUyp1a4D5y9B
	Y7NVoYq8CLCA5FF97PQtkW1XCMRl+JCaa69cgzLtyLdRDY0V9bhKrrG+4IY1Rgc2
	QLhKxHZ/o/UHX9FQY738gAKWpXmVmiZx8QUj6Y8ybuv2mQ9ymZy16ol/iXJpY6I5
	3dFOLkKDMEQG08gsOPcAvNls/Mmrr2QWsWu4TKM/iSfic3G0mE+6vbBcq0jIPKdT
	IsizOY28Twhr1EvQX5SUs4TKdhIJYcK9MIwW+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786749244; x=
	1786835644; bh=2maQtjbzSY0fif66GOBMQzYy3A7PMOQUN8uytFVAt1U=; b=K
	qO8gJXBVPAap26z02RVWM4sezY1TYpKhqHUzXp2be+4T1Q+qf68Doo3y+ZBctpZa
	EWxwN6MsVJrGIRvcJika3Aiw7awSt6ZvUj29C7kn/f+zddKPPKfilxylr8ktF/tG
	TT6+u0gqDIzZnt/LRK+/v0b9qlxBZysxpDUrUsej4DknxKQAOBGIWsEgIR18bTET
	Z5SKSRZQJ402EL/xni938ZmgS90uZFzhAEwQxlaYellvAHAGfZZfFGsezJfSi9YQ
	21wD0UynRYEvzer4mwBsQ0sw7kkFui9eYTItg6QZGZjHsM002taNiIlnoPfpGNtZ
	XZYD6kEUQGGw8o87V0hMg==
X-ME-Sender: <xms:O6F_aq9B0NE1ZyTYvFueB9aGYaOKQ4ChcbTvHVU1sYp1gilMYhuHBw>
    <xme:O6F_arLnpNHexDT7bnvjDPhc-cBnx34LHZh5PklKemPNdRZyAyRZmG92C-sSUPj9G
    sxwaXpZ9A6GwXPT_7hEMrUqffxFLlU-1oqeW2oIEIROeaBykmUko6Q>
X-ME-Received: <xmr:O6F_aguPfyipBHYKZIIM79zj8L3nmsZaG2tbUp5gExlrw5jpeYsVstJjNGE>
X-ME-Proxy-Cause: dmFkZTFYP2OcNGoZVBHpCnsozM5vc3+qZz70OTa5q67eEEJbcJ5/j/NTlQ12bvbqs/Z40x
    tXC14Bw7vvCwCa+DtpG4pXCxlNg7Nsf21fD7GPJw0pALLXWzvaLDzYoRq4wHgxiSdYqWvB
    TW4DTWLIXz5sd4X/Ccx8ecK1c54m0dmBuTcysZlng9n3OkVNbLCpOUJjEZ6Q8pxQFy65lu
    7NqFNPZkeHmaoXsbZT9VBob+Q46nSjmicgnl7c6q6Adg5JARK7pax1npDeHWoGSxvA7PS7
    Q4Yjl+MOxz3v5med7yyYu/oCBlAO0S6/xc+f/YGZrjcRX+1pZojcdwDeBfdrGJtZiIlJoc
    BKWPXYCXTCIFqbtTqO2OSf+j/6gKf9jYD7DrfwrWc8RTc3LpIYLX2r2YoeyPwlu/0ni9ET
    VQDqMJEPbhiJtHRkZwP5LJ/NbjMmVthcKTes6YlfYsNLkag1BWvj2F39ADq6ic7bss93u7
    cU/SdvZZSxUd0472rQbpajsmwWiTqWOjLd7x5169SYLx/R7+lIOM3VUzpzuJI7XcraebMs
    Fi3XahmGPMGZAgLNB1uU5Mqy6ybesoonL2pCmuS8MUEI/soyeTLZvTMkCzVWAdYUeZL+WQ
    YW2+1RThfvd3DA7WjwYsIEEM9stNdg2lhaoQU1uEf6mOpaxshfzrSduBIdiw
X-ME-Proxy: <xmx:PKF_aqCww7gxdIh23WghKKItK1IebUK_-tXcETqNJExbcl52Cn4zrg>
    <xmx:PKF_agMtKIMGQDnsGvpPRFdWZ-fJGTKBK38wH0k8mMmueQWkz3DCiw>
    <xmx:PKF_aqDdxDl3TxvgbXBig3LnZxnl0rfN8H7ldw0JmtNrnhhg0NvYlw>
    <xmx:PKF_ah71jeMD0VLN4vR6ZncqM6xJ8A-n2OqMU-DsFUFOuT4mmj5VbQ>
    <xmx:PKF_apsqBKHPEVuFfI4FEBrc25y3igRs0oHzAjB24jdaNh9Ot88Z9e6c>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 19:14:03 -0400 (EDT)
Date: Sat, 15 Aug 2026 01:14:01 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com>,
	davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in rtmsg_ifinfo_build_skb
Message-ID: <an-hOd_nV-xUqpUq@krikkit>
References: <6a7f3555.dbb3a75c.20434b.0005.GAE@google.com>
 <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLye45x8mhXm5-rcttmCqjDKEEXR70o9jJeFy0kOp0zbQ@mail.gmail.com>

2026-08-14, 17:35:00 +0200, Eric Dumazet wrote:
> On Fri, Aug 14, 2026 at 5:33 PM syzbot
> <syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    02dc699f83d0 Merge tag 'kbuild-fixes-7.2-1' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17320db9580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f2f6312ad1b5a0bfe316
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d0e5b9580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f9cc9e580000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-02dc699f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/faf03a1fb300/vmlinux-02dc699f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a48e50ceca1d/bzImage-02dc699f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > err == -EMSGSIZE
> > WARNING: net/core/rtnetlink.c:4538 at rtmsg_ifinfo_build_skb+0x1c1/0x260 net/core/rtnetlink.c:4538, CPU#1: syz.0.17/5924
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5924 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:rtmsg_ifinfo_build_skb+0x1c1/0x260 net/core/rtnetlink.c:4538
> > Code: ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 80 00 00 00 45 8b 76 08 e9 3c ff ff ff e8 40 d7 73 f8 90 <0f> 0b 90 ba 02 00 00 00 48 89 ee 31 ff bb a6 ff ff ff e8 d8 8f f0
> > RSP: 0018:ffffc90004266df0 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 00000000ffffffa6 RCX: ffffffff89968a40
> > RDX: ffff888034e5a540 RSI: ffffffff89968aa0 RDI: ffff888034e5a540
> > RBP: ffff88803d24db80 R08: 0000000000000005 R09: 0000000000000000
> > R10: 00000000ffffffa6 R11: 0000000000000000 R12: 0000000000000002
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880578ce108
> > FS:  000055558858a500(0000) GS:ffff8880d5ed8000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000001140 CR3: 0000000036c7c000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  rtmsg_ifinfo_event net/core/rtnetlink.c:4566 [inline]
> >  rtmsg_ifinfo_event net/core/rtnetlink.c:4556 [inline]
> >  rtnetlink_event+0x137/0x1f0 net/core/rtnetlink.c:7136
> >  notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
> >  call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
> >  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2302 [inline]
> >  netdev_features_change net/core/dev.c:1590 [inline]
> >  netdev_update_features net/core/dev.c:11108 [inline]
> >  netdev_update_features net/core/dev.c:11105 [inline]
> >  netif_disable_lro+0x3e9/0x660 net/core/dev.c:1831
> >  inetdev_init+0x371/0x570 net/ipv4/devinet.c:284
> >  inetdev_event+0x7fa/0x17f0 net/ipv4/devinet.c:1590
> >  notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
> >  call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
> >  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2302 [inline]
> >  register_netdevice+0x1998/0x25a0 net/core/dev.c:11484
> >  macsec_newlink+0x4fb/0x1c50 drivers/net/macsec.c:4221
> >  rtnl_newlink_create net/core/rtnetlink.c:3913 [inline]
> >  __rtnl_newlink net/core/rtnetlink.c:4044 [inline]
> >  rtnl_newlink+0x1499/0x2380 net/core/rtnetlink.c:4159
> >  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:7076
> >  netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
> >  netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
> >  netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
> >  sock_sendmsg_nosec net/socket.c:775 [inline]
> >  __sock_sendmsg net/socket.c:790 [inline]
> >  ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
> >  ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
> >  __sys_sendmsg+0x160/0x210 net/socket.c:2770
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fbf0c99e019
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fffe9eca118 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007fbf0cc25fa0 RCX: 00007fbf0c99e019
> > RDX: 0000000000000000 RSI: 0000200000000280 RDI: 0000000000000005
> > RBP: 00007fbf0ca3500c R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fbf0cc25fac R14: 00007fbf0cc25fa0 R15: 00007fbf0cc25fa0
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> 
> #syz test
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index ee0e2eb7dbc61c1affe4b0203337f2fdaeaa031c..0844f551d3be696bad72a8322fa4ea1bf9ccf105
> 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -4402,7 +4402,7 @@ static int macsec_fill_info(struct sk_buff *skb,
>                 csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 :
> MACSEC_CIPHER_ID_GCM_AES_256;
>                 break;
>         default:
> -               goto nla_put_failure;
> +               return 0;
>         }

It's not possible to create a macsec device with a key length other
than those 2, but it's true that returning -EMSGSIZE in this case is
not correct (-EINVAL + DEBUG_NET_WARN_ON_ONCE I guess).

The real problem is that we register the netdev before private data
has been fully initialized (macsec_newlink calls register_netdevice,
then macsec_add_dev), so we end up reaching fill_info before key_len
has been set.

So I think we should run macsec_add_dev before registering (and maybe
move those allocs to ndo_init), and possibly macsec_changelink_common
too. Setting the sci was intentionally done late, so this bit should
stay where it is.

-- 
Sabrina
