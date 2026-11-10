Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352408;
	b=NfzXhPx+UgAcssSXolw9mu2Py6BJAGZ1PAvzWX+agSbbxNlN+Z80z+WZi4IlN38wK7B9
	 cpHXbT6yMAKKpoPX2ZJTi00HnozzRq1MbZZP1xAixQE7wKlMFpUXYpeWAU/MVwLB50bJZ
	 zA5ATEPLQ9EziPqa+HjT1uXlYrVVOxCF5avnIZjNsXjqva+HYpRYHXh34agnUFAoaqF4Y
	 SgAhoCw0KudbEFfG3KdmURJry08kWgDeSU+Rk85WfCVMTga7Fklcnc4lnQPFat9+7q+G/
	 NhQlFmweOAHp9h51mLW9uJDJxF/IY2xI2sjKikMo1wAgRTP5UQbYgqIMIaz+nt7swlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KPjjNdzNNe62t+wzBfTzcH4sAdNUBvRnqarPrYBxLuM=;
	b=vkoJ2pSVZiEmoTTnzAy9YObIsXdxqIJZ40tttEUvkWA4MwAnjbhaVa0eFZu8KSVLaOGv
	 cXI22f/sNr6aWvpUq8d2RMcQbYpxFl7N6YwnCp3LlzaLocsSpO1z/EDtThOeekpBC6olJ
	 UCkKPZzdXPB71VA6M6mI0Aaw5zHXw56EqKeXvO1MJ3HHC6t5fr33N40CD5TmtMIJPJ7Dt
	 pZCsUQms7kPHAWNoDObg3DtJEAqq/xrsmTU3E7AmzlfLcyhFukc9ypqK7qt//OgDWp8gf
	 ZVxf46ph+SdsNpbvlDwsgfjW770H7ZflxLFI+wzDL82mpdpoDZoXOfZCBVpqqIWUdGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lOisifqB;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8187606A330
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8187606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lOisifqB
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e940d5d2beso10157885ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794352406; x=1794957206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPjjNdzNNe62t+wzBfTzcH4sAdNUBvRnqarPrYBxLuM=;
        b=lOisifqBTO8ch8f+y85SanimyAgxf04DC8JmmHbuR4oySMJ7k67CQOulv4Pmz9hQDJ
         H+0kfYZIqUdc1VHGS0vheJs8VPLXkOhr88rM9RBPwAo3thVxFwhp3Q2SIz25PqeLMNb7
         BT6uEoDLYFlNTmnDNdLFcKtCfVCnabonrZxGnkea0sMLuVJ4WWggPHp8+4nNhHyV+VfN
         lVFJTYyAFWCnDrfz0BYTeVzBEVCT5AV85UrUMHCH8tT0FKY7QgFSC9kd3ecduNyrFJuk
         5wXjgiwKXIBx2XxCMebD3yCeArq8mgIOSlvvJ8FuXtMfZtWqQFZMR9/5SX3sp2obEyI3
         7Lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352406; x=1794957206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPjjNdzNNe62t+wzBfTzcH4sAdNUBvRnqarPrYBxLuM=;
        b=gFes1OKe6YQsqTGvPn7ZEbYtiyEgl08WusL21DRhGFiT+K7STQt+1Z2QpvNeqbbVCH
         xFtOwoQtnPpTDDphAttxG97xQezIrlVa+K2RVCT+2bl2QiYx05QW4o1JyboXJOzRYa5Q
         E4qOnmGfoyJmd+18jDs538zGQRXfJ/r7S9PLcX8F6uTmQZjUL1CX5eMw7+5OfjuQbL0a
         kbQppd2mDDkE3M3+zEJVzfWeSmUjS7O5KtM20qg2EhFNWOOPsOv39D4b+WBlfvrP43zw
         1SOgIHyLokt4lrCgdan1KsQS/XUEhbIZbtwKkc0p+OotagJz0au5Z4e/xjm7oRA9UL9f
         T69Q==
X-Gm-Message-State: APuU4Z9Y2ABzuWVAyosS8LI1gzXA4FU01f/mrk1NfOXzH07X3Pq6lZ9O
	N640/Q5lbAtdOPKAQOO+O2IMviJf2qAOjPg172icerfRJB7P3+pjJtZWwZRGP1j35rZmVMpqdK/
	abSiw
