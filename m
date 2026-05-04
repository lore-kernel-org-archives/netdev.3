Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67C3A5E92
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908765; cv=none; b=AKyOJBLMon/IrZfeps/kbWwyasIa6S9+MRRDC7hdn3LDodxsdlUVXMuhL6ik/0mxf13XJ+z94Hr4xsKo6rrXFiLlF/3yRLJJDgFc/1zxXHAzZ/rOD1CvU61JcUWxzuPbjtQY7Vvy0kJPrILBhYXBycJp9/ZUNGDjSYGkNzhjSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908765; c=relaxed/simple;
	bh=nLZTqMfzwTsLZzxp3MQg7grIaJw6JLZVendXP0xz+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afWXMkQqXCWYYn8LHwAdNY6hmh0INus/awc1XPFsHPebPOBgxhFj4mDN/1N9Rxi8rD9IzvR2XuoLuW839cCZv/7ff7xdn6M+p2JHo0+uLs/BK37SqEXv9Gnvu6IIeq4mJ0ZynmFla2lQSsrVJ98Yz93aYYK3f6Y6E4nOmwnjfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWJsi9e3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWJsi9e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F684C2BCF6;
	Mon,  4 May 2026 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908765;
	bh=nLZTqMfzwTsLZzxp3MQg7grIaJw6JLZVendXP0xz+lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWJsi9e34PuwV+rO4VPrmFMu2QbDl1BD3cIQ7xv2f9IzR/3YFRsisDIL689zwvuje
	 u+fJ1Rk7DCiPCchfOQjs9fHQZE5O/cQs+St5eSxcUlPgzWdicNjh3dc+YuQ0Ntf6pH
	 5NVgMAdO1YOCe6mD1hn/d/GJAiff2v6LUBa+hCmxFzvgFdOBOQXOxI9j+4Y8EawYfi
	 Vop2Z3oIXD6WIHxWcSIBdbgR4Q7reV23+qVuo5I0wQnm7DGJ4exrQqAlT4+E2SbBcM
	 nyHzxDV0EaXhzLec3PhJgPGpu/K4KbaVcX9Ll+8JWCgpWRiYO/pPg6GKi+ptXc+P9/
	 Onv5iggjiWO9g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 5/5] net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
Date: Mon,  4 May 2026 17:32:27 +0200
Message-ID: <20260504153227.1390546-6-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
References: <20260504153227.1390546-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 23e8b470c7788 ("net: dsa: mv88e6xxx: Add devlink param for ATU
hash algorithm.") introduced ATU hash algorithm access via devlink, but
did not enable it for the 6320 family. Do it now.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 09da154f80d7..4234755100ea 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5196,6 +5196,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.atu_get_hash = mv88e6165_g1_atu_get_hash,
+	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
@@ -5250,6 +5252,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
+	.atu_get_hash = mv88e6165_g1_atu_get_hash,
+	.atu_set_hash = mv88e6165_g1_atu_set_hash,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.stu_getnext = mv88e6352_g1_stu_getnext,
-- 
2.53.0

