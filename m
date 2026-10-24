Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792811044;
	b=ury3xtBaB9KzYo4icaFKjTZV8/5fa8t2IsmMsQ3C+tn8n2dJ5VZdMtgL1J7yAGFEnHXF
	 y1eqUaqxbi+vSPW0mfzMebkSI67v4FxeUugQ5ZGSJfqMmOYvG5MDHdwV+6vYrlYLGzXad
	 9AUt6AeK591Im7BudkB/cPcYw6zIQ53B8FL7buANVpsZOs36hyKkTs6Ponk5tagPZROSE
	 SgIPI+VtyTCs8uR0eza7OR3lPjHyoy54zWgP/VTTNiezgVFVHEQXMOHPOF7uP7/fRl3V4
	 dq3/MZLTxXtdP74Ysxmr22qtItpTgge0hFvRZtZOUPFcVEpP+Qu1fXuvNZhxsacH9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792811044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Hs4kepycTRBAy17QyXDZeRCyHZAEsRiAGe7625jFRXk=;
	b=n0FQ/oetX17Yg2TusH7dCOO8smakCk33IxF0E7jBZz9lrxC3bl6Wtz9/azohrnpMw3cX
	 gIas89q+8Pl397roRcL5GUkPtCznzE732ilFxCX0etRe4ybHwGWyhcNeJZXBGl7wLyWMN
	 zSEwai5tJpHngk51KLO6O8UAmQshAZZARPk2xuC3sjrZzJehd7NKoO1yQSeLAtR8ZLun3
	 sMFS4BccuQeolXqTtyKyONo5uEGeNlTFbCeyYi04B7TMNhAiiKmvDMxhBeNWg/4oCmOph
	 zKlnmZsNhnnQbU3v1rwKklJcpgd+wDmOWvjUoOqQiZtj41gps9g0nyS95pSfLA4M+8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=f5TcGnJD;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277E606A31F
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 03:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A277E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=f5TcGnJD
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3662e7a9299so6409424eec.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792811043; x=1793415843; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hs4kepycTRBAy17QyXDZeRCyHZAEsRiAGe7625jFRXk=;
        b=f5TcGnJD5/0A13Dz23oyZjpdqIzw9RLj99NWY/iNJZ19+LhciMcWqq37S1Pww8zF28
         65In6iR3dSE7FMunQ6H5/pBzL2g51Xp0z/zI4+/xqOBOWH41UcqszUhsOWSy1dyD1fs3
         GV9xGGQqJAQW90pM3UAlhf1SeyhpeVCgfr7vJoCkk3YrZj4xMm8clOMXkWBjrrJRyjfV
         MyO3RGe8puxLgvr3hJugzg79d4eo4MYiqSoQUIM0b6ar9IFWXXMEnqzeNpfrtyrB3kur
         YF9jEeB9jk5Y2+QEhYp0ee1lxmdBREUJjOIwAyp0xKn9bk6DcRWT6KMAnvRZWyrknZn6
         QzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792811043; x=1793415843;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hs4kepycTRBAy17QyXDZeRCyHZAEsRiAGe7625jFRXk=;
        b=wvzh6B5Wb79X8iDn4uaRPS2VA2pl5XbHSndr1q7oYmnNIA/pNzQ/jIkPvAM6D4roa2
         WYOvJiVm0OqnQeQCr6IIGdvJu5il2BQAJOKXMzXsApyY/RI7h+RaGaJFBv8Oho7VoPvW
         eO/RcMNZEHpVitXbt4ZTaXDPQIolYU9T8akO9ikJPOnffzDAbRNxT/wuthTMSzHetbfK
         zirDUzlB2oheVyRfEeikmFCma0pI+eazGMmvuQHiOw73Aggkc2t+AZb8qDbdM4re4J37
         mPk5MY3Ljn++H6ENfNvNcDhaM4WeSKlp6wTYXalcNBwA0RrUI0jNYyzxpR8sKCJimTAo
         vp6A==
X-Forwarded-Encrypted: i=1; AKwUvBy/JFgGR+owcJaEXqlBAsoa0Guki39oE4lQg0KO/58bpZz6dBZrF5qAEOeToOCqMjEYX6Hj4KY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+uWu4zgyq858+iECJDA0kSDh7hh7LVL7jq9fSXfVuQKATRSvb
	PBCYhjoGH82LWXMOtuKQ8b0plHZv9resy7Rtmr+lLRkq8YeEYBKVcOMKVsFVFrAAF1O5ALAjp9M
	IB/ERNk0+va/Ta0COCK5yhxmlOQ==
X-Received: from dlbek20.prod.google.com ([2002:a05:7022:c94:b0:167:6177:d54])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4615:b0:369:2505:380 with SMTP id 5a478bee46e88-369e84e80d5mr1578756eec.24.1792811042353;
 Fri, 23 Oct 2026 20:04:02 -0700 (PDT)
Date: Sat, 24 Oct 2026 03:04:01 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261024030401.852598-1-almasrymina@google.com>
Subject: [PATCH net] idpf: free the skb on TX DMA mapping errors
From: Mina Almasry <almasrymina@google.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Naman Gulati <namangulati@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Naman Gulati <namangulati@google.com>

When a DMA mapping fails in idpf_tx_splitq_map() or
idpf_tx_singleq_map(), the unwind walks the buffers with
libeth_tx_complete(). The first buffer is still typed LIBETH_SQE_FRAG
(or LIBETH_SQE_EMPTY if the linear data mapping itself failed) at that
point, so it is only unmapped and the skb is never freed. The callers
return NETDEV_TX_OK and do not touch the skb either, so it leaks.

Free the skb at the end of the unwind.

Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
Signed-off-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 2 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..010903260ff6f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -228,6 +228,8 @@ static void idpf_tx_singleq_dma_map_error(struct idpf_tx_queue *txq,
 
 	/* Update tail in case netdev_xmit_more was previously true */
 	idpf_tx_buf_hw_update(txq, idx, false);
+
+	dev_kfree_skb_any(skb);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..a92e2457781e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2606,6 +2606,7 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
 	struct idpf_sw_queue *refillq = txq->refillq;
 	struct libeth_sq_napi_stats ss = { };
 	struct idpf_tx_buf *tx_buf = first;
+	struct sk_buff *skb = first->skb;
 	struct libeth_cq_pp cp = {
 		.dev    = txq->dev,
 		.ss     = &ss,
@@ -2621,6 +2622,8 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
 		libeth_tx_complete(tx_buf, &cp);
 	}
 
+	dev_kfree_skb_any(skb);
+
 	/* Update tail in case netdev_xmit_more was previously true. */
 	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
 

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.56.0.257.gf7497c7d27-goog

