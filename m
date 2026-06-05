Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CD3E7152
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684556; cv=none; b=dXAQn3NnciFpfqstMbnbV2Ub8vuOLwTvfTRHAdcaKyfQu+5BO3Vqgq9vzM9+V2WmaCI+V7RwNXpMlyeZQ//cnssHhFtES1EYVmmfSu0ZeKR1VTwTflXEkQdqV22sS7+VfX3zyPfmcQ5QFOCEHGnF8pjRHu3UGeEBqyOQVuPXDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684556; c=relaxed/simple;
	bh=VKa1p6dcOvuI2DFfe1gs5QWC1H4dbHxEPdSpJFQaEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKap+GwSb59XSWtwmZEaEVNVSKTP2Kqr0q5ezOlZZVUCgIjMNHf8be57JiPIzNG8ZN5pbloDBlbxCP9AtzWziTraA8EZvTWJQTG/QVgOXv4HCqCqBLb66M9ztTgQ9EWzVzGtvaBRz6erqoJ1x+UlmLN8txWHbiA8oKJzmgv+L4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3ps2j6/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3ps2j6/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf114b0cf9so19893895ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684554; x=1781289354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=T3ps2j6/jTHDPB6kEp1oGdtIoGSRAwAmf6dfnLGf6P9Si14FqGK/rme8u1f5PPb0av
         PKr0NL+4zhdd9MO+w9gbcMbib6F6mGJvTC/KMqMk1t0VQLSJvkBjhrfH2zNz5EhPAHCN
         +zH+iQQk7b1bSYbVGgHFJG2nFSMuGKz8v04y7SfaI3nHoQUwW+8muTo26Tw6U+5BpBT8
         lkuYud1VfOYfAJJpstqNQo1wWG41KXkG3nrlV0OjoAv3n+RomnoMCLUCbmLLsPDqyj0l
         ILW6g63Q1vazmePf9u9u+qNoLNRrNgaoV5tknHGdVCNgw8Sf8QGKP8iMO4037XgwGezo
         b8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684554; x=1781289354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=T0yjiVCMfAVKzEattP+Csj3fb9J9TSx8TtC7zXxl21zi2deFas3VR+jbyvIMisevZV
         nqWoZky7Pv2nCawcoqMhw3+Gj/9zFkd0zIIiYfhF8ogCj0o1TYv64MvUIvUdTrGPWPpI
         9v5unY/TVPP143MTtogzHtmmnE14omYIYwDCCCvugY1MbmAYu/rWjNd+QG99FyDRvpDC
         NoGJxgmqGSXxIh/TcUUbCD15hd6mLIrbOTIYSxphWLkzLHbnU+dGBiO/rux+qKTJdZTt
         +hKuFBtMcqV0BMHQXKjhl2eJwGrI0akmkZO8EGXY0mMZlBu8qg0j9cFCgfquw/6bf7nu
         82lg==
X-Gm-Message-State: AOJu0Yx1Ngj1Wux3bx8ujJMEmL3NjwuhbL28APB4qRLLjqjGUy27HWqG
	64IIpAZOOxZ4HQv+Pi+thfN52VVspvtW9kcRTF93eE/NBcRyBJGcnXh0
X-Gm-Gg: Acq92OGciR6hYK2yibVWomwtHuGDIolMg9ji+zeyxa48/Ap8yLkH7+kJzdMp55Y1Ysk
	/gxEVZT+N8rTI7yVjlx3gXPYSOdjxWLA1h5ZaOjwe0y33TViWtmamD0M2Io2uBW/rRjrU1uE+CX
	ee3E0Pxow8M3a+BOFLavMRbjL2ohGpKkU8LW0eZofthe0WPGKvzOU6D4mlqb7oVq9S6qKzWE2gs
	vkNefrCXnoA6xHkIoEfrCiquvSIIbwRIcsihJabdEf4tqmor3pBOdUG6HNah3b1uHcttneW5aJS
	HEkdgQZGIWuuOMBA9I6Nnu59NdYDG033czqRrS3NzrYv+T3CXNO1l4vJlH3ciHWzVFW7RPows48
	8LZ3zojeN9sEZjpotrPW4nl1+/7D1Um0NIiH+Kc8pgtOCBTITzOUlqR3IMB0ST4xuMHmDt1CgJb
	Cqskw3iMtOURNa9jdjaqisN7s=
X-Received: by 2002:a17:903:2a84:b0:2c0:c389:d99c with SMTP id d9443c01a7336-2c1e8332a7cmr54352795ad.15.1780684553679;
        Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649293esm102838365ad.68.2026.06.05.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Fri,  5 Jun 2026 11:35:47 -0700
Message-ID: <20260605183551.969144-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acquire_reference() returns a signed int that may be a negative errno
but was converted to unsigned, which makes the subsequent error check
deadcode. Fix it by declaring 'id' as int so the error path is taken
correctly.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6446db9628ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
+	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
+	int id;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
-- 
2.53.0-Meta

