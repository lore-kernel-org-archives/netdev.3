Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19105364953
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213713; cv=none; b=BInyZkJMG3SmRkv56ieE2yL8FMHKNEiY7JrUNeUcgNC3OQJMhOdjLlJwad3YWixsq+oboGs8Vjy0CwHuAJRNoM98SzpfqPAthHdN3tZ7cdHy6DTpUOMjOCRd+OxuDQtAhKyHZ3sBql5vXMoRcqvxVkJjmdKwjcnM64XITDREubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213713; c=relaxed/simple;
	bh=VZFl5/IU1v4UTxpNq12Cpk26Nokne9p5RJzDQgfLWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKiIDmO1Ynz2tbJsBjxG3tcXVY74ELkJI2YkN3Lwx+EjlYudbqEjbit8WrwSlm3V+A5wYnoQb10es7WNdHnkieywpFgy8cEqfwNSjH3EYjEe8aL4J5Ntzd8k+ldkzrHTr/zKTLB+i/kz1hygtrLs/BrdrtBm97R/XI7q2UOgg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRBawhXB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRBawhXB"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so3685206b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777213711; x=1777818511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RS8ucX8FcZXkpy4jFipC3+eWnTvqfIiw+EMH9PjAj6g=;
        b=YRBawhXBm9xLvA4Ua4Im3mLZTvEMURLItTWpm44na0bojRsL/YzTGkYnFhIlt7ctDf
         52Tin0gKJVv0mSDdp+Y5G7vlpOPkE6xPI1wzfAXrPuomj2uE2ujDDp81yq46AtEGEWYd
         aH4Kil+HqvW87QyWR0OLYvSZSSgR+ehd3Os+9MWA9YxaMUQfmcr4qUwW8dJOptGs46J0
         Hb7OxZQWf+SLprBL0cUgdwkHga4OJ450vvGBcXUHMp3e2pFW32MfOS1w+cEWtsWz1hMM
         3614ys00tnGoTc1g4TDT55HJRKsMgiOP99TRDDYzvP377va6VOjJF+kgVWmLZKF+9hmB
         Q4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777213711; x=1777818511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS8ucX8FcZXkpy4jFipC3+eWnTvqfIiw+EMH9PjAj6g=;
        b=b219iOtg0q+v6K1Vh9YnjJtXU7UXfQS15rAtKY04yWDRoTAH32ylSslPCjjKqGbOs4
         UsYo05FqlI+8GwgntgUi1/IQTKQ/w+St6/BLM5Prs+cArCqILwZPZbazyB18QI8vWNq4
         MwP/yj3uqF2HIHlf6y3C8Jn+u/ejjb1t13aK39SqOjuqnHukjDJG4pyO3cC+3Gf9S57v
         OixdxlcSXyh+apLqD7UC6sX1TKjRz2FCeUmxjdKLRZi+qa/TXO1wFa142WkgxbJ8mzJk
         kDQRFDnG6VWiSjVw2aUtjduxGXDxFv8kA+vCSIrHxasqk4vmqgD1JSB9Ubma82I/XAXA
         cuxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Cv3NZ2C8esC9VVzkvuAZa3j6C0SJNhLOOHE4H30bNoKhCEfYv8wh4KDVILstNlDAov6urllk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hDoswHJvw0wD41MG6dBqzJa3xhWNBHUcQvaKLY1YPhlWkEyV
	8iKB7+7bSE5A0koTQe1o1EfT+/KALLi68xtE2jZ1UCNNSqO+J/ArXnTUoCZAOxvldg==
X-Gm-Gg: AeBDievJ8n1qbc0BpIC4Iib2Lu/SyQTrxomQlwb7/YFz5qwNx55m7YwQeB8tGwJDhJA
	dQYkAJanE+U65JzQZoN5xQvuiULwiOPWxJJTqOJZFlEbJFvVzwuOi4PSuYBuZ6nInAB2YBCchOU
	KljjMM0Hlar/23HJvxNTGkE0Tb7rKi5KlpyaaOf2pZKwRyVytnxSMwMTfYuGbexjz3uGdiP3rbv
	KqYAyYNNQwg3oRDFlT1Ah7cQH5w9YVAMDnEDI1t9pjgd7vUuw6fCY9v8lXYwkl1gdQQVg8SRSRb
	ERBdWRk4jEOcY4t0JzGlHp5F2kR4vnfbhArLiqH8Q1YYW+imD18r2b9mdVdV3Ob5878L9Uzlntn
	rcVc/Js/EEdxc6QyO5Fjwyy/tSfSOCFI95fvMFzTnvo20RTUs8ITqzfm9iNHyjvzHmuTeTv2fX1
	9Xrwg3ZmE2tRxEuuHbujzkgvumU7TgnuzXrt2T9YvnDwrN1sRp2Ywp1X7SXMwnLo+4qw2foRcLT
	J3BrURG4g==
X-Received: by 2002:a05:6a00:a883:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82f8c9ece1emr40810968b3a.48.1777213711426;
        Sun, 26 Apr 2026 07:28:31 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f94204ac8sm28318578b3a.0.2026.04.26.07.28.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 07:28:30 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: lan966x: avoid unregistering netdev on register failure
Date: Sun, 26 Apr 2026 23:27:50 +0900
Message-ID: <20260426142806.36028-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan966x_probe_port() stores the newly allocated net_device in the
port before calling register_netdev(). If register_netdev() fails,
the probe error path calls lan966x_cleanup_ports(), which sees
port->dev and calls unregister_netdev() for a device that was never
registered.

Destroy the phylink instance created for this port and clear port->dev
before returning the registration error, matching the existing guard
used by the common cleanup path.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 47752d3fde..22c496f588 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -873,6 +873,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(lan966x->dev, "register_netdev failed\n");
+		phylink_destroy(phylink);
+		port->phylink = NULL;
+		port->dev = NULL;
 		return err;
 	}
 
