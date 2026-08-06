Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0B41F5EA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006280; cv=none; b=Xt1incp+YuJuErHacTaBS3IeGQD0IUl9Le6blbD6geaLyGKm9dezh1Eltn8XKke4EK3OeEYYJPtNHbOZSol/XHqvC25HoMKZU00FEMoJUXMy6AIarrQT1X0QP24xEgRF3Js40S210Rky8aZadzpG5hvNa+GPtn57p0/NBWNuk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006280; c=relaxed/simple;
	bh=VYNwMztRwRXx9k730Dk3Q56fjlxa2ePzx4k0C6SvVLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MT3uSq4IjX16d4ywM2i8E2Y7LYh3Fq1VZ3yz0lzf7UQavnCrNxYj6Ehxw8CgxtLyCGh5HL2i1xBqzSsgWIn1WQ3PcAGhx1Q9EN7pFvuyQqkN0eD9HxIu04anm5vbEiorUow7weUGMA+eUf/BWc6hJYITbMAjiPXNZSBxhsMKzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com; spf=pass smtp.mailfrom=evalinux.com; dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b=AkmTgDro; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evalinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b="AkmTgDro"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb63dbd229so541818a34.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evalinux.com; s=google; t=1786006277; x=1786611077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+G8Jh3KWSQ+T8cmi2Vu2z+BX/sE34SkYPOmIBWZpXy8=;
        b=AkmTgDroiFqKzWddz9MBrQtRi+MbfFu8Br6gqmNCsOkFZriAY1/U3fDLF9Tb9lsoNa
         Vl19M45kEQBU+LAWrxw5p8hLrCtAXMvyJJvwsNzib+wLwB2j81LLX0jYlg87ZzoWJcoU
         JJ8YZ3pEGlRftfvzcldTNQ++/j3T9NEWi93Xs0cdY+BwHGNXycuZytHb0pbIvoszxgaE
         z49CjbVyhYSxt30agKilj3XlaGQDMgIWd1xPOq5XhOKefonp82fWASNQcOjDnVboyEAf
         6mNgvfb2LzI5+6oKf3d07/C1gq1BuXaNdiSGai4bjEMvq2+zOpAx9s1KeNtB7Buy+ohP
         Oa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006277; x=1786611077;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+G8Jh3KWSQ+T8cmi2Vu2z+BX/sE34SkYPOmIBWZpXy8=;
        b=HiZGMjBgefqKRDeiVugSlOSGRBnLEA+KWcS4f+238vsWR1FQLaQ8sI3eaqXVdHrqhB
         rokMbD52jKO51Tfk/MmFrZ29FrAYCQIPudP0zHG6AXBvohb+u7xE/QB76TmKSAlQIBFH
         nJFp2QJ8mmDPmXSQomhh5grJ9qOm4tpOWbHguvU95JvCzYNNNS2Jomb9PhjchqdUffUD
         XQJTq+LV23v2iUbg9vn5GXle/4DuN/qwu8wgezya5FNbZPhJjmi3GuVYXQ1jvGCiv7JB
         m+j1AfK5n68o+bex9mbf0MIJbDPpU+rej0CZqHq355YDIhtVPbSiSJ4OCS5Nk2D6Y25D
         BOIw==
X-Gm-Message-State: AOJu0YyJho8/iqa9C6jWmt53NubVIQcwyQivD5lCDx4bjGy611x+7CRJ
	IZsJt1x4mOo1RkQkV8c9LE6vMjBAdy8g45F69MmuAYXfUhF8j2TjoXIZoaE3dBVGQIcuwD4raCB
	RTtFVXLng5w==
X-Gm-Gg: AR+sD10LW/TzrBswP2YDQh+BZ1gaEaLvqlr+zBDgHUltzKw/v72W+L1s8BXfWX3jfIr
	hza/gUSwTHdKXGhNl+eGX/of7dmROzQNWle+ANXcblUCS88c/XqM4lqnb0CfVf9GpD0AqEy3L1e
	s7XbUblgzH4X6Ja6Eu3/bHI52IQSNLtbIm6ukdDhaF3hAsuOi0XdncV0f2GEbmqgub5JI0jbP94
	4JjpXRqtNSGja4eCWrzpofEJ4r4SvQePccSF9sIXmqE/Tqjn0x+Xnp7MqD2TAxyhgU+5VmHzEST
	YLtIEdTZrHudS8E4Y+gwRlDCLQhb0/klZwihNgVqmXMtchKDC9LXTKBe0sWJYVUvpgA35O2rT1d
	g2ut/H0FRAJdcuVGjTnbVRpvIC+2YBGMN3kJRSco/B8xX/KKTS+0gyg3dxVnigpRTG5N/KDOHBH
	Rg7rCvoOeipyC0u5Oqjg2p29Cu84zUdu8FFCOpAbLoSsLFVker8cWGSZjubT5sTS2g+MrEcXq0S
	es7eVXxy+unbw3Nkviy5AoK1lDr+aY9dydUZZbgSbabPQAr7w==
X-Received: by 2002:a05:6830:348c:b0:7e7:24f9:55c8 with SMTP id 46e09a7af769-7f344381203mr811596a34.5.1786006276977;
        Thu, 06 Aug 2026 01:51:16 -0700 (PDT)
Received: from desktop.casa.g02.org ([2001:470:1f0f:2e4:14ce:9fa2:a97a:cd20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df2fd11dsm4088528a34.5.2026.08.06.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:51:15 -0700 (PDT)
From: "=?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?=" <renich@evalinux.com>
X-Google-Original-From: =?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@woralelandia.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	=?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@woralelandia.com>
Subject: [PATCH net] gve: use gve_schedule_reset() on AdminQ flow rule timeout
Date: Thu,  6 Aug 2026 02:51:12 -0600
Message-ID: <20260806085112.385934-1-renich@woralelandia.com>
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

Fixes: 8ffade77b633 ("gve: Flow steering trigger reset only for timeout error")
Link: https://github.com/GoogleCloudPlatform/compute-virtual-ethernet-linux/issues/93
Signed-off-by: Rénich Bon Ćirić <renich@woralelandia.com>
---
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
