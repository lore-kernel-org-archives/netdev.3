Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1722C3245
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474564; cv=none; b=udAjnvUvzA+7SQq6NJls0IMJ/6mRIkdi9JDwAM3XOez/BcnwC+rqpIZuJvsfFGtfkXUMfwVQYVeJLTvMoEeHSsgbELqtgVDr8GLMVANsWG925564Oyqfou3DQzEgq7bmQyTajHNSJA2XVit+LsonF/sa3SzokcgB/wMW6ubyJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474564; c=relaxed/simple;
	bh=I4z8RcddTk/W6eb/VEggN6eIMMI5w0xL7uumLhDLtkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzyCSGTjWm3xK66BFv6SxNlnEdKWD2nIN/6xqtFO//U9ADU1mkKp5oDzRK+uBz+a+A5crYnrmSCaT1bAsTxs2Hum54/Sl6t4Z8Nagp00gEARiVT45Q9uT6tdMeLhHTSDbktOYUsESStobMNIDdKjBM6O5VGrRgihll5YHXxHXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dcj03gxl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dcj03gxl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceeee8c46bso15510135ad.2
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474562; x=1785079362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/kAZZ6CXcXVTT9Vyn6wjy2NgA+oPqodreHoRRBv/nk=;
        b=Dcj03gxlgbqH1eRH2R5C1Z/nou2byrsBbk0JMWELKczlRE+SVpXumjH37kw/UWwFqp
         KIYwVT442fJ6MUfZy3sVWp7fECRVAf9r0/0v6V1nnufSoc+5dKrrXJ3ciHpr3TMjHJDO
         uJJ7yt96+f4aFzryIjMZwsCYQfgtjVPLiVLrgf+xO5klGpEUkGmprUzOEHgYHcr2ZvHU
         udJtOP3qDVM2gXkYkDbVjjuBnegjntNPMCQkBErMrJvWuehnh+roqaRjqmqhyk5joMBw
         0jAz1ib87VTPQSmCZwRPSQm4pnpHZYyNsdZ0B8xcio4tgm4ZpWyHVyi6eO5N4+qiShvZ
         G5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474562; x=1785079362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/kAZZ6CXcXVTT9Vyn6wjy2NgA+oPqodreHoRRBv/nk=;
        b=WqXFRfhhkBIS9RUVptLqGLuer+fE49yNWyaBf6cb9JZR2ahTEKmJrNCC1xKFHqjw30
         If5rnhyQ5bkKOqQmf7w+Ai4MMB0Z7G05pcl1FWbOR3IK2fn/AphsT+mxwOVbY3375eZ6
         52iEUoQOrsfs7lu0V21vtHIyx/1QgY4Jfpf5GWtvC8IJQvUgEMJWPzOqbe3M1N4v/Ra8
         FqSt9UqnSmHN+rUlKI0DoZl+TRJfeeswUmA/SsP5oM9sqZNvv6h3JDbAzYRk3+tUZJXS
         MtMAlti6W5+5hZEB+SSrMkU1X9K5AK2Jtp74wzdmcOnzYAhf2pTomZB5leGHGFE/4dJq
         voeQ==
X-Gm-Message-State: AOJu0YwRFgL3vTOP0+NOjS80WA4/nYUtavPasOoZFyK6vlESicSc81xB
	1ZTNT5wFt8xsEn5FY/WEWZXGVIyuRtM76oZan3/zoYNll2Trvz3A4pAO
