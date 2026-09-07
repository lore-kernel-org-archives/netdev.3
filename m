Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69373845B0
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763373; cv=none; b=RjGEG/J4c5eDNy+g1r+9OXn86DaMGeHfhgeJsIf4jIMNEY/GKs49uBzcVwyNCEktcmuTy6SwMVNwTSdbUdf6quXZWTPduvIk/POFhTBYSaSRE3OQK+SFFBY2+ibYnGCVm1zslt/L4vrcEO0hT2xSw4p/JAkV8VR/1tWzaB042E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763373; c=relaxed/simple;
	bh=obCt6dFIrhqK0L3cVGv0aYy1LeuBf7kuUudz81Z9e3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7qzdHUswd8YhxyHEpLtF1i+f/OAzuhiJak0sBoWK6dw1FPwT/4tWRfXlQuz9FmtKzoW8Zz1Q4HmcEtPvYwBqhHJH3rLQjBxLjTwRrY5ePxEU8YWC6XQ987DUViWO5E18Fr4IIDsXa7XaUwCR02lKS7Syl8OUvEapRMW9X8tnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2CM20xR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2CM20xR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so3151337a91.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763371; x=1789368171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ar25cKs1gH5uWsuIBDWcu71MwwQW4FbjSNAQqbQcxuM=;
        b=R2CM20xRVjgggwT6RZ9dSkgejffFNsFnk969uwIletslHRlWM2AM0Cr8kzvGwf0yIl
         KwcsFLjVvcdoDeCfOsMvAm3K8Bs5OVwPjV8UDfFU0Xzggvboue9dQHK76Z5jdfGzpHXu
         BCZRG0b0yewzeZP5AsHry0GMqg41JJeyKlT9JtQR2UTY51q01WcvdTmvV/SMUorTz49I
         lpQoRa5E5ThOZc03Ojhal46F72whX7RZr6teukT5BaQPcxImtFYlzRS8+UKvJL7sO2E7
         Lo0ejR9ivA8OWn1sKu06ohAqoIt8XJC/6cdTjVRfF0plg+mgmkLOgxnHU1/jkuEGPf2A
         gQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763371; x=1789368171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ar25cKs1gH5uWsuIBDWcu71MwwQW4FbjSNAQqbQcxuM=;
        b=DX4VhqdrI/+YOerJj7GTqbxRCAXKr80NFNEpRn0n74X6hr0OdvDATZ4Zd8AnkUwZTG
         hmTaHpdWiqwjfafSOsuMhH5r7C54bRal2yFfuBCTmAFHJs8Amvo42ogRe8/OCINqR/ZG
         SrTZxsCeBXpVeZdCRksEf2OFCmR4SfLt4HeZe24CNFvoLC//nbSLEN1R2M5TJRW+20FM
         e+H8s2tFR2/ho3TjRIGKcy0UpvMozVl1qHXDyT2uYw8SG49IsATLPEQCD0Jc4JEitb3/
         Yj1nHBE663IzgWbRDnQO4IGMCEj4ZKyMfTRF+c0BbuR5Xa/O/3uF1qNWMT5+FP3qO/Sj
         9Spw==
X-Forwarded-Encrypted: i=1; AKwUvBwIwpNDdWlP7RvVeOZ5R+rjb2ATwvg5PtcIsRVjv9A+ecovJJUPqFR3nfTJv7qiEPzRxQFePuY=@vger.kernel.org
X-Gm-Message-State: AFuF++lmX+Mr7mE8pxZ+r9d8+G6SA9N3F+cyXak+8M723rHRp5zzkvNP
	LkMRprOCsLamjmemPK+LJdXZn80OQ9tPIdlQKTlZVmgBQy4TLK2hoyPQ
X-Gm-Gg: AYBFou3iMnLlx4eAaHcNup4YFFXFRcxdGBlZI3A3E9Cuzs3XVwUix5CAYAqJMUIDq0S
	cnB86NRnae5NQhnrwUU7oCeHHMXVKkvlSfI3s6FvCwNaGq9ALtYsKo1ztXEDYvRp6L9+IZPE0Hh
	JvGUkA/1K0pmVhxrCY+Glgvce8iaJhKJyS0zdVAGZulk7EXt6WNyUidWTjj8D9OAfqphO/chry8
	eqn2N37EsKdz6Mc47P39oNsgR/Rn9Nj71ic9Eqonu7CQiDYU8DlhWkEmdf5VeAQp7zKCvWMX3pR
	7NVClM2NuXrQprcAI9EZoazP0DTBMpryg7L6G6ZwASPnvfmGMXOmMn3jI6bZ92msDlbJE3Npsqn
	MMOIqrJFWgkpoF9fK7BK4+dPjKJnOvmeyMzd9C93yxyySFbPbeGIKRZbeFjfIzyAMkYKEbl/ECB
	i79PylMVXsCrRVF4bW81mD5FuLPuzaB838XOrGaFai1lYJIdSmoTjfUxvt8+oZI6mGsDDrc0lDT
	Ud4XFJNm2CgNQ==
X-Received: by 2002:a17:90b:4ac5:b0:398:9beb:a2ba with SMTP id 98e67ed59e1d1-39b087fb503mr30411442a91.28.1788763371277;
        Sun, 06 Sep 2026 23:42:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm14377817eec.8.2026.09.06.23.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:42:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] net: ipv4: fix typo "alignement" in comment
Date: Mon,  7 Sep 2026 12:12:36 +0530
Message-ID: <20260907064239.39910-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064239.39910-1-hemanth.selam@gmail.com>
References: <20260907064239.39910-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "alignement" to "alignment", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 net/ipv4/netfilter/arp_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index a87e07e80d0d..b680bd14d329 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -59,7 +59,7 @@ static inline int arp_devaddr_compare(const struct arpt_devaddr_info *ap,
 /*
  * Unfortunately, _b and _mask are not aligned to an int (or long int)
  * Some arches dont care, unrolling the loop is a win on them.
- * For other arches, we only have a 16bit alignement.
+ * For other arches, we only have a 16bit alignment.
  */
 static unsigned long ifname_compare(const char *_a, const char *_b, const char *_mask)
 {
-- 
2.48.1

