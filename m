Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9F2248A5
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148502; cv=none; b=RYchY053UePnO/Jr2HEh7IhMp9V2eXKKLHoMTXTs5FJe6AofDmBpWV9MpLs6MZSglyc0PdhOeeRBecQgwPGVY5ZdR67y3jx/kdrv2Q5K1GvgwRodf7ZH3y1sxjdUlpexui07mbQvCdn5YKwQNJXyD3yPwZWvLVglO8AJywHiuHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148502; c=relaxed/simple;
	bh=z9MFRQX+LrEg/QdMHrd6vU5VInn97elzdYndSSxx87o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gi8QYqPs1eyuww2PDj9MDH7bddzm58t8FkitYEKbcgYo4gDRSV9JBqbkfohb/Wakv1nu3xI670kQ1BRQ6weot8okX2U2x08n/NWILZGT5F/nXHjjYViQtdyKXNpqZUdrbqUrD09zn4gMs1ZBgRkA9BdWf3tKvwubiFburUW6MHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com; spf=pass smtp.mailfrom=evalinux.com; dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b=DGCSh9PA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evalinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b="DGCSh9PA"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9d7464b71so51489a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evalinux.com; s=google; t=1786148500; x=1786753300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0HnVtOOvJ1Ok5hXYFLNzgsDH84OVPDRhKgq1zzq9Ao=;
        b=DGCSh9PAutiDmQogok2TqbTrtDWQAkBhgeTK370S0nTr48yNgbeIylLcVr4dQRdXhT
         qkLVjr5qDTpA5cfUNQYCbimFDoHwPePMqVqxAKtr89T1W+w+FyZwT/AKeGD7lucWs7p0
         rXeyZsN2YHpJh8Ix5epfNAUmqpDw4jkX2mhTrbr2/AcV1hfKfZXTVw1FhYsyDxlm7iAp
         qxPuG0j9ADy11d5qpRdXJscS4Kgo9TppBfMUXD7AfJoxfUnT7PVq1jabcu9jXh0IwnsO
         T3uMR0/MJC3svsQUNYHODxHyYTUallM3zOTCzri1hX+5oSgYsCC1JdtpAi9BgoQP8oqJ
         1UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148500; x=1786753300;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F0HnVtOOvJ1Ok5hXYFLNzgsDH84OVPDRhKgq1zzq9Ao=;
        b=oToEkFw1eWnWwhQzqcmJMtmrFvs0veuwnY83b2qM3TwBoYyVTJJz99x/Z6bSGsqYKW
         oo6a4g++9PqdUzAvTFBUQw5ZTI8b4PIm7NLzFIMSqmgyrdB7d6NLo3/Dvl+NqpYKRTFe
         UkCE/7QBha2gWUiDK5W//Rrl6wMxUo2L6cPgOBDCMuMem3ztUZd0tPDO0ZvNapmaiMb9
         3ebifBk/bFy18/OXImbyILPKxdUWWJCUcu5uIo+cg1bfTmhcukBI1VCmpIpVEHgmTX2X
         uQUp7K7UJklZ+6bMm/kzCu70PFQ13AaIyniXLj14qIkIHg9VDLu3SAZrp8VyYKelgZ0k
         OiRw==
X-Gm-Message-State: AOJu0YySiWVxCKj64ALr6SPFe9Mq6G217DsnRJonUzc1F8gYUGcG8lkp
	4MfmbsDwirH2oyWrsXUYADpyiwMJ3cTbmol4ICgjG2V9VCnoxSUbFZzI5TVCtnDGIS5hmDwxwyM
	2hmHuHsw0Fw==
X-Gm-Gg: AR+sD10LDT5Vsk3l/aOX1UiIeGG96AdP/DPptFgB5PsM5ZmaIOiQuSnJL890dvwj/H0
	QZ2bDDpSVwyI6BUaawRhsdlDg+D+qyA6hUPsD9H+OY0e+bj2pIynV/FYivbLtPyBmQ0S7we7WMu
	34r+hQL/S9HLjABj307kQho1LkqVb4AyQP1kjk613uVPxD3za1w48vCCC/J7ozvZqHPJBY2F5tR
	jaEAJzJUvrsIn7dj19SLvcBQ+NQCgljSx3RYgCuiZKWojYpEMT+G3PHQ0Eoz3WVa/FBCVm+wZZE
	JRWDQYa8j7QcgM6+Ev6A5/w7SKPxlXehQHUXRsg3Na5rRfGmo53CmcKdFUUWead8arscUEhIZVe
	BgQhnoB+LExqiTYOFjImaI3rlwCog3xpoDPmbzzQsgSZYRce6TzsaLIdwnQgNuN6sT1t4eiQ/ft
	a6iBxNgakH4W+S2mH2l5YDOFBfEf4wAriwMkSpNxd9kGq7PS0l8beEEXOprdkXfPssLbH/kpXFj
	vXm4Cn+IlhpWcEvw1Sm8WMwT6ZbT+7ctA==
X-Received: by 2002:a05:6830:81d4:b0:7eb:c933:eff7 with SMTP id 46e09a7af769-7f1e5e2b779mr17210775a34.9.1786148499783;
        Fri, 07 Aug 2026 17:21:39 -0700 (PDT)
Received: from desktop.casa.g02.org ([2001:470:1f0f:2e4:14ce:9fa2:a97a:cd20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2528968a34.8.2026.08.07.17.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:21:39 -0700 (PDT)
From: =?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	=?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v2] gve: use gve_schedule_reset() on AdminQ flow rule timeout
Date: Fri,  7 Aug 2026 18:21:36 -0600
Message-ID: <20260808002136.2064827-1-renich@evalinux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an AdminQ command to configure a flow rule times out in
gve_adminq_configure_flow_rule(), the driver currently calls
gve_reset(priv, true) synchronously.

When flow rule configuration is invoked under netlink or ethtool
callbacks, gve_reset() attempts to acquire rtnl_lock while already
executing within an inner driver lock context. This violates the driver's
lock hierarchy and causes an AB-BA circular lock inversion deadlock.

Resolve this lock inversion by replacing synchronous gve_reset() with
gve_schedule_reset(). This defers reset execution safely to
gve_service_task out-of-band under the proper lock ordering.

Co-developed with Gemini AI (Google DeepMind) for root cause analysis
and patch formulation.

Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Rénich Bon Ćirić <renich@evalinux.com>
---
v2: https://lore.kernel.org/netdev/20260806085112.385934-1-renich@woralelandia.com/
  - Update Fixes tag to 57718b60df9b per Przemek Kitszel review.
  - Add Reviewed-by tag from Przemek Kitszel.
  - Remove misleading GitHub Issue #93 link (opened for CentOS Stream 10 NAPI bug).
  - Add explicit AI co-development disclosure in commit body.
v1: https://lore.kernel.org/netdev/20260806085112.385934-1-renich@woralelandia.com/

 drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf12345..2037b1767890 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1322,7 +1322,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 
 	if (err == -ETIME) {
 		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
-		gve_reset(priv, true);
+		gve_schedule_reset(priv);
 	} else if (!err) {
 		priv->flow_rules_cache.rules_cache_synced = false;
 	}
-- 
2.45.2
