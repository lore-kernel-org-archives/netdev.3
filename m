Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697013C09ED
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715257; cv=none; b=mFHPU3ERMyqcBCz70oTdd0hErPgUI8OAMG2+cPQlD1+eyQ3qximaHbBXK1ymKf8DHHpV9W8p8IZbHESC5mobRcQX/FtVY4N5qnuaYsGtQzgqD4FOfO6ZFx/qazqD7sIAfHqG9qhFt4DBge+785s7anBNGAGKHhIISAH3vNDL9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715257; c=relaxed/simple;
	bh=Gfr4FSzndcn2ScL/CgGJgV8UNj7sj5QgiW6yYdf/rJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdX0zbANt6OtwnYnUXL+IKrbZvWfjKLCsd+5m1xMxLnY/VcoyQxODS4ANTWoAJbi5/BBR50tGIHMUV9Hip/BycsV+V+q88U9HOnzzePMINmpKbqCCvJkAb5X2aapQnvSb5RNCXOypeNeAPsW2sVO3F422m/Z/FfOAvq64+cy+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=go4M5xaE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bgRLLpPu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="go4M5xaE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bgRLLpPu"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=go4M5xaEENGmbdoCX5xepNm7/p2A2f9U9debaz2FTzorZYh1kf3KnyEeLzmfWwCIlEOEWheYMug1mO2YbBwUU8d2p0kxNTwyaaPgWiZqKrQX6FrTJ1pim8kPCmKdEPeGjTj/dtexOJkRUtvNmhBFknuqWe7N9vj6dLLVvmI3y6l3vo7N+j+m2HrP13u9Oz2qx/0ubDIYWDdfvqxgOtGly/vcY2aV7N7b5KlXUApSs0FKNitm2hC3PqMavtNaum6dceJgvwaXccww5hxSBqrFKwgJCb2kG3TLRnvA3rCuZwmIDHQm590dQX7T8tH8ljTQ6AupzrDJoaGe2HKbw/I7Nw==; s=purelymail3; d=tinyisr.com; v=1; bh=Gfr4FSzndcn2ScL/CgGJgV8UNj7sj5QgiW6yYdf/rJA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=bgRLLpPuuXfG/BoA4JgwpTWL71cEhxtOrRCfCJJDCmwzeVVgnvROw7EeHfdaY9i6S3In+xu0r4pcpjPPDSlCqvxjOxDhJs1qctPszHNMf7Ml3I4ihKc9D38QE3tvAl7F8WZN+gfb0xaf47EvEMqgt3km6UZoac5MxxYkxcDTbA2xM2NaeH9zARSq4knjJswXXCU14sZfDC4Ch5Pn7aRsDSV+ZougKwy8rY6eUrOqSJD8zZFkYEenqqW0sDKcJcWuNi/B3PcSrgtVCIbF3PyTvOw5nSwmYlFK+2wD9F/tjZ1cicSlEQkf3vdCBUZUjucKGGiEvswH1l9DBJ/UwZeI4A==; s=purelymail3; d=purelymail.com; v=1; bh=Gfr4FSzndcn2ScL/CgGJgV8UNj7sj5QgiW6yYdf/rJA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1438868657;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 06 Sep 2026 17:20:51 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v1 6/6] MAINTAINERS: add myself as MT7628 embedded switch maintainer
Date: Sun,  6 Sep 2026 20:16:25 +0300
Message-ID: <20260906171625.533915-7-joey@tinyisr.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906171625.533915-1-joey@tinyisr.com>
References: <20260906171625.533915-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

List all the files of the MT7628 embedded switch driver and add myself
as the maintainer.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..95e361f5d0ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16781,6 +16781,15 @@ S:=09Maintained
 F:=09Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
 F:=09drivers/i2c/busses/i2c-mt7621.c
=20
+MEDIATEK MT7628 SWITCH DRIVER
+M:=09Joris Vaisvila <joey@tinyisr.com>
+L:=09netdev@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
+F:=09drivers/net/dsa/mt7628.c
+F:=09drivers/net/phy/mediatek/mtk-fe-soc.c
+F:=09net/dsa/tag_mt7628.c
+
 MEDIATEK MTMIPS CLOCK DRIVER
 M:=09Sergio Paracuellos <sergio.paracuellos@gmail.com>
 S:=09Maintained
--=20
2.55.0

