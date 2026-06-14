Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAA3932F2
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421942; cv=none; b=n4wdVl+5zU8fLnbHwIFomuo4ZLzZvNP7eYVKzm0iSQKi/hYJXYXGaV6NTH8b+IssJPZkGrpzC7xVe8n4zg1XH6EV0UBF81jrHDtZY2XVAEiDSnLBAFbMpacJE2NmJ0vX0JR/rmbqSZDFhqBp3e1/A6ytLOY2dU7VZFg/IcsqgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421942; c=relaxed/simple;
	bh=aJIHOSdzmDg+4k1s74yK7btcK/W38FhygFtMbMzRYEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMI7mxRu9tGyPWTr17C0BQh2MArI1G3eoRDvP6TW43xTHRkk2WGoBo1grD7UKW0u/4zvD0d3jtfr9EB0pbHPr5PLOWzE26HOcmKB2khRVloaGJ3c5MblxMtr3XqLP0OGt5BAhXPVu6+7XSkEyi5cHF8UdmwWxD46lUVkHBHStuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fVzfi4DY; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fVzfi4DY"
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-304d7f31215so2170557eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421940; x=1782026740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwzZFIxcbRJ+s5HDyZ0yU5a7I0wsgJseSsFu0xR3apw=;
        b=mRUCvaFZw15+FjMW8QBZRafPgb5rW1dPriE5YBBzYJzjdc8ZBaA1ulr1glAOKGUFeQ
         Ob6ZomSmP0xAuyqhT/S9a/0tvUx2maCocf2gD+MhoeXIlu1+wqahUUZuLOvQh+LhUBke
         wAwCsAxRVegM3kQYC6YZ1n/5d3edXciOnQRe8+4x1HPqAjEfDQFqpuvgzg4CTlPQpGq9
         UyuJAR5iD/Xz0/J6Xpw1185JMpxp2fxwQzUFpHzjQ6J5dhoR8h16yf5z0reri3wXoHVJ
         fMYmDW7Nzu25taBwjwK/XPLSsOji29egDXl8n7Vw4ywsdLtuCLHyG88FKmwlifvx8b8p
         TvEA==
X-Gm-Message-State: AOJu0Yy92HMSCJUzQdjRcsRsateTMI5qwzY8qcGUlHU51FWZ0dWUbWdO
	vOo8pw/Q8PpO6C6+HrM4oPECrbJY47lSPftz0x9orqFe4IV02MM25/12yZM2uojtlPKJ8qrtucd
	8aUxPBzR/emM5GaHwbT4KdYWjvI54oGSDPNmBFwhDw82T6OH5A+PhI+wzr19OYuNoSMD666t8tY
	AADhm+UW0RQXsQZG11ubsL5Y9koBbM1ywo0W8wBHxjNJqTMq/vR4NZ/qsl6AuSs7MlaRzIFLU0r
	4NEZFEFy6A=
X-Gm-Gg: Acq92OERnT8rMQvem9FJNZvTGwsuSq60xXSQ/QCMjimytGiVkdxXRHxWv42f3JEKz3V
	Va9Vv/772wpTIENloaY4vRW9ruqLxAC83c4PlXJfDF8sv2r4m+qbSEJmKx2uy66G2EQTrcTO72a
	NBMB8VUHW85Cr+VQij6plQgdJdFztiPyWdx0AsxD7Ft4myzv+0zbl5dIhjZVmcOjwm5wo9yu/n+
	gFi80PhdIDYA6B0niBdrpSrixHPiLgCZbkIPPKk0dxkPGD16DdJknBFOhd1QT98GLWc4i68GiXh
	9vZWnNujNLQpPNR00MHuD6KUi9lc1H+J6iOtE8CH4mOc7E7rqcPPg5ok13wCRT3odKrlwoCHaWr
	8BuDVFosVmFcf/nJ5oWWqZ3PtKCJU7aeq9S/a4aGcKSpNn9S/RWDh3rm/aUVrMJVudSV8XanXtG
	q1CXkvhIvw0EfHWHwCpMcw92uclWtiJA+LHP7pVRaII9+eYNLtMuk+KjULTzQ=
X-Received: by 2002:a05:7300:b905:b0:307:d4e7:b18b with SMTP id 5a478bee46e88-3082004bd24mr5302799eec.20.1781421940037;
        Sun, 14 Jun 2026 00:25:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3081e5ee91asm427575eec.10.2026.06.14.00.25.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30762d67a64so3344901eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421938; x=1782026738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwzZFIxcbRJ+s5HDyZ0yU5a7I0wsgJseSsFu0xR3apw=;
        b=fVzfi4DYKi2GjAOsl2/HHtkKwB/GnM41TVViJekgFABKrIGUvKXLhMd3uV913w0xAw
         CJ0E4Vym3bUYN2oXx4sJGqAu/2Q2WSwwiUkwMn8+CLT1CR7HOspW6ejfrBGuB2F31/Zg
         xOUlzR0ND4DPYZU7K/ApMaZH3tMcbnZJME0Ds=
X-Received: by 2002:a05:7300:6d22:b0:2f7:d419:dee0 with SMTP id 5a478bee46e88-3081ff3da2dmr5313555eec.6.1781421937820;
        Sun, 14 Jun 2026 00:25:37 -0700 (PDT)
X-Received: by 2002:a05:7300:6d22:b0:2f7:d419:dee0 with SMTP id 5a478bee46e88-3081ff3da2dmr5313546eec.6.1781421937193;
        Sun, 14 Jun 2026 00:25:37 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:36 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 14/15] bnxt_en: Add support for inline transmit BDs
Date: Sun, 14 Jun 2026 00:24:06 -0700
Message-ID: <20260614072407.2761092-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Newer chips (P5_PLUS) support inline transmit BDs that contain extra
data.  One such use case is to transmit out-of-sequence kTLS packets
with encryption enabled.  To account for these inline BDs during TX
completion, we add the inline_data_bds field to struct bnxt_sw_tx_bd
(tx_buf).  tx_buf->is_push will always be set when sending these
inline BDs as the operation is similar to push packets.  tx_buf->skb
will always be NULL as there is no associated SKB.

The next patch will make use of this feature.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3560ee5525fd..ce3175721be2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -848,7 +848,7 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		head_buf = tx_buf;
 		skb = tx_buf->skb;
 
-		if (unlikely(!skb)) {
+		if (unlikely(!skb && !tx_buf->is_push)) {
 			bnxt_sched_reset_txr(bp, txr, cons);
 			return rc;
 		}
@@ -860,13 +860,22 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		}
 
 		cons = NEXT_TX(cons);
-		tx_pkts++;
-		tx_bytes += skb->len;
+		if (skb) {
+			tx_pkts++;
+			tx_bytes += skb->len;
+		}
 		tx_buf->skb = NULL;
 		tx_buf->is_ts_pkt = 0;
 
 		if (tx_buf->is_push) {
 			tx_buf->is_push = 0;
+			cons += tx_buf->inline_data_bds;
+			tx_buf->inline_data_bds = 0;
+			if (!skb) {
+				/* presync BD */
+				cons = NEXT_TX(cons);
+				continue;
+			}
 			goto next_tx_int;
 		}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4ca36b99c4a3..500bb9171274 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -917,6 +917,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			is_sw_gso;
 	u8			action;
+	u8			inline_data_bds;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
-- 
2.51.0

