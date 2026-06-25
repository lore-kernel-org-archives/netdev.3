Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F102E8B83
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394305; cv=none; b=bN6NCPb6ItpzcaQaKdA07LoUQ+oELKd/65Cdv1tenU0eap1bAcm3RO/zPCca7TS6wZ/5SPo1XJOeAwvC3Foa2tPm3b3N91CTFJ8oJAJzgeDm3nL3nvL2+4eHRlFMUEMhqeg1bpRwFnIEq+MFdrThY5hHg+hjXHZc0VoopZJ+eIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394305; c=relaxed/simple;
	bh=GkObJTGOwvo/yZsse89jgOyAK3tQLcC4VOm5XflDZOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chrCA6yL8hcXREQR49KRcJtaP2WvLVq3MJm7bvr+lRNpbpT3IYSv7meUMrXST4FkCD8gJOCmeknCRkudOuUfWlP558EmJBhhHTlAMf8Z0KkcoznFH5fZdUDsQkQZBFGpn0GRkan+tsgOsq0+k2uTBqmlkZwrw/OsEuIz009uQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS3r46eC; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS3r46eC"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13981833e13so2778943c88.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394304; x=1782999104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6SpJYh+oLbM19wL4RZRwc0NJUjhwQHIffBTILtoP8=;
        b=eS3r46eC4opLOzjO0f2kQBTShxHcOHDa3ckBl3twkGEkKAtbVuHFvB6AJ6aTMweHG0
         LC/JXTA5kiU00rW3GXXNIRjcTlQWoV7oVtkFiQ/UvsSDtR3ZrAfUROeirefsM/X/qXxW
         Wx8IYJHsZv3q5/utYbvHnBkaUjb6zb7G6/aAjf1+TKNpbswG0jhxqYhnK9XmP8+2z1HX
         uwWbp8mJkEkZQlFWZa0zaEQ3wXWeE0Ud3867ViRubxCgee0kljfwEJ45L6UGN3pkJcSo
         ObOOavSn3bPSKCzVmdo+Aq+SVblcj7nNZHxF17GESq7DrFdnUYYBRLVkAdzxt11IL3AU
         RrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394304; x=1782999104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK6SpJYh+oLbM19wL4RZRwc0NJUjhwQHIffBTILtoP8=;
        b=nAG7wA3g2qfl3qtumXCXU3/+Cf1nhSSnoSDqgcEvKmDF64kTceZO83BqwS92F9GNF2
         WXuJdhUIy2oqpi2uVKQtMuflnjxDWxMRuM17zFvcXz+CHAUgpeFP4iPQl19feXd+/yME
         I2nk8/5uIl0uBasllm2KvMlK61pUNB0Tz2INClKTTy7zINBeFsbCGMZQ+18a/KIasYUU
         psGIUQoXEO1iaPSsYDvva8QLn6Qmy3GxDTLD7v8nRDjZmDBvz8BFeHVxfl/TD7OUmOl4
         iUzya7fBUQP1Fa42tcBv9ltmre/wfneSj8MY4aRBteaB1BUnD2bGSO41pBtju3IvJNIn
         u5Zw==
X-Forwarded-Encrypted: i=1; AFNElJ+rbVlq/3nVVdvND1GH07GIhrm9crSZM2moN/TRTd6ldEEjEriNmHs1e/TL86u/1RG3g66ldjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYIAlUBhlha7k6dcZ4Tuz52sQOgfhc8Qpspee4tnD8mMUU7ui
	HQuxdP0a6gUSm8UE93WFrPqzll3eZNBQNyyj14ipsF1TL7PevpRgp7LB
X-Gm-Gg: AfdE7cl0Lh+cMrSp0mo+n35sYg9nXl0TOhbwV2H9g6s9lePXAkEJ+yqOrKcJ2ylHrq4
	5Y7dkjGZCFw9L9SQyloD3mLuYrWsg8eL2KmPsRd3xnh0bMkPc1uhJ1aAKkvdz/GLzfLK4b37Jbo
	guly2V0Guh6aCC7u+YPfVKfacGtVS16nHbxnEPfEadxCSIKp2s1hU8uyvvHqtN6XKfoWyEAxxo4
	KvCgDgrujhQNxPbrz7n8lbipjtTefmo/GJfEQ6bdM0s+41gsaFp6ZwvTgPtfTU5ZPIYx0LVUzSN
	jalB7ERpKwgEjA0iXlmR4AQRc826PlJlahX0ntF8kAUT6j4n0oJrzRgFI4LGFFseUFzgvXBLJk6
	aZKRR3sVYVVsT8CFkvse1LRoq/N6IKMVQMmkpJmGR5N5wniXG2OuQE/smNUG1ZfFASRzRMAjo/y
	UwlF/uTOw2Khn7uzFpHTU75kQhF8lhY9M=
X-Received: by 2002:a05:7022:6192:b0:138:e4:c44d with SMTP id a92af1059eb24-139dbae0ad1mr2171642c88.25.1782394303648;
        Thu, 25 Jun 2026 06:31:43 -0700 (PDT)
Received: from idcredbox1391.. ([2404:f801:8028:3:40af:bf67:9423:25ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f55b04sm8806333c88.4.2026.06.25.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:31:43 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Subasri S <subasris1210@gmail.com>
Subject: [PATCH nf-next] netfilter: remove redundant null check before kvfree()
Date: Thu, 25 Jun 2026 19:01:24 +0530
Message-ID: <20260625133124.970238-1-subasris1210@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvfree() internally performs NULL check on the pointer
handed to it and takes no action if it indeed is NULL.
Hence there is no need for a pre-check of the memory
pointer before handing it to kvfree().

Issue reported by ifnullfree.cocci Coccinelle semantic
patch script.

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 net/netfilter/nft_set_rbtree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 018bbb6df4ce..efc25e788a1c 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -544,8 +544,7 @@ static int nft_array_intervals_alloc(struct nft_array *array, u32 max_intervals)
 	if (!intervals)
 		return -ENOMEM;
 
-	if (array->intervals)
-		kvfree(array->intervals);
+	kvfree(array->intervals);
 
 	array->intervals = intervals;
 	array->max_intervals = max_intervals;
-- 
2.43.0

