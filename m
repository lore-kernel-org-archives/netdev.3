Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794165216;
	b=k7PSHOtTqoYbw2icVBToWYFIwkgSNdoK2O4fdPNF9nExdMxqQ8lwNtlh4yeXeDw90yFz
	 +QhYvTABD2fKmCvXb3QyjI13v61a9ROyGIVpbbp3W9RsnOvko9Y0uRaLKviZS+bi+FJWF
	 Io6AabvDgG6LnMYQko4kY0fOouz6nDcYUFLwRo5dkm02qXG2kfkeBUGmWv4aqz9CLpsqF
	 fq+svR80LaFx+XhLD/ddlPkmmT+UdBsCI/yvo9xe5XKVU1yNd9Tk9wgQZDYugEjzVGx3T
	 Ch7ZSbYJfjm8ZAbudGblPj58T3+AM3VDMUIUQMYxFJvTw8XwVaN8M+5+sFuRgrgV95w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bTj9qoNHQi5OZQim48gnEjYI7Uzi+s/92LtGxJlXzy4=;
	b=5USGosnB3rYkNrCGNL+veUQus6G9o/zXfuura160BfgFzt8PbXvnCNrlnvH/nfNjiEuj
	 GvWUE8VbbUH3WO6FR0+KdZnwFhhxT36lRhqFBVnHyI11VbsIiXSItECOdI61L6/wT9nV1
	 /cR3SevbXZMus5sH3qoskfJmM3tngl4hVeURdiFoQdICilvBN5N++V9aAvGsnzjA/vcHl
	 NrbAq4GENBh1c1Pgbz5GWxkzr7RddeHVon19iRHde3SRrH2zwYACv5C5a1MsHXOprFsBN
	 SkTDQqe0Hjtgs+V4ekFPWHjUTDzJD+9u1vyF5y0ZoTO515I/UJFktsEm3PINakkVJOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSA8zJmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA68606A31C;
	Sun,  8 Nov 2026 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSA8zJmJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794165215;
	b=E8Dwtr3nBSm6YhWzTWNRDLpqskySRQMG2Qy/fAFIpAkeMOIJdIpQWfH11I+/DlKyZF6v
	 qWOk6tBbavDZZp0M7ph+dAN2mTNRXjcK9M1GKmgp9g2PmEbAVBBlrbiUBJQ/5sUMzFM4P
	 HLSrpUDMllCFZzE49ATJBPAEW1TQh/4XP3gcNJO4npddyI9vEsIaq0vqg8iYIK1ujlE87
	 28VMaghnFRsfnKaWw2QsLzL2wG9PMpVEOPKllXoIbKTt5aNbEMbsW5AWV9rZlaUXwU0Df
	 X12QZ0qUzTYBJENNtZaiBA4CPatG9eiiKv6449fy6l6mppIV4r6eIXSKYRh+x4SC6nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794165215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bTj9qoNHQi5OZQim48gnEjYI7Uzi+s/92LtGxJlXzy4=;
	b=rgPtjiAYbVd6Vni+rjZBOSexpV1a1klY4+GG4zYGJWVW2s/enemCCyXyhQH+dFdum5JU
	 8JWRWkvfnejZFY7d3Kb4ONDKPJHiB8njvUc53ghqnEjPKXYmNgHerxWTFZ4YQy3SWEUAK
	 IQsTV/qU1RVFMIHCzc9olmjWe9oUcsD2MuDNhAJepn2MGAisvV5eVeDQC/Ies/JlEb6eO
	 fXjlbol32rLx18jEEr7ORKl/BOnt9xyPaArFd2iz7yF/xUtXRPdN/iZI1EP6HjqJx2w9C
	 kMQlZz0/99XAtPkc9OdNX3/LodPYw5t1pOyvxZBQvgNz5II8+aIzqHq/1zM05NtRc6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60DFB1F008A1;
	Sun,  8 Nov 2026 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165215;
	bh=bTj9qoNHQi5OZQim48gnEjYI7Uzi+s/92LtGxJlXzy4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=eSA8zJmJyRR3ogmrVAzD7TZ2s9uc/6Gvz/0ZjAN/nF9QThrooB0in6OerWHhwJAQ+
	 RbjIpTSPdp5rzx9tm0FojN6dU5fpadBSXmt4fwoOK6cwijp/xtWhE3uABXrc1nkEPb
	 qQHeY9FsH/SbfwYlMtdiC/+r9BNUK43Z6WMjIC9+An692rQateaFVM0FzG0SRzhrFm
	 Fgb82HsyUwIdQ2N2Ch3knlRstp90UcBhx9Llqzb6y7tY2RhdUXftVftqJnmD8YqbmS
	 +VlFAGWnIxvLkLqzisReQpjbgi7svcq04Hg8wmd77a51n7GKdA0TU357sRaEBo8h75
	 CAfs1bBHw3x5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B24F948019;
	Sun,  8 Nov 2026 19:13:34 +0000 (UTC)
