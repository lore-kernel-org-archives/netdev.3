Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57D3AD538
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255180; cv=none; b=BcPo4K4qw6ZMKwdm6Dd0VvOtiNJ5pN5UYwofVToxX20tnG49JR1e/+1gzXdAzkkh27wJQ1J0WC95tCALywyGDg4RUWLXI3TEdvFugaj1FrlrzDrDPGPGuP/TZOvtk9+LESUNMhykybzsolG6dTZ7G0bdMn1Y6d4/Gqr4knvEuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255180; c=relaxed/simple;
	bh=jqT5Ab18KbkMPLG5nuVmKYwi9/htcEz1suyx38WJeRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im4+c25XNKTKencWRQpJJDnI+9/pRlUnAYaUVi0PQZTb40x7/0gki3QaaqYGB9quixE3TqOoURzJBIIRlSmttztiHpz/ZwcMFBwyMy7KwDFX3RemRtMSpJJLkwU3UKRNLyQR4da0L/pySayWa0O1YOtb2L+8rT5M4S3z11ZMdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHp+M4b8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHp+M4b8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-88b8f0a1bcdso634360b3a.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255178; x=1792859978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=KHp+M4b8kEF4X4L9pHkqbUBN3Cx44JEyv0oAmlCh2OOSMPhXu66oIVkXkXyt77RBcE
         eUu9xOWnhD9OdIG/gEWOKSe6hPTSAHsLExd+jXkvX/FEHyiAqv+29U2jHOaHBXTfR9XP
         p6KrsxJEesYbP+Cm10LDm8x8ILQGgRu4fhoKDKaA/crC+7TO6vTeiA0M7+hnzCUWSbSP
         j3iG/LJz0IEFHC/uCbkaALTwo9oJYdK6jFQNHAkRp5yiB0cqxNtSUmrCy1D/89ar4B0r
         5qs5/yv0SVOR3h1eLt/lbqhkHUwXqKfzHcBa0Hqkrm4inAWE/20MHqMPoLGT10GO0gEC
         Q/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255178; x=1792859978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=E8FTj2siKMWEI987fuxwrakiT9lobIurMN7KV3wTfTMk/evnOdjUKYZXsxI7X/QN+s
         rXCaMyfQhP90QXyh0nCNtV5AtfySf0F909jiNEhf+RAtO8kdvF4iJc2is+Q73iJu1mIS
         wB5T6NW4UaWoYdCuG0MYsOa5Zt5Q4/I8GicAVU6vYdw3LNypmhN4msoUBdsDaUsAIdiD
         c1a61XTlg6D91SzqxgCxz9E80Y8UOB7ZefYpP3PQXfBn5JQbpVS2xvW1h8FaRteCKurm
         bNN8Kl6B/ZsKsTw4tWyYVyx5t8KKProz83WKZaqffeQwDFy128XfwSb1Jk8ITaf10q7h
         w0+g==
X-Forwarded-Encrypted: i=1; AKwUvBw18ljOUkH4fFQ8IGO5w//8RxJee5jXdanVXxbXBL95JzwARyfqtaQe2Nrv946IbGd5O0ECYMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqneB/u9mPyu5WzcXbjgvpF3oxTy7Td+VYNrTtQLo2t7HbuZxQ
	boKh79pzJOejxSFMIor2MERbD4dNCRf89DffOX5+dOy5ORhGoPdhgQs5YDRkXQ==
X-Gm-Gg: AYBFou0FhPI2s6iS7+Tpmk0y8VcsOlxFmLHJjJR6q9+tjhEXcphV0U3/RerH2hV/2Vt
	bESQfoYAXPDgYG7sOvERjKWXJQh6hlNupKe8u+rgirqf/+xVJdXHSceVUCeRs+yTZ4gM48/R4lF
	SnAQLREvxKfHVFaO/a3fRcsCREtKxEHud1WrsoUIn53wFsZ5mQWmS31zgBMCFnNLp6iEDp5XKP9
	3RCCTD+Lvpxfk57ZpnAOeqtEQVlSPh5pS1G59l06abjcoR3eak6kWK2VSCK3JdSOiWf4aOnB5q7
	FLI/v9GVnsIX8kIxgNwy1tOVtJnJv/h7+q5aCxgIJR/Lt3DFD+LbVX1lFP1aZyrxfnmM6hnL+pi
	IJdS45xt0ZGSZMggiFYShWCGNdJElGAsFg01rn72vl9f+20Lfm7Iq04sur+xjG0wouW8lA9Rd6x
	NntXN3Xz6EIdgL96r1zD3Y2ePmelzuQzlJjwtRYqxyOo4IuUxeUHQPL8kbFTezYkVy5VWgixEjL
	/5hruTbMkmG68I4Ql+uP3pjXTZBMkIEu7ienCJBwb/MEl1i5Yutb1w2N05J4LCVJlktjerpgxn8
	qJZo3F/j0POJzB/zlffokGpm/7v8huVf19Uwm5VCDTPi
X-Received: by 2002:a05:6a00:1891:b0:89f:5ac6:32f1 with SMTP id d2e1a72fcca58-8a04bb360fbmr2044013b3a.23.1792255178073;
        Sat, 17 Oct 2026 09:39:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735dd55sm2296489b3a.26.2026.10.17.09.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 18/43] bpf: Bound the nesting that the BTF show code follows
Date: Sat, 17 Oct 2026 16:37:20 +0000
Message-ID: <20261017163745.3341787-19-alexei.starovoitov@gmail.com>
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

btf_struct_show() and btf_array_show() recurse for every nested struct
and array.  MAX_RESOLVE_DEPTH bounds one resolve walk when BTF is loaded,
not the nesting: a member whose type is resolved already is not walked
again, so BTF that defines its types from the inside out can nest them as
deep as it has types.

Whoever may load BTF, with CAP_BPF or a BPF token, can give such a type
to the value of a map.  Reading the file of that map in bpffs then
overruns the kernel stack: with a few hundred levels the stack guard page
is hit and the kernel panics.

Stop at 32 levels.  That is MAX_RESOLVE_DEPTH, and __btf_show_indent()
has as many columns.  Nothing is shown for a member that lies deeper, and
the status becomes -E2BIG, which bpf_snprintf_btf() and
bpf_seq_printf_btf() return.  The types of an x86_64 defconfig kernel nest
14 deep.

Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64c78434fa05..a9bf4c3c0a27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1081,6 +1081,8 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
 }
 
 #define BTF_SHOW_MAX_ITER	10
+/* nested structs and arrays shown; __btf_show_indent() has as many columns */
+#define BTF_SHOW_MAX_DEPTH	32
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
 
@@ -1474,8 +1476,18 @@ static void *btf_show_start_aggr_type(struct btf_show *show,
 				      const struct btf_type *t,
 				      u32 type_id, void *data)
 {
-	void *safe_data = btf_show_start_type(show, t, type_id, data);
+	void *safe_data;
 
+	/*
+	 * Structs and arrays are shown by recursion.  BTF loading bounds the
+	 * depth of one resolve walk, not how deep resolved types may nest.
+	 */
+	if (show->state.depth >= BTF_SHOW_MAX_DEPTH) {
+		show->state.status = -E2BIG;
+		return NULL;
+	}
+
+	safe_data = btf_show_start_type(show, t, type_id, data);
 	if (!safe_data)
 		return safe_data;
 
-- 
2.55.0

