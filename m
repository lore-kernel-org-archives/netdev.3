Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6EA38F258
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252436; cv=none; b=Eqxs4iZddVgeNCmCkPhmBJJQJVzKRWPmokdvQTL41yGzqB8OcRICqjYPpjPNT3WbmpwweNfAXkQy5X8+a7MMV6awhe46qe4lC0ki0pHsoZ8BZKZcZhNFMuDp2+dKm+9FB5qLU8ph7wxP9FoB0ASIavKAm+J1h3RIZlcY0zg7ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252436; c=relaxed/simple;
	bh=Ug1KFsfJsMzBeekPEc+ZW4yfLJKZ5SoN4CdNkl9+Dw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFWTPYYAP3gCF8DoUgDWdVn/n0vnyDXhpNQ6nPMiBeHs0WQNxjuUKbg099UJG+/IMrP0qYFO45M9/B+1bhQzlXV0wJOkj+X5V/asBjtQviUxetm1xmxKf/l3/uZENrn18ip3xpDpuXgVNs+eD2Nh05BhFSqd40hEsXVklJ+HGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afXXaEQT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ngOaiGAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afXXaEQT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ngOaiGAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788252433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
	b=afXXaEQTP1uATKGtB0eOBABIm3rqLvypJOfcL/CgYIbeeQwVwo8Zs3Cq5pFOdrorqH7i/l
	KkaYO3oDaoYq/Gw1gKfRjC3p+P9l8585LT7NyIbiN29QgtcyDuFEu5xaJxrvXEBY8Lbb9x
	Nc7d+JLj0U1LxTpl84mSvQZ0AnDuRHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ksU2o_x0MICE5o-4tFQWHg-1; Tue, 01 Sept 2026 04:47:11 -0400
X-MC-Unique: ksU2o_x0MICE5o-4tFQWHg-1
X-Mimecast-MFC-AGG-ID: ksU2o_x0MICE5o-4tFQWHg_1788252431
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4957287363bso29929945e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788252431; x=1788857231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
        b=ngOaiGADhx4yMOUZ2ODAJGJjhIOxnt9sTYpwGS0030I6DBKJlm/zn5Jj58fJsu27Rz
         3cgpuFE/ixq6/NjAOdPWUjf/rlXDS0mh8nyXflXUnTJ+SBw/AJnJEI5rqxp5ydGkGg6d
         j8G3T/gfdD2NyyI4Vvvy5iCrxt9edDDmOvkI0tyo08dSGc4Sq6XzSFOFeLdO3DIRg0NG
         CMOnUzH45oBZdfbPPznn4/+qfk0PNa2YSzpgGEErPe5E6OFAROQ0+pFHlMDq3htTIX9Q
         kq07WhPO5/MxYJYSfJY0j3q2aFgytaRHMaeD+8QZKiIioAm/5G43hSYSAhfg7IEq+B0x
         quhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252431; x=1788857231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kwqy7Cw9XpjnQe/3kYaVkAu+DODeFH5YBSgrhz7vkt4=;
        b=DwQ14hKlM1I5VjJD3Q8DlJ+Bk995NQSwNM5qqBFVtkQZe4lDBSY1MJPgODvZU7+oxc
         /cTRfTf1vtxNdRkmqSTDgDR/abaVK3IN1yZoGeO9FJ+5n5u1S5GhI52RbH1ZDCbGUcAE
         duCpY2bpOTudF5yv8Q5CPrjQzAzsB3DHqinXcXSFRHDSjCPIZh+JYW4vxuG6ydiohuKD
         KfMgenCHrpI4DrJ54bgrVPvLzc61QOA1ATiLa25Vg8xtZHO9ADxZKeIIkSXvmpFYOfJF
         LxlR37Ti3AcSBu1sQIXwsbYbNpNJOVAb+JvGfQLWRDqbWlCN3wKcuc7BQuPlIqGBXxF8
         HKvA==
X-Forwarded-Encrypted: i=1; AHgh+Rqlb0kvvYcZx+mYO45u/zl9plDTNf9ku/JnU2sNcf0I+59KQJ08MVrUEvh8fyebZUQhLSKoIvs=@vger.kernel.org
X-Gm-Message-State: AFuF++mrnL4kMWWPMHtfqOx6n8/ecgW6YOrK2Uj7yJytG3UHMkz1EBQA
	zhLKnwI5RkVQBgxdhMsYivBnYzwZBA06YR9h1aapyfp56mYEqQgZJ7ouNMD/i556TOIqDLoewQ/
	ZaVICnqfA9DEST7t+ZZhBFtTII/fFqYqNHy1aufvQK9L7iizMkiWDtdkIJQ==
