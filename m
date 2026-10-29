Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294587;
	b=VIAtJX9o+CEeb/8M3wT5eLZH69oyQasLJ77OdftNBJT+nJ67GgSXmlC69L/f6TeyNsz5
	 zO2FwkpZjxnUKijfhzWLztVymhOs24CR4MNde0GpNVrCX41/qRMOAMFrlUEcTkJzqVwaC
	 XG5ho7TzIY60+FoWI8bC7FNsLjKdM4wqp9aqhXw+GhE3EQXhLEvRJPe3f+Jc9ZjFz4vOX
	 xaHgOeEUmF6cT+PYCgRqLMYPkhUS3IKYbQKhM8hXiEzGfNPCbjosgIVCqn2VcbraBax85
	 mk2A5xED9hk1SWZ/WKL2qiH+Uts6xd/hMaU5lRY2UEQ3Ya/Ytqvc8JGPXBeC7kWIRow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
	b=s3LfRsB+VjCwoGq8hBxSyBbnH2UBqvZP7Ob6WU36nVXRMnbf/9xxlLopxWMsubPkEYTV
	 WB/9L7WU7eciWHnjdxN4usWM7ho6oP7Od1T/5GX+62aN70wFaB3jYURev8ag6ns/T+iM+
	 LL9Cr8Ya9TNuJxw07E8Zd0bY+2jVaKZ8x9nn0U1vl4evuu7sV3Tg9vvxV7sRnYw4F35a/
	 mxqrKH7vsxb0ski3oKcJmDPErkW5fKdWVdn/ENlzqmAmcBDlk3901wNZGUwj2pNLWoo0V
	 qaF+GBdlv+vqfaUYIfGIZgFu7KXqPx4JRXvSmXC2gXSp2n9zuzcTxWk59CH5sCairxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KWf1cPuI;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47E606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA47E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=KWf1cPuI
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd69954c755so1703604a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793294586; x=1793899386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=KWf1cPuIggkZn92EwTkl/KvJ6hwWix4GVHBZ+DLMKXfuTvxLl70DB/JYAxMQ0/ScnM
         FTs5qopv8mGr2ohtYJu1dvBeEqsP+8CWgutFKJuKcj+KkfFzP1rh6GLmEUZjLJaBuTKT
         2DX2hw69+zlhM46HvRseXsqq6bzUMpLmLAOhYE++1G5Qs+0ACJ6ZiYACTI1jWL/RQLMb
         wCXNU4GgMkXQ5J6eyO2kcwYAVA5gU7o6exSV+kcU2OzwI7NmDuWiEtEoqK94jElMUgtB
         SER1e+WkA3Os3koIdvKdLyqJGojOmORnPTe2L5bknuryOY2yRt03/7Lz6EwgbI0RBdgq
         4Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294586; x=1793899386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=GFp5ua4wG7/EPMgwZOVSjrpv/0u0gVo1E/0hTgIjboyv5J/9Eh+N/lDelTbA1wPhYJ
         o2IW5K83KLEGV2WXNY53N5atb+6W74BbihOJ023axHORkLccu4TUcq5lPezgaOL3xxtT
         wxln6k0fsnKpqcMQ7AaX6/6snlGBDbnoFewOAWJ9imSIxO8wHOOFSreRK9KdtxAs+K/5
         AOqvHAV9YwlvEmfepQTkkyK/k0da9D2CW5EB886FoSxFZ8PRh1wiWtZe2LAw/ZLFGNPX
         cHrlq4Z2sUjxcf+pfP8JmXShRynnODSBBObVX0B+Gz/k98dDVmzq5Ec9+s0Czf9Q5gu3
         13gQ==
X-Gm-Message-State: AFq9FYLlf+wm6+e9lhW6R3I9SxsnpbE4awF/+CDKcSgT5WOquraA7XNZ
	hqpkQjjNLPoO+NOte8gTQxylzCexc+IghSFd/i7GYXxyGO0uUVa5/KQ0V2FMw3Cla2szMABt2Ql
	S7xlyM5koTTh4343AMpOnoFBeA7atFE6iJGVp
