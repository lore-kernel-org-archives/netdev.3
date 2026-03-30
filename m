Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C53CFF4C;
	Mon, 30 Mar 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878849; cv=none; b=c0kjbkyK8eLJzLs5JTTdK6lcHDggzFKcsn3PGn86UbIWwS6mnIZMNDmcwSiDzOHMdvIMvkJsu6zng+kOiO/uZudlVgaTocpfSgmagCmWUoltlQU9FVdGeMLFa5bk6rY3wQPlp38s9RLTUItnCGTgpSL7j+VhXz4OvXKg9Ohq7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878849; c=relaxed/simple;
	bh=midICES3zQg7WQIUNDsvP129E3nOXX9D6fKgbZuhsKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTWc0mQfkSQtnlqVXDm/V2LW7m9p8bJrh8uN2KPcyuni537YOJbgkNTK8ElSHL51tDlpennuTgoScAVwJbW+uhUVP+TthVgmr4V8hemTl7+1+CpptkpQgX/ReTEuCk288TRiP0nHR8EgJBnQmOshaIQlMdRoQFrj/oQ3GOfgquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=SwO5pRSZ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SwO5pRSZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=bS+5U5P3ccWJMWQmgqbXdtLDmIwpp0JJIkDW5ui3uko=; b=SwO5pRSZDfNC5fH5zon
	NG8RybTG3DlTxxya8s38dQkznBCJKBFDt6xI9UwCzrrfUPfnO7rshrpqfr1NcZ9XwPotzYc7JGe/d
	wm70uR/mvwtAEqnpn/OEmquBb2Uf7j3m1wZfddBo3AdUfjkQmrwX/T1T7Zjk3+nkD6kHQdK6rAGMb
	cd8+qQNJwucDjpibuaGnrFT/L/ipmJYbq903Ol24Pof28sDIHMV/YDyuDEroPsVpVEG+4eYyz+n+3
	o26c/Vzg/a2vGFWPK+Q/k+8+6+Iwu0AIlLhfhVKLz8q70QkfJ0jEPiP7vNJvudinbm1FQwg6EWaUw
	BBqPbcfF0CCe4kw==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7D1c-008K2q-1x;
	Mon, 30 Mar 2026 15:53:30 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	arnd@arndb.de,
	linux@weissschuh.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH 1/1] net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
Date: Mon, 30 Mar 2026 16:53:37 +0300
Message-ID: <20260330135337.937540-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260330135337.937540-1-khorenko@virtuozzo.com>
References: <20260330135337.937540-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_GCOV_PROFILE_ALL=y is enabled, GCC inserts branch profiling
counters into skb_ext_total_length() and, combined with -fno-tree-loop-im
from GCOV, prevents the compiler from constant-folding the loop that
sums skb_ext_type_len[] array elements.  This causes the compile-time
BUILD_BUG_ON(skb_ext_total_length() > 255) check to fail, even though
the actual computed value is well below 255.

The kernel already has a guard for CONFIG_KCOV_INSTRUMENT_ALL, which
causes the same problem.  Add a similar guard for GCOV.

The number of loop iterations matters: with 4 extension types (as in
earlier kernels), GCC 11 can still constant-fold despite GCOV. With 5+
types (after SKB_EXT_CAN and other additions), it gives up.  This is
why the issue only manifests in recent kernels with GCOV enabled.

Tested with GCC 11.4.1 and GCC 16.0.1 20260327 (experimental) - both
exhibit the same behavior.

Note that skb_ext_total_length() is still correct at runtime; this
change only allows the build to succeed when GCOV_PROFILE_ALL is
enabled for coverage analysis.

Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..98c3d4e63219 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5159,7 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
 static void skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
-#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
+#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL) && !IS_ENABLED(CONFIG_GCOV_PROFILE_ALL)
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
 #endif
 
-- 
2.43.5

