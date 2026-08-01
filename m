Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1B3BFAE7;
	Sat,  1 Aug 2026 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611431; cv=none; b=FvHYzjb6pivcBciF+xQGPe2dZE6PAKXYRfLNVG6TQg7K4lsWGvZmFxpo5O3rGgH64+OVPB+nyb6uDTTsiWnkBUPmVqCfoqUWLSyaZ8rhT8X3HN0oqAZ6EaztQcZ0/jBL8sgzPSeCpHXiHgr5Ve6YRDtJ82hiiu/zIgV85xCoinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611431; c=relaxed/simple;
	bh=rWShTCnpu0nTEcgy1sbsffU5EgEmFWX620BaTycVffc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPlVjwOeeOPhJFlNc8pEXoKINGCMkQpDdcwl/VQbgYe1PiNwYOfTp+3hDUnVe7bz/8EsoINvc16h/psFQHaVYqoqdv6KIFdy/CelglyUGctfJtyfnimq9Zz3eI3R64x+j6ypS6A76Dnalh055CJtrFMRuymB//A+ZTsyeQvWtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=nhP8ENMz; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="nhP8ENMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ssXN2uCAT2Uhn0ArUw64PP/w4h6IpNJKZdRuODIzPjo=;
  b=nhP8ENMzq3BcR4Gi9iRSAy8bysLDz82ITKw1uOEyta0aZQ18tnj1lR/L
   pTSpz0H3xYKqKzPSwmU1QzAzqLGqk+5OPVVlWL/ZOEiBb6RO4uwF5dL69
   4EC3/tpM5RNY0O83yr1bOGfDxcLc/qoKZa3hqbu49OWYSgkbgjjYOqfQL
   g=;
X-CSE-ConnectionGUID: +g8MtnpVSTuTPYZtrs7PKA==
X-CSE-MsgGUID: Xr76GDPtTJSXWLifBK3vGQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769007"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Shahed Shaikh <shshaikh@marvell.com>
Cc: kernel-janitors@vger.kernel.org,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qlcnic: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:51 +0200
Message-Id: <20260801191002.1383835-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 537fd26da..761ef3bc8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -29,7 +29,7 @@
 #define QLCNIC_FLAGS_VLAN_OOB		0x40
 
 #define qlcnic_set_tx_vlan_tci(cmd_desc, v)	\
-	(cmd_desc)->vlan_TCI = cpu_to_le16(v);
+	(cmd_desc)->vlan_TCI = cpu_to_le16(v)
 #define qlcnic_set_cmd_desc_port(cmd_desc, var)	\
 	((cmd_desc)->port_ctxid |= ((var) & 0x0F))
 #define qlcnic_set_cmd_desc_ctxid(cmd_desc, var)	\

