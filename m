Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C421CC59
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200472; cv=none; b=qBa18US4AlJZI8bQeokbCtstDCGaDw1JBq9wMSgYNX2nVuCa6ecmfiTCtuoe1tChri4zkgAL1FmmUOusPrBl1IQTE6d4fZgjEcjrbSKJTrVTEYp3Qi7nFD7zZ4xYT3XsoBRw4+SJUPFg8mJ5zCifFn7fvXoDWVaOC5L+SwVojns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200472; c=relaxed/simple;
	bh=jqT5Ab18KbkMPLG5nuVmKYwi9/htcEz1suyx38WJeRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9n4m0oyhZjm7AtLvmSRZYLRoQaPRIA6knemM/1lP1sP1uHUC1BjL5jftPaHeQClU/wvhEpT/2sbC5NL2N8fzZnKewej94q9LZM2L6UXKQK2dbs80LPKdEvmDG9Mm5XOzpChxWVs1Z8lJ0yJUmFqZZ9dlMM0S1kLKdYbVx6Cnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzXbxCNP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzXbxCNP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so334663a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200469; x=1792805269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=kzXbxCNPf34WSlNfqlfLUj1nuQbgGCGNRw0+s4Bk32bA6KWXB0IXzqT3l6gdPacCGG
         fNOR9FLRmakhstZKNSWL+Nah4gvsVrBh44v8Jpp5WdTZbrLfW+Sr0OaS5aGURnapK3Zj
         gAvd0j4rZ4GOwQXXJMEo70xOxKXT38FAhdPkjPc6gIx/fCfZneBYve3S1j7tJKM7KM9M
         HITBrW4n7jP9J0XIO1+b73rMFkNhgGFCjBrHk2jFY0lEUzUUOcNTap8l86xMbPPTTvnd
         +hk9Tah8e2VYADqkg6PRc9BK6n8c6hdG+Q94Gv2gslt6bqKARfWVwxaEkDxOmNmHdiiU
         D2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200469; x=1792805269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIpcC7WsRUsfob/M32I+w1LmmQqZv3hP9zFFPAjnTx0=;
        b=gkUq/wARmJzCbpE1BUdXZP4C3inreqasRRuAvX7YlMQdGQI70daW0vmQmRSKsZLgGc
         xP4Z2nYJVMDlwVdscKdE64NAl2SYvdBlbFbXADSFchSqdm8PyGlxtKWBnPocprH0EGcj
         glllTfWZ2YNbQcpnJqBqVsIpDM5/hhXMrJkzDPfJmvS0bbtMgEe6NH4XjsZRt0fg8Qof
         Pq5r2400zpU7fkDb986W1chD/dO4z7TvlzgZUzrImtjn6jC9SVuda1aIbAcLYhMwiB8T
         rYwtUUwxAtY4YlE3FdZSYH2HWKwqOg0rWecDA5w085Zh/DvHCzmx6PJOheS0v27pxmdp
         LEtw==
X-Forwarded-Encrypted: i=1; AKwUvBwETrFCR2pUauPX+QbYxRcKWrX5zhr5e3Dk1re+H2ffIjr9hdLlt6b0gdWbhqvKAlYci6pGTdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsD8fp9XgHlQ6pBtRVMrCO5BTZaB+anq+m7KvxFq8FsWb/Q7Q2
	PM7369K3Pu3lj1ZxJsVZndIcVKiwhU/D2nxxU2w6tjmoUjnvlG55BeWg
X-Gm-Gg: AYBFou21IQtLXr2FEqNh2bsBcTWYvfiV+KmjQcEc1pujlPOmUnierCyLeIUAv30I0Y7
	/IZ7QH53XhSEQITKyMGFRU34jrYKO+tAbM4RDB36jHeNCvM2CFwGFfkLxMC5uNAfUXVNztzJUqN
	cK9ZZjXr8A/gvxInqlvXS0BPxccpGGtSI7DEBUQB55BkBi6FM+Y+oFSpnRNBgmMvQo9V5uQvKG+
	vHECQCBaosiKxlbge0hi2g/6S9spLpUp8J/hd/y0ibBM32cItnMlyUVzh2NQ0da+lx2rJAaNypN
	ME1HIGZpxTISnxQ/wXBC3k6SP6zCy/HhyD/hzc1wwVTg/hT/PCJO08Qx9BHZCC+HPMQ3pYNnGp1
	jype11Yj+Nk5X1tPigZ31/NMzouTujsKB7lA075NIhJpiCx+l5F2O2FSt7wAfE2oQZMJL2YzDi/
	+BzKU3CyrLepwiPYydYbAx7ta5+Ag0E+ItrnuY+U9gtdCoZH7bgZiyMwpdBnofsrE0I/EBO4uTy
	qT8N8Oqvnb/g/fS5/QIRZ1Sb2QtoHeQfYWOP4QUbuptWjscd9b8gpbL8LSj2g2BotW8tDD5gkQG
	wgjvnkTcxD4KorJxiK+THON27Ixcc8eUsmebDw6lyl2a
X-Received: by 2002:a17:90b:39ad:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3acee2796fdmr1139235a91.2.1792200468922;
        Fri, 16 Oct 2026 18:27:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm11282572a91.7.2026.10.16.18.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:27:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 17/38] bpf: Bound the nesting that the BTF show code follows
Date: Sat, 17 Oct 2026 01:24:30 +0000
Message-ID: <20261017012451.364800-9-alexei.starovoitov@gmail.com>
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

