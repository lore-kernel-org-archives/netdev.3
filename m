Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8823ADBAC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170177; cv=none; b=BJAEZwwRo5afonWfJwSrrY66Rp9E+ecQKZVf5+iemwOKVUEfppJHLbaTtWHxL/j8nhf3cDsyYtK9dxTk+DTVmiIsicvEI316tv7PAaYJ6qOHuY6R4jcTUBqw6fhzA2oRI5zZtsx4rGrqJa/7zfhwwGZiL7FiIPNlgwCfCBcd6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170177; c=relaxed/simple;
	bh=xZpkcRsjMyqwKXIMySA+dUyCEbiGC+Dy79GqvFaXwvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wqp3eYd0Plujvz4GX3aZJnZPek5JZ3/K0QsTkJzQ82XiiVw7rANY5jE/PR6tGvDEdDgW2MrNAleVR2HwbriCxmosvHB0ES7i6gA9f47E+Szw+3qX84GwU+O9nHDPVnkrgHuvkh8D9CbNAzXA45IKdRxAcbT8ECVRtlAb4kKipD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlHQTHy0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlHQTHy0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso3594130b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170176; x=1781774976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0JEM3IPEIHf7I0phAfhJo+nw+BnZ//a7nBgiLZ1jD44=;
        b=QlHQTHy0MlumQyPqeSFi7Um/DF0wRxpySH1Vr79D/Xx9GSMD6ex2nLJlVHSVfsJHch
         PqVoRXINQIg5g5PwK6auQdz8ip8GdDFTXgqPGSNoN9vshanalOvy3EjP6UHP90mZOR5P
         2R4pZ4cVPg9HeHdW0auspIsA28HEgiiqLria8sSqAHBqsvS/WH7vWsstZ/dIwCRbgM4q
         Q/EnbwfLxAuSlIrfDkKjLSUkJToNjSSShiZfXgcWwseMT6gLFTlnc6KLXLk79KbJv/0R
         hEIVKk7R7ai+4uLRzLzvxZOyMvlD1v0xs3PrNDxg7Mb7GmhjrfVkGUOKwCDZntPx5cuH
         aCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170176; x=1781774976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JEM3IPEIHf7I0phAfhJo+nw+BnZ//a7nBgiLZ1jD44=;
        b=jokRrVOQ537v8NW58mi7x2eRMPVhJmkVXM2ynL180oPz8Ay3CNDC/fuXCI9nVfB3TN
         +35Jk+3Qa7E2gTYlPD9qtolQXwQN3W6RUdnbsBLGzj+Xyu7BQoZGV4UDLzmF7TtUpN7C
         WzycGK4Az9tZws3dNsunurs5lzC6t7QiwdbTVZVFB78fa636T2io0b8OUV/6ysD2zOzm
         ozhJBziV/KMwxje+Lu0AQKr8i/brx/4YB34GSwmk09Ia2bi2yQgJsRcLQT0uvjY8gH6O
         LiULaEKyJiffuL8XNcJLRs88gwVDcAb/fTK+rrpdrimEmaLtQ+b8sHCckO/iSrg8S1ef
         vQyg==
X-Forwarded-Encrypted: i=1; AFNElJ9/nis4mQ5tdWzEpoTgMtM8m0axR9d7p6xh55FLYdnjmQ4JQ1cJ5ea/7RUJiDUCF7Q7TSXRptI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkvkoJXcsQ6LU80DaxuuunY6jom57GGMLatpAq1FYmRrJh7PT
	NcvAhkC3dc7kgcXdnjM4hZnMvcaCvO5sNX6nw73SIpSyNV6fo6g3N2aD
X-Gm-Gg: Acq92OGwhv36a6NAE9oyKznJ9VfOQOo7WiQVKiEBbZmQxrOVD1gprHkSBwv0qDxzCd+
	AcVs/PwYrXZLmnhia5SJZjG1seMFoomv22hb/3vcCaB98LFF7OKxY2TA9c1Wr0rCzUau9ptlIrq
	1pw2s73EgKKI/iORtIYtQIYBD3junLupNeePp3z4Wwx2RVRZqTRvb0741rocddTd7vRSYcdykGU
	J4ow78KCj1dXJvSx6XUjxeI20XZ0BhSS1lG3Gr8+kpV8m6TK4NRzYTbGWXFpxLgjo4adWMviEHm
	1W4cFCeGRpype3a9kiJV58T0+FgZOiZ5EUSJ3PKMlGfyRy8okrI1Bgy3CjaRGLc9czddgLL92uq
	UolenUOSChFSuMyoQeikbblmJzeefzbB/cpxkr45CCFiWfpbaRtW9mB5cI+QQVpiDj80W7U0LFN
	KsTTtOp3jm9I5t2Id6E1A3rIXFTYGDx+S5inf0SmvuckIKat/M0OzuZSdYQ8xvvb5yJWaQq7HK
X-Received: by 2002:a05:6a00:1412:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-8433690a40fmr2276378b3a.17.1781170175939;
        Thu, 11 Jun 2026 02:29:35 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382f094csm1424334b3a.47.2026.06.11.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:29:35 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Thu, 11 Jun 2026 09:29:18 +0000
Message-ID: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():

  WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
  RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
  Call Trace:
   <IRQ>
   tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
   tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
   tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
   tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
   </IRQ>

The child is freed before it is ever established, so it should run no
sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_sock(),
the common point for the IPv4, IPv6 and chtls forced-close paths and for the
MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_done()
on a child that was never established too.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v3:
 - move the clearing into inet_csk_prepare_for_destroy_sock() (Kuniyuki Iwashima)

v2:
 - move the clearing into inet_csk_prepare_forced_close (Jiayuan Chen,
   Simon Horman)
 - https://lore.kernel.org/all/20260610155946.894878-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.com/
 include/net/tcp.h               | 9 +++++++++
 net/ipv4/inet_connection_sock.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..607298501e12 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2959,6 +2964,10 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dbcd37dfdc15..6305da871e78 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1279,6 +1279,7 @@ EXPORT_SYMBOL(inet_csk_destroy_sock);
 void inet_csk_prepare_for_destroy_sock(struct sock *sk)
 {
 	/* The below has to be done to allow calling inet_csk_destroy_sock */
+	tcp_clear_sock_ops_cb_flags(sk);
 	sock_set_flag(sk, SOCK_DEAD);
 	tcp_orphan_count_inc();
 }
-- 
2.43.0

