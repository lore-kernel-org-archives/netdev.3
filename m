Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AF4A3F1F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345523; cv=none; b=qgDJyoqPFWXxsLYn/fFe9t2cAPXh9AZyYAqJCx5sQ8o1QogCCDwNXt8WiFS9mXdeu19K3sFC8xNXl3En2EowDqinVnI5k5xQJ8cdJTY7Cr0hB2eGU9rTrkH1QnPhSE7U9vvtSF/4cLFrcBxnHymuQbBQGfRbSoTziQBW8b70Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345523; c=relaxed/simple;
	bh=kpB+P5IgBraa5hfYbRLKKdjLjknHhjJvEYrNAH8GIMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+mopalMxWqklVoM6D1JbIlTD0XGhvdqjaSRQ9x4KIe8R8hROFSRkkKjruxCtTbXDF1G0WDIswZIc4Jf4r/QYuGwx+6IbzyN+rFz5upOwMAJ9G8zttTz92qKp2RXA+Nt6ALzzoHyW+eN66of66fFcLfJASmF4rmdJ9GWd54Ydcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=nH+kadg8; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="nH+kadg8"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91434eba57fso4982046d6.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345521; x=1790950321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWmHRI/KalPjXKg4Cpy0gjt++WenU4Jtw+yVPdV0Dtg=;
        b=nH+kadg8ghdbHzRMicK38xeYz9eaoNXC/Vo+pCEl+iq42earwmE/qeQ6DVLZqfZjI/
         FaQBwuKAvlKmDVf8NA2pQ8dePGsXIBdgqh0PnM7/p6lmg6JHbyQpoxe/em9Bk5hvAIdV
         jaZu36q5haKidAKZ4bH+iTz3lgtNxxuVZ3DlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345521; x=1790950321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWmHRI/KalPjXKg4Cpy0gjt++WenU4Jtw+yVPdV0Dtg=;
        b=VILuqPhP7SoF4vMl6ccXHT775mu8LJPlDC0t5bFMuHYpv/C1ln9VqcchR39MOli85x
         ZRhhwun/P+EekDtuToLN26JQU1AgFO85MJafhm8ZEfypx0u6m4iWU+ZlFIZ+gpxWwoAb
         SH+DjmmMjy8WD6Vog8uee7ZFy2EoWndugMdELimedUJTMGCQI0pNQs4GmAHbh6CyWeSU
         kEWqxZ4TIPPzyuc2WpDIfLihLhH3thMChAAhLL9ythXg7ZOvozP4uKfToe3lg0v7FlIp
         OhmA5xgYikfgwnvCb0eoovQYLBXEE5Dim/QDMcJ2LksIgGvGyQdPES1iDtlpUFyxK1nd
         tbKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1tzmzXQK01okJJfvURb8JKLnWDx9nQA8h8YF+uemD26s6aUhaZ3+Kpv4gCqQTjcrSkDMxi64=@vger.kernel.org
X-Gm-Message-State: AFuF++nAPwTu1QGdpQOTrjIuU3quCsWe6GLAv3jLw6MuQi50tZst33Aw
	fV2l9Chxs/hg3xHQlnv9QRkNM6UftbVafr+orgbfZs8Lrw9ucNk2HDVOJfcfwzTOa+s=
X-Gm-Gg: AYBFou2SjtW79NtETXYjyioE8J+nO5Yww5jl/qnkilnIjjMIr10ZZs+9vaEV2Hf6aXq
	0yjvqFKTeCY1T/3VQ3pFfpiFgFLFVAEzgp5fZVf2aAPDybzzdcXvXGEwMWyJ8SNVikPPyI2nc0U
	cUKyL1/x5j1qK/RLv/K0bVbiRSNlhl/86JDKHBCsoCFkIfPnYMANg7i/VHTt0yU9+oa4vdA5blo
	oGjNaHfgerxwpI+0aVMEN6QE7lAW6ayLAfYEdF7Ib1HLs0QqYsuWdZZ/YSdLDXrCHX0LC9OsiCD
	opBmZ0QeGZuPXjaXnKnsElTS0c+oYYdkiddphO4OXtol1b0Mh0zIvOuLLtfoFWbbBdcxPmcYsx9
	zmBYGTYyvXbzATJVwJ6qMHa9ttlG6MlYdV8gSzbK04NmpMdp38mkF1OrO41pKRIrJwEVho1QPul
	Ya3ycIW7D+pQkbzdZH6BYDiHGgTEFZl1yktEzKAHwuXR0dZYJiRWo/6x87EqolkNT9zp1pQMelH
	fmTaMs1cArEbERCRfk6+G00xyL5nqmMOMXKCPwY
X-Received: by 2002:a05:6214:5f02:b0:912:5b19:ed61 with SMTP id 6a1803df08f44-9142f68bfcamr42218396d6.16.1790345520657;
        Fri, 25 Sep 2026 07:12:00 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430da9123sm17878676d6.16.2026.09.25.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:12:00 -0700 (PDT)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Keith Hoodlet <keith.hoodlet@1password.com>,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH nf 2/2] ipv6: update *offset for non-first fragments in ipv6_find_hdr()
Date: Fri, 25 Sep 2026 10:11:55 -0400
Message-ID: <20260925141155.17603-3-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260925141155.17603-1-axel.mierczuk@1password.com>
References: <20260925141155.17603-1-axel.mierczuk@1password.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-first fragment early return is the only successful exit of
ipv6_find_hdr() that leaves *offset untouched. IPVS used the initial
offset as if it had been updated.

For non-first fragments with target < 0, set *offset immediately
after the Fragment header, at the start of the fragment payload.
Callers must still account for the nonzero fragment offset. A
NEXTHDR_FRAGMENT search continues to return the Fragment header's
offset. Other target < 0 callers check the returned fragment offset
or ignore *offset here.

Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/ipv6/exthdrs_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf4..e27f5b8cc154 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -179,7 +179,10 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
  *
  * Note that non-1st fragment is special case that "the protocol number
  * of last header" is "next header" field in Fragment header. In this case,
- * *offset is meaningless and fragment offset is stored in *fragoff if fragoff
+ * for target < 0, *offset points immediately after the Fragment header,
+ * at the start of the fragment payload. Callers must still account for
+ * the nonzero fragment offset before interpreting the payload. The
+ * fragment offset is stored in *fragoff if fragoff
  * isn't NULL.
  *
  * if flags is not NULL and it's a fragment, then the frag flag
@@ -261,6 +264,7 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 				     hp->nexthdr == NEXTHDR_NONE)) {
 					if (fragoff)
 						*fragoff = _frag_off;
+					*offset = start + sizeof(struct frag_hdr);
 					return hp->nexthdr;
 				}
 				if (!found)
-- 
2.43.0

