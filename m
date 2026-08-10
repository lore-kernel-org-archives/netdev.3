Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A3396B68
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338913; cv=none; b=F3EDb3rLMRvU33OTxhSnn0J4d5cXJRgYdZ3I4mGmSxyrdiPmtGx4oZbQBnWH/I3O2s07ojVBC5Hdfv0tirVIHw1ZWKnxtl6BtzeI6iELnbpICQ/JGKxkWp9K1o9/T/nnZokbVUJEGw9qf+XzTWvAk6rc1J+JGEXhP0v/jSDf+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338913; c=relaxed/simple;
	bh=m1wWcPdUUFWG/KAJBW2fAwwpNLtRD+32W0as5oAn/mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iokQKOLGKuAX7pTKAjgrEjeXjkqbGrfvwrBYm6AVdhzxK/ZhZWqwxU/H1DWFwm4OXS4xAIE/UoDgBNNdK3yU1jxy6JZkCkzJZh0aqwoE5dND4BmafVqVckrRGA7LlOpAg+QUxtsmzPV4lxt0aOpEaxH3+WPwdLuq57y9MisUBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GTBCIVi3; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GTBCIVi3"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1230583a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338911; x=1786943711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fp9M0AmmKiaMvZ5/l7dijlzxYcz8D1uRQyADxY6S5Rc=;
        b=X7vNrDTz6RkgByvN5d4QZ2Vt4U7Na7z5dZGRArg5X43Fap8m70+7OgElbO6orQNVPs
         O7mHlYpBP9GOCKK3zVInc1/qN4wKsv7ofmmuYkiHb7VOMFol37Ig6Y+/pYWzMMvvwgtW
         G+yUDjd5j5YaJMPrNGH8wlHne18UuLoJlTYfT++pG0DkJqzHClymJZaRQ8KvpifAgqLX
         vTfMVcBtqXGxi2fRks6QGnSegeiDVAoysjKQMzcxx+bMlK0VfbzNYW+uLZ6zuc8hhRNK
         4/hqVIQ7dCuIHhR3/7UAKWtO1Cq1Hry5T/8WPC0B+1H4ODCOsvnAGfQFHlB3ZHhqwmYZ
         jVJA==
X-Gm-Message-State: AOJu0Yz6hXvgV1I/OFoR3eYB7jRPWLT2qX8185LUqRrPZ/JyeMPF9lot
	DYzJXH+247IP2HNHyUdCxkuwraApV51F1HE4JDraxDl5wc9NymQWrOHQYn650iv4CGSUs8VhY6N
	IiibxWwlDRKlXlXyrywExNavRJOGMDHy46UbW8vXn6aT9iA6ClxYji06BzEzoKtDVtWTqYrKbH1
	9dk9LBtqmluqiP3jn6vvDnDxJL4LH6k1/YBo7SNd2eWbUa5vDc0Ln/I8RCTrdhp7LGNSPSvNS35
	kmdmofXoI8=
X-Gm-Gg: AR+sD102qcV6IoWm5wV29pxzIQS9R3UrZrKkU84OwV9XWeRVTtYw9rYIMOImiSNLsPl
	xi84nCjoRfYG9e1xzywN/ZQu7OWaxOze9N0+7SUwb3s3CLJkRfSGMFW3Be/laCP+sc6jPBqvgM0
	/hZkDLhWSQ5mcbVNSwEHRzubmu6ZwsnhvLeXU1fE5eu61pN0nkrM9V6/1GncgPNms+rhjNZHphQ
	NmkslphjsO/YHVK1zapSd1vDkSYnUc3Ifxrac9c08JeYmUJt1LerJ0cg/2QNGA/QiTsdDR5vlmB
	GQcwFagekNymGYBEr8sFZHGVKDDR9o3nWqX94xPymaBFTqwxfFJLOblvGfbKM2wuAPOklIqAc/9
	74G7navyqb4ABSxepWT90uN7resqHMJa/7IutQNDaQuIPWIoytfBVfWm6qmX08MIp2IZ3vgvCOc
	vwkb4HG6xNbUMWlft3N/7dZO3gt259U8fd+TE=
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3903c5c51cdmr41796854a91.17.1786338911445;
        Sun, 09 Aug 2026 22:15:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392825e7e96sm3961672a91.9.2026.08.09.22.15.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:15:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso13531251cf.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338910; x=1786943710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fp9M0AmmKiaMvZ5/l7dijlzxYcz8D1uRQyADxY6S5Rc=;
        b=GTBCIVi38CUD50RavhYoh1xchOqwfaBiPjNRKU++snDsbmo13Jqx00NV51OtsAY6uq
         E5CmyU/eHKj7pgP4gcRsO3sEKRyX6Y5bu60lo9uhjjh0J06J9yuSwwaHzbRlcrWv03qT
         p2bq7XydjWh7dhBUj0p6EHL22BRQ/bNqJ/r3s=
X-Received: by 2002:a05:622a:9008:b0:52d:f7d:804a with SMTP id d75a77b69052e-52d0f7d8697mr256762721cf.10.1786338910156;
        Sun, 09 Aug 2026 22:15:10 -0700 (PDT)
X-Received: by 2002:a05:622a:9008:b0:52d:f7d:804a with SMTP id d75a77b69052e-52d0f7d8697mr256762271cf.10.1786338909654;
        Sun, 09 Aug 2026 22:15:09 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:15:09 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v6 14/15] bnxt_en: Add support for inline transmit BDs
Date: Sun,  9 Aug 2026 22:13:57 -0700
Message-ID: <20260810051358.1244418-15-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
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
v6:
Clear is_push and inline_data_bds during TX ring free.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 ++++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 15b329ee878b..55f999dbe7ad 100644
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
 
@@ -3481,6 +3490,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 		skb = tx_buf->skb;
 		if (!skb) {
+			if (tx_buf->is_push) {
+				tx_buf->is_push = 0;
+				tx_buf->inline_data_bds = 0;
+			}
 			i++;
 			continue;
 		}
@@ -3489,6 +3502,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 		if (tx_buf->is_push) {
 			dev_kfree_skb(skb);
+			tx_buf->is_push = 0;
+			tx_buf->inline_data_bds = 0;
 			i += 2;
 			continue;
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5ff70623e849..e500178d5f80 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -918,6 +918,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_push;
 	u8			is_sw_gso;
 	u8			action;
+	u8			inline_data_bds;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
-- 
2.51.0

