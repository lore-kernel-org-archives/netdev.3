Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE013B71CB
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394864; cv=none; b=rhn+x97gzE0gn1E12A62w+NpxFUsZ7Sr/KyxE/DONvwxJoVvmuBpXxOoYZDXVqlDFQhbL6rZ6ASzoiscHRisod7DDPC53eGa7OF/idV8NN5/f0vv5sG/i+wGDY0lXtNNLCv/bk3hJF26oqW4KbBQCmPA1l/Y69uludhATT1nXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394864; c=relaxed/simple;
	bh=eKp6r98ojxh8s9legEhSzCBjgDqizpUpBuH1vlYM1qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYUKxwHnH6d/rrjCd+sCl/V7WLHoj3lV4Tl2Nm0zS/eEnMAr3jiRqwxmCuSF3PdsSzMA5QbiofZ11DemU8EbvR6BBO7L4eE2HK/vMp8H29WeRjmf8yu8PBh2AQdaMArBKpK78XHAqbzwVKOaXp6yR6jBPN1IphfzrR/fYMCcVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lerACfMZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lerACfMZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d02b4c3601so14034655ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785394860; x=1785999660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHi/2ZYHMeqRQXbaVsSIIrgLqCO53DrLiWM7cu1qGAI=;
        b=lerACfMZkczxQjFCMqXEXim+gYHa71NllSzp5yw+NMPolfYcJWpk6Zfb0+pPbtpsP6
         FN/xDihxozlJaV3Nu6FgwwsHeTnI+5NDt98EAmOwOFgUzz08rkoceE+ilPd+dfcgWCbJ
         IIuHlHVQ/wOBy3Q0ic5nx0RiK3JhmLMaQb8xVJsgY6YLWWr98He2OgsU0YIbFEKjstVh
         pY+Z+JBHI0w9OsgWAKVqyJGkpSNsNiQZg4qZ2aoVih5juijamHlk3nMxWh5AU1CP/Hjl
         8PnykM3w80WJm/ZiBrSxqJy16DueQtM7ncM/tcfBJkqsb2Opgp0m9aDJJCvX8EXfFwS/
         L1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394860; x=1785999660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHi/2ZYHMeqRQXbaVsSIIrgLqCO53DrLiWM7cu1qGAI=;
        b=nZrF39wrupLdDHxp6VtM6t6HA3ZtF9gZLDxewhszUVQqDVn/nKlrvwfBl4YFN/W0fy
         CNqVfa3GW3yPXutPcMkWu/VSX3Hkdtih42Fp50J17ywMczKPCNrRO6xgcx0cXP8msHs6
         RqiycpAN44PdGKiyMjM28IL2t2anxbXKeV9I9wvz/c7R9jKbTTDPQrmYG7oFZ0i5Niii
         q1DsdUHy7XJwVJ3fFqBQZbKr8RNTh47ezN/pCng7Z4qHuIGlXzCMwYoFCec9b7fU4B5U
         Ka/CbhUbx7yulewPiN15UOrFtZ+3ONy0TlGPXgi453PQGMsHYq9Ih7j2khdkcfXdpvKD
         rGxQ==
X-Gm-Message-State: AOJu0YyF4vNISN4TXEkLkWbPR+IJKtdFNx/fgJ8G7EkfMJCbmT0Sru7M
	y6NEFH5+lVTfIpUJZLmDkFtzuy0l4WZ0B0o6UUfqUlEftwaPK7WeKs6h6sgloa9aLuII+Gv32z2
	Zb4ULIfeR
X-Gm-Gg: AR+sD11psrs25LdNeYoqJeKO7GhkD3yvnR706PfwLsixIqPxeq77rm9+XqEEIpkm99R
	BWclY2qq3/DtQ/VZizBePj4/D8BHIpUrfRx5F2JF0ndji71RC+TpGTExwEwJM6bA6HVTBZaCQ0V
	eeCYpKLMlU8ulQEmP6P5G7Qyv+/Qq9LWnft39GSgb0xrTYMIQD/XRa8hVvBYZTobAr2JIwuUalS
	XdgEVCu7T81qnddvXYEeUR90AcOFMPsMUP9UI3sUXCLAYq6cDyNoTg/amfDXf8Dn+WqNeLQCkJ6
	s8vv66pMqGcj0xu3c1IO58jpo5kFG3AxVUH35G9Lx4bIl0wfssma6BOEeDi/CQte9Uyt9rrbD84
	saWYUf0ryJio6WCzJtdOVOwtIv+U1mMnEgYXHhyg/INkF5egXE7HuNVuIDXGeMIZCV08Cn5hVW6
	F16gavunqtrQf94CGyFeNd11XeSZ4vhOrwj69l2eK53iwv05++/UGykKHeOAwr1t8+CG09vII=
X-Received: by 2002:a17:902:e783:b0:2cf:32bc:9722 with SMTP id d9443c01a7336-2d035cfc883mr15907775ad.34.1785394860157;
        Thu, 30 Jul 2026 00:01:00 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a154ebsm21456755ad.14.2026.07.30.00.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:00:59 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] llc: fix listener child socket leaks
Date: Thu, 30 Jul 2026 07:00:22 +0000
Message-ID: <0816efdb7d7ddf5ae74bd2dc90f62f69e9b39e02.1785386749.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785386749.git.zihanx@nebusec.ai>
References: <cover.1785386749.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_handler() creates a child socket before the passive-open path
finishes publishing it to accept(). Two listener-side paths can leave
that child behind.

