Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE33BED11
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535319; cv=none; b=Dht7uXBzY4JwE0Ge+/Wjgnf8CBtqaaCSq8kOeMW6Tf5bhzATjN1pu3ADTsHcBgD3frEdzvzUFqva7PDfcbm+C70wQcqrVnG9puZ19B0+/ZziJqxpPfxhCTL3aMJUIeCpXaWJ+9nK4XmsYVUbH8DWeIPfhoNDj0Dy+y+fKlfIyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535319; c=relaxed/simple;
	bh=LqP62nguFNFw4UIn14y1SSzotfAejTBFagu336IS0II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3xd9r6ISuYX/dBdUCnfuSl1+vjyy2tw5xvYHdH0GRVPS4/4QTDQw2nXjummn4lK6/FHm9sLNLE/lx7gkrvz14kupMztI4zYHIgC7njmXpEyhzC0S0NE57y373rRQCBeJrS8qBbyUOjQERcHxvRguMWis+roCe8jYyXIpDg/wYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=YnY7rDe+; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="YnY7rDe+"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so354896a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535318; x=1790140118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7GrN4YXw+hUYBnpeWbeGsPVdLzgCyXeoX7BDPf9SCY=;
        b=YnY7rDe+qIUfirVI/+8mw6S3XTF+lq4eN0nIqs+AfgULoNzlgE6+D1t4UlTmnuLF+0
         8tVL3WQCarMLU1odpXgl7pO5cZswgoluRGG7JNtEFgSrFCdfnpX21y8UdqNp3baO84CR
         Ybv6OSgIdAmSjQD93jE0SZEEFV5uc98qA5Dal5SiJWTsoxHyu2V5OxzbZQQmfswZtFYR
         sq051ZI0ees8gix+8r6JQqvq29iZ0Lv07n4VgxR/NUWPQQ67Pt+u1qqjq271q1Dav+Dm
         EC338Vv20GbmYPBIMPbOh3DwaP11NbpG6pLG/6RbKH+6TBMyWn2e4jPemKZtNpCd+ynw
         NKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535318; x=1790140118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7GrN4YXw+hUYBnpeWbeGsPVdLzgCyXeoX7BDPf9SCY=;
        b=u5f54zxWdzsX1xc0XHDl30Lezka8Cv28p0KxMprATKyOf/hkbcJuflkqg/n7U6vhEH
         rVk4arngGg+KJjgJOuvOE6nTKdVoCnKcgU/7JSQRmTsgI/5LTwl7YVlkSvC6hqkzlwZ2
         Q/m/LBY+BXSqC/kKYiSeIQ7ktx4Se4Ip05ESRdfWTBFZOh8ZCYJAjtbq8v5IUE2MzZZ6
         CAVf2PaEBnVAuWmJKo/FhRQUXOAH5NKmLmRhqsjtUQ+e7nBLNFqrv5+LZLAAl1+Eb+Ld
         5Kp4x50uuAWzKsazNuwI/gJiNwFo/Aks6RYIWzCJv5+0gP3YH7D32wrgrJbVe5k5y0Im
         RsjQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9Y/if11qauB3FxVdXXL4uCdC+AKDD5QGq3yWV6WWLWtD2kS9vuZvHAfIjfroz7IVlAuKtzbM=@vger.kernel.org
X-Gm-Message-State: AFuF++kpRwo+jC4zDQD7nHWI0+2RC+u1ruN5DJBpO3THAEwWuFQwhoGO
	NtCiHUvb/EXOUn2KGoYam2fWxOZ/zkmyZGIzA5TDnXv7SZwREBEKIZX36zGAgJkLQ9U=
X-Gm-Gg: AYBFou36TvTtLS4e7f+leDdd/z8a1r9sV5EVe8L2P4jb0ggSYZq7vd9eugMBmuQihrs
	6bOrZsGszt2WkkOdaTwbCvf012WkhfQPTLb5iBOHjMVcd9bZ55mG2hewDxFRt5rhzHpv5PM9ry6
	RizR+4F1wNBAxvReiSY0rNmqIZAFUjEN+83T8QDjRo1Y2b4rc5meUQTcH4jP4L/Kij/rXxjJ9PQ
	CDj1NKc116O2YrddRTGbQXbSGvTN4KZtXSZQYzgLguIaYsZWKX5Sa4kMmBgpEA/ZjswmSYfe6O4
	OjbLldDQRFL8RYEfYa145M4CDly6zOU0T3xx0shJqLTuKRCsm/jlG/MASa/plBqiyTqlESNWTVm
	pzT97Yulp28TmTn9xURKESXVET16LQoxQdGou8tNdWabfRT68m4LEnAayUCvASCTlcy4UIoupVs
	l4WZFAwcgH/kFNpDHX5UgksZt1VF1NoNgjWMmyEUoliIPIV+P0NkvVeibDUiY0TFCcTPoaTx7Je
	hg2oHU4yut6vAKuFloxMkgkUPeBYU8kKbHBPw==
X-Received: by 2002:a17:90b:2ec7:b0:39d:f317:44cd with SMTP id 98e67ed59e1d1-39e1e4907f3mr3114547a91.14.1789535317907;
        Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
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
Subject: [PATCH bpf 03/11] bpf: Fix bpf_sock context code generation
Date: Wed, 16 Sep 2026 05:08:21 +0000
Message-ID: <20260916050830.8774-4-emil@etsalapatis.com>
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

Currently, the ctx access code reads the rx_queue_mapping
field with either a 4-byte or 2-byte load. The rest of the bits
in the register are marked known zero by the verifier. However,
the emitted ctx access code places in the register on certain
the special value (-1) using BPF_MOV_IMM64, which gets sign-extended
to turn on all the bits in the register. By shifting this value right,
the program ends up with a value at runtime above what the verifier
assumes is possible.

Fix this by ensuring the read value is as wide as the assumed size.
Use MOV32 instructions instead of MOV64 instructions to keep
the upper bits zero as assumed by the verifier. Also properly report
the size of the destination variable (the bpf_sock field, 4 bytes) instead
of the source (the socket field, 2 bytes).

Fixes: c3c16f2ea6d2 ("bpf: Add rx_queue_mapping to bpf_sock")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 net/core/filter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753..5d1705508 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10565,11 +10565,12 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				       target_size));
 		*insn++ = BPF_JMP_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
 				      1);
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #else
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
-		*target_size = 2;
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #endif
+		*target_size = sizeof_field(struct bpf_sock, rx_queue_mapping);
+
 		break;
 	}
 
-- 
2.54.0

