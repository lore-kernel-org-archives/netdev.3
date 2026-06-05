Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB882F7EE5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690860; cv=none; b=rIZK0qlVTCecuUT3ffCw4SYhRoO3gLh/PPEiHr8q4jhNPcMvhg+g64O5rFgHgYnUxwjpBiyK35aeKk+eGrtOu7TuUDwOM865XfeISxGyiV62WEMuSeny2F8856LxC6p0SLl7SlrD2cR5j5M7lMLmSYRdtvhlNZuoPxwRMfoj81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690860; c=relaxed/simple;
	bh=VKa1p6dcOvuI2DFfe1gs5QWC1H4dbHxEPdSpJFQaEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haU6yIiut/7vThwA6R50i2+HsaHSX82MSNvijvsEgwobGDE8VFh6p5ieox/eV268NonEXZd4zA0SPnWerXEwHFpib9ZW2OknJk9SBGDFz5FaAFlI6JBLVolVmQ8JUH3ar6u9hJ3ktLcOOapzx3FBVkYHxFGZUSiOOT8wBxdKkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJ7Krlu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJ7Krlu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf1f074a12so24392155ad.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690858; x=1781295658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=kNJ7KrluUXmFE6QSJgP0lDFWlb8jcgoNsF3CNiqf5QODBehh2vlz6CLQUqwsvjole2
         /U+XID+UaZEF6b+kTvc/mgRvBNryyAjbr58V5e1Y+UzjOalHCghjDuHv+7fgyqmgqCb6
         J2Ef8tPHeEJlkcTMGRCINY2S4xBHropcl+rS9VfB4iJyBiHn8E2+U62wjIR8SBzKJqTh
         5TSi6QgSVQmOorMoHmFxOAlJmlU+nL57e5SpwcSNzVqE9oBalGmo/mJQLfPmryoQSXYE
         LSMp53Nb45Bxe/4uzXoBGOvXuoXASbAHIctmt55kgDPrjZ0RxLbtOBMm2N34k9+Pn82J
         MFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690858; x=1781295658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=QmvksO+2kjLOfu203xOHXUZ6ky1DlkQRz+trZMFR+aS5bJEQbEx8eqqKzQNzsXf2fy
         RgcGggUi186KwnN/1kKYl6CIZ2IeREJfFaFyh9MNgxZZXYhzRY4qBFj7Qea76ar4hAnX
         TPs31HuGz7ylk+fPUUE0qv018xh66skwsQ9Mc55fR9AHJe4Xm8D21C/60s67NHErPf7X
         HEI6iNT+CzNUBR+KysBMhAA3PFREuiXGrH9T2ljEZLp1zEjdVUqvv3fGKMzmREV2Iy3h
         b6c8DkNIZsE3ZtqltETKwgXgJTDMIzrP8JXMKM7zXmFUlSUrk4B+2WZfIXMetLp3YuIl
         ssqw==
X-Gm-Message-State: AOJu0YxGN+2WDCYO3B25EQFzHt3KrsBo7Ztrh+cbzm2ZPYUB0lzczHyC
	Jd3LbBRl3Hn83sDXbhIOPIynG1K65KKiLtIRI+8h+e0LF7XSo2vR01BF
X-Gm-Gg: Acq92OEQkjaGKLG9gFojosPWx59rAqipkD7vsydI+jESR2j7Vdu2Lm2d5mL3MjV7XYk
	/y974R9XfF0rmrAuEeTrJ/0TJFIoHPhiunzr40hf7uoldzhxo9+U5jM/77cj/gLLjs48v2lFKgg
	MAEPXCg801SK5SIjli+LZdk2kv8TYlMvdI2rcONjOgWQV9ecR07HGM52rHZHwTn8eovJTAD4xc4
	kyc6zE8T219gqr42ICdtIoi+ADb5KaJDqQ8Uu7I5wR8cXIoRnOoOyofkEO5hyJL5vc9t9AJ6yZA
	9N8OaOdv9pfqilj/bdDNFDHTgEs4Zf8z7A8v7qa3XtHtmrQdlraXhwoAfFPegEpsxUthe/w2VoA
	26ZT2A3dF8FYCf+wiWtttks9mm0wLrqpcKolWAK/JtL8OfYxPdiu+RMUIcLahyBEC7xNkEZeSw6
	cnl80XK2D+IZbgvjAjVBp8Yr8=
X-Received: by 2002:a17:902:f60d:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c1e85e0896mr52701875ad.36.1780690858479;
        Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm103007865ad.53.2026.06.05.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Fri,  5 Jun 2026 13:20:52 -0700
Message-ID: <20260605202056.1780352-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
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

