Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D93C8732
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802687; cv=none; b=HWbHnhP4qJ/+idZdNynFTIKYwF91wdjmZQbvcI0pfmxaV1pwqHKC614er0UbXYCUVqYZzffA8y2JZMAXF6iGWlzv+9cOzbVOP8P/s3P/2v/47Ox27fR4wUjooj0JEu8XbXxZzdEsVqPA4QqfB5BneSzViFBai31q0OdqcI0Ze1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802687; c=relaxed/simple;
	bh=to4R4ee8k2o5804/vpzYrLJhMjVE1Ml1XXys9wSRdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enUn+Z35tDgN1ML7ypq8uyTFCZXm25jRIxy6I7uR27TEslegkFu7sxEcW0laFoFjLWXURhSO7IVC4rx03iuXBAnW4Z9Gx0eXcHFFf1Iv/ah5baD/zxl8pbsGU/wFNZO3rpkRMqQV6BT3w1tJNtjd46/zk1W0K4udMifvnBLT4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOBGnHVT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOBGnHVT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-475417f010dso383367f8f.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802683; x=1783407483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=hOBGnHVT67Lt3gKYEGMm1hlFw3lhLlTyIkAJJnIuUnru8IKeAb2ZC2Z0WEQuN4rVH7
         CLleuvU5MvMMbULpAG3wyn3nsrpYp4EtQHycA6NLn8PavmMQaMHUtnWYse1G5g53xnyo
         utQOrAXbmJaT5s5pT2R3Kuv6tozZpkXh5T0FQrt2XUShlWHogR9dL5InbZROChKWHT8m
         wqnOHuy0jlxzecRhwFr3G6GBZG1eJkTyIMlwkfQ1/76nhuywMAwdgElucBls/wUcY76i
         AlyFlhQ9A1AzVdEEb0kQqV2osxU93gx7jC3Vzmhy7SRgE73Qc0TmzCB2KzN5EQ43gnOr
         LYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802683; x=1783407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=EPmrPs+JBrV4oXfDdvyA0/C50mdi8JHHmRGYS7NazsNAqC36oLEcirB03io3CqGccM
         FnSZ3fcR/0cZ4idTuZbhQhyPN/Ef/s4lapTGhQc5kAr1tKdbuYbBST84fFoK7GNePaWf
         T9enChCaiR/Kcwo5sVeBk798w3/ljiMaKafZjuohGJjb+6WSoYzPEuYJShazKcPutBif
         NfLGYz+3DZMBh356/TB4nqAljAkMflp5f3jZ2UMKmwLkPkjuWaxQqIaVsAApuIcvBV6J
         vUYs62hNO5hzXuW6Qf1v4ut45ljtFUSRRZ/iyCMn7flLii80hbIWPrPuzHNkcPCj7CX+
         OxtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyFtLh/ca7dENbrRqNkkxdf235Dtuvz/FB5ajukqEC6bxa/NmwG8JaQkdEYeqaIVl3QctsHUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7oY6DIv4uqAsKeO5R2u4K1h6lV/I7TqLvoX0J/IoUdKoU6vR
	H/aTWjOY86cSIGJD1El6MdOTVGKAxUIezTo3CbVqbarvEQoSCyOfJu/S
X-Gm-Gg: AfdE7cnwmtb9OAb5M0PNdjweKLmx0b2g/+PlMLdX9NuSFA6xArvUwHeiMsuWTCVo2FX
	l50tRGzqX8NPudw7q3vzZ2ZukGENj+FoCcmg66eONi1DdRlDjznW4aqzJ3lbgHLZHXEpNzCnBK0
	NEGpAOi5gdkYyBl3S2c3sX3gulJYXS2t7/Vv1uk59Esr4njaysUVvpK0Ie4/kw13uVK6EE3PNNk
	vBuKp9RwkE3dwTbsFOBPTVuSnu7i7jAOcYoY8HYnDq1qvg87Kcq8/MgVCiaoPuT9iEQ+dRkYFTZ
	hIcslDErIOHMsu8OE0p0nc2F5tz9uaJ9MDffwWI+BSnhCJx3kANUSI1hJsAFQ3Z4GX7XSo5hnOc
	GiOBR8myEn2bZU+BDTws7r63Q14R43vO0/NrKhuUppJYGYI3e55cHnlOn0B9wO6WtEY1AELaaLF
	s6gTraLrI=
X-Received: by 2002:a05:6000:2c03:b0:476:135a:1349 with SMTP id ffacd0b85a97d-476135a1477mr139610f8f.6.1782802682657;
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 4/5] netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
Date: Tue, 30 Jun 2026 08:57:34 +0200
Message-ID: <20260630065735.3341614-5-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630065735.3341614-1-pawlik.dan@gmail.com>
References: <20260630065735.3341614-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Chen <rchen14b@gmail.com>

Without this change, nft_dev_path_info() hits the default -ENOENT path
for WiFi bridge offload via WDMA on MT7996. When a bridged flow goes
through the MT7996 WiFi device, the DEV_PATH_MTK_WDMA step does not set
h_source, causing the PPE entry to receive a zero source MAC and packets
to stall in both software fastpath and hardware path.

Based on a MediaTek SDK patch by Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 6c470854127f..580aa1db3cb4 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -219,6 +219,10 @@ static int nft_dev_path_info(const struct net_device_path_stack *stack,
 			}
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
+		case DEV_PATH_MTK_WDMA:
+			if (is_zero_ether_addr(info->h_source))
+				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
+			break;
 		default:
 			return -1;
 		}
-- 
2.54.0

