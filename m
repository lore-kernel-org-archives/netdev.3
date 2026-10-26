Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016268;
	b=5ju8bX3fvx7iRx2fJp0uJtHLVneX02J3FKZAGGVAazY22s9lor5xsDcOImkibbB439Ks
	 u7Rcq3qSFDRaNAj2Gh1lh1BrSQy9Zzx/nBwrmrYi+HK61ea+i7rm/TIEut/I+ZhkoQI/i
	 OqOh/jYcM8VC6/cBWuynDvEGm8jfHbvupvdRFjuiOqGnK8s2ZbGoI378jxkERgJb4yuSk
	 g547EJu64QLk586UWDGv5bFWPeZS+/q+476N1A5enCXWhJ0tNG42I5Iysa6rjndkW+k+I
	 8FceeatfEHZyTeEP81QmpoqXIhX4zKw8H77eHM6gfVgUjT1L7bcub2PyHolZ7S1rd2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6hhfEnTNSqKM/tyqjy+CS3N1xRody6+azCrBm85/WAM=;
	b=24JpE2macplcyhDG3G67Knvpu3DJCrEBhYN9hrRlESf8qls5pznb5+t+gPfy+13fufRQ
	 r8wYf/uOIauhcJjIrz3pZbSbkqNQQZvQMxcO1YzHCcgeSSIQQgYHHarXBi7nxkVod7CsB
	 pJmIwZrhSiJMSZMP5iDDcqoi3e99PfZVTrTcHx66DAxnZABzqCFPW5SjSovXI6Cxfrjla
	 K8fcshRse7lDRRXJn7K3Zh0GIzcH4SjKVjccJUwoA+r97wPEgqakGa4wtAnJ4itu4Qnzv
	 93ix4pDgCVvhTO0mZmyDEmH28VAONUuBgsa0qDrGMep6Ao6yg+TcCIxGgJTnIz+gDYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="AG0R/kg0";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E59606A33D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E59606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AG0R/kg0
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so1221111a91.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016267; x=1793621067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hhfEnTNSqKM/tyqjy+CS3N1xRody6+azCrBm85/WAM=;
        b=AG0R/kg05eRDg9WE5jHbRGxj+K+GmIpRO9fjrcNXse5wt1WKnHI6lJnkP2vLYXWvdB
         kXSxkZr1oQxs7XsIOp0lSoR9LooIn6YguQHIwelxgRgj+1biXwMOjWi45+ssJ6AAcvxA
         04QBOjO44wFYCKCIKZIF92SvQCy09nKXgFZbfXMeCEB5ZNdvsGtyJz3+FCWD6uGMkkPb
         zjP7TlNUipVwBh2O9UhUtbskzsyUyiB9Tx1FvHkfZjx9d2b2AHDKEjoy3N8c2n6LnsGF
         U8SblTprJhxKLNNelzLhmA06qT7T9ZWxgtlc9ZU0zSFezDSkRKPfGRM+A9sNczkY1oKs
         bbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016267; x=1793621067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hhfEnTNSqKM/tyqjy+CS3N1xRody6+azCrBm85/WAM=;
        b=JIpEm4AGH4ewxO8TStoJBklzwPBBhhwDtZFKoQQNIdHmYf2lgWLnW2AFLZbdfY1R9b
         YSmhDyOA/NL4OYUTcvYpFtYxrc9ca1nGm+iIHAisAMdcP0ysQ2hRNfxddel+kQU/LFCG
         gLS8ivJJ3TygtJm7GJFfZFAqMZR/Lcq9gx+kc2cwO52DUcyjjHlQu4NJhaMNwdOKGwau
         4PFEwLhQ8/l82H1XsaOxy0qFFzLLWMOSJZrPm3du3bBqvga+T2zd2dmWgSW/ryU+qqWZ
         HESLLcwFftHv5RZbZFT19+ohP6MfsvQDx1KJjwPA3eMw0jPg7UD8r/nu027vcRsXFX4o
         EL2Q==
X-Forwarded-Encrypted: i=1; AKwUvByEzaNcoUutMaEutA0pGdty9BeIBMDP+ZwgpX/41/leqDJDBNp1hIm9StafkUV/o3/Up4FKqME=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9KH28lXGsYj/0e151t3lDyFogNvfHkDNux0Mvv2Zsn3Zf0E+o
	FzczNk3ICAOoX4lwvttCeDKtwA+Q5rsObqExJg02jYEBIsPFQ4BlNITA
