Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09FE3B058A
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255228; cv=none; b=VCHA8v5F5bm18k/wWY+fSTKjk9FCJKwTd3xPGpC1YV915wESYNhi72u4KFw7fbVKk/Pn7W55oC1Psusa5IOdF6rujLpFP6VZ4eQ6Ll4E4Sokd0H1z7urWD3PXG+9d3YQK+QzlsAJBB5VjMxRE7XtJIdpOjvDKcf8712BgDNq6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255228; c=relaxed/simple;
	bh=1vipa/BUWLt7FxSSWIAQxQD1mC5GvojWAIA5QQzic0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaKiTfQUQt31VLA4it1SQDNLBCM2m6qO+K/qzvdfcD9/iQxCbpFS83aKIsK0FeWcCEXTmRen6km+LlPFh8HgLJDw4NRUREiYwq729RsHFqCpbbN+NM5ofvzY3lLQ5KQClhjHVCY41wEN7ysL0ztAWhXDPS9W1qwuhtJi2tGJNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieKJj3eo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieKJj3eo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e96502e447so5811805ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255226; x=1792860026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=ieKJj3eoFcYuI1MLB/6HSHDlkK2tCkToFVT3RBbpoULeAXtUyyW7sOpvy5Am2TEzCg
         GqJJDsvmWKR59o/nDxxKFsQ0YWuNjw0bPw8t0uEn6AJ4Hbrj0sT8dFcQJu5qp7e96Ahi
         XtcdGmMnSds9hRXDYZsxO0E7L/TMpBQ6gIx4B9ko0FgJsM7WWEROTVxgcWebuglTLVhs
         gsd/S+w+fHf4qMlMRYgqDdOqq1jOltLs6LHA/Vmkr4+q5n+6JYyUT6sQLQrDIJmoHax3
         r+SBv38PgQmuh91DWoOxg7fWypfc0kWtbM/0RPOoKA9UFBnuLndMCKbsH9pa1RKW1drQ
         K2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255226; x=1792860026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmpNB1WJ0gNH4EFaRbOnrMQM/lEdyqJ32Z6JUH8YZaE=;
        b=Gvq4H1MGt1ydtmPbugF7OXWcrZDYM0wVhzG00Ug1wBOPYx0+Dk+vpXG2Cb0SI4Vv8t
         yffFEp4w2evhZ5M11fLwuJTC26abWybIWdoXarMTpIpihqajymE2CuLqqZRzdlQ08dQ4
         L5fjhpZH6a1MUW2mM4NqdYnMr+wwI+vX4+ExrXB7cayT4+cH3w2TLSD6ukXjpFlW/PqU
         gjzo1TxMMY9Wy26TkELI3bBCBPlane90v2q3ReRz866ot+XndB/oC+nJm18rdU6Oz4Ux
         e0SFx4L1fpb3k1Lx+MSBHOAs5U9v3iycNF61y4yU4qPTCvWc/6F9Mbm3TL/eRVvTgqVE
         bBKw==
X-Forwarded-Encrypted: i=1; AKwUvBz9hN+dkpcRCtSd+wZs8vhmEGBoV8I6hDYYj8Lob2zmRtanuyYNqlMUlXlmMUO49EY0y+UtIsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+O4OaPHiuI8YzacQl6LCS9n0yx43aXNTJOTuXIBON8oF36Rm8
	TS131UwFeqe0JLVSp/Qmro31AnNymh1Cu3d2NWMZKIirrNCNScRlZuDe
X-Gm-Gg: AYBFou3vtxKr4YhlksUkI5dFzl7Su7fHpWT/tsSmtv2EpQvjZIniQ8UNPRE73Bg7IqK
	PHY9pEmqgLym6f2k/rj5sBBFvhIYTRvXcfKxpdWd3trjUERm/o0MrkGV8KfJlVWTiiv0L1qWRk3
	/tjs72o/EKkSwd66u9mvcR3mZASYczD9irXc4Xj61aqCcfkfAu9sxq9BgWoMCa6ipk80pC7iafQ
	7ZI3zZ/VfBXp2hn3kBzh2zbcui2vW9CKzcgegV1jRMQCsjMbRqohxQ9KB/CDHF/ZF/x22QyMWfV
	ylx6/VCkKrRVQySJmUF8OPTTukvjgfqzCzqymRaQBdG7Zg1HiwPJilLfqxlEmD8Rf35uZHMTjlq
	DCNialcLbG6mfgfxc9aG/F3Gf7XproAC4emn7VvLnDMTlzmSH4B9Njkpyy2LnLIXySBDqXWuFZO
	wpGOcTeJSvgHr9q1C6SD/rx1IDsvoJu/5XBFurp0RdGw8+3w08h9PexVIkT17CVj2Nu23Po0Eh1
	4H+unqOi91fpDsHWudNU18mhhlMrjX20WX8fA8ag1YojL0bHI5CYL1ojZhXFOWN/nJCbm1RS5HH
	4h+IUwxaspL4VVbjVEuc0Ce1MVoTyKY2tO/E/GxaKrUYLkIhohC6Ow==
X-Received: by 2002:a17:903:19c7:b0:2e9:5772:9ab2 with SMTP id d9443c01a7336-2e9a6f5876emr29025655ad.41.1792255226030;
        Sat, 17 Oct 2026 09:40:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804ea9sm22325235ad.13.2026.10.17.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an iterator program
Date: Sat, 17 Oct 2026 16:37:28 +0000
Message-ID: <20261017163745.3341787-27-alexei.starovoitov@gmail.com>
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

An extension inherits the expected_attach_type of the program it extends.
If that is BPF_TRACE_ITER, check_attach_btf_id() hands the extension to
bpf_iter_prog_supported(), which goes by the name of the attach function.
For an extension that is the name of the subprogram it replaces, so the
load fails with -EINVAL, unless that subprogram is called like the function
of a target, bpf_iter_bpf_map_elem for example.

Then the extension gets the context of that target.  If the subprogram
has as many arguments, it can use the key and the value as buffers, but
how far it reaches is noted in the extension, where the test of the
iterator link does not look: it reads and writes behind the elements of
the map.  And the id of the subprogram in the BTF of the program is cached
as the id of the target, so that programs of that target which are loaded
already cannot be attached.

Refuse all extensions here.

Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 4668c1696a08..5fd376bd210b 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -351,6 +351,13 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
 	const char *prefix = BPF_ITER_FUNC_PREFIX;
 	int prefix_len = strlen(prefix);
 
+	/*
+	 * The attach function of an extension is a subprogram of the iterator
+	 * program that it extends, whatever its name is.
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		return -EINVAL;
+
 	if (strncmp(attach_fname, prefix, prefix_len))
 		return -EINVAL;
 
-- 
2.55.0

