Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F68467
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689900; cv=none; b=bClGUHccmr7V+/0MRAlaATwia79PH2QPM/ITAIVThDCAX0umjJ6fQJBu5ujLZMxbqT1anehBxlYTTbA33tJ0lAMAaJzwwyUlLNyQLLX5ChDeH5z9Irtk/srK26xmJ8ZsaBz1dohGknpvWF6P/NjfdjY3jESKfu0K84DyVn/frPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689900; c=relaxed/simple;
	bh=NlCV0XPyFqunr7tuleA8xNsyu4zTegMcxbVLgRwtjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWzGwW5AgFpKMANHECMXdiraa/p1GcSzGtLmJSaeXG2HU6Z8QuFAOPxEQpU+O4Y6RX7MtBClAZxk7KDaF0sUXCEC35WyTN+NKIxW/USFuEKtziGcDOAH2VvMyeQVJnqsO03NiEsaH68kn3AG2eVD2RxCAqk1y2gnW7kuJXHKbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: David Seifert <soap@gentoo.org>
To: netdev@vger.kernel.org
Cc: David Seifert <soap@gentoo.org>
Subject: [PATCH] musl: include <limits.h> for PATH_MAX macro
Date: Sun,  8 Dec 2024 21:31:26 +0100
Message-ID: <20241208203126.23468-1-soap@gentoo.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://bugs.gentoo.org/946088
---
 ip/iplink.c  | 1 +
 ip/ipnetns.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index aa2332fc..27863b98 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <stdbool.h>
+#include <limits.h>
 #include <linux/mpls.h>
 
 #include "rt_names.h"
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 5c943400..de16b279 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <limits.h>
 #include <linux/limits.h>
 
 #include <linux/net_namespace.h>
-- 
2.47.1

