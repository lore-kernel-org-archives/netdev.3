Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F23101D8;
	Sun,  7 Jun 2026 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857349; cv=none; b=lheM5dY0VuOQXLMrPPRd8jhGDs7zSgvCccP2OlhZmsn36yeAGkZuMaBmWKwyph5oFLy5QiVm6pP2Fa5qFLx+tYbNH1mVECxSUF1IPMfWKOmxhHxjgGtE7I78uNBqFKCo1gKZzZiavVLBQhcmEUUVOnhfCvZL2YuvJP2oWKckJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857349; c=relaxed/simple;
	bh=IlOl2lTbjJvzf3VEWq4GBVISiao5ux55lRmLsq8H/Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ir/HFwyhTy9j2UaZ4MBapS6/+/vHQdGk2T/dNXDf1P7Z59thN9zo7GI1vYUhU+yBNM3Btb0ZTMOIurUlVLqUFmavbCyVI1EFJoijKNyRQLCRCGZnkvOGxu+RkcpnTuPoGRGAKKK6cUUJNalXmPvV0yk3M+lRWG7GL+uFRc09f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx4OUXkT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx4OUXkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780857348; x=1812393348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlOl2lTbjJvzf3VEWq4GBVISiao5ux55lRmLsq8H/Qw=;
  b=Jx4OUXkTGUKXhEb8MtQyrhKkahGW1lAOy284pYDzuy3Grg2JjGhEWxbx
   Iyt/QAIcWNUgs56sbuqXuZ8EhbX/NPgHi1VX8HYE6KQEBOCyEMCbqDUmy
   878IQyB/3PlRPVSEXqrSHWpuM8aqJu5REG8gXZHOvqjZSBlEGnSogpJYt
   EGpgUrZv09VKvGLI2AarBaeCr/kM6JULoPHiyNH9/eBRx66U/SDMPZpKi
   e9rL1Q6tern7UxkduOILBWCtOof1JWHjtKGxkpZiv6gtGb9tI1n0datZX
   g/Hkc9oyW4sqBXYsOBvQn21uJXS8ylD3zLuYRwmtar4BMuuPZHVDCSZD/
   g==;
X-CSE-ConnectionGUID: DrLaHGUgSdCkH70tnWLq9A==
X-CSE-MsgGUID: TUKXdqpPQlKk0lja5/3D+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81602073"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81602073"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 11:35:47 -0700
X-CSE-ConnectionGUID: 8KVjqrV1Ro2L30ByvT49+w==
X-CSE-MsgGUID: ceMdq7vSS4iJ7xtFShq3eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245171411"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2026 11:35:42 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v14 net-next 05/13] dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
Date: Sun,  7 Jun 2026 20:30:37 +0200
Message-Id: <20260607183045.1213735-6-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpll_pin_on_pin_register() emits a creation notification for every
parent->dpll_refs entry, but dpll_pin_on_pin_unregister() emitted only
one deletion notification outside the loop. When a pin is registered
against multiple parent dplls, userspace sees N creates but a single
delete and leaks per-dpll state.

Move dpll_pin_delete_ntf() into the loop and call it before
__dpll_pin_unregister() so the DPLL_REGISTERED mark is still set when
dpll_pin_available() is consulted.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 80195f3a84f3..58034be07080 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1036,14 +1036,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
 			continue;
+		dpll_pin_delete_ntf(pin);
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.39.3