X-Gm-Gg: AYBFou1KTs3xxnV3WtbJ2SyesawsLvdISTNdpUI/z1ovwFW1OztozKlSuiFlKM8+Z5j
	GpMFMKj23/BZhjD89h2A7hoE0N5RQ/kSiKa+ecQmi/nL3QEw2t0B+Cxc8v/whZPJLGnlAP9ZkLI
	z09O3kwRNw21qcRdsMvxLc3VFVQYZXGKjEpneMzcKUWBnYz4fCRmBcyzANZsp2K1yYY5cEcCuK9
	04mcPnGK1lbrlc3B5pzAjd4GQU1PXaa0LPkU2kYEsiG7oVDZXTQzgUIVj+oFXuC8JFGZVdET5cF
	KHD1syzVr4I6XY7IBUKGDDU28Qz26g2KxecPUmFHE0Ei7pxnbIjAs7b0kyegFJYLIwkYFEUH6Ej
	ppUC/t3m27XSkGSiXpZTSyUMKsrskRYWfMAc=
X-Received: by 2002:a17:90b:3811:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3ae582279a3mr5438437a91.30.1793294585949;
        Thu, 29 Oct 2026 10:23:05 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85f56a85sm24253a91.1.2026.10.29.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:23:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 32BA743622;
	Thu, 29 Oct 2026 11:23:05 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 2D28ADCE139; Thu, 29 Oct 2026 11:23:05 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	Boris Pismenny <borisp@mellanox.com>,
	Aviad Yehezkel <aviadye@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] tls: only install push_pending_record for a TX context
Date: Thu, 29 Oct 2026 11:23:00 -0600
Message-ID: <20261029172302.2944955-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_set_sw_offload() assigns ctx->push_pending_record for both
directions, but the hook is a TX-side dispatcher. On a socket whose TX
side is HW offloaded, tls_set_device_offload() installs
tls_device_push_pending_record(); any later TLS_RX setsockopt
overwrites it with tls_sw_push_pending_record(), because
tls_set_device_offload_rx() itself calls tls_set_sw_offload(sk, 0, NULL)
for the software half of a successful HW RX offload, and so does the
fallback when the RX offload is declined (NIC with TX-only offload,
tls_dev_add() failure).

From then on tls_handle_open_record() (a TLS_SET_RECORD_TYPE cmsg after
a MSG_MORE send, or the close path with a pending writer) runs
tls_sw_push_pending_record() against priv_ctx_tx, which is a
struct tls_offload_context_tx, not a struct tls_sw_context_tx, and
reads open_rec from inside the offload context. On x86_64 without lock
debugging that field overlays sg_tx_data[2].dma_address, which is never
set, so the push is silently skipped and the data buffered by the
MSG_MORE send is later sent under the cmsg's record type, e.g.
application data in a handshake or alert record. Enabling
CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_LOCK_ALLOC and CONFIG_LOCKDEP, but
not CONFIG_LOCK_STAT, in the tested x86_64 configuration moves open_rec
over sg_tx_data[5].page_link. Once populated, its page pointer and
scatterlist flags are interpreted as a tls_rec pointer and dereferenced
while reading msg_plaintext.sg.size.

Only set the hook when initialising the TX side.

Found by code review while developing TLS 1.3 HW offload rekey support.

Tested with HW TLS TX and RX offload on Mellanox ConnectX-6 Dx (Crypto
Enabled): after setting TLS_RX, send() "AAAA" with MSG_MORE, then
sendmsg() "BBBB" with a TLS_SET_RECORD_TYPE cmsg for a handshake
record. Without this patch the peer receives a single handshake record
"AAAABBBB"; with it, an application data record "AAAA" followed by a
handshake record "BBBB".

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_sw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..23eb94d9da6e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2594,7 +2594,8 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 		}
 	}
 
-	ctx->push_pending_record = tls_sw_push_pending_record;
+	if (tx)
+		ctx->push_pending_record = tls_sw_push_pending_record;
 
 	/* setkey is the last operation that could fail during a
 	 * rekey. if it succeeds, we can start modifying the
-- 
2.50.1

