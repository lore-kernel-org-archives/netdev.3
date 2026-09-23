Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0F42589D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199447; cv=none; b=C7d7sK5r9cZkWdUxO2MRozgF9ik+XHRu/gpm2QS+Rvwz4/h9heswF2cjKpLBvdVX5/ZERC+VmCPpOEXHEg6TJ+K2NG67cEIWlcRC5TRhPaG3Njjhfg2RruJyjEIVn79uZ5J9xScViCMiTuqauHdNkclQv0bA8Zpt/tqK/bVLdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199447; c=relaxed/simple;
	bh=bs9GzRJZuVWAJwdO169nNTQ+eyFwlSv4C20n+ekBwyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/2PbTjP1BsMTHTvaFdsFq4nQf8RZeAP+mZM+FxUvQULWusiMUOE8ZqRl6SkMHpJGGzKPHW68OKLuOU1qDqRF++3YZtwczq+SrXHxNwSwxcj0Uxde1NkAjOKDzIfWG2NztBxRtZxCpMI3WNDO+n/Jt8LrdBzTvOkObSKpEB8rzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vH1XELuV; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vH1XELuV"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86917d18880so1095959b3a.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199444; x=1790804244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGXfmEWkq3/HHuasNWZ53w5Ago5oUb+2kjKFTNmi4jc=;
        b=vH1XELuVEbn5apgZ4MKW19BlX/Rru2sJN5R82KsWWBF/H0n3F82CtSPLbdgNHA1WK2
         DC9WPK9/w4G9d6ztgkeRRXNIDgdENuGeWcPSG9rs53cDGzD1GNx9RmG7cVgH87iFSh/k
         NzbGhrJLOGkZJGXPJLx5eRUL0Lt7Vm579s+BSHHaDMnis8z0pEHoqnqjfDFGN+0+8GYl
         E843tBJ4OS2QBWdqMbk8Bny2hrUFalq5bWA4pVk7Aa/fQtTZYEHgVZTAKaAfVE7J5a63
         IHJ1dVTWCJ99m7zGdTK/b0Zy9gw/FujqGkyPZUEvTHMualf7SWZ4kCXXQGgshpRdN1AQ
         r5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199444; x=1790804244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGXfmEWkq3/HHuasNWZ53w5Ago5oUb+2kjKFTNmi4jc=;
        b=GrhHHDp2KAJUx91dZAhlDat3dw/sW/eDtMLTfNrixnXD/EAWxR6j2+SZf7WntU8/qf
         GRWcUoM0vkWX4l/8ksTKEtcYxnDYQvAsFswqbftQ/HxuNFEO89xGvsGW4j0zsc7fgm5a
         UKVmjAxnJmxoMbqpwo47a95+UCMmkEEQ6rK6S0F03ycxxvlmqghafdx39aHI6lehestJ
         HUJDgfKOBS+quOMyFvsOG7I0RTNl8jp9Y/ogi6zS2VqhGIdN4EMZjnog/a4EhqwwLRzZ
         oBDdhXs5WZ5kVze5Bll78dt+pm0S0m5cls+L2qYhji1pAYpCY6xsbHd/r35lrQQMrMzy
         byGg==
X-Forwarded-Encrypted: i=1; AKwUvBwNY076PwRD3a+rV4qHgKBhKdkONYbMn8op11faE8QHC5NNFPvFVXh4yNSSSFEo09vHDBKY0d0=@vger.kernel.org
X-Gm-Message-State: AFuF++k1zRHqaTtq7SUY87zubH/rg0T6rCNHrGJGnjJ4hsBYfVVfLWq2
	XAshVH0vE/CTgAgsNvOq3wVVpE/En3tPxMHtWAxJENwN5+mmYvWFKAv8XFWD17xezJHksMtOtuX
	R2CjChw==
X-Received: from pfbna15.prod.google.com ([2002:a05:6a00:3e0f:b0:87d:6399:223f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad02:b0:87d:e633:72fd
 with SMTP id d2e1a72fcca58-87e9f824499mr329534b3a.51.1790199443883; Wed, 23
 Sep 2026 14:37:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:32 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 2/8] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
 + 1 for bad_cb_test_rv.
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
2.56.0.rc1.315.gc6ed9934b7-goog

