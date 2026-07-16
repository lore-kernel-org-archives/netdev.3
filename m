Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE3345750
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183684; cv=none; b=HxEkZu5jE9R8N9RRzc8izAB1B+4mZCs0OiapSSE2RLA+E5EaE/2Xvw+UtQQ9aFpRaOleTbrde7FosqaiyBaX8l83IUmjFFyA048Mdts8dV52Ctcoyb5Lk3p5qjCuYk3fbuh8f6u6K72YyDOND5JUdNWaPFI9j6sTZZkN/eUw2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183684; c=relaxed/simple;
	bh=qcxtIhicU4yjTcuHKm9/uZfexpxtxK7NRRzA5uQ3Zio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qSq0sRIIsjU5+8lKEJzYiYOzYtp6wLotRVZHpzilKxHVXiY9EPjDTqW6GjVboEqr5tupvOO8CP2uGNkWU60Alpf3LO4wmNuL+6PPR7vi6BpJo3Zj7x+gYW6GyzKuEWDl+bfvM9cU6hgkNa5rtyy7KkiA8gj+0TCqIQ8pT1K4r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igyuf2fI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igyuf2fI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8486ac3f347so215187b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183683; x=1784788483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Wh24uH+pJSF3cGDjRO13znY6HNZJNEVNTxW5E0WYJA=;
        b=Igyuf2fIB1lH4cABZCFKKi2PdNaReBGRSGfAfjSohbAtGJoRH5PDuiZiF5zhrSQA2r
         8RxYfVoExTWvX1p18MVo47oDzTGMHNlTPXfVGwY8MjV9V8K7rQbuStG/fjCwhy/uL7HL
         NTYwgK5Gk0KCBfpShMbnRrsyB3b1Z2Lv1ZZhACxttwiz/MhaZD3ATkH5Qa9eS89IMKTe
         CLhcp7MSksFJeWP0dk1spSM4KwgVODE9n5n5kd2+OHTbHmclFwhdidvDn+UVNqiWxuHA
         uWiB+7heHp8Ev8z+w+QEFtxeuGHOU+nNaOchI39vENsPjL5d3xPG3Bpd5Mk2/AcKM53g
         6FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183683; x=1784788483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Wh24uH+pJSF3cGDjRO13znY6HNZJNEVNTxW5E0WYJA=;
        b=JAzBQ2XnUardnG2WqZgSQgrj+JHotElSMSsozP/NgHigM4Sv/X4R4We0FTMZd5hl4n
         uxarH4b55hGp3oB1ILxu/7pJoX91vE/BoM8AeavvjaOxHNKPESBw1so06ahMeEjH/d3N
         QKqFiuWOLh0ilW1BFdE1D1bPlCreLinFNewbnqECdWiIO4bm4jKVmb8tE8StzYWCTeAl
         29jwRgap4sKtz/cfI36yPDE3H+cjeXQSBtv8cElKlt/iQUBzXRE45EVoSiYTNT7qSI4M
         15bdxuyb7H7+hxuHF1SObkPyPAmOI75JBqIC1I9k8bT6oshDesfEydO0hYOXHgDuuZNd
         sa9g==
X-Forwarded-Encrypted: i=1; AHgh+RoZzkbKUu5tNFkT5qjHXAVDjOJ4CdBXj/FUcvKwzgXICJBgT+wu+bzbB14uFXezElmihe0L3zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNc+0D8hRZ607ErEttBtHAt9x9p234BSGNFPwcJskZSx6qrdi
	ZJfGwNapIeUHBatV4wBpQ6eU1NZ5vbtzQKG5BMD9i9U7oVL/CIh2d3kH
X-Gm-Gg: AfdE7cnnJQEK3nKm68KlxsO3iPJnN5iAhd9Wyfhu4JcRi1xNXubEcSDUkSycz9QiTcr
	rz8zTFxaKpU9Xt7PIlRJJM9sTj04I0tSP6WtXhMALhk8MrCB3znlIpzoe3StE+MShrnWMlx7ly9
	w/TqtZpiWGceeIinS4+WJjQtJhi+aRwK1Dk00h6bjuZuL4ZbxVyOHW0u81d2Nz79zZ2b8mBMQE0
	LUYJUJIy0nzGjupaJt4IjuqxbqVF8CL45dxUhcQPAl+7smNhV22wBeI/UhuvloYn0ruf6/jB0S4
	lsItmuhxFYnNsFlphB1wYS64ThXxOcHiKIJ5WgvMZ3JRyrstBG1tPU9wQjszylo0s3Hby8WotIe
	3IpslUWMgQd0Mhu6+T/I5wK9kby1IxfGU2mNlK9f0ibQiUirWzLjstCzM6MNUfecmIVYgyYRo0j
	zzInOLXlK4hCXR9R98/JJ17OgcEoY=
X-Received: by 2002:a05:6a00:440b:b0:847:9aa8:d3c1 with SMTP id d2e1a72fcca58-84beb53e204mr1322880b3a.34.1784183682572;
        Wed, 15 Jul 2026 23:34:42 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dadcfsm4242172b3a.48.2026.07.15.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:34:42 -0700 (PDT)
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
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 1/3] octeon_ep: fix skb frags overflow in the RX path
Date: Thu, 16 Jul 2026 14:34:30 +0800
Message-Id: <20260716063432.2908100-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
References: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk:

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
about 3776 on 4K pages, so a full packet yields about 18 fragments. That
is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
writes past shinfo->frags[].

The fragment count is now checked before build_skb(). A packet that needs
more fragments than the skb can hold is dropped. octep_oq_drop_rx()
consumes its descriptors like the build_skb failure path. The same class
was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a..1e5494c652 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
+		if (buff_info->len > oq->max_single_buffer_size) {
+			u32 data_len = buff_info->len - oq->max_single_buffer_size;
+
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				continue;
+			}
+		}
+
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
-- 
2.34.1

