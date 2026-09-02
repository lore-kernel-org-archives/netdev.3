Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD4490C1B;
	Wed,  2 Sep 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374256; cv=none; b=gmjf6cH4z3ECsyL2o+pjBTBQruzqITeg93zZwmcY2i5brPz2IsW3MVVt2taSrMBYe8T4lvP3CNVv0n7laMB2jozP+9mrVIyWSsKjZi4WJlxqnHqKzjtMc7t5txfFgYEkbvI1ku8jzHfIVTIgea0bKs2YzHczQWcxLFZQE8fERB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374256; c=relaxed/simple;
	bh=JSkAMrttf03IeqGaTYIwicBjs4X9ewx5Yd4SI1TwCLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QN4EReVPWxNc4Cu2eCtuUMkzRnzKHSLQUWm23Tg88PK1zSrycJYxnhmsRyfLYWTR5VGM/om5MDy+IOKA6IAvddfAN1w6XwJsXGLvi+WldO5bvvNyLHO7oZZlN7KNGKm1ZWIIe5XTi5f3k50Wi/1uEFbPjGkhfIidanl8M0ucfuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxt8WewQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxt8WewQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0012BC2BCB3;
	Wed,  2 Sep 2026 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788374256;
	bh=JSkAMrttf03IeqGaTYIwicBjs4X9ewx5Yd4SI1TwCLQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gxt8WewQdWMRHxK2qe52TjEZ03V1gUL44NXIRPG5POhl9RGrWwj2BFL+KBfEbUToU
	 pv+fEOXA5b1Ucjmrv/RP2JRQbDY808gz/Nl7fcXrjWKiICfDfKZP6XdRVLOMsbIXdr
	 q7B67zeEFuLgFEAwslp6H2cxLxmzGpHSs0hxO+PW5rxP0DaFGaJ87r8uy5V8CQBXm5
	 PkNRVtPGrAILAt/yuB4mvn2ArKc9Pjbej1Tjo8aRQb6dqbpYDudqKGemHAJ87ddrWD
	 JpopMcxSHXIpAcVYCWCvRBc4M+gRQ+ZS7iCIxP659qwdK+Izpd4LwPA9xWP9fh83/k
	 bvwpuYwtuxCyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB1C624D4;
	Wed,  2 Sep 2026 18:37:35 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Subject: [PATCH v3 0/2] net: pcs: rzn1-miic: Fix config array
 initialization
Date: Wed, 02 Sep 2026 11:37:34 -0700
Message-Id: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5smGoC/33NzQ6CMAzA8VchO1uzjY+BJ9/DeBizSBNgpiNEJ
 Ly7g4sX9fhv018XEZAJgzgli2CcKJAfYqSHRLjWDncEusUWWupClioFfg0KeiIHDT3BMtsZsLC
 YZbl2UhkRLx+Mcbmrl2vslsLoed6fTGqb/vcmBQrqvHS2ca5SBs+MHdm6Q+eHkX0Xjs73YqMn/
 eEqqb5zGiSkWEkjswqNkT+4dV3fiBw4QhABAAA=
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788374255; l=940;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=JSkAMrttf03IeqGaTYIwicBjs4X9ewx5Yd4SI1TwCLQ=;
 b=A1G7LnBE/kxgqKFIDqWrNK+MumUa5OJsh/l2rSTsCYjZq2J6sqAgrjvF3kI6n2Fsq0Cee5QaI
 JeF+naspXStA6I8xIrM8me3qgci92j4elQ6yzXcqXzsmhmh5Wc3jawJ
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
Fix issues when populating dt_val array from device tree values

Changes in v3:
 * Make invalid port number return error
 * Update commit tags

Changes in v2: https://lore.kernel.org/r/20260901-rzn1-miic-fix-array-v2-0-3e907049e770@reliablecontrols.com
 * Use a more correct array size in memset
 * Ensure that write to dt_val is in range

Link to v1: https://lore.kernel.org/r/20260813-rzn1-miic-fix-array-v1-1-b58cafcc917e@reliablecontrols.com

---
Kyle Hendry (2):
      net: pcs: rzn1-miic: Fix config array initialization
      net: pcs: rzn1-miic: Verify port number from dtb

 drivers/net/pcs/pcs-rzn1-miic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 544d85de4dc22c01badfd8cefa59829ce35c4858
change-id: 20260813-rzn1-miic-fix-array-e6ae4452c017

Best regards,
-- 
Kyle Hendry <khendry@reliablecontrols.com>


