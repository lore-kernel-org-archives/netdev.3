Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655016;
	b=QjTmd/aAeJ7ioT7pxwVkne45M7Vy0ZOI62dldEsJYeAOBoo/t7i1USp4tQIDgm5CrAdj
	 iWO9BNyEydeQ/uBvHJlR5/pT0OLDK938JWgx2GVec6YDSrdSKPm+X+vw8regCyrNzaeYz
	 CJzNSFlxE3dYzZeJ28O2NhAXVHKRC8FHtZWU0UNmENM+vexJr0NDYYizKfTnUv9BVNCeg
	 HLPyCsYLalFM594jWAi+C/Btz3nX7tQeYyDtrB2DQPNfh9ipjEPq86E50MIn/R7gZRsH3
	 Slr9DTPNwEbBc4JOEf0RoxH0+lNasT0fTqaxq06RVugA6PUzlMKBw99ck3uP7ahQMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
	b=Dzkgd/SVkhrHY2Fw/WLn58pJLwuehg8LydoKMSHakjVKed7q1Bc0xdDK9w/oNwEOqf5p
	 vUypkokdqr2lSki5gvAXALpeq03A9/nt4YOI1nOs8yp0HXXXHmzsE5hwxox2zBwP7l6W0
	 FqlKkmOr5+6RdWCVYcohWgdlC+iXVkRnJT0OH3Y0KI1rSFMhWFEjIzlvHbGqlHc4GTMva
	 f8eGtganpWldueWt5Afa0ob4nI0d7l7INm86RtkgShBx5bb7l4DgNaj6bNjah5TmxwyTa
	 S3ZDQeIpRtGgGzBmgvRgZqErCyUIjHPgNNh1NYINsqU7M6FWzjPwKddla4MtmZw13Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DqzOhJhl;
	arc=none smtp.remote-ip=209.85.222.227
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138A606A330
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0138A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=DqzOhJhl
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93e635220b4so348617485a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793655014; x=1794259814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=DqzOhJhlFMX7tm4xWPsNcgpICq4CZkoigy5owj9/Kj+tcuzmTo+M8XfPUu5xnx4K+N
         XzRPaVpScaZGf4mCurK9fGnfXXm0S4EiZ5kDU5nt2nEZeBxN6n0gd7IFeuAx3yzoywIq
         4NwzsZ9AUKmtDwmXFm3xXjme9dOm7rVmkKW5vpPdFDpOhUhm9kOBee3FzwB3du8CWmtX
         r0yo9oeA4nWDAgdK2EK/etnDeiuVaCKPDYxTTTl9X3lc8WJVnL5bcAU1y9PXNgaVUJPl
         KIQNCgPpLlqKu/5+uxgzMm1c5MNNZemSeHxnUzp94oGLCpOY2hXWpfwG3/dBfJCGhP9c
         v8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655014; x=1794259814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2q8aiyZNu7WsOVILgK8CuohQb1g9BJN+Pm1TJ57mfvo=;
        b=ygh1Sh5eMVIvpw2yyFMChiyNIJt4Mk49+L1oVUCdNj3Dem7RhANjKjyYaixd9VGPEs
         O8iwsgzLFlyeRxpbxTeChA2ywcc8Q11W35TyYPGQ6YwVyrzPP5zR9MpIZiszvBuT89xd
         W+rwkyCRl00kDc6KN3OltIHXY2GlPykMjdqOa0gqelZ+PpAwMuQBHYc41WeHiZFffJTQ
         r6ujDSrraqYYXvJ7bVhI1/OUnJIyzlNSZYqxqlgGXs0pR0RWKrUT3qZawvu2YSj6L4it
         3ngvbnW288HQMSrYZCVs8zrCvw2QuACDtqdwhBooiQ9fJojRYseoN+lbsfoJGzeWM6dj
         /Amw==
X-Gm-Message-State: AFq9FYLGVjnl4xx10IheKch2Tri8ekY0FfUFCZra4ZJ8spUQMvMXoW7j
	PrBxcUaBL6Uj6HS8Lwn1Lj5X9eHaUwnogR4PPRhsmdUn3I5FWnlbROLnMR7KtpNNsVro+O6/I+S
	pDi0JsFLFMi6chuHI095CxH5OKTtBcaLuo2gTPEqSqg7G8rzgj8aP
X-Gm-Gg: AYBFou0yXzYaUpYs/rao/aJhxx5yRn3hFsjsw7WUNDKJgT6u54INmmWwX0P1eE9c9/E
	QS1X94jR6t401+5vQJ/HGaLovA9nYt0QFWDFfoXLXTY7EEKM4He27ajExNryz0UMwyVOyYEbTUT
	4k9rz1xxaieNSl/Lq7J/zew37F1Ib7T6h2+jfxKMSL2LZSty3OpHSnQMQ6x/ZABNVNqg3JwFf8G
	2bl3NKXUvq/TIaF6YzZHPGKv0amuE4vzXsHgHcdBmlSXUJr0ilPTHEO7qnU13tKykznFEOzT55c
	gU71rtphXFf1ZNINcrwhsW1oUjKu3Sh0ZCWxvt7HYFF9HNGkxagda7SduIi1yDeyKWltDqGErir
	xuXTXjNS5N+HmN+rwQV4=
X-Received: by 2002:a05:620a:28c5:b0:940:ef15:1c99 with SMTP id af79cd13be357-94421735a1amr1949198485a.72.1793655013720;
        Mon, 02 Nov 2026 13:30:13 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9442582a2cfsm96565385a.15.2026.11.02.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:30:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A8B1540017;
	Mon,  2 Nov 2026 14:30:12 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 9BECCDC0CB7; Mon,  2 Nov 2026 14:30:12 -0700 (MST)
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
	Aviad Yehezkel <aviadye@mellanox.com>,
	Boris Pismenny <borisp@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/2] tls: only install push_pending_record for a TX context
Date: Mon,  2 Nov 2026 14:30:06 -0700
Message-ID: <20261102213011.4191020-1-rjethwani@purestorage.com>
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

