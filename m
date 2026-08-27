Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D534334DC
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824977; cv=none; b=VqTOzYdxNRyztPIJSlsJN7YxnlNuTi1bJJR5h2A0wE1Oi1gaa9yaIVhII3DnwuHgHUvnWEolRJeGzFmYWL6iQbMYPhxJLQ33xFsbiOwYVupqEfv5eNdEafC5VC6yvHN3EAnVF0F31H+CodndjzUCe4++YTfMbXHpMxsMLXWovoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824977; c=relaxed/simple;
	bh=+JsS/wv7XR6N9uh4uo2a/6K05J5MWW3eChLg/XiaPkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IErOBi6w7ur2GUQ5jU5dghFXiOvYuE/FIwDRbHMVz2Uz9YpGFhdrIP2Lw51I/KfcajrnrumIfzBMtygKKnJnFWfunXShSnlWrwCg1den3mZJDHVRLApBS8OHyV5l2kGA1MvJ/bJLJ22QOlZ5RP4bfQ9egqyH0HoiSOnBMi9vNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKJazyJe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CA2iTlBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKJazyJe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CA2iTlBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787824964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/c72MQdWufExTh7+4DDW9MBVDxBOFoBAW+G3h8roBs=;
	b=VKJazyJeCATiaVmy30gCgbTw2yrAYQ0JSvDYBmGw+ndlX6SNxeOfBHair0LecUovoAUrY7
	okT47+RVFvV9rF9znYz5CTrzP11ivWgJvoDVigyLi5+eEIiloeN5U941C8SNfbdVakqEhH
	MrQWMzb9mdPfTLG7HJPFKh6iFyzW8UQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-z0wTXxMANPiFSHGLpWgV0Q-1; Thu, 27 Aug 2026 06:02:43 -0400
X-MC-Unique: z0wTXxMANPiFSHGLpWgV0Q-1
X-Mimecast-MFC-AGG-ID: z0wTXxMANPiFSHGLpWgV0Q_1787824962
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482a5e9400eso484018f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787824962; x=1788429762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/c72MQdWufExTh7+4DDW9MBVDxBOFoBAW+G3h8roBs=;
        b=CA2iTlBtExxXX3hFj0AliRg+l0/fakevO7M6hS7zeA5nzurut4VCfbkmeHwHuHy2mw
         1J+X77bhVnhIXcqrDkKJ5/srQSAVTqiVogX/tv4gPdzEijRpEMEWml2Awvh2DExoRKLz
         SG2Pi8S0RlSkM+9pOfYd/I7aEYYJP0QI0ZqMtoCRK/bbWlQkMh8Wat3dJFLwBR2lHhIW
         42mTy1eYp5YoOWZShGPT0vEvDKeCSnpaUcoUEN0ms1ya9SR/NGI4yt1cOqE2GDXKCdY5
         JG5nkQGjyzOo89iyiMvSyWLAu8KqwGemx1vvYrG0LozSqimtDdwrNYPSnSYuS9EsGGJV
         1Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824962; x=1788429762;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H/c72MQdWufExTh7+4DDW9MBVDxBOFoBAW+G3h8roBs=;
        b=csibdVfnhxeDtwfX09ZMPERnfaQJswrJTJU37pxJzhgwRZxMy07vQ0dh3ffST3VwP2
         Jq0PD44On1F39uU+2bK1DdHuUKeHIFqLIh5r4jJbpyxjY/6tnx/P4ERqBxrpZ9iSJFVW
         jntZHUwAO4oeBCnkvE9Gf7X4dUMHARnycECIL5terLBUm4ofd2zl1NT1hbM8pwMJUcTm
         NjV9nW9gubqaVr3kfOWS3Rx9KHry4ovHlQ3jYEMVgd55oCmsDVbaPiZJRjjeIYd32k4T
         KpwYIYNbLyKauXQ63xGULmWTQLeSFseHZLDG81RFlqqPYNrYb9SsdVBZ0SDWQ/XJBACY
         3/+A==
