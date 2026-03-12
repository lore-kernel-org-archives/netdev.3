Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B920375AD8;
	Thu, 12 Mar 2026 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280090; cv=none; b=gWNzyKxnMnKS0TxG+vb1vXCtLthuzq+nKF162MfH9diY03P4WXG2XLoEZucOGqYUO6Q37/hePCSQosBZmPU09J6X4Qq3H/5jm/jgijPznN0oabEgi0QA7YjmJg/R7iHON4PH4vmgNv0utdsWOvBbswH1nqyoiZyveslvyUOCcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280090; c=relaxed/simple;
	bh=+5c4ZZNdwnisPDb42RxZFHLu6gp5zd/Z5bg1csnIoSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXr7DDSV9S5QHlekVKAohU9VUmL/ujVS9vDUhS/zXzAQfacPSkSWdeRwFxbOznUwEsAaxFm+OFoMyLR9yiVY1pu7tcNxCQy1Gfr7cqrjrRfKZV00bXKudexSJvEX3KKJf6vdXk6i0BPBSin3gUQ5iSC5ppvIVLaE1kW44yoHKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuIMbX1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuIMbX1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D9EC19421;
	Thu, 12 Mar 2026 01:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280089;
	bh=+5c4ZZNdwnisPDb42RxZFHLu6gp5zd/Z5bg1csnIoSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuIMbX1JnYVFUx4sVjTL4dwj9DgkMfjtFVtN7UennTH66TQYt6lsVMRWnCd0bEH7G
	 8F/vdKKiM5Vtxx2d1e55hBqpeWn2MQ/vFTNJopCeYhRryAtTSAYsIhSY8ov4urWvyC
	 sqfWmE2QSLE32TkxB6O7pnsiGuS8MHLaJyWGy8eo78cI6ETGY+B0yqnpCv6uc39qUX
	 vOd51Ppu/7bX5W65k3LCTrRdJKYywQEnWJ37+FZacaqkldsE/RdFEL3SQIpxNYoMbp
	 5aaGmi6vnI15K3vRFqrQVPnYxu23sRKv+4TpLFw2jJSE0IHi0NRZ6NQ6x9T3UfGoGk
	 sjKZvYYQ/oIHQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/8] tls: Fix dangling skb pointer in tls_sw_read_sock()
Date: Wed, 11 Mar 2026 21:47:59 -0400
Message-ID: <20260312014804.5083-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312014804.5083-1-cel@kernel.org>
References: <20260312014804.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of its
lifetime; Annex J.2 classifies the use of such a value as undefined
behavior. In tls_sw_read_sock(), consume_skb(skb) in the
fully-consumed path frees the skb, but the "do { } while (skb)"
loop condition then evaluates that freed pointer. Although the
value is never dereferenced -- the loop either continues and
overwrites skb, or exits -- any future change that adds a
dereference between consume_skb() and the loop condition would
produce a silent use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 81e0e8aaa6f9..e5d0447cbba6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2373,7 +2373,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2422,10 +2422,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 				goto read_sock_requeue;
 		} else {
 			consume_skb(skb);
+			skb = NULL;
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);
-- 
2.52.0

