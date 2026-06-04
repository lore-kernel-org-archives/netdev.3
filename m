Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F832481A8D;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590780; cv=none; b=aiKuMHQEnBGFWOokZ3sOmm4QZv6Kii0gvNNgQ/ZGqjkE09JLk5bRjJCuAaK7nxOAn1uqsGVkVrB41gSbTdRbiwUOBeQ0KQpvaEWCTsYyZYL6B5IQJlh4ENuoM8lBjxVJzergnNYheq8r0UsA9CLEcRaxyPBFa9Ty62HYjpr8QEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590780; c=relaxed/simple;
	bh=WxJeLSmnlvSp9HNlkuarFkmfHSAlWDR40P3hrDZjsAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6cT9SLrJSP4Ju+t6VDUgcOtTHmqFl6oZctchZs49stRrG0Fecv9DMZtcGR09PBtN5hT+K9OqV8qwd+Es6KZVZkcJ7vwIEgMYsjF0AcvSwRrD2NxIyppidi9/A9b+ZGk5nc3OLgO1BMgXLuyXxJfnPZUO+rH5pVLUaFoCDn80jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwyfYyu2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwyfYyu2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D8FAC2BCB8;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780590780;
	bh=WxJeLSmnlvSp9HNlkuarFkmfHSAlWDR40P3hrDZjsAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fwyfYyu2ZUmYdDfTJcP+bz8EzH32BfuNU7as/rUuXcPAAwTYHb5trEGI/4qQZrY71
	 Tzl71Vpt6a0Fhfkzkv7GT+0GSIQq0aiq/6SWQAxC2sD2hj+mbY2O2/3Tscq2jJRJWz
	 826759c2Hqc+g3y6GqkF+tf4hVMYa96QvzLFeBRof0Q2u6swinOYmq7W5PT6iHnIXQ
	 OK1VasW6FRwh3dgrZNaEUxjdb4WCThhP87JCollJTR0Lg4ELzmN06sc5pfZfZ1Y3xj
	 ti7rbLVNEd+RYSRIum0wDGBJA3FX6nETY2x8FAU1cdR0LaigO6GfZ1cUjWok7DzqbE
	 b5fDXqOHk4+5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16025CD6E7C;
	Thu,  4 Jun 2026 16:33:00 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 19:32:54 +0300
Subject: [PATCH net-next v3 09/13] net: ethernet: oa_tc6: Add new register
 address defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-adin1140-driver-v3-9-5debdb3173c4@analog.com>
References: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
In-Reply-To: <20260604-adin1140-driver-v3-0-5debdb3173c4@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780590775; l=1033;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=XLlVXJ5JKEByKuTG8wv/EPQZUEA1wZ12/OZMlAN0o6M=;
 b=15V6fMXtWlth7cs+frklZTL+9pejPfbLpZ56+JaRGzkPe89P0V6f+Cyymf71h6cm95rQUfTLz
 66PxryZqTfaBoc3zYoMpHNWt4kc/bXNg/lH4JG2LGJnoySeGWrZUwYt
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

Add macro defines for the CONFIG2 register and the MMS1 memory map.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v3 changelog:
 - New patch
---
 include/linux/oa_tc6.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 9fa4397303d1..e6eca352b2c0 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -25,6 +25,9 @@
 #define OA_TC6_CONFIG0_ZARFE_ENABLE		BIT(12)
 #define OA_TC6_CONFIG0_PROTE			BIT(5)
 
+/* Configuration Register #2 */
+#define OA_TC6_REG_CONFIG2			0x0006
+
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define OA_TC6_STATUS0_RESETC			BIT(6)	/* Reset Complete */
@@ -49,6 +52,9 @@
 #define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
 #define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
 
+/* Vendor specific memory map. */
+#define OA_TC6_VEND_MMS1			1
+
 /* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
  * OPEN Alliance specification.
  */

-- 
2.43.0


