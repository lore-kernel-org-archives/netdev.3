Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED811A683C
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483543; cv=none; b=jlR8LOMSWugD6NRd+TW84v8RCoPwmtXbI15NIo+FMuuB26P6lteNGyV+YEMit/rz2t3i8CifJWvwWs6gZEJT87baJPerqr3XmwL4V2oKL8l3iwgaQiXsVh/BxRK6GxiSF8Rs2l2GvI0wZjZ4YHeX/rLQkYM5R2PqDNbXgMaBO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483543; c=relaxed/simple;
	bh=CesoFYRKsw+O5SXSx4jdD1WFIkboSdaXwuphwY8rR+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3P+6bDMZEZFypPmMTzjigFLI896avDnfJQlPniRTXuyQzhhqX79YvrpnmkSkJkzEZzrNsC3a7YohcsrqsFCwGQtA4cpHqu2AzalW5Ub9Wi6/S3kLYRm/GwZ/ke3GJ2U4b+wIudX4dN638PIEO+/8vlLEvlVclqzH2MsBNYAOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=XHvMvCPM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="XHvMvCPM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso119479a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788483540; x=1789088340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xro6XTnPAcOxfN1ZCDIt/YDKaZpg9rHm46KS1h7Fng8=;
        b=XHvMvCPMJkxv3OGU7jfHr0oWw8LQ1u+b7eB9CNnFvGiQ64IGla6Bdpl8fzJ8P5jQqF
         AtNcdZlfkhzcVo9laDroGN15REanUt6O5f2dd6zetJB62MnfMCJ8/FVtjszifoT6nqKM
         yHpk9GO9MkVAtxR20xBGHfWGHBR9kovhlbgai9sZ/NUH0x8ppAmEAJBsSVFBKik5oSU4
         elsK4TbwVgPaGJSsvPkDYgZkTVIPfL9AhmjS/rAHsL8v9903yf87KbC41IsvE4vIxbUR
         hvNsLxgYTqLuohfbOKRTGLaHXrSd74yhkQxGuqqti2TcxWOBK5c5QrvZTh5ootxoy4xl
         Cqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483540; x=1789088340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xro6XTnPAcOxfN1ZCDIt/YDKaZpg9rHm46KS1h7Fng8=;
        b=MDy1PlZmFkTCAGwkuBISHipiJGwukLGo5lriSDQo3yPkmQOoqcpMqAnUuysXOyrtJ3
         Wuz5MHQa0lSWwr21r7s4pgRqBMTrBk5SQSP6IeMFsbajVNVYnGEyzM3zbHugJJcqIQSr
         C289rX2v1KfJYeHjruLFXvveqssxzbhEZkIeoUU1vQK/sj3NukneqxxLEfFPhQCqzGJB
         KDtYK6hI/sQCE3yk52/SCXieVsAXFX4cUQijetqv9YvKjmNnKnrWTLJSArl32pxbiUO+
         E7Q+lwb61qyARf04KeyCDhJBdg825A4HhZhBzGLv0iTOQo00atG/Nv28aQYeAMp6L1cL
         F74Q==
X-Gm-Message-State: AFuF++lR9Y4esJuGZpKvN86oSD6+bA29C0Ltovy8A0DUSOjnLYr7oA1Q
	dNZNMvO5Wc/MpCLX+5s8Oekt42tm/UTDm0aXPsyRaLUpq9P4LYaB788LvaqJrpsK2Q==
X-Gm-Gg: AYBFou2B7IY1GNWtHofLwufBdlJmXl8wLN1xNXgAFDDY8wEOK0RNN9pFVVnsADki2a1
	jXQxg83ZWLAfTHb3xUW3/YwWmLw04AgsNDZCvSMRcoLvS9ztvZo7vck/bfcxQROTiCttI+V6HZZ
	NpHclhGwvoh1R/vpRebJrR0KeD7a60j4c7HQxgdZKy3vjRXKfHIjCAd7LGTGKQu3Jye/RvpmtYd
	D8lN/JPb5Fo6BR0u+1YrsjLQrqyrsBJhtOFKCy19E93zXuB9Y3Zr+xfA5wNo32AVZt6DT2+pnFc
	AtGK+rd478Bwy+8dgsb9BjeMEj98zuexuyzZF1nzkcQSVDJQS4eyZsR5qSUqaYbI+UDuVIXCvZ9
	coxYlnFk3gEqtEb4jcMSRW5w8+wLeL8gwRpvW79WvZj+QsohhsjfCnYzcw03k6dnV1omNg++ipW
	y9PSiqMtD4/DYmj1v/MN8jaRhB1SYd8c/Xx78/muWTRIAnGmZkzhFkRrryrOyKKogIj7fToaHZe
	dbqkisNDeJjBMIwVBGx9bKo38guLXwkOdtWSg==
