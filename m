Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901483F4DD6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812370; cv=none; b=dRvx4mPy2xN+5KakkDAtpxbTyPikaQlC9s1IL00yhbsusue6qN4v5z9ydhjvS0cnI/RkeflX9Sifqq4k5YEJ6aieTzLN3XNSj93+nbGMMFzrr4AOM2jKrYxZMHo9bEVxPTI3bJPUHI8O3jJdJUWQmKfW9lCELNgh/srA8rAMnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812370; c=relaxed/simple;
	bh=Mdp4dHp9ElITnJAkU5a96KDXLwBwbM8y6FoOZ41QR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQe9mtmQQIoBVU7b+W9MzH+7TCtFfm082fKiLIC7wZ8ngoLOSpIVJtz26RQds1EyTxWHFFWBYdyxFbnhqmJDtLukocw5wOBzPbX12DRG8HjdkXmoLvDLdCuby9hmDamIyhFglVEe6sD0iy2HdF7Iw3qTE/r0Gzsi4gSti+xh4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1pbkyGS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1pbkyGS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2806140a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812369; x=1786417169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEfsGt9zPkqCVw+2RikdWiSpY/gxVUvhARG2RcmaJAA=;
        b=i1pbkyGSLT6STFxwXLR9X1SzuHhHEz1A1f/+wDPJuzBzl3tNVAe4BUr5dqJ2qV73+/
         CbE5OvqtrmRgrGpT1qBUn8nnCzaZvFX2ojBffAk5vhEL3Dzu3uu3quWLzcBueA1LBXlc
         /drLcGsfdOpycxb6RX893Cwf/7wZdmDnwZmfoQMyV5sQGeKxs9QqGJjAbTNH91a4Iql6
         jtnz+EJuSqdm9wReKDGEDEYw5R2TEeXfXPz9T29TtaVF4H28JZxJ8aQaIb5QeaLkft2L
         iDaeeuFwnozaawLLzYUMcXmIzCMd4RQVxif5rgg+tpABnRYt6aiBKdlMvHBqvIyHHLPu
         Z5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812369; x=1786417169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEfsGt9zPkqCVw+2RikdWiSpY/gxVUvhARG2RcmaJAA=;
        b=j+7DBl97fnHyvGIe43DjOzIZwEA/Fcpkeq5v5Qnyvl1pXHacSVo9Lw5FJlgK565SZy
         j5MaGuOwGfNyf+Swlvhe/K4f/mjPO45dLHFcPza7znLQ8wpctC1Y+0F31LiuTgXa4vjA
         Ogyg+XAv5ZRoIWyAjSKXXQBCuMkuzjP9YAmn9ylycfwArAQfoZCTg+qBmHcg/yaWbd4f
         FBU18l24GpIH/IGzvx3czpaBID3nzpiPdh3HhPiccFQMlBR9N+oMNZxezwKOEZnwBOZT
         EOWPP8Yxr0qn9gIqB8NdanS7xlW6mMGm1TVYNM4M9jQ5WYBRWqj/IWOY/iolgxK2y6cP
         79dA==
X-Gm-Message-State: AOJu0YxBh+DeSRfRrhEwBADL1sVddITKnn5Gqa0sg4t5WV9+vCdSZJ/T
	5tuvd5ijwB2aYqXjUzQ2X+F4oAQFfH5nxQf/cudQ2QmhRFZLkIOl9oheTH6Tef+Q
X-Gm-Gg: AR+sD11HPX97hLHJ1mckiKGNJYOia0o7WJVDn//oi43fSz3kY3L+bXfMVDnS3EB3e2w
	Hsak/5HjaxUK3d4HWi76ShqID0JOwjQMNl8UZGGpfmlLDFbSbQhhXU1d1tYONrvcMFzHWk2LBzN
	N4TZ+dDoYszLW0kE3Ay4lZLW/+d3T2sHtH/kNrdQgRHi8KRVUbcNfrxV3E2t/Z7Ns2G22z+Q6s7
	AAuxVXfpS2O0Q7VGU9slRpUOuUYlAaC+45QEXF/EX9fQx0xPtpGgtTN6fwlvXDgIWS3ACVFadIi
	AwiO8hZ7ERxF7ckdS+m1RdRZ9hF5U4RRo7OFpwNk4pkB4X41zNyOi9IcuBpNGP0RMuDT6MEkSa/
	gb+qkbXCdoRzISJM1S/0vlt4jZGCAQjFy0eISEwV9Yugn5dOH+KmyJxCvyobOObpeBImX5nkbko
	AmG+zo4LSiTjo0aAEOGhMYTwCtpGTcnegR3mVZ+AyrhTNm1LFCyR8NmoXsTvzjNYtiRw==
X-Received: by 2002:a05:6a21:3390:b0:3c4:3ada:384d with SMTP id adf61e73a8af0-3c92a57baf2mr11133346637.30.1785812368880;
        Mon, 03 Aug 2026 19:59:28 -0700 (PDT)
Received: from fedora ([2804:1b3:a8c3:8ee5:1c39:64d9:e257:73dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm35974758c88.8.2026.08.03.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:59:28 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH net-next v2 0/4] net: selftests: adjustments to ipv6_flowlabel_mgr
Date: Mon,  3 Aug 2026 23:59:06 -0300
Message-ID: <20260804025910.50145-1-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipv6_flowlabel_mgr test file was lacking coverage for the IPV6_FL_A_RENEW
action, and the IPV6_FL_F_REMOTE and IPV6_FL_F_REFLECT flags. The first
three patches from this set aim to add a proper test case for each.

The fourth patch proposes the adoption of "kselftest_harness.h" helpers,
improving code readability and conforming to the implementation of the most
recent selftests.

---
v2:
- Apply missing scripts/checkpath.pl fixes and other formatting
  enhancements
- Add new basic IPV6_FL_A_RENEW tests
- Put label after IPV6_FL_F_REMOTE test, freeing the value for a
  subsequent test
- Delegate flowlabel_consistency configuration to wrapper sh script
  instead of doing it on the main test code
- Skip IPV6_FL_F_REFLECT tests if flowlabel_consistency is set,
  instead of failing the test or attempting to change it
- Compare resulting error for failure assertions
v1:
- https://lore.kernel.org/all/20260727043516.93101-1-marcelospe@proton.me/

Marcelo Mendes Spessoto Junior (4):
  selftests: net: test IPV6_FL_A_RENEW
  selftests: net: test IPV6_FL_F_REMOTE
  selftests: net: test IPV6_FL_F_REFLECT
  selftests: net: adopt harness for flow label mgr

 tools/testing/selftests/net/ipv6_flowlabel.sh |   3 +-
 .../selftests/net/ipv6_flowlabel_mgr.c        | 504 +++++++++++++-----
 2 files changed, 387 insertions(+), 120 deletions(-)

-- 
2.55.0

