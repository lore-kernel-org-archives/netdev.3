Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348767;
	b=YY6+GAX0endys8xVAWlgFxEupY+VG/d5g+9PM2qemy4tJGWDZhorFC9FqZ1Eu1Jh6c4e
	 I8yQW6JpoShYppGI2SlpvDWneXv/84KCC9+rcADuB9CGJUG2KILCu5mVjdD1kE5eDSBl5
	 ZL4mHm4BNTruXDwlhNTbiP4GgovQWz0Ae+VCCk7Md4NQfYOHYUw530JNg+OuAoixRv5pm
	 iSWkG1Tf4Usyf3ToIl4J3V+J2xzGvh1OqvRcOohU5HS/wwsWzsCN6Er9uxg2nqiA1iz5U
	 Sw+aqX98KaEV7HH2atkOT692XWHen3+rs0+1mfuy1CdcBoWIWsPl69EDtSNHKGqRgnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348767;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aNXERptz7qTR+6t+3Qsay7S44BkYXF3Cv2liAKg/moM=;
	b=O8WLOQ11bi+Kwf/NvFPHxjItbjdbJCTifmzL60Fg60vUe/bU6DyTsSWEZotij6P2Nnj0
	 MDwN4FNgwrMv03NBFddTX4n3l83CX2VQOdLRrOD3fy9SF9eYzgmQjMd1omWcg6INxwHxg
	 9MbLjxUHM/jivKGxz9XqEI+nfkprF5hhSADD6jeAxfrU0FO1TGJLPPy85+XkRKecJO31i
	 SaOhu3XlxKt0QYbophkULopfZVCYynxBG6ZyWcop/A7VHLdk1O2FSNbhrNyWjzvkYnpvb
	 Xr4FdFdwQ+y/gqh4KheqTpAN0TamTY8SD4zicYfmYDdPvJVPbV9XbZVUNEwSpQhO3aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6WFI+eF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF8606A332
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6WFI+eF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E434D1F00A1F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348761;
	bh=aNXERptz7qTR+6t+3Qsay7S44BkYXF3Cv2liAKg/moM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R6WFI+eFjQuCiLtMF6m/X2DqXL6K4cKlYw4jkM7/JLuUY/34IjcRjDW8EgXKUQ93J
	 uFuP28d5QeKUEUQdT6vKfnFvzsGlX1yzxPg6CxiWQnr1iU/98P9xax32llM7ynUKpA
	 8aYs8wgSetg/+j5O825YHGXA4zUlsxQ0ls3YDP+pC3/Pn8DTFr6W77+qZ9JlPk69av
	 pDoc9RFM7f+APMqLN81e+ApLEO43BsKuhClMMmGq4JmavkH1uR3e7mu9hgJv+5UXNS
	 oAVSp33TyZly90uP1yf0+mwf95+6BKNVjxIhuYKkfVqaf2JEEEpszW39DmJ4V+F3fg
	 LejLFjVHZ7v2Q==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-55e0090c580so124776b6e.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:26:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykfEqapTEALfzs5YJZb05shAHUcxp5GAgsGigYQCv4QHlCCukE/fztb3mVMnvC4jJd5BfuXDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+sSfJkJQWPdk8IrcbAP9g6tFYIT1te82v7i8ld/80cn8rOwNb
	kJSA+ZJ5qh9COiTwy/Y7HXMm4FowC7orDu/ZsAX3RpkDkiCDPNbpptJjKO57NGFvOz1SKL27e6K
	Oo6HaeQ8tpaC8Nq0NHjM0bl8dupHDkVA=
X-Received: by 2002:a05:6808:1303:b0:4f8:65de:7293 with SMTP id
 5614622812f47-5640dce8ea9mr1292336b6e.15.1793348761127; Fri, 30 Oct 2026
 01:26:01 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ae4102e.9c6421ad.36baac.0005.GAE@google.com>
