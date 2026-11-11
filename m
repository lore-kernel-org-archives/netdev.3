Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416817;
	b=hbvVrPey8WE5iA25d65C10HZXTG3KO1i5B62/rl2wmJTdhhDz2WKjxxt2R6TiYLFn7LD
	 Q29ZEFd/i3HmJAO3Q1TMyOal7DxKxl4R7yQE+hEMlFgfk0cy+OBi8wqcZ23wciHOBKIdo
	 3TSAiSNhRMWKgmLtPg/Sb+U++RccDpJ7Jw6wav9NlFKTGB/I5VXNLGeS/hquwipo/0XLl
	 S1/DhECdTlHjT3rEm3AqJJEjnmkAAMlUk+HfVUDJx/N6VwA3NqlDHgjiM4A85B1S3KqVC
	 3FeIvtmCPFQYMaF60SKKNARcDXLMIyMHEWU1Zf7LWl+XKD0mB2jwi7R1r86ebuk9Psg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
	b=KGhX5lTF6+sFH2hRYnXhiT5mRFePC6DPISgCZx922MwSrkijgiQZM9SqaM3CTpbJeRUx
	 eQQpYmb1LM/0QYvNe1Kw3vTrdw6i3lYtS/6mn1DW8kj8cakfKSwl219nibkYbxG62Z70C
	 s0ymBufQZUUffXscMQikRGIMPHZNa08Jx80xgLAcQ+qUxKO3rL6RbbD61fqBddzfVe26i
	 dC98JCsawGiCkC2EqfEQDPxMcbVsHInFqky5YG/rLMKF98kG9jPeFaxTbkdVo1Gpj6aA1
	 xnKE15Gp4H5uURJS9NHjkTKCsqzYLHrkNdWbLZIHyyfrDQTQ/8QkPKoKgQw4WfO7aUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbmojHWm;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CE60A2618
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2CE60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbmojHWm
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070781f63so1528157b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416816; x=1795021616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
        b=IbmojHWmWD70omZcaVCBU3b2W6NUiCjIa+IrJtazBOuwzFIQceMskZjfN16dYaqWZ6
         CxswnpmLBmfzKvCU6kXcO1hbDMh6hzwXXM1hSxZT/vNjrk0O5eZ99M1XDQ/E9KFfaE3k
         XkfHU/7oBuP4ua0kzM/7hh+lf76behzLaDXzQAUIdBJ30Ay01n8Dl5LpZFhTcBHjz5B6
         G07uRZMTBpihE03hkQ+eLytZG0lKOF9rN19d3+rpmxWwVNndqrDNk1fHMYnEL6JPsVNv
         6Zgi2Wm8u619S2db1cNeIkt+txLvd50wKvx4yNIw5QOm0oXTSVdoihymawXrTlM4dbfx
         ssTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416816; x=1795021616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwZjNt+AmvnnJlc2JIDYQN6kjA0XRtfGXpIO1xxacwA=;
        b=0vGGzDKydUnde0iiFbspkuVsmaEhR/GEM7m2oayJcy8hMbcoeA/oSwPY6EHwW6qAXI
         BDtVqHLKZCj9b9QHo0czEhpJ1tPEkL9qrfX5PgOScViKV0O5m+tktqJFcXJE0BB1gJ8S
         R82VbSgq9CwGvWVFqZ8FNCyaOdK57pa+2m5h0bBBm5RJaCuPYUqXFMlT2L1/g8haTX/k
         VFpwmf+2HDXHvHi/YN//q8XxS9N/F+C+1Jlv+/FV6Ahdqb+KZEYkCkpW8xE9iQGEtNBK
         r6GzrnA59vZg9SCmIj4u+E7aY0dEdl0SiPfQbEBy/zSJ4EaoBVY+jRQBz4kL4ar3BXdf
         K2Gw==
X-Gm-Message-State: APuU4Z9D2PLwzelrp230L+x8BPEDWWJgKrw4Cib3oEXjzMx5vGyMOwTm
	GanWbTdNnXjHa2MqRwyrsXgpBHX7+SznqAY7r6f5QNU83GppjreKg/rj
