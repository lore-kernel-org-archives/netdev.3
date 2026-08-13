Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F4468C1B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620053; cv=none; b=WF34Y+cmYFNbZpsgsQJe+M3xTa33ItKOER0n621Q44E0cXn9qbpsOb1Z5tKVUs8Egx+4f0kjiQGLwsYlknQ5rv/HR/aceGC5zzb+fGQqzNn5LjjmOvdmDRSFHQGq27LtOtOq339xi4lW9ZnIrcigeGz7dUf54Q58i60csP3UvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620053; c=relaxed/simple;
	bh=P5YIBD+IEF6HJRaAGNy7VzeGfJT29meHNSysVeIQ1pQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=puhhNC4ovAAf86Xuu3AeC02ajpsPVsvZP347kXCSXGAtmKWkwo5+yHSK+rO4YKOV8bH0LguPBL4BXQ0twNptrnBCUyLAEzdEwndpBVUMMa0PKlm0OQVIB6jZZh/D/RNjHJGMLStsVkKmwM/ew1vekhSVQ4LJES2RXA3k5kZqGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afQ3Lhds; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afQ3Lhds"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso721792a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786620049; x=1787224849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N7j/+SMKaLuu1HBtE5dsP3tHnoNTq6cGaHA0oSdZ5Ek=;
        b=afQ3Lhdsyb9f7UkdQzrMv8gCdxmE90rI0IwwDCEIqG78Oqi0IrmQk0V+LAM5vgs/wY
         sgcoKlaOb/EwIM2Hb97/R/0utu6VZG+uVxNNug0hmefvaUMQJAlLwm/ExLWtiYoS8yY8
         D9bKu4R3dYYlam23aOAPPxyuP+U0ByAYHuenGqs8g98hWxfLBXYNbNhHWBpVMjnKF+EG
         jiZcGAkhrWodvpIYiW9CQsDa7/kf3GdVlPEtO3nPJJIrbr7lKFqeELosVQKgCxtxMsBj
         qV2Dh2TnAnTS4XB3V7RlTXheqOzwtHEQTo4mqNtT8XeXtEzUz44SNX+cgPBb7YCxB1MN
         7Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620049; x=1787224849;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7j/+SMKaLuu1HBtE5dsP3tHnoNTq6cGaHA0oSdZ5Ek=;
        b=dJ7NMaxFdJLHPWxOYpMb3+RC+zI2MpLR2795Rl0nqDGwDTYf4siYlqxGZUxmBKjX11
         C3xRb3LyOW/LBFtQxTsbK+q00o3OfJenwn47fddTcnpT0CazkG3s+mjN3v3CIg47nWq6
         UYA1Kuj5o3ojMGEuXuShB1U6rLgALoee0cttam8okGk/71al37eLR/atSXDtDA2gXwRv
         3h1xhhDmhN3nIDPFDhusp2FePef4t5cLT+LeYxrmE52ZLwwRaXnZVJ/UVOIK1JyA6hRk
         QTk5r2I3K0pYchENLerNW5V79BY2blrbJCeaB2rC/q8kOWPT52dmVWthcZu4vKNBY8sO
         aSNw==
X-Gm-Message-State: AOJu0Yxzuz9Y1BCMa7i5FcGBr+Zqw6vk9f+DUxLS5zGtvUA0USQIXUMG
	TsMuuLKQnqC9mpqYIZRQ3iS5Kcsn9Je/IM1EUujimZMWCmNdi2PEKore3Zg66sSB1Hhj6wI56Q=
	=
X-Received: from dlbcm36.prod.google.com ([2002:a05:7022:68a4:b0:13c:fa0e:4693])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224d:b0:37d:f983:7b5
 with SMTP id 98e67ed59e1d1-3931e06a33bmr6076285a91.9.1786620048817; Thu, 13
 Aug 2026 04:20:48 -0700 (PDT)
Date: Thu, 13 Aug 2026 04:20:39 -0700
In-Reply-To: <20260813112039.247862-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813112039.247862-1-maze@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813112039.247862-2-maze@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_sockopt
 is_compat field
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sync tools/include/uapi/linux/bpf.h with the addition of the 'is_compat'
field in 'struct bpf_sockopt' and add test cases to 'prog_tests/sockopt.c'
to verify context access permissions:

 - Test reading 'ctx->is_compat' in 'cgroup/{g,s}etsockopt'
   (expecting 0 in native execution).
 - Check verifier rejects writes to 'ctx->is_compat'
   in 'cgroup/{g,s}etsockopt'.

Tested via:
  tools/testing/selftests/bpf/vmtest.sh -- ./test_progs -t sockopt

Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/sockopt.c        | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index ffd96e8b920b..15f712b5b164 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7616,6 +7616,7 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
+	__s32	is_compat;
 };
=20
 struct bpf_pidns_info {
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testi=
ng/selftests/bpf/prog_tests/sockopt.c
index eaac83a7f388..c7dd22d0e3f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -215,6 +215,49 @@ static struct sockopt_test {
 		.get_optname =3D IP_TOS,
 		.get_optlen =3D 1,
 	},
+	{
+		.descr =3D "getsockopt: read ctx->is_compat",
+		.insns =3D {
+			/* r6 =3D ctx->is_compat */
+			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, is_compat)),
+
+			/* if (ctx->is_compat =3D=3D 0) { */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 4),
+			/* ctx->retval =3D 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, retval)),
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+			/* } else { */
+			/* return 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			/* } */
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
+
+		.get_level =3D SOL_IP,
+		.get_optname =3D IP_TOS,
+		.get_optlen =3D 1,
+	},
+	{
+		.descr =3D "getsockopt: deny writing to ctx->is_compat",
+		.insns =3D {
+			/* ctx->is_compat =3D 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, is_compat)),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
+
+		.error =3D DENY_LOAD,
+	},
 	{
 		.descr =3D "getsockopt: deny writing to ctx->optname",
 		.insns =3D {
@@ -609,6 +652,49 @@ static struct sockopt_test {
 		.get_optval =3D { 1 << 3 },
 		.get_optlen =3D 1,
 	},
+	{
+		.descr =3D "setsockopt: read ctx->is_compat",
+		.insns =3D {
+			/* r6 =3D ctx->is_compat */
+			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
+				    offsetof(struct bpf_sockopt, is_compat)),
+
+			/* if (ctx->is_compat =3D=3D 0) { */
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_6, 0, 4),
+			/* ctx->optlen =3D -1 */
+			BPF_MOV64_IMM(BPF_REG_0, -1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, optlen)),
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_JMP_A(1),
+			/* } else { */
+			/* return 0 */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			/* } */
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_SETSOCKOPT,
+
+		.set_optname =3D 123,
+		.set_optlen =3D 1,
+		.io_uring_support =3D true,
+	},
+	{
+		.descr =3D "setsockopt: deny writing to ctx->is_compat",
+		.insns =3D {
+			/* ctx->is_compat =3D 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
+				    offsetof(struct bpf_sockopt, is_compat)),
+			BPF_EXIT_INSN(),
+		},
+		.attach_type =3D BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type =3D BPF_CGROUP_SETSOCKOPT,
+
+		.error =3D DENY_LOAD,
+	},
 	{
 		.descr =3D "setsockopt: read ctx->optlen",
 		.insns =3D {
--=20
2.55.0.691.gc56d675ccc-goog

