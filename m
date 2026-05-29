Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6336212D
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019386; cv=none; b=nCAUZDbl10SmlGyxoZn59QxLdw1VyuKpgA7zNvNbXepEebTo6C0eg83OgefPW0IFGkaRJiyzYBqroLlR802CchjKzi8KdFA3xb/WVG4dNo5khOP7WH8p8XRbtm+v8pVUiD61//bJMpQIM1b0lwoOCgAWYaNsstB32M9z0ZA36yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019386; c=relaxed/simple;
	bh=pe8s9TVFFol6JHyr+MNp/5iPOnewMEboT/fxjDbiS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3MZhMbyxgo/UpWtbhNVy0f69fh0joNQzggGY01hFPX/TCFO9gw+XtrtJx56VZJOuRDDIPdRmQdOsPjQXdrdXaVLfDugJnfpwBs1iCfAMuRnBC1fu7eFG6qSyOy4xuRiclOM8HOMxj0XYGd4oLvh2Mo/u1T2pS3vRodlw9JXSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0KGR+If; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0KGR+If"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b458ca2296so100673865ad.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019383; x=1780624183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J+IgdoEHYeF4G3sj7Ia8qLZGV8/E+K/UCZOiol4nfM=;
        b=j0KGR+IfA3duNdPkVwpNDfn1dP5WkYaKm9C67IIF/YNreXjDmSVIqX7H05Q58ZCJD1
         G/WLWx0LXCFJqozFLbZfBrELUAwnjDLMHfI8FSzzr4A4WqRoXi4RGHK8tbdvbjoR6MOs
         hFBaESfcsLCNxXrTDtJB51/klhFNPbnU7pjc1GgarEDuUTjE4rWYxrIHOMW5PEJFzPXG
         G+IRxzu5Wzgxl7hw81vxhLAUBli+BUS2w8DS7TnZkZ4CZ07MbKvtCQAFdJN3YA2hshMt
         Z/bdadKotPsgExoSMCGOXXXOYRj/iHcPPqHEol9n0pxtR+2qhXPk/SNyW8JxzIC0F96u
         BRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019383; x=1780624183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2J+IgdoEHYeF4G3sj7Ia8qLZGV8/E+K/UCZOiol4nfM=;
        b=hLpnBS3jvRnLNn8oR92lJNx7IZrZwqLlX4DwIZuUL26XFEjsvRbLQu7afS8IWdjwzO
         zmgpx+ASLxszpY/vaQE+2y3EqXE80ItNh4HndHj5f1OzKoW6XvjK2pRGDOBjwIzHd1y0
         ZB4x1SdiBImbiaPIdU4C7Z3YgI8XMDsfV2Msd7etfI2IbqBLOQqNXcO3SKLRKL9t0fjW
         q9ewnU2LKJZPA7R23namt/0oSX7wBJEatI7dPb6KtoIOqdO+yKrToGdBhaOpHm5/Q+KR
         wMD0zTEhCqtUxls/YeuX+MrIYuFw8yNiuHUhuCvydOCerMGh7njScUXcOSbz/nsqGVej
         HAQQ==
X-Gm-Message-State: AOJu0YzytrN/0f+F724i2JVtDhkuL1znPjyZN/ANpY0C0phEgpPSYhT7
	0UE2ndCZlomxoI9rvaogdNUDbz17i+eJmZBmiVQ08sIHk9fjGn5UYc1P
X-Gm-Gg: Acq92OH96SVwjkJiRhhC5zgpnbJEvPf5LHAlBkyw7PxWBA+nNw62Dj13w5bR8QCuvO8
	deAnpi0U3dxsi6oMidapXps+G5JTtUYtVko5Lt6ZrPX9zSvVPFggz+J8+BKUAYZRA1vVtCFXQVS
	LUltVC3HrghK1k6u9pBSIfRlEr/8rPUxhCSJactLmCA4li3ADQSnv8qaXC8ZvxbtqLfo46ZpnNB
	cKX9QvQUf1st+J69W16HGZnj2/x9sOfNA7A7c7qdjXPyq+TcSHVAJTOsBJylRgAAxALeuuVDSgN
	VfozLrtNME3nSJ8u3lIqGAjPI43ELxUiJgQNil8uUjTQoL9hFZFSEuqPtxyd2bXFvNkizMlWePf
	J5LwKIQyZM+hMWa0Xev5zQIrQixFvEIMz46lchJq+vJ+OcaAwXkoQedRUEQ2/akwbbMSHhVPGic
	48JJj8SzNmvPPoER241g0KxWCQ
X-Received: by 2002:a17:903:948:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2bf2063dc45mr11713455ad.10.1780019383016;
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm854665ad.29.2026.05.28.18.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 03/13] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Thu, 28 May 2026 18:49:26 -0700
Message-ID: <20260529014936.2811085-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d29846c4998a..552840d8d2bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6208,8 +6208,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6219,8 +6217,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].id = info.ref_obj_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
+				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
+					regs[value_regno].id = ++env->id_gen;
 			}
 			regs[value_regno].type = info.reg_type;
 		}
-- 
2.53.0-Meta