X-Gm-Gg: AYBFou0otiV5LDqMwGXXJcmpakcutZWNLguDVzLDx3oBSR8OBI5dAiFKKcEvyeoaodH
	mehaZEIK1hSh7eFAMQ20gU+AImyj/oYrbTbbevIrOa5ub/fjzKbhNvxQhGph540dxvZDfIKL+b8
	9jJhp1WI3vvbcnF+Oq+SYdErSKQx50S3L8CxKNRcLonZ3zABOUfPtD+myxJNB+4a4x8m0gaQ3tB
	xiOx7pWRgi3x5Nu2e0acnx4xG7dI9BolPFFUwmFOlnw5zzo04dPC1VMJhFw0SCCvs0FsnzJfv1F
	87OFKbONoAYBCs7K/T7N34CQw+YAxdSn3MrNRYscoBUbKDGfMH5Mhj4oCleUPCE4jJvaIuw1y4h
	5NsEpPHp66iRIt4srBMBKoieH8JoU9TAGcFZmBJlKJXFhfK1rEKgLSP5rEpaUOwCmPZUy1LQCL6
	T//TT2LR+DkQZ2KicxTKq/5kqbX3KbMA2Z8ccPCrhaMAqJWb+eKg1xB8taRGvOcYnVqvqf4inlU
	0+EX3WMs4p/9NBJidTDY5yz2tWwqey/MU3PAi3gDHR74rp2yVQ=
X-Received: by 2002:a17:90b:4a44:b0:3ad:818f:3da2 with SMTP id 98e67ed59e1d1-3adeb195cfbmr4778178a91.63.1793016266667;
        Mon, 26 Oct 2026 05:04:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm8298309a91.12.2026.10.26.05.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:26 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net 2/2] mptcp: release the parent socket reference with the subflow context
Date: Mon, 26 Oct 2026 20:04:09 +0800
Message-Id: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
References: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subflow context owns a reference on its MPTCP parent socket through
ctx->conn, and subflow_ulp_release() drops it when the TCP protocol
state of the subflow is destroyed. Two users of the TCP subflow socket
can outlive that point and still follow the pointer.

bpf_skc_to_mptcp_sock() returns ctx->conn for any TCP socket that has
is_mptcp set. An SK_SKB program can look up a connected subflow with
bpf_sk_lookup_tcp() and hold the TCP child without holding the MPTCP
socket. A concurrent zero-linger close destroys the TCP protocol state
and releases the ULP despite that reference, and once the remaining
MPTCP references drain the program reads the freed MPTCP socket:

  SK_SKB reader                    MPTCP close
  rcu_read_lock()
  bpf_sk_lookup_tcp() -> ssk
  bpf_skc_to_mptcp_sock(ssk) -> msk
                                   mptcp_close()
                                     __mptcp_destroy_sock()
                                       __mptcp_close_ssk()
                                         __tcp_close()
                                           subflow_ulp_release()
                                             sock_put(ctx->conn)
                                     final sock_put(msk)
  read msk->token

A delegated action pins the TCP subflow socket, but
mptcp_subflow_process_delegated() locks and updates ctx->conn. A peer
reset followed by the application closing the MPTCP socket releases
the parent before mptcp_napi_poll() takes its data lock:

  Delegation / NAPI                 Peer reset / application close
  queue SEND or SNDBUF
    sock_hold(ssk)
                                    subflow_ulp_release(ssk)
                                      sock_put(parent)
                                    mptcp_close(parent)
                                      last sock_put(parent)
  mptcp_napi_poll()
    mptcp_subflow_process_delegated()
      mptcp_data_lock(parent)

Now that a retired context stays attached to its socket until
sk_destruct, release the parent reference from the context destructor
instead of from the ULP release. Every reference on the subflow socket
then also keeps the parent alive, and delegated actions need no
reference of their own. The final parent sock_put() may now run from
the subflow destructor in softirq or RCU callback context; the parent
is already closed and its protocol destroy callback has run by then, so
only the generic socket release is left. This depends on the previous
commit, which keeps the context alive until the subflow socket is
destroyed.

The hold around tcp_done() in mptcp_subflow_reset() stays, with its
comment updated: that call can destroy the subflow socket and thereby
release the parent reference.

Both reports below were taken with KASAN poisoning forced for the
SLAB_TYPESAFE_BY_RCU MPTCP socket cache. The first one is the BPF
reader, the second one the delegated action.

BUG: KASAN: slab-use-after-free in ___bpf_prog_run+0x2507/0xbcf0
Read of size 4 at addr ffff888119920930 by task mptcp_skb_looku/492

