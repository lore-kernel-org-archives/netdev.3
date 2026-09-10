Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE804CB8B2
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057122; cv=none; b=EzfcA2OyB1K8k4gwmMQV7oYrjdsFTyVcp7OA3IqVcIfGRKo52F5f8MoTiDCwRpJegDwdEpCvU5UBDiTM85Meug1P/+Taz6FX/RYN2lIhq6vM5wIV+NKg8e3fTQoht2NtWh+QuDxLrEIhWZ3PfcqzVSFSFDYBMl61hJgmsPs+Dnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057122; c=relaxed/simple;
	bh=aAZFucMOJ7/GL1ufGTFJzyWEmjStboys/FukU0gQmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3ydBzyI76a3hd8Hds9YJQ+p9v5naMkt0y/u2WB87svc4mnjLJuG81X7ZE+T5Q8XvPo0z1wrhQyxLhXq3IMYI8oTo8H62I4uS8VHftGgFY6ouglPH/F2qeFgfBlIjZ4QHEwn9ar5F/FCZWJETovQp9f3y8MHnlD0UtPfiKjH0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=jWww2dxo; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="jWww2dxo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso17474a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789057121; x=1789661921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muqL+n5pc5dgTfrd8eYbfZcJF/aWvClhjFuvc+tBE1U=;
        b=jWww2dxoJwiTucs+/oo0uxsUgtCfOWWzBfknU6xhO9ypXko/4pQbmsWibBnoGSTmL7
         JZOC0zt9HCdFDcJGgO9nKDKgXrYZGWWllWXbVqSb81dmjM51T7HIvTDaRtA5bxpaZz4O
         TI/eItEBs++JZpFYMNPh49zZER8E1FI07K4JqkDOJ2KgfuSna1OtmnITUzWREPxqfdlS
         hlVYaIoSR4QYzZtOnJH2blWmXubzHWBgSFtiCGidJxa1e3IZDIOrWXg+r/5mmv2t2i/q
         6BS8+hxmdMGRNa9yf/zKArtglcjbY4mP9yZCJWWNkN//RVsXVJJR+04hoHFczU+pY11Z
         M3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057121; x=1789661921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muqL+n5pc5dgTfrd8eYbfZcJF/aWvClhjFuvc+tBE1U=;
        b=a3k7NXpkFidAQKCColdFaB/VadWhkYD37T3c0yNzw9/5NzAbTOLdCJeIL3XAEX3CFv
         +zwLygm7gdJwWArQBdhUYU5E+LeHTikUClhRzkqC+Mgxe2DWgdEUp9nHDrLosSuZ7frS
         5Gif2FltaCrlZm1Bx29Z6T33MW9/fVbAdestgCsTBZg+YsojYGcLuc3lu9w3PpghxGZt
         mx7bTrlLojkiUgzfrhMUG/rcVGNzUN5JFc2Rrh61Cr9IOjmY2fSkh5Jb2WBEQM5d1EBl
         O3WmvB7ctnXLOTaj+ZBWUM5/FORFqv+dtsl/hcrolvq5dGbWj6c5dj0F/RAIlbE88+RY
         ycQg==
X-Gm-Message-State: AFuF++nFvs82fQ2/qsxP1r/UrrSwJIDydqfMtPVlQCF6xODyc5yCpWzw
	ResmgFB6WktIayu/h192QfqjOB36Or5rRjy36TRtJ4VXXozcm9eYqik0Oh466LErcOxQrYUbMVT
	83vXnyQ==
X-Gm-Gg: AYBFou1H4Cc8fN6y2SIto1M/5iRujBeoqtncsC36zOdorkfro3wtTkLAhwc5L6QbwoI
	RQwBrF0OPv+awJqzpuaZOjEUiiZB30/MRhA36UHt0EAaT5rMdRFlGhGocrFivJlfDishFHRrgnn
	IwDcLSXRsX+/6z+HdK9GXu+wqUzM9VduTZ8kvZKsLNMl8UW2AxrX54r5ve3vZ0aNYnzGxlNANVL
	bDhjFCHkygrqe75jlOPOmPQupSNuAU13jYhSIF7Mne00SI0sP3Xd1ur+TJFEsgpzntdMOtfvzPf
	UyKKpEh1na5N22yFiXYth7FshbP08wtEId9at9z8M5GNYejeddJpDePEqZlZCYCzuYvdoI4TDBi
	mIqkUvB7WxvcipQPMD0c14HKxDwqFMh0/D27h69qxetnEGWNzAtiSOyzh9i/CjvCaEAVrc6rHot
	RPe1fP4j8ZirsRL3wqMKur8hnVV3EtGYVwfsGgugbvkrMutctN++0BHHuVz36i7rn2RsoP2/cGw
	tCRxJQ=
X-Received: by 2002:a17:90a:d005:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39bac4571c4mr22077077a91.24.1789057120727;
        Thu, 10 Sep 2026 09:18:40 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm24262327eec.8.2026.09.10.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:18:40 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jonathan.lemon@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH bpf 1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
Date: Fri, 11 Sep 2026 00:18:24 +0800
Message-ID: <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789056660.git.zhilinz@nebusec.ai>
References: <cover.1789056660.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_map_gen_lookup() loads a u32 key and compares it with max_entries
using BPF_JMP_IMM. BPF immediates are sign-extended to 64 bits, so a
max_entries value of 0x80000000 or higher becomes a threshold larger
than every zero-extended 32-bit key. An out-of-range index then skips
the bounds check and the generated lookup reads past xsk_map[].

Compare with BPF_JMP32_IMM so the check stays in 32-bit unsigned range.

Fixes: e65650f291ee ("bpf: Implement map_gen_lookup() callback for XSKMAP")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/xdp/xskmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 3bff346308d0f..bf00d6463c191 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -124,7 +124,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	struct bpf_insn *insn = insn_buf;
 
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+	*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_sock *)));
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, xsk_map));
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, mp);
-- 
2.43.0

