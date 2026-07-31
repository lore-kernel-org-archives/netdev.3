Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA68428463
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502184; cv=none; b=NY2thhseSEjCnfSqlR+IydY5BSwz4aJdtHoIO+k68h/Ocw5a01d9m/LzV48Ytf+jv1nlfLtMpQkbeHLYC3KfRwZxjGH3xKmmnex7eklIlpby7RiFhU2LC6JVwp20J1XuGHLSEfZ+cNbLdPrmzUVDMwcrsuyxzNHANeLN3QC36Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502184; c=relaxed/simple;
	bh=GIKN6MRFDPaW0jRKKs1FxX7l8vahLILnPz8DeWbGX68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+MnMnP2TcudDg45gBiE/yHoZfJsISvskv62ljkqib0vP6q9zmjXVqU1SipacEibfutTdEsKgvF0ox1N9nopFctQQKd+RIlcwgBZEXx5pSoSEfRos4OACsRCU1HeiGK5LrQSRt+smhF8ad3jIKpLJWj2Sk4jBSZAJhtGLqZ3awM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSK2AM9P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSK2AM9P"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8143daf89c7so9064837b3.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785502182; x=1786106982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jG6/m0wFIS3acCnXY9BG108ect7Vn9Ccjk8vk1+isvU=;
        b=aSK2AM9PeqXmdMSAHKs/yN3Ue20NOtSROxqhjbCO5p7PQ7VCLFjs3Eqn2SOrbVOil9
         jweM1BOoXhjAh4lwmcAsHrg2oB/EtODXQoXA4fKI2jqvNcp67ozdE51PBdPBqNn+Abrk
         JF8gCb8kfsUpcSaIz6gaEhrY45IMQDru8FHxWO+vRFC2h+TDFYvz3sVp1J7HpTAQkzfm
         lGNC3w7h1DfFQnXlxI33dVZUe8Utu90HEf2cXzME4+HUy7C9HJYbgRLldNRXiKgOzM68
         ev2cWH0sW9MrkqcKzm/TdUX66iQ/QDtzfflF6M0derreAW+BxG0VylfLG/SmOvG4c/tq
         MDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502182; x=1786106982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jG6/m0wFIS3acCnXY9BG108ect7Vn9Ccjk8vk1+isvU=;
        b=TxPNimTgOopJdi5T2v8FLjspfOih7kCzenyJ5Uw5gSXA8BcN3dnbsd3s7Ifri2i4Fi
         u80rw7c07pFQXdDWkhII5TjVdZvIG9kC5JitkTOa6zVpO/UGf2yKrNnecbX6JEg7ZxIo
         KR5fj3y35ATodvKRljdqx6r0d9VNGFDmnSJnKLtyI6ZPfbOcFj6MkX3oBnKtByYnY/Lk
         jcwC1rSRuy6ILy6C0k/RlBnv6KdnkdZeJJexpejVv3auIYTTbN5bmVudJt5zxq98R2BO
         vCI5sRo8N4aIcAzaQmkmLGGCKegStkWJOD0UuNGJKHR2JSWw3aEBppqV15dYt61Tmy1B
         dREg==
X-Gm-Message-State: AOJu0Yz3NC0VL3VYRBsrfZdPskh9kc1yUyQiuyK/1ruBlh5M3JFjpkvz
	bkSXlbT1FDS14R+MI1d+GZ5aFUn66tKUXQtySwR01r/IUpfSwRGngvvT2iKI6dPP
X-Gm-Gg: AR+sD1318iwua4kRFBVh5oJi+yGblJvZBxEw22uvyTpyHWyxSbYwAkqFaybsJdjCrtf
	v9iIppPSeOJqfgxW6HgJInHm5ciIFQ7cugERLFCMa3NiMqhYyN6P2/ttCUA/J8wi98yMD3CqLCg
	6QoowOk8KuogUVpKZjG9gIhy/nSCb66s1aUzMNgQLT0P+PvD98WbPpsoHzg/Q/E0ESY07jV2iV5
	Uk/+E2pc+3L0u+shI2YiwNklHw7581EAnvgDQjq5uibccvxbBrwhXhEzinabq0d7ySbsYCoC6Hs
	uMoVFWLWfgwzZsGqgtk0nTnux2wCFX8qn8PaSn9MgaKL1CIX7WiTbAvrQSKl3AjpxS3/BnwfkNC
	nIUN51S+FmtE3sbIKl83hWmAcp9DcIU33+5+Nie1rvUKqn9EBRVTLJYIAU1zk5gDhELsjl8JUaV
	2rFm0m1UsLGap250DwYEDiU1iA8/v4cnxIizi4J61c
X-Received: by 2002:a05:690c:61c2:b0:814:4755:2b2b with SMTP id 00721157ae682-81fcba55a69mr16655277b3.3.1785502182259;
        Fri, 31 Jul 2026 05:49:42 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd108f0bsm5695367b3.35.2026.07.31.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:49:41 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 2/3] iavf: use __libeth_rx_sync_for_cpu
Date: Fri, 31 Jul 2026 08:41:08 -0400
Message-ID: <20260731124109.99065-3-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
References: <20260731124109.99065-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rx ring already has a reference to its page pool adjacent to fields
touched every iteration. Avoid loading the netmem_desc for sync by
taking the shortcut.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c30abf17cf5d..3ae2f0a0ee4d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1387,6 +1387,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 {
 	bool flex = rx_ring->rxdid == VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	const struct page_pool *pp = rx_ring->pp;
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = IAVF_DESC_UNUSED(rx_ring);
 	bool failure = false;
@@ -1424,7 +1425,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 
 		rx_buffer = &rx_ring->rx_fqes[rx_ring->next_to_clean];
-		if (!libeth_rx_sync_for_cpu(rx_buffer, fields.len))
+		if (!__libeth_rx_sync_for_cpu(pp, rx_buffer, fields.len))
 			goto skip_data;
 
 		/* retrieve a buffer from the ring */
-- 
2.43.0