X-Gm-Gg: AYBFou1akdKZWoovxhJNvN8xoABiVvyiGOPDbSdAIlGlT3XgVQY6v9ze0Yv8QfKvNlC
	L2Dl9yIqbnWAG0DuTIrXNskOKcIp8f2J0GxE/J4er4BEsKMNbHCAdIF/0y4+LfQbPd5swkSN9zl
	82+4CrGpYLmQjCDpn/rq1BgRZj8nqu3t3cTjSfiQjtOeE9mys1s1s5qldfCUciZzd2vafULOgtI
	IYMURnZp2qv77UspC2HpFRNiRUrWIt+7lSQ18xShQvAZcL7u8JMTTjbB5c85zcDUgpauu42dpVB
	ZQQ3HWvgjdfn+14HuYC0vx3/yykwNeGTnszws9z2aaEWmjMdYSQjQ+b7AEEG5D9tHlE6t1cK4Jf
	yJuT96ClgZ05x9J3kT9wmh0P33L8NbmYNYCGXe6YEddq8XVeYlZQdjlnhORxV/lX/PTU5zvDASZ
	JdnhSwJuleWYwmVqMRfhpAPt7dLcmG+eNGowzkxa/hueB5QUVkkE9g3zHY8D0Q6o6I3L6Z2oEDP
	CoTL81tyCwGwezCXt0EGxahKbixp305qFiNQfBNhT4pRKUmHhGcS+DNoF0SkTzQHS0UyGfWQAw/
	6bnS1q8Y19gGxg1gqNzFon14qg1Gy2XNVsST/57gAp/774WRuPaQQY/gz+ZdCd4W
X-Received: by 2002:a17:903:1b27:b0:2e9:7dda:bfce with SMTP id d9443c01a7336-2edd7b85ea9mr5458855ad.74.1794352406223;
        Tue, 10 Nov 2026 15:13:26 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edbc1b81f3sm11989765ad.26.2026.11.10.15.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:13:24 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 4/5] net/mlx4: track whether a TX doorbell is pending
Date: Tue, 10 Nov 2026 15:12:58 -0800
Message-ID: <20261110231304.1859217-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231304.1859217-1-joe@dama.to>
References: <20261110231304.1859217-1-joe@dama.to>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the stack sets xmit_more, mlx4_en_xmit() skips the doorbell and
relies on a later call in the same batch to write it. Nothing records
that a doorbell is owed, so a path that ends the batch without writing
the doorbell leaves the WQEs posted before it unannounced to HW.

Add ring->doorbell_pending, set when the doorbell is deferred and
cleared whenever a doorbell or a BlueFlame write is issued, so such a
path can flush the deferred doorbell.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   | 9 +++++++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 97f27e005810..123071a47bed 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -194,6 +194,7 @@ int mlx4_en_activate_tx_ring(struct mlx4_en_priv *priv,
 	ring->prod = 0;
 	ring->cons = 0xffffffff;
 	ring->last_nr_txbb = 1;
+	ring->doorbell_pending = false;
 	memset(ring->tx_info, 0, ring->size * sizeof(struct mlx4_en_tx_info));
 	memset(ring->buf, 0, ring->buf_size);
 	ring->free_tx_desc = mlx4_en_free_tx_desc;
@@ -757,6 +758,7 @@ void mlx4_en_xmit_doorbell(struct mlx4_en_tx_ring *ring)
 	iowrite32be(
 #endif
 		  (__force u32)ring->doorbell_qpn, ring->doorbell_address);
+	ring->doorbell_pending = false;
 }
 
 static void mlx4_en_tx_write_desc(struct mlx4_en_tx_ring *ring,
@@ -784,16 +786,19 @@ static void mlx4_en_tx_write_desc(struct mlx4_en_tx_ring *ring,
 		wmb();
 
 		ring->bf.offset ^= ring->bf.buf_size;
+		ring->doorbell_pending = false;
 	} else {
 		/* Ensure new descriptor hits memory
 		 * before setting ownership of this descriptor to HW
 		 */
 		dma_wmb();
 		tx_desc->ctrl.owner_opcode = op_own;
-		if (send_doorbell)
+		if (send_doorbell) {
 			mlx4_en_xmit_doorbell(ring);
-		else
+		} else {
 			ring->xmit_more++;
+			ring->doorbell_pending = true;
+		}
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index aab97694f86b..601c09020f38 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -281,6 +281,7 @@ struct mlx4_en_tx_ring {
 	unsigned long		tso_packets;
 	unsigned long		xmit_more;
 	struct mlx4_bf		bf;
+	bool			doorbell_pending;
 
 	/* Following part should be mostly read */
 	void __iomem		*doorbell_address;
-- 
2.53.0-Meta

