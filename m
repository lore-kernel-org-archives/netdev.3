Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC37263B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872275; cv=none; b=IbEHjVZPY7k5cuJTOYyWT5jDccTeok4mtKgEFNtZ59JyEpoJi6jXgcOCVOkvDhshTlg6NEGKKLFl4UsjNhNPSkiDKR8pMx4kUYVe5ZEWeVlHfohoJXLJmXr0JrooPP0H68dSaWYCUPKmwznHvI9nxeKTQh7O7fviA1JYONAHM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872275; c=relaxed/simple;
	bh=3fRmPQKteOOiOxEbZeHv6la9gP4hfmfJPqu7KAj7ZgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psIzHwN0X8JWohzCELy1yiIfq4wkl9Teq9YWZwrxRkdkpPfA2QoPp+AnsmRIoT0KwcSXiAXity/+O/qJBgvJEjOgN4tFyGbbnF8wBaVo2UGRipMCysmNs2KYqh2595t3RbSfd098ociwnYft+VAgLQKUEEOA/WophIa81rp92GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvadXRa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvadXRa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E2A1F00A3A;
	Wed,  1 Jul 2026 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872274;
	bh=Xke1GweU36y3e1sZ2CtkJ23FtWzM+P/iIj4KDN1At6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IvadXRa0En3IJq0xoia8PpqI3kVVUmtPLCDJhlo8JKl/VzPt+i+nEstfQZ7+d6D+K
	 pxSVm1o2KtP5U/NYj1IcecGNdnPpNuN3K44Vbg+lhUnGQDgH2lbbmuplDV5K/XYn2a
	 BE5esi7TL/2iijLbIwegfJsVZIgNeMFZyShJp77ZiHk/BJfZRLA5nFZVxKs2JFPbU1
	 Cb1hrTy34ojcTqpHSNjQAvElG271z7o2p7SKX5r1gvAj94nlrvutOIXLicsCPeqROx
	 1X7U/Ytq0JA7dl4Tftq6fIczS59vg/0jVu/YD1fM6Aog4sLeaBy5Gyy+mgWhsAmPka
	 CBmWXT9djNH6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	jstancek@redhat.com,
	ast@fiberby.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] tools: ynl: pyynl: re-export the library API from the package root
Date: Tue, 30 Jun 2026 19:17:50 -0700
Message-ID: <20260701021751.3234681-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701021751.3234681-1-kuba@kernel.org>
References: <20260701021751.3234681-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The public classes live in pyynl.lib, so users had to spell out

  from pyynl.lib import YnlFamily

which I forget at least once a month. Re-export lib's API from
the package __init__ so that

  from pyynl import YnlFamily

works as well. I don't think there was a real reason not to do
this?

Acked-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/__init__.py b/tools/net/ynl/pyynl/__init__.py
index e69de29bb2d1..d8f59c132ab7 100644
--- a/tools/net/ynl/pyynl/__init__.py
+++ b/tools/net/ynl/pyynl/__init__.py
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+""" Python YNL (YAML Netlink) library. """
+
+# Re-export the public library API so it can be imported straight from the
+# package, e.g. `from pyynl import YnlFamily`.
+# pylint: disable=wildcard-import,unused-wildcard-import
+from .lib import *
+from .lib import __all__
-- 
2.54.0

