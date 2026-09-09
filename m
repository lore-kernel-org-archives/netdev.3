Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C4331202
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929713; cv=none; b=VOE2LEgPeuGXxOtOoiktehzpGIogRCWSdU1lkjQz0DT3jp0jGV1qrS9gGt7vFj4fadIbL3w/KcFbC21y22y8Be9ry3Z+K3gtaUflDFpvdEVShh9dYppEB6w7W3FBZJwuvaI7E6h48ilRwONkUhZjNIGadI3kPwY993ySKN3vI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929713; c=relaxed/simple;
	bh=/jNbC5DebhzK+Aiemy35oWPeEdVyuqm+UDXrJimJ528=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0q2WKSUh90bdklrzfjsF1t0FXkOI+E3e6XVsrJ7Zady3i91aO9uM1hmcrHbC0SbGU9tqoEtEQ5cxW0WEu7uR8o53VufWgtirMd1ZobI18HtOFCDcbAQslMyoWFu5g9XWYb/8HTRWB+DO4BXosBUDgU2+1gt+IcXB3SQ4JptxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiY83OCH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiY83OCH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d9db539a54so47981895ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788929712; x=1789534512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wu0O0pJmWewYzRf0DSsVxXq14cBDmhqpv1Ta+hWpqN4=;
        b=QiY83OCHg8V3QU3R6GHw2HdmuCNbyXXCNxeZ43y2I8Z0e+bsv18NUQdYRhwfEXaH58
         BZ/4i7vAwbw38rG8B4r36v/2Iq77+71UbQDPclJkeZNowtEQuHYX/uM5Qnwx8ar3pkMt
         wSafHYswYazLg8oAGza0vDmJjEgof91d4vV8LoBKE+icKYzmWEFhYMUsYDslQ0HxxN4J
         zOJhpEHQBVHA8K7gUtIbNP1INDldk728dRCVJigBbMNfE7dndhyF+APxviAyb0wRUDUs
         2Z0GXDK61z178+gFqwS1IUIBWpbLklqOFd1m4Xc30+VwQxnkFeWyzb2VGd3o/XTiDbQU
         O9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929712; x=1789534512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wu0O0pJmWewYzRf0DSsVxXq14cBDmhqpv1Ta+hWpqN4=;
        b=gfGKzCoedbLJudt9ucBEJ/UxqDe545ecRxYJcDEkfjsuNzUkanY3O9eSed7p3kkfSa
         lxaJS5Be2u1rsC5RAkRBQnLxHKpa5nlmXFFHZ0K//N09SLAHRT+ldX5P5kBgIswPOp7Z
         IpvJUn5XgZlX/2xlhhE0VYts+Y7rbkSoQlJ13WPyzu+rMxHvq8OvkRgKMJFiAsWKd1OG
         5cWSrrtt23smvGNrcwfPHl7aqe4bsKIcyMBfGf4/YF9ouwwXNs3UqyhickQzgRMhBh+a
         0YV+S9goUITHog+HMw7qMN3ee9ldsnjlpAOZuLjCYHW4w3yV1XiI7TFNGQGGDjObgwZg
         F9/A==
X-Gm-Message-State: AFuF++klBScHUUMDj2lgqIPATl5m3NQhNhH/0tqoKiluOdWBvr9SYXa0
	Zb/z/RQfCtLU83xllkefkh+XqgC06LeAPf38lYm9PSQxYTR27n/A/OYI
X-Gm-Gg: AYBFou26+qHX0tsDj44+pc6z9qXRLQ2jfeQZ5VS+R/3YdYhb4XRMJcZV9ytYjz3kxy6
	ZzLJmVC2JbYpWmomz5p9pl2gfsViuh8yAgh179+xa+VBrWjtjZZfIqe+wrWLFhn/Bnd0bpy1iJV
	6j419kpIJkUzzOUDqbUOx274F7DN/nyit7i49UL/QmKA63aB8AdqEJk9fGpLu0trTbKxO//nF0+
	BRmbJZmNfBrurYOW+s05P34WEWtSthSirdYh0hkyXWA6o+oZT7VMIvmsKtMQRGeUhEpbCkrC8P5
	Z2Mk0dx+J9vFPovg9Qpeg/Je0R6/xAynHUx9QeKqcp28nvASxQjIk2L/a1v59kr0X+QSQzH2ep5
	P7XVVjH04ipxPP2h7sTsd9QjfbUEazTyEIyqPMoKBmLId9kxSS4AKla1eGVhqQpxEy0Q2+gidgT
	QXUqmoje8OdaK770CI6YJHHsPKpBU2k971MPElCy2mpTEnMjQuLB2a/9aeC4vicv8M/0Kke+CIi
	rrZhyk9r/T8RKNPWiyIH9afBbjI7wSk8/upJT7J97ukrCJJjfyT4MKj1NVA0cdkAMxLQPJWyeBh
	8R8hWoMoVZfrshE=
X-Received: by 2002:a17:902:ebc5:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2db1231f623mr518417745ad.5.1788929711582;
        Tue, 08 Sep 2026 21:55:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499e876sm66688505ad.56.2026.09.08.21.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:55:11 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v6 1/3] net: xilinx: axienet: Propagate errors from optional IRQ lookup
Date: Wed,  9 Sep 2026 11:54:48 +0700
Message-ID: <20260909045450.16176-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909045450.16176-1-phucduc.bui@gmail.com>
References: <20260909045450.16176-1-phucduc.bui@gmail.com>
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

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v6 : 
 - Add Simon's Reviewed-by: tag.
 - Drop the Fixes: tag as this patch is intended for net-next.

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

