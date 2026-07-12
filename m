Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9E3B3C1D
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883801; cv=none; b=N6KmvHtjjYOXZi9nLcV0KzY5iT4T2fKYtQ906tJYLEPaksH+oyOdzP0opPoj4PVqEXSvinUljD+q9oJq1cTbq7LUG+Xvcsqqdh+NlsikfYKrvo6XB4iNdLlqjei79+ZXwqjeIRcK9PgxR5s3zg77jNUT/6PYuA/l4xgn7wPTEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883801; c=relaxed/simple;
	bh=3omQbdkzxVMUTQWPVFWGZOcimZIiLKSzRtsVqayRl6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe7SAYx+5rDIhwY1ElkHoIVjMmYsTZDQq/NJj8kLDk91Axxchvm2LD0k1pv4osXt8+UnQSNSNzmy7sDuVBArAigKpy6Lmrm6s20FgmDFRDLzQW/ZmLiYoupw9ofl+xaYItnOJ818PAaWKUyZuCbA0nOYCANiHWr26GTD2WBdfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPjCV2Si; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPjCV2Si"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so743696b3a.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783883800; x=1784488600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5uUX9nBMX6dend7Nz469oivKMBhodrKtUvZhGLjA08A=;
        b=OPjCV2SifqQTkWTJ0FWmhRPFqvsoxA/pKlZu7TfAeYBDojM7ZJ1RJiR2V3ok0VfafT
         pLGo4vX/HedlPvxZ0WNL0lgh4HzcwxFGUPP4SX3GjYa4ikZ1l0jFqNLu3czfMkrXURL3
         YIhDqmy4ICz5dFa67x3/hp/WPJ+YhKy1elPxNrAYymifwbGq4Xa+kgNO4Eox+z9irOt7
         Dd6ZptwYuqsXNpmnzyPMhzh3+8hWU3FKA0CXDdi7Cpj5cQfqITZ+LzB3J9FTmdr2LE8J
         tYl7kFMCEkvW8WnZY3RSLF9xfvE6VJqhwPBdEk23l1k1406T9goChOPK2HCrAB55sMag
         mDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783883800; x=1784488600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5uUX9nBMX6dend7Nz469oivKMBhodrKtUvZhGLjA08A=;
        b=dTogEcYKU2K0xWExBCupd4h/UjLc1Z9I+8gxnHpcqKLkgSJwhsTbECM4ILgp5TFXsd
         z6OIb7pedVvRCFBagiaa8nmnvGayG6xjY7uiWN0jMclHEyyjDafZMjs29QWrWPUFQync
         Ks9s5IOG0IOHRsCYTaaTE1UbVOA/wJ/SqAmGOzS4b75FioLtaphfAZMfKf9YVlmvm2jS
         safMOegDWCH/TnoxEwLU3+yHrARUm9cAzytkzZPwU2cdci01hTrbzXy6d9SyUICbA5E2
         hpShwnsY/VoEhIhPt/AsC0h7qlI93jKhu7rAXS7NaAVkdd7cS0AUPvH/Rw7zLCVvu+kA
         B0hQ==
X-Gm-Message-State: AOJu0YxZJYYyJY+QT1CWz/WztzIQuc0nKos/xgjZiAY9HH/nok0EOUNX
	noC40497mFotKl38mmeiYa33mibGCGQrU2rf6Mk9tHz4xHPfe5Jlc3qt8QL/Pwr+
X-Gm-Gg: AfdE7cnZ8wjdkqyiqDfrGUOXGRnAfWn5tZ6OwfiHxteCpFRQURZ1nqfqkcU6hz0s5K7
	q7FA5DWm1HX6pmcx1PNTKvZIv8IJTCukk65xi0IeE+3WLwt9+TjdBb9B4n7WVnE67Vr32fQTaHX
	gR3WCeAXJAoxtvaV2SUirsWqlI7HcpVrdpydGGpHq/a+mYCh6XHZg1pbSWmizOINn8YUCttGbhH
	NEF5umrP0mxh737dsHHjrlEpgOfpYHread5EVGx09AU0BlDwXSFK7S3w4N+e1lxlwGVw3+pnlCk
	8Bbpymb2ICfwNglWvd1SiapX5EVV3nvEHwR7r10bHHHpHBh9JsT8pDaHHdaj75bW9GV9HN6szcF
	kNhwrOC2+lLRtn9Kvffe9Eag9JCwfUQKRRQKmvn9IIkaSYV508WVqpJDZahur0FxAPWXyj/h68w
	OpbL/P3Q38XsszJJUg/ITT6nj5ewz/ZJABUqxZmuh1AdvvAA==
X-Received: by 2002:a05:6a00:2d02:b0:842:6004:3fda with SMTP id d2e1a72fcca58-84889643027mr6044387b3a.25.1783883799726;
        Sun, 12 Jul 2026 12:16:39 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm13079371b3a.60.2026.07.12.12.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 12:16:39 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: [PATCH net-next 2/3] vxlan: honor per-nexthop fdb destination port
Date: Sun, 12 Jul 2026 19:12:17 +0000
Message-ID: <20260712191218.236-3-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712191218.236-1-jack4it@gmail.com>
References: <20260712191218.236-1-jack4it@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an fdb entry points at a nexthop group, vxlan_fdb_nh_path_select()
resolves the selected leg's remote IP but leaves the UDP destination port
at the device default (vxlan->cfg.dst_port).

Extend nexthop_path_fdb_result() to also return the selected nexthop's
NHA_FDB_PORT (0 when unset) and have vxlan_fdb_nh_path_select() store it
in rdst->remote_port.  vxlan_xmit_one() already prefers rdst->remote_port
when non-zero and falls back to the device port otherwise, so nexthops
without a port are unaffected.

This lets one fdb nexthop group load-balance a flow across legs that
share an underlay IP but differ in UDP destination port.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 include/net/nexthop.h | 5 ++++-
 include/net/vxlan.h   | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 9c8227996..7fb612a73 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -576,7 +576,8 @@ struct fib_nh_common *nexthop_fdb_nhc(struct nexthop *nh)
 }
 
 static inline struct fib_nh_common *nexthop_path_fdb_result(struct nexthop *nh,
-							    int hash)
+						    int hash,
+						    __be16 *fdb_port)
 {
 	struct nh_info *nhi;
 	struct nexthop *nhp;
@@ -585,6 +586,8 @@ static inline struct fib_nh_common *nexthop_path_fdb_result(struct nexthop *nh,
 	if (unlikely(!nhp))
 		return NULL;
 	nhi = rcu_dereference(nhp->nh_info);
+	if (fdb_port)
+		*fdb_port = nhi->fdb_port;
 	return &nhi->fib_nhc;
 }
 #endif
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index dfba89695..de41b3746 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -567,8 +567,9 @@ static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
 					    struct vxlan_rdst *rdst)
 {
 	struct fib_nh_common *nhc;
+	__be16 fdb_port = 0;
 
-	nhc = nexthop_path_fdb_result(nh, hash >> 1);
+	nhc = nexthop_path_fdb_result(nh, hash >> 1, &fdb_port);
 	if (unlikely(!nhc))
 		return false;
 
@@ -583,6 +584,8 @@ static inline bool vxlan_fdb_nh_path_select(struct nexthop *nh,
 		break;
 	}
 
+	rdst->remote_port = fdb_port;
+
 	return true;
 }
 
-- 
2.43.0