In-Reply-To: <6ae4102e.9c6421ad.36baac.0005.GAE@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 30 Oct 2026 09:25:49 +0100
X-Gmail-Original-Message-ID: <CAL4WiipBVMi_fiSQVUAFxqcPVc5jR2BswOwA2iNmGFYE_sbyRg@mail.gmail.com>
X-Gm-Features: AclHuK_c5K2Xa_OvjKUPQHstmR8REIAhrM_26qFbqmZZXQiExz0QuCddT3LTrwQ
Message-ID: <CAL4WiipBVMi_fiSQVUAFxqcPVc5jR2BswOwA2iNmGFYE_sbyRg@mail.gmail.com>
Subject: Re: [syzbot] [net?] memory leak in build_skb
To: syzbot <syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, jasowangio@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 30 oct. 2026 =C3=A0 04:34, syzbot
<syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com> a =C3=A9crit :
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    65ba8f34ec88 Merge tag 'xtensa-20261027' of https://githu=
b..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1592353e58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfbf447a1375a1=
948
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da3f21220cbbb6e1=
4ee2e
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D142ee469580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b4e738ce5f2b/dis=
k-65ba8f34.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1de9d1ecbbb6/vmlinu=
x-65ba8f34.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8a3d79b65181/b=
zImage-65ba8f34.xz
>
> AI-generated root cause summary:
> In IPsec IP-TFS (XFRM_MODE_IPTFS) processing, when inner packets (includi=
ng the
> reused outer skb) are parsed and added to a temporary local 'sublist' dur=
ing
> __input_process_payload(), any error encountering invalid header data or
> truncated payload jumps to 'done:'. At 'done:', packets on 'sublist' are =
neither
> delivered nor freed, and the reused outer skb is neither placed in 'defer=
' nor
> freed by kfree_skb(), permanently leaking the sk_buff and its attached se=
c_path
> extension.
>
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3Da3f2122=
0cbbb6e14ee2e
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com
>
> 2026/10/28 09:56:01 executed programs: 5
> BUG: memory leak
> unreferenced object 0xffff888104c73c00 (size 240):
>   comm "syz.0.17", pid 5970, jiffies 4294947974
>   hex dump (first 32 bytes):
>     90 38 1f 02 00 c9 ff ff 90 38 1f 02 00 c9 ff ff  .8.......8......
>     00 00 6a 24 81 88 ff ff 00 00 00 00 00 00 00 00  ..j$............
>   backtrace (crc 84fdfeb5):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4733 [inline]
>     slab_alloc_node mm/slub.c:5033 [inline]
>     kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
>     __build_skb net/core/skbuff.c:495 [inline]
>     build_skb+0x25/0x120 net/core/skbuff.c:511
>     __tun_build_skb drivers/net/tun.c:1631 [inline]
>     tun_build_skb+0x489/0x770 drivers/net/tun.c:1726
>     tun_get_user+0xd2e/0x2040 drivers/net/tun.c:1860
>     tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:2100
>     new_sync_write fs/read_write.c:595 [inline]
>     vfs_write+0x3ae/0x720 fs/read_write.c:687
>     ksys_write+0xa5/0x170 fs/read_write.c:739
>     do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>     do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> BUG: memory leak
> unreferenced object 0xffff888104d139c0 (size 192):
>   comm "syz.0.17", pid 5970, jiffies 4294947974
>   hex dump (first 32 bytes):
>     01 00 00 00 00 02 00 00 00 00 0b 00 00 00 00 00  ................
>     80 9f 7b 24 81 88 ff ff 00 00 00 00 00 00 00 00  ..{$............
>   backtrace (crc 420634a7):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4733 [inline]
>     slab_alloc_node mm/slub.c:5033 [inline]
>     kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
>     __skb_ext_alloc+0x1a/0x50 net/core/skbuff.c:7246
>     skb_ext_add+0x1a6/0x280 net/core/skbuff.c:7350
>     secpath_set+0x7c/0xc0 net/xfrm/xfrm_input.c:127
>     xfrm_input+0x381/0x28a0 net/xfrm/xfrm_input.c:571
>     vti_input+0xf4/0x160 net/ipv4/ip_vti.c:69
>     xfrm4_esp_rcv+0x46/0xb0 net/ipv4/xfrm4_protocol.c:104
>     ip_protocol_deliver_rcu+0x259/0x260 net/ipv4/ip_input.c:207
>     ip_local_deliver_finish+0x115/0x1e0 net/ipv4/ip_input.c:241
>     NF_HOOK include/linux/netfilter.h:325 [inline]
>     NF_HOOK include/linux/netfilter.h:319 [inline]
>     ip_local_deliver+0x97/0x140 net/ipv4/ip_input.c:262
>     dst_input include/net/dst.h:481 [inline]
>     ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
>     NF_HOOK include/linux/netfilter.h:325 [inline]
>     NF_HOOK include/linux/netfilter.h:319 [inline]
>     ip_rcv+0x212/0x230 net/ipv4/ip_input.c:612
>     __netif_receive_skb_one_core+0xce/0x100 net/core/dev.c:6405
>     __netif_receive_skb+0x1d/0x80 net/core/dev.c:6518
>     netif_receive_skb_internal net/core/dev.c:6604 [inline]
>     netif_receive_skb+0x49/0x200 net/core/dev.c:6663
>     tun_rx_batched drivers/net/tun.c:1575 [inline]
>     tun_get_user+0x1ccc/0x2040 drivers/net/tun.c:2053
>     tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:2100
>
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 103cf7c5dbfb..0313a43aa8a9 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -1182,6 +1182,7 @@ static bool __input_process_payload(struct
xfrm_state *x, u32 data,
                /* this should not happen from the above code */
                XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);

+done:
        if (first_skb && first_iplen && !defer && !first_skb_partial) {
                /* first_skb is queued b/c !defer and not partial */
                if (pskb_trim(first_skb, first_iplen)) {
@@ -1198,7 +1199,7 @@ static bool __input_process_payload(struct
xfrm_state *x, u32 data,
                if (xfrm_input(skb, 0, 0, -2))
                        kfree_skb(skb);
        }
-done:
+
        skb =3D skbseq->root_skb;
        skb_abort_seq_read(skbseq);
