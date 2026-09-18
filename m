Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29F4FECF9
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745398; cv=none; b=E6ZTXLmVYqiCQFSwZIHdBwzkpMTgN3vhFvZeEA8uACy0Di0C5UI/WlA1+DzqnsNJpSdpi90EQvQnitRaTXD2Bb5hR/Gad5LKYIWFaZ4boMz935P2Q6zK5kwQA94ouh4ihI8JtMdkuXc+atXzDcoJYOcBs1Olx5ejRXNVVklpC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745398; c=relaxed/simple;
	bh=XYsfo8o5Asadzmw159ufKmUqiSadcrJylPnfHJNeQts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKWFH8MhUTbpYmvmboWObovP7hf8d3HaL/4KX22R8/wluGLqPfXhCkS19hs6ziR4bcUt7Uf74/xJI6Ec42yQHlFzZvZkFya2gHfUZ3ETw/l+/zv/os9O38rtGsdrqvZfN/bFTpyBvNL4EU2Df4jkOwLKtlCnZXF3gKF7Hq1MDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Q5yjhc7o; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Q5yjhc7o"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so5907685e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745395; x=1790350195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9rB3tIRMtglcqN6pGjAHeHm2M9HV8sIVhRduA6yeaWI=;
        b=Q5yjhc7oUsyXPTrqW84L9uIBA5V21pkNXa9FYqbOIsGFcot21rNkwkN9ALukwMseQV
         6At4a/dTHvsN9mlv9gc/OFwn410xiv8K5Jmi4M4TksYnuolwCCGgIBGhtMHlQeV1orOm
         TTr+yyyflyScKZz7A0PMuj3aw9cLVyVob/y0ZUPLfujAFoohjAn64I9XD9441M4aAUvm
         iTJAVaxfv/C4et80oAqN3mb7lgSDC5RZMGDMGsQiFGVD/DwfGNPijgUBpfEBOVCevRtK
         vUpP4peCiwDDmXJXm51GL+a9YgrqFkxMd3pX1phInzOLZEMsOyWB9AeiBNayvqvGs4pt
         zZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745395; x=1790350195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9rB3tIRMtglcqN6pGjAHeHm2M9HV8sIVhRduA6yeaWI=;
        b=zv1NuZZccAVvrNWpO3jjSkdxWuEeyVaDZ/qGgrylHywrlv0yRtHFbWNawKxDL4yEal
         Z2X1wYKPFbB61l0YQqTy84+meRK5KK1uwyY5+597K5a0CTuBviYeOv1SqoI01OKSmkGN
         0yYxQb4jC6w1rhZSGsw0kbpzYB0wRMdVhkbRGIZQUxhv/7Qq71HSDDzQuQp4d9D6M+5o
         lTOq0Ewasof4kP/95SbzgKPOI0bLwBDaLDHZ+bzoc3nXSTOXnlaHMc+OQG8qxLPH1dL0
         ZoC63D41VP1tJ85yxFn28QTSOENxo5I2DMIjp+ZVfMFZmBvhRqe1EvtjVpgkgP6jSY6F
         s2+g==
X-Gm-Message-State: AFuF++ltID9GbEo7JczmO/MVrjNF/gPmEjVVUrPOxc9nJhZfKp3dmUBw
	QFdFzNgj8NxpEX3T2qnUH3L3ZwP+UNPCd030DXLJLVG7AvxqCwXmPdy04IGpjIKN6r4FQEnt+uj
	S536J
