Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985579;
	b=vRwUZR9RU+Dtks403GUWj3T+4xO2BsTT58g/nEiZP0NNu0KbGXTst1d0b+4sLS/t0QKt
	 P9vdIcNqNc1lKwJowFRSl/tNs+N0oxbwWDZxrhHwC4msxdX8etU+CeZdE3si6456ZHqVX
	 DeVTDCsBmeiO4Ls7tabtb51aDJkcHXq15bJFUwThLfgkKG/8B74Zjp4dFL6HGBvOmMb18
	 2ITB4OODl2fbonh83nPAunLTlyx5vuizV25bFGupukqtHGYq01ZOQKIAifWLv36h0cMhj
	 juL3CVTN1NreFFgwRi6VqM1WGV+yDL2xmDo2lwJLVlXB2qMj7HS6sK8+sbOytrydMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985579;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=NSKj/XqX/ADHIG5jBE/6lxb4x6UdzI0GoHHUwYrQYyU=;
	b=Z/46aCuNaQx5eueNdYxyGX+EVdP196MkMHt9rWAMnNHXdvwRoLCJjB1/VeRjl3VZhbOo
	 OELaEtesLdaEFjeTO5ukrJtRZLEyaVZAiu5AUCHEYblU64VPfhI/qgOcSZmyo0opiGQxs
	 wFMUxzayvJw+IfLP4O8uXWm6qzfZZUde5Pyhl7Oz4AIuBIlMwlo/m8fAUXsBd7uTWOzHu
	 AeVzm4UlgRlE0CF8jcggxjwqdKScbaKURtGxrkNi0ifCvoH7ignV2hGbySwWDFYUJrH+V
	 +Cp99fmixsqCyergKZQSfzcOHK5bcWuZA77JCB0YcpU6RuwnzctnJVdirL4tCfPzx3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b="iFy2Xg/+";
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D94606A31A;
	Mon, 26 Oct 2026 03:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=iFy2Xg/+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792985574;
	bh=NSKj/XqX/ADHIG5jBE/6lxb4x6UdzI0GoHHUwYrQYyU=;
	h=From:Date:Subject:To:Cc;
	b=iFy2Xg/+HdKYGb4kvEq4QJayCICt9bYIkmOxhduuQuWZCF5Klq6bllMWUtcQP8st0
	 N6sG+qCroXr0q12VCsleGtTkGoCvDVxuMTFtjQNeOP/vwggpyi1l8RGEGwgh2jSNA4
	 yUS1pDSD67mj4uYiiMI8qfW8E/Dje8XsxEupQXho9xfXdjrldi3evVRrbDXohTINTB
	 Kh9xg2/LaPjH9sk/e3rqbep2jWXhNVVRuMGy3xp24vf8/R4a/3v+bTZPpSYVz0Ma23
	 XMLEifPeVgRa+PvQDy37bsnoWze7Zi0bK6eFPIjgDNAmp4pi1nY3D9EMA3mDdR9rdd
	 VSXKwW1Zn2p6g==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id D8236709A3; Mon, 26 Oct 2026 11:32:54 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 26 Oct 2026 11:32:32 +0800
Subject: [PATCH net] net: mctp: usblib: Fix broken assertion
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-dev-mctp-static-assert-fix-v1-1-ceef9913e891@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAM/J3moC/x3MuwqAMAyF4VeRzAa0eAFfRRxqGzWDVZoggvjuB
 ocz/Gf4HhDKTAJD8UCmi4WPZFGXBYTNp5WQozW4ynW1DSNduAc9UdQrB/RiguLCN8Y2tnPTz96
 RAwPOTHb/+AiJFKb3/QBMSzqQcQAAAA==
X-Change-ID: 20261026-dev-mctp-static-assert-fix-d5d5b47ba2e2
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

The expression in a static assertion in the kunit tests was not
considered constant by gcc, causing an error. Replace the static assert
with a runtime kunit equivalent.

Fixes: 1e12f734afc1 ("net: mctp: usblib: Add initial kunit tx tests")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com/
Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index b7e8743c561f948a9528fccfaa5a50cd78b3320e..3a48b10164b0975a9232a00800a8f7bf2f9c1cfa 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -816,8 +816,8 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
 	};
 	int rc;
 
-	static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
-		      "The last push must claim there will be no more");
+	KUNIT_ASSERT_TRUE_MSG(test, !sends[ARRAY_SIZE(sends) - 1].more,
+			      "The last push must claim there will be no more");
 
 	max_length = 0;
 	for (i = 0; i < ARRAY_SIZE(sends); i++) {

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261026-dev-mctp-static-assert-fix-d5d5b47ba2e2

Best regards,
-- 
James Lee <james@codeconstruct.com.au>

