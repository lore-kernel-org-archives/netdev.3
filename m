Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521073;
	b=NNDSWl8FYcVojtcsQoWAFtv5qkq20XCZHqdVHVIBLJtyT8F+9u6UAn7caglpJaeEKEaB
	 1XyYb4Z7/u1Oag0odTasbEU+mJapC7BVS+UeWby4+BAz/qfUTvDxivjZ4xiiwZM5yMw/k
	 hLxvemV7/GTkD8CwhraTPExyxRqEatoMJuBlei5wv+yLos28HmItofwg7D0MIAdxBOGyL
	 jAgLHxnIpRgnm9Da0xHha2emYJgS+Ovl8QtCLqXHUI+aS1kaW6OfaRLHWugVf75zzfGDY
	 wA9Hsu4HXifLZNDbNyR0+rU2TBzg0TU0/7d1307WbVE/7hOGPM2J76Cf1eQGn6uhBzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QcfjJsTF/PzZsq0pp89MIFI9OrI6d1YbyNN4vvIC+34=;
	b=wXPwuaWLoqgM2F9bzwEG6X+KN4X9Fjrg3iM0r/zJ3+Mv3V7WD871+DXnsC3if2DB9vPI
	 15sMh4ZmAVrjKpUrhD0mV5HXaJB6ujW8o00ahMS1XlYkjMJuooIl9WO3rMXSYs7PQN52m
	 C+bGADJHyF07XA95XZYSdEULA3G2mIy+64j3f1OMma0igGCA1Ip7IIf95O6GHW9NODurG
	 gnTh1IAppqxukGIuKldE+cdBbKEHOvX9AjJe959Rz6DSNF74GATJSEDY7C7hl+XIxaB4p
	 i4I7fSY0c8fC35R5YfXjeBjGHpKPaPMlZWRgCWKsnoU0CUS27Kl2FcfWc/R6YQ/cwXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8e8M3op;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC606A32D
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 08:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411BC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8e8M3op
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1727400a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521072; x=1794125872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcfjJsTF/PzZsq0pp89MIFI9OrI6d1YbyNN4vvIC+34=;
        b=e8e8M3oplfgu5sCEqtHoHQEyAn0EuYk2yBGHdapnBg0ZMprlQ4nqm1ZwDPbBKayJab
         s0cqprNNEPneFYAXDPQ4XFvisR13ReC11uu4CmlWz1sBAlue+bi72FRuCAj9R0n3V/fK
         B0IeyTADL1R0Xi4WAaN/gSLCn6xasCwYjByONBsRo8tgdP9wHHCNRtBfv4PpXkASbTeV
         433cAL1np3FyKbFdZibworL1HTNwbh4l4fCgQJc11ahxKh2Gi+4uQsjWYjYPVTutAi5Z
         33boMkwOZQbpz6fRDCW7gXEzF/7CuoOMNyPV2H1nJuxGBMTA4UvBxzmpF4LexK8m6Mmj
         7jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521072; x=1794125872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcfjJsTF/PzZsq0pp89MIFI9OrI6d1YbyNN4vvIC+34=;
        b=JpgCLrVL9N4BXgv1anC6qow2TXMT0USxSyDNjSLwTNfdH4lZtEbWIqW8wa4me9boGs
         hexNedJaHMHV0Xt89UACfsaofAyT6gNjyv2gZalxJvb22z2dbkoYFei8mknXlaJscWrC
         RbrCU6O5LN5snenb2yaGTxKKqLQqMm1Klrdazs8M4MCYznPyGHRF7MPcQveOk3VAGiuR
         lIQUMEFTNyHZOVnIAEhcCnnSoClfvriQUxkHHKVjeFrVi5DJonNbvZKGUTcre9KinWuv
         i7iSVGBR4AKMlZznwfMfMOEYnUj9vclBIXmYasMZB/A6SFEtizrRj0G3ZM9dH8lC1BIj
         yrAQ==
X-Forwarded-Encrypted: i=1; AKwUvByYLaFQVCOHEs1WQJnaXcIpVVdE+BFT7Cleugi4KUt4rtRkjrBWEPPZdAb6AeAwSJIXwVzqfMc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4SpdngdF/12mN47V4xeOzfX3XnXqPSCOXUFh1gXbw8d1BKRnh
	KfdTfZVURde9Linb7NPegwhAVfuJBZOiae/d46IcAmK3ZgQRwUhv7VBm
