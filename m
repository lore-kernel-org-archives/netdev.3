Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC34ADDA2
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555712; cv=none; b=cylIQ8Wl/2RjQ6zwWpXwsLqS2me2hl1kFPLNIugqhBvTYuw7plnuoVRSCLKDhrDsxmI/vOXj9iYHn5LVJO6c75si9Ju5h9OoPCTPU394m2UWks3AHTsFn40+catBI+IeR5AGRDXOiAZ4vy3bVXuoBezVNGwrYspTOUIM6qy7WPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555712; c=relaxed/simple;
	bh=dyhuZhWVeLlVjPYOi35FsozVlSLj8PAtOptkreeIrtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhmIY4MNTcpX7bNBAt5l7prrd9vIQPcds2epboUOWVjf3rO73ny2uzdolxofvWi/XnIDFci6VNx5z4XGKQpwymCG7kFSvBNQ+K3jV0PgL8kMJjLBG9PDISq1RkmG7q70upe2gkawkQY9Qk/0v2t2i3BY3ZVUVZzpmbqJ0xBp0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9eTINvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9eTINvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE986C2BCB1;
	Tue,  3 Mar 2026 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555712;
	bh=dyhuZhWVeLlVjPYOi35FsozVlSLj8PAtOptkreeIrtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9eTINvJQwmd7YOEgf0i6HWWq+HbQ6//uR74FpPEd7HxUiVMsEOqPaG7nBdq09EjQ
	 y1SLRJZdNM1O/bShwcKoi7NvZAoW+oL2QcISILK4WVQbXqcrb8QdEBwoh6V4eSNNKv
	 Chebjh5XJxKtUj1g8+IAnYImJg66RIdyf+IAvY97GaVtPBxSmr97vJ9uXwvNB6xB6L
	 TnGd9bdMmDPDJjcOByRwCyj2PZxRm5c0vzaVGlqxCGrEd7wN2LREmhXrBnuOssS6OC
	 ndVBvESXpqerFIaQKDJunrdGa7XSvgtcY3X7B556v/5+0BkSPt7gd82xwmXg9JLV/i
	 77uR7Qjgs1K+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] tools: ynl: rename TESTS variable to TEST_PROGS
Date: Tue,  3 Mar 2026 08:35:01 -0800
Message-ID: <20260303163504.2084981-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
References: <20260303163504.2084981-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the standard kselftest variable naming for tests in the Makefile.
NIPA depends on being able to selectively target tests by setting
those variables on the CLI.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index c1df2e001255..ee4362ca286d 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -1,23 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for YNL tests
 
-TESTS := \
+TEST_PROGS := \
 	test_ynl_cli.sh \
 	test_ynl_ethtool.sh \
-# end of TESTS
+# end of TEST_PROGS
 
-all: $(TESTS)
+all: $(TEST_PROGS)
 
 run_tests:
-	@for test in $(TESTS); do \
+	@for test in $(TEST_PROGS); do \
 		./$$test; \
 	done
 
-install: $(TESTS)
+install: $(TEST_PROGS)
 	@mkdir -p $(DESTDIR)/usr/bin
 	@mkdir -p $(DESTDIR)/usr/share/kselftest
 	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(DESTDIR)/usr/share/kselftest/
-	@for test in $(TESTS); do \
+	@for test in $(TEST_PROGS); do \
 		name=$$(basename $$test .sh); \
 		sed -e 's|^ynl=.*|ynl="ynl"|' \
 		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
-- 
2.53.0

