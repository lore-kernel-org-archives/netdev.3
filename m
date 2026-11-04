Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816482;
	b=GGaDSlqSgLB0WNvShwegWRG7mBDr2FXeO946KVYT3QafbnGTizt86vl57GdeyzJCpMhV
	 dxyt8UG4YVI+um+KdKrggXpaCU+Om+bwGSfD9d7JwLK9A4dGlsKgOcc+4E2RS7NIXHcUo
	 08XWZqCJIhwMQiZYpxQ40gwfhSkBo0ADbWQP8OuliQfSQsTVaAwWpIlbV3ybBX2tNnMrx
	 96RiU5zzKtawk0X45IDY9HmP/DOFOTtRYcCyywobnaP43Oy1pEBe4rE0Me7oKGf+q1KvY
	 TVJIeRTCWzRemiVn/lzvlQTT60ctbULdDviC55CDXw7BkBmSmNV9OOeGKyhPtzsTJvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qoA0b0WqoQVyQ4s8ggfEko6YCn52CN5Lygx0rJr7TsU=;
	b=q6y6GGnz7fTaA9254zC/n8SmhY3QQ6cMY+LbHvEUMMQyfNt9Hu5j4lW0itBiIE4TmM85
	 X5Ym47J2YOahmfJlsa6xhxtu7af+9d8HgWujOsuyHejqug0Xvxvlt2qJYIRZ5KBVecSN+
	 gpLxZ1CZhjy+gxBJyuk5fe+ghpBi2dDvQpHsfhjx/Pa7YQhuwfijyg9x7roFHkdLarRTx
	 JZCy48SOXREoYs32n0v4aVNogNDa8lUR7er07Q9J2fumPa+t4KlyxBmNwGhuiSHQrffY5
	 hWKygUcS/0L8/4KXT7Nd5y7VAwdsBSp7J7w+Y5p1ouH5+M4NzRWvGU9n473xELZPdeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5corqjg;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0D6083628
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF0D6083628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5corqjg
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so8121645e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816481; x=1794421281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qoA0b0WqoQVyQ4s8ggfEko6YCn52CN5Lygx0rJr7TsU=;
        b=B5corqjge8lxXP8hH2NNrMFHeSd6tqG7U2fOuevHtZCjzKMBlC7wko1wz1Zc+QvhOW
         GguDbv+6DYxVrQ2PS/Jm7KIIO3enikMFBRIGGeQGI+VXDYF/+22Et2ITlZVCVop7/Nxi
         6AbajOlVqPIfVFAQKhBq9aQ5oTCoRFpSN/tJmAvj7/jbDsjVZlt8h/xdSpCHTYI/xjEl
         +tLpuLQC6Ww2S/IoslY7P53atZ7Ddl5Wn3gpNf2ERsj3Bm3+7TTCvvI5gfYqMCWp4yQr
         LVWmEdX15TNTKJtr9WGw4n7yrWCe7jEDT2r68j7+9XKc2GoRD0NpHfddYBrUBfRig+9k
         wjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816481; x=1794421281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qoA0b0WqoQVyQ4s8ggfEko6YCn52CN5Lygx0rJr7TsU=;
        b=B0i16phfTY6eguLj91EoIngUNjQ+zOOvt3s6VckbZTOEN9GIuJ4Ntidy3ypO0dNjvd
         f0LMVjb4v/B/93+6dCrNUL5v2Ophgz0lSGKjKf8QJPi+LG/pTOZgHWAtfw6n/RZhvLuM
         03jQzTZ+2R+KAAOOZKocd036czhnaBOc3v9T0WXF6d8PFFrXUQzrFYVSbwjKGBO1GidO
         xGFco2HRMBKN3EewhfcRimk8roz6Wz7nKz0kmeUqfj+/UOKhMZzWqVVjCvZ6LFKSMzJj
         j2sdI92DETGo7oidXBVn3Ks3s9mcae4knNqcLmr44tcN9+MQjuBvT98ArIPHPGZtz4sl
         IS6w==