X-Received: by 2002:a17:90b:52c4:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-39b260d3375mr3880175a91.2.1788483539796;
        Thu, 03 Sep 2026 17:58:59 -0700 (PDT)
Received: from p1.. (129-219-8-31.nat.asu.edu. [129.219.8.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b024715sm2416474eec.17.2026.09.03.17.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 17:58:59 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	David Ahern <dsahern@kernel.org>,
	co+2c72469dbbec34af@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/tcp-ao: transfer tcp_ao_info to the TIME_WAIT socket
Date: Thu,  3 Sep 2026 17:58:51 -0700
Message-ID: <20260904005851.149071-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_ao_time_wait() gives the TIME_WAIT socket a reference to the full
socket's tcp_ao_info but leaves tp->ao_info pointing at the same object.
That is only safe if the full socket is going away. On the tcp_fin()
FIN_WAIT2 path (and TCP_CLOSING in tcp_rcv_state_process()) tcp_done()
skips inet_csk_destroy_sock(), so the socket lives on in TCP_CLOSE with
its fd open while the hashed TIME_WAIT socket reads the same tcp_ao_info
from softirq, serialised against nothing.

An unprivileged user can turn that into a NULL deref: tcp_disconnect()
does not clear ao_info, so connect(AF_UNSPEC) + listen() reaches
TCP_LISTEN where TCP_AO_DEL_KEY accepts del_async=1 and NULLs
ao_info->rnext_key, which tcp_v4_timewait_ack() then dereferences
unchecked. The triggering segment need not be authenticated, as
tcp_v4_rcv()'s do_time_wait: path skips tcp_inbound_hash().

The refcount keeps the object allocated for both sockets, but nothing
keeps its contents coherent: the setsockopt writers hold the full
socket's lock while the TIME_WAIT reader runs in softirq, and no lock
spans the two. Make the transition a handover, as the sk_omem_alloc
charge moved here already implies: clear tp->ao_info instead of taking a
second reference, leaving the TIME_WAIT socket as sole owner. Such a
socket no longer exposes TCP-AO state (TCP_AO_INFO and TCP_AO_DEL_KEY
return -ENOENT); that state describes the finished connection and
belongs to the TIME_WAIT socket that keeps updating it.

  Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000010: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  RIP: 0010:tcp_v4_rcv (net/ipv4/tcp_ipv4.c:1055 net/ipv4/tcp_ipv4.c:2333)
  Call Trace:
   <IRQ>
   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
   ip_local_deliver_finish (net/ipv4/ip_input.c:241)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq.part.0 (kernel/softirq.c:546)
   </IRQ>
   <TASK>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __dev_queue_xmit (net/core/dev.c:4961)
   ip_finish_output2 (net/ipv4/ip_output.c:236)
   ip_output (net/ipv4/ip_output.c:437)
   __ip_queue_xmit (net/ipv4/ip_output.c:533)
   __tcp_transmit_skb (net/ipv4/tcp_output.c:1716)
   tcp_connect (net/ipv4/tcp_output.c:4383)
   tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
   __inet_stream_connect (net/ipv4/af_inet.c:684)
   inet_stream_connect (net/ipv4/af_inet.c:755)
   __sys_connect (net/socket.c:2183)
   __x64_sys_connect (net/socket.c:2189)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
Cc: stable@vger.kernel.org
Reported-by: co+2c72469dbbec34af@bugs.sh
Closes: https://lore.kernel.org/all/YG9s0PiBKJZcXAKld3MToa1IVRJOUoKiaA57%40bugs.sh/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ipv4/tcp_ao.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bb7bbc20ba3f..27525f90398b 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -428,7 +428,7 @@ void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
 			omem += tcp_ao_sizeof_key(key);
 		}
 
-		refcount_inc(&ao_info->refcnt);
+		rcu_assign_pointer(tp->ao_info, NULL);
 		atomic_sub(omem, &(((struct sock *)tp)->sk_omem_alloc));
 		rcu_assign_pointer(tcptw->ao_info, ao_info);
 	} else {
-- 
2.43.0

