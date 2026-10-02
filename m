Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161D3C3F40
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973945; cv=none; b=R88/eCfHso/L6uEKAdFZKo/jgmRgz/EkbetvKPwqXWcFWzBqK6zmcNyd/+uuZqa/VaOhdogulNUYF4BcjpTBmjlS7H4mJwS7HCvZGuEvjxsH3Z8QJ5Ybx7xv2qJD1x5zpdOiGWv4ta80MvK7/irlIchkYNTiAL3PnwFBEMbe1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973945; c=relaxed/simple;
	bh=hrKzZ43cJvocqLxV9DmG9Sqd8Bel7/0VvNw3HPWvWl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4KUtaMSRk7ojKMmxBaRuStH903eILjIPBDKvesBzJ/sl9+LtRbnIZgfLYFVzopC5LAOlTfGwQX+4wpQd2iM/UzyF2x0LZtKQy9xozoMD3gZXzyNYhoQrPhyw839ELad5b/TnOdvUlptxHFwG/MMLEEeEWIR1mgptiWxYtxNVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=WZOd3/my; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="WZOd3/my"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so13983eec.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790973939; x=1791578739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sgvZhgmjrftKT8E5vS9CrFzO9ANsKTScS9cgLRZmapE=;
        b=WZOd3/myVZqIyBJUs+Us+pqPYI9Jg04o3Ta6P6Qo+DrbW7Z9NMTr6VNswoArMON1gt
         BeyyvbDVerQ/a2OjX2Sxq8nBTNdVLxvv4Ob1wC6Kt03o0cuxXZ/yhqF7fvokkG6FBipw
         pf4cmb0DH39zqebzCGyTDWFmF3gdyrr9jxVEGFe0audy1mOhOFuEt0r0iCoUN7mJQ2r7
         ZiBABw+7jWtQKL7W+4sK5aZDzyTkn4gHG8zwSRSVakBoA5UhBLmxHmSXZLvcrKsL4vyU
         3DdHP3koxK4SSk8OrHbvB86XLReIJOzkn3uoFz1WGkdKhJVbLGIWt4iQUR9qXp4XFr7a
         6HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973939; x=1791578739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sgvZhgmjrftKT8E5vS9CrFzO9ANsKTScS9cgLRZmapE=;
        b=qbzch6FlsEpPL37JvVOFETqu5WIrrhbgAZhiA1Yb9UZ1kx3W0Gb1zdWrapj8TXxGid
         WRhJAxaC+KE43xFJLt39JOk9aroMtqFpZnuk+NbeqPeQn5Ek7r/QaQy/0V0JTxKJ99FP
         WhyK3hK8XgvaYe7VCoMWeQeeRlRxNGfMezEgWjm8KAZC9/lnig3qWmLGMJdS8WXzlnwg
         f2G1zAWa/g90a2ao2CcHBhqhmWNYWf5cyxj7Wgcaq6aRo1CSp8mdDi2Hy+ARKxsee4fq
         IwttvtbpLHXuwSWNFVU1RBdSGow7mUVnC7O+F4rcDn6GGTixEB3GJfBQmdKIaXYL3Oza
         TEAw==
X-Forwarded-Encrypted: i=1; AKwUvBxEVs+b9K2TBmNW/iC+ROfw+kwutze5/vWuiubOSixR52nEWFBUsoTwqQ+MDMb8vSUH4UikWjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL2nmmGQ+tBLdUgQ6jWnOoe3lsXaXn4WdBcqW+Xeey1suBVNgl
	+UUokUosFzJ/aUbXiJirv5Nvc9BzIgKDlKWmi/XvFSnZ8DFBIRF5iWOY+LXiaSTzXiA=
X-Gm-Gg: AYBFou1X9zhmN9RnyQal216SfcZQV2n17wrVV9hpiBromiPXcIqrZ/i+BwG9v9SwZgM
	8Ye1QPawR0uRDKWIJb/pGUOPRzcH9mw87hf7TkIik2dY3AHrdbvzyB02N1z+wIwVHaYCYq3tLXg
	EbLVuNWT++uLNLG1uuy3lIO7IaXD7GDjV7QqviUUsLxmGahGVyfLxmbmxfddDliTnCEuqu5LyVF
	tYBt0i2V93FFDauO2MWJrWBvZMToQLXxPEp0MR6+688JCOS9yI2LjflLZRskxQla4vlrBQkUVWS
	60dfEpDZ8B6sny3m6u0aMKIE79eWFadOb8I7ghnaNM0QqkCeliIrWTQbg/jUT0jvRz/iMS7OuxY
	aHB8OG+ZIpcdkznVqbLAlS2y0GGyyXI4JjiE5bdxZMqc6loUkX+da/nFnOA80Roa8d1unGU/jgh
	8EtHbCp5i2RmTs9PNj8/ZehDEVvE71b9oQnlaaXZlIih5b157fTp11/gKAAVBIWCVO7sCnb6bpf
	wLmJ1FC/IibJMMmkjURaFzVPzgA2cu8blrsrKuXXhwR3zgi3uWUdXgJ7OS+veiDIDWeXfku
