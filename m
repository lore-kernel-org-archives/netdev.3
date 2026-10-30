Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331248;
	b=y5YxtW4mlxFS1pKvZdmFmf7nX0vpncFtNJMt4N5yqK1+wQ1NHE5yUM1lvfG8sLvBJxsR
	 C5BEF3N2IuyvPDI78K6vzQ4pwePxIwDDNUrOl4wo70o2yLfrrSDqKj4kmopzZIDPZYn7V
	 vyOLNSc4bDOM/mEkzujzvRdxvwhx0zylQXDj6f+jodYS9H1p50c5xO4sNWkCdyv23r8vi
	 hYGQUX3g0wE3KJwYZyp1RSuQ4+gLHIfK8/tAg3rzcHRoKhV0TKP1+PRxiRJMiOfcSdYFY
	 +I8pn0r6bfMG0uJBMeWYOD6l0x5gJ36GK36DXMtJVEo7uRA1RqdvWXOujX8QzgbdFPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331248;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=Vix3fmD5B1RoXCv2Tg2/yNFH2E30GjPKB1m+XBLjNCc=;
	b=e+cc0kTeN7y8mbRuHcstdIQDFy621d51XY/ZaxRD8vMjxMKSzhiGEBFq/Wq/fgMzi00z
	 n37pq+MYhPyyyBVkxX4kbR5doKCTRsYMUzDUSA9Tnw+cX2/rbSFYnTFaQVBjmrFz54AfT
	 ZK6heg/YDm2plQ8PChdNOc3zKdG3JEUIkiRoOHFrA0fEGwanfuTAlcD2V6mjNBcbQn2TX
	 k4o52DmUghGO+qOaxIoj8hIL44/hT/U5xMY/1nNUBgz7sKX2SFD2p8jb9fruUxGNhgFhZ
	 cKEWzXqvKnFpTpN8dixBwCJTW+0Az/UO/3En2JfVRrnjfvH2LA4s/YBu6MmrOBw6q9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B1606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D6B1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c467e19391so444586b6e.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331246; x=1793936046;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vix3fmD5B1RoXCv2Tg2/yNFH2E30GjPKB1m+XBLjNCc=;
        b=yRj85cBJWcDY1LQ/r8ke2vptsPDlm99CctkahLtAISGLoWLmK1S14Am9m0SPwc9dgi
         IsHMR9KcT/gjF+173eeVLbUHY6V/ZTMMY9DM6/FNrOb2LGKVH9MqtpZw1IWkgCsqx5IG
         KAhKSVIyDNPuCoIKe1MR2keHoWTNz7L6tle685jy6+iD2T2Xg9k7RHqJbvJBxG7sQho7
         z5hJhwp4qlXbgq8FT/iDCUMH58GoZWs0/ScFKfoMe6f1mgPWTmW7etHdOVHnY67t7Ra7
         BQbJdECese0jnTdX+EiIKq0TF8bLM17jl7X0i06DwkO3S+8RnVd7mkIh4RHSD+Iv5nTz
         EwYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJy4cyOaOzTka6hPXKFe7UUqoN/gS9KZRT6hTyzHuwjNSAwqL65FmJs/4UYbFQy4TjN4hJ9t8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkFe0p4cQXW+CD+BkO6zcnPCrtqyxta4fiTPeW+CUtWadrDrg+
	8/NR7YvgqAt9VCyetQDSGAwwcRxtWbyHvdIUeXUD30v1nDY7PLiG/osiGG9ezha2YR2DIbU7Ddw
	b5b0zK5RVYrhzwD+RmwKL1C6DG7vu7ZXDv3l8SKq0CvKDouKO/L2/AdoF+vU=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2396:b0:53f:3c0e:c74b with SMTP id
 5614622812f47-5640d91a298mr938755b6e.9.1793331246705; Thu, 29 Oct 2026
 20:34:06 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:34:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae4102e.9c6421ad.36baac.0005.GAE@google.com>
