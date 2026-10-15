Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863251AFDB
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068398; cv=none; b=CvZi5HlBniuJzG3WjG7EyFXX3Tmo02JKkNtkG1j+U6hpYDbv4RoNxUiAb9a1NQz8IpEKDSN+IsrFltOND6KNjg9YhqVLgg27GR2V++S02jHSzaDCainhL8xwLnR8vC2iRmv0fo9JVWTWUWrDWa2Er5vHy28H/lIVotF00Jqv/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068398; c=relaxed/simple;
	bh=cFiDNlYzTpfBr4CpahMrYQnDXXyhSYH4MDv7Q2S8ipY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Buq0UGIfPGXZG/iupXva8xOGofsrOfMJuk3EDCoWJVjf22d4qmm/kUUBge0rX/kqoYpFbnN4gpSrutwrqMH6rYVocWWMEr8MoEqR1TEzbxl6B/GoX5qdMbxH0+HSoteobyt30Rt4nS7Ds+s42Mfzwcavl5w/D0IteM32jJWz+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT2jOlMT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT2jOlMT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a17ce1dc00so10490645e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068395; x=1792673195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+l8FvzFknLtk4IDfbn1d5i85ebVlKTC+SH6Z/LTFqeA=;
        b=HT2jOlMTOD1S9Ly7eCQTKS7yo5NsJWUgL9WuYRFVlNT8iPZ72FXmK5aCZWcacg/dSe
         dlVRFfPNJ0LeQSE7RLWIai6+hFidcyo5HdbJ43ifroiQYuZRghbRvcyWP0V9I3L0aT8G
         jG5WHAMUpeHZWK1mDWyTctRdpro5jmAVE54WzkMOceMzpImI1yxVH+bhFjbT5BbT2Uq4
         MGc46X2Z1AuvDGrD1fHu4bzL/Dy6iQzspQacwvBIQOSiI8eICVhZqazhJMwlUBrLNqRe
         57HgZ8diZSgdIZIqth+IukUlPEQx3SVrTPsHkQ9Ap5HiOyIaN9xPu2qaoS9TvD24gd4g
         gn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068395; x=1792673195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+l8FvzFknLtk4IDfbn1d5i85ebVlKTC+SH6Z/LTFqeA=;
        b=WnRoc0sw9EBNTvF5HFbbVt3WarfUKkctFmMjZrrg0abwwZcKp26I5F1qRXT7+aEWDn
         pmtx3viNciuRDswSg8hFHWIcIoRAncnafo2sYHrLd39W6AiCdbEJoi/G2vRe0XKQvmqF
         mxphG+zd1K4kDahY+NDmWRm5z0RUK1mRiwu2LI9hir+o58zP+yJgDUhv5VW1Ui4PznTL
         eKyjO2neastRdscupH6XOyXPCECcN5ISLU2u0EsZ6R0Cvoio/KbLiVp4bqljNFlFkdKv
         UmUhKIegHgk86siHSKxPfpLzdL2FzcKMWDZxU6NTzxps0QDK2WX9iMysv/n5Lpb4cyfl
         sWOw==
X-Forwarded-Encrypted: i=1; AKwUvBwbPyy1GuNpJeiLyhCZmBH0ZSFJAUv0h0lfANtrgTpuyqKIEr15+OVUUw/t6y9hAiPoEuWtZW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxmsNNLBptsHUG+kQvca4kiQjy5KYKmTTefK+jRmcGrULuWBtt
	nrWv40E0tDoSKeTtKQgeX0l7epHe5VYJfl3GSSu+h4BF2Rx9RtbyATHF
X-Gm-Gg: AYBFou3Jq9CuVcJQgok9vhxxb6/SVwfq1vUnWi1TST8H9IYWglcZgrVFthzR2mE/ere
	o8OjwUGveBYCG3lIJgjYqqsnQsHVxztjXdku3sXS/s2gAa+i6onH3TH1fn1eYjcReB5bzQh+p13
	//VZGv9bVb5bow5MESSSKdXilHjwvyjlD6KjCWrO7uRoVsVb/XL/tAQN9hhCKbHLkaF9TfT/7YE
	96Ow+K/tadBoJNO4ohE0oviFuN40vzIk0TQ/zgNxTNpmfWWDyISWGFIVZvTs1mX7OkIBgjT/Wxl
	EKl0TVHQDNYBLKmTfW69VzzfbWtQL1YWaPp5X9tu3gVjo1l8furq+UF7lD0ydH3OWfzOlrfDM17
	UlrEfy00CVRNvp1Ra9EcKVoQo3M+Mmox7OSyderXjjZu6oMPF4sfqkpzcBizM15dVH4iJR6D7ac
	svO1Rp9WZbDjtOAHQe55IojXF7fFILrWrVRtGFE5hiOI9mo6t8iBtnNSwdLCOPze+i27m05fPmH
	GwVpGn8z9S69XA7coAsvsxqLb9gu7CGKLniAIO7PuqSgjN2VnzulxJljrADMUiFPLg=
X-Received: by 2002:a05:600c:1912:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4a18e3ef211mr354944995e9.0.1792068394724;
        Thu, 15 Oct 2026 05:46:34 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1bd99febesm80110545e9.15.2026.10.15.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:46:33 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single() size
Date: Thu, 15 Oct 2026 14:45:46 +0200
Message-ID: <20261015124547.29996-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xgene_enet_refill_bufpool(), the skb->data is dma-mapped with length
len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
xgene_enet_delete_bufpool(), the same buffer is unmapped with length
XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
DMA buffers or cause other issues.

Change unmap length to XGENE_ENET_STD_MTU.

Fixes: a9380b0f7be8 ("drivers: net: xgene: Add support for Jumbo frame")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Fix function name in commit description
  - Change Fixes tag

 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 507db46daf2b..2ddcbf27014e 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -185,7 +185,7 @@ static void xgene_enet_delete_bufpool(struct xgene_enet_desc_ring *buf_pool)
 
 			raw_desc = &buf_pool->raw_desc16[i];
 			dma_addr = GET_VAL(DATAADDR, le64_to_cpu(raw_desc->m1));
-			dma_unmap_single(dev, dma_addr, XGENE_ENET_MAX_MTU,
+			dma_unmap_single(dev, dma_addr, XGENE_ENET_STD_MTU,
 					 DMA_FROM_DEVICE);
 		}
 	}
-- 
2.53.0

