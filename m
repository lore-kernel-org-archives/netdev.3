Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63298310655;
	Thu,  2 Apr 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138781; cv=none; b=k3SBwmzJ8KW9cgMK7FY7mN/Ff15eReUxVpGBNOmfg8k7lKNJHOjJ2MghUxhqJK91x/WdT/qHqadItPoi1rNWI+k8JgauDDmVHKNg26QiooajVTBm5Rc+vfNC3MsgqxWJkXG4tubl2SY3nRuAjg3F0yE3Z1EDlbLbbVc7E9EMqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138781; c=relaxed/simple;
	bh=pfgVGDgPPhXVTWpuZF/LlQPzPd5D5CTCfpW+uxpq64g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYWKp3MQ1iyB3CutH0zB26HXo1MSXo6IGgMzkNoX0lzkLPF88TeRP+Z/CYpWFXUv2qhE6nBhcOzaHir2EgXHlpnLTfRu5n7uv59q7qOVMruKB0TiMrx7pomRI4YBYdQ1smVoM2hBGfgyn48P4wzBWHBqg5d+oQvJEko7txQkYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=oV+zLoew; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oV+zLoew"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=yx8315qT6qYcNHYrSQC5idH5MKNb4uq1YT/n0BZxwKA=; b=oV+zLoewNQw9Q1OD1U9
	tyKsvtj2aMbaEiTt+/djXr0kY4vBWvcfPqu1+ZdqBcOg/DH22YQ/DyrNPr75Cqt15Jbypkfn4tsDC
	QdGHhVzFQm6uD7AFVoq+rXYX7ebm0Hu0f/2rhU4DzoAoNzOdXg9cvPdH7lrtssl/PT98tpFWMNogX
	dPZtckPwnv/pg471vlyZf73PlCQwqb5O7W552tIHSYx8Iw3LgOUhEeMSQJ42qTZnTmcFIyveYaODV
	qOMKG5JE8qAJYA+McJZFeylVWxwa6QJbm00TSXtId4YwOkNspoR82DW69yAVt4XJB+aK2qU+Nt7OH
	NiWvqmbAqNCbRxg==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w8Ie8-003MIM-1L;
	Thu, 02 Apr 2026 16:05:56 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: [PATCH 1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
Date: Thu,  2 Apr 2026 17:05:57 +0300
Message-ID: <20260402140558.1437002-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260402140558.1437002-1-khorenko@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_GCOV_PROFILE_ALL=y is enabled, the kernel fails to build:

  In file included from <command-line>:
  In function 'skb_extensions_init',
      inlined from 'skb_init' at net/core/skbuff.c:5214:2:
  ././include/linux/compiler_types.h:706:45: error: call to
    '__compiletime_assert_1490' declared with attribute error:
    BUILD_BUG_ON failed: skb_ext_total_length() > 255

CONFIG_GCOV_PROFILE_ALL adds -fprofile-arcs -ftest-coverage
-fno-tree-loop-im to CFLAGS globally. GCC inserts branch profiling
counters into the skb_ext_total_length() loop and, combined with
-fno-tree-loop-im (which disables loop invariant motion), cannot
constant-fold the result.
BUILD_BUG_ON requires a compile-time constant and fails.

The issue manifests in kernels with 5+ SKB extension types enabled
(e.g., after addition of SKB_EXT_CAN, SKB_EXT_PSP). With 4 extensions
GCC can still unroll and fold the loop despite GCOV instrumentation;
with 5+ it gives up.

Mark skb_ext_total_length() with __no_profile to prevent GCOV from
inserting counters into this function. Without counters the loop is
"clean" and GCC can constant-fold it even with -fno-tree-loop-im active.
This allows BUILD_BUG_ON to work correctly while keeping GCOV profiling
for the rest of the kernel.

This also removes the CONFIG_KCOV_INSTRUMENT_ALL preprocessor guard
introduced by d6e5794b06c0, as __no_profile handles both GCOV and KCOV
instrumentation at the root cause level rather than just disabling the
check.

Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
Fixes: d6e5794b06c0 ("net: avoid build bug in skb extension length calculation")

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/core/skbuff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..47c7f0ab6e84 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
 #endif
 };
 
-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 {
 	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
 	int i;
@@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
 static void skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
-#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
-#endif
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
 					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),
-- 
2.43.5