X-Forwarded-Encrypted: i=1; AHgh+RpKKUpZJaHIn4DKwH17DZCGCTkYPuLMuMrhM9lYgsICXQN3nXDsWAb59e/JmS7Ta1mZiPDmTzg=@vger.kernel.org
X-Gm-Message-State: AFuF++l9tk38J4vQ/BU9+qw88byTK0w1tO6GqQevH7U0yQlmAtd0GrwR
	wGTtsgJ+nyJwCwasi7xYzQOQ59Oi3QMxgkPBYlNA+6Kt/nAWYZpyWV878j8McVrt4UAOOYL6KS3
	CNGJwEHRYxUVqAJPF8lJUsBtAyIuXYyP2ImmxY0UAG0Q8ogqv3CE3CTNcgQ==
X-Gm-Gg: AR+sD11GZ8tlKM2w3ssogY7RqHThQbm54TT574jVup1F/OuuDsUtqvf5G7jQxkcqXON
	orPcXnM9kIGYkLINFF5R+EbPjxpX1LGmHvSXdz3Zp5gAFCZjkNcavcnIMEa7e3jd0V6h3xrkhHd
	Jd8rckOkl4kj5squSm51O3P/1WqCQ+FxQ0vP3rOEORaZZkGAOi2zT71nhJwWvR4Y4Y1UcIRjvhr
	oYsMcP9bxsC4r62zO/6/8WaYRGx7o20SqFrl1ntdYW1VnM2KeZwosmsgL8nQeD5Lo3qgdTcIE+9
	mT3WjThSrCiXnrdKQCaL9zNm/KKgQJIYncM/n5zub2cJLJ2XoMbh7flzh0LNniKAoYMflMTHrXU
	55bats5EMPGz3omgSxEAgqsYpLCg=
X-Received: by 2002:a05:6000:27d1:b0:481:4f2a:bdb0 with SMTP id ffacd0b85a97d-482e2703aa9mr14038215f8f.18.1787824961704;
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
X-Received: by 2002:a05:6000:27d1:b0:481:4f2a:bdb0 with SMTP id ffacd0b85a97d-482e2703aa9mr14038128f8f.18.1787824961295;
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279ecaesm8160863f8f.6.2026.08.27.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:02:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8E1E7979E20; Thu, 27 Aug 2026 12:02:39 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/2] libbpf: Move XDP frags flag to prog_flags
Date: Thu, 27 Aug 2026 12:02:11 +0200
Message-ID: <20260827100214.169215-1-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The libbpf section definition for XDP frags support stores the flags bit
in the private section definition cookie from object open to load time.
This has the unfortunate consequence that API consumers cannot see (or
manipulate) the flag between object open and program load.

In particular, libxdp has special handling of frags-enabled programs to
make them compatible with the dispatcher. This doesn't work on XDP
programs that enable frags through the 'xdp.frags' section definition
because the flag is not visible through bpf_program__flags()[0].

Fix this by changing how libbpf loads the 'xdp.frags' section: instead
of using the private section definition cookie, add a setup function to
the section definition that stores the flag in the prog_flags field of
struct bpf_program.

[0] https://github.com/xdp-project/xdp-tools/issues/587

Fixes: 082c4bfba4f7 ("libbpf: Add SEC name for xdp frags programs")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..7d6f0fe518d9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -420,10 +420,8 @@ enum sec_def_flags {
 	SEC_ATTACH_BTF = 4,
 	/* BPF program type allows sleeping/blocking in kernel */
 	SEC_SLEEPABLE = 8,
-	/* BPF program support non-linear XDP buffer */
-	SEC_XDP_FRAGS = 16,
 	/* Setup proper attach type for usdt probes. */
-	SEC_USDT = 32,
+	SEC_USDT = 16,
 };
 
 struct bpf_sec_def {
@@ -7879,6 +7877,12 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
 	return 0;
 }
 
+static int setup_xdp_frags(struct bpf_program *prog, long cookie)
+{
+	prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+	return 0;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7892,9 +7896,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if (def & SEC_SLEEPABLE)
 		opts->prog_flags |= BPF_F_SLEEPABLE;
 
-	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
-		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
-
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
 		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
@@ -10182,11 +10183,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("iter+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("iter.s+",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
-	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
+	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_NONE, .prog_setup_fn = setup_xdp_frags),
 	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
-	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
+	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_NONE, .prog_setup_fn = setup_xdp_frags),
 	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
-	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
+	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_NONE, .prog_setup_fn = setup_xdp_frags),
 	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT),
 	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
 	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
-- 
2.55.0

