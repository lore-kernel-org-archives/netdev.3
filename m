Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287E364059
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203281; cv=none; b=aGDS3ZVgmvCq7SaiCpDDBg7pDOb+o8XJh+UnK25+pvPFEPuxUJ3bsWCkAcHqrD1SLgbQqxR/DsbvhCFX1z3nMaZmWvtfBPaKwdEj4CQBhLHTiUny75tF9D8OLv+eVlcrUnkJzi5FQfysQ1uCCBKRV24gscjtkZvr7L8aMfvI/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203281; c=relaxed/simple;
	bh=H72joEEQeU7EkBxFVrmcwkidXuoJ1VE1rpgUFhTyapM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufLbx4R3DO9Xot2GkwxOV3xkyScNqacMljRKAJgsC6s5Xc9ibS9Pk+5GMEHwNkIGZhIEKHTqL/Oc2PYC6V9B/780B4xEEGc1xFFX4LcedZYyBjLYO4cip+Iwqka4rew5D2P8dbYHLaS6jKEOTWCuH6jH9Uqib7ar5i/R75oB9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxdmcbBj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYnzIC0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxdmcbBj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYnzIC0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789203279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk/BARFjkrnis1WDPjmICHhSE0NsdL5Q0jVyiwGdh9Y=;
	b=SxdmcbBj8Jhc3ze8dZ+U9wqY1b6wjuixPbhXaDsi0Pfp/JeQLWtlJsUE/Qacn1NV8kVX/8
	V9Jd+0PPCNVwqABPkY4h1mZV+ktUfpzbramt9JGdpF43+dbuyVFjm03kROccWQdK3idfTY
	Bh80/XBs7nDUL9fGrGa8wvmiJIkL8zU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Fz8DlU3bMwC4-bDGvEoxrA-1; Sat, 12 Sep 2026 04:54:37 -0400
X-MC-Unique: Fz8DlU3bMwC4-bDGvEoxrA-1
X-Mimecast-MFC-AGG-ID: Fz8DlU3bMwC4-bDGvEoxrA_1789203276
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so6769425e9.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789203276; x=1789808076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tk/BARFjkrnis1WDPjmICHhSE0NsdL5Q0jVyiwGdh9Y=;
        b=cYnzIC0+2NigKyc/JmqqQRaXNf14cZazMcnvAXLCmOnQeuIO0ZqrxikccL+6Zh3Auw
         +n5dtvSDgJvxJDJ/7BjkgdP7w+Lxw7PkO76dP5MNJm1R9rLUM3Vhh3V2I6RhaEzuchNJ
         zjw2MvebC3/o5Ql8mlftvf0yk8PyJwKsQcRXVzJmKn29EHAQrsrJrwC4QWNcGaZgC9y4
         RAvNE3iB3YaDlui+C5mo3UviDtewNhCtS3FcxdpUzoT+UAP6otTe7//uopfPzDtzwICl
         ojP1VL/HMZu6mmcVVg+a+TwFQ3lVqb5JGxPeMyrgcQDhKj2cxFp37yLzQXaTsNAkNVZi
         R6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203276; x=1789808076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tk/BARFjkrnis1WDPjmICHhSE0NsdL5Q0jVyiwGdh9Y=;
        b=P5U+G9qOAT0qV0rNN9YM5kvolin0BUXgf9nAwHxReUQ5Vjhm3faiOm+2GFN8F+LwK5
         IQDWoVQ6in36BewxgivDZ2iOV0TvSh1WFO+pW/g83nn8gfynlgd0yvygtIVd6aLTuUTX
         nN+Kt2VK8Ph/PLkGb4RPAJBL8n+WYORJHJsUdZZIjY8ducEQMIdx8Lg0XwbvDBMz5Eya
         j1XND8GoZobYKSG4YdGPMnP85gKjQ2dvj4nYqhdJ+IJzB2hkp9wmbCwmxMFEX6tiZspj
         2Kh3BbsFJlaovAh8Ew9m0yjNzsx76i/YKL4lIWDk3Zgb/vNcxjJ95xafr8D9vC7rY4+S
         kvnA==
