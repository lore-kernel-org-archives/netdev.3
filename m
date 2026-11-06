Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991927;
	b=1djLOvtYLNSb+MlpNUckuclxjJoPJq4oP5ncyiFtBZSeNfcoh/GI2Zv76rG0OPXzrHVO
	 vJRLfeWk1TX1NoK7yJyLPD1TFkAqQNMBquwxlsaEM+e4wKzIqLV2Hm8usKX2AvHshwyxr
	 hCAVZaEUG1qHt2G6TCuygiF0ela57yodxU1sUS6s58X5um6AW4G6nuU6TdO2X0XpP4q+k
	 IstOhrGtaSgHWonJRj9wOZoHAdQICTcyld+7ZygIlDsNZozn9l5IX2aSRTbYNhQjg/LX2
	 ytz9EuIbVXxswikxJMLE83IpuwnPTFO/NeofIGOmq17uhAZJyla9tUxxMe+JHq8y++A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2T8ZYwQtl91zdyiQJyBoQRMm+I4dJMf5ghcXGTax8X8=;
	b=n2Pz/sXwID9/6Dt0nTTQQhU3K4qDkfrTdYKiDLsm1C+DNX6gc6NAIdbsNuGlghdGPNsS
	 rTNN6vLy4f44zmb4ziUbq35pM1y+Tq6VH5o+ogauu2WWtRg0yZBrsBggBhMEQByJZxx0D
	 yW8QMbKHKc54u4c4LrsGyxAroHb9Gmi6f6dhgKqzSbrfPWcjjpk+yCNwzhM40zXXxEKT4
	 fwsPw7gSXsYfwSe3SsmKQwlIR/8TmOqmxMzNs8gcp3/cBxF/9JCqgrQCP8ZLYL20PPRTb
	 TBS9RuActgjUnsXcuBOLFV6cDFzZqdIHBJxgnY+pt6wkqjNVHpe8NwBi/f6O6tm4nSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PNub6xoj;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C1606A338
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41C1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PNub6xoj
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed02a00b24so9200505ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793991926; x=1794596726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2T8ZYwQtl91zdyiQJyBoQRMm+I4dJMf5ghcXGTax8X8=;
        b=PNub6xojnk8CE8wBfjiPWxMp5N6AK+IoKAAsz+/w5aw1XWtpX15PTX0hkRVcXN6FLH
         1VOeyFWxV3khSslZm5TX8CbJXQdH4zaPnnXB/MjaGUmElrapuRfxpwhg0v/rwHLvT40m
         KFiN496z1iPGLlueuZYgRZ99lZ8PU8yETNi+Vvkv3QKxQHbMqE+xcaTgMQ/mEzfswXUg
         hfvg3PqvCpMD49ThWC8m9UDfG1lIVRbL36s5NSVjxIoE4WXPd8IQPbWBr97tJ882zJWx
         H/lbdNlDAbV61viZ1UWvSPap3x170DdO+4fPzcrTXIxEXgF20oWDLmhigvmR5bQBiTaV
         fz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991926; x=1794596726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2T8ZYwQtl91zdyiQJyBoQRMm+I4dJMf5ghcXGTax8X8=;
        b=hH6J0/+428yQactqgUgoXDBHTvz9oK4U6ICslJ1TnDS0bfhO3gbQYVJuk2JfaQD8Xm
         hdSp8LsP5iplphDluAgEo7SgCN7APP6On6GSC1fgsAQgQjBxkkJLoeuETmCXnDTQR4tG
         0bXel+Pg8xC3j0mZqCKMhUozccIki8ZINDYvUDmIMKqNL7ABW3P8rb4FLoEqZaN6Ao7f
         ibdLpzcFmejjJT/S2zfzZ+5ZHXgqG1JBplGfLyXuDpVwr25oxbAKgKyuSS2hjVAR3hgp
         VxUL5ZA858HQr+HTTlSoZn16x3s6fdv2DdNZnU7NLT01of0X8A6pA7eMx2P2b54I467O
         kTmQ==
X-Forwarded-Encrypted: i=1; AL+hErEqyu1HlEAjlIM3zWmndDAU76Pplt5YPcMcjI3jlpVIEJAWM/9dbZsEnJCIKjYE4u7fznH/1v0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+CAwxoyf2i7d+6G+hXMM7m62hUb71qA3P3Un0V25JvYXMBPab
	EzcTfR2r82VdptGBpk1JqyjwL4TfjkOCFnVMtH/f/l1LXr991MUldnHcgc4AKpXKo+bJu54ahd9
	OzFR/UA==