X-Gm-Gg: AYBFou3h91YDcjTf/YbdYCE5+ixgsU/WWaxfhHyszBPkQwEXYUFGAv16doPO/NAj5Ft
	Ia8CT2WtYuBiykV4Z2uI/29e9XNdDS2ZpUkO+j6xi/oFIDoaKE3xtLXtBYsSSw4Gr17dLu/u0wJ
	TaMQvko28tBWHhxTEdVHCk1OCzV+23Sarffq7GtCOHPW7TM31K55qsXPGPFYFlRiTwBmc58iBxI
	DO1Yxb4E0ken+LUWaPMZf1j0DWZDE/eCCvhfPpGv2l2ZvWzPr+CnifLMQJBZXxB45LC+0+Xs7Qu
	C6ni4XSzTg2iHmWvBQgpechZGdCuV7mdEQwQk8c8HHE9hu1VpBXauDnn81DFbUfixu5OUqGFVdj
	PGGfxF8c3A1izGaPw42sIraF1ML1P3VZQJy/ejUTCImVp4JvOG4epvTwgMXpMl8YWV9Qa8UXk7c
	BneLdGRarkCdh536C0N0+VTVeYBzu9l4ByGVABBxCEbGwpNfcq9l3Li6WkWtzFCuXo6FMUTiB2O
	+pxFHiyPxYdW9XSrpp+EhqqgAm4IAJMkdcPVDtaEs0iEYJWxs233I4mMOyhlIihJFPKrsxRae8h
	UQf06tgAkr6+mvs9kh05X3e3U/69W7qMMJnfFgK/aZ6GmY6/jPZ1KS1algU2jeVY2uIgk05zRxO
	RQw==
X-Received: by 2002:a17:90b:17c1:b0:3ac:9706:7739 with SMTP id 98e67ed59e1d1-3ae89724dfcmr5080442a91.17.1793521072372;
        Sun, 01 Nov 2026 01:17:52 -0700 (PDT)
