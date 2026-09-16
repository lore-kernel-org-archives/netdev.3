Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FD37F742
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535326; cv=none; b=Xxp6y3+TNvKAYXYDEFULohXSWc1GG5OCrdFFPSZ/E6CPQ3bAFTX+W1OowsTFEb8iYL9j9c+H8vl0Tphe5PEbqYidS5jDltWCh84MLQaCoH6oRQzvkvStinOrVzWZUKdY8lNjPTFOrP7psLRLsr+u5i+NP5bywdSb3ScN/se4694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535326; c=relaxed/simple;
	bh=/EBmqpedMyXNs4le2UtjM/VEZab4NrlOKqHobY6nb5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs133YkWRj9mgqwLrdkNzKMxcPQl896hXPNmtvEIhOJ/c0qBOLuDm/zNOEpUmlooE/e6Mt8r5MMGbOXBBwQkjntcZZVXMANWMIZaNUqrYK7gLs9YdjePEq/mwZHf4VDxdTj76m/l6pwY30hAvxXKmrLEHSGYLNnIwG06h2CAhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=cRo90lHt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="cRo90lHt"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso463911a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535325; x=1790140125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbuudFOahnKw+BAgWb7UD/RD+Mep0oLIS45rulzTPn0=;
        b=cRo90lHt/O8sZp0SUkoFt+OOA29mH/BroxBlP9HQ5sH8S9S7eyD96VfsQCaz+ySXVl
         bUS0fon8ijIWx/IIOIr4EPp0Z+FOg0AfKfZd5oipdtgieZn1C/JrizH3w+YPjKk9kaYS
         S3gn6Be+V3iwq5Q3gG+328psemmNigJLGno16iB1c87yqVBOoponMw4cXnuAIrJD1va1
         REfnypde9sg+k9exfnRFZt57orqhoJyyvuAfVkAeJISakhBc8etVNLtazOU6dLOvOVHJ
         h7ci5WYfDhxMf8MALyh6AAVj2tr9JZL+G9HLdP++BhWmhLLvr+iRKLvNRtHht8LnQ5MX
         SXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535325; x=1790140125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbuudFOahnKw+BAgWb7UD/RD+Mep0oLIS45rulzTPn0=;
        b=eF5oZy3ux7dovRL3Hfv/I2eV72ZQeKQh+p+r+zaIBfJ4ED7dUPQMD/lWGy/IEd2PNF
         /WMI051EmRrKdttg0uAkkOBXb5l6wz/RsWoBJGk/KHFxcfCx2G+z2bB+KIcYSirqkKj+
         P3glP6+R/D3R28Tu662RcksFnddq8WCS086XxkOy6kqmQkTApleYZXt8AZyoF5B8K2xd
         f5lnQr08mBEZwlMui6gOMFMCD6NUCiBESxOb9GCOFA7GvHaQOzV65uL9iDzZ8UHlhbih
         nY7xhlTCETdwtUcbxiuZhwSWtsZq2yK0AyGLeIIzCC77EOWyXVVUKifSvEpaMI8/LVHr
         02Mg==
X-Forwarded-Encrypted: i=1; AKwUvBx2LQVXQI01gxoI4y3O8VdEkiFHo1fKSgDJ1nmL3jxJBKsFSF+OY+E/lPYRJz0QdrEmp5Ce6dI=@vger.kernel.org
X-Gm-Message-State: AFuF++mzCj0aNdodf0QX8ysv1YkagpaRpQwGqHR/mFREdkBU2cxmgJW5
	ciltnSnDPbKvvl+T3juOaq+iyZ1phqhrZOdVuOZlykSw1fuDXb9HnCoiuSydDCfLOrk=
