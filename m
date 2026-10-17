Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24753ADB9A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255267; cv=none; b=FDX5WaEq9bMWCuAPG7zCZBqYwrECxxWCQF8YV9hzEH2NF27ohh6KtJExCADeQNsKtafvLIjaGhFYSUvJVePnd5VQXSQifkKBWT15jHJ4lpFKwnUKU4TRr0kqwE/YORmjk/AY+ffG9KTHc1wMZZzyvh6FWkRFesk1TC3GhrERivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255267; c=relaxed/simple;
	bh=9aByiuY6uviIXExgY+w0sYV157gG0bi2Of4rSv4eqIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDfg+mLrfuNhM81MfOL4isXyNuVZsTwYmNJeFx6T3DJVV98w09RdeeYh3tAvotPQrjMmpYZpvYzwtalbIKhfD5XwXna84uq6lWUTVLcSBf5m+gdqSREwN/Qr5I4wUReo/B+lpKUFPMkF4eZEGksPQp96rc+XIo/PPNTTY4LCV0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRUXk3i2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRUXk3i2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a706146559so708125a91.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255265; x=1792860065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/qciBoMPYJlnJRP8tFkm767/AyPbCuLkauH7cTHL5k=;
        b=jRUXk3i2uewUVEpdP2tlVMbnRej3G/PTKpFcqebT93d+89MAvetL/oR3W0XhokhFhM
         sFnv0uRczAr46mD8spPaHlr2crjJJcBtHrM3nmiXpxEI+AYJu6zEt8xa0UzUqs2ZdUp4
         PpqWtsnzrkDxu2f372XzZNvGXiU4BRaVkPQRHt5Jw6pHU7ittZa6TglJDFjtRQ7Gy3tr
         VtkQfd/0lQdQLtZ2su8QE/sSgr7DWjHIygpH8bdRB/xRl04E1CW739Rvw2EFORU+33tu
         diPbYskU1GbH3ONwEjaB5syjDDELxbRPv4/r4wReRk8au3LJSpdBnkYckrQpYjpF0x/l
         IeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255265; x=1792860065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/qciBoMPYJlnJRP8tFkm767/AyPbCuLkauH7cTHL5k=;
        b=W1bImY0G5MN+bmjL4RJZ/ksfgg1azsvu+A9fTSSEE0c987za3KA7i9Xpug3jAnnhJE
         E92sIJQDoj6AloSD3oP5MxscBKa6OGEKZVhaDH7pU3u+gKKeDRz5A4YhTcne1QNw58Cc
         d0j8KAAwOXyN1ErWgsnnH5awrb7UU2tWIJWZ2oJZAT5/j3Q0C1JQdBeK3gXKbJ5Dj8xi
         Dei+YQLxhyj8AqQyFC+OeV+0pthIPO2gJLHx+uiATsrRrxslzEUENpSz3/aQGm4sjjIX
         7aBWaUgGahVv2c4Q4BKJYgdTMEFu8DNv/t3gD6KGpaXEOz6oSunqnyXbljDw1YyZRomg
         KGPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPuW/yTd1UFulEXPvHJexsgkFaf0+i8ztUPOOBphYRJEizlw8UI8T3Ohd2ZrVzOAmUkThmAus=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7JWAv5y3ZX4EF6CPLEinL9DtuuCPHRnxQs+kc1D2qoNwpZ5h7
	xmXbRgu3nc0+ptb5s2PuNqbuuO2tZKKi2tnR8gX/MUV52zTKyTWShGvwP3FyRA==
X-Gm-Gg: AYBFou2KuziZXtYhSZf8b8/E1VgyZopC9FZE3bbU/oR9A7J8UD+3HqLGzMNonAwxZaK
	F6BHeIkEm856sWG5NVLH9JaiaVXLhPjBvynPSbI+zCNvikOP4dclCHEuGrNRjqnSGJ4RYKmWrSz
	C7cbda9tBWOMy6VdyIqsM4PHcOA8FyCS6IqIM+h410psup5vaThtCN2aK5H4+TrtePsw3SIdi/P
	G20nI2uK8uHoDpt+pwBYHXEJkFVUlbRuxMGEZfqIYoALIvTCBsaAKq6TGA9PXBIDbMD1n9hTMXE
	ThTjhXys+XwDkn41Bz7b0VH7kemh0Hs+dEUsBLm+HJTjD7hv086VjUAN6ok6weHI1ch+l8LUenf
	Dx3cwb4J8cdkDB9X1l8cJYNPCQekDXYBCEvyC4t6a4q242gOZbeTgYzbCOtPgagjjzJRWrYeVjh
	2/RNVo1NSq+gUDpWoVGQcqk3sLrjDOnFwJ28hG0m1LdaZ0q8sz8KfQQYIN2KRA3oQEcke3arH9f
	KCr4Q0q4lp2uR2vgcOuLRAK72HFHYnoO017HFJCNwI6YNLQTv1YdWlibny3HMlGNZ3k2QDUSbMb
	nFimMtbbDbGm/sBVbvPuMWagKIN9/ENyP2+gnVQVgM6exL0xumHtmw==
