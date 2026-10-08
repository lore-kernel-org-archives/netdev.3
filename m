Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2643FD0B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482013; cv=none; b=q/Muz4zgiA6I10V+h0ZDBHAMH7PebkO7l33sfv3mQppiRTHEnabCcm3/VieGRXr1IJGA2oWfhEmhoJ4fvQWaeRkUsiMJ94mgzglx/4Sser1S1Q/XAQSWDi2Ci0CXvDb+x+T2H7v/GINVqTEYvi33NvpuNqA6tuzHAUlPxmgmCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482013; c=relaxed/simple;
	bh=77hqLc9J7JNzbmg7AMorhPOB16l5fiuXalMgNBngkQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXWLO9Ex2KNMlFU0uSK3sFTlbwmobHQ2Hy1dj++w64FfCreQnJQdSyVXXkneHhCZVopHh7Fy4YgyBL88msvnG+9ySmLBlmDws3hJESkey6qlFHOpEYMD7CXd5/9fRlHLe/eP73UBWW023NfDk7FYd3wvEen4L4WbtrD1qdbi3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6F464ud; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6F464ud"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e501442e2so2084894a91.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791482011; x=1792086811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yY8SyQWcSYsDi8cm3rA+aW2F8vWLi9p/feyMtYn7Pcg=;
        b=U6F464udNz7sAkBvHjW/0IKodXHDHrUra980xqWG7jHcPKRn97ZGLK38uhsIxr6Ady
         2N3zhlr3Mi++REofXu3KX3v37Lhhmc1Fuhwoa2gIBd8jJpTRMgxT/c2wGcDs7SM6Ogn/
         EcfjwhZRCYESzkZa0bWnnwheVxPhdGmL9IVB+jzleqVf+qukmbvPTV5uUu80vEkJh2Zw
         PBc7O2ORvTld2g1fxmi+UurxtUgYRrCoriv+hjpPCTAJs0Hg+OkNuWQkjiDbldKSqmdr
         3nkTSoWzMlKSsQp2hzloZDw6/TdV2lTvAuJCx29y6XzfYjCqJcanS6Ei2lCya6AM+Hey
         bi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482011; x=1792086811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yY8SyQWcSYsDi8cm3rA+aW2F8vWLi9p/feyMtYn7Pcg=;
        b=TX7soEFigKsczbPL4nOPr+G8wk66Rm4Iq8zf+A7eMUFAEWVsmhSo8iuI/ToJjTH5H5
         eMjUZUkM+RPHslWi8rasMYO+xQQSJXim1UjlXJ1L8IMx34uRlv4Kqe/tioeM2G4mQcaI
         mxNc40uzbCGdwf3NrRNZaCtqmuK2QPwufkJ08spPm1xrFPzKoEZUSAwIQYz7kGKdrknW
         tpgOPOBEcCB8JUn5tnO4ckILxvRvC29zMMpR8iuVnz8jB0KG3+1H5+Shzka4GX5V9ViH
         6em62zG2IxWIzsxNR5o3JEdOdANGzZHjwDa95cdPh2My3AzmEXYdnqHVzJ+qtH5N6cIz
         rK9A==
X-Forwarded-Encrypted: i=1; AKwUvBxwUXjr/UiTfCqMyBVlZkB5U7OeVdnFgsNmG4DOjY8xo0fStorSP24ylkEet8INFlScSzWM1nU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkRa+f3rD3GOxRcj9d5F70Rb45yfjaUW3cceIx/8KYrR2RBUlU
	YBRUgRncPHXyZuMUXztbO6Xt0Dgx3mewweTxbb81aHTvjAuEUDpnxBeV
X-Gm-Gg: AYBFou1M72+W6+VEuJEiR0tyU5GTeybfV9/g3rkU6XVNKjkKLxkD4KZCbJ0zxjyx1yP
	MiOG/ZHa23vHU2v+9Zq9Zfg8pxWc1p92vP3o+Kjb96RhBt9m7ZnYAijXRAnc0IKNMkmM1dm46M0
	rMYasKI6dO0F0ogyF87GrIwSLnLHE7UZC2Cxen8dwofx4OMfGPE4hbG9CcHep6pkhmdOXPxpfN5
	YdUZ6QH1b3joeZCKtnm91+py7LXX5neYD0BBF0bjrTVn+tJgDHsjaB9c3CR43CY3VQHw57WtTcC
	snbl1UvbBIc4u5l5zNg+9XNyHn1+d/Np27KWjW75Wsj9Xdrs38T/kk9/G8O7TTxKm9JJTUVMEMp
	XLBuEMQouIRjk0r1yNg5UKANiDDTB+Bg3jYbG79GQKkUV1aY8B2VguoTzRQsngqrcEX/fBg4Ekg
	/vEi7C6YHe1cXcAS0Pkv6GT7cGbbIKWpxlq9scemERD0JQJ/T2pZ9c7e/4QAF8c06xjA3tojfx5
	hKaah8=
X-Received: by 2002:a17:90b:534f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3a8a0cd4b4emr5164503a91.32.1791482011331;
        Thu, 08 Oct 2026 10:53:31 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3277c459sm144332a91.16.2026.10.08.10.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:53:30 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v11 6/6] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Fri,  9 Oct 2026 01:52:00 +0800
Message-ID: <20261008175225.3375274-7-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008175225.3375274-1-coiaprant@gmail.com>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Rockchip RK3568 XPCS platform driver
and its device tree binding.

Include the relevant mailing lists (netdev and linux-rockchip) so that
future patches are properly distributed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65e8a4b5c90b1..2f0f46eabcf54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23757,6 +23757,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3