X-Gm-Gg: AR+sD13ZDXPtkfkpXPIbZL2/CURN25RFcHtVKfeR2bRHzk4m0O4H4GFlKOvuNKb5s6m
	ZlxIY5xpYc/Hl/xNSsLzLnCmFVTDIhnmww6oODuE2vcQzZPTx87ZhPNHt0UpxNIwIX38Tq2h3wy
	lWiN+fW5KbPcfRNG21p7qqBJ7yu4Bdpo/EaenJxENL6KcY9LR1NdVLAvkUAQsB3p7bq+g3CeQCr
	KUpjO0ZtimotVRBv7XD2TDCEM0GcaPbc4Fd9C3EktGWWZfxV4mCHr61yT7vfk0ZZOWXTQAf4rci
	mKQuxoyMCQGLk3K0pvMFkdxvq1gAW4YLZHIgl/arxfb1Nw4wOss90OGVgruuEMoNSo0FVV7EIRy
	cxELaDYTIsui2SB+JKlc7YfA0O7s=
X-Received: by 2002:a05:600c:a00b:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cdc2c214emr102805145e9.2.1788252430686;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
X-Received: by 2002:a05:600c:a00b:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49cdc2c214emr102804265e9.2.1788252430227;
        Tue, 01 Sep 2026 01:47:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1e3a9sm51551035e9.15.2026.09.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:47:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9950597C524; Tue, 01 Sep 2026 10:47:07 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 01 Sep 2026 10:46:56 +0200
Subject: [PATCH bpf-next v3 3/4] libbpf: Move section-defined program flags
 to prog_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260901-libbpf-frags-flags-v3-3-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.15.2

The libbpf section definition modifiers for XDP frags support and
sleepable programs stores the flags bits only in the private section
definition cookie from object open to load time. This has the
unfortunate consequence that API consumers cannot see (or manipulate)
the flag between object open and program load.

In particular, libxdp has special handling of frags-enabled programs to
make them compatible with the dispatcher. This doesn't work on XDP
programs that enable frags through the 'xdp.frags' section definition
because the flag is not visible through bpf_program__flags()[0].

Fix this by changing how libbpf loads the program flags from section
definitions: instead of using the private section definition cookie, add
a setup function to the default section definitions that stores the
flags for sleepable and XDP frags programs in the prog_flags field of
struct bpf_program.

Exposing the flags this way means that any use of
bpf_program__set_flags() will override the flags unless the caller takes
care of updating flags in a non-destructive way. This is unavoidable
with the set-only API, and any user setting flags unconditionally is
already broken in the sense that they will also override any other
current and future flags.

In addition, prog_flags survives program type changes through
bpf_program__set_type(). It is the responsibility of the caller to
ensure the flags are cleared if they are incompatible with the new
program type.

[0] https://github.com/xdp-project/xdp-tools/issues/587

Fixes: 082c4bfba4f7 ("libbpf: Add SEC name for xdp frags programs")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..27779b4cddd0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7879,6 +7879,19 @@ static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
 	return 0;
 }
 
+static int libbpf_setup_prog_flags(struct bpf_program *prog, long cookie)
+{
+	enum sec_def_flags def = cookie;
+
+	if (def & SEC_SLEEPABLE)
+		prog->prog_flags |= BPF_F_SLEEPABLE;
+
+	if (def & SEC_XDP_FRAGS)
+		prog->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+
+	return 0;
+}
+
 /* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
 static int libbpf_prepare_prog_load(struct bpf_program *prog,
 				    struct bpf_prog_load_opts *opts, long cookie)
@@ -7889,12 +7902,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
 		opts->expected_attach_type = 0;
 
-	if (def & SEC_SLEEPABLE)
-		opts->prog_flags |= BPF_F_SLEEPABLE;
-
-	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
-		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
-
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
 		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
@@ -10099,6 +10106,7 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.expected_attach_type = atype,					    \
 	.cookie = (long)(flags),					    \
+	.prog_setup_fn = libbpf_setup_prog_flags,			    \
 	.prog_prepare_load_fn = libbpf_prepare_prog_load,		    \
 	__VA_ARGS__							    \
 }

-- 
2.55.0

