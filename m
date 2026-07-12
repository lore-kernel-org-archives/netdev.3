Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65D346E40
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783896687; cv=none; b=YuSjOXVjuZgqfWE3KxMZHZZYNJEiBpposzBXLWve5pAONDFBkMYnHNXuWHg9bqwhNxFyxeUfvuSaq4/TuZECFYvvDjCtsNxlil8BfRqXq11EXtlm3Q9ZnR8iVf9Lj2tUXehXuhrtZgG1xWJxgKMPEf6LXLT7xadZCLhQ4YRmlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783896687; c=relaxed/simple;
	bh=9IOmE5mNlfjptaUGfi9UqMwAnD1cwqFpc4KgYx+CaB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BGRSIUoqtA5jID4oHDwc1CurG+2XdaPRnggMOdUO+28mroTP4JaPRCRSrmbwZHdC1C6APvDCDjI3zbc2I/sv1ujTeEKA9oGV0SiCF4zEfyTPrNMYfFB9RfEuFYuWU/Ot0HXfGvT+uFOZ2R/928xo8DsPGBp7B48syt03WjRaQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCI/KfUQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCI/KfUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C51F000E9;
	Sun, 12 Jul 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783896685;
	bh=uTN9eiQpXZWak59Ktj86jwkwDyLSdgYvZipCV0ynG6Q=;
	h=From:Date:Subject:To:Cc;
	b=FCI/KfUQsRP2I+06OX9CH0CjS2QZ8yB6cfsNwysGEqk76UJux/bJ2r5HflsJZEgLG
	 CKx6Pu6+uR0qnfmxJkfTVw+LbrrxMMyGNdUmhwvdq6AKKD0pdo3SZT9QONU+tI7vU7
	 c5V3jQMiPcjd1DygRyXIH1XnOPX6xv+gxYAaxCxbXn0CM0WZ10+Z90qVFiZEbxoxgR
	 vK9gs2IA5bK99UPLPgxkpT/dsbUn/1vPUNTz5L/MFsUc0rsGgcaFcZORl5kXGboLLS
	 V4fUdjVma8HFrsY9YHgikJ6SgzyeuU2kxyYLzlOWw91Ewruh8XFMu/siJAiv3TRBdc
	 rn/iTH+cyHz/g==
From: Michael Grzeschik <mgr@kernel.org>
Date: Mon, 13 Jul 2026 00:51:03 +0200
Subject: [PATCH] mailmap: fix wrong canonical name for mgr@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-mailmap-v1-1-cb40979cb190@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFYaVGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nj3dzEzJzcxALdJDMzE0uzRFNLYzMLJaDqgqLUtMwKsEnRsbW1AGF
 vUAtZAAAA
X-Change-ID: 20260713-mailmap-b66496a59368
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Grzeschik <mgr@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=mgr@kernel.org;
 h=from:subject:message-id; bh=9IOmE5mNlfjptaUGfi9UqMwAnD1cwqFpc4KgYx+CaB4=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqVBprbOqVBzCRwJGuLlJuEbGlWjNH+RNFiofIN
 jgIiVWKmSKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCalQaawAKCRC/aVhE+XH0
 q8lGD/oDzKvCqKSEaGPtQ1f3g6QSOd/wURNR3xoRd6Qbv5yFNEGWpOWWV1kIRJY00IlUHpr3ZyX
 TmrcjksOu5xuEQzLTHuIz1cI1UBnr4anW7xqrzAYZRLIVp/8UpQ3/pLi0mpKBanyECgRxJs3H+G
 0kcpALpJiiEYv3q05iU0dPvyLEUSLZFCxDeG+tAnV3pC11THI7ifEAEbwGecOSLiDFi4al9HOfT
 tMlWItEns2FRd24iS3I7GB21YpMr2ZibKvWYmN/mw2i26B/TgYRTs3nNL3nMvkT+SlY54UlMxuZ
 XJEg2K3N7c3QId672j0WzX4riOKEzPwUg0o1MsnBkoQtFbYAXrTAU+FL55vBNugEt8QVNECYg/c
 ZidpN9YDWoOJeBt62e4fW+s9ONgYtt9IIwVvJXz+s+5ZZ2Bj5jEMcgdx4t8JVriouzXcCJIWD9G
 XcsukNqAqLu6Q77//y/cKEpSW4jvdMAGOoJOqchvFpUAKRqe0/2KIXPwti4Y2oQmzCb7f//n1AS
 8EWmivqupFfobRSBE9hmdl55XnMkHIQDBghF7WhRuNURviqcXntSgGQIABKcjyBns8dsuuzS7/A
 YN3Pp+QtA5tdroktfcfvYh3ejCKXLFv5e06M+xg/0kq7yAfgk+Sq5JRkOXWkUeIxpE23FdIRQkj
 H8hgURDwF770Xfg==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

After picking up some pending patches for the kernel to work on, I
realized my name in the mailmap file somehow got mixed up. When
switching to my kernel.org Address some time ago, I had never the
intention to use a scrambled variant of Polish and German used for my
first name to be found in this file. However, so here we are. Lets fix
it for good.

Fixes: 85fac50b58ca ('MAINTAINERS: Update address for Michael Grzeschik')
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 .mailmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 12f3acdebd72..0596bd04b1c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -594,8 +594,8 @@ Mayuresh Janorkar <mayur@ti.com>
 Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
 Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
 Michael Buesch <m@bues.ch>
-Michal Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
-Michal Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
+Michael Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
+Michael Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
 Michael Riesch <michael.riesch@collabora.com> <michael.riesch@wolfvision.net>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michel Dänzer <michel@tungstengraphics.com>

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260713-mailmap-b66496a59368

Best regards,
-- 
Michael Grzeschik <mgr@kernel.org>

