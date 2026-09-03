Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EB3ACA5F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427481; cv=none; b=EbdbTk6chalv0pqX/u/oB9zBjjPEKK0FDA23jgfF3T9Ey2NlByytJmnYQcHUVs8FoHnr3YIDmW/93AfUzWgUjgo6j4zVXcvATjsMnGWSwcnGYpvyTZCJmgZ873ZVsG1AjOn4T/kKZz9kHMmrjW82sb7GxSzSHypsPE9yUFwsbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427481; c=relaxed/simple;
	bh=cEf4o8+8XW9QCAFqpuj0Ej54QC4VEezbJjbC7ptT+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0BEzVVa/ZUkig/KpVnifZtpASmR0JWysAnispBa7nIXmVLhkYSrOKZ0tLWu7pRjjRH/hnUxq5/Mpmivmj0YI6nYWPM/22LYlvwgmeqy8XVV2wTHpa8qxAnsxkN7VvD38rAtwTjk7XVsHvThcGLbVDwGzwQuZVXF6TeduTINOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9zLMDF8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaJaN4fU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9zLMDF8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaJaN4fU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mf6kivuRMhC5ODDzH3ln2mFV2QNDJ9sbY59yurKD9w=;
	b=M9zLMDF8frN0iuM0DX4bBlAu24FYbqjUSAHUZfP16R9ZVuF+0hcIhvEQm5BMxryFYeIEAj
	irZBEeT2dgs95QRs14ELVo33pVH3GtXIWSatu2SI7Q8NYkb+7jU+wp0e+2nVGr/Vsv6Cvy
	jD4aixGrPfTg0FrjOQh+cwDw4rfqz1g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-lvT8KvZTPX2v-mfWFx7Z6g-1; Thu, 03 Sep 2026 05:24:36 -0400
X-MC-Unique: lvT8KvZTPX2v-mfWFx7Z6g-1
X-Mimecast-MFC-AGG-ID: lvT8KvZTPX2v-mfWFx7Z6g_1788427475
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f4bff865cso1252970f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788427475; x=1789032275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4mf6kivuRMhC5ODDzH3ln2mFV2QNDJ9sbY59yurKD9w=;
        b=FaJaN4fUIf7kIYfq9cHwRsbLKqYPKzG0PIV4OgjS2elOnIgFMP3jnS09LFzNi+ijvM
         NXc2KYRoIa9NQFHflb2sg3CWFPCbhvYlKAiRXXVKvx2fcVyTZKh9LdIw1LlwGG6MfnSt
         JiSgqjYkxDIXqtceRlzJwpLqckcapk7i4CiIZgSxY9TgqszSTAqcm9T3euaB0QFPzeZB
         clpoJFxsX4nN5odukF6g1wXWAicrNvDc3MBy6mS8flsyEst3s4EjU5Bwvze8SHlMnrDo
         mzEH7yEwrFxyCsLjwJtu2n/vZmSwhD355XsdXBnHUrNklMJIC4t6y+vXqLqrFKsdKGQA
         LeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427475; x=1789032275;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mf6kivuRMhC5ODDzH3ln2mFV2QNDJ9sbY59yurKD9w=;
        b=Q2hluqe47jDjfYJYweLJ0HPLtdfEx5Ql0X3aecew7Kp8vIBcsDrWHJGO3Holig4/xb
         kop712Z3ZX1ZNwO5eBxFCHXlcWLHyBIDaQU5wbT69PIONimMoxYJP2rpzLed73bPXrTA
         EPsfid5mEATzbkKeQV9yjpKS4viQpgZMilexQVzRAhjshv4ALf0hum2Lse1nsW2kMAvy
         C47IGXhyLnFC0msn6MsjrYad0dVJqvKsuIL6a4cxrV7cDO+ejWIOsYJA8QQ0TQRjx6jP
         eTmle6tR5NDa7RKqnUM1sMv2r0W/GC5gRoA1od7gQnYp5doUO6iOLOw1KDKUNTkDxapI
         k4Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwSu7Vh+EUgKGux3PSeRNiPoz8+JRZblN4YSGcB9vdmoL+tNohvmr7iku4R9W1F6GIxzNHTLFE=@vger.kernel.org
X-Gm-Message-State: AFuF++ktdruPfc5lJHp8HR59QShSoKwAvPqtx9LRFXqOjpqvbWSn7lTe
	zVXHKsTOQe8CM6R2cUgiiHt5Ufo5anIZWJIn8HDPXGJhE4uHTohlrNvwumpcvb7MAkIkXlKEcRO
	vLlX6P9i54Y73ggIkbvuDuN6BHyya2AKWAtlLU7XXthOXNmvfAzn4MuLcOA==
X-Gm-Gg: AYBFou0t+fD/cSAI4m0L1imE7MlMSbP3H9zXtrbBf2FHh4oynXMjcRQ6ReZK2GU+WZt
	ntv4bfrdv8Am9TVNfb/qEWjPMVxKFIyS40UT2exR8XlQhGQLIuxtqoYGoi/gdmEq8i+eGdX2AWs
	2Fxf5rC5vQJba27i1XYkYa+8SgHCEyGoiL7R7aPI6hi+vw3y3oZ1dmc1Gt6U+2lU2O+tEt3nTW0
	dnHVh+K3gQT3wawGXFDTJPBAImeIj0Swb9nXExJR/yGdxmXnXrP46depfdBq3Og+tfv1jRh69Ej
	SOV/gWksATOW5CzkhCKSTZOuLjpcbp+uqUn8wiLhyk+AhuJ/ZyXWK6524zAkZlw0fQg3LRBkKFW
	6m63CCY6oGO9fhbtUbjuesMIS
X-Received: by 2002:a05:600c:a40f:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49cedfed584mr89926565e9.10.1788427475076;
        Thu, 03 Sep 2026 02:24:35 -0700 (PDT)
X-Received: by 2002:a05:600c:a40f:b0:49c:edfe:d525 with SMTP id 5b1f17b1804b1-49cedfed584mr89926015e9.10.1788427474733;
        Thu, 03 Sep 2026 02:24:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d1fa6sm60749425e9.1.2026.09.03.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:24:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8B33997C7F0; Thu, 03 Sep 2026 11:24:33 +0200 (CEST)
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
Subject: [PATCH bpf-next 3/4] selftests/bpf: Adopt bpf_program__add_flags() helper
Date: Thu,  3 Sep 2026 11:24:10 +0200
Message-ID: <20260903092416.223294-3-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903092416.223294-1-toke@redhat.com>
References: <20260903092416.223294-1-toke@redhat.com>
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

