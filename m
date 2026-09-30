Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A54D795C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781792; cv=none; b=afBquST7bhKu0wB7+dPElreXxwIIpb1lePzlhV1jtDMTIu6JHmnZU/AYSAIGrSFjIChWfG7WpV2LinjfCIw1bWa1YR0LAz9XcsWr51S63gzRbcDiV+L1N4q4NE0leQ1A9CER7I47+k9Wy7agoiQDbORU0FyrH3yQSZKgo9ukjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781792; c=relaxed/simple;
	bh=9YozpNhCB6RxQb3vSIk33QuUlNnJvEgYENRshldeQTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5DydN1b3GLR1SCoZlFR+5fDVCVSM2lHySYAC6WUO+KEytZtfYquK4iK5YZ2J1sTQ+ZH5J3Y+KNjqXG6CnLSSZEkV+db2oAsYrwUcD8FW0m7/kNbYl3OgtAo+7Hk6SKl/MW0dU47i87y8H7NOsAM8QkxK5YF7YKAo2JQNdz4Cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=nJ5hOyqa; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="nJ5hOyqa"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so847138666b.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790781783; x=1791386583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t6cn97a2VxefS6h6oEWU5CpS/OstCxxYrDuVNoyCidQ=;
        b=nJ5hOyqaMtrdOhJnx3LQrdR1/EPkFtTMCcMUoxqs+Tga/SjXCFPli4pJnQaQEfpWi/
         UaD/5VD2OuUd/8xoyTKjT8uLp/OCsNwERaAK6T37ViOSXPRKBmrVEVNhgnv/NM/GGyQL
         R9iSMlXACssKNXv9z/KvIqTf9UDhCARb+RZln9tEyb34eqgVvnFDBSQixbsFwVzCkUwq
         yf6GgeA9jJHezubE7wOu3bZJqPXsADGKS2TNEWop/aQdmQ2RxtisSM8+2w0307hI62qd
         ZwGx8pvvkB8MKMyAr/N+CSoccO0C5V93nAgB74bpE/xUQvifiozFna2s3wtS9qTYHQci
         uSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781783; x=1791386583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6cn97a2VxefS6h6oEWU5CpS/OstCxxYrDuVNoyCidQ=;
        b=rvflC552b/7eZGFEXOOpZHEHypavlzBPhcQl94+zZybZ/6Pt/sDHCEtWLcJtQ21Gtb
         s/YezZXqbajyRhRIDckvyWN410Cxx7JnsqaFRPbQYXQNhXtmzkeDKLtwQVa3mtKnE/5C
         PQMHwd0BGUo1Axbc4cnNlQji6dqtz8Hly/0O5V35DFgG3Wozw80Wnq5BeT6kT+tpaPwN
         V/SAtEn18H1DhvFBJ69XDtfql+Kt9JALuHfxdDqN11I6PCKLeydNOcg4I3ChhDSR0+cb
         FA5fn3SpvdaYoXTCcmCYCXgEKAJ4xHPgaH++hNe182qqulaTCYhFVEPPEbNfqEokyHGq
         tZTA==
X-Gm-Message-State: AFq9FYKcjZ4sjSrYiX4L8gWdmVvbsUBAeD6iipTwmTrqrESagkgWFR9S
	4+oejs5aeQFIEwdUALz9WbUAJdtfpaW7sQuGNlrIw5WaOwSv01inStciP6rz+YmyKXmemXG0Dz8
	OrEFSnZVOj6H4rLCdDX0lnu8v1tadjbR9756CO8bICk243LZB7r7+9WF3VMB17OGocF9L/h6g9d
	G13+MSLRucCqZuJuqALLFimzLv5QjrJSUNGyCgDwxTpPM=
X-Gm-Gg: AYBFou3OeF7YGZ1VmQwpHNjy9M/eTAmfK5+m8Bzb8ExOVxnhu6tF5ZD2xHCY5jzUcVi
	N85HHlHBwuRhOK/doSZzf1qo7OhAEkrY7bS1gx+EtWmX2RQyZ0kzjS8GH0v9vcckruD3w3P4ubU
	ycOG1jNrmdmtD2rIoWwZuiJA3Cs0JYk58sh6iyWBE2X3DtPublcvssH9OiGl/DXjOlhOSTecyhE
	+/yGl3cHzWgB+7SJfr/adkQeimu98cNNZzz/A/DGfc2Frgb/riRnmgjOd35dWhhzL9K2Fsp7V2B
	7dSdPXww+CJpmX9vhSZqnbYb8c0WLQhcCblp9hkrrjjfxv/ESTNfVDJf4/zk/dciVWJBjitO+rs
	ZeUGlk2Vqm11+f1WA0YUJLE2v6nPr9dtusD9YoSdmjAoAFj5epRbjWhX51x2v8FfN94aZP+6mSJ
	Uoj0MlhSUReSpX4NrkJI/zwpC6itQ9QspPRXZpep1LeH6Q0Po6IVNDSdym4gNho65fUjzAFB9FC
	nE9XsS5YshQzi9peFcJCQ==
X-Received: by 2002:a17:907:3fa5:b0:c25:47a4:fedc with SMTP id a640c23a62f3a-c2e237605f8mr170086166b.2.1790781782842;
        Wed, 30 Sep 2026 08:23:02 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce6499sm23874966b.33.2026.09.30.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:23:02 -0700 (PDT)
From: hengyul@cs.unc.edu
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>
Subject: [PATCH net 0/2] ipv6: route: fix adding routes via the loopback device
Date: Wed, 30 Sep 2026 11:22:27 -0400
Message-ID: <20260930152229.1453929-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Since commit 21ec92774d15 ("net: ipv6: fix panic when IPv4 route
references loopback IPv6 nexthop"), adding an IPv6 route via the
loopback device fails in cases that used to work, e.g. when the
loopback device is down, when a gateway is specified or when IPv6 is
disabled on the loopback device, although such routes are promoted to
reject routes afterwards. The commit was also backported to the stable
kernels down to 5.10.

Patch 1 restores the previous behavior for routes. IPv6 nexthop objects
and IPv4 routes with an IPv6 gateway keep the current behavior, so the
panic fixed by the above commit does not come back. Patch 2 adds tests
for these cases to fib_tests.sh.

Hengyu Liang (2):
  ipv6: route: do not validate nexthop of routes promoted to reject
    routes
  selftests: net: fib_tests: add tests for IPv6 routes via loopback
    device

 net/ipv6/route.c                         | 29 +++++++++++++++++-----
 tools/testing/selftests/net/fib_tests.sh | 31 +++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 7 deletions(-)

-- 
2.53.0

