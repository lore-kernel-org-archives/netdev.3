Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F493B1035
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065163; cv=none; b=G3n+5SUFdXCNPwrb9LxH7DlXf/ESeZS+YDpeunNANfWsXkf2JgV0WUVst5gizZZvWhsdKc1AzQDgQa0kdyVVCNUYNs8vQYJTy3mNMOJvD71R6iFH4LXyaeye/ev1bC9VgbkorYKCH1KRNjGSNLseBbAN+VHSkmleTa+8MWaAQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065163; c=relaxed/simple;
	bh=PI7uGsrqYBml1yQ62BeBmR0W34Xd1twYSjkMHlzDzmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RC7DsR0wayZxZMC9dQI4e4A+DZn7vTaEh2jv4wsqWkD7Pw2lajTvUJFnYbnpLwCuVQCqNs8At9ZNry4BZtS7F5bjWUuIQT3iJLUGCXGJCbzzxr8hmdXghzVRLoqIKOPng1CwSEQjibdshjC2SDD2x64RbIZwPuppIsBUw+mQn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAPQBPfl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH73my5T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAPQBPfl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH73my5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789065155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
	b=bAPQBPflQ6lDt2SR2n/pONTIUYov1eEEEyas/q5t5O2qmU/nqs1hsdUqfxVe0ZZwe79WSH
	p3qMPD1zlmaZCh5BFWDBo2RPKwfPhIwW3A6Ib8A7g5FQ2bpM0gvTApsClK4NwW5ajOzJu5
	B7KgmYXa6lntHGiJAWpA+L2E3nlK44Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-G6KQVbL8O4Ow-VeyX9eHww-1; Thu, 10 Sep 2026 14:32:34 -0400
X-MC-Unique: G6KQVbL8O4Ow-VeyX9eHww-1
X-Mimecast-MFC-AGG-ID: G6KQVbL8O4Ow-VeyX9eHww_1789065153
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49d156c917cso8048155e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789065153; x=1789669953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
        b=WH73my5TrNFumBPYszXMFqj3qQE+a/7rwiHVfWW7WHa0IoW7FiLdmmEhClKjvgGYJf
         05Jvomo3PPUqqqSPMLISQmHvm3NcgsBzYHj+XkXSA4OdXPVP9un7J8T9sGbEuLHVTEqP
         5Iavtb32JgHcuIHYIb0n1w+xVtAFG/2lsAntmhm/E0xrZiRqawtXNAhQybXTXtF9K/t5
         26jg1exri47xvolKXV5FUPeFhsL1qaslF6LIgh1PoKmp/AZwQOsgEedvGE+ULxaCz7ve
         pYSbw4n14M1Hmb7mbSzshpu3RMghN8bt/nmWPX0kC6YS3q2h7T9EMQMjYMWeGYM6BVKT
         kh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065153; x=1789669953;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpWhO6z/1eXUTTgA/H9eXGVtX0eq8vp4A6ySs0zyK0c=;
        b=W+XvPMbqZYpiPhPiNMeWAAbV72VWFd0cwl5kUyArm9GRsBGHfm72NkaVd3lWbHPWMG
         KvSzOcetlXtpXgiMdfkSrWPxSEAhwXJZonJUPVknY7MlKNVXiq9WKU3IAg4kmp+KrLKH
         d8ZPK0ITk05GxLnEh0WHmmYLRI1j/lYlbzo81bMsDWbQgjeGmgEiNdBN9MrRCzU/xHOD
         TtLDwrSGkeOiQ5xXVgy0ygqKcHMraX/QPaBmK8n/V/6yLZk6SnGeLBlG6ckP8029Zout
         IpDsbFhipgSz2noQ9AoB9E2PX0Nu75EBItEQMv/RPbnTyOh7Av6w8eePqbo6DeUnjqo3
         Knkg==
X-Forwarded-Encrypted: i=1; AKwUvByJxgIP++YU43ZKDEey3PgxXEubAy9b3krpXNH0lJ4CH1HmFVTX+w9S/4ZvheKYmI/WffuknVI=@vger.kernel.org
X-Gm-Message-State: AFuF++lHw7tw/WNIMjf5PC95ZgrwZs+UCIeFfo06w5Kw6SqVRqHO1Bwp
	hQP8ViHwicH4MNhGFyckenDcxTXB6e2gZIMWVfMOsq3cWRv5+WCe3Ghrae9cw9cFrGyp1lyipu8
	W/sKYfCecznlr83YzFTZphMM7UiuATUUOiWgcqQjqdhQWdVdTcFLhG/kL5A==
X-Gm-Gg: AYBFou0lGCFEVhCES7+ENz78q9aHlAr899xCz2Tbwqy3ieTh/HzI3GfLDoSOvDpB+eG
	CvuuWZMr6CMpi9PswH0pqrL2LQ/2aJpTxOXACKIOFF80NTrtzinz4yGcX8QxIjdzJZ33SbCWk9u
	ikUp1jEZdkewB/joDcwznYNqUBadlTAx1KmxC7LlcaQs+0GjSuFH8HqBgJo1rCvJTBbco6HNStD
	cxpCwtQTm2oPaSsWWHX+FXNpUvjt6wb4oiqJYHDDo7yphPg2Xe8NAa0B1a1n0kYnj4pBRdaOAwp
	1Xu9hbiXBQx1vbV6hV+z6miZsEST09fBtrRqqODK3g6Yle3p7YlKCWcoUnrCEl+p0RHVYr/hVcX
	sTDnLJOorkuHFbSr1pKw/+dhr30A=
