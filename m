Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B23DA5B0
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691402; cv=none; b=t1/eZ1RYxIq69kw02sm8/ZL7F8YOuSKmSByYJMg+oronz6SsEHbqYVplY+qfbjFA/osZaBXnZHEW66MqM6KgUaJT3eW41E6u4nGsuOOoAZEpF9sEsOxxsAEnRqMcAQv8leRw+RHfl3g1tB3tP+PqzmKwRUcUM8nKd+muMVblGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691402; c=relaxed/simple;
	bh=1TltuWnybZZt+k74AbIku8Gr6n8qILGVs4/kgPzm7Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBODAoiRNmIurFIvytCTZih72gZKFH7Yowh1YKjVHRCnSVxX5lMMmTiuS0lDzYUpnwAcBeyOsWeFqG6agmg4kN5+7uX+Kxdn1iyldwwhTM+kQSrXqntqEjdbPaTUqfJ55TEywHZYEJV84QUJ3dLrJtVv41x5l26tNGKQzV6sMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcBRGIMN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcBRGIMN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso8605671a12.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784691400; x=1785296200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NHyhDTZjnyF9Jy1uHqpnZ3KtVUroBokJdvpUJqEFWk=;
        b=lcBRGIMNPxfANXX1Xs3OSvTSapkcv77+mMRJyknb57Cs33NeRTjfWvdNjFxyTQ5+FQ
         pgVPx4epqhDG0Q9G2ekfGWhCa48e39fBPqVwM9TzllSHM6bht9f1yhXpWPgUMxJYpHpU
         kdBFeQLoLW76Gf2b4nTfKnVYg5BT1TubDJvQJLwtytMGh+LG0NLTpRK6nAdJTJlwhDdR
         nrWrKHMwTLRB2kv4mtuv3xdFwRtaev9f58PBf9QdVtEn8mN0R19gFvCo1RURTuF1DG5a
         PL3o31Xgkdb6hPrxq/F5gDEtotcEJdA9yiFZB9bipOPyBuwUWlU3xddd5u7o/hajicpY
         c7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691400; x=1785296200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NHyhDTZjnyF9Jy1uHqpnZ3KtVUroBokJdvpUJqEFWk=;
        b=dE/mRtVqL/1nE0zwsjw/Z1YZ9t1vM2OSc1gXpM+4/cFXH8uio1dL0/g/jT3tPvCAAd
         rlGbAFPrYyysm/vvMb3BdoDzSjwrUK45P8dMqPWUiEJkJCeODovT7l/65MxmG/QIv/a3
         eEDGZ54jm/rPyjAYZFSFqsL46rf2Mz/CErcorNSiz/hHDL5uvYIdnsQYkwLFg86Rxzla
         XJaZ9197TcGCFC2TieLLBxx0ypyT211tI7eH49r6zIziz5ef1M8vfXOtb/uRwglhccwm
         p9O+KSOT027G5Te8geQh/QvI/UxPp9IqYEL7c8B54Pa0+KczWKaUzsu7aaTl0B38BOGv
         2qVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIr9CWSJXf6HxP9YdezyM39Z5J0EtwAen5oYpsIXVSxOZ9d/6t1e7ly6R0Xlo674tNrXOUAUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwjoRzVeHe5ISF7XtIkiZM4rZMHVXMYo7yO4LDJx4Pjtckxol
	Xt1lNIzLDNuA/rtn5mQ5IXcbCl0agwBwQIVMttJH1wNtyimOXX9NM90=
X-Gm-Gg: AR+sD11fN2+SQnTWpKo4it9F1aVhu9ATFdo+zNb/Wjkt8JzuYwMMhOb9nWrNwnkDZY9
	1aSsE0cNyDFC9mna5WXGId+GSEMcSBsz5FyAcf253rIcylyyDR/QxPA3GrexzwC0CwbAfkXqr6D
	vILOT3DVUb2B2vsvbPEeHZ2iS9HMj2eOwBSSeWrDZJy3EDcOyWScrghYl4FRcxMZZ99yNILF432
	7zWcwyX2Rpvub+aU3kUhyjpeTCSOoK7AN8s2FRnAXT6b/64TvDx6bjc6kyP4at9NxVOeieTaIm6
	DmQ7uzNWrq3vEz4+8eAR2pUZQ+/ZvmO4F3lcS+1oow5e4ImdgNg/bNxolGWaKiWtkc9NqE6B5g2
	bEv7QvmhaLeDwB1LDdLQAg3K6+yfFiOO1wyel1o+SoeLEUGx5ND88/sPOzVTC7H9GRS8kGzX4Tk
	RglWZgFIIUwdmuWiEM7unYI+ScDzc=
X-Received: by 2002:a05:6300:808c:b0:3c4:2cf9:28a1 with SMTP id adf61e73a8af0-3c42cf93a4fmr1420862637.46.1784691400038;
        Tue, 21 Jul 2026 20:36:40 -0700 (PDT)
Received: from t-rex ([2401:4900:adaa:53ec:4dd9:f3bc:714a:d631])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13015052sm1561599c88.5.2026.07.21.20.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 20:36:39 -0700 (PDT)
From: kr494167@gmail.com
To: ioana.ciornei@nxp.com,
	vladimir.oltean@nxp.com,
	vkoul@kernel.org
Cc: neil.armstrong@linaro.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	surendra <kr494167@gmail.com>
Subject: [PATCH] phy: fsl-lynx-28g: propagate PCVT enable errors
Date: Wed, 22 Jul 2026 09:06:19 +0530
Message-ID: <20260722033619.10647-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: surendra <kr494167@gmail.com>

lynx_28g_set_mode() currently ignores failures from
lynx_28g_lane_enable_pcvt(). It then updates the lane mode and reports
success even though the protocol converter may remain disabled.

Propagate the error and leave the previous lane mode intact so the caller
can handle the failed reconfiguration.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: surendra <kr494167@gmail.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 38afcd081a2a..1fe406adc83c 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1003,7 +1003,9 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 
 	lynx_28g_lane_change_proto_conf(lane, lane_mode);
 	lynx_28g_lane_remap_pll(lane, lane_mode);
-	WARN_ON(lynx_28g_lane_enable_pcvt(lane, lane_mode));
+	err = lynx_28g_lane_enable_pcvt(lane, lane_mode);
+	if (err)
+		goto out;
 
 	lane->mode = lane_mode;
 
-- 
2.55.0

