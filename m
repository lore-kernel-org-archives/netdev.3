Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741997;
	b=WIXn8tHMkVTTqk+NKY1TpQpww3qN3xZT6LJ72cjO1zBPaIiGLcTj1OXSVTf5Lu8TYa2/
	 fY5ZhdPCR9TFkgw2KcUFCVqYMj3Q0fWfH4VbE/gMQ+EDj/sFdsg7elZ9ghqbnoSkNL6lk
	 IeQau/tnev8cyoAb/AISD6q3f7bruga1wXtRk7QqakIH2/xZcB18fqxHZP0QjvOEFxiRm
	 78QzHGI20fMss0jc9NxUZs3SYaK1ZiEJKX0u2dgj2bpQqOd2C6yF10etnNARylaNO5kQQ
	 ybDcYrCOEFOAm0gOJTDsZhxLEi0uE3hurvgNVqvZrGnTQdhHS3MmQJLpS18X+R96V7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gccHhk1zXKvI2lBwqqMmtzgSCLGdxT+o/5IMCODfY24=;
	b=XomR5g6tnt1uKpt2Hlso/lhAwEUjOV9INhLxHjpnRvsJsEhdfAA7ni+bY4DQ16S37gBp
	 J+O1QmAWpyZ7wQxFxG6vZECSvjDvZmURLqWFfIpOLQTOu2lugespadOylX345nyJDLbKp
	 FCLYHUKoTjMKyvZ/O23USJYohN6bVgXjq0K0U7+FbV1UXwjanBSOGG6yRaf6rjgNC81IS
	 9eJTRyRPtAYta7uUKUNY4abxvdhQ3oIoUxGzbC3vwi+8ZEHIIoFGIMZNiXTyHcmw4p8cF
	 sUrYsYdz3wOC/InX+J1w94frGreG5LAQMISHChBUmbWSrOZ2k6taXbQoA94yGmmRXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LBWfTOJH;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF05606A333
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF05606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LBWfTOJH
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso501949c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741996; x=1793346796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gccHhk1zXKvI2lBwqqMmtzgSCLGdxT+o/5IMCODfY24=;
        b=LBWfTOJHBn2220bqeCMn50DefPC2tvZT67Uro55yezV2FbLKmnjdRUloaKJ4dKiayW
         4uzH0rAH3os/w7/fGkmpHkcwQbXvytbB8XBTDrWEC+OM1EOVF8zTLcteWo3zryuyl1rc
         0QNkJHrOdTUl7ed+bKsJQDP+4++awIpspLAgg2xlRwhFcxcnoBNbiKVc/7LlqD37F+Kx
         7aTSxz+eAcElZzgccyegYhcUH9jc4P7MUjJrXEZKYi+fd5Wt4ybdqmW6hywEcuMn/6Qd
         /yJ6fEUYj70ULTJxrNxO+vv0hIpkW4AjgiD1EO/uBws/ACPtWoEhXL1Ziuk8+ZFSIlIL
         vhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741996; x=1793346796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gccHhk1zXKvI2lBwqqMmtzgSCLGdxT+o/5IMCODfY24=;
        b=cYzk6aA78qjz9mentF8jNvwqrflYY5la1UdNYCTtjWdQLFfKspQKZ4e6Z22wMb/+Kx
         g6F+EeLe4Wf7oBRFNLLsQGgGyQwVDrcTENpVv3FdlWaVELAXluO5ln9XsNKFkeWSWRgK
         gERzL/yw80hbIibhJ0A8kDUDNUFtPDX1SFQGn6P+97D7Ig2OnAmB/ttn4SiZluV9Djlo
         mIgLWl9Ejg/8FUmb8w2lXa/XfLGbAigEMimbr4KieE4pPy5J9f0E9x4dqXTRwY/5o/uJ
         YYVbHdkWEENsrHGE1kjFeQz274iy17bw+2E3iyuVB2FL7AlwKBv7RdsyvCw+gFmLEBp2
         OcvQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4Az4jZu5inSRWDbU0PGneNxl0Qd+85pLb7VcA/drciS71GxvgupFdFMqpm2LCOFdqACUrO9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKLmv6cU2PewZ2Pb0D7Ib0+xbdYmOwPKu1tzqfPwfWhX5x6pHi
	qeHrqLuKiudRinZrMSDfGWivQ3s1oLSniPX8etQaA4citunvX3l7Oh17
X-Gm-Gg: AYBFou2o5IrncOMvRPetnEns0BTfuJFAhsRubu96EegYvru6codWVT1LsfVfN7Ms3lO
	IYqGDw8LbGJdwEwDSfPFp/evev0T4k7JI2zQ4TcPZs2SiC7cpQaGu2KczWnwGvgUwrfbd0NUobx
	JqHijtF4DgcAu0SszzOYqWT/QmO2ptKnhwj8gdcVtRufIfN4H2P3BoEIb3rVPLDgsBerAxRcLKo
	ysSKMzkbhlIF0wKMbxqaiPUSy2NZdt3wO6I4wMjVb2/fuCdvXPfVtZXXC++BVP2XwCxaCE+Yot0
	JXg8jNupUAa/0VyPiSJNRq6h7ObIz+Wwb6kfjOlRdCNhqlmE4E+o1XEzPMXRbjh0fLQN7N8GNqa
	cN+fjlSom8tfQZqg6QKlFXwlXOuGRYqelFlR7LBLCnhL+nx2Q5SbwJbcnSRX8wcXRr0YhMvCxew
	DYe/wG/ppLrUURRRKGPwxMWps1hkYvOH5Oy+uqGdoleTqNfP1ypkcU+A+XLDWchpcIuUm0Mjqjq
	kJqZkME2eN80KKzdtmDyhwlxX4Y4IyGQMc5MM6yFk4vciSRlmb3eg==
X-Received: by 2002:a05:7022:e803:b0:165:4b88:abc2 with SMTP id a92af1059eb24-195c1e5520fmr2349281c88.26.1792741995686;
        Fri, 23 Oct 2026 00:53:15 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195eae0e830sm4122132c88.10.2026.10.23.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:53:15 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Coia Prant <coiaprant@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/4] MAINTAINERS: list DW XPCS platform driver and binding under XPCS entry
Date: Fri, 23 Oct 2026 15:52:15 +0800
Message-ID: <20261023075214.1793922-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023075214.1793922-2-coiaprant@gmail.com>
References: <20261023075214.1793922-2-coiaprant@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Synopsys DW XPCS entry covers pcs-xpcs.c, pcs-xpcs.h and the public
header, but not pcs-xpcs-plat.c or its DT binding. pcs-xpcs-plat.c only
matches the ETHERNET PHY LIBRARY entry today, and the binding is only
matched by the generic DT and networking rules.

Add both files so the entry covers the whole driver.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7336600952c8..4f24656f7653 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26729,6 +26729,8 @@ F:	drivers/net/ethernet/synopsys/
 SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
+F:	Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-plat.c
 F:	drivers/net/pcs/pcs-xpcs.c
 F:	drivers/net/pcs/pcs-xpcs.h
 F:	include/linux/pcs/pcs-xpcs.h
-- 
2.47.3