X-Gm-Gg: AYBFou3zKNPHnqRV1uzH+hyp9Y68k9KInJwEgsyy+QoGOYL4t4jubv0Qp8SrHwXRgbe
	femYpQa1wswiDCliBdPVIxkVM+RcjpjNqkXYkoLj++OWGU86Vvk4m7ebPK1//LXD5AAFJJsF9RV
	34qw3LvLAs6uFQRdOcK5M6tRS533TdXr7/iS3dfqlHmmChgBwj1vMhkUq85lwunmruhKAPU9neL
	Pw3m97pIeWA+7binIYj7/kdtrpmpswejAj8bCb0vkJfbLPMXxDHkVHmC9VXahJ7AXpuDV43Pfv+
	L5X7bTSz2qfu0thb8cVbBTzQPfZHZuS/qWF2/d8ktypYTc+1nkyC0M+90lBA07AoxZgBm5i2fta
	6AY2IbSFHEcHAXxvZYb5eLwufWKte7StiWNurQ9YHRfxAbqhdjV0CKIBC+jzxEN8YmBK7A8vY4G
	rkdwwO+nySGhqLwukCpaIIQ2+JPbNux7p+QcyFpAKYWfYmLS6Ue1ozaMnAEOX+JQzWdxY3xpvL5
	D3ToD8zrrdU2qAwqCddo0k9ARkFtGVQaMNWw5rVonhAXSoNII8PUK0MN038ZbA3VNfzV/6Lk0OT
	29mkD7kCDzsr+kIohVxqbi4X1D8hJhW2Xwx/aEHVJTDK+o+0WHfjesWcGy9NXy2L8b5isSZeZ3O
	qiw==
X-Received: by 2002:a05:6a20:ef01:b0:3e2:4bd9:683e with SMTP id adf61e73a8af0-3f2feedf34emr2685736637.73.1794416816286;
        Wed, 11 Nov 2026 09:06:56 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm2347806b3a.5.2026.11.11.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:06:55 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+beaa1ed2d7aaec16@bugs.sh
Subject: [PATCH net] net: initialize ICMP error queue opt_stats
Date: Wed, 11 Nov 2026 09:05:30 -0800
Message-ID: <20261111170528.495116-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ip_icmp_error() and ipv6_icmp_error() clone a received ICMP skb before
building its error queue entry.  skb_clone() preserves the complete control
buffer, while the IP receive paths initialize only the portion aliased by
sock_exterr_skb::header.  The two functions initialize ee, addr_offset, and
port, but leave the final byte containing opt_stats and unused untouched.
A TCX classifier can leave bpf_skb_data_end::data_end across that byte,
forging opt_stats and making __sock_recv_timestamp() pass skb->len bytes
from skb->data to put_cmsg().  For a non-linear ICMP skb, this reads beyond
its linear head.

Initialize both bitfields in the two clone-based producers.  Do not clear
the whole sock_exterr_skb because the error receive paths consume the saved
IP control-buffer header.

  usercopy: Kernel memory exposure attempt detected from SLUB object
            'skbuff_small_head' (offset 72, size 59964)!
  kernel BUG at mm/usercopy.c:102!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: usercopy_abort (mm/usercopy.c:102)
  Call Trace:
   __check_heap_object (mm/slub.c:8146)
   __check_object_size (mm/usercopy.c:258)
   put_cmsg (net/core/scm.c:276)
   __sock_recv_timestamp (net/socket.c:1061)
   ip_recv_error (net/ipv4/ip_sockglue.c:550)
   udp_recvmsg (net/ipv4/udp.c:2034)
   inet_recvmsg (net/ipv4/af_inet.c:896)
   sock_recvmsg (net/socket.c:1159)
   ____sys_recvmsg (net/socket.c:2918)
   ___sys_recvmsg (net/socket.c:2961)
   __sys_recvmsg (net/socket.c:2993)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  Kernel panic - not syncing: Fatal exception

With HARDENED_USERCOPY enabled, the reproducer aborted the unpatched kernel
on its first packet.  With runtime usercopy checks disabled and KASAN left
in report mode, the same recvmsg() returned 59,964 control-message data
bytes sourced past a 704-byte skb head.  Beyond offset 1,024, 58,932 bytes
differed from the prefilled userspace marker, including 6,288 nonzero
bytes.  The patched build completed 2,000 packets under both configurations
without a forged SCM_TIMESTAMPING_OPT_STATS message or sanitizer report.
Networking selftests were not run.

Fixes: 4ef1b2869447 ("tcp: mark skbs with SCM_TIMESTAMPING_OPT_STATS")
Cc: stable@vger.kernel.org
Reported-by: <co+beaa1ed2d7aaec16@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>

---
 net/ipv4/ip_sockglue.c | 2 ++
 net/ipv6/datagram.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec93..3ab84a4c31e5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -429,6 +429,8 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	serr->addr_offset = (u8 *)&(((struct iphdr *)(icmp_hdr(skb) + 1))->daddr) -
 				   skb_network_header(skb);
 	serr->port = port;
+	serr->opt_stats = 0;
+	serr->unused = 0;
 
 	if (skb_pull(skb, payload - skb->data)) {
 		if (inet_test_bit(RECVERR_RFC4884, sk))
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index ca3605acb433..85f646f8d059 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -330,6 +330,8 @@ void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	serr->addr_offset = (u8 *)&(((struct ipv6hdr *)(icmph + 1))->daddr) -
 				  skb_network_header(skb);
 	serr->port = port;
+	serr->opt_stats = 0;
+	serr->unused = 0;
 
 	__skb_pull(skb, payload - skb->data);
 
-- 
2.56.0