First, non-SABME frames could still allocate an incoming child even
though only SABME is a valid passive-open request. Those frames never
publish the child to accept() and leak the child socket and its device
reference.

Second, even for a valid SABME request, the child is created before the
connection state machine reaches LLC_CONN_PRIM. If the SABME setup path
fails first, or if a listener-owned SABME skb is dropped before the
current tree can process it, that unpublished child can remain linked
in the SAP tables with its held device reference while it is still
invisible to accept().

Only create an incoming child for SABME commands. For non-SABME
listener traffic, send stateless DM responses for DISC and command
frames with P=1, and drop all other frames without entering the
listener connection state machine. For listener-owned SABME traffic, do
not create the child before backlog enqueue, so backlog-side drops in
the current tree cannot strand an unpublished child. If direct SABME
processing then fails before publication, roll that child back out of
the SAP and release its device reference.

This closes both leak paths while preserving the existing passive-open
flow for successful SABME connections.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/llc/llc_conn.c | 90 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 9 deletions(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50..421f0d993 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -771,10 +771,55 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	return newsk;
 }
 
+static struct sock *llc_create_incoming_sock_from_skb(struct sock *sk,
+						      struct sk_buff *skb)
+{
+	struct llc_addr saddr, daddr;
+
+	llc_pdu_decode_sa(skb, saddr.mac);
+	llc_pdu_decode_ssap(skb, &saddr.lsap);
+	llc_pdu_decode_da(skb, daddr.mac);
+	llc_pdu_decode_dsap(skb, &daddr.lsap);
+
+	return llc_create_incoming_sock(sk, skb->dev, &saddr, &daddr);
+}
+
+static void llc_release_incoming_sock(struct sock *sk)
+{
+	struct llc_sock *llc = llc_sk(sk);
+
+	llc_sap_remove_socket(llc->sap, sk);
+	dev_put(llc->dev);
+	sock_orphan(sk);
+	llc_sk_free(sk);
+}
+
+static void llc_conn_send_dm_rsp(struct llc_sap *sap, struct sk_buff *skb,
+				 struct llc_addr *saddr, u8 f_bit)
+{
+	struct sk_buff *nskb;
+	int rc;
+
+	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, 0);
+	if (!nskb)
+		return;
+
+	llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
+			    saddr->lsap, LLC_PDU_RSP);
+	llc_pdu_init_as_dm_rsp(nskb, f_bit);
+	rc = llc_mac_hdr_init(nskb, skb->dev->dev_addr, saddr->mac);
+	if (unlikely(rc))
+		kfree_skb(nskb);
+	else
+		dev_queue_xmit(nskb);
+}
+
 void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_addr saddr, daddr;
+	struct sock *newsk = NULL;
 	struct sock *sk;
+	int rc;
 
 	llc_pdu_decode_sa(skb, saddr.mac);
 	llc_pdu_decode_ssap(skb, &saddr.lsap);
@@ -795,11 +840,24 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * in the newly created struct sock private area. -acme
 	 */
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
-		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
-							      &saddr, &daddr);
-		if (!newsk)
+		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
+			if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
+				u8 f_bit;
+
+				llc_pdu_decode_pf_bit(skb, &f_bit);
+				llc_conn_send_dm_rsp(sap, skb, &saddr, f_bit);
+			} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk,
+								       skb)) {
+				llc_conn_send_dm_rsp(sap, skb, &saddr, 1);
+			}
 			goto drop_unlock;
-		skb_set_owner_r(skb, newsk);
+		} else if (!sock_owned_by_user(sk)) {
+			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
+							 &daddr);
+			if (!newsk)
+				goto drop_unlock;
+			skb_set_owner_r(skb, newsk);
+		}
 	} else {
 		/*
 		 * Can't be skb_set_owner_r, this will be done at the
@@ -813,9 +871,13 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 		skb->sk = sk;
 		skb->destructor = sock_efree;
 	}
-	if (!sock_owned_by_user(sk))
-		llc_conn_rcv(sk, skb);
-	else {
+	if (!sock_owned_by_user(sk)) {
+		rc = llc_conn_rcv(sk, skb);
+		if (unlikely(rc) && newsk) {
+			llc_release_incoming_sock(newsk);
+			goto out;
+		}
+	} else {
 		dprintk("%s: adding to backlog...\n", __func__);
 		llc_set_backlog_type(skb, LLC_PACKET);
 		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
@@ -852,12 +914,22 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = 0;
 	struct llc_sock *llc = llc_sk(sk);
+	struct sock *newsk = NULL;
 
 	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
-		if (likely(llc->state > 1)) /* not closed */
+		if (likely(llc->state > 1)) { /* not closed */
+			if (unlikely(sk->sk_state == TCP_LISTEN)) {
+				newsk = llc_create_incoming_sock_from_skb(sk, skb);
+				if (!newsk)
+					goto out_kfree_skb;
+				skb_set_owner_r(skb, newsk);
+			}
 			rc = llc_conn_rcv(sk, skb);
-		else
+			if (unlikely(rc) && newsk)
+				llc_release_incoming_sock(newsk);
+		} else {
 			goto out_kfree_skb;
+		}
 	} else if (llc_backlog_type(skb) == LLC_EVENT) {
 		/* timer expiration event */
 		if (likely(llc->state > 1))  /* not closed */
-- 
2.43.0

