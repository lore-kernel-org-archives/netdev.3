Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252659;
	b=1qRtxamInpFPD9D3IcBo84wM384nNR3ggUer3NomfVqx4P9MlUWDNZ6Sv6SskXNnte94
	 1FqI+vtUCN6v8LvYsuNIrmUGyrr5ERaIGSKEAvlZHKvjUn8S8A3QC4KfP3RWefzDATEFK
	 l30XTZukt03eQPs2iZa0v8fNmm9pFScnHsQSQF8KZGkJ4ye67xUznor5elI0Cv5zjqPGS
	 NmPt6LLtQwVhjl9hap9WaEXEW/UF66HMW1Zd70sP+ooy/mTUNMvPacOYJZzLjwfii1M+V
	 XHPgiEyksmGEbNSobm39vopFPg4rQ1ZSbDjMa0SrcJBOGVEvm9Bn2fiF27GsgWzi9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rj1LZOnv/SE1NOc5ikyvnTDvl7OuS8ukJ6aGZ0BFbZA=;
	b=ObqdR5DEK26Z8wYprohWOpS421jqzAIR/qykOj7mgeMnJSpRNduh7tawVXKcWUmZhiWF
	 Ac/6X2zmV/hlY8/2D3XooJgtegbv/A39ZGEI0ibv3ItvqKQ1G2PtM2d8V6Y9i69m62bwE
	 qUmritQVBzcZW44Pi0dgdu7p+eFCUagPbNppUvJEUquZqbOx6j4ARZ373TacyXlIcVXgI
	 B4/S33BSiiJzeh9CcmqBdQ/EzOfONshB4S3dQcv8nzNcZFnYyrCE64MCK2CBIwyd43Eov
	 /rrcckO9fm1aY9JpK8u76+W3TE4X3atN3nd4pIQYh5yrsKIxUHXN9JRWfaKUgVIAdlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8kiLEFY;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEE606A333
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39BEE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8kiLEFY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794252658; x=1825788658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y61z1sw4xngWoQSApiB694z8YCrIUbPA4OCVfPaamFE=;
  b=F8kiLEFY+Mc5vt2CrXJXNF1zeUJVsgsortMZTQ32PQAqCbuPBiDyTBre
   PM+sxC8XdDw+DKAiMrVH3s4DlAinGM6lo5I5TLBQsVz5RaZZrP5/U+D78
   Zvj4SDORFYKzVwwC8p0R2N59Uh6EIk1eZmQx75ziC4oPA76UU91xHNtTR
   Y3WQBZFX7xP0234RDMYkXJdJD6P/ThhUkbzbjKkhgLGmnp5QncQv4Po9c
   zRIvw+Ibp1Ey5DA7DgdWIwMHxCvIKXvcaByUONuPstpqL9pbSLAFslKhx
   yTP/NJivtWhYBdP7nA+Newk5pVqFoOFvKfhoYbYPP1bYNbrLYLeFRUdZe
   Q==;
X-CSE-ConnectionGUID: uuJggbvESIW/3PNCqiY+3Q==
X-CSE-MsgGUID: Bapp+6AMRriz5zY/zyAYJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3021036"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3021036"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:30:58 -0800
X-CSE-ConnectionGUID: Pn/uAX0KTeGxDT1Uc/bv2w==
X-CSE-MsgGUID: V5tj2BKdQDO5jEkJA8yg7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9807973"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa013.fm.intel.com with ESMTP; 09 Nov 2026 11:30:56 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v2 net-next 1/4] selftests/bpf: drop the test_progs AF_XDP wrapper
Date: Mon,  9 Nov 2026 20:30:45 +0100
Message-Id: <20261109193048.1006986-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

prog_tests/xsk.c runs the xskxceiver cases inside test_progs. With the
AF_XDP test suite moving to selftests/net in a following patch, the
wrapper would make test_progs build the engine and its XDP program
from there, so drop it.

BPF CI loses ns_xsk_skb and ns_xsk_drv. test_xsk.sh still covers the
same cases over veth, but no CI runs it until the suite is ready for
NIPA.

