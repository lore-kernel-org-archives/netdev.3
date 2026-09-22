Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E32577E34
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097655; cv=none; b=A7sfSUPMksh5kkot26PWtSCsC/nxBACKA323Ge0SfNAp5goj32EaEATnsuIlYaYmPa9MEFB5N1iWIGYLT1yh6oj0Cg6FnOgXABxnzpdK9J306rMj/Mm0+IUYlFbGsrdmEPjEWClmwVWgz5aHryW0Qj8KDD0gOg37EGtmRJoNnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097655; c=relaxed/simple;
	bh=+wqleCA+p9rbs7ppEm2zoLuG3IWPujpJnMYbg025GIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4NEc7j7sYxI4ODNyqE8JHMjdENq3lsbKSFA6X8Ejq5121mQ8T/Hfq9r2EO20cZ+I4EEMWY4wfh0MKul9hyAQKudG92z4kBpSxME0kI54943EZZMO5hOupHpFOZrFDof5twx3CU72QR1SoAIxCcqFqHg9G84qCSf2+xeszTSugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UL6E3tYd; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UL6E3tYd"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a1676000so110272a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097648; x=1790702448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DZs2haudTC1Ifx9sckuF8aKv3VP4ro6sJqrcY12YPF0=;
        b=UL6E3tYdHPIlGHvq+EPDfk0W5rGjuI+xSSvWR3Axywuo6/IZAdhCewlDqa5BClJeyi
         yyq2JiacpB6sCmj/28pYvVWGA2ogMdnmJ3YqP+JOFhAzU6wbiEvmu6zVZcEBwd7Ciw8j
         s5ed2nkLilAQ/kaaB/kmRNmuo3rMgfHyKboYTyGUphK9GO42g98mzc4G9isiJFvgiHpI
         EUsbZy92rS0xdytlnH/bnqigpYTNBETl1vNE2DeFx7L6JVHABSac6SJR+fpf9SKRo53G
         cd0ZNjmzBGo59F5y5ce0mJC4zmed9c1ibBcPpVrPGn1fSINwwezH9XqXGYNqBWElv0E3
         hPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097648; x=1790702448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DZs2haudTC1Ifx9sckuF8aKv3VP4ro6sJqrcY12YPF0=;
        b=eOstn3a9291mEj9sY+BvcGLBUAYyB3cvAHp9PR9NXvrQGqddyx692OxvTS95mYjnBQ
         CjhsF49huzKOCOC4MxgWFGb3c4dy+3JnwEpjIK/nH0v7nE5ou+NMZiSfLMrKnVFsRQz4
         K/owoo6JfxFoAl+JhKnX6WmFNcEBD+L/yaOWnBsTHkKaWM2/IYn4EeNfah+BHNHhdrRw
         LPn+RqT/I/O3e13E2MjoASrcKW5ic+6FwW1d2shPR6bOXBuvNAsKSddpsJY/1dSBQ7P8
         Dim69YcIRk233dCELDSYiVSycqzQoB8DA1DUTypCNE7ebexIp2Xo1hTqSuxAZ3d+kHta
         j3dA==
X-Forwarded-Encrypted: i=1; AKwUvBxg/dEIxd4CtuXYmbwA465N9m+jMW1hnzcsLudFtgxvBe9E3p/7SBs3aqivcL4Y8GAM8KHUtMc=@vger.kernel.org
X-Gm-Message-State: AFuF++nJiMaM/gTRwsehYGtfKhojyolm4o/uBrPmd9l05anVmRdYcoJW
	KXUaec3oEfqIwlSk2puOdwWaZ70hx5fwqsFReVRi+PegxP9eM/7UGY9vf5cB28Wg0uU=
X-Gm-Gg: AYBFou3lnrIkVupLHrDSy1VPVaWbkA5dxN4vFxMgxtk97SQVm8hKh0saJkRD8N2t9/S
	Z9G5LzYY76FT/llRTm8H2xx95u3tM3YgZlMHajDmeaeGqFL2XhKwWAact/1UpHkPzFBxuUQJzrl
	KPQ8/YLuEHGuhB8Tg/nYTIsUFMMr34xum1LboE6pdXeCTVjyVkQ9gv8hB3fbi2r6N3vl2l8vvW4
	0iWWbSjnwZY5TYBdZzR2EE4zjvjJ7ppM94mZ89DerzAnMhcBJU1FmcP1rTadTTA//xQ4BtEMsSa
	Ei5dH0WslvJeslZCm6KTKSoGDN2vnl8IZstVMJ8SPj5QDwnKlMCQRNMfh7HQZ9sUuwYxSvAsiwR
	mMRQdIOcw3oPmcqqkzDcdzwXweLWk8VBkt40EKWZf1bNjKP44SGImAaHnD9Lrqfc2ZPzRmjqIeW
	aH2YvXqeSXnSdMhnOZGqbuudXigoea2ykHR6NtVpGSzHDAQMM65wF4WQ8Pro1LVWkwohz1cBhNQ
	BISIgYZe3uDYkZ2h/zHaosGj6RUvaq+Uqx60M63ZA==
X-Received: by 2002:a17:90b:52d0:b0:39e:1693:c3c1 with SMTP id 98e67ed59e1d1-3a07e5973c4mr163619a91.17.1790097648106;
        Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 09/11] bpf: Track whether dynptr type is known
Date: Tue, 22 Sep 2026 17:20:26 +0000
Message-ID: <20260922172028.6269-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
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
 kernel/bpf/states.c          |  1 +
 kernel/bpf/verifier.c        | 27 ++++++++++++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index be0ccad15..f57730d1d 100644
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
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c..360aeb5da 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -795,6 +795,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
+			    old_reg->dynptr.type_unknown != cur_reg->dynptr.type_unknown ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
 			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
 			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cebed6c9d..da110cdbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -694,24 +694,26 @@ static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 
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
@@ -723,6 +725,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	int spi, i, err, parent_id = 0;
+	bool type_unknown = false;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -778,10 +781,12 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
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
@@ -1951,7 +1956,8 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int id, int parent_id)
+			      bool first_slot, bool type_unknown,
+			      int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1963,6 +1969,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->id = id;
 	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
+	reg->dynptr.type_unknown = type_unknown;
 	reg->dynptr.first_slot = first_slot;
 }
 
@@ -7801,6 +7808,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		meta->dynptr.type = reg->dynptr.type;
+		meta->dynptr.type_unknown = reg->dynptr.type_unknown;
 		meta->dynptr.id = reg->id;
 		meta->dynptr.parent_id = reg->parent_id;
 	}
@@ -19963,8 +19971,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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

