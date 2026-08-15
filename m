Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A11E98EF
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807066; cv=none; b=ZWaSxfnCQlYm3VhpQOBZ6icqfB60pV18t9VkqlcO7wrQhXFGSM6y0YDwwzPmHJAkxEWoKwlBtKxgUCuJiN5HoUq8HnkFX/Dym9l07xzMVnDRhQyttGJZGBMKt1QnV/ZbzTslRnrJ016I7Pc5SFw7N26cmJyBn5yzEkCowtm9wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807066; c=relaxed/simple;
	bh=2hxmW94Ek8ehSolOWjXwAwJbXBuSZJ7x17/QTqOc8NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpFEIfb8xReOcs6Ud/2aQupazS56WKX5JpOdBcdAGXRkhKZN3tlTeUtRFMR7OCbs/cSTrLVVa+gmswabkrZOTEoD579E+prvPjirGZVaB/aTp7aHB0jby+bo2N+0PXb5sFvgoPrAzVpvp/NOTdQCpHHxSg4QkFwwCrLyuOl2zmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLcYJ5K8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLcYJ5K8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc97653887so33772915ad.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786807064; x=1787411864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcWSfdSSYCgCNkMPSpeHhusssgttiSmPauVCrrfM4Qo=;
        b=nLcYJ5K8Rv29xC9QMt7ZFvOZM/Xa4rKkPuXMPoAElKJHFcsXmI6KTjx8wGicbfkL77
         tEYjg5gZMYbwf+SiiveRRKNhNVWZMXLD98rqILjDnBGw7mB42R2Rf7vD57iFt+Nqc0MJ
         AKs8JqvJdYbviImaDCC8YZNHRQgeZI0ivYmZrzj8U7i6x1mgav3E4KtIQVW/mJ4tK7id
         PB/0hGu4Ov7ZZIHsk+rOrR+/Zew3hJRU2kL4zywUCctw9fFvAkXIsWuZdYR5xulOSAG8
         Bj5Y3Cg2frUtgn0xh7+UdBnOIvfiS9AGLpocEZ2d+yv3BeoYQYIictPiA9ZNhgF3mcgU
         lOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786807064; x=1787411864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcWSfdSSYCgCNkMPSpeHhusssgttiSmPauVCrrfM4Qo=;
        b=KLspGE+ETrCfqGfVtnZG81B4sPSclFP4dY/f8XNl52+4FKOk3c7O3HMADvves4p+yP
         N4f0IhcFhFLJoXIrqfBoN1NFtRRR3QGOdYYzrin+ZWOAa/eIV4DO7tZ/PPBvadLNxnmg
         QFdPEf2iRlO0XaFiVTs+frpKm7sbDyl6ZocVQ91UcqQ5YucRAOFjDxLHPlA5oZhggcIW
         dOBkeEGoNtqUc+aMVuoS3uWawiQ7syGiEsWGUgNdPcPBDwTKY9A5AtW523mpUj0tlhQR
         2Wgn6CzZt+ektF99ECvvKgsWsAXhgrqpQukSqvMO8OTrsNKVLI1Ogz/5lYDkYwXneWJh
         buZg==
X-Gm-Message-State: AOJu0YwC1kUnA8px9QGggTPqTI1t05YX7vO1SWdbKr6PuAU5RjX/VeXL
	yosJ8IgNhhmtqqxAwLBF/THORhq1RP69zmxDPJuDtDziAKvgAXhb6U3v
X-Gm-Gg: AR+sD10QyDLiEhYj5LQoPYV3MHBSMl698VuMvUPlwaGfiY6j4u6Z4ThYiz4Xopk8QiE
	djdz7iH5j5P6N7Tb6jTOr2jCFVAajUJZvtyc6mSXkPdrrxPjiGKYEAG9y2M5X5/fnLzEWzNxXAJ
	qog1jqGLcss9zXuRwBOxq9lGtIBpHM26VMj6eM6yKygS6ft7p4DNxf6Vo6ucl6W/tAYUSwg10Ku
	jcXqpcFXv8CJ3dvpOyCGq0bX7jouKt+6IuLbjmNXzlp5geNOCLx0T1mDPuJW5U7Ut3xa4WLhrUf
	zVVXyqqnMquTFWggn4e+0FLE0NMm9McCuRfAcAgkY5c7a8HLpHMOTmGLJkUZQ+1NcqwTke0Qke0
	VniLGYmHqCJIyOywo0eROjQlXfyi41iqshr5q9x6GONG0dMPzYPGUJcMc6q66rUc1NNkADN84vA
	xN1Xjyl/JKAs6KyZOpxOTPGyuWjJlki6AZGNkyGnLpDP1ceBxC3HItMEcRzR3rnDz5M2D5XsoZS
	y1v+bYmMTzLGek1L1E=
X-Received: by 2002:a17:903:1250:b0:2ca:62e:cc4f with SMTP id d9443c01a7336-2d3b0f6e3a0mr145318985ad.23.1786807064198;
        Sat, 15 Aug 2026 08:17:44 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:5225:2a2e:8e7c:13a7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7aae00sm20326745ad.22.2026.08.15.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:17:43 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH net v2] net: ipa: balance runtime PM reference on remove error
Date: Sat, 15 Aug 2026 23:17:37 +0800
Message-ID: <20260815151737.3758320-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipa_remove() takes a runtime PM reference before accessing IPA hardware
during teardown. If a concurrent modem start or stop keeps
ipa_modem_stop() busy across both attempts, the callback intentionally
returns without releasing the remaining resources because proceeding
with teardown could crash. That return also skips the matching
pm_runtime_put_noidle(), leaving the callback's usage-count reference
held.

Drop only this runtime PM reference before returning.
pm_runtime_put_noidle() does not request an idle transition, so the
hardware and resources retained on this exceptional path remain
untouched while the usage count stays balanced.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 923a6b698447 ("net: ipa: get clock in ipa_probe()")
Assisted-by: unnamed:gpt-5.5 typestate
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
Reviewed-by: Alex Elder <elder@riscstar.com>

---
Changes in v2:
- Simplify the teardown comment as requested.
- Add the Assisted-by tag.

v1: https://lore.kernel.org/r/20260814134047.1387177-1-ruoyuw560@gmail.com/
---
 drivers/net/ipa/ipa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 788dd99af2a4dc..8d82fd5bb24b97 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -969,12 +969,12 @@ static void ipa_remove(struct platform_device *pdev)
 		}
 		if (ret) {
 			/*
-			 * Not cleaning up here properly might also yield a
-			 * crash later on. As the device is still unregistered
-			 * in this case, this might even yield a crash later on.
+			 * Continuing teardown after failing to stop the modem
+			 * could crash, so leave the remaining resources allocated.
 			 */
 			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
 				ERR_PTR(ret));
+			pm_runtime_put_noidle(dev);
 			return;
 		}
 
-- 
2.51.0