X-Received: by 2002:a05:7301:1709:b0:34d:f38d:4302 with SMTP id 5a478bee46e88-34f150d1b0bmr4216038eec.17.1790973939173;
        Fri, 02 Oct 2026 13:45:39 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a1e3:ffe2:b35a:69a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351143b577bsm62111eec.15.2026.10.02.13.45.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:45:38 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH 6.1.y] net: ena: Add validation for completion descriptors consistency
Date: Fri,  2 Oct 2026 16:45:33 -0400
Message-ID: <20261002204534.26297-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7 ]

Validate that `first` flag is set only for the first
descriptor in multi-buffer packets.
In case of an invalid descriptor, a reset will occur.
A new reset reason for RX data corruption has been added.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240512134637.25299-4-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and net maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-40999. It detects inconsistent ENA completion
descriptors and resets instead of consuming them.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The code change is identical to upstream.

Could you please queue it for 6.1.y?

CVE: CVE-2024-40999
Upstream: b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 933e619b3a3134..4c6e07aa4bbb55 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -229,30 +229,43 @@ static struct ena_eth_io_rx_cdesc_base *
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
 
-static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
-					   u16 *first_cdesc_idx)
+static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
+				    u16 *first_cdesc_idx,
+				    u16 *num_descs)
 {
+	u16 count = io_cq->cur_rx_pkt_cdesc_count, head_masked;
 	struct ena_eth_io_rx_cdesc_base *cdesc;
-	u16 count = 0, head_masked;
 	u32 last = 0;
 
 	do {
+		u32 status;
+
 		cdesc = ena_com_get_next_rx_cdesc(io_cq);
 		if (!cdesc)
 			break;
+		status = READ_ONCE(cdesc->status);
 
 		ena_com_cq_inc_head(io_cq);
+		if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK) >>
+		    ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count != 0)) {
+			struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
+
+			netdev_err(dev->net_device,
+				   "First bit is on in descriptor #%d on q_id: %d, req_id: %u\n",
+				   count, io_cq->qid, cdesc->req_id);
+			return -EFAULT;
+		}
 		count++;
-		last = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
-		       ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
+		last = (status & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
+			ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
 	} while (!last);
 
 	if (last) {
 		*first_cdesc_idx = io_cq->cur_rx_pkt_cdesc_start_idx;
-		count += io_cq->cur_rx_pkt_cdesc_count;
 
 		head_masked = io_cq->head & (io_cq->q_depth - 1);
 
+		*num_descs = count;
 		io_cq->cur_rx_pkt_cdesc_count = 0;
 		io_cq->cur_rx_pkt_cdesc_start_idx = head_masked;
 
@@ -260,11 +273,11 @@ static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			   "ENA q_id: %d packets were completed. first desc idx %u descs# %d\n",
 			   io_cq->qid, *first_cdesc_idx, count);
 	} else {
-		io_cq->cur_rx_pkt_cdesc_count += count;
-		count = 0;
+		io_cq->cur_rx_pkt_cdesc_count = count;
+		*num_descs = 0;
 	}
 
-	return count;
+	return 0;
 }
 
 static int ena_com_create_meta(struct ena_com_io_sq *io_sq,
@@ -539,10 +552,14 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
 	u16 i = 0;
+	int rc;
 
 	WARN(io_cq->direction != ENA_COM_IO_QUEUE_DIRECTION_RX, "wrong Q type");
 
-	nb_hw_desc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx);
+	rc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx, &nb_hw_desc);
+	if (unlikely(rc != 0))
+		return -EFAULT;
+
 	if (nb_hw_desc == 0) {
 		ena_rx_ctx->descs = nb_hw_desc;
 		return 0;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5159fb9fbe66fd..11f47f24917eb3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1853,6 +1853,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	if (rc == -ENOSPC) {
 		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
 		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
+	} else if (rc == -EFAULT) {
+		ena_reset_device(adapter, ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index 1e007a41a52564..23466d62fbc5c5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -21,6 +21,7 @@ enum ena_regs_reset_reason_types {
 	ENA_REGS_RESET_USER_TRIGGER                 = 12,
 	ENA_REGS_RESET_GENERIC                      = 13,
 	ENA_REGS_RESET_MISS_INTERRUPT               = 14,
+	ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED	    = 16,
 };
 
 /* ena_registers offsets */
-- 
2.39.5

