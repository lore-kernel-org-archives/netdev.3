Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D834402B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151653; cv=none; b=QoGltchiKafkUc0TUUfiGxZdGPVr1qVdkLHotYRMLXmPR8TKapjzOoLN3tVti3whFmubvEgorIjovTqA87SesheUK4OVf6KcmI5+MajzkUyF6U+B+hEhypIRxWDfDhcorL2GXs13QBXK7TY140lnsNhip2+8Cj9Nuf/a/PwvewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151653; c=relaxed/simple;
	bh=/uNY/g5ChUlJgLBBMSykVUOOf1H13i8PXVVv2qrFlf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CURGS4kBFr2ru3AnIrZkVnraoRq6ND8VEOstMTCrGYbkmlS9mAOKeqWu5RSPiNP3oywxxJdPlMar/SfC09woh3lNpojYzCwhaMcCksEmduFMo/hPAZHWeUC0DScoFazRBCy6M0R3OjA6xlkI//KI5udOGed4JzYeVrbKQ7CDLVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs0fe24/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs0fe24/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so2670557b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782151650; x=1782756450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi8XP4plZxmYEGI/WLe/p7dZpHRmhylxOAFEFxTCSE8=;
        b=Fs0fe24/jJAP4XKZ8KSo3g8Fv2yALDxaJMf1FjAHpr/F1VPFZSnAwDDzUl6NP/D08/
         xz+1mJolhJcn2nX457juO4sJ3HbmqGfMAiNrOokgn11fOcA4oZ2ZNdO43MPA8tNyHfY2
         9Jy7Tf1+N0UfBCvEltzxD8ktaTctJueCEty01/RCWbwT9GckjWnv5U7vS97S/6tEsNww
         XcfzYVxrpEzQyjOyMc8VHD7e+V79nwdDi0rkYQ6kcNEYh8SXgiySDWXI4dInppZELzSn
         Y0271oS6dULFkWE/rG0ewbFTy4oXrK5yeCg7TVx4fxyNSZR0x9oWyZAhlPB4V68pRa2G
         gnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782151650; x=1782756450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi8XP4plZxmYEGI/WLe/p7dZpHRmhylxOAFEFxTCSE8=;
        b=k0TJeXt1SA88s48tik3wpmGCN1qaviqisSIzbKaBXr9+MC0NiUO83sOWFTRGxaQSHq
         BoVMFAGLCfNjxPTmbYMqP6jRnYaxrJ8ep7htEcEL+yslSWrirC0qCUOUGkKd5T2reioi
         DznOpZ136jrc1nd2QGx/S+Cu9VpkO9DVA6oVcv/QlSjWE+lRNPxmcwiy9oa5021FkVnj
         tzXuHKgGxDGqzRogwZkzTo6Xc4GgUugkW1Ula9compFwL9I5dkppngTZTjCD/URPsPJ1
         21okwcHeBC4bPb1P9+31EOfVsDuko+TWz2sGMg1FirmVyUZg5B6USIjugFo51Rgaya6Q
         t3Bw==
X-Gm-Message-State: AOJu0YyknuWYWQwX7d0XN156G6mmfLWsmEMXWSli3oSL2QBQr6hLxaOj
	6yypKTCqaSPOm6EPjYleyxvxpX/L7uPUSIkynDN16eT7OQxB0SYQR4dh
X-Gm-Gg: AfdE7ckHPYfHLDtHhmpgsFSnx1q2+28TcNssBQzOAXtuLulbZyiCbwcgoRsNCC6/Oiq
	xxABH6UqceQ8AG+PBhlj5AZ7MUNUwM67G1i6fqH+n+fAILjCwK/IK22UNz2iR6hca3Hr8slx5pJ
	yTTei/yvyrLqucSeFtTF77+QeDxyRTnjtDCRkJrFIOU210YWIf4ANL+Vu1UwCuFZHlEs5TPPa0Q
	T5ll+34bXRANeNHY9jxvrb+UUOgKlXSdOgoRqgkUhsA9hAxsJ5XPKCZ95fTSMXME8+V/B4ImqSg
	fnUc3Xxhtd0j1VDdbxnwaG8jXQef9rDvXKeN8Kf0F64cVua8k/RDMGy4II6QPqTLfx/D02LpTOs
	d0tKfglA7oJ+yiz/NiO5BDILFmbycAqOT3AWIc0G5taZKZOwkH6RfhA2LDXoBLkcxNvvpPpLTQS
	k9BqiV+K+ttAUuxLT9crwmWcc44eXqrZgnS3jeQnma4yJavhQQNQ==
X-Received: by 2002:a05:6a00:408b:b0:842:2ae0:968d with SMTP id d2e1a72fcca58-845508aba7fmr16499668b3a.32.1782151649625;
        Mon, 22 Jun 2026 11:07:29 -0700 (PDT)
Received: from wells-linux.. (114-43-109-86.dynamic-ip.hinet.net. [114.43.109.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3212sm8419888b3a.55.2026.06.22.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:07:28 -0700 (PDT)
From: Wells Lu <wellslutw@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
	Wells Lu <wellslutw@gmail.com>
Subject: [PATCH] MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
Date: Tue, 23 Jun 2026 02:07:21 +0800
Message-ID: <20260622180721.28334-1-wellslutw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have left Sunplus and no longer have access to the relevant hardware
to test or maintain this driver. Mark the driver as orphaned.

Signed-off-by: Wells Lu <wellslutw@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f843d20b..30040fd65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25928,9 +25928,8 @@ S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
 SUNPLUS ETHERNET DRIVER
-M:	Wells Lu <wellslutw@gmail.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://sunplus.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/net/sunplus,sp7021-emac.yaml
 F:	drivers/net/ethernet/sunplus/
-- 
2.43.0

