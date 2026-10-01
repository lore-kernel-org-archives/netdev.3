Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF652F298
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869421; cv=none; b=Rr4prMgExdU/XYC8kPmrE6xFF5FajURs4luvZPULl/iYW1OgInjqPPPqfbueIW3vYx3+RLmOxqStN7ornZT0WA6LEA5Mp0A8tW0U1EQLNCTTY5Qv2manGraOsxiQ7st4vfycw8u5pomKG6cUuJYpwvqQE6NutZ54OlPvuAHzSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869421; c=relaxed/simple;
	bh=nW+JMLHiFU9orVIthc91msKuW9PqT7A0A6/amJs74MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrZQu6u5XS64nYt7g2r0BDpEfj3axqftlBSdmqYRiMoXQI+22oA1JzNi1ufb+A9NOy9XhCB0UBCaI1GU3XV8xXkIobzk0QxGUUnw3Oy9AaDn+j8xqXEvL/Qhrpxsx4MQtjauyGmbhCLis/TebNNqpEVEWOfK9lJ9KEcbqZta7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKr1txFp; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKr1txFp"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so3267355e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869416; x=1791474216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msLs90Jn+yH2RYcHq+7D9lQYssyMQJNyeueFs8OHBis=;
        b=EKr1txFpzOgDdBug3c1haSKjZbOrt/NTMR+Duapj4W21Pb0RZPQQsj0wqBeGFBEF2f
         xI7N4CmWo0zmauZeTZYF3w2mrvOttFh4l/sIncoQUhZCEZuBfN8Q6LHRh2xFRltGCOXK
         wDGdaJIq99BFcskmhNtLEAtjXzYyhdYOAkA6q661p4Idq0+JyiulWmGFH/8uIwSPkV1a
         noNTTw3fEtFbdTkY/8nWN0TVdmMFciLarnCvC6Qfib1uzE8PqvKREbWSfUSsP31QWz+F
         93nK7LUoKfFrmEPeg4lGrMR3q+YWwioV252xYWqPCwHvGlReK0NII+zsKvUomBd17WMk
         F3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869416; x=1791474216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=msLs90Jn+yH2RYcHq+7D9lQYssyMQJNyeueFs8OHBis=;
        b=Og1GuvlLh8VC6fns8vCRIO5Q2tSeh9hpBzcWtbkYy2zg0GNiv8ovuAEA9PnjE8gdEh
         HC3ue24XqkCwIhacmpom0LNHXaDYfooWOFvqAxVNspr4as0zcdPOeWGjzarME3vjUd3S
         4N8ZTOHi/JIDAUKxq2fdf3tzAfYew0Tq+cLHSPgNYo7erYN70Oms1wJZnRKbgdubngyT
         fHPaBP5Y5Td0OHDyBb1k/Z2Agu1af+UKXhlQe9oX7I8ntw5bMj9wsFhFYQW1MIwcYvNJ
         gUPAJWHrWwW+6fHM5H3WIoer1LpubXMxJgSYESDOQv6Q0l/SxP33kg/r9abBKO4mgTTo
         6V0A==
X-Forwarded-Encrypted: i=1; AKwUvBwZw1+TU15lCkZr6phvAR3k2oD48H+Hj+wSixH2cc2j+cYaQFmm3eoz+TsCRZzuiz9wc1hnifw=@vger.kernel.org
X-Gm-Message-State: AFuF++nWD418AzrRtS/ehM02TMrmVdMuuhUhag8e9PaORQxIhyDtDTmg
	6Zfbg4tVfEeW8SwY4dlriFD8DImxIhIi2u9aZvLJisuPNuASlPteElzG
X-Gm-Gg: AYBFou3vzCby3XOUOR4ZN8eBaxWNsjUPB9x/gq93m3+cFHod5QLcGDX0cMw/FfR6D70
	06LnS3vYmDOHlTSb8A/UoEqxvSdvMryyFcDVfxtFDgKb4/QVwMpYrPnwk4Ka+5uazawevSl5ntZ
	EdlIhQevvr/sHEoTs/JlPpHpY/1tqdhen+HDMWUkBi9AzhjCGZbaNbcWys69dwMdvO+ntnBkMzg
	Yvgea9lZoz5XlobEA+IuwbzkM033hoD6AMVEjFqGp4m9QEGRZeYyJd5u2ny5qMqDOdvjJddSCgV
	+mS7bFiOx8f5PdYjTfgpuWOHLYDcPs71rggO20M2VkS9ogUQhYx98ijMtgS7Rq+00294h2botrw
	+fvKN4USSWeBNizKzUv5wr4yiYth0RRUZNtXiAnYLdQHchqfomr50FZrulzUv11N2F54bC5qUWo
	X3lY5OJ7xh6EHtWoKzMr5Bvx5DnIVk39uH7vMswUQuHmR4BJWtPOgfQPuC7IBCKzC6frnrutbgh
	xtXMur+sgATINngkGYcXw6pPFvFFL1sAn1DLtoOCeyan5ynWM5f7gogkho6pRXk0lLW8INZpl/7
	IdEcKLTnsshJjhEre3k=
X-Received: by 2002:a05:600c:4f81:b0:4a0:1ebb:bd0b with SMTP id 5b1f17b1804b1-4a02755f840mr444255e9.8.1790869416505;
        Thu, 01 Oct 2026 08:43:36 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 03/12] net: dsa: Kconfig: Expand config description to cover RZ/T2H and RZ/N2H ETHSW
Date: Thu,  1 Oct 2026 16:43:16 +0100
Message-ID: <20261001154326.754314-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Update the Kconfig entry for the RZN1 A5PSW tag driver to reflect that
the same tagging format is also used by the ETHSW blocks found in Renesas
RZ/T2H and RZ/N2H SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Updated description for Kconfig entry to cover RZ/T2H and RZ/N2H ETHSW
---
 net/dsa/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..88e181ad4cc3 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -188,11 +188,12 @@ config NET_DSA_TAG_RTL8_4
 	  switches with 8 byte protocol 4 tags, such as the Realtek RTL8365MB-VC.
 
 config NET_DSA_TAG_RZN1_A5PSW
-	tristate "Tag driver for Renesas RZ/N1 A5PSW switch"
+	tristate "Tag driver for Renesas RZ/N1 A5PSW and RZ/T2H, RZ/N2H ETHSW"
 	help
-	  Say Y or M if you want to enable support for tagging frames for
-	  Renesas RZ/N1 embedded switch that uses an 8 byte tag located after
-	  destination MAC address.
+	  Say Y or M if you want to enable frame tagging support for embedded
+	  switches found on Renesas RZ/N1 (A5PSW) and RZ/T2H, RZ/N2H (ETHSW)
+	  SoCs. These switches use an 8-byte tag located after the destination
+	  MAC address.
 
 config NET_DSA_TAG_LAN9303
 	tristate "Tag driver for SMSC/Microchip LAN9303 family of switches"
-- 
2.55.0

