Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B13655DD
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200900; cv=none; b=HKaDqISsmvyYnKWt5vyklAteoyiX0CfyTVW4bc+HKEx0vwLubsmetFUyhxTa9Zxm8ngzCsrHBmdkArJRqhaaISPdSHXpKyLK1T5S2YNU5+PNxA87gIdmWGxJYqASins8ONWb9mbqpr/mwY65v7Uyi7PYhhOxFs55ZSJNwMJvaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200900; c=relaxed/simple;
	bh=LFQg+21msyu9OTgpui2dYEq+h9B6ZDaCiuwPnIXbwgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYpSa8gVOCO7TNbF0G86bWredPehfx9uOJuPVD9PpTpgDWUOHAyh9r6OtrTChoPrvGeD1D76ZwQSPU+7dg5MjRxjQKqijNxcNhJoq22oxaLDPg9de1RfdsJOtLvbFm5rWO2yWw0waO3F3EQu523qXUEOCctXbfeFpg3Cbdbfppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cntBJ2z1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cntBJ2z1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398b3c37877so370404a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200899; x=1792805699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZsHuPe0VyhOxoSmJoae0tgGC6fG6Lk0otvXcNJu4JU=;
        b=cntBJ2z1AOU8D3jFJiN7W6lbJHrkfXMjgM8ggo1eBqUFjUyrm5VFyEksnUbiphsxIJ
         yMtHPkBzzNw9NL4S5HZS4OE2cdf6Jp4L/KZokEQvmSbcPOiFqeJZFC4SzXUIhshhaDRC
         O5EK5SEq+cRqiFOO8RwelqHlCtfsgDBokP3PYySbtIh61J8AsJu/nrQHuH2aSsVA1t0X
         LSjd2sDZEAoXL7pVGZqKLcaQu/J2ABPCZmsyxMagbvctwBACXBSR2vXidGBwkjHgsy/5
         GSkjZdfDF+sczlAeKTxhhAsaTs9uhLO4irfnNPOLRdGdWn/wMxIGBdb08dYDtxC0v9et
         uSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200899; x=1792805699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZsHuPe0VyhOxoSmJoae0tgGC6fG6Lk0otvXcNJu4JU=;
        b=UJUawXNeToZ5/hRkbyMJspKSsyjb9Hw/o7exfJifpsIodpzyzqJ1v2J1d8D59zd/zP
         0s2Nz7wdrZII+TVisInvZYW21tJz3fhu3uigivQHcjDRpBBLcKIYfqr/6dEUM5PCyZFN
         UcOuaU2pKxENaRvZC/gY2yvQFntRNLO5HyQDu73PEER5nMqE0ZvYhgAEj6n7xdSkrvLX
         Jgcb1wSdvODMPwxazXrnCDj8AnYZRy5oOszMvV54sw7zNY1kY3fCdnRISkGCNjTXmcWU
         wyNHU/CU/ziZwE+ODW1+PYrORmgpk/FuqodcQCGruML2O7HfjxgLH12Tew2lfefhnLU1
         hUOA==
X-Forwarded-Encrypted: i=1; AKwUvBzo1PfqgUshFLnCohHGzxmbq/0n4EzOvfKw74bgHIjHBrQFrg5T+NPgRYuOsXMu8P58Azl05Rs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0sfwI+bz0vBaO0CWVhGGDKk6zHzy+s6wvORS2SDMWEGzUTtUb
	dyfPHkt/7OJGD4dTAPulnv8LQzVnF18lPs1hs6b+4yl7Fqemd58BSkw0
X-Gm-Gg: AYBFou1hQhYqut5OTZso21pe2pjtHN2nGCQMmgIzHyp5/Oy5D9ROhiv4ZHVhnNkQNmF
	B7V3/XqJW4DtQ/dJV54zE5Fti90tJnMV2kloEICaQkKCs67qt1DAMj6j1IOgZxTv2FAE7wmHp/I
	OS1aKt5c8JHYRlQhCe6F55DOBtFiqbLrZ0rUEm31eKeEMwkbNR35mFUPCkEvJmE7vSjMHJwbEcp
	ouyD8h/UzY+qL6u/h32qkHPPCQ7xrcJ3zVONV6GPle8I6efHEqzdudA9zkYQwPU0oQPxkAqwE7i
	tnfMl+H6jTlYVrXB8jOZOaDwoElq2Qidr1SR4Omigb5KCMqAFkSMXqCmAdr7H2kv9ZHHwPhJL7Q
	8gOnyxEiLJYjZzuU4bH/UcumPHIak1Xrz3k3dlZNvA2VI9gbY5Vnq23E4+BE+xIxe+g4T99zpi5
	5RGyF4gw61QcS/0PDca3ykXojeRJgxcCqTsIlmtosY0kuSaIyhHnl1czk/MeAx+czZj51nNAV0a
	LmVWebpBf/6u12Jxeavs+KRP6KfKcWINAM7IGuU442AHYzQxFJgJKUekgdwOHVZSobrAyLgzh1C
	Y+uSGgYWBOzCoFF2hbc0rWycLp07/gj+9qJXfSDT2J0=
X-Received: by 2002:a17:90b:268a:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3acef5f1cd8mr1266174a91.63.1792200898849;
        Fri, 16 Oct 2026 18:34:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm11189575a91.12.2026.10.16.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:34:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 37/38] bpf: Use memmove() to store bytes in an skb
Date: Sat, 17 Oct 2026 01:24:50 +0000
Message-ID: <20261017012451.364800-29-alexei.starovoitov@gmail.com>
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

Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
destination. memcpy() then reads bytes which it has overwritten already. On
x86 with FSRM it repeats the first bytes of the source instead of copying
it. The other kinds of dynptr are written with memmove() for that reason.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 54e9084b9263..0e3261f8d322 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1731,7 +1731,8 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpull_rcsum(skb, ptr, len, offset);
 
-	memcpy(ptr, from, len);
+	/* through a dynptr the source may be an overlapping slice of the skb */
+	memmove(ptr, from, len);
 
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpush_rcsum(skb, ptr, len, offset);
-- 
2.55.0

