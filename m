Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE023CD8B1
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653926; cv=none; b=HgNGa3CzwPK4i4QUS1+bezMDS3uElBwM7c9rCM98oJJc4IfhQgne/v5INWklLwtVn4RHOSaf2yyZlhX+uh4ChjzQEdw0Run03cly4+R/mkcShR570VIRFJ+d1UJNXb1roAJRk4A0ssUh8MoQJSYardrTe1gjuAs93G8gX+xM/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653926; c=relaxed/simple;
	bh=PpPMGQbAmgiuM9HIOll7uCflsYjGK5MLju7m2oo4jhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvTeD7shG9DZDzjXaMAZS4/FiJ3joNl33XcsUK1FlE8ClQ9PXwdUO7Svc/aN4hhWePLdt+dIevXtnA4V/+xTp3aF2Hy2hkjU7bta3N55rbvQoi6yVZCPNtsnjjyUyyW8//JrI+6F/+GLis6TuPJXXlT1g7Ton+WMqN1eNbjk1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/fsh/lh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/fsh/lh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653923; x=1807189923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PpPMGQbAmgiuM9HIOll7uCflsYjGK5MLju7m2oo4jhc=;
  b=P/fsh/lhqhisrn963H4i8oM+5eDG0CTe4yuDw0gDJXjppVCRkbYGR4az
   ZTGVT+4w+xxerA3P87fBRru1LVBDiga6Du5Cy/gbfPDqqni7oBIc2H/SF
   T1j/3eEvogiUbcZDcqA+5fMnfb4Dfan08zsLQWxZFDAGUs7sBfV8/X0Ii
   UT1+qnwi9jJFriLuOkT2qMmsM23IFYxmQ9yK0WLIZk4VSoKbb4t5dIDod
   wxKaF4OMBCW603WaRRI1jz6kcnJUXNCZZhLbnE2wJbHF/v65lrjwAH0wx
   9npDf1J8WZFX+fY3ww38Gp0mk7tJdFb93YUhzTYuAu+9uoIBXWDWqPn0X
   w==;
X-CSE-ConnectionGUID: uG9YOWnnQROHgxtSyqmWAg==
X-CSE-MsgGUID: jp0HmR9jR6ezRAdf4y4fFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087234"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:02 -0700
X-CSE-ConnectionGUID: nX59O9kFTlGYWVPwcZAbHg==
X-CSE-MsgGUID: 6hyiGce6S/ugd6MA8qRDbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228714962"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:02 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-net v2 4/6] ixgbe: fix cls_u32 nexthdr path returning success when no entry installed
Date: Wed,  8 Apr 2026 15:11:52 +0200
Message-ID: <20260408131154.2661818-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
even when ixgbe_clsu32_build_input() fails for every candidate entry
and no jump-table slot is actually programmed.  Callers that test the
return value would then falsely believe the filter was installed.

The variable 'err' already tracks the last ixgbe_clsu32_build_input()
return value; if the loop completes with a successful break, err is 0.
If all attempts failed, err holds the last failure code.  Change the
unconditional 'return 0' to 'return err' so errors are propagated
correctly.

Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v1 -> v2:
 - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
   return is a user-visible correctness bug, not a cleanup).

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..6e7f8a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10311,7 +10311,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 				kfree(jump);
 			}
 		}
-		return 0;
+		return err;
 	}
 
 	input = kzalloc_obj(*input);
-- 
2.52.0