X-Gm-Gg: AYBFou2fgL9vpUohiIYajL4UnRuXxNdAppbUFU1UprtXvhZwBFajhwhkg9eCLFt0c7x
	1iNDmBcDO3D2mAxRWck5PN7vaZEfk+9pQ+qhqtPbIkHxvphu19FPi3d9G/nsSUIqatl8IISaskS
	Xi8DjlZqd8NazmC6Z8ZY9XD/lrImsW935B+NP2a3iIjnOHj/cOHmItV6BFLIufI1CErC454jgup
	HHN9S8NAijNcFkN196MtUnubllnoi/LOBB2rk3vITdMOL416AEAiDn1NwFMBFso1WRA3CWu1yuX
	i73XgP/GdzOs22w+rRLM4iCjV1RVQRpPzKhXYgbZ6HGf98iOTSzpUK3YnnYuMucjZoWIn9T8ENi
	U4S7T5Q7s0px64hIYrUp2sJdzMMa4GoBodghIdaj+LaAmuV3q+eT2syaMlm7GssFKAAe3Eti0vq
	IbedNQXH5Rm+GgoPs8BW65MMITN2t78hiHQnSK9Kcrr6saRI94LFKaLpI7Cx8I4SYedmGY8/DPK
	/YT3xVjLeKAkUkldrGiWK1Ku1+PPCl2FG+OHg==
X-Received: by 2002:a17:90b:3c51:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-39e1e5047b1mr3271726a91.21.1789535324587;
        Tue, 15 Sep 2026 22:08:44 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 09/11] bpf: Track whether dynptr type is known
Date: Wed, 16 Sep 2026 05:08:27 +0000
Message-ID: <20260916050830.8774-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TYPE_LOCAL dynptr type is used for two different
kinds of dynptrs in the codebase: Those that are created
locally and backed with a memory region, and those that
are passed as arguments to a global subprog, whose type
is not known at verification time. The two kinds require
different handling in certain scenarios, e.g., packet
pointer invalidation. However, there is no current way
to distinguish them.

Add a new field, type_unknown, to bpf_reg_state's  dynptr-
specific state. The field designates whether the dynptr
type reported is accurate, or a placeholder for "type
unknown". Adding an extra field to bpf_reg_state avoids
unnecessarily splitting TYPE_LOCAL into two types, since
they would behave identically in most cases.

The change is currently non-functional. The new field is
first used in the next commit.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d5b4ab0ba..76aa724de 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -71,6 +71,7 @@ struct bpf_reg_state {
 		/* For dynptr stack slots */
 		struct {
 			enum bpf_dynptr_type type;
+			bool type_unknown;
 			/* A dynptr is 16 bytes so it takes up 2 stack slots.
 			 * We need to track which slot is the first slot
 			 * to protect against cases where the user may try to
@@ -1531,6 +1532,7 @@ struct bpf_map_desc {
 /* The last initialized dynptr; Populated by process_dynptr_func() */
 struct bpf_dynptr_desc {
 	enum bpf_dynptr_type type;
+	bool type_unknown;
 	u32 id;
 	u32 parent_id;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c08ea94d..357ed7c30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -688,24 +688,26 @@ static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id);
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id);
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type, int parent_id)
+				   enum bpf_dynptr_type type,
+				   bool type_unknown, int parent_id)
 {
 	int id = ++env->id_gen;
 
-	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
-	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
+	__mark_dynptr_reg(sreg1, type, true, type_unknown, id, parent_id);
+	__mark_dynptr_reg(sreg2, type, false, type_unknown, id, parent_id);
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+	__mark_dynptr_reg(reg, type, true, false, ++env->id_gen, 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -717,6 +719,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, err, parent_id = 0;
+	bool type_unknown = false;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -772,10 +775,12 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		}
 	} else { /* bpf_dynptr_clone() */
 		parent_id = dynptr->parent_id;
+		type_unknown = dynptr->type_unknown;
 	}
 
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type, parent_id);
+			       &state->stack[spi - 1].spilled_ptr, type,
+			       type_unknown, parent_id);
 
 	return 0;
 }
@@ -1945,7 +1950,8 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id)
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1957,6 +1963,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->id = id;
 	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
+	reg->dynptr.type_unknown = type_unknown;
 	reg->dynptr.first_slot = first_slot;
 }
 
@@ -7783,6 +7790,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		meta->dynptr.type = reg->dynptr.type;
+		meta->dynptr.type_unknown = reg->dynptr.type_unknown;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
@@ -19889,8 +19897,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
-				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0);
+				/* Global subprog args may be backed by any dynptr type. */
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, true,
+						  ++env->id_gen, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
-- 
2.54.0

