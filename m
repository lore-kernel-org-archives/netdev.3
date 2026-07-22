Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7E36194E
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735509; cv=none; b=Ws4RDRcFOQ7ZMiKPliRdicifikGoOxHov/4skXwi2352HRJfMIZcGi+5s+JWjiMCpy/BZfpTIE+pveiBynaSrq8na8Awx3yJjsStB8uSCSDE2oPPFmBYqRowxGd7UCnN5+P5pGoqkZ6/tNtxfFj2ns8atO1lF7Hn5DxfD8RXt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735509; c=relaxed/simple;
	bh=MaKDNUKQjWmWayDF5cS32+ZCJ4JvRRuKQRVPZiHyD2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNKNU8W++zuwL/v90KZ6cWr56wdWDPOG7xrzl+0a02mee26/rDKV6X1/mgAHWSRsx9EinO9xYNwRvxqV/Ka1fYR9Pk3dDw/DaLzVXz8yRGUbcNqtbYqfw1jWZhIA8fqygJP7s68NiRfLGCOQaimOqUlXFwjXSt45tXJKM4GtNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb3qYZPn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb3qYZPn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceab75934dso136196355ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735507; x=1785340307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xyjk1qw4u8DGYX3M80XZHxNBFE7UmONsJaSKGY0mNY=;
        b=Xb3qYZPnmsm1YAUh3cppYUy2jqiOpa/h3g1J0/8Y6asX1tIUXoXVucJTnJrvTj1WRf
         Y4bzCvCQeRgJEGdEQAoZKbcKVOY1dMgoguabIgIXOtHAqCOP6hBDCgioFshNQhFJYe7w
         J1llTosXfu/tEgmK8rvizQvk07X+DZnZrK5X9Chvh9Zl9kcHzo9LWL1uJjWvIKoZjsnT
         qOoAIlaeb90vFLnEt3mzBJEM9nsoWYFpuDTYvt3OIwIW389evdLirwOHt7ekVCCdeB44
         kJ13Iuj6uipNrFcyj/kAzCVPr9DOL5BHMmgTfGprBxN6KaS/Fx+z7X5+jlfoXWU92BnP
         SD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735507; x=1785340307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xyjk1qw4u8DGYX3M80XZHxNBFE7UmONsJaSKGY0mNY=;
        b=D0RBI6nLKbJj5AAx52FOILJaxz8w3qvY2teU6n/IHd4cG7t2T2u/dTbYHbSbJ3C8bZ
         z6vQ3vjs4lB7QRoCGszR0zcJXsnZt4hw95V2pqz6JAtez8HGeZbaJKyfqGdI/r+T709T
         LRdThAGy/x10IG27l8LnAfGj/z7hA6HeDnwr8NsqZQZjEb3fXue8MWFxUEp382c4oalV
         RV2dwYNMQL3w1V47vwbQocGn4EYWulrG4gIIIeARw5XkPJs/STTkAIREz2+0XOFx5D5M
         uIYES4vbZIx/e1oj6eF+2NMl/J8EfumTTuS7cAluevs7i1JIyUzpQa4ESS4DrquXTuEU
         tA9w==
X-Forwarded-Encrypted: i=1; AHgh+RrOZmmgcpKrGjolWlzzyJ/YTiaySTPF8JQ38hAMncSCitWhEHfphMGVPSSFF3NwkmAfjOOxNcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7prpDYpCE4HRf/t6N/SHXhNcxGww3AUizrv5mSEVBSwvKtEUq
	FzObgvSJdBLUklGP+nhcpboD6QXmqfminc9s5AwcIE/x/cM3REZyBeSj
X-Gm-Gg: AR+sD12b7TbQ4EomcBHEC0Iw4sMTdrutNzOGj2jYf1wyJVhCzB/3Vz+/jdSwTa9Hccu
	ZjlMbsKDBixHoQ2LW/Z7WdAXT5XSpbkvKki1LGT5EZnhczsYy73HvR7CRFar8ylbcGtPxXI5+Ee
	hbT81yGC5qaK58fkfJ/MBew2dOUDMnP+nedk7kvvBieCcD+AqO5S09e+IAsFcJKYaWi2a3d4GNg
	wDJJEKf3MQBZBFL5/EvOLCALuxSQpbCb9zT21aLd9GiPTEQllI8byjt5dvhdA8Xk0W96bsv+0/E
	KA+/T7K7tjF5La97zwMi6mKlr+dt3z/gRJYDtmDK2nHeJECvZ8/Fns41bXAFF0eugbZVFeQMYhC
	vAynkiB8dnRSSfgA2JV3LM6tue8PvVqitLKVmS4siHiwJlMJQBhQONQOOg4hlwnrzuiHE1XZZWW
	7US0wvWyim3tj6xesCcIsNZvs0p2F0+z1ZVcdyAA==
X-Received: by 2002:a17:902:f710:b0:2cf:7d44:e14f with SMTP id d9443c01a7336-2cf7d44f558mr110005485ad.26.1784735507059;
        Wed, 22 Jul 2026 08:51:47 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm11123125eec.17.2026.07.22.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:51:46 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 2/4] octeon_ep: fix skb frags overflow in the RX path
Date: Wed, 22 Jul 2026 23:51:29 +0800
Message-Id: <20260722155131.2017597-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk.

	data_len = buff_info->len - oq->max_single_buffer_size;
	while (data_len) {
		...
		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
				buff_info->len, buff_info->len);
		...
	}

buff_info->len comes from the device response header
(be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
about 3776 on 4K pages. A full packet then yields about 18 fragments.
That is one more than the default MAX_SKB_FRAGS of 17. skb_add_rx_frag()
writes past shinfo->frags[].

The fragment count is now checked before build_skb(). A packet that needs
more fragments than the skb can hold is dropped. octep_oq_drop_rx() frees
the fragment pages. This path frees the head page too. The same class was
fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index b0162fb9d9..20c7b9f53e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -459,6 +459,16 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
+		if (buff_info->len > oq->max_single_buffer_size) {
+			u32 data_len = buff_info->len - oq->max_single_buffer_size;
+
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				put_page(virt_to_page(resp_hw));
+				continue;
+			}
+		}
+
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
-- 
2.34.1