Call Trace:
 <IRQ>
 ___bpf_prog_run+0x2507/0xbcf0
 __bpf_prog_run32+0xda/0x120
 bpf_prog_run_pin_on_cpu+0x136/0x3d0
 sk_psock_verdict_recv+0x319/0x12c0
 tcp_read_skb+0x349/0x500
 sk_psock_verdict_data_ready+0x164/0x6f0
 tcp_data_ready+0xfe/0x3c0
 tcp_data_queue+0x181b/0x48e0
 tcp_rcv_established+0x9c5/0x3480
 tcp_v4_do_rcv+0x5bf/0xc60
 tcp_v4_rcv+0x29cb/0x3da0
 ip_protocol_deliver_rcu+0xad/0x430
 ip_local_deliver_finish+0x383/0x610
 ip_local_deliver+0x16a/0x1c0
 ip_rcv+0x2d1/0x380
 __netif_receive_skb_one_core+0x19c/0x1f0
 __netif_receive_skb+0x22/0x150
 process_backlog+0x43c/0x1260
 __napi_poll.constprop.0+0xab/0x670
 net_rx_action+0x4df/0xe60
 handle_softirqs+0x201/0x930
 do_softirq+0x47/0xa0
 </IRQ>

Allocated by task 492:
 kmem_cache_alloc_noprof+0x20b/0x5f0
 sk_prot_alloc+0x65/0x260
 sk_alloc+0x37/0xb40
 inet_create+0x33a/0xf40
 __sock_create+0x2c4/0x730
 __sys_socket+0x141/0x210
 __x64_sys_socket+0x77/0xc0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 496:
 kmem_cache_free+0x293/0x670
 __sk_destruct+0x4dd/0x8f0
 sk_destruct+0xb3/0xd0
 __sk_free+0xdd/0x370
 sk_free+0x51/0x80
 mptcp_close+0x7d/0x100
 inet_release+0x11f/0x250
 __sock_release+0xb8/0x270
 sock_close+0x21/0x30
 __fput+0x39f/0xa60
 fput_close_sync+0xff/0x200
 __x64_sys_close+0x8c/0xf0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x38/0x50
Read of size 1 at addr ffff88810acf25d8 by task ksoftirqd/2/29

Call Trace:
 <TASK>
 lock_acquire+0x113/0x2f0
 _raw_spin_lock_bh+0x38/0x50
 mptcp_subflow_process_delegated+0xa6/0x9a0
 mptcp_napi_poll+0x50d/0x12f0
 __napi_poll.constprop.0+0xab/0x670
 net_rx_action+0x4df/0xe60
 handle_softirqs+0x201/0x930
 run_ksoftirqd+0x33/0x60
 smpboot_thread_fn+0x3bd/0x9a0
 kthread+0x34f/0x460
 ret_from_fork+0x659/0x940
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 586:
 kmem_cache_alloc_noprof+0x20b/0x5f0
 sk_prot_alloc+0x65/0x260
 sk_alloc+0x37/0xb40
 inet_create+0x33a/0xf40
 __sock_create+0x2c4/0x730
 __sys_socket+0x141/0x210
 __x64_sys_socket+0x77/0xc0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 586:
 kmem_cache_free+0x259/0x5a0
 __sk_destruct+0x4a0/0x790
 sk_destruct+0xb3/0xd0
 __sk_free+0xdd/0x370
 sk_free+0x51/0x80
 mptcp_close+0x150/0x530
 inet_release+0x11f/0x250
 __sock_release+0xb8/0x270
 sock_close+0x21/0x30
 __fput+0x39f/0xa60
 fput_close_sync+0xff/0x200
 __x64_sys_close+0x8c/0xf0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
 net/mptcp/subflow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8dc0677dc551..ebcface15661 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -471,7 +471,9 @@ void mptcp_subflow_reset(struct sock *ssk)
 	if (ssk->sk_state == TCP_CLOSE)
 		return;
 
-	/* must hold: tcp_done() could drop last reference on parent */
+	/* must hold: the parent reference owned by the subflow context is
+	 * released together with ssk, which tcp_done() can destroy
+	 */
 	sock_hold(sk);
 
 	subflow->resetting = 1;
@@ -820,6 +822,8 @@ static void subflow_ctx_destruct(struct sock *ssk)
 
 	rcu_assign_pointer(inet_csk(ssk)->icsk_ulp_data, NULL);
 	ctx->tcp_sock_destruct(ssk);
+	if (ctx->conn)
+		sock_put(ctx->conn);
 	kfree_rcu(ctx, rcu);
 }
 
@@ -2120,7 +2124,6 @@ static void subflow_ulp_release(struct sock *ssk)
 		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
 						  &mptcp_sk(sk)->flags))
 			mptcp_schedule_work(sk);
-		sock_put(sk);
 	}
 
 	mptcp_subflow_ops_undo_override(ssk);
