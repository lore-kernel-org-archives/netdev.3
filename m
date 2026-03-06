Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3A30F526
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762963; cv=none; b=dMeA2DcYD6o6bkd2mukt4uxPc1Apu6CbMPtqexzciZryk1mWwTzFGbLxVp+K+RicGrEs0L0IGZzusTb8y7BjycU8XuI7K9hbVmWRXmk5bCEEVevhCa+++hnNkyVKJmcYyNfHPP7AllOJnB90m0GJFjFO5NeqSmgp0GdBFrYGu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762963; c=relaxed/simple;
	bh=Xk9WHS8YGf06Isjf0uTetpHzqqihVGnzxW2axX6zubs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPv1Tfjv4UUZvDeZU8mXYpoL7KLboONmvvUBJWO8U/+vwxFDi+Az5Bt1EEdTBc52kl11vQSMhENnmc35XMEFGsT9tKZaJB6OmOYiKGCQ3yOd6h0Q8jiKulaULj3KRBK5kRB70aA5ek+FldUWM5vsI6a3xv2I1piRxyW3fMHhj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV0zTOQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV0zTOQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7FBC19423;
	Fri,  6 Mar 2026 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762962;
	bh=Xk9WHS8YGf06Isjf0uTetpHzqqihVGnzxW2axX6zubs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RV0zTOQw3ZcklpRBn0r19EgsUv6wFpEvS7xsfzMdkioFFU2N6Wpv2C9PJzrKPUpni
	 pwS+SjeItHQcREKHzaNFkzQXhI6Wmz8prm2zleY982MQjaysWbF3V2Z3aARPMLK9RW
	 Tj1vmsG5EVTzpuoOPa3nifvAYV7QTJrsj03dk0tQeSmZp3HRbx6rrXEd6wSQdVkp88
	 +H2vGboJ2sU7tbotwEiZbt5szBVAbSzJIoiQlwg2d1jiOdTBx5uBzKhQqL5yeb8q7O
	 +Eyewx+tfkM+/1treccuhUxTwL4lzGbjLXkN+f2EWPuBfUjFeqOAZjNYA6igeXPpKk
	 DmfwBBEHWp/hQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/10] tools: ynl: convert ovs sample to selftest
Date: Thu,  5 Mar 2026 18:08:54 -0800
Message-ID: <20260306020901.524105-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306020901.524105-1-kuba@kernel.org>
References: <20260306020901.524105-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ovs.c to produce KTAP output with kselftest_harness.
The single "crud" test creates a new OVS datapath, fetches it back
by name, then dumps all datapaths verifying the new one appears.

IIRC I added this test because ovs is a genetlink family but
has a family-specific fixed header.

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           ovs.crud ...
  # get:
  # ynl-test(3): pid:0 cache:256
  # dump:
  # ynl-test(3): pid:0 cache:256
  #            OK  ovs.crud
  ok 1 ovs.crud
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/tests/Makefile |   3 +-
 tools/net/ynl/tests/ovs.c    | 124 ++++++++++++++++++++++++-----------
 tools/net/ynl/tests/config   |   1 +
 3 files changed, 87 insertions(+), 41 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 1d77d3662f46..df9d37c8b2a4 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -20,12 +20,12 @@ TEST_PROGS := \
 
 TEST_GEN_PROGS := \
 	netdev \
+	ovs \
 # end of TEST_GEN_PROGS
 
 BINS := \
 	devlink \
 	ethtool \
-	ovs \
 	rt-addr \
 	rt-link \
 	rt-route \
@@ -34,6 +34,7 @@ BINS := \
 # end of BINS
 
 CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
+CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
 CFLAGS_tc-filter-add:=$(CFLAGS_tc)
 
 include $(wildcard *.d)
diff --git a/tools/net/ynl/tests/ovs.c b/tools/net/ynl/tests/ovs.c
index 3e975c003d77..6be002c28eff 100644
--- a/tools/net/ynl/tests/ovs.c
+++ b/tools/net/ynl/tests/ovs.c
@@ -4,57 +4,101 @@
 
 #include <ynl.h>
 
+#include <kselftest_harness.h>
+
 #include "ovs_datapath-user.h"
 
