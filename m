Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F8424D57
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291559; cv=none; b=RX6jTErbNP3va8FnoSCnH6Dx9NWmD+PLuGdtIvxClc/J+GXyQVIyD6mjXCoafrBzcYLz8BoYxL95z4ViSb1GTmrLXk9u4eny+rKFbZC6q4+CApfBZ0AA6mUHeGzkpEc7NJVp3i5Zcd7a9u88LTUrzpTYjYSOoBae5sHRljHPy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291559; c=relaxed/simple;
	bh=Kla8bPD6QeaBIyzco46MsgWXZjmrVWGrzC1WkZZCt4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9wrriiEMpW6w7Ptf/ZUh2JVvFYUI35A3ykW7d3njiFLCQjgatPi9HjIiXrb1E8rVFa3I0joiWIuesXRrmdfEmB1Ux2ANImbOC/XX9CwqdSshq4DMuy1q/TJQXHl4oExF+Fa0/0yhR4ENcukZXSuOKBbW68526lxvnEF13EyLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEmKu8pP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEmKu8pP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AE01F0089A;
	Thu, 24 Sep 2026 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790291558;
	bh=nSOV03bGqF7h2W/EVfNXBX+OGLShx6xf9TNUIeM3160=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEmKu8pPljCiwaeFAuldDlNMmEPEISqkl0ZoEgVNYkuy4B7q8EqYQBRyrnBETW6So
	 /63MhgmhCVQZbQY6ilvvgfy5EBxIHxjCWMiTjof6YQGCpGlWe0i6ykAeQd+SuPFmOW
	 uCZGbwTHYN09CZp3P5jMyJlWZeoUr/pnrOv9OezAmU46sLlklCQ1YgG6cdHgmzYa+a
	 cima1UaFuXpnDz0sqKKsu6TwMUD8Au5t8jMuG7JG7YpC2mvJx0HzbXYU9fXrikMlAP
	 /2IqLJgl2izsE2a0l3LqhXhPr6guiK5ANRUfr72xEYWllJtYM+aHI5CvKb7vfxC2dh
	 syGJACd2xgEzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] netlink: specs: dpll: drop the reference to DPLL_MODE_DETACHED
Date: Thu, 24 Sep 2026 16:12:11 -0700
Message-ID: <20260924231211.568213-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924231211.568213-1-kuba@kernel.org>
References: <20260924231211.568213-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock-status doc tells userspace that DPLL_LOCK_STATUS_UNLOCKED
can be forced by setting DPLL_A_MODE to DPLL_MODE_DETACHED.
But no such value has been defined so far. enum dpll_mode has only
MANUAL and AUTOMATIC. Let's make sure the doc reflects current
reality.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/dpll.yaml | 3 +--
 include/uapi/linux/dpll.h             | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 7009a64473b1..8fa789a50273 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -31,8 +31,7 @@ doc: DPLL subsystem.
       -
         name: unlocked
         doc: |
-          dpll was not yet locked to any valid input (or forced by setting
-          DPLL_A_MODE to DPLL_MODE_DETACHED)
+          dpll was not yet locked to any valid input
         value: 1
       -
         name: locked
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 85b898b1db5e..8c71fc3f9863 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -29,8 +29,7 @@ enum dpll_mode {
 /**
  * enum dpll_lock_status - provides information of dpll device lock status,
  *   valid values for DPLL_A_LOCK_STATUS attribute
- * @DPLL_LOCK_STATUS_UNLOCKED: dpll was not yet locked to any valid input (or
- *   forced by setting DPLL_A_MODE to DPLL_MODE_DETACHED)
+ * @DPLL_LOCK_STATUS_UNLOCKED: dpll was not yet locked to any valid input
  * @DPLL_LOCK_STATUS_LOCKED: dpll is locked to a valid signal, but no holdover
  *   available
  * @DPLL_LOCK_STATUS_LOCKED_HO_ACQ: dpll is locked and holdover acquired
-- 
2.55.0

