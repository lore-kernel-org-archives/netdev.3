Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954D3C10AB
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535321; cv=none; b=paPUkfIqFvKWVDkXX4xtyOHsi/13GwmifQYMNw3lDut/XttBEKIVyCGhTGrxL8w8hUE6ne2zWzxIFTBGtyzyRgrGZatKPJ0oaunVCeg7kMrn7/M+qKb+PBeP2Qxx2Uj6eIHbhxus8UoKOgf6Uo6ztnPvU6TOe/uMCRYOQ5dUrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535321; c=relaxed/simple;
	bh=J80yl7pSeu1aJfefCtPfA36j81IPQ16Uf9GsjRy4ypI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wltf66d7TB3Xoh8tHHBdpkCEUd24if5rK8mtkhy8X5LXzD3BzkDB/qVKG3AQWdld9A0HihvbUw6ywa0gymjvD7rMYPmgF6JuYhxl0+bo808+jNxwEzic2NcR1kC8JxpjRKMpStTViFYCQ//7Ebi3SLhKT9WrOFftcjTWzsCm4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CBZV1qX9; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CBZV1qX9"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so129921a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535320; x=1790140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=02XHkDP9g5u8iUqxCMNdoLYMMHIC7E9GJphz8qfrxd8=;
        b=CBZV1qX9y/6ieDA1u7zFLcdTSW9lxsBq2OfRLG+gqUirQbXk0dpi3xArLAfThzGTZL
         ePev5iWdXH/RRi8u7L4lKGbomhdsnPaKFye3DFCq+zlEflt0mniyVYEfkV4OYbEXJsn1
         6Cu7am0dAjZ0oyxCc5RbRDrfBjazcaQuWkzdILMe6DlRlTKoBbkiCw1JXeXhZtb5pcNO
         lZsxuuFBJKfqNeDMrmcvi/pylA897xY2kIL1jl9ptdaQfPfsOQTV+9ofJPB+Wp9dIxUa
         XLHV58EBez//rshBd+JnshnnUa7OGVh7tqbrmlV2e6wvHmUiEy0VJegs8gFIDftwHSVM
         lKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535320; x=1790140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=02XHkDP9g5u8iUqxCMNdoLYMMHIC7E9GJphz8qfrxd8=;
        b=w9M9HFVZB+pUWlkW3vef0wKOAb0oAEoG//qVipoxB2KeezG725PgEPmA+TzeQa1Tga
         Wj4ZETEp9D+0cykqixFjSkwsUYRgb1vfVHShK3DatmRdzdr+NquK/cR7TmiktN6kgoYW
         SzOWPp1KlpdlaBGEVmrFprL2kJ2MrqJsdk0mpCpbK5feuBnWinegkYCAkZLcdbyLP0X7
         Fdpw5k5cJd2+/bTKk+P7pewO3PJH/gZnFYau7NGAaJKQ/FMLuKJb/DQwZBAxMaIqJnHB
         +sUpHGxPK21zxcREad2AHpzvnCDOKo+YD5yszPuGVwK+ACwoxFDTsw5uYraPNGH8f2me
         n7Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwt5Gu6mTjEoLbDvitxCHFuju7q8i7cs7aU5fz8tDhpd+fVjbzAGDPwOPzMIb1zBxa1qN6vf+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kkYhaLJrrd1sLKXy3TWJFjMD2he6AcSqlUHA6iUvHlF/whOcgl
	C66ssL4xo7yuQs3Ck35L7RsLudEwwynT8DUJkJvbKt27Ar8N48d+MTuitAzRhmKOVIs=
X-Gm-Gg: AYBFou25E66UNtJt6qrmZYqpHEeyXyfUE+2lD1cGAo6GCG7oljynpvf2imATEux0rJo
	Uln/YzPwwuNeaa94VHjljMKMN80K0X4n4riy6tIOJ026mPxmEUozlGBQ+fVDjtmUiEU5+NFPlx/
	8jb9YEHMLYcU3uIi+Bw2qlfLApAWxTDuV1o+hBPex2I9HmoJh09I9VEUHPNo7df1pg9xP0Po6rV
	ljn7Si5mtOCU3XsAJ0Q9/DjQU2Cj5L5XjSh9PODJCSP8LmOm/TfknW1xJsQfPBdo15LsXSNrF9F
	LynS82TWjv9cceYE+8Sgk9T7lfLBIcjb5Ha+uKV6VlUUFYZAO/IuZfW6Mei1wg3XKem4xeexvja
	KRK47K+3E8aiGSuPetOPbsqh3/LbJYj4z3e52o1cg4aeHOU7J7+7k6tlVMudpnqG4WOYT22fDuH
	VnRF/RfKgd8c8T0vbp6UE5jx18GjdtZvMzBhmQwzQnPFk1uD6knTmOLaDLdaHdV0SVfnvTMXiNh
	oKN2ZzDsp20k/+2ZCWiZ737jFbfwyr5YQCsMc8=
X-Received: by 2002:a17:90a:fc46:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e1ff502a0mr1231132a91.6.1789535319534;
        Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
Date: Wed, 16 Sep 2026 05:08:23 +0000
Message-ID: <20260916050830.8774-6-emil@etsalapatis.com>
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

The verifier tracks changes in how PTR_TO_PACKET registers'
bounds are modified across subprog boundaries. PTR_TO_PACKET
registers are actually passed as PTR_TO_MEM, which is assumed
valid for the entire call. This is not the case with packet memory,
where a pskb_* call may invalidate its memory region.

Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
because we would also need to somehow pass the PTR_TO_PACKET_META
or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
the pointer in the subprog as PTR_TO_MEM, only permit it if the
subprog is guaranteed not to mutate the packet.

Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d852..507bc14b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
 					  NULL))
 				return -EINVAL;
+			/*
+			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
+			 * us from adjusting bounds tracking info.
+			 */
+			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
+			    sub->changes_pkt_data) {
+				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
+						reg_arg_name(env, argno), subprog);
+				return -EINVAL;
+			}
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
-- 
2.54.0