Received: from LDYT9Q2G2M ([2a09:bac5:cad2:3228::4ff:28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm10011455a91.9.2026.11.01.01.17.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 01:17:51 -0700 (PDT)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] lib/ts_fsm: add KUnit coverage for exported patterns
Date: Sun,  1 Nov 2026 16:17:36 +0800
Message-ID: <20261101081736.51803-3-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261101081736.51803-1-zhiqizhangg@gmail.com>
References: <20261101081736.51803-1-zhiqizhangg@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression coverage for exporting an FSM pattern and preparing another
configuration from it. Check all 14 public token types with positive and
negative matching examples, and a sequence containing a repeated class.

Compare the exported bytes with the input pattern as well as checking
matching behaviour. Verify that the original configuration remains usable
after exporting and recreating the pattern. Register cleanup actions so
that early assertion failures still destroy the configurations.

OpenAI Codex drafted these tests and the changelog and drove the recorded
automated validation.

Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 lib/Kconfig.debug                |  14 ++++
 lib/tests/Makefile               |   1 +
 lib/tests/textsearch_fsm_kunit.c | 138 +++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 lib/tests/textsearch_fsm_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec..416d033b0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2531,6 +2531,20 @@ config STRING_HELPERS_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 
+config TEXTSEARCH_FSM_KUNIT_TEST
+	tristate "KUnit tests for FSM text search" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select TEXTSEARCH
+	select TEXTSEARCH_FSM
+	default KUNIT_ALL_TESTS
+	help
+	  Test that exporting and recreating an FSM text search configuration
+	  preserves its matching behaviour. Exercise each public token type
+	  and a sequence of tokens with a repeated character class. Check
+	  that exporting also leaves the original configuration usable.
+
+	  If unsure, say N.
+
 config STRING_KUNIT_BENCH
        bool "Benchmark string functions at runtime"
        depends on STRING_KUNIT_TEST
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b..fa47ef5d3 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -54,6 +54,7 @@ CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
+obj-$(CONFIG_TEXTSEARCH_FSM_KUNIT_TEST) += textsearch_fsm_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
diff --git a/lib/tests/textsearch_fsm_kunit.c b/lib/tests/textsearch_fsm_kunit.c
new file mode 100644
index 000000000..6cb173b97
--- /dev/null
+++ b/lib/tests/textsearch_fsm_kunit.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Tests for exporting and recreating FSM text search configurations. */
+
+#include <kunit/test.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/textsearch.h>
+#include <linux/textsearch_fsm.h>
+
+struct fsm_test_case {
+	const char *name;
+	u16 type;
+	const char *match;
+	const char *miss;
+};
+
+static const struct fsm_test_case fsm_test_cases[] = {
+	{ "specific", TS_FSM_SPECIFIC, "x", "y" },
+	{ "wildcard", TS_FSM_WILDCARD, "A", "" },
+	{ "digit", TS_FSM_DIGIT, "7", "A" },
+	{ "xdigit", TS_FSM_XDIGIT, "f", "g" },
+	{ "print", TS_FSM_PRINT, "A", "\n" },
+	{ "alpha", TS_FSM_ALPHA, "A", "7" },
+	{ "alnum", TS_FSM_ALNUM, "7", "!" },
+	{ "ascii", TS_FSM_ASCII, "A", "\200" },
+	{ "cntrl", TS_FSM_CNTRL, "\n", "A" },
+	{ "graph", TS_FSM_GRAPH, "!", " " },
+	{ "lower", TS_FSM_LOWER, "a", "A" },
+	{ "upper", TS_FSM_UPPER, "A", "a" },
+	{ "punct", TS_FSM_PUNCT, "!", "A" },
+	{ "space", TS_FSM_SPACE, " ", "A" },
+};
+
+static void fsm_case_to_desc(const struct fsm_test_case *params, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", params->name);
+}
+
+KUNIT_ARRAY_PARAM(fsm, fsm_test_cases, fsm_case_to_desc);
+
+static void fsm_destroy_config(void *conf)
+{
+	textsearch_destroy(conf);
+}
+
+static void fsm_expect_matches(struct kunit *test, struct ts_config *conf,
+			       const struct fsm_test_case *params)
+{
+	struct ts_state state = {};
+	unsigned int pos;
+
+	pos = textsearch_find_continuous(conf, &state, params->match,
+					 strlen(params->match));
+	KUNIT_EXPECT_EQ(test, pos, 0U);
+	pos = textsearch_find_continuous(conf, &state, params->miss,
+					 strlen(params->miss));
+	KUNIT_EXPECT_EQ(test, pos, UINT_MAX);
+}
+
+static void fsm_check_roundtrip(struct kunit *test,
+				const struct ts_fsm_token *pattern,
+				unsigned int len,
+				const struct fsm_test_case *params)
+{
+	struct ts_fsm_token *exported;
+	struct ts_config *conf, *recreated;
+	int err;
+
+	conf = textsearch_prepare("fsm", pattern, len, GFP_KERNEL, TS_AUTOLOAD);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conf);
+	err = kunit_add_action_or_reset(test, fsm_destroy_config, conf);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	fsm_expect_matches(test, conf, params);
+
+	KUNIT_ASSERT_EQ(test, textsearch_get_pattern_len(conf), len);
+	exported = kunit_kmalloc(test, len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, exported);
+	memcpy(exported, textsearch_get_pattern(conf), len);
+	KUNIT_EXPECT_MEMEQ(test, exported, pattern, len);
+
+	/* Exporting a pattern must preserve the existing search behaviour. */
+	fsm_expect_matches(test, conf, params);
+
+	recreated = textsearch_prepare("fsm", exported, len, GFP_KERNEL,
+				       TS_AUTOLOAD);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, recreated,
+					 "exported token: type=%u recur=%u value=%u",
+					 exported->type, exported->recur,
+					 exported->value);
+	err = kunit_add_action_or_reset(test, fsm_destroy_config, recreated);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	fsm_expect_matches(test, recreated, params);
+	fsm_expect_matches(test, conf, params);
+}
+
+static void fsm_test_pattern_roundtrip(struct kunit *test)
+{
+	const struct fsm_test_case *params = test->param_value;
+	struct ts_fsm_token pattern = {
+		.type = params->type,
+		.recur = TS_FSM_SINGLE,
+		.value = 'x',
+	};
+
+	fsm_check_roundtrip(test, &pattern, sizeof(pattern), params);
+}
+
+static void fsm_test_sequence_roundtrip(struct kunit *test)
+{
+	static const struct ts_fsm_token pattern[] = {
+		{ TS_FSM_DIGIT, TS_FSM_MULTI, 0 },
+		{ TS_FSM_SPECIFIC, TS_FSM_SINGLE, ':' },
+		{ TS_FSM_UPPER, TS_FSM_SINGLE, 0 },
+	};
+	static const struct fsm_test_case params = {
+		.match = "77:A",
+		.miss = "77:a",
+	};
+
+	fsm_check_roundtrip(test, pattern, sizeof(pattern), &params);
+}
+
+static struct kunit_case fsm_kunit_test_cases[] = {
+	KUNIT_CASE_PARAM(fsm_test_pattern_roundtrip, fsm_gen_params),
+	KUNIT_CASE(fsm_test_sequence_roundtrip),
+	{}
+};
+
+static struct kunit_suite fsm_test_suite = {
+	.name = "textsearch-fsm",
+	.test_cases = fsm_kunit_test_cases,
+};
+
+kunit_test_suite(fsm_test_suite);
+
+MODULE_DESCRIPTION("FSM text search configuration tests");
+MODULE_LICENSE("GPL");
-- 
2.54.0 (Apple Git-157)