ci_skip_tests[] only held the cases that the wrapper left out, so fold
it into tests[]. The test IDs do not change.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.h       |   3 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 170 ------------------
 tools/testing/selftests/bpf/xskxceiver.c      |  10 +-
 3 files changed, 2 insertions(+), 181 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..69158b67466c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -297,9 +297,6 @@ static const struct test_spec tests[] = {
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
 	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
-	};
-
-static const struct test_spec ci_skip_tests[] = {
 	/* Flaky tests */
 	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
 	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
deleted file mode 100644
index 772f3dd7ce64..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ /dev/null
@@ -1,170 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <net/if.h>
-#include <stdarg.h>
-
-#include "network_helpers.h"
-#include "test_progs.h"
-#include "test_xsk.h"
-#include "xsk_xdp_progs.skel.h"
-
-#define VETH_RX "veth0"
-#define VETH_TX "veth1"
-#define MTU	1500
-
-int setup_veth(bool busy_poll)
-{
-	SYS(fail,
-	"ip link add %s numtxqueues 4 numrxqueues 4 type veth peer name %s numtxqueues 4 numrxqueues 4",
-	VETH_RX, VETH_TX);
-	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_RX);
-	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_TX);
-
-	if (busy_poll) {
-		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_RX);
-		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_RX);
-		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_TX);
-		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_TX);
-	}
-
-	SYS(fail, "ip link set %s mtu %d", VETH_RX, MTU);
-	SYS(fail, "ip link set %s mtu %d", VETH_TX, MTU);
-	SYS(fail, "ip link set %s up", VETH_RX);
-	SYS(fail, "ip link set %s up", VETH_TX);
-
-	return 0;
-
-fail:
-	return -1;
-}
-
-void delete_veth(void)
-{
-	SYS_NOFAIL("ip link del %s", VETH_RX);
-	SYS_NOFAIL("ip link del %s", VETH_TX);
-}
-
-int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
-{
-	rx->ifindex = if_nametoindex(VETH_RX);
-	if (!ASSERT_OK_FD(rx->ifindex, "get RX ifindex"))
-		return -1;
-
-	tx->ifindex = if_nametoindex(VETH_TX);
-	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
-		return -1;
-
-	tx->shared_umem = false;
-	rx->shared_umem = false;
-
-
-	return 0;
-}
-
-static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
-{
-	u32 max_frags, umem_tailroom, cache_line_size;
-	struct ifobject *ifobj_tx, *ifobj_rx;
-	struct test_spec test;
-	int ret;
-
-	ifobj_tx = ifobject_create();
-	if (!ASSERT_OK_PTR(ifobj_tx, "create ifobj_tx"))
-		return;
-
-	ifobj_rx = ifobject_create();
-	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
-		goto delete_tx;
-
-	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "configure ifobj"))
-		goto delete_rx;
-
-	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-	if (!ret) {
-		ifobj_tx->hw_ring_size_supp = true;
-		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
-		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
-	}
-
-	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
-	if (!cache_line_size)
-		cache_line_size = 64;
-
-	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
-	if (!max_frags)
-		max_frags = 17;
-
-	ifobj_tx->max_skb_frags = max_frags;
-	ifobj_rx->max_skb_frags = max_frags;
-
-	/* 48 bytes is a part of skb_shared_info w/o frags array;
-	 * 16 bytes is sizeof(skb_frag_t)
-	 */
-	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
-	ifobj_tx->umem_tailroom = umem_tailroom;
-	ifobj_rx->umem_tailroom = umem_tailroom;
-
-	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
-		goto delete_rx;
-	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
-		goto delete_rx;
-
-	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
-
-	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	if (!ASSERT_OK_PTR(test.tx_pkt_stream_default, "TX pkt generation"))
-		goto delete_rx;
-	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
-	if (!ASSERT_OK_PTR(test.rx_pkt_stream_default, "RX pkt generation"))
-		goto delete_rx;
-
-
-	test_init(&test, ifobj_tx, ifobj_rx, mode, test_to_run);
-	ret = test.test_func(&test);
-	if (ret != TEST_SKIP)
-		ASSERT_OK(ret, "Run test");
-	pkt_stream_restore_default(&test);
-
-	if (ifobj_tx->hw_ring_size_supp)
-		hw_ring_size_reset(ifobj_tx);
-
-	pkt_stream_delete(test.tx_pkt_stream_default);
-	pkt_stream_delete(test.rx_pkt_stream_default);
-	xsk_xdp_progs__destroy(ifobj_tx->xdp_progs);
-	xsk_xdp_progs__destroy(ifobj_rx->xdp_progs);
-
-delete_rx:
-	ifobject_delete(ifobj_rx);
-delete_tx:
-	ifobject_delete(ifobj_tx);
-}
-
-void test_ns_xsk_skb(void)
-{
-	int i;
-
-	if (!ASSERT_OK(setup_veth(false), "setup veth"))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (test__start_subtest(tests[i].name))
-			test_xsk(&tests[i], TEST_MODE_SKB);
-	}
-
-	delete_veth();
-}
-
-void test_ns_xsk_drv(void)
-{
-	int i;
-
-	if (!ASSERT_OK(setup_veth(false), "setup veth"))
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (test__start_subtest(tests[i].name))
-			test_xsk(&tests[i], TEST_MODE_DRV);
-	}
-
-	delete_veth();
-}
-
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..6cf95a44c8c0 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -327,14 +327,12 @@ static void print_tests(void)
 	printf("Tests:\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++)
 		printf("%u: %s\n", i, tests[i].name);
-	for (i = ARRAY_SIZE(tests); i < ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests); i++)
-		printf("%u: %s\n", i, ci_skip_tests[i - ARRAY_SIZE(tests)].name);
 }
 
 int main(int argc, char **argv)
 {
-	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
 	u32 cache_line_size, max_frags, umem_tailroom;
+	const size_t total_tests = ARRAY_SIZE(tests);
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -449,11 +447,7 @@ int main(int argc, char **argv)
 			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
 				continue;
 
-			if (j < ARRAY_SIZE(tests))
-				test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
-			else
-				test_init(&test, ifobj_tx, ifobj_rx, i,
-					  &ci_skip_tests[j - ARRAY_SIZE(tests)]);
+			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
 			run_pkt_test(&test);
 			usleep(USLEEP_MAX);
 
-- 
2.43.0

