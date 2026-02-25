Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF218872A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992221; cv=none; b=M4k/+kt7pAkEhE51VnZEziZe+6fBRiXesj/Rbf4gHtveWtwfkF9UUPBSP0qHJpF7vnTwZAEGzEV2uDnVNU1Rz5E5DCOS6T8zxhrzs/3uoy0dBbAuNTD9sYrFH3Rt/o8O1+XuWYfNPxopOHXkU1bjg866fjgCRRfrHyAMxgH4U+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992221; c=relaxed/simple;
	bh=0N+sruDKmi/XJo7LvxGteupOZgUjRWLDe3QAy0oqcck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuvSe+IeT8CbNpMEq1IbZVavrZUpMuTdNe1mKzbpwre97w7lLhJQxotCRTjUtyojcYmn9znioCySq/WoFB2SrLC/NjyzsEsXMMPdIHlEYxY7Urg+fbrv/+IdYYJqlsgNaEoLN5AYTkLgX8rkdmjjZ6+M59XdPoY14qD8GLhFVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enHOdRUV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enHOdRUV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824a829f9bbso3198763b3a.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 20:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771992219; x=1772597019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXfhyeuX44W4vahEtU8uWK0qNVnpM0ieWnPAglQX3q4=;
        b=enHOdRUVy7Tz2qiz+1F+RyhVdGrxErp1F6GaF5jqxrFQtSj1QrCXNQWFksDOtp1nFR
         kwCSfmEuvyQtod9NrZhNlf0pCkTRmTP+5bqdrDhcIi05mbOU5dKQTOt2c0dwzyr6GcCC
         Km3F9SlxPW91pi3MZCwgNDC+6tbGAjAl7MIWyVuUQ1mOC7X732Y7Ud6RLf3gfqcFjOTR
         EiTh9ALh0x2+WSsjVaYMuXcI8t3cMk7FyhZRQZA4CMM7iW8nqfzCjP2O/YKsvYD6Dxsv
         zipTr0GEzqsDC24O0XJTdKVvxcl7FN66Noz2AhnkLeTl1dCRsicO6kOGB/OINEd/y7Kn
         WjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771992219; x=1772597019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXfhyeuX44W4vahEtU8uWK0qNVnpM0ieWnPAglQX3q4=;
        b=D3m3mY6z8df3tLAQYj03Vjpfz+NLzVdWpnyfuRumujpdCOTkfApRE/3iaPrn5TUq4d
         YOMClMd6NVlXSLL7MlyE+7mkRLdhQQk+3Mq/deDTsbCh7zWDmRgaPB4rQ88uCtp9BABQ
         F1tPu7ov+0VivU4Mt9WlsU+jR+wI3E8ewxXWhYVfMkiPXysEBsmcr0UNccUbcucrEprz
         kKsI82e5Blirxb4FZwgOwlpAhR5G1unE4AMqpCe+/WRILbRotXfx4V8R//skTTxatFVe
         i0YezllG2fF/GbGDoCAO6RL6EbKWlSBffFr1bkPf3Q8ZeZIxTEMhup0dZ1dp8vyiAsnr
         qXUg==
X-Gm-Message-State: AOJu0YwUQ0Yy5YFpxHZ/YPtp8xVMKFhUEYxkEaILcnAeJoVg52p9eVZA
	gd4JRhRj3QqC4ebHbA2Tc6ldA2L0RdnyzfUp04Yjda/h2JC6YyTQM/KzvYem9xvR
X-Gm-Gg: ATEYQzxq9XmAW4wtSGp3fmHWgpcIwu5dqupxH1Wqdg+46by1ti9ymNuhyKY3ia3xIWK
	GKvUmw7yF9g8yalPaWe187Ccg3r7ff+8oXNl7yyT7MfKP4/Q7hZ8NyQ7gPJoKHGEW7wZsZQ5ERV
	EBJ6r9LMXBGxazk98ahoEZ1M4D1AKOZZbsZo7LEi0SOHl3JCuHtqGP9SHnfHDwgobhwHehp69B1
	dwGWSRSwsJAtZp8SwbQAncvBS8QLf7YZVXYwQBsvkmBJJF+aBS8RldplFvv6Sw4gRiR6Jz+4e7h
	xBtDeMhOAMuMGFiTr15V3HQGz4EekgixNtx5kQrXoxviI6aJ89pg0yoQ4qBT3GNgelwTO//3wF3
	zhSOqEzZJwHn2CSC7lp6jKZ89PV8MwGjCyQcWeAU/mWLGGKRPmiLLKWFie80/pY3UjCJ6UeE6Dr
	O2Tejx/08NaoStNz8kmKunVwt+450aTjOXeJzRMcugWglXbctRLT3Paw==
X-Received: by 2002:a05:6a20:7484:b0:364:14f3:22a7 with SMTP id adf61e73a8af0-39545f52541mr13040885637.42.1771992218872;
        Tue, 24 Feb 2026 20:03:38 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd87eea4sm13379209b3a.40.2026.02.24.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 20:03:38 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com (maintainer:OCELOT ETHERNET SWITCH DRIVER),
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: dsa: felix: use kmalloc_flex helper
Date: Tue, 24 Feb 2026 20:03:23 -0800
Message-ID: <20260225040323.69497-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A little simpler than using a separate size variable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 8387dd208adb..cb132679fd99 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2254,7 +2254,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
 	struct felix_stream_gate *sgi;
 	struct ocelot_psfp_list *psfp;
 	struct ocelot_policer pol;
-	int ret, i, size;
+	int ret, i;
 	u64 rate, burst;
 	u32 index;
 
@@ -2271,8 +2271,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
 	flow_action_for_each(i, a, &f->rule->action) {
 		switch (a->id) {
 		case FLOW_ACTION_GATE:
-			size = struct_size(sgi, entries, a->gate.num_entries);
-			sgi = kzalloc(size, GFP_KERNEL);
+			sgi = kzalloc_flex(*sgi, entries, a->gate.num_entries, GFP_KERNEL);
 			if (!sgi) {
 				ret = -ENOMEM;
 				goto err;
-- 
2.53.0

