Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859D5012A6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676465; cv=none; b=iLCpLjbipD/5u3APhZYVkT5qM2xckR5SJxr13l9i9P26ZFPFhYC1NRYL1JALI3V2qnFV9Iov6bXdlPq+VD0mQznsT0EahbZYgrVGwRNZCZq7tVINpAaC7bvHmZXgBHS92pIjzGoA2bR0KO7147vfM1gDXF/kkDx4BwHsjEQ51RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676465; c=relaxed/simple;
	bh=KJFLEZ1v4mTD+m/l/3qSuOzDumZPPFtC6lZTh/jPfDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kw6dEuAm+3FK4VHrB07DwcgfyvKc6k07C6OtfAwpYJdeL5iMC/biHj/jI58bJVLmHZhLPtQK65PcIk5tFkIONGztRr1IiYgk4DNPmqDiaDKc4TFX5hJN+zEE++j7GHxuTFC1ZBmd0U+BUqHFWy+nfloJfmtU+swqSY288OdDTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UufCtY2/; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UufCtY2/"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so2291751c88.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790676443; x=1791281243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mMSM/kY1l4Gzn1BlIvdJFdJREWDCkpXwh6FxH2SOcxI=;
        b=UufCtY2/weguc8BuB8PzLTNjXPYbV6Dips6UZ7khgiwkLJP27IGu//WOhYnvSVWIJ4
         gTka285nd6BvGc1W7cUGmwhwEAPm0l0JQFleDnV5+YylH0IGWQuC/uw1KJfAqgRRNs6b
         rsSIreJV9u1sItJxp3/bF06xyQ3e99l1le1YZoT6c2ph3OT2Vb1oUeKDuUHUNDEJvHaS
         eXyfD6+g+a4U8vqeyw4DQU2VAz4x401rmLjO2oNMzcXhWCjlp6GzackIQIBV7A6DhpZl
         S+5tLKHwGJfKOW1tB+E0VSldVMQcTA+zOqk5xSrSI+Vg0C+UyUIjGG7sZiw1rTpQbrg2
         rZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676443; x=1791281243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMSM/kY1l4Gzn1BlIvdJFdJREWDCkpXwh6FxH2SOcxI=;
        b=izsGyZFtREQ7JFgkc+yrjNzC4/D0IHUIGZOzVHjXiRO+ep2yzWr3p9KbNTvuC4M7o9
         w79t8nH5EtQWCyZffYC5wHVqqLRp8c3uzSaawwg8FZzGlQsiqPnqbXhjxmGqktAuQ89K
         ksNbRHblUd803E+hNiq7VoMKIRUWMB8xzplAo3+YYxyl59+sdGGFcmSYASGsGQ2vL6VA
         cDccPXU4ecL+sd+y2OSRQUC16q/n075GN5W3JVazpHnSIfS4q7BLvzcJSAv2cyVy/Dyz
         IHXUMsTMpLAYj8tIVM0z6cOJUvBpsF/UhCa8z7mq7MQLvDQjvFCVZS/XLORwNzAYR8Nq
         wsIA==
X-Gm-Message-State: AFuF++nRV2Ts3m1oyPMvQmooyRrpGalZeT/ihJGQsdE4JpVbyWrhVCvj
	7Gyiqq5vJukFVtF9pFYkNotqV5fqU3I/N6kBlDQsT5t0518vi1noVxTM
X-Gm-Gg: AYBFou0UXzXcI0uGWrxOIKAedojhL5/5PANJZlDEeKtUYw/6SGVBq4NPNr5wIFGJN/Y
	9mbdQaSpJXRbWq/XiNVskB+PXxGRfe66+3gp+7Q6om6z5I9cJuvrGxlNkphvcgwYkVTWfN8YjFu
	EaECNIhNx92yR1wfm/LYa9XfQVFqrAiZFTbBbNgX5ugPk/9THsm05SRqtKVUZEUprv587hsvqWo
	la/VQy9V3EoY4OHiUdxTYj6B23CBgb2qySU51ICNBLc73IE2A5FLtZRrT/Nf2x1wmF8GQfGsoKE
	fMFA7V2Bo86vSh2KlNHtD8G6nTJxS3Xm5dcz2ON2Q1v5jeyx07j54UH941twpRgDp6jJPikI8xI
	7v07tKudefpHD7EvuSh6J1OTlrpAuqgvgGf/CL2BVWfP4XTVTwYDG/XYcXSt1ZaqlDEWiah2job
	Qq5tI3cDN09twWTw3W4REK8vV1bKawNxzDWVm1g5YN2GH4S+ONhP+//3FEUA==
X-Received: by 2002:a05:7022:289:b0:14a:33d:f581 with SMTP id a92af1059eb24-14a033df628mr5250637c88.22.1790676442638;
        Tue, 29 Sep 2026 03:07:22 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e4:11cd::1c6:2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a5ecsm36445307eec.3.2026.09.29.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:07:22 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH net-next] sfc: siena: fix kernel-doc description for efx_ptp_timeset
Date: Tue, 29 Sep 2026 15:36:24 +0530
Message-ID: <20260929100625.50380-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove excess @valid struct member description from

efx_ptp_timeset.

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/sfc/siena/ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
index 0b723a127364..d643e41ae773 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.c
+++ b/drivers/net/ethernet/sfc/siena/ptp.c
@@ -196,7 +196,6 @@ struct efx_ptp_event_rx {
  * @wait: Number of NIC clock ticks between hardware timestamp being read and
  *          host end time being seen
  * @window: Difference of host_end and host_start
- * @valid: Whether this timeset is valid
  */
 struct efx_ptp_timeset {
 	u32 host_start;
-- 
2.53.0

