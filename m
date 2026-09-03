Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9342C4F8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420800; cv=none; b=bZaCIL4uBed+Fmq4qd13o9QsG0FqUv4RRhLsafkDhJxE4dWJiHAqThAU+QcK2z7ctIPLTPt8F7ZSEh3XHffXSHV/2tUfMFDk4qWQW1x0p/B0jKO+/n/wZt7j0YMnT5dMX1ajh/7UCEJ5Mjm+u/suvOMmCsfw6Zxc5lEbK0p+A5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420800; c=relaxed/simple;
	bh=5qMEuy5eGy/JVQD+dpqf2Q/66DUF3xuDuOpkz4CMcPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5HPRu42ti9DnNHWiLfoABCJx21WbfJ3efLCtPTCsxa2VQWwFm7wcAYIYGVA0rrPGiq+2DP1GoYmzURCALunAsNVswZGVGhOf/tcq/1pOmVAJWBiTFSfCligNJikA7zf4vFDVtd93rC/KybkNX5zURCdvijWhHurqRzcRrFNsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEurpcjX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEurpcjX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2393635a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788420799; x=1789025599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQhuxUhRanThkxdEOXasCJ4w6JBVmta7BprVKmAc0/A=;
        b=GEurpcjX52Ed2vWWK4CVPakHBMV2l3QjDELSaX/KTPh77hIS3XvtwyistVfUrIkRuD
         Qh4oidMzQ5+CvFcPioFoLxkHxkB6nCS6CKv4KJOjz9gS1yA6Icg0YBskyywgDV/iS7Ho
         yb3qTaAv05w0ci4KUQLKEm4n7L90vklfDX+A0Rn10lll3IkK5GlICQBQ+nTdfr+h5E4g
         JrtlU3IL0xS6P2hWaQT9V2IDAEsYZTMqWWefl7xFZmLgcsEqOrHQelsyIrRt0ctOWR8X
         O5Nn1JcRx0QOq6LuIq26fyEntC1aFENTiKVm0I7KMfjCYgiXNKKjIyHeZ2ijqxpr7on4
         S0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420799; x=1789025599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQhuxUhRanThkxdEOXasCJ4w6JBVmta7BprVKmAc0/A=;
        b=dYqfgeCmh7+HuLoiYzsUp0ab1ptRrXGLvQFXHMUQRoa1Fu4a09rfTB616tcM81LMAz
         mVB+LIvYGjM2/naConcFQWC8hxX/gm34B8WJAiqyp48eFWtigDkMP+Yu9oluzulpFX+r
         z727tickcVKuyxy6qoAlNZMQyPBRFgWRN2vOcxh4/+hCo/rmzOwOc0qT0El/hxw8zMpo
         gv9pToyouJBbM2WaVU9Qp13MZG/WZY/VaOVVqoWFqSiHBR+G3iI6/YmOYwoFMRR011TX
         nW14BPIgQVEtWfjz3iHY7jWPuUWJ2nMJP2J23SSaJsGPpdCAqLzmBquMWBK2qzgzeKQY
         pn2g==
X-Forwarded-Encrypted: i=1; AKwUvBywSuQhfFNhX6SFkaPlggY7N6aPeTeqn+nyhOeY6368ERYJnifIIote2gDahOBFV+2cBtn3sd0=@vger.kernel.org
X-Gm-Message-State: AFuF++n65mI4KRiWHrpqb1w7zmbzC6Wss5T2XMAKDmOFhcjFKIFQ7qO4
	JuwPr6hjWlHMruTDB0V8+kLBbz6ll0V2500oKATvwA5b1Et4CU42w6mT
X-Gm-Gg: AYBFou1uAxWtOvoUZY3vCqtDexFSOD37McTAC/xdrVoMwqS4Nzy+ldJ/e0situdaD05
	4gWRRop/rhXjVbzEnvxSK9Y4KvedxYFH0KUcG0OkmDj46wlg7FNxlTX2eEUOtiEF5hUXopZIOLf
	SPvBwaVw6aFzij1S9h+hJ0IJAp7aorr3eVW1ObNrbmzlOnmyqfJ0Hl6E1msRnsyOSDVcZA2FOYD
	bgQ17r8MMTcPoKE534zvBucJ+A8osY6yLvfbQgPqDnD084B2DjrrsiopQdMitQD+aNxREI0Orad
	XKRysovhEkZvHkLXY6xDva9izSrJzWTkvkIpg/wJ6HfFnq95z7K231qpfGM2JQU0DJ+qPmoK5zH
	wkx/yEYVMBzi90T4cAjY4DqMleks7CRxxeuT8rhFJ7CH5zMTbhOIXMLxnrQukQmqVTVbVx2sagy
	EQnLq0CylXobR+8cUhDrWUugxGfZX4vXRSbwGtzrAL0tgCYCAla1/U6kobwJQCJrM4+1QHiYodh
	v/LmCjkhsgUpNlrD+WM7Gv1ZvthW3caZnJTGf63etQbqJbAUShs++5Qcl6pvYQMsRqI16vTcg68
	kWWR
X-Received: by 2002:a17:90b:2604:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39aedce056cmr16042015a91.0.1788420798943;
        Thu, 03 Sep 2026 00:33:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08624f11sm3606813a91.11.2026.09.03.00.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:33:18 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Robert Hancock <hancock@sedsystems.ca>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v5 1/3] net: xilinx: axienet: Propagate errors from optional IRQ lookup
Date: Thu,  3 Sep 2026 14:32:50 +0700
Message-ID: <20260903073252.339250-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903073252.339250-1-phucduc.bui@gmail.com>
References: <20260903073252.339250-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO.

Another call to platform_get_irq_optional() in the same function already
handles the return value this way. Apply the same error handling to this
call site for consistency.

Fixes: d6349e3e14c7 ("net: axienet: Mark eth_irq as optional")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1722b7038f34..207aecb5f8b9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2975,6 +2975,8 @@ static int axienet_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not determine irqs\n");
 			return -ENOMEM;
 		}
+		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
+			return lp->eth_irq;
 
 		/* Reset core now that clocks are enabled, prior to accessing MDIO */
 		ret = __axienet_device_reset(lp);
-- 
2.43.0

