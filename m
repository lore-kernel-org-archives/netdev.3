Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AA3F12C2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751358; cv=none; b=GigwnTFN6QnFv+3aXqX9CpSd4QdrlQlcdV6u7KJEhukimrtS3EvxhkT3waSwxoMbW7omVQ81MANBe8X8AK1Q5pNWszGORE9MlvAnPwYPo2RuA7Du0oFu/E2uDk33MPI3kfwSPSsrigOvVXx8AFbPxmAH8kEOS55fK8gWmMZG9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751358; c=relaxed/simple;
	bh=Vrq8TFknVqZqc/8JOPgG7PDUWg3gpVhuozznIWgm30E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7zm/yeADNXP6tyMTsONK4RQ7Z4eUNVY2b4D1sUYxogH0HG41lhBoUclavHq3wPqB0xFgeLlyRMse1he8DzhgpbcX0iz2tdG964ce/Uj+/4k8g3ga5DTbM6W4vNphZq3l24D+ofEqIVyWtMG8J8OiNHFjH6fEWdXsBlMewSs+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnTkp0nP; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnTkp0nP"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbef7b172easo3145206a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751356; x=1787356156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrN2/9T5gE9eG4RGKPE/4WL0YOiYDGqFenhtgUxLKRo=;
        b=GnTkp0nPfxFYd7XT+TOl1JxkQZtAvFJbjy+LkqinG3KEWrfKxPcSeLUy5RuaY6uVNV
         oHfsgoLGNYYGtNc1754SnyobyjEXWIo74IDZLoXatblUCNJa32syuASyBi1L5jKg/fRU
         zxq8T5Ik2QCvPFZ4l7QNhAuoFxNwlIv1hxlj2LlGlrnLLGkmtJ46n6747aVFrizNBGdq
         gwZZ0JhXRDtkLDcaWp3aPiRiTddr0KTuXiENg4VKeO59InAw4dg5e9aqnLIt4LrAGdf/
         HUfS4On6Pu5YYU4J4F0spaQ64voa+4j5DgyGogjKfRkZfIVjfMgV4R2WxTwlxuFcnH0u
         JFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751356; x=1787356156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrN2/9T5gE9eG4RGKPE/4WL0YOiYDGqFenhtgUxLKRo=;
        b=i9+romGv3pgkTNGGXXaFLD6CKR42VmcbuHT7jW6Pc6RJ6eCRsZjnXDqF+JLGznyaNB
         I0FLjTrICo9s7Bw5fPmSoliBEkqIndBz0LEULtr6sfBKPMMlXZqc5GqzlrpE58PDB073
         B76vW/BZVHEHWmnSP2K71AJpoB/h1WJmPtak/0kS/T15XZhOgnhHeqX/EwHcWytKU1Yu
         WwgaZjw8WQ05euw1dsx1ZEZhdZtq0dSjWnoQ/vY3siThmsnFiBOP7yPIJSeaUW2x1WYO
         a3I7pZ6zYQHOBKe71PU8p4Qx7Qp5PqFWTwOpY65WMmWZWKWx0FzvVD+iefpm9ioMuq8m
         sXcg==
X-Gm-Message-State: AOJu0Yxh/a4x97kMi8wdkaLTsTRNfqJnfnCAlfPbEShhrWm0u4MeNag7
	Qs33+/ELXLSN5oj6fyt7WJRL+TPygaSOkdxOGWteB0DON/7upQNvFkhyGV0iK5S5nJ7Nbnv1dqY
	jZeGCZ06IwQ5cHeK3DzqZ84CNFlLDg8atEwdxUW2gWr7MTBxtDmV/N0nuKIUW2r98V6fKWeaXEI
	p1XVgj9Ft0vCKMllhZFiH/WsdrEEuJ1HWm/F1sHW4ddz7kMFE=
X-Received: from pfuu5.prod.google.com ([2002:a05:6a00:6f85:b0:848:4e44:7f19])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:850:b0:84e:5e4:b9a2 with SMTP id d2e1a72fcca58-84fde31a0bdmr8848385b3a.36.1786751355562;
 Fri, 14 Aug 2026 16:49:15 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:41 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-3-joshwash@google.com>
Subject: [PATCH net 2/6] gve: fix XSK buffer leak when rings are stopped
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index db38bc645296..2c1ce23d1550 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

