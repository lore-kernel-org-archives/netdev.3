Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA13BAD9C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697074; cv=none; b=HKu+EZjsk2u+qscenZbJ0jp4G02RIaNse2FDg0sEbeuM2egnqBOGLEHVh0yNO7aPHfTw8YBZH4D2zkEv1F7wT3ny9xzzBxS5Rc3pC6lJ3ddOni5vQj3r0J5wu3l14RpxWlLz9uB1kFkpJwXlckVg5uEFbZH6D5Y6efcBkACnKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697074; c=relaxed/simple;
	bh=UkhzmiDRxOJm/KkY5kZc/kXeWdTV119sUKWsG2ZBJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvWqq5F1D06jTgIF0WC+0tMt/wgiFakl0PjauDYrkS3Zz0y3XXvib09uig+BOOPEZjilMuAZo3X9WY63Twd4oWRUQKWqAVnIryBt9Z1UzE9f8JxlUKmn2X+XwL+Q12cWT06Uj0c8COAwWAr8Qoc3fqFMkppHo819obVU8R5vScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jELWBBhT; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jELWBBhT"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef3so174582a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789697065; x=1790301865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+ZmYKPJxwk4ppbLxhtM923pOwtZYQbBQl5io1pIn2g=;
        b=jELWBBhTNaYxjuEQzafD4ICzvqECtnk5UIDQH4e1cHpg3oae9s1iqZ8TW3gIlQeRkH
         JPLeYQQAzw6p5K3xcxHKhGxI1JBzfTD5mkOCI+GwtmoQihOTk3EXvqgcsRo0IZ8cEf/K
         KbeZ47H/kfeGbIDYE1AKVB2X/Q69zqb9+zCX2a02ISI40CVB+Cv+rKTPWCi5EVXimJLX
         +kNn1HGluS83//RngeWft3BO0fbPU/WIAanciH7s5cAVGMypvmc8lJashoE3Xxulttqq
         7NLhop9JRcVxHrI0yqEOjRXgqIrBFLLn0efVA8Dlxrz3OqeY+h6zHkAp+8H5K0+O/E4F
         RRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789697065; x=1790301865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+ZmYKPJxwk4ppbLxhtM923pOwtZYQbBQl5io1pIn2g=;
        b=pHnYNAQYxrzkMlOuKlJaIt9dO3ETwg7vUFYl9uQUfdLqAo8twdhYV+jLa9mgJWO2lg
         iFLjfhG4yHQZ5gacNuFeDKakucSmqs/dpntK/wBVvPpA8y03lUdTmBeT1zYF80WQhMPA
         mYbHSM+wyhwsCA7nyPm5IqCvFlKJj6TCQBp2JF91YYyD5jBS9SS2NM90tM3aQfu0c8pN
         OoWysSbXM6Q/cYGHNb+28kCMXRiUwrs3v0+/FoBjEj8CO7pGCj48RkcupCOmtD0R5hbO
         pAMm7OPadzAE3IKCiqgfTVG+4sy/k0h5+x9E1IIX/WsH1XqVzpEpUqjV9KMbwBwMxcb2
         KW4g==
X-Forwarded-Encrypted: i=1; AKwUvBwR3v9NITuFYU7eUdmZn6kps8+0EkeTUVHoxtkoGJlflU81tE3ZQwgeZssghx0+Q08t5Qr9HUI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFjEVFk7986q38LmZOa6/8dfqFtj3CLHAeneDPXon32DCvzcQW
	rGSLbKMa4kWV+X0676KXU3Fs40kPueVwXZVgKsT1l9tvH6mUTucPH8q+
X-Gm-Gg: AYBFou2ezsU1rFGPJQV7WvKxzIn2DO1OH/1bbke3h6rceZeFK43UszBzTjyflSbaaJz
	XT56fXHd6YC8ya67I70RiXYinlhRoaCisHb1agQjWOtrfkNZuLtCLOt4FFr3cd1Zh9h668Rsc9+
	GxcKJLP5lhxLRtdzRxH69XLbxF7xOZsyO5F+NJPJ1Ak18uxUGZ5sRZu9z+lEGp7CI48pgvCXcnc
	TNUiLkzgS6UFuwKqGBhqFkdZ2Jnbx1HYDKJ9Pz7S5Iv7OCv+xtIv/cSdPkLKK87MG5S7+sHvpW5
	NeiPhUcA2TBFNAmEO9OypJLU3Emn5em0Y6su3VLsCRJ0GyLSIGPUf3eeMSm8sT7WZpb6MZKi79B
	RwWBLmGKXF6irddQGXKOFs3wGmcnZN0IAs1QafzdzTiM3gOHy5mxKxGjFkyOYl/CZHyAtnJAX2/
	z5Eh4mJ3BU8QVReKkRkkc9KZRqCQ1XuAU1Aki6kzOqcDY2JNUWjFczNg/mgYJ0ZYZcfe2RpVWD3
	7sYn1bXsdWMyrquMhQQVvW8PiUfZsZkrLlauSI=
X-Received: by 2002:a05:6a20:c989:b0:3dd:85aa:4532 with SMTP id adf61e73a8af0-3dd8c5eaf0emr1932234637.36.1789697064675;
        Thu, 17 Sep 2026 19:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79ca:7a54:4576:24ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2890b915sm136049eec.30.2026.09.17.19.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:04:24 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Christophe Ricard <christophe.ricard@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] nfc: nci: do not process unexpected or invalid CORE_CONN_CREATE_RSP
Date: Fri, 18 Sep 2026 10:04:12 +0800
Message-ID: <20260918020412.82878-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918020412.82878-1-ndaugoing@gmail.com>
References: <20260918020412.82878-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

