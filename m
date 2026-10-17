Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9697335067
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200772; cv=none; b=hFaautM/KcxFGDS05Q+gTiuqDfI91emTZk13c4sga4GbPgO4vNMq4IRFAfa+ldZkzY+4tO+8FiYz6JP4sx8ua4dQRRApgHVkMOGDnJszHfKyt2xDzsEv/5XVSmfvj+EmPbJvnRw0ATLvKkD6pUb3gz/ND9XXsBvCOB1xZmGF+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200772; c=relaxed/simple;
	bh=On30PjEO6J1ruL3q/hkvb5tuhhy8lM0xd8Kj4HfM0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB25JMT9GpLhLKoOXjs+2H/mlMxNkgkfMVQTOlqJs2+3sXSi58z7gI00Zy5MTLFaeiOlGllkvzGEfToXE/k9oeSNvR8MNGEHvr7L801XqCa9Cz3cUcjBzPGVxw/Hw2z7VXVLdiq0gXusuOE2XXyv1UrBpiXTb5SpcwxAp9Oef5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqIl4yrL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqIl4yrL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso342757a91.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200769; x=1792805569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=JqIl4yrLmFLyG05DFf/Ntw6JquMcgZqDS1X6eVJhg/VNpwXE2OJ33rU1LVkrvNF93e
         TxJtNp4sV2hufv5zPLWf6PKG3elRooPygGUaNmYbh+Bz8ogc9eKv8Q37j0AqEeiTy7gN
         HUOtT0uLtLrvio88iNzAZJclFBKOd49/3hy2ZxP4BCd5ABhK4wqVf6ZGSiiPQpWwtZ+k
         PAlPnwNKQ1ryO93xW3y3qgU/RQNP25Aa66WQ7bWseyA14O8KaotJOmHIVT57Xl8I6/Rm
         9uVvOSkujTS9LadORk3zn/UZfjLZ3c/70SEbuUaPXiAb9/g4Wx+/uw8pD/CROJxq9h1M
         UELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200769; x=1792805569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=t9Fxw9dQBU2wS0Lnb8FjvoLzt5r/irTf9JhCe3Ggo3VdMSe3GvQoF2atcwZ6o/sDFj
         WUwM8/RQJPV9IiT3awBlp2B1xSFjsyQih6lNtiisKDnk2TChfI1oR8Ptv4Zv0oV99fcS
         VLBTOtR6lAfFuduA1wYVyH2AWUg/MTrY9FmGd3g9Ico/FRT8w5xqPswY1gbPRY7d1uyf
         k7+VZgJnYUbq3MTr5MAeqQV87Bi57KxMXzEq8kN6OMqXS3+7QLQXwmkO4ZUsova9ESSD
         tS/LI4R2q07OAQ90afPg+AQJpaNM970aDlI4cjfb6naRAKlIbYrCe8E3UVDALyz5XV2n
         7GyQ==
X-Forwarded-Encrypted: i=1; AKwUvByKtbDuNHpXCnHFgm0WXWK6rVUvIjk6ysDqHc9Dyi9vX12uEw0OCLFgPE7zJIzrnH5Fj2DHh+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbI4liapKAidr+qsCwzhn8kkLKvKKzg7h5Iqxpe7dTO0wKKkSn
	evHocVG4GXoUg0eYgzQR5d0JlQdJ5rA3muMiuWbDx0FFzfikkScoQIMg
X-Gm-Gg: AYBFou0kIJnKP4lXZ5So2J0nsdqIy/m0dfO7hwu/rSVGpvHT9VFdZ9FT3wh/Y8Nygi7
	p1s6uhxtiV75UJDr2bsmZBLJ8iGyzec9SLVsDUSu5p0fJqe0efy3h9Gc/up4PoeOObcEcPWumdn
	RprL086WgT2IBGdbNp3q9UiPLzco50aaq0UtY9NPZP17uLL+IZyvRvCjF/NeZlrPEky1buG3X/N
	qLFtYiq4cHqx/DuPf41k9U4SMqg7IDR7BBA93ysmLPgaxWMUu8t9+4cSD6J6lMNKJILo96kwGNb
	D9T5ApSiHxyPQnaZZVoyGsuyAsP2J8Mms0MM5lQ/9YiyhsDZdOWS6GZeJIc0UQaVgF9Nl/qmEdW
	6rZgdzl//ufkReGHaI4WX+5jg+XyAHu6UIjAGZ9KQ8wbJDbFecS0Yr8zFr4dLzPRH5rjjLvSd+t
	ewZ99IJ1FFCArLVjCsBpVAwXY2UGkW+4+Spihx9hbmVF1lSQO/2cGRJup6JZZ0x9IztZZREOqe5
	cz981HHHBvOWfG3nEofmGoG3a6rSTjHnjA2q4NsYkPsNXyOeC81RXolLQX3gtv2BJ6dXv1biYNH
	LEvxvhQ4BR1htzVzc0MNjRea7UJngh1T7YfmU7+nPo3b
X-Received: by 2002:a17:90b:3d87:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3acef154517mr1174222a91.34.1792200769146;
        Fri, 16 Oct 2026 18:32:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm3578215a91.2.2026.10.16.18.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:32:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 31/38] bpf: Use the socket of a sk_lookup test run under RCU
Date: Sat, 17 Oct 2026 01:24:44 +0000
Message-ID: <20261017012451.364800-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_sk_lookup_assign() accepts only sockets which are freed by RCU, and
takes no reference. bpf_prog_test_run_sk_lookup() looks at sk_reuseport of
the selected socket and generates its cookie, which is a write, behind
bpf_test_timer_leave(), that is outside of the RCU read side critical
section in which the program ran. If the socket is closed in the meantime
it may be gone.

Do both before the section ends.

Fixes: 7c32e8f8bc33 ("bpf: Add PROG_TEST_RUN support for sk_lookup programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/bpf/test_run.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d73cd247f8cd..3043a7393c29 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1656,20 +1656,19 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		ctx.selected_sk = NULL;
 		retval = BPF_PROG_SK_LOOKUP_RUN_ARRAY(progs, ctx, bpf_prog_run);
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
-	bpf_test_timer_leave(&t);
-
-	if (ret < 0)
-		goto out;
 
+	/* Nothing but RCU keeps the selected socket */
 	user_ctx->cookie = 0;
-	if (ctx.selected_sk) {
-		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport) {
+	if (!ret && ctx.selected_sk) {
+		if (ctx.selected_sk->sk_reuseport && !ctx.no_reuseport)
 			ret = -EOPNOTSUPP;
-			goto out;
-		}
-
-		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
+		else
+			user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
 	}
+	bpf_test_timer_leave(&t);
+
+	if (ret < 0)
+		goto out;
 
 	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, duration);
 	if (!ret)
-- 
2.55.0

