Received: from mail-dy2-f15.google.com (mail-dy2-f15.google.com [74.125.229.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4541F37F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292238; cv=none; b=g2m5fpjKxg3oCwU0ExBUs/+wvuGhBRmhsHkjuWAc9q+CsHxf5bthYdXunwLax0qWJUhLWEnfSnSO/0/ez6DoqzsSKdfJq39X0/rcpoeQNPrfhLUwEQSJ/23s/SUlWFFXWsBlFKO/oYS9+SRG9C0REIe0hQXrT6EmA86z18mlJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292238; c=relaxed/simple;
	bh=L9s05IwcaEGjCqGmULp2mdtQR1iZBPLwYB39kXJUY+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrfW+YSujIijbEQUEdugXBQX2bChCPakz1KNWpx3LAUCwH+xX75/bPFoimU4lNUBYu4nmuHpbqzeP1giKCCS1qU9daMriutuigSkxaHydXs7viXItogG6sAlobUp8zOE1diiQTKXZ9+qhwc7M8dP0HasVSnuVcXNQD+nKJx0LQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPdWcDu7; arc=none smtp.client-ip=74.125.229.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPdWcDu7"
Received: by mail-dy2-f15.google.com with SMTP id 5a478bee46e88-32dec843c37so350587eec.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292236; x=1790897036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
        b=EPdWcDu7tiJtwu4f5I6JXYV9QLOIa/4pxo2Aj3St43UfSzA9pT0vpXk3oNR91EfteS
         UpFodTFymMCfFChlcB53SWsKSipvm/qnLhXwZu2qZoFO9LhHhGBnoJ1mXza0Z/gH69z9
         Hj2uisB/VkUuydwwpxzoH3y175vY1G0bAV9Dme/otB55kdRmhUXUI4+cJma0ONUWScwm
         HayNRRvwnQJq19IH+CguRtQppPsM+RfNlISHW9lRu6NChAL6dTsHRdCYyBOQI4QHHFbp
         QasNi0OJUWLvwa8RZOJnA7HYvmN0mCV4jxpUX09R3nfC76O96Bg/xHv3sh0SpoBMfaLj
         43UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292236; x=1790897036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N0BCZSjIX+UY6/4hcfUjcg/hMZ34STcp2U1v/I0YunY=;
        b=hNQMdOtDHWcdWE2FyOZs+sSdvHwwZ+ytW5O4UvddyVQYoW9MYVf8AOlLJdExpNm7Hm
         aQLAa65O2y8rq1m5WnoXGXlZVlaw3XQH4vzmMtZ1wc7WJmjVaa0EsjnMJXLQ19z59pXZ
         TJ3iNB9zdejpgsJgAMApWriDQdOjZMhHZPbqB8ZtxyCYfdelocOURKUBB0Hq3kE/+XUg
         SKCPQYnGObXDSvEisjfkQcldgt/LkvQs/yn9ts4KTADMlmVXlIfbWQ2yVAAoOlstSmvs
         9sgcIEJqzZn6uaJboHDd5OW4P1/f3nVD9zGOo5ThiaowW+yOCXcz41EbLEEtLebh6pYL
         T96w==
X-Forwarded-Encrypted: i=1; AKwUvByrG15otKxPB6UhDsPpBI55kQAk42axxsF2wDAfsPxN283O5hGzSIzpRDu9LxS8iW/O+f0Lfuc=@vger.kernel.org
X-Gm-Message-State: AFuF++needifITHPPbt4cOhqXV6P835cKm81UskpZiSG+QYyLjq8UI5L
	OSgamh7stX4evQ++i4TIRh4XTqZpYo9BrB0NeKyVALm3+pQIABmp7V62
X-Gm-Gg: AYBFou1tWC1Q3GvNC0G+b9EfZUZ2BxDaCjtwdJE6Lvu7NAYIVMMyfA3Pjb8zRJ3phHV
	uvxmxLOTHUMMyixpAJlOd2Q0DaILhT1+/ZtMBQ/cG2/7wYxH6A9km3MBxh8G49P+T6KxKUAy8Lq
	g/rI4FjZVDCgkX/MZVl2GlAFZQvh8980361jAde/sNks0EliSHbiWTwZ40cEr5xSenqGdeId/cm
	XlmqFyaX8sSqsI27IbNV8sHO80q2C3H5P/qlq50JH2xApW4EbqwG/b/bW9esC9PZMJje4HCP3Tt
	1nr9Jny5RP9+JBW3gnw/4rce7xvRb+9Xsg8PBUYgeF6pbK9cESbLbm27RHN90xQp5hZwRcjqxKW
	olN0y9/ogWVHThkUStQzRBrF6KCKdc1GT7cpBZxVlfFNQ9nZFO1TYTX5XbG5rjbYgvVpWQ2c+Bk
	KycvbZaOpHVjuqFYiNc9uAkPud/bMTKnRfjQyWayh8zVRaU4QjNIAFBpeYXqA=
X-Received: by 2002:a05:693c:87d5:20b0:33b:bfb7:31cc with SMTP id 5a478bee46e88-34001f1961emr3645480eec.16.1790292235455;
        Thu, 24 Sep 2026 16:23:55 -0700 (PDT)
Received: from evangelion-g ([2a09:bac5:40e1:11cd::1c6:c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757263sm1516795eec.12.2026.09.24.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:23:54 -0700 (PDT)
From: Ayush Yaduvanshi <ayush37735@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	Ayush Yaduvanshi <ayush37735@gmail.com>
Subject: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
Date: Fri, 25 Sep 2026 04:51:38 +0530
Message-ID: <20260924232138.69492-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove stale @count and @cgu parameter descriptions from
ice_dpll_init_fwnode_pins() and ice_dpll_init_pins_e825().

Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 85a74cd6ea1f..d00a2fb683d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3919,7 +3919,6 @@ ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
  * @pf: board private structure
  * @pins: pointer to pins array
  * @start_idx: starting index for pins
- * @count: number of pins to initialize
  *
  * Initialize input pins for E825 RCLK support. The parent pins (rclk0, rclk1)
  * are expected to be defined by the system firmware (ACPI). This function
@@ -4025,7 +4024,6 @@ static int ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
 /**
  * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
  * @pf: board private structure
- * @cgu: if cgu is present and controlled by this NIC
  *
  * Initialize directly connected pf's pins within pf's dplls in a Linux dpll
  * subsystem.
-- 
2.53.0

