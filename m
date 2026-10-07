Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAC49E134
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379857; cv=none; b=HbH05nwuBsO8a+w7S+ArZbPE3d+Fj6NFgI7p5AeP6BWE9tFqSlat7xs6W7NADiyIeM8FgjON3iIqFthCbvvoJh6HMwyE9fupTnCtZ6WrIwfy7m7rGXmq+IBZxVjAmY9nKnN6O+/mzZKNB6zgLBB55Y6wbv0N75Xpf15ptVeWBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379857; c=relaxed/simple;
	bh=1ZKsmwhzjd0+CZKksbja61c9gxXZzOLvYNTFmQ+X0AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3Bg4PVwhnmvD7XpM2Gjmb61E8bogngMC1H3FK5kG5iJxsVx3fQKjYyWzs2Tsuzxc2LwwKFnenCbOOgvkRz12aUqBlaaxKohyzHLFIx0C04fsCr66SzMwHYhi7hSPsEQ9jPc56uSHuEgkEDgZAooYgmQ+EB7H4WcJdO9nbt0miM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Z6RhPZTl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Z6RhPZTl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49ff680331aso42981745e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1791379834; x=1791984634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ2CI3HUMCjNAVkBXSDeX8OI6aVqzPbi2J7N9xHi8nc=;
        b=Z6RhPZTlUWkJpEFxdMXeCJQKTZp9lRSNpF5VajfUStT2yiVfCvyj6zn8dcUG/fmIHh
         DimJqF/0CO9aygM8YY9VG6ylncOq/XdIOG90buz/CrtOpXmwwYjdT6KL6EvEvOx89l5j
         gl+5jBTZR2JlA8vRviETRLA2kP/MqHoibJqSa2bEXZMmGTwLv+N/rWJasd5f1kdsi6CB
         wQ0GTMqJetXzg3Uc5Ga7QTrVWBVgJ4knfdaAJ3pwPIWqW9ERYkaRTcH8j1DGDsQX5oCp
         lHdB1RqYFnaaoOTb9vrJ8mkHd35DMqtUgf4RpeTt5Q4ckgZLp/FY0J6pnxDbtTh40p/5
         arUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791379834; x=1791984634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ2CI3HUMCjNAVkBXSDeX8OI6aVqzPbi2J7N9xHi8nc=;
        b=VSLOTcidZbIwjMU8b7NpAaIypVm62CiVP3jXs62/fYEA1qkdw3UVOXSb9CQ/xepqdG
         2Y+e94ll5vY1YW5oPm7OTd1vY36qtNs48BjfpW4HaDwO08cXpxQ3oHG8AYFcJFhpJqnO
         HJHCAC0oTeU1an0JNX0Vu93G4VgC/LA6v0Q2khm009iKDRaUixzYtn248ErTQlu3gTc5
         sth7nlFoyQfsrpXJe8tIcp0ESQYDVphj9r/zLRr3RV6snQx+m5/jnJeguZMIoq2XO0ra
         cBh0h4jZ81DYmg7SlwbiztkzoYpYKHAjxFqCuouRrUBWvHK1EntNr2zv5D1G9ooRlh7i
         H06Q==
X-Gm-Message-State: AFuF++mhKd7y09RQjPl+d2srMwb83s5c6tkNaSwVBBze0lPnKp0Svkvo
	xRinNOPtlWEmng5lRewK0EZ+rRQAHqmkdobsxNMeHabgMo+1x2DnEMzFhpjcizznNAlZjTw+CX6
	DgIFxCSNq86nDfiCEN6pV0PGB/Pybzdz7VHiVt6kr+ERf30yIFMCQ96Jig+LdnGJq
X-Gm-Gg: AYBFou3LyRDXEZp2ORVzjAPc0esU4eEwrrQTV1t3/w5It+GwJFCauJvixeH+zsEVG0w
	H7Gb5iUjpjtaeO0CS872iFqZ5i1++QzkFNPvLogW/kXXDYOjKlx7qvluffPcIVcI7Ls4y73Xyzc
	4KhIy4BCR8uTIHizvmDZLO5VbwJZWycmKx+hcrSxOWz2M2NcaCRFaJax5XuPEbxZtPC64m+YDco
	2P3w8TWNj3guSDBvvJQQX+g0e/Ckaoyvv2OLOOpNmMWcKyeRfJnmMv6ZSsptY8gh1SXwBWKlZb4
	GXsajApJeAPqVqVnDB8n+m9Z+gYxsGO2T3i3eDoQUTZWFeGGBjb353OmHq34Cepsxjiuw9yu/9A
	GWTibOGAU4M/PsEegnq2OlXVJn41evgym4AvD9J4HP3gbIi1/0s/F1Xw9OR+8LWV3N0CTbGP/sz
	HMj18aWaRosZxK3cM102B/UJtRuXKQkQp0C0g5bUknAF9Dlz/tT6x2XvqLsyFRHMhp864Hb2W+H
	EUTGglH9FY=
X-Received: by 2002:a05:600c:3b0a:b0:4a1:6a10:4dc8 with SMTP id 5b1f17b1804b1-4a1806767f8mr33160245e9.28.1791379834535;
        Wed, 07 Oct 2026 06:30:34 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7fc5:5cc8:bac1:5ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17a0fc2e4sm150356145e9.3.2026.10.07.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:30:33 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 7/7] MAINTAINERS: ovpn: add Ralf Lici as reviewer
Date: Wed,  7 Oct 2026 15:30:16 +0200
Message-ID: <20261007133018.1451958-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007133018.1451958-1-antonio@openvpn.net>
References: <20261007133018.1451958-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ralf has authored 39 of the ovpn commits merged so far, second only to
the maintainer, and is already involved in the review of most changes
posted to the list. Add him as designated reviewer so that he is CCed
on incoming patches.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Acked-by: Ralf Lici <ralf@mandelbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1ff058db6..f7ca3177fa27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20523,6 +20523,7 @@ F:	drivers/irqchip/irq-or1k-*
 
 OPENVPN DATA CHANNEL OFFLOAD
 M:	Antonio Quartulli <antonio@openvpn.net>
+R:	Ralf Lici <ralf@mandelbit.com>
 R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
-- 
2.55.0