X-Gm-Gg: AYBFou1Y+QW0tkSmfcgmenccKWJuv6irD9rPZnmgOajT8wesGzVFlfIVo1j6M04Fqqu
	dkmspIVIwcnlHascX4IK5qagZIUe6XRm1THB6w52LAc+B+uuA5e56sDivpP/4EZgilnN7qqte76
	nQilMLEx7Ja438G4kPXAE7dp1YV1s196u1l5ZIzTBeSoKINpTMb75tlD6qcHeIrxbkknGDz01qq
	iw4uhnr7QDFqNFTSXWmmVlaDihKMxadm+ZKiBqdSGjzt5C8Mac2Us1VQ5Aphy02aw1jC3PyU6Io
	z64KwYYwnSrjJMMOotuYS/JAmAuQCXD3jd81ZPhLc+UIEkJ249IFgLHgBYWFyceEFqvI2g4vuwK
	Ovj5xu42Gl3rYwKTpgt1S7G7ei8wA4LflGiThmbwtIrYUXl1a2R2NMNi8/ZTIiLtyz1RJN1mtYm
	cetv/Y13g8J2VA/YXeZCBmT5S9K/B4DW+zPMSgvurf/3F18Wa5aNTHEOxqTCAowXROF2fD9TpCh
	VBW2xCHXCpgzd+SgoVJ3g==
X-Received: by 2002:a05:600c:5489:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49fc573579amr81100765e9.13.1789745394563;
        Fri, 18 Sep 2026 08:29:54 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd0822fbsm1041815e9.3.2026.09.18.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:54 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/9] net: bridge: factor out common flood completion handling
Date: Fri, 18 Sep 2026 18:29:42 +0300
Message-ID: <20260918152950.1938259-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the common flood completion handling shared by br_flood and
br_multicast_flood into a new helper - br_flood_finish. No functional
changes intended.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 65 ++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 46c762ca5177..31d54125b441 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -197,12 +197,33 @@ static struct net_bridge_port *maybe_deliver(
 	return p;
 }
 
+static void br_flood_finish(struct net_bridge_port *prev, struct sk_buff *skb,
+			    bool local_rcv, bool local_orig)
+{
+	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
+
+	if (IS_ERR_OR_NULL(prev)) {
+		if (IS_ERR(prev)) {
+			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
+				 SKB_DROP_REASON_NOT_SPECIFIED;
+		}
+
+		if (!local_rcv)
+			kfree_skb_reason(skb, reason);
+		return;
+	}
+
+	if (local_rcv)
+		deliver_clone(prev, skb, local_orig);
+	else
+		__br_forward(prev, skb, local_orig);
+}
+
 /* called under rcu_read_lock */
 void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
 	      u16 vid)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
@@ -243,25 +264,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		}
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
-		if (IS_ERR(prev)) {
-			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
-				 SKB_DROP_REASON_NOT_SPECIFIED;
-			goto out;
-		}
+		if (IS_ERR(prev))
+			break;
 	}
 
-	if (!prev)
-		goto out;
-
-	if (local_rcv)
-		deliver_clone(prev, skb, local_orig);
-	else
-		__br_forward(prev, skb, local_orig);
-	return;
-
-out:
-	if (!local_rcv)
-		kfree_skb_reason(skb, reason);
+	br_flood_finish(prev, skb, local_rcv, local_orig);
 }
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -301,7 +308,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			struct net_bridge_mcast *brmctx,
 			bool local_rcv, bool local_orig)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
 	bool allow_mode_include = true;
@@ -343,11 +349,9 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		}
 
 		prev = maybe_deliver(prev, port, skb, local_orig);
-		if (IS_ERR(prev)) {
-			reason = PTR_ERR(prev) == -ENOMEM ? SKB_DROP_REASON_NOMEM :
-				 SKB_DROP_REASON_NOT_SPECIFIED;
-			goto out;
-		}
+		if (IS_ERR(prev))
+			break;
+
 delivered:
 		if ((unsigned long)lport >= (unsigned long)port)
 			p = rcu_dereference(p->next);
@@ -355,17 +359,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			rp = rcu_dereference(hlist_next_rcu(rp));
 	}
 
-	if (!prev)
-		goto out;
-
-	if (local_rcv)
-		deliver_clone(prev, skb, local_orig);
-	else
-		__br_forward(prev, skb, local_orig);
-	return;
-
-out:
-	if (!local_rcv)
-		kfree_skb_reason(skb, reason);
+	br_flood_finish(prev, skb, local_rcv, local_orig);
 }
 #endif
-- 
2.47.3

