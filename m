Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19902393DD3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808796; cv=none; b=CbXu/ARma0p8cOd745jRtixd8y3YJRRnOMo/FKKJ1OsyERCB3su/IJA7hg4G5PMtuQcfdhY22oA+vZNS2B2LrAdfXbiyR+Rm7a7ZDYNZp52aTAn2cRdiry2aR4Ymob/q05jKNGE1bRxlJaujjmp7Q+IAMQfbbpQZ0foLvMK/gjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808796; c=relaxed/simple;
	bh=kKsh8G02HdVpc2N26b3iNoXlx79rQU6xtvF8QVQccEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAsks8VT31J1edp7CqoJEvHz644SHly1/LfWn4mly69PZp/bbMw8Wb4D151M+3TmmgDYqX6u+PWbjcdbbxxpeEffHifWMjqfFiXz0SJdOog6SpMGJH+gSfnyhvTkUFSTX3wn9U7iTXQfB5xrNNg8+nT4tdd4wlStGl4DCXYJ2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QklsIe0/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QklsIe0/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso48479505e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788808792; x=1789413592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/o46YaC7pYeVZPsZJcV4phXeXLrFAX/x8xzi7YXaI4=;
        b=QklsIe0/OapVD97Bf92t/2A6sKwPm3bOZa4FJT4h07/A8lqI5DRcxsEwOCetwsjlLZ
         hzUXd0ziQiSnHTb1GnCPPkpsrMNWgB31txX8J3gLX2vwnNR3l8HE3LQ/d6WYW+jahDHZ
         Dsg2wPKjiyNFugocDYFqhhequA2c5yzUiAExVj6MRjVqb8dgE6yLR9YcvoihZdjGbvjU
         RJsB6rShHkzwC+ePYcdSrf8WIFelgqJlYXcxD/RbHSHQk+h6aGtc8BDx6bXYIJDR4hcJ
         KBIzjYD5qQvtXWvNWnPYGxHap/+VzZBeXwHH2rhbTGP+P+mh7EOMxsDYQ06T13E3zV2r
         4IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788808792; x=1789413592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/o46YaC7pYeVZPsZJcV4phXeXLrFAX/x8xzi7YXaI4=;
        b=bzc1KVL8It+hqgidaEBrOk02tjz3JsHZa1NlGnnVHymRfKCQ2Ei9WigZVG7Pu1ZCki
         Rkjx9cr/yQh/TjQ6CjUAI1w8AAdvWH63jkiV2At8GpyHb8kpHxyvaIRLgGylbq1Ywvf7
         mMSwLVvm3B0VGa7ksRLM9xDAEI1XVT22FIlqmgc9gyJFXzJ6Y8zHsYa7y+12bnHu39/b
         RZr8D5hESgDWZT+Ci730ev7/So/0VYmKSvZZyYvpFRpIrRbtSc/Wl1AKLL5IK00hGDac
         c5avRUZ+WHCl8TYb5O/+hcortLCxD+5uc+S1yUQ6cX+oPbqso97TAFNf7NBF+z6UTbD/
         yOkw==
X-Gm-Message-State: AFuF++k1kVuDpy5Q7F1Bfu4PulXgYIcB9VkgIz2gL0ZbLr0k4JepWM+t
	GRhNB8i1Jw00w8JolhCtTIDpU41mnjXECKuwCe9gnlH1Nl5aB+HpVC1w
X-Gm-Gg: AYBFou0B7lWgKMfT8XD6ROkdxrkEl0Ynx9l0QO94it99E1OtF69IvtekCOScSEEUBLB
	vr11exqOP3o31gOfN4wm1CuOkzatVZyO+c5PE8920YpBdQ/I+OMHPwgL5khOj4SQhEktPEraSE2
	wlqbD6ULjPMSJYTJajm0Ww+4mu7Vrec5cVgJ6TGg7BoIxbqkQ+KBb+xHz1HzBfXcZhl14DwUxz3
	dDQZI3CTKRiqpB9nE7stO46kMPYdabN+mQbL/HmByfLyXulWmYyc6QZjREnjs56aQFU5SDO+TAI
	ZSgWxOIXCH1ifZxMBUP0dXtUARL8knLubXGaZm4KQKflQyYESr8Et7muJw149TOc5XMa5VWJDwk
	izZYjgl8r6v/Y6qytHmSeOisL9opuVJAb/fVIGic8Vsq0ekbA5KZHkQcT2HiXKJ7WIq1fCTJk3S
	XRxoBU+DLYMbn50vL4RNd4Bk/BhwaLZV72spYDKCGLrwFoQJQSiptLyJixCnMQbzbQtkOwCUcqc
	GfSfOj2vjYhyWSba+jABAM9C4v8BRXPjtjWz613
X-Received: by 2002:a05:600c:4685:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49cf7f32214mr252352075e9.0.1788808792027;
        Mon, 07 Sep 2026 12:19:52 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs692038.centertel.pl. [5.184.246.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm231242835e9.0.2026.09.07.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 12:19:51 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Alvarado <contact@c127.dev>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH net] net: dsa: realtek: rtl8365mb: let the SerDes PLL settle after the data-path reset
Date: Mon,  7 Sep 2026 21:19:45 +0200
Message-ID: <20260907191945.806751-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor DW8051 firmware waits ~98 ms after the BMCR data-path reset
(constant SGMII_TIMEOUT_98MS in Sgmii_Init[]) before any further SerDes
register access, giving the SerDes PLL and analog front-end time to
settle. Without the wait the SGMII link on the RTL8367S can come up
half-alive on cold boot: carrier up and RX passing traffic, TX
permanently dead (measured on a TP-Link Archer AX55 v1, IPQ5018).

Fixes: 0b577e2fe06c ("net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S")
Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -1408,6 +1408,14 @@ static int rtl8365mb_pcs_config(struct p
 	if (ret)
 		return ret;
 
+	/* The vendor DW8051 firmware waits ~98 ms after the data-path reset
+	 * (SGMII_TIMEOUT_98MS in Sgmii_Init[]) for the SerDes PLL and analog
+	 * front-end to settle before any further SerDes register access.
+	 * Without the wait the link can come up half-alive on cold boot:
+	 * carrier and RX fine, TX permanently dead.
+	 */
+	msleep(98);
+
 	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
 	 * forced from rtl8365mb_pcs_link_up() instead.
 	 */