Subject: [syzbot] [net?] memory leak in build_skb
From: syzbot <syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	jasowangio@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    65ba8f34ec88 Merge tag 'xtensa-20261027' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1592353e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbf447a1375a1948
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f21220cbbb6e14ee2e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142ee469580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4e738ce5f2b/disk-65ba8f34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1de9d1ecbbb6/vmlinux-65ba8f34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a3d79b65181/bzImage-65ba8f34.xz

AI-generated root cause summary:
In IPsec IP-TFS (XFRM_MODE_IPTFS) processing, when inner packets (including the
reused outer skb) are parsed and added to a temporary local 'sublist' during
__input_process_payload(), any error encountering invalid header data or
truncated payload jumps to 'done:'. At 'done:', packets on 'sublist' are neither
delivered nor freed, and the reused outer skb is neither placed in 'defer' nor
freed by kfree_skb(), permanently leaking the sk_buff and its attached sec_path
extension.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=a3f21220cbbb6e14ee2e

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com

2026/10/28 09:56:01 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888104c73c00 (size 240):
  comm "syz.0.17", pid 5970, jiffies 4294947974
  hex dump (first 32 bytes):
    90 38 1f 02 00 c9 ff ff 90 38 1f 02 00 c9 ff ff  .8.......8......
    00 00 6a 24 81 88 ff ff 00 00 00 00 00 00 00 00  ..j$............
  backtrace (crc 84fdfeb5):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
    __build_skb net/core/skbuff.c:495 [inline]
    build_skb+0x25/0x120 net/core/skbuff.c:511
    __tun_build_skb drivers/net/tun.c:1631 [inline]
    tun_build_skb+0x489/0x770 drivers/net/tun.c:1726
    tun_get_user+0xd2e/0x2040 drivers/net/tun.c:1860
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:2100
    new_sync_write fs/read_write.c:595 [inline]
    vfs_write+0x3ae/0x720 fs/read_write.c:687
    ksys_write+0xa5/0x170 fs/read_write.c:739
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888104d139c0 (size 192):
  comm "syz.0.17", pid 5970, jiffies 4294947974
  hex dump (first 32 bytes):
    01 00 00 00 00 02 00 00 00 00 0b 00 00 00 00 00  ................
    80 9f 7b 24 81 88 ff ff 00 00 00 00 00 00 00 00  ..{$............
  backtrace (crc 420634a7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
    __skb_ext_alloc+0x1a/0x50 net/core/skbuff.c:7246
    skb_ext_add+0x1a6/0x280 net/core/skbuff.c:7350
    secpath_set+0x7c/0xc0 net/xfrm/xfrm_input.c:127
    xfrm_input+0x381/0x28a0 net/xfrm/xfrm_input.c:571
    vti_input+0xf4/0x160 net/ipv4/ip_vti.c:69
    xfrm4_esp_rcv+0x46/0xb0 net/ipv4/xfrm4_protocol.c:104
    ip_protocol_deliver_rcu+0x259/0x260 net/ipv4/ip_input.c:207
    ip_local_deliver_finish+0x115/0x1e0 net/ipv4/ip_input.c:241
    NF_HOOK include/linux/netfilter.h:325 [inline]
    NF_HOOK include/linux/netfilter.h:319 [inline]
    ip_local_deliver+0x97/0x140 net/ipv4/ip_input.c:262
    dst_input include/net/dst.h:481 [inline]
    ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
    NF_HOOK include/linux/netfilter.h:325 [inline]
    NF_HOOK include/linux/netfilter.h:319 [inline]
    ip_rcv+0x212/0x230 net/ipv4/ip_input.c:612
    __netif_receive_skb_one_core+0xce/0x100 net/core/dev.c:6405
    __netif_receive_skb+0x1d/0x80 net/core/dev.c:6518
    netif_receive_skb_internal net/core/dev.c:6604 [inline]
    netif_receive_skb+0x49/0x200 net/core/dev.c:6663
    tun_rx_batched drivers/net/tun.c:1575 [inline]
    tun_get_user+0x1ccc/0x2040 drivers/net/tun.c:2053
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:2100

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