X-Received: by 2002:a05:600c:620a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49e60f5af42mr10094045e9.2.1789065153251;
        Thu, 10 Sep 2026 11:32:33 -0700 (PDT)
X-Received: by 2002:a05:600c:620a:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49e60f5af42mr10093785e9.2.1789065152909;
        Thu, 10 Sep 2026 11:32:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a80948sm2211005e9.3.2026.09.10.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:32:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A2B529B97EE; Thu, 10 Sep 2026 20:32:30 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Adopt bpf_program__add_flags() helper
Date: Thu, 10 Sep 2026 20:32:16 +0200
Message-ID: <20260910183222.307208-3-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt the newly added bpf_program__add_flags() helper everywhere the
selftests non-destructively modifies program flags (which turns out to
be every use of bpf_program__set_flags() in the tests).

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c      | 4 ++--
 tools/testing/selftests/bpf/test_loader.c                  | 5 ++---
 tools/testing/selftests/bpf/testing_helpers.c              | 4 +---
 tools/testing/selftests/bpf/veristat.c                     | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c              | 2 +-
 8 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 7dadb90e7b68..41136e1c7752 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -543,9 +543,7 @@ static void test_kprobe_sleepable(void)
 		return;
 
 	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(
-			       skel->progs.handle_kprobe_sleepable,
-			       bpf_program__flags(skel->progs.handle_kprobe_sleepable) | BPF_F_SLEEPABLE),
+	if (!ASSERT_OK(bpf_program__add_flags(skel->progs.handle_kprobe_sleepable, BPF_F_SLEEPABLE),
 		       "kprobe_sleepable_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 652307a1b22e..902a70d5afeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_type type)
 	}
 
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | testing_prog_flags());
+	bpf_program__add_flags(prog, testing_prog_flags());
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
 
 	err = bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index ed3fd0a88dab..651123cd8602 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -361,8 +361,7 @@ static void test_attach_api_fails(void)
 
 	sl_skel->bss->user_ptr = sl_skel;
 
-	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
-				     bpf_program__flags(sl_skel->progs.handle_kprobe_multi_sleepable) | BPF_F_SLEEPABLE);
+	err = bpf_program__add_flags(sl_skel->progs.handle_kprobe_multi_sleepable, BPF_F_SLEEPABLE);
 	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 047dfdc322a2..3ab963458903 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -408,14 +408,14 @@ void test_xdp_metadata(void)
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, rx_ifindex);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	/* Make sure we can load a dev-bound program that performs
 	 * XDP_REDIRECT into a devmap.
 	 */
 	new_prog = bpf_object__find_program_by_name(bpf_obj->obj, "redirect");
 	bpf_program__set_ifindex(new_prog, rx_ifindex);
-	bpf_program__set_flags(new_prog, bpf_program__flags(new_prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(new_prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	if (!ASSERT_OK(xdp_metadata__load(bpf_obj), "load skeleton"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 794a7dfb0579..28724de06322 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -748,7 +748,7 @@ static void prepare_case(struct test_loader *tester,
 			 struct bpf_object *obj,
 			 struct bpf_program *prog)
 {
-	int min_log_level = 0, prog_flags;
+	int min_log_level = 0;
 
 	if (env.verbosity > VERBOSE_NONE)
 		min_log_level = 1;
@@ -766,8 +766,7 @@ static void prepare_case(struct test_loader *tester,
 	else
 		bpf_program__set_log_level(prog, spec->log_level);
 
-	prog_flags = bpf_program__flags(prog);
-	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
+	bpf_program__add_flags(prog, spec->prog_flags);
 
 	tester->log_buf[0] = '\0';
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 3f037949e978..d1d60451c5bc 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -292,7 +292,6 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	);
 	struct bpf_object *obj;
 	struct bpf_program *prog;
-	__u32 flags;
 	int err;
 
 	obj = bpf_object__open_file(file, &opts);
@@ -308,8 +307,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	if (type != BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) != type)
 		bpf_program__set_type(prog, type);
 
-	flags = bpf_program__flags(prog) | testing_prog_flags();
-	bpf_program__set_flags(prog, flags);
+	bpf_program__add_flags(prog, testing_prog_flags());
 
 	err = bpf_object__load(obj);
 	if (err)
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e70741c6b9b7..9cfc9b4b41c1 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1722,9 +1722,9 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	fixup_obj(obj, prog, base_filename);
 
 	if (env.force_checkpoints)
-		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STATE_FREQ);
+		bpf_program__add_flags(prog, BPF_F_TEST_STATE_FREQ);
 	if (env.force_reg_invariants)
-		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_INVARIANTS);
+		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
 
 	opts.log_buf = buf;
 	opts.log_size = buf_sz;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index c5501b3fdf48..ab3f5fc56e86 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -845,7 +845,7 @@ int main(int argc, char *argv[])
 
 	prog = bpf_object__find_program_by_name(bpf_obj->obj, "rx");
 	bpf_program__set_ifindex(prog, ifindex);
-	bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_XDP_DEV_BOUND_ONLY);
+	bpf_program__add_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
 
 	printf("load bpf program...\n");
 	ret = xdp_hw_metadata__load(bpf_obj);
-- 
2.55.0