X-Received: from plbky12.prod.google.com ([2002:a17:902:f98c:b0:2e8:7c6f:de6a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b05:b0:2ed:101c:480a
 with SMTP id d9443c01a7336-2ed40c9a8e2mr42904045ad.37.1793991926030; Fri, 06
 Nov 2026 11:05:26 -0800 (PST)
Date: Fri, 6 Nov 2026 19:05:25 +0000
In-Reply-To: <au347UiVUe5oUuxM@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <au27Y9m78_3EH2v1@gmail.com> <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
 <au347UiVUe5oUuxM@gmail.com>
Message-ID: <au4kpSGVSH3tYiZm@google.com>
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, acme@kernel.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, ast@kernel.org, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 07:58:01 -0800, Breno Leitao wrote:
> On Fri, Nov 06, 2026 at 09:16:24PM +0800, Jiayuan Chen wrote:
> > Thanks for the report !
> > 
> > 
> > On 11/6/26 7:38 PM, Breno Leitao wrote:
> > > My arm64 KCSAN builds of linux-next fail since next-20261015, because
> > > bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
> > >
> > >   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
> > >   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> > >   Failed to generate BTF for vmlinux
> > >   Try to disable CONFIG_DEBUG_INFO_BTF
> > >   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> > 
> > 
> > 
> > Has pahole fixed this issue?
> 
> I don't think so, see the line below:

Could you try this ?

---8<---
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 01049e9802a3..92793ae6cf98 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1782,18 +1782,32 @@ static uint64_t dwarf_op__const_value(const Dwarf_Op *op)
 	return op->number;
 }
 
+static bool cu__is_arg_reg(const struct cu *cu, int reg)
+{
+	if (cu->register_params[0] < 0)
+		return reg >= DW_OP_reg0;
+
+	for (int i = 0; i < cu->nr_register_params; i++) {
+		if (cu->register_params[i] == reg)
+			return true;
+	}
+	return false;
+}
+
 static void parameter__set_loc_reg(struct parameter *parm, int reg)
 {
 	if (parm->loc_reg == PARAMETER_UNKNOWN_REG)
 		parm->loc_reg = reg;
 }
 
-static void parameter__record_loc_reg(struct parameter *parm, int reg,
-				      int64_t offset, bool is_deref,
-				      uint8_t size)
+static void parameter__record_loc_reg(struct parameter *parm, const struct cu *cu,
+				      bool for_inline, int reg, int64_t offset,
+				      bool is_deref, uint8_t size)
 {
 	if (reg < DW_OP_reg0 || !size)
 		return;
+	if (!for_inline && (is_deref || !cu__is_arg_reg(cu, reg)))
+		return;
 
 	parameter__set_loc_reg(parm, reg);
 
@@ -1920,7 +1934,8 @@ static void parameter__finish_piece_decode(struct parameter *parm, Dwarf_Die *di
  * ABI-preserved or should be replaced by the single used member candidate.
  */
 static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
-				   size_t exprlen, struct parameter *parm)
+				   size_t exprlen, struct parameter *parm,
+				   bool for_inline)
 {
 	int regs[2], nregs = 0;
 	uint64_t piece_size = 0;
@@ -1951,11 +1966,12 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 		switch (expr[0].atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
 			if (loc_num == 0)
-				parameter__record_loc_reg(parm, expr[0].atom, 0, false, size);
+				parameter__record_loc_reg(parm, cu, for_inline, expr[0].atom,
+							  0, false, size);
 			return;
 		case DW_OP_breg0 ... DW_OP_breg31:
 			if (loc_num == 0)
-				parameter__record_loc_reg(parm,
+				parameter__record_loc_reg(parm, cu, for_inline,
 							  expr[0].atom - DW_OP_breg0 + DW_OP_reg0,
 							  dwarf_op__snumber(&expr[0]),
 							  !had_stack_value, size);
@@ -1994,14 +2010,15 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 			if (off < cu->addr_size || parm->loc_reg == PARAMETER_UNKNOWN_REG) {
 				uint8_t size = parameter__loc_size(parm, cu);
 
-				parameter__record_loc_reg(parm, expr[i].atom, 0, false, size);
+				parameter__record_loc_reg(parm, cu, for_inline, expr[i].atom,
+							  0, false, size);
 			}
 		} else {
 			reg_pieces = false;
 		}
 	}
 
-	if (loc_num == 0 && reg_pieces && nregs == ARRAY_SIZE(regs) &&
+	if (for_inline && loc_num == 0 && reg_pieces && nregs == ARRAY_SIZE(regs) &&
 	    piece_size == parm->type_byte_size)
 		parameter__record_loc_reg_pair(parm, DW_OP_reg0 + regs[0],
 					       DW_OP_reg0 + regs[1]);
@@ -2009,7 +2026,7 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 
 static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *conf,
 				       struct cu *cu, Dwarf_Die *die,
-				       struct parameter *parm)
+				       struct parameter *parm, bool for_inline)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
@@ -2051,7 +2068,7 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 			continue;
 
 		if (exprlen != 1) {
-			parameter__multi_exprs(expr, loc_num, cu, exprlen, parm);
+			parameter__multi_exprs(expr, loc_num, cu, exprlen, parm, for_inline);
 			continue;
 		}
 
@@ -2060,11 +2077,12 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 		switch (expr->atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
 			if (loc_num == 0)
-				parameter__record_loc_reg(parm, expr->atom, 0, false, size);
+				parameter__record_loc_reg(parm, cu, for_inline, expr->atom,
+							  0, false, size);
 			break;
 		case DW_OP_breg0 ... DW_OP_breg31:
 			if (loc_num == 0)
-				parameter__record_loc_reg(parm,
+				parameter__record_loc_reg(parm, cu, for_inline,
 							  expr->atom - DW_OP_breg0 + DW_OP_reg0,
 							  dwarf_op__snumber(expr),
 							  had_deref || !had_stack_value,
@@ -2103,7 +2121,8 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
 			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
 			    entry_len == 1 && dwarf_op__is_reg(entry_ops->atom))
-				parameter__record_loc_reg(parm, entry_ops->atom, 0, false, size);
+				parameter__record_loc_reg(parm, cu, for_inline, entry_ops->atom,
+							  0, false, size);
 			break;
 		}
 	}
@@ -2171,7 +2190,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct co
 			parameter__record_attr_const_value(&attr, cu, parm);
 		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
 		if (parm->has_loc)
-			parameter__decode_location(&attr, conf, cu, die, parm);
+			parameter__decode_location(&attr, conf, cu, die, parm,
+						   ftype == NULL);
 	}
 
 	return parm;
---8<---
