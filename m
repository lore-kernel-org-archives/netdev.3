Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471B43DEC1
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345520; cv=none; b=Aa3B/c1MtdZ7GtvIrs5bWfTvsQ5Cc18qqKA5qqtu20KRVyV6vO1SF+XgFFT3dnpn0Juhm+VS/90MFumzYSjL4J3ihkwZad96XZjGPSG7wEaZ3Q2itdB+kyGKFWEDE5O2zRU3DUWD9wYC7oT6VKkWo/hZyPPEq8DdHI02/wSlrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345520; c=relaxed/simple;
	bh=bClgww2PEDEwfXY5iR7JQeRsyjdwM433YNLMHw0EdVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHKJwP+vY6z7h4no1YPShuKDdFMCATGZnJS1DD6EZV9lGCR7ss4kC3G5gCjI2q++RYalyUZQ7TLdU1w0RU3GOs3Bmpv9/Pz0ATwlnMaquyzCoFLNP4EDSc4/klI+w1p3njk95yfqvtFZfDelMFBqlgXkrLErphZWJhDcDzv99vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=B5iFfF/4; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="B5iFfF/4"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3aso9287576d6.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345518; x=1790950318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dO7NZCxAxiVThQ0A8dmI8vnZ3FIyuKMw3NNH1me1PFc=;
        b=B5iFfF/4mvlPPw3BphhIrn1bZb4aH/fj7RRA3eZ4zH2usE2JEeIerXfGQjx+dGHsdt
         +wAmuiF8z7s4ZnY6toCfecMo1pSDnmtKS73c3aVF8YDg6Jq3SyJmUO60QEGO0ugpvuXn
         BzTN9n4LbfuWhtFFaimkUHgi/T8zdtoo1I7zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345518; x=1790950318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dO7NZCxAxiVThQ0A8dmI8vnZ3FIyuKMw3NNH1me1PFc=;
        b=OLc+kFB7nQvnrV18pq8r6RVQUobYBTemTaTkcQ2ThgEXm0PXvEKQFgu9lP/EBtliY0
         aILDMjkPnCvVI0bhNhLLXW1oNXqc5qmOQqIwyCKWYK1NDVviKgXEQDIVJ2Ep4FyGjH4s
         AoVmgzIs5uvvQkHvbujFfLruVfYL5j0eguW8ZIEhv/UBLihblJB8eL/eHNzJANZIEFxF
         n4qV84TmJblqcoybF72VUU5Np0o5p7hA7bJE2pPSa0eOB/GQ3bWMmET8n82b7MyxPbjH
         ltMn9g0Hfh8QP7OA9Djm1PeoS5HCVIL88xfh9zmFAknW9AMxVFD9f/R2Ttp3RJxbTCvj
         wd/w==
X-Forwarded-Encrypted: i=1; AKwUvBzmEccdcJKAiCmJLI5EG9uVlFWGrQr8i4XZA747JCcjF0T9RVlV5OWnICGW7UJrUWPOkGzvYDY=@vger.kernel.org
X-Gm-Message-State: AFuF++m+ZAT9np0ojIHNGI/2Qo//hM+U77c7auwXWH6xWQykWd7GBhu1
	awlWTVsMQXvAaByclGLoNxhjyo1j2qp5JF4/gai9RQZIcKXKrDv18jBxoJNUKPolUxQ=
X-Gm-Gg: AYBFou0xTM/kjUzewAQSVVdjuvao9856I7bYL50eom5YxJVY4Bs92DvLfk5rTZ4rcpl
	kb13VFUpdSZ/Vi89BajZXzXwHpij6nAOVc1dgxGevQhLOjb6tbUcuJ360p096jbn6CwmuWPf0SH
	3zTmcTg14m9vghfdSOeSh/fWgunRV3Oitwn9+liAI8LLpjxc60hnO+0DzcKZcfp7aACJUzS7BB0
	bkl6bYyEK+gDTCDtwzWHLsPyycVfo8WQq83IpfGD86LIusngIlCnK4Hb2YLTXvnx+o4ypsj76ww
	GvFphYQqwZH6CORA72gwPhOhNCdZxIpKWc0obPujG+xTsXArWazjJxLbv1YapTAeYs0k2U+TWjm
	cwMVLdjD4e/dxt7Q7xAC2t0sNA4OqT5mYpNoGrYh3S3ilvNS7bsMLHT9CHk0SvzrJeAGOFEb7ML
	zgVwjUTan8gLOeekDJ/mrnqnOdk/X/Ee2Knm/U3q9DiWrnQh28HMO3UJ/j8iAVqF2fVO03C6bLF
	ayz/mBgfvaVgK4raCbysZv96OSFFQ==
X-Received: by 2002:a05:6214:20cf:b0:907:c025:e4 with SMTP id 6a1803df08f44-9142f7af5eemr44633636d6.13.1790345517807;
        Fri, 25 Sep 2026 07:11:57 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ecf80csm17564456d6.49.2026.09.25.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:11:57 -0700 (PDT)
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
Subject: [PATCH nf 0/2] ipvs: fix OOB write when NATing ICMPv6 errors quoting non-first fragments
Date: Fri, 25 Sep 2026 10:11:53 -0400
Message-ID: <20260925141155.17603-1-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a 16-byte OOB write past the verified skb area,
reachable through ICMPv6 errors that quote non-first fragments.
Following Julian's suggestion, it preserves ESP ICMPv6 handling.

Patch 1 includes the embedded IP header in ciph.len at both ICMPv6
call sites when parsing stops at a non-first fragment. The change
follows the ip_vs_fill_iph_skb_icmp() calls and does not depend on
patch 2.

Patch 2 makes ipv6_find_hdr() set *offset to the fragment payload
for non-first fragments when target < 0, so every successful return
updates it. It carries no Fixes tag because it defines an offset
that was previously unspecified.

Axel Mierczuk (2):
  ipvs: avoid out-of-bounds write in ip_vs_nat_icmp_v6
  ipv6: update *offset for non-first fragments in ipv6_find_hdr()

 net/ipv6/exthdrs_core.c         |  6 +++++-
 net/netfilter/ipvs/ip_vs_core.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.43.0