-int main(int argc, char **argv)
+static void ovs_print_datapath(struct __test_metadata *_metadata,
+			       struct ovs_datapath_get_rsp *dp)
+{
+	EXPECT_TRUE((bool)dp->_len.name);
+	if (!dp->_len.name)
+		return;
+
+	EXPECT_TRUE((bool)dp->_hdr.dp_ifindex);
+	ksft_print_msg("%s(%d): pid:%u cache:%u\n",
+		       dp->name, dp->_hdr.dp_ifindex,
+		       dp->upcall_pid, dp->masks_cache_size);
+}
+
+FIXTURE(ovs)
 {
 	struct ynl_sock *ys;
+	char *dp_name;
+};
+
+FIXTURE_SETUP(ovs)
+{
+	self->ys = ynl_sock_create(&ynl_ovs_datapath_family, NULL);
+	ASSERT_NE(NULL, self->ys)
+		TH_LOG("failed to create OVS datapath socket");
+}
+
+FIXTURE_TEARDOWN(ovs)
+{
+	if (self->dp_name) {
+		struct ovs_datapath_del_req *req;
+
+		req = ovs_datapath_del_req_alloc();
+		if (req) {
+			ovs_datapath_del_req_set_name(req, self->dp_name);
+			ovs_datapath_del(self->ys, req);
+			ovs_datapath_del_req_free(req);
+		}
+	}
+	ynl_sock_destroy(self->ys);
+}
+
+TEST_F(ovs, crud)
+{
+	struct ovs_datapath_get_req_dump *dreq;
+	struct ovs_datapath_new_req *new_req;
+	struct ovs_datapath_get_list *dps;
+	struct ovs_datapath_get_rsp *dp;
+	struct ovs_datapath_get_req *req;
+	bool found = false;
 	int err;
 
-	ys = ynl_sock_create(&ynl_ovs_datapath_family, NULL);
-	if (!ys)
-		return 1;
+	new_req = ovs_datapath_new_req_alloc();
+	ovs_datapath_new_req_set_upcall_pid(new_req, 1);
+	ovs_datapath_new_req_set_name(new_req, "ynl-test");
 
-	if (argc > 1) {
-		struct ovs_datapath_new_req *req;
+	err = ovs_datapath_new(self->ys, new_req);
+	ovs_datapath_new_req_free(new_req);
+	ASSERT_EQ(0, err) {
+		TH_LOG("new failed: %s", self->ys->err.msg);
+	}
+	self->dp_name = "ynl-test";
 
-		req = ovs_datapath_new_req_alloc();
-		if (!req)
-			goto err_close;
+	ksft_print_msg("get:\n");
+	req = ovs_datapath_get_req_alloc();
+	ovs_datapath_get_req_set_name(req, "ynl-test");
 
-		ovs_datapath_new_req_set_upcall_pid(req, 1);
-		ovs_datapath_new_req_set_name(req, argv[1]);
-
-		err = ovs_datapath_new(ys, req);
-		ovs_datapath_new_req_free(req);
-		if (err)
-			goto err_close;
-	} else {
-		struct ovs_datapath_get_req_dump *req;
-		struct ovs_datapath_get_list *dps;
-
-		printf("Dump:\n");
-		req = ovs_datapath_get_req_dump_alloc();
-
-		dps = ovs_datapath_get_dump(ys, req);
-		ovs_datapath_get_req_dump_free(req);
-		if (!dps)
-			goto err_close;
-
-		ynl_dump_foreach(dps, dp) {
-			printf("  %s(%d): pid:%u cache:%u\n",
-			       dp->name, dp->_hdr.dp_ifindex,
-			       dp->upcall_pid, dp->masks_cache_size);
-		}
-		ovs_datapath_get_list_free(dps);
+	dp = ovs_datapath_get(self->ys, req);
+	ovs_datapath_get_req_free(req);
+	ASSERT_NE(NULL, dp) {
+		TH_LOG("get failed: %s", self->ys->err.msg);
 	}
 
-	ynl_sock_destroy(ys);
+	ovs_print_datapath(_metadata, dp);
+	EXPECT_STREQ("ynl-test", dp->name);
+	ovs_datapath_get_rsp_free(dp);
 
-	return 0;
+	ksft_print_msg("dump:\n");
+	dreq = ovs_datapath_get_req_dump_alloc();
+	dps = ovs_datapath_get_dump(self->ys, dreq);
+	ovs_datapath_get_req_dump_free(dreq);
+	ASSERT_NE(NULL, dps) {
+		TH_LOG("dump failed: %s", self->ys->err.msg);
+	}
 
-err_close:
-	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
-	ynl_sock_destroy(ys);
-	return 2;
+	ynl_dump_foreach(dps, d) {
+		ovs_print_datapath(_metadata, d);
+		if (d->name && !strcmp(d->name, "ynl-test"))
+			found = true;
+	}
+	ovs_datapath_get_list_free(dps);
+	EXPECT_TRUE(found);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
index 339f1309c03f..357b34611da4 100644
--- a/tools/net/ynl/tests/config
+++ b/tools/net/ynl/tests/config
@@ -3,4 +3,5 @@ CONFIG_INET_DIAG=y
 CONFIG_IPV6=y
 CONFIG_NET_NS=y
 CONFIG_NETDEVSIM=m
+CONFIG_OPENVSWITCH=m
 CONFIG_VETH=m
-- 
2.53.0