X-Forwarded-Encrypted: i=1; AKwUvBzAAnKlwQur+D605thqmgH0bsv+OQMGntC/r8IKyU4alMGIdtqWOZaNfX/6qXqGHAJ1UAxvHc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IgQXuljhLAx4bpGlTQtI0NPmHDTn/hXpe6UgktPc5MLTUMmSb
	dX7X15FvEkGu6lgMK2whSFJjpcQKabQst29Cy/PTpUsTdtzfgUbZ0HDU
X-Gm-Gg: AYBFou2Dk3sf0+FhQhYBKs4H3KRmSRfFvYyjzXjGaWKEqynTuJeoUR3hZS9lGBkCWAR
	JJWNI4ru7ES0C9e4AikWYN7nU8+gSfw82yrl45GXcROuXkw4aZKLgAKb4FDcT53kQYb4toh31L3
	/BKGWPdEEdbL7CVc2RUpDY4EyRo4Xqm4uGNJphbEXFlsmAwk+XWOyRFBfuXuaYfu1+TLWO7Ludi
	qXdg5DGR8qxgdf9/IV2yTDbotYNZAyuUDNVoVuiwqjHHVGjgSWDRZvWTw9fwlAbLZDgWw2FtTlS
	UEw56jJ1SBC4ozX+Cws9MQLzMRoqWjkk71WL8x8/olk2zt6WczI0QAPpXuMnsjgh+zPH5DSumjr
	wBsVO3QuT+NkujMfW+aTE8d61qyZZSR51kkGeCRHaskEhoMEyRWnp81B7fFV0M7hUPmuifDw+aV
	KsMBzryOMK7W6g1NziB80EYlVhVyn8y7N64gWlLuQzdrNzn9UktKJ1lmphPAMzJ9T+C+qWNEeP4
	atXuMG0nCnWy0w2DGB5kt0uaNLcJ+dL8O52zysabYxOv78MtgI9PtakQ4dl07bwlJlXyX82y0OG
	92MCXdZdFyaY8xF5U7AAgBPlBKBBJ5sx6iWM9toFc0IfiH2SBmnwQtlR6rsKD7nE0in9FfliD+J
	oAcqwmBY7eYUlvswryLsy6lwNWugymNHumBD4Cf9I2YgFvaCLwvLXahWsvDL4
X-Received: by 2002:a05:600c:198e:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4ac1932a23fmr387484835e9.32.1793816480738;
        Wed, 04 Nov 2026 10:21:20 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:20 -0800 (PST)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 09/14] net: dsa: rzn1-a5psw: Make use dev_err_probe()
Date: Wed,  4 Nov 2026 18:20:57 +0000
Message-ID: <20261104182105.1102555-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Replace dev_err() with dev_err_probe() when reporting failures from
devm_clk_get_enabled(). Clock retrieval may legitimately return
-EPROBE_DEFER, and the current use of dev_err() incorrectly reports
such cases as hard errors.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- New patch
---
 drivers/net/dsa/rzn1_a5psw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 846216f22bc3..bdfa84745eda 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1234,15 +1234,15 @@ static int a5psw_probe(struct platform_device *pdev)
 
 	a5psw->hclk = devm_clk_get_enabled(dev, "hclk");
 	if (IS_ERR(a5psw->hclk)) {
-		dev_err(dev, "failed get hclk clock\n");
 		ret = PTR_ERR(a5psw->hclk);
+		dev_err_probe(dev, ret, "failed get hclk clock\n");
 		goto free_pcs;
 	}
 
 	a5psw->clk = devm_clk_get_enabled(dev, "clk");
 	if (IS_ERR(a5psw->clk)) {
-		dev_err(dev, "failed get clk_switch clock\n");
 		ret = PTR_ERR(a5psw->clk);
+		dev_err_probe(dev, ret, "failed get clk_switch clock\n");
 		goto free_pcs;
 	}
 
-- 
2.56.0