X-Received: by 2002:a17:90a:d60d:b0:3ab:2737:3393 with SMTP id 98e67ed59e1d1-3acef4e6d00mr2910974a91.40.1792255265207;
        Sat, 17 Oct 2026 09:41:05 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm8704378a91.8.2026.10.17.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 32/43] bpf: Don't take an extension for a function that runs sleepable
Date: Sat, 17 Oct 2026 16:37:34 +0000
Message-ID: <20261017163745.3341787-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

An extension cannot be sleepable, and it is verified as a program that
runs under the RCU read lock.  But it runs in the context of the function
that it replaces.  For a sleepable program, or a function that is called
from a bpf_wq or bpf_task_work callback, that is rcu_read_lock_trace().

The verifier lets such an extension use maps and pointers that rely on
RCU.  Its maps are not counted as maps with sleepable users either, so
that what it got from them is freed behind a plain RCU grace period:

  WARNING: net/core/sock_map.c:903 at __sock_hash_lookup_elem+0xe8/0xf0

  BUG: KASAN: slab-use-after-free in bpf_prog_b3bad285227d855b_ext_storage+0x245/0x297
  Write of size 8 at addr ffff888108717a50 by task fr/955

The verifier knows the contexts that a global function is called in.
Refuse to replace one that is called without the RCU read lock, and the
main function of a sleepable program.  A function that sleepable code only
calls under bpf_rcu_read_lock() can still be replaced.

The summarization test has replaced functions of sleepable programs by
ones that do not sleep.  Expect that to fail.

Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 20 ++++++++++++++++++
 .../selftests/bpf/prog_tests/summarization.c  | 21 +++++--------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c812a5f1da8..d738ce6e7428 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22151,6 +22151,21 @@ static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *
 	return -EINVAL;
 }
 
+/*
+ * An extension is verified as a program that runs under the RCU read lock. Does
+ * the function that it is to replace?
+ */
+static bool func_has_rcu_read_lock(const struct bpf_prog *prog, int subprog)
+{
+	const struct bpf_func_info_aux *sub_aux = &prog->aux->func_info_aux[subprog];
+
+	if (!subprog)
+		return !prog->sleepable;
+
+	return !sub_aux->called[BPF_FUNC_CTX_SLEEPABLE] &&
+	       !sub_aux->called[BPF_FUNC_CTX_NO_RCU_LOCK];
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -22247,6 +22262,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Cannot extend a writable raw tracepoint program\n");
 				return -EINVAL;
 			}
+			if (!func_has_rcu_read_lock(tgt_prog, subprog)) {
+				bpf_log(log,
+					"Cannot extend a function that runs without RCU read lock\n");
+				return -EINVAL;
+			}
 			tgt_changes_pkt_data = aux->func
 					       ? aux->func[subprog]->aux->changes_pkt_data
 					       : aux->changes_pkt_data;
diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
index 6951786044ca..3e4bcf071735 100644
--- a/tools/testing/selftests/bpf/prog_tests/summarization.c
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -53,17 +53,6 @@ static void test_aux(const char *main_prog_name,
 	err = summarization_freplace__load(freplace);
 	print_verifier_log(log);
 
-	/* The might_sleep extension doesn't work yet as sleepable calls are not
-	 * allowed, but preserve the check in case it's supported later and then
-	 * this particular combination can be enabled.
-	 */
-	if (!strcmp("might_sleep", replacement) && err) {
-		ASSERT_HAS_SUBSTR(log, "sleepable helper bpf_copy_from_user#", "error log");
-		ASSERT_EQ(err, -EINVAL, "err");
-		test__skip();
-		goto out;
-	}
-
 	if (expect_load) {
 		ASSERT_OK(err, "summarization_freplace__load");
 	} else {
@@ -86,9 +75,8 @@ static void test_aux(const char *main_prog_name,
  * Also test a case when main subprogram itself is replaced and is a single
  * subprogram in a program.
  *
- * This holds for might_sleep programs. It is ok to replace might_sleep with
- * might_sleep and with does_not_sleep, but does_not_sleep cannot be replaced
- * with might_sleep.
+ * An extension is verified as a non-sleepable program, hence nothing that runs
+ * sleepable can be replaced.
  */
 void test_summarization_freplace(void)
 {
@@ -111,7 +99,7 @@ void test_summarization_freplace(void)
 		},
 	};
 	const char *pkt_err = "Extension program changes packet data";
-	const char *slp_err = "Extension program may sleep";
+	const char *slp_err = "Cannot extend a function that runs without RCU read lock";
 	struct {
 		const char *func;
 		bool has_side_effect;
@@ -136,7 +124,8 @@ void test_summarization_freplace(void)
 				if (!test__start_subtest(buf))
 					continue;
 				test_aux(mains[t][i].main, mains[t][i].to_be_replaced, replacements[t][j].func,
-					 mains[t][i].has_side_effect || !replacements[t][j].has_side_effect,
+					 t == 0 &&
+					 (mains[t][i].has_side_effect || !replacements[t][j].has_side_effect),
 					 replacements[t][j].err_msg);
 			}
 		}
-- 
2.55.0