From: Ofri Zangi via B4 Relay <devnull+ofriz.xsightlabs.com@kernel.org>
Date: Sun, 08 Nov 2026 21:12:57 +0200
Subject: [PATCH net] tls: fix async encryption race on weakly ordered
 architectures
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-tls-async-tx-ordering-v1-1-f9a1844ca88e@xsightlabs.com>
X-B4-Tracking: v=1; b=H4sIALjJ8GoC/x3MQQqDQAxA0atI1g1MBlukVxEXOok2ILFMhqKId
 3fo8i/eP8Elqzi8mxOy/NR1sxr0aCB9RlsElWtDDPFFFJ5YVsfRD0tYdtwyV24LdhIDTUycWoZ
 qv1lm3f/fHkwKDNd1A46LG0lsAAAA
X-Change-ID: 20261105-tls-async-tx-ordering-8e201bd1dc4d
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Vakul Garg <vakul.garg@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guy Tzalik <guyt@xsightlabs.com>, Ofri Zangi <ofriz@xsightlabs.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794165214; l=2872;
 i=ofriz@xsightlabs.com; s=20261105; h=from:subject:message-id;
 bh=hcXcF7sxE609mzlFBuSNX0rkVPXJlsc5tyQKGD8S0wc=;
 b=ayXzZfMgnuQMW3NnzjfQ5jTuEsBo7LYME27Rl3fx9x5JicPgVp/2/Lcb6BPAx2gMQvgS9GPAl
 2if/wONP5OODANNDt9nhRj3LWCaLg6RD9RMYDR2v2aGnFdPV8kZLLtu
X-Developer-Key: i=ofriz@xsightlabs.com; a=ed25519;
 pk=pD06etcYUBGIxIDkICg6n7JJNuijXIPti5DrRX4CxuQ=
X-Endpoint-Received: by B4 Relay for ofriz@xsightlabs.com/20261105 with
 auth_id=1416
X-Original-From: Ofri Zangi <ofriz@xsightlabs.com>
Reply-To: ofriz@xsightlabs.com
Content-Transfer-Encoding: 7bit

From: Ofri Zangi <ofriz@xsightlabs.com>

With async encryption, a record can be transmitted without its TLS
header on weakly ordered architectures such as arm64, because the
consumer may observe rec->tx_ready set while still seeing the old
scatterlist entry.

tls_encrypt_done() restores the TLS header in the scatterlist entry
(sge->offset -= prot->prepend_size, sge->length += prot->prepend_size)
and then publishes the record with smp_store_mb(rec->tx_ready, true).
On another CPU, tls_tx_records() checks rec->tx_ready with READ_ONCE()
and then reads the entry in tls_push_sg().

Nothing orders these accesses. The barrier in smp_store_mb() comes
after the tx_ready store, so it does not order the earlier scatterlist
update before it. On the reader side, READ_ONCE() does not order the
later loads of sge->offset and sge->length. The reader can therefore
see tx_ready set together with the old offset and length, and pushes
the record without its header.

Publish tx_ready with smp_store_release() in tls_encrypt_done() and read
it with smp_load_acquire() in tls_tx_records(), so that observing
tx_ready guarantees the restored scatterlist entry is visible. Keep the
full barrier that smp_store_mb() provided as an explicit smp_mb(), as
it is still needed to order the tx_ready store before the tx_list head
check.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Ofri Zangi <ofriz@xsightlabs.com>
---
 net/tls/tls_sw.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..c9d3b9eb22be 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -436,7 +436,8 @@ int tls_tx_records(struct sock *sk, int flags)
 
 	/* Tx all ready records */
 	list_for_each_entry_safe(rec, tmp, &ctx->tx_list, list) {
-		if (READ_ONCE(rec->tx_ready)) {
+		/* Pairs with smp_store_release() in tls_encrypt_done() */
+		if (smp_load_acquire(&rec->tx_ready)) {
 			if (flags == -1)
 				tx_flags = rec->tx_flags;
 			else
@@ -504,8 +505,14 @@ static void tls_encrypt_done(void *data, int err)
 	if (rec) {
 		struct tls_rec *first_rec;
 
-		/* Mark the record as ready for transmission */
-		smp_store_mb(rec->tx_ready, true);
+		/* Mark the record as ready for transmission. Pairs with
+		 * smp_load_acquire() in tls_tx_records(): the sge
+		 * offset/length update above must be visible before tx_ready.
+		 */
+		smp_store_release(&rec->tx_ready, true);
+
+		/* Order the tx_ready store before the tx_list head check */
+		smp_mb();
 
 		/* If received record is at head of tx_list, schedule tx */
 		first_rec = list_first_entry(&ctx->tx_list,

---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261105-tls-async-tx-ordering-8e201bd1dc4d

Best regards,
-- 
Ofri Zangi <ofriz@xsightlabs.com>