When an NCI_OP_CORE_CONN_CREATE_RSP packet is received,
nci_core_conn_create_rsp_packet() parses it and creates a logical
connection entry in ndev->conn_info_list.

However, nci_core_conn_create_rsp_packet() suffers from several issues:
1. It does not verify that a connection creation command is currently
   pending. An unsolicited or delayed CORE_CONN_CREATE_RSP packet
   unconditionally creates a rogue connection and calls
   nci_req_complete(), prematurely completing unrelated in-flight
   requests.
2. It lacks bounds checking against sizeof(struct nci_core_conn_create_rsp)
   for the packet payload, leading to potential out-of-bounds reads.
3. It does not validate rsp->conn_id. Dynamic logical connections
   assigned by the NFCC must not use NCI_STATIC_RF_CONN_ID (0x00) or
   collide with any existing connection ID.
4. It inserts the new connection at the head of ndev->conn_info_list
   via list_add(). Because connection lookup (e.g. in nci_tx_work() and
   nci_data_exchange_complete()) uses first-match semantics, prepending
   allows a newly created connection with a duplicate ID to shadow the
   static RF connection or earlier connections.
   Furthermore, ndev->hci_dev->conn_info is mistakenly updated even
   when the destination type is not NCI_DESTINATION_NFCEE because
   cur_params.id and nfcee_id both default to 0.

Fix this by:
- Adding an NCI_CONN_CREATE_PENDING flag in enum nci_flag to track
  in-flight connection creation commands, and rejecting unsolicited or
  delayed responses.
- Adding packet length verification before reading payload fields.
- Rejecting responses that allocate NCI_STATIC_RF_CONN_ID or duplicate
  existing connection IDs.
- Appending new connections with list_add_tail() instead of list_add().
- Restricting ndev->hci_dev->conn_info assignment to NFCEE destination
  types.

Fixes: 736bb9577407 ("NFC: nci: Support logical connections management")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  2 ++
 net/nfc/nci/rsp.c          | 37 ++++++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..a4652ffc173d 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -31,6 +31,7 @@ enum nci_flag {
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
 	NCI_UNREG,
+	NCI_CONN_CREATE_PENDING,
 };
 
 /* NCI device states */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..b5fa17f0524e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
 	}
 
 	ndev->req_status = ndev->req_result = 0;
+	clear_bit(NCI_CONN_CREATE_PENDING, &ndev->flags);
 
 	return rc;
 }
@@ -709,6 +710,7 @@ static void nci_core_conn_create_req(struct nci_dev *ndev, const void *opt)
 {
 	const struct core_conn_create_data *data = opt;
 
+	set_bit(NCI_CONN_CREATE_PENDING, &ndev->flags);
 	nci_send_cmd(ndev, NCI_OP_CORE_CONN_CREATE_CMD, data->length, data->cmd);
 }
 
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..a56a7392ab5e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -305,15 +305,37 @@ static void nci_nfcee_mode_set_rsp_packet(struct nci_dev *ndev,
 static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
-	__u8 status = skb->data[0];
 	struct nci_conn_info *conn_info = NULL;
 	const struct nci_core_conn_create_rsp *rsp;
+	__u8 status;
+
+	if (skb->len < 1)
+		return;
 
+	status = skb->data[0];
 	pr_debug("status 0x%x\n", status);
 
+	if (!test_and_clear_bit(NCI_CONN_CREATE_PENDING, &ndev->flags)) {
+		pr_warn_ratelimited("unexpected CORE_CONN_CREATE_RSP\n");
+		return;
+	}
+
 	if (status == NCI_STATUS_OK) {
+		if (skb->len < sizeof(*rsp)) {
+			status = NCI_STATUS_SYNTAX_ERROR;
+			goto exit;
+		}
+
 		rsp = (struct nci_core_conn_create_rsp *)skb->data;
 
+		if (rsp->conn_id == NCI_STATIC_RF_CONN_ID ||
+		    nci_get_conn_info_by_conn_id(ndev, rsp->conn_id)) {
+			pr_warn_ratelimited("invalid or duplicate conn_id 0x%x\n",
+					    rsp->conn_id);
+			status = NCI_STATUS_REJECTED;
+			goto exit;
+		}
+
 		conn_info = devm_kzalloc(&ndev->nfc_dev->dev,
 					 sizeof(*conn_info), GFP_KERNEL);
 		if (!conn_info) {
@@ -339,21 +361,22 @@ static void nci_core_conn_create_rsp_packet(struct nci_dev *ndev,
 		 */
 
 		INIT_LIST_HEAD(&conn_info->list);
-		list_add(&conn_info->list, &ndev->conn_info_list);
+		list_add_tail(&conn_info->list, &ndev->conn_info_list);
 
-		if (ndev->cur_params.id == ndev->hci_dev->nfcee_id)
+		if (conn_info->dest_type == NCI_DESTINATION_NFCEE &&
+		    ndev->cur_params.id == ndev->hci_dev->nfcee_id)
 			ndev->hci_dev->conn_info = conn_info;
 
-		conn_info->conn_id = rsp->conn_id;
 		conn_info->max_pkt_payload_len = rsp->max_ctrl_pkt_payload_len;
 		atomic_set(&conn_info->credits_cnt, rsp->credits_cnt);
 	}
 
+	nci_req_complete(ndev, status);
+	return;
+
 free_conn_info:
-	if (status == NCI_STATUS_REJECTED)
-		devm_kfree(&ndev->nfc_dev->dev, conn_info);
+	devm_kfree(&ndev->nfc_dev->dev, conn_info);
 exit:
-
 	nci_req_complete(ndev, status);
 }
 
-- 
2.53.0

