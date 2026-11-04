Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816474;
	b=eJAd3DzFQefdocnvWPj9HSJWLEW95bPRSwc08oihMXcZcU3J3TSoEXsuUMcUMjqaJ0zW
	 rTjW9G68JjmuKfgpnhju/Y+d7UPDR7/5OpKe6D5KWBdbAD0z39tl9AjFGxTvy1C3G3qI9
	 CiFrZehj8ZcVUsQyxgtLjeYNux8+HtaCXVgX5q0WfijJ5r6xq36JsLp8iI1W7MvuTZoIA
	 kqOH8XXiZag2/e7Wv5zpTWRmEsaQg2xe1M9VefNlagTiP43qjGglq48iATMdNCNAV/Jk3
	 vMv5JLfPxw3lJjEpNOrqg90ZG23gAUR1s+12y2HeTjwhducYaslpGyUXtWWqYO5RJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Sr6nSQY3uWEqkIiMYzgpKENOs6ABbPBnX5Q/I3z4scA=;
	b=xbYiCpRfWTA51IVJfbVzpx3G547EiX1IZxuXqGafRLs6MxZKNA5pETKWT9YneY4unjrb
	 DerJPuvvVAYuTHH3PpQyl86L618idSJrJBMFlkcGLUesapVoKB3tFpyh9y476zSaOcHw4
	 R8NS6PPMSAommF6BARv30WQbfpeK3q94DCkVUsyRWU/90kypt9Gpfq6jBGrSGe6Jfjnr2
	 yE3GOCIrysN0UphzDf9g7Gps1/2a5AmKRAj7kA4LgVfjwT1/3wenlOR6hyot1kytf0vpt
	 WZs/fRD8csoN0f24r433vGHVlFxdx1lB0J0kDoZw6o9wDnPPoLZCAgEIb1K5kjC2/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4A606EE89
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F4A606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b060ec084so686489f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816472; x=1794421272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sr6nSQY3uWEqkIiMYzgpKENOs6ABbPBnX5Q/I3z4scA=;
        b=aAEQE6J6Yd08SLoynnSdAXVwopPn6rtlIDJWOD5R8ioPI4Aouvtdxf/xvyFkxsyk4T
         +H1DeyosJh1gmvdcTb2osWw4xOEEqFOHPjNDOQRom9A022bCE6TWjeDkzda+jx4ugBfw
         Y82DNo8MYfpJzNOUY7c0Qk5keLwWfpb/BCiClIZVCrt2jRR9stgc82IxppQsTZiIn7Pp
         hWWGOcRY0O6P2kzykkA08Xl4YcSuQaf0chOjzl+iCqv9/WVrxucS+mbB/Bm2xOqahBR4
         wqxLP6rzpkE42Evn3Frr1K3hyTWRJs01Nfl9NKai0lKiGbEkCYdDDlUtZsSldH13kEQG
         gnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816472; x=1794421272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sr6nSQY3uWEqkIiMYzgpKENOs6ABbPBnX5Q/I3z4scA=;
        b=MCuuVoDjFkDo4yAR3vE3B2qvuDGSwDSa2NvUW6lGqvgvv99AwF5gwNKhcikGPShA0P
         21x9SGbuNCrAzf7BcuPF2eSh9qAERb7/3U9+SdlGv7QmAdbpwhDW+kBDKnGDsa8g6xxa
         gQEJAcsvbz2lHiMF+eBuNQJRahK5ng1Am6bQ9qLmkDv2Fo75Ks7phDSWaolsaYkfZPgq
         z7s5HkJe70YAyCHbTkjlPPXwiyUIUpLWv5kejSj2FFOh/5DCIM1xQRw9DZmaw5Z7CRVW
         iWSPv/oEb/NhDaJj6uiMWPpzAmXHydSOtQe+R9Z4+qXQKi6C/jnLViCbeLbb1PTl1VH7
         PEqg==
X-Forwarded-Encrypted: i=1; AKwUvByk/Nlo4gi4coK3o4MlqYsEEWgoPt5q4KBgDrs8tDcNBvcsy4Jq0jsKqJSg/zX9N3FiXzgIQhY=@vger.kernel.org
X-Gm-Message-State: APuU4Z95/vbBF8+wDGg8nQX8IrxKf6N7KvM2Na01cdqNUBn//LU5tSZB
	0HC1r/momZIWphm4Hc2/gEx/tKZlZQ+tVIJmemqca52jEjTOn2tbt5nf
X-Gm-Gg: AYBFou0ez/tfFGym2xYeDCW8OTcaSrMU9g9DqwJsUrAt09hgCL+nfSWO8uWPF6DgkWu
	/6fk3XVGSOruuYralmc8S+In2CBXy/HcLgbJHFaBv2B4FK40/tkBfd72PI1tpAvZ4+gR6+IKm/v
	SMjeJw/MnJbK+KUuHzrUoFrqLVCfbWBkKVB6rV26H8iFcX/LXJVO8h9e/iF1SNoi9A1QycVz9Dx
	Ha/nAt9qdQQIEzKXWj6w7q7E/KNVonU02L0MvD5z0hixXdBRu6VPFuN/ivU7mM9gqqFJNxyWjM5
	QE/8KQbq5rMEMwePnXUOxtQB1RtnUErEeU5ov+7dPoRuC4cG0MmkywzRAiUZ+Qaza89PUVe4QS0
	x52N43WEcXE40bbmK+CuCWEspbrT/FCvK43/JTgIoZlVov/doHq1L4K4QGQDmwLe0OwlByHIIPo
	pWGENiexEGie62Zys7o1ixUbqnjcerX7sSDDwglqQinwBziTRLtCJxQMxXxmcKlQ/3A/aEEJ3rn
	V00+q4XhuWTrLmnadoCsZLG6wl+sEtm+g8O/Yzyd/jb8v8+wxCFsQaAkMClFEY9rtNdxRUxJv+R
	6AvxcDSEoYFFo57APYv8vjG1E+k3/iSnuPVjTKfRbGmAzUibAEcgA8XVxVORO/sIJ7T3WM5/LiZ
	BwAEFRw0JFW/j9A6T5l2Y5rCtqSJABmsQGW1Tpw==
X-Received: by 2002:a05:6000:2089:b0:48c:4f6f:62e3 with SMTP id ffacd0b85a97d-48e6e2eb736mr34348488f8f.18.1793816472184;
        Wed, 04 Nov 2026 10:21:12 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:11 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v4 01/14] net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
Date: Wed,  4 Nov 2026 18:20:49 +0000
Message-ID: <20261104182105.1102555-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the locally defined ETH_P_DSA_A5PSW protocol value from
tag_rzn1_a5psw.c. The macro is already provided by <linux/if_ether.h>,
which is included by this file, making the local definition redundant.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- Added RB tag
---
 net/dsa/tag_rzn1_a5psw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 734910156dc3..aab0ec143c77 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -24,7 +24,6 @@
 
 #define A5PSW_NAME			"a5psw"
 
-#define ETH_P_DSA_A5PSW			0xE001
 #define A5PSW_TAG_LEN			8
 #define A5PSW_CTRL_DATA_FORCE_FORWARD	BIT(0)
 /* This is both used for xmit tag and rcv tagging */
-- 
2.56.0

