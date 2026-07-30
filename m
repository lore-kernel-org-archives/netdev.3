Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256183B059E;
	Thu, 30 Jul 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432954; cv=none; b=DlCcjlIhJkeoAcXwXfZ4zR6lW/knD46cIOX6rq7b2CsXEoEiEKRJ54kIV51eJOG23t7mt2V6x9I0xwunceoRLgIwuXlXGm35C2qGRc0og0VJW/BJLHxqx11iROv8gdRD/cSStZn37Z91cw8Avjuhcbzfwrdp9crqt9678FGLPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432954; c=relaxed/simple;
	bh=umRawVc9zBpyw+jNE8U6eT/8Oo+v7tZOqCVRehyKIJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnAxcyPXAyCJnSHSh4ABFYQpDoXNmOgWhnGUDWfmCEwW77D/0w1SreAxyodQPFA5IOQ5NwI0TAOhamylQylulO0r4ZDAo4xC4t3Ep+eehfr6laOJPDkezYib7nsOsiaa8NeV1P963rcvJiBT0RqJ7XJhhsuSA5y4y781fqjJMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtERkK+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtERkK+n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C49C4C2BCF7;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785432953;
	bh=umRawVc9zBpyw+jNE8U6eT/8Oo+v7tZOqCVRehyKIJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FtERkK+nUIRCwNr7hLxbVwtv4xt44tQctEkAqbSitbqG0sivl6Xn/8AA0EdKO2h6G
	 /BZy5v0G5U8EuPhX5SRtCfvhEjV+vCT1A0VyZdsDFJBVdKcbZkSTEsBdNe2dMmZ73P
	 y4skIUrNgjHi1LQRJ/KF+/U5D+jVBH5jtnZaGFv5BX+qo77tA3lThDG6VwjKLO0bAR
	 CKCMjrXE6JVa8Rb7wbDvGRKHsqVg26ce48nL/H8/uEVbrxTcKsCypv5Ra/NvQxHksq
	 dmX24YM7KdGiEfqjlRGEWFVkiBmhd0L2Icj2snyifVw9sBe8MKX7PePWc7IZBBxg/a
	 YJDmiM4NIvobA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8724C5516F;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Thu, 30 Jul 2026 19:35:36 +0200
Subject: [PATCH v2 2/2] dpll: zl3073x: recognize the ZL30643 chip ID
 (0x0E3B)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-for-upstream-zl30643-v2-2-0ea0bbd03755@free.fr>
References: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
In-Reply-To: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785432952; l=1616;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=xCtgr91zlWngDn75MfH0IGNmQxTVmxN95ksqxlV4CZE=;
 b=4h6DL7S6qrP4GJOZyW8qqbH524nC+R7/WwWwROIaF8HJWOaxbNB8ozPUXHFw+dUqML9YoFEaE
 qWdaaYDEyZ+CUbwUFtzU9kcilGiRl9mb08V0ea8a334+iljF3wOR/ma
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

The Microchip ZL30643 is a 3-channel ZL3064x line-card part that is
register compatible with the ZL30733. Only the runtime chip-ID table
needs the 0x0E3B entry so the probe resolves the channel count (3)
and flags.

The ZL3073X_FLAG_REF_PHASE_COMP_32 flag applies unchanged: the
ref_phase path
  dpll_meas_ctrl::en -> ref_phase_0P/0N
  -> ref_phase_offset_compensation -> ref_phase_err_read_rqst
is identical between ZL3064x and ZL3073x. No new device flag is needed.

Test: once register, for instance, we get:

  devlink dev param set spi/spi0.0 name clock_id value 3733 cmode driverinit
  devlink dev reload spi/spi0.0
  devlink dev param set spi/spi2.1 name clock_id value 3643 cmode driverinit
  devlink dev reload spi/spi2.1

  dpll device show | grep clock-id
    clock-id: 3733
    clock-id: 3733
    clock-id: 3733
    clock-id: 3643
    clock-id: 3643
    clock-id: 3643

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/dpll/zl3073x/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 8e6416a4741d..4d07f69efb44 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -25,6 +25,7 @@
 
 static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
 	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),

-- 
2.43.0