X-Gm-Gg: AfdE7cnV6ZzAL3j92WIN+1MLn8Do4XUootBAQhVskboPmLKTYsOwzL1xJIMHeuUwq5M
	kpTciLMBTL4Acaic284WHSQxbNCkWEaqmi7tqEuBCI7I05fFKoPS4QZv1ee+gAiMjhoPvseEMPe
	nZDoUcdV4dXhzMhtaaE3vGK283BXTtgWJr2uAXzazIP5pBgqP+HM3G1JUaAd2nO7n88KpSK2ynx
	IsvsDVzpT2Z55zsVXqDHrQH5+JPWbFv/HJEw4TXK4m46ah57JFVsklrJQrBhRq7Vu2fzj4NJxot
	r5UoU6KJoc4alXvd6SDHlGY99373SQ0W2E71FS5NWHP2SOVDXfWOa7IiXK0Wjqyp3nmYhYIlqtN
	jV1XiML7nmpKRMF73/5OdBPqZalXUie/gT5AdWDxSoA8/O9I37XYm9OkkDvRZD6Cxt4bf2czQKk
	xxEV+qYGVMsrJV1bhGZAKpx5Iw5YDi0qhKEbKPZAUQuG3lkPIC
X-Received: by 2002:a17:90b:5683:b0:381:fa5:5217 with SMTP id 98e67ed59e1d1-38e4b5d7cbemr8249330a91.7.1784474561728;
        Sun, 19 Jul 2026 08:22:41 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff1cd3sm4364278a91.6.2026.07.19.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:22:41 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [L7 FRAMEWORK] (sockmap))
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf, sockmap: Fix sk_redir use-after-free in send verdict
Date: Sun, 19 Jul 2026 23:22:07 +0800
Message-ID: <20260719152207.2892156-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_msg_verdict() takes a socket reference for psock->sk_redir.
tcp_bpf_send_verdict() copies that pointer while holding the source socket
lock, but does not take a reference for the local copy before dropping the
lock around tcp_bpf_sendmsg_redir().

When apply_bytes keeps the cached verdict active, another sendmsg() on the
same source socket can consume the remaining bytes and release the cached
reference while the first thread still holds only the raw local pointer:

  CPU 0                                  CPU 1
  sk_redir = psock->sk_redir
  apply_bytes remains nonzero
  release_sock(sk)
                                         lock_sock(sk)
                                         apply_bytes reaches zero
                                         psock->sk_redir = NULL
                                         release_sock(sk)
                                         tcp_bpf_sendmsg_redir(sk_redir)
                                         sock_put(sk_redir)
  tcp_bpf_sendmsg_redir(sk_redir)

The final sock_put() can free sk_redir before CPU 0 dereferences it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tcp_bpf_sendmsg_redir+0xf39/0x1020
  Read of size 8 at addr ffff888108537090 by task poc/87
  Call Trace:
   tcp_bpf_sendmsg_redir+0xf39/0x1020
   tcp_bpf_sendmsg+0x977/0x1a50
   __sys_sendto+0x32c/0x3a0
   __x64_sys_sendto+0xdb/0x1b0
  Allocated by task 85:
   sk_prot_alloc+0x56/0x210
   sk_clone+0x6f/0x14b0
   inet_csk_clone_lock+0x24/0x740
   tcp_create_openreq_child+0x25/0x2710
   tcp_v4_syn_recv_sock+0x10a/0xe00
  Freed by task 0:
   __kasan_slab_free+0x43/0x70
   slab_free_after_rcu_debug+0xa6/0x1e0
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   __sk_destruct+0x3da/0x540
   sk_psock_destroy+0x81e/0xab0
   process_one_work+0x63a/0x1070

Take a temporary socket reference while the source socket lock still
protects psock->sk_redir, and drop it after tcp_bpf_sendmsg_redir()
returns.  This keeps each unlocked use independent of cached-verdict
ownership.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/ipv4/tcp_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8e905b50dead..69cc8bc33bcd 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -469,6 +469,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	case __SK_REDIRECT:
 		redir_ingress = psock->redir_ingress;
 		sk_redir = psock->sk_redir;
+		sock_hold(sk_redir);
 		sk_msg_apply_bytes(psock, tosend);
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
@@ -489,6 +490,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
 		if (eval == __SK_REDIRECT)
 			sock_put(sk_redir);
+		sock_put(sk_redir);
 
 		lock_sock(sk);
 		sk_mem_uncharge(sk, sent);
-- 
2.43.0

