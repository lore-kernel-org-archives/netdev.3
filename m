Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3D4CC26E
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549032; cv=none; b=P/b+odAUnTLsbAu6OoXkFdfVMQtBJuUro1KLyKKcGdr+hLLojKOUHl09kFCBgV5A3Jt+lP4cxVaoKRXr5uLJxkQOPZS+/H+F+ZqDWPIwZ0w5jEMKbgi1Pxwn9DTKNJPmOdQhPNHFX9o9RTKJr3lssilNoYfv23D6qqyAnJF3Up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549032; c=relaxed/simple;
	bh=KnkR/FUrVhtW84FnX4LKQbgi5/YlY8b8hCVlc8Xvau0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcgGsZfXLDfxS6nXzorhcg9EznqYXxeBxfyMMbUUM6xlSOUZHTpWhN4lsoRPejkSRnNzvf+Em0OT7/YjC7xSdILuBBh0YWsM5Wn7sbmhCcAb5+u2clWy6aSCh0CFBc02W9sCEj/NeakOc9QpAHaWVJecK0wVmYG83phrDQZpJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnFSvHVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnFSvHVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07421F00A3F;
	Fri,  4 Sep 2026 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788549028;
	bh=y+1vk1/6TI5e1XufJe+Oh8haMwyDGUKCOxPmIVUjotw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CnFSvHVFdvhaR70hH63bTZ2YK7b9QZFagsQTdtllrD9qSPORFe6KNdCh5aXh8HMdM
	 fU5PdkL+m6q76/bBEUZ/444HXeiUvAbk8UhyOWNr56T1u80SYqcBecP3uZklcLj41e
	 Stip3V8TF2hreFW7PedCxFglnz6+4GYl72P/WTgmkImjqKkqeFz6K+kavgm5/2W8zC
	 aRSdfyBP2NvocbS7q+HQ19ljb/MjvWSxzJZUMSX92r37rTLLZ7HxXC1XAGtxvPm1kU
	 6TUCctfe9T1ivFAZ+jC9QWFVv5qreGqw8hGaBkeSkAzQsTO98hYuKbsTSE60da0HiP
	 YMYMPtW7tL0+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] netlink: specs: dpll: add clock-quality-level to the device-get reply
Date: Fri,  4 Sep 2026 12:10:20 -0700
Message-ID: <20260904191023.3869690-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904191023.3869690-1-kuba@kernel.org>
References: <20260904191023.3869690-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpll_device_get_one() calls dpll_msg_add_clock_quality_level(), which
puts DPLL_A_CLOCK_QUALITY_LEVEL into every device-get reply, dump entry
and device-*-ntf of a device whose driver implements
clock_quality_level_get() - mlx5 does. The &dev-attrs anchor lists 12
attributes and not this one, so struct dpll_device_get_rsp has no field
for it, dpll_device_get_rsp_parse() drops it and dpll.rst does not
document it.

The attribute itself is correctly declared in the dpll attribute set,
only the reply list was missing an entry. Missing since commit
a1afb959add1 ("dpll: add clock quality level attribute and op").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index cdc8c7b456df..64a45088c027 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -632,6 +632,7 @@ doc: DPLL subsystem.
             - mode-supported
             - lock-status
             - lock-status-error
+            - clock-quality-level
             - temp
             - clock-id
             - type
-- 
2.55.0

