Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106D4A21
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348477; cv=none; b=N7rYSo1WmQdueFWMm5x4B+ZeusgCoufjzd4k1dH8xFd2Fi20r26I92zo74KpgYQeu8d2xE3I0R1qqXEsQd6CaJKxDqH9XQiYpTusDvTWJvq+v0epXF7Qu5LNZxV8uOL0Up82aaxaR65Uz/8LOYqDqk0TzJps8WGq+LJwkRq2V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348477; c=relaxed/simple;
	bh=qS5tzCk95IUvdSOMslCewBdNnYXZRkDwJxePIoCWP2A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oe4P7jew1xrlcVd4dzF/PrU8wsugqCooQapxuYfFqpGSPy88g6cMjFt2+CJ85oGo/OdfBCO1hrsgZX6jj2CRIRbwFyVnTq8Cvs2YqTgEKuwJopHINAsu0J01Zd+2S6YdOuHYoU7nWuTHlbdkGUA9MOjzikQGgvj7fBYQhuoThlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StA415l7; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StA415l7"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso2427701a12.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789348475; x=1789953275; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tS/UwjALOXwC7MstWGjfEOa5jKvlKeTb9f/fFchu1KE=;
        b=StA415l7vCIVGnhwIVNacD+R5uRw5RRUUW0RU2Asmq6uUa7zXufrZGLXEb62jm+F7z
         9YOhrYd5+aIgodTL1C5M9owEhLFA1ekp3rgiu5N4PrHG5S8vw2AHl5ZVx756M9y/KGUc
         oz45lQwri3zarCM82R4/S8Z1qxBFEIxeBJiY3zexuB2LZecBBnGWAZoGokAra+6GbV/8
         EgcpH2ABvw5P7kGnqPy1IotOloeBe6Kd+OVKXle8vL1QHfl9Z5j6NogieEZkOaag99B0
         L+cE4BeWlqPjFhCg/0URUdkmHCh36m4zJ2Cp2yZ+yh/FhvsueREjf+I0r5o1eNsLfUG9
         uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348475; x=1789953275;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tS/UwjALOXwC7MstWGjfEOa5jKvlKeTb9f/fFchu1KE=;
        b=B8q/aHXVNLfgXPNVBVO0lHY559O8102cKiJClg4f5y1jVS263WTPKPA3z+j84RZhUs
         LjUl5ZLGBAKnqAIHWlawDgF33opOJKDqCg7zIVcNcqrrw8IHJAiLxvm+jEtBy+Z5jCEg
         3MpJ64Wg+J/EpbwnQoczU2veyAVWBArUlv4JYhrm7CaeTs9BEFCb1GV3DxeJG5R1SkLK
         bUQqhioKqpQEdv0Tk8RC1Nh12g917DjiyfpXtkeEQo3Si+71LVg2Z9DJYBILzjdUywHV
         PlOtVJQ32jWrCuFBr2U7chJgY1+Y2Eh2njdm0XsTKwp/4ST107d5V+TmeQVjIrSeaMFV
         RTxg==
X-Forwarded-Encrypted: i=1; AKwUvBxyqEO4MYb1LyaU3R9MbTRgLMtAiF0NVNjGf4g/NQ9yXhMo3rD+tPjn8OwBJ53LDOzdSyGkTeg=@vger.kernel.org
X-Gm-Message-State: AFuF++mmUE6uUF+J/S/oyKxx1q4i5o7YeaFuM6eVmjz+pTAkGzjzKJ1i
	ynTp0uSsu/BE221oONNWZQjKMvIMy5Gi0xrf9QHh/s4n+A+uuSkzAeCDd0sVqcwlQ2Rg+4Ct5F9
	pmDm9Sw==
X-Received: from pgp1-n1.prod.google.com ([2002:a05:6a02:62c1:10b0:cc4:b09f:9441])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939f:b0:3d2:89db:1688
 with SMTP id adf61e73a8af0-3db40422631mr435020637.2.1789348475117; Sun, 13
 Sep 2026 18:14:35 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:14:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260914011420.115556-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for close()d
 listener in tcp_v6_do_rcv().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_v6_do_rcv() no longer calls skb_clone_and_charge_r() for
TCP_LISTEN since commit 073d89808c06 ("net: fix data-races around
sk->sk_forward_alloc").

However, there is still a small race window between tcp_v6_rcv()
and tcp_v6_do_rcv(), where concurrent close() changes TCP_LISTEN
to TCP_CLOSE, causing skb_clone_and_charge_r() to be called
locklessly and resulting in the splat below. [0]

Let's avoid calling skb_clone_and_charge_r() for TCP_CLOSE as well.

This is fine for non-listeners because tcp_rcv_state_process()
drops skb for TCP_CLOSE and opt_skb was freed immediately anyway.

[0]:
sk->sk_forward_alloc
WARNING: net/ipv4/af_inet.c:162 at inet_sock_destruct+0x64d/0x810 net/ipv4/af_inet.c:162, CPU#1: ksoftirqd/1/28
Modules linked in:
CPU: 1 UID: 0 PID: 28 Comm: ksoftirqd/1 Not tainted 7.2.0 #17 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
RIP: 0010:inet_sock_destruct+0x64d/0x810 net/ipv4/af_inet.c:162
Code: 3d 49 ff e9 06 fd ff ff e8 d0 5b 83 f8 90 0f 0b 90 e9 35 fe ff ff e8 c2 5b 83 f8 90 0f 0b 90 e9 c5 fe ff ff e8 b4 5b 83 f8 90 <0f> 0b 90 e9 04 ff ff ff e8 a6 5b 83 f8 90 0f 0b 90 e9 65 fe ff ff
RSP: 0018:ffffc90000677bb8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880117bde80 RCX: ffffffff8957eb41
RDX: ffff88801dad5d00 RSI: ffffffff8957ec3c RDI: 0000000000000005
RBP: 00000000fffff000 R08: ffffffff8957eb41 R09: 00000000fffff000
R10: 0000000000000005 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880117bdf10 R14: ffffffff81c08eb7 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880d7ae5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f93a1021138 CR3: 00000000207a9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __sk_destruct+0x82/0xae0 net/core/sock.c:2356
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x59c/0x1100 kernel/rcu/tree.c:2897
 handle_softirqs+0x1e4/0x9b0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x458/0xc80 kernel/smpboot.c:160
 kthread+0x396/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x8e0/0xe40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Reported-by: Taras Madan <tarasmadan@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/tcp_ipv6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index df9c29eb5c1f..7fa4ed2fd4f1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1604,7 +1604,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
+	if (np->rxopt.all &&
+	    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
-- 
2.55.0.1007.g17ff1f9808-goog

