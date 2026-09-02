Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AF34D4D6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314250; cv=none; b=mqTMX4CCtlrpjbAZU9Y2L73l3w18IqYhldj9KvjBvsvcvA/6tYbLiqgLBfiF8A7oRUbwD+0Y22nOYL3F1MIvKHso/s6MufuHPARjlVxCx9crt/BOge799UghxnLPYNXwQa6xylDbomEF4V6QVTwHq74BrArxetJhBkkwpusRiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314250; c=relaxed/simple;
	bh=Ik8QSbgXP5buhxF8hVJJ2LX4PPnIIT1KbX8G1W+E0SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR+4Gz15sXQSL0Lz/E3YQuPy/xhPjOpb4JybyF0zXemGuSEkpEzD6laCI9DTTI5YQp16zzODb8XYD76uYXTXPaH3PEX0SYpAmaF6XT8wu6RcDLcqUTV5x27qQOjv7aJ+qWe2/MiQgSd2meOUb/er7Bdj0S7/jIvJvaBCP/X2ypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=vq7vIi6+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="vq7vIi6+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so641917a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314240; x=1788919040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8NexaY5OOI9G959hLH28cElmfzdE2NH8o0S1EDtR7Y=;
        b=vq7vIi6+UoSsgixFtBE+wtmsAHZF8AYBbcUrQGvXEDVqobFBjGu8jYbDtx+XbjawV2
         x08vwufGQPnlR+9M+hTO1V1vo4RlslUWh+TyuPqVfdBB5YW4jRx6fWWLbWnK6a8f0U6x
         7K1v6lqUN6smgwe5A3sYwajZHIo2pD6wuf+sVRMu6gOCRMstrPN2nKe1yhJyMLjxNtSL
         tJwM/gN+dEDzsyQm6ms04gjsUV5qA/hEb8sat075+cu9C+1mYys+G+/XYvV6FENN0Jl+
         AKqnXOcSBt6OAgTSDRQ3H5RVw7n79VvJEQ85z83YOEEr7FM0Tj8qhUgWE14Puh4bN5sF
         7saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314240; x=1788919040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8NexaY5OOI9G959hLH28cElmfzdE2NH8o0S1EDtR7Y=;
        b=a9VpTEvucbokuI2gwY3W2igOrNcRn4SH+bcaVasMxile7YZcUFKwuswkR2juqyfyp0
         TUAp5eTSIVssp8knklU3hedBk+NkvXlsuJJKTXSdC257qahDi0tpR5qESU6Hwf5VkETV
         ttBd8uR+rBXbgxffc3QPg4xCk/HhSALZJXG2ADAfaKJpKQrO+hdU4oK+VAQGHJfhk3WI
         OUGbBHy+oRWRN5Q5GJPEGRFNQTQjduySuAaHlZSU3iW8s1hJ5RH58Aj5TdjQHSg16fsq
         cL2yOV2bcIxutrxuErXtjgz2X54jD+oxojIQWjMvU8nXTHZf8ItUE28R61V18wVVXK7J
         wZXA==
X-Gm-Message-State: AFuF++ltfF/kmHfpJNcV15KLnj3BhqVrPHoDGfaMcdCzXrNyr2ndiNkW
	EvQZMnEQW0svVI4Lj/dN8MEs8R9ZPt0LjmgIJddCqPLJpwEyfYWhnd0QZKZt50rO7QpKE9vEqBV
	jb64NFic=
X-Gm-Gg: AYBFou0qPn1LzBV+LeQeiOAvPVwD8dTX4CyYflnlgHbZ09DfbFFQHW8D7XbE8kYtWj5
	I2qGTlvQcafYkdI4O+nbqVo4RcxBSXPUQFXDe5OOMh3dkJbX5grquTKq5uCTN4cf+OinXF3l53w
	t+AC4fJ0YkozbKo50iMVvOfXnWBNFPmagO41SXzQhHJYMbxm4enJYflSsElnAJPnMdAgzdhoaf6
	M4ZS5U6Ojg4LO3/WRn16TbuzMWUUw8W6Ay5QPeSlfT5opEj4bYm8w1HCd1u0iU+XtXXb8OQ0BcN
	i4v5ja3qXmfu5WVYKZD1i2hXBvcBWnVSRzGjLP6hO7Kj5Okxts2cRyJLXhVi2iTlFm5x19GCs7W
	d3XfzXzCUWUBkBj1+tyF8jKWi7xyEMV8s1qDyzJjEl1VXU7N2mkXsp8CYG9TpN3yW0FGsVKIx/5
	ZfSNJ1P9LGGz/MWRrR0LnuRRsiWHk3wV0lOiWMIBtR3rk=
X-Received: by 2002:a17:90b:524c:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39aedfb8ebcmr1991272a91.7.1788314239469;
        Tue, 01 Sep 2026 18:57:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfe6b6sm2346061a91.1.2026.09.01.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:18 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Edwin Peer <edwin.peer@broadcom.com>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 4/6] bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
Date: Tue,  1 Sep 2026 18:56:47 -0700
Message-ID: <20260902015652.2421609-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_rx_ring_reset() frees the ring buffers and then reallocates them,
ignoring the result.

bnxt_alloc_one_rx_ring() can fail in bnxt_alloc_one_tpa_info_data(), which
returns -ENOMEM on the first failed allocation and leaves the remaining
rxr->rx_tpa[] entries zeroed.

The error isn't propagated up, so the loop in bnxt_rx_ring_reset
continues and at the end the code re-enables TPA with partially
unallocated rx_tpa array.

This means that when the agg_id from hardware is mapped to a SW index in
rxr->rx_tpa[], an uninitialized slot can be chosen which would hand a
zero DMA address to the device.

Fix this by falling back to a global reset, which is what the existing
code already does when other functions fail, but unlike the other
failure cases this particular failure has to return because TPA can't
be re-enabled since the allocation failed.

Fixes: 8fbf58e17dce ("bnxt_en: Implement RX ring reset in response to buffer errors.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3755a30f8d40..a8e5fdfcdf59 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14604,7 +14604,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		rc = bnxt_alloc_one_rx_ring(bp, i);
+		if (rc) {
+			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
+				    rc);
+			bnxt_reset_task(bp, true);
+			bnxt_rtnl_unlock_sp(bp);
+			return;
+		}
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
-- 
2.53.0-Meta

