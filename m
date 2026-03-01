Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E72D838A;
	Sun,  1 Mar 2026 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329166; cv=none; b=TzvqfFg2e3dKQ870vTecT3zwSIlpqSVU1EDTjjEBd5KyqEdhve8Sin8OypI4ly5fCDCCkBKFJG9ZCASkCFZcngo9Qp7aMnhkNd1TaXHQPzyQzDMdd3uYjPBXK7PzW2+1WQduleRs6IC+P5adi9W5mHoKY0DPZbm9/My5e2WR9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329166; c=relaxed/simple;
	bh=cmI80WFwdb+F3WMycJ8FKf4whAL/On8tRfEoeZNavdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArRxLx+/ghHog6URMs8DIHybx7JLm1qsq3As8wM9AanV3Mql2LIGWzY+Y3IL7nS7qH5gdRrKqmhQW+cOqr01zb1QqgiXLYGYyMpqIndyk7HvZPneS5pzcphF1CjGqOsotzL19LHKWgUE1MorBYhgxfYNO7K9aDJn2sVf2KDfOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnSVi2aX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnSVi2aX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B441C19421;
	Sun,  1 Mar 2026 01:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329166;
	bh=cmI80WFwdb+F3WMycJ8FKf4whAL/On8tRfEoeZNavdI=;
	h=From:To:Cc:Subject:Date:From;
	b=tnSVi2aXTST+jkaI15jWQmGXAzGqLQ8DZ6GvcuSptfcItN/blDMQHrxMQjmN5FjDS
	 BlyKTOYCEFX3eoK+Bva6jRVmBqnOYY28PttU2kkcaGPB6jE+dOw54Tp1oNE1cyil9H
	 nRT+af19ECS5STwczs5D/vWuUkpDp2Z0ynIOjGLQLyfG6KP/qG/pBbISxjVs4t9pei
	 0Gad7V7eZ9e2OMGOMfpkeRhWFyLcWcE4zKQdiGwoylo+C72WY3VZtUMpb01GNWiP2j
	 MZU8ODvYS7efSM0GCg9nvJE2z0qDi5VhoA7USG+Kk2e9bI1dGBDHVivVUl+9CjK02C
	 77BitedJ3E4Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:24 -0500
Message-ID: <20260301013924.1700389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ffe68c3766997d82e9ccaf1cdbd47eba269c4aa2 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 13 Feb 2026 17:43:39 +0100
Subject: [PATCH] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle

dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
the dma handle. This would lead to improper unmapping of the buffer.

Change the dma handle to priv->rx_buf.alloc_phys.

Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260213164340.77272-2-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ec_bhf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 67275aa4f65b2..0c86cbb0313c3 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -423,7 +423,7 @@ static int ec_bhf_open(struct net_device *net_dev)
 
 error_rx_free:
 	dma_free_coherent(dev, priv->rx_buf.alloc_len, priv->rx_buf.alloc,
-			  priv->rx_buf.alloc_len);
+			  priv->rx_buf.alloc_phys);
 out:
 	return err;
 }
-- 
2.51.0