X-Forwarded-Encrypted: i=1; AKwUvBwHbFZtHdzgqiR6QLDisLa14TwFwDeoLHvw+zlwHZ45PHUXdjTosdhuI+QKfgIXaURmgFxygxw=@vger.kernel.org
X-Gm-Message-State: AFuF++kv6UTvapCyC0Kw+UvgvoXYrWLzDHuRvPeZFey6IduY92BAIJ9+
	v0hqpoGh3OyVbDFmV07sj/bM4qtTWgPKZ9icL/4EjoXq2xcOa1xvwwCg32s6cyiC1wuWnTHQBbL
	qTxeEknL/XnRWwFJYC1MgxAFF+Bwsd4WFoliPI+KbJ9t7K+DVyoKHTFSF4Q==
X-Gm-Gg: AYBFou2Cb5rZV+K46pFyB5203uouzDLn0DL1sm419QXSVM/c5GrFt/wz67rHivWKYJ7
	zS8Kc46ac8OKXt4s+aZYyhtHqoXIY8vF/2MRw2cOyEFUqIukp9TqKL1dNDmdlqiE74zFP9PCsDK
	WV3ONEumc/75B2FK2TJnyl6CV20zTr5fyH0TCoSDToZLygKI9ebmolvGNk3mIXJ1uXBCohUxZct
	zVfQV6idAu2SyQ4ytwI2CafkzQZ5ccvfhCT4NTE6z+sCQshEtoLnhiAUyaB4zStMjovMfB1M+Q2
	/4yysyTAHhiT9aj6gWXtiDRmFU8P4a8rjsxqpCdhIeU/acQBcXzy7r7OCoKUbgyd56HX8hseoNb
	jVkpTr1dHc3sDuCUxNeE0ecSSJNo=
X-Received: by 2002:a05:600c:4fd4:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49e619b8a83mr182011535e9.12.1789203276065;
        Sat, 12 Sep 2026 01:54:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd4:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49e619b8a83mr182011225e9.12.1789203275618;
        Sat, 12 Sep 2026 01:54:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm203687945e9.13.2026.09.12.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:54:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 65B629B9ABB; Sat, 12 Sep 2026 10:54:34 +0200 (CEST)
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Adopt bpf_program__add_flags() helper
Date: Sat, 12 Sep 2026 10:41:02 +0200
Message-ID: <20260912084109.432834-3-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912084109.432834-1-toke@redhat.com>
References: <20260912084109.432834-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt the newly added bpf_program__add_flags() helper everywhere the
selftests adds program flags (replacing all uses of
bpf_program__set_flags() in the tests).

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c      | 4 +---
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/kasan.c             | 4 ++--
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c      | 4 ++--
 tools/testing/selftests/bpf/test_loader.c                  | 5 ++---
 tools/testing/selftests/bpf/testing_helpers.c              | 4 +---
 tools/testing/selftests/bpf/veristat.c                     | 4 ++--
 tools/testing/selftests/bpf/xdp_hw_metadata.c              | 2 +-
 9 files changed, 13 insertions(+), 19 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testing/selftests/bpf/prog_tests/kasan.c
index 7cd4d1208c3b..9911b96fec9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kasan.c
+++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
@@ -424,13 +424,13 @@ void serial_test_kasan(void)
 		prog = bpf_object__find_program_by_name(skel->obj, prog_name);
 		if (!ASSERT_OK_PTR(prog, "find rnd_hi32 on_stack prog"))
 			goto destroy;
-		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+		bpf_program__add_flags(prog, BPF_F_TEST_RND_HI32);
 		snprintf(prog_name, SUBTEST_NAME_MAX_LEN, "%s_%s",
 			 tests[i].prog_type, "not_on_stack");
 		prog = bpf_object__find_program_by_name(skel->obj, prog_name);
 		if (!ASSERT_OK_PTR(prog, "find rnd_hi32 not_on_stack prog"))
 			goto destroy;
-		bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
+		bpf_program__add_flags(prog, BPF_F_TEST_RND_HI32);
 	}
 
 	if (!ASSERT_OK(kasan__load(skel), "load prog"))
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

