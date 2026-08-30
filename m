Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D5356754
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788132141; cv=none; b=cLuoKuVIZXC2gkqsCBbmUnwvRw+m5e06LMtruCBPaBAnED7S1+So0pvE2LDupb1616yPCkMoLWBQAKcqwZVOvgK0a3OUuZxEDQTz0En8K4Jl+bA1bfR+qsAlsCFg9hjAOlQMOqVkzeQkZTjEnIG2ARQiW60Ga7tJI7UM7B7sJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788132141; c=relaxed/simple;
	bh=Vd7t/VCSbdHAy1kCjXH7yJArhfu/zvuWLMP+dsSFygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnIgF6LSSuPfrFTUpHgznU3GNKSeSFbBOKo1NPvxWJktdAs502nLgZf3KmMeeA5yZLtNQnxM4J6fYaqePED4dev5xJyOX6A+mA2IboLL8Pt+9HanOxj66mAsNBf4qVp0jiSIalkc6KA+BJQ5GNa6HrnNDMqiLWVfijz2VOneTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE0qg5du; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE0qg5du"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8549a96e93cso15809487b3.3
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788132139; x=1788736939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0uXGJNgPYreSiDYBBxdQJQqH0DPau7askhrNGDyNQM=;
        b=iE0qg5duG2FHjiYohT99/cShNRhkZm0iwr0LTazbY+7t3b9/02VqF5lqZFDbH9FVIl
         1jNm+etMm/huph6IHLrTYu8oWWwftiOQtItCftr3yavotrLJsehMmatcxJTWrtXq0Sx9
         aVWQedlfiiDtxTmo4Q1Z4jT5ReXDMv1MRuQ3QtBaNMZmr22TByAmUgOqTYw8meHu2Zo5
         CxVxmxOjCZJtlUO+FL2tzawdzj5vk0o4LIThCk76vAXJrH9FRa+4S7MGicOp0g/viVRM
         mRZWu9R5rnrXNVAYlotxH9UKs64Z+A+y4u0XQ0bNX9yWe5gAgx8n60Nm1cT2T4NnVY8e
         c8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788132139; x=1788736939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0uXGJNgPYreSiDYBBxdQJQqH0DPau7askhrNGDyNQM=;
        b=Ly3tuvSMP6jA2eR87r63q5g3WUjxDhmpPOO98bFJZIiJ+e+N1jm4BUHl1ac+aY5T0W
         pKFkIvNXGvGUg7kiA/6cs6yLNpL0SC5URpC2NeO2AXJsd0ZuzfLJlTdEctWl6sm/ttOW
         ZtNj4dTNwXhTnwOK0le87WH54fwCvhJLf8pri5L09GrAMK6aWx5qk9Y4lBjp4iGyLQZj
         5h2SHbifPmhRsmfSf/QTeO9VqMrEOuMEDKemksB4OrMbv3Jjt/AjY6ojsW4BqAo0V7qU
         Eb78Qe198zr9BipNTryksF2h5nb1qR89151bw1HntVH7XOmuC7EuGhORzAz9R3Hp9Zds
         nkEA==
X-Gm-Message-State: AFuF++ldmsAAv39YKMuXw0/v2IWgj3E1zOjjoyAcRvnKnPqOvRxTC1Af
	CY3Ge+5Hn4dyc/nHa4AFWvrhEOuUvGzmK5wpC8vgXbgB7whaooG08+tX
X-Gm-Gg: AYBFou0LDfLGhOswMbYmC6P77EF5dQIpJV9YumxPSfCQxSr4xBcPOtmE03bR66FEI4y
	rhAbMfmfDMx4XzJQrPTd0LyiwotdImKgY9FxUGW1mndKSlGl3+kDLmT8jVUGpuKYunhwrIj/tX+
	R2ukRC0+KUc0575RQUNUAUdBzizR2vg6IfCgBJFOJpytxG+7sfFMCXfL1Wg/MtDtBYHwV0PyGUQ
	vlP7rQA02b9exJRnm/LS9kCqUzQgyBBv6Rm8QCgJ0sPVEZp1KxBvYXF1LoAJVOXvkvKqkdz89cc
	yAwF9o0wHC5w7JRWoGQzekQA/61X4YKHr6wMTge9fyCPdg68+upF9hHTtmNbMdPwfUyuchE68st
	47bJkY2RjPuutSQcNGGPmvRf5AzuRRqLTPkH0GGN9y7LIU7F8nXKOaXMyL/YD2pqJyRxCP8xXOU
	U1JBqJZg/jPICt5bdFepvMzNG02lL/TBbwt00mZicI
X-Received: by 2002:a05:690c:6912:b0:858:d6fb:2b9f with SMTP id 00721157ae682-85d660db315mr76627717b3.5.1788132138950;
        Sun, 30 Aug 2026 16:22:18 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 16:22:18 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Date: Sun, 30 Aug 2026 19:21:39 -0400
Message-ID: <20260830232146.36948-2-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830232146.36948-1-tactii@gmail.com>
References: <20260830232146.36948-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the hardware is configured to not strip the FCS (CrcStripping=0),
the jumbo Rx path would deliver frames with the FCS still attached.
Follow the standard path's convention by stripping the FCS at EOP and
leaving it out of the byte count.

The jumbo path was omitted when the CrcStripping feature was added.
Since v3.3[1], the jumbo path has only been used where the page size is
over 16K, which practically rules out LOMs, BMC sideband, and the need
to leave FCS on frames. The bug is only reachable only by setting
CrcStripping=0 on a platform with nothing that needs it.

This change prepares for convergence of Rx onto the jumbo path in
following patches. The set of h/w routed through this path will expand
to include LOMs.

[1] Commit 79d4e9087a6e ("e1000e: disable Early Receive DMA on ICH LOMs")

Signed-off-by: Matt Vollrath <tactii@gmail.com>
Fixes: eb7c3adb1ca9 ("e1000e: fix IPMI traffic")
Assisted-by: Claude:claude-5-fable
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..599600ad695c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
 			}
 		}
 
+		/* strip the Ethernet CRC; it may span fragments */
+		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
+		    !(netdev->features & NETIF_F_RXFCS))
+			pskb_trim(skb, skb->len - 4);
+
 		/* Receive Checksum Offload */
 		e1000_rx_checksum(adapter, staterr, skb);
 
 		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
 
-		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
+		/* If configured to store CRC, keep the FCS bytes out of the
+		 * total_rx_bytes counter
+		 */
+		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
+		    (netdev->features & NETIF_F_RXFCS))
+			total_rx_bytes -= 4;
 		total_rx_packets++;
 
 		/* eth type trans needs skb->data to point to something */
-- 
2.43.0

