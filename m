Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3E30D3E5
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934197; cv=none; b=qgLAoWeZ3I0hcwDqN9AQ41B5u9g5XmQjbsDTpADlXOMbyGY7dX5XWsi8nLR9cmS/iYktTYlhm7yEeFurBJvEpXenmFmGVYWz+CBglyZxIxhQfxgPlqWKn6rP6Z0IZm8J0ctIqAfR8riUTinhKiI8wO0BmuMrhGGfiMyo0KApl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934197; c=relaxed/simple;
	bh=KNZRFOZlKS3k/6j+Jn6MrH6VV305HMZu9ozPlFqIxlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YKNFTlk8GFm3Pu/r+FFfS3boHBRg7JeU3F7DFtSS/n6sInGOdmEC4MqnBavCuEFzd9w5FIsJ3zaE28oPEaXmP1H3Nn+d+MG+cH3lUpqSJolPDM+s+Zwu9+o1X4UTwh4QutYij5yjGwooJvKAEnPdYNk4rK72dd9vwlzSO7lFyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s61Iy2br; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s61Iy2br"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd1631d291so29011615ad.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934196; x=1790538996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+TZlQpugj+c9MJLWRaRFzFuVXJdi5re21PKY0fPg3A=;
        b=s61Iy2brCjZgpruTNmy+hW4Ap+b2tAvm7LD9rE7s8u+wSRiIRv9dx/Wa7H4y3aF6o1
         uh53JdZ+uHIaIIq08MtDAWSuj+ZOgT4jXFmn+dZspE75pQLNqVeGxlDmdbz3AgqDnK38
         3syS86zamFAqCjTegsHLeyw/Z/aZw4TZz4e9bCF17H4ea4urg57hoJdE57JYKPz+mpew
         tYBQIpwEu/FDZCXE6E//PqnJ8xrOa+4QHuULiXsFmc5cx3ix6hZhzm2Hr+vCojKV9pGW
         ebjK9c34BQukoetq+SmKTGgwOIzRY+2uSrhZGCyaqtao80drHj/n3kyFpuzaxOkj/k+g
         Ik+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934196; x=1790538996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+TZlQpugj+c9MJLWRaRFzFuVXJdi5re21PKY0fPg3A=;
        b=O30Ok5mKoIqePJgOIHlgJ2VoYuZEzvLzMhHBiRvKHrlx3RRn7czVk3B4xfyRIk3+dF
         bye6u8FDbvdkfS9PcvV+J48TgDRaa9QTwr6ZcUFEG0j3+SwIhNNvluQCOWj3YJYcuacs
         3mYaO6nrw++zjo6j5gKUrOwTy5GTQpbyf8GJhUIiy0jxjCs3suLDpz1lXUuNB/oquWJN
         CbjfEUMGR4Mx8qzgJHA/LiTwLgJKeTqlNeHM5VR5vMrFvIimA2mO8ovRqr9r6lkjwXr/
         aTiMoTlzlpKo+oIyeKIi2WP5kng6sThyUFyIsVaRqGmauNyNFksGS4Mskag0R6G6xNzk
         0cMA==
X-Forwarded-Encrypted: i=1; AKwUvBwnC5PNrfYdUVqqjSk230QZS5nojQ7+ubR8k/FWm6zkqzDdUQBSii7v41seWBt5UNig2ipeRl8=@vger.kernel.org
X-Gm-Message-State: AFuF++lNqkAJO/rNyqb6Jja6EWYhS8wjuskLiMZPaSMLvSR3O/4AiWVL
	zXE0FhrYHb6vcTLvrxzvkwKhWshXD7V3kgowKQ5R6S9wYFIF/dmxVZjxF4/Vfn5z2ZBRK3IxGHx
	m1jH0hw==
X-Received: from plat4.prod.google.com ([2002:a17:902:e1c4:b0:2dd:bf24:7d3a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e751:b0:2c8:2808:3ec9
 with SMTP id d9443c01a7336-2ddb1ae69b7mr134287945ad.12.1789934195949; Sun, 20
 Sep 2026 12:56:35 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:10 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-2-kuniyu@google.com>
Subject: [PATCH bpf-next 1/7] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1
 for bad_cb_test_rv.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once bpf_sock_ops_cb_flags_set() supports a new flag,
tcpbpf_user.c fails due to the hard-coded max value, 0x80.

Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c | 3 ++-
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 7e8fe1bad03f..e4849d2a2956 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
 	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
 	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
-	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
+	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
+		  "bad_cb_test_rv");
 	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
 	ASSERT_EQ(result->num_listen, 1, "num_listen");
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 6935f32eeb8f..e30cb1fab079 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		/* Test failure to set largest cb flag (assumes not defined) */
-		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
+		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
+								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);
 		/* Set callback */
 		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
 						 BPF_SOCK_OPS_STATE_CB_FLAG);
-- 
2.55.0.1082.g2b9226bbc0-goog

