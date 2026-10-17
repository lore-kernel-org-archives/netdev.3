Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525C3AF65F
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255279; cv=none; b=pZTv/PmqPzYyUoO+GeXqeA4zfhbH0xcdMLHTeNWVMV/tf2M34yV5rkg1jE6g1TI+ilKIPjEpuj5cJbyl+XU/Sjmyo76j5AQKThz7sp+O/MZoJdQHogzENCxCWgJ9lfs4gSrzRt9aQFLV28Tlk93gH8jNNaXxxSSkmy02v46n5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255279; c=relaxed/simple;
	bh=On30PjEO6J1ruL3q/hkvb5tuhhy8lM0xd8Kj4HfM0CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWlwTu345dvc31M5v4ygmzZoynJJwRT6NecwK9WTINWb2h8/1uU17K9MkGTd04HbqfzbfB5SroBZOK2tClJZqnxukCeAcUzOGXNYObzJJjZPdv40+6UGPboJ6GrpujWHpek4Ourc2T6goX78KDYQvDC+rnIjqy2JxIutPSMpy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCVPtB8l; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCVPtB8l"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so558791a91.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255277; x=1792860077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=eCVPtB8lsJsbdGPf+zUzh47kmPa939Zq11a3fLA8qz3T7IOLWj0MHUGF9zD1tgNqEK
         FQl0oWPYn7wlaIec8ysQtyuvAKcuibSI2ywRSYCEBBQCe6HIVLEVKX5YW1PUt0fqlDxH
         AddiVOYkwqRmajLCMXtCGS5xQdif9uy2IfIcaOidh7sl3w+E9AWjwADNleoh/w/Czkc3
         kk/KPFDySI1Kv4II3dwSfRsFqn3Tmc+Gd6bEdPAfQj9Ljf9LMwPbD/7hhO/EWbSlLv0Q
         QLXiu+jYEbKlWL980zkgQ8aRbCx0Tr/BrVOOBBGpThefmmdfRlQvaHayph2QafrgWMW8
         24sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255277; x=1792860077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIcM5wreYA6XtufTFK2gEH3CtqCVUiXfm+uw2U6jSRk=;
        b=shliV3JW69yKtkcS+cHItUGT5KzavAt6tpnlLw36Pr5trnb6L4sbFKoulXfN63Qc90
         z325yd5VVV3g0rB/j0ohZ4K5eAli78saJTUnCVu28m1wDqi7HFR6ScjevfD38glXWCVq
         6Lj045K/gQT1V1ddRyzhtM3cHaSL50/qS6vMvHDV+g/H7L81ftIb5NofotiuoDDsdxEC
         umvXkGNkOqal1/hQxaS4/2E+yjYBl/fcmKb6vGUOo+xfqm6z4+YKIZ6UNEc5YBcUEL02
         x0s3pWvbhKNRS34cUeh1U/ocYMOv+z3/Mf0Ftl1fOyWXKUpp/q6pyuHNm7Z3ddKLsuqD
         zKBA==
X-Forwarded-Encrypted: i=1; AKwUvBwnpOcLqrdS35TknMb3jIhty51vI8gTI1o5ZV2ZxyTDG+lYpKCbC0TGHflaEU0za3DfVzjK0kA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3sAY396bGD+sN4n3T5p5JjZQJLQgfvnXzOcgAIooiP3trUfyW
	7FSlNcqRJ6uDSaAh3wEdlwiFvru3ZY3gKaDhMIdknNg99ZLazJlClp4l
X-Gm-Gg: AYBFou1qFciaxN6PfwouK5n6gwAKzFQ412bx9f+o0Ul2LVHvF6rj6DppyVmuMrhw5R/
	LtiKjgBrSQGSAhTpWHShFO0toaHeBsseVxUVcYIaGbJTVbKd3Cj1fXcF+KYtwT5mW0EnK0o9IaW
	CrBb0Sv+WTKdObZqEw34oUSRU/RFa7MjQ3wCxsULanxy1lncY7g+q2Sep9ZzX4lEU0lJIEUZqwZ
	kW6n/lqsQIhB8BzCGQUTTMdkJ0Po/5KypAQ2rGNrgIJMGHp3G3+sBvsEzsAgb0uY6EAJuHeCTVO
	RQ37DnOJMnPauT0KX5uObOFFk7rQ+VY5qXhw0dDPf2on93kwLHbbnZwmJ5bqaXkk1+Pf0VtcOqC
	9Y4gWWbuUWohKuu8MVVsTHE2JYzMGvo0aj7LOxLqrbbe3Cn+0UUhbayus5N1bRsEioziQVPkdIC
	BBw5S7HvQil+xLXfZWe0EAw9N/gLaFcsIpnrXz7lsyMY8E1kCIEVS1Gk4iC5a7scAj0DdprmpLX
	pGPv2eOZCNrh0AcNrXMVzwYzmN9q8u8PTP7NUNk7EMGfdTwvoenvv+1v6j0G1OQ/0ITNJGMtCGG
	xZ6lDuW3U/L293EKHVHxn5e4KF3JlIvNygkxkKBPKjs=
X-Received: by 2002:a17:90b:4d84:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3acef59b49emr1864932a91.38.1792255277196;
        Sat, 17 Oct 2026 09:41:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ecd32sm8979900a91.3.2026.10.17.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 34/43] bpf: Use the socket of a sk_lookup test run under RCU
Date: Sat, 17 Oct 2026 16:37:36 +0000
Message-ID: <20261017163745.3341787-35-alexei.starovoitov@gmail.com>
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

