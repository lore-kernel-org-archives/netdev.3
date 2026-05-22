Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474337E2E6
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491223; cv=none; b=O2vgs1OOHl/SCcNzCypJj6VKUuv75nJ6rhRTOObgyOmvRGikkl+OP4V1pXHJvecoGr5+67Vm+mzGEPyO3s5Sq/YFHLB1+y4vGcXYmeHmaLsj+MVUMAqgU8p/OTdNFqYXGQC5xu7ZnMNQj4Y3TSiE6h+MdZGfvftsYK8Acyumx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491223; c=relaxed/simple;
	bh=VHuekFtuuwBInoW8rnwmfFZANefl/pAEZSsrph9dI9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTXyYz7DOosDjf1rILLpc/HtxD5CUxCnPN0KPqAbwo42nKJXBPRl1rtbtn4/vUN8hrulbC5SyeCQiDgb9z6cXVmPMvX/E/phQupxhHnnraE8AAAFxY1agYL686jT8LdEUkmVi54OSR4VZq81oV1VwovUr5Ep661VhEwNSOPUtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYfI4Lp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYfI4Lp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDB1F000E9;
	Fri, 22 May 2026 23:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491222;
	bh=lXME3GH2qea3svR7EPFJCxTxYNc5dEqQVVNGS99A5kM=;
	h=From:To:Cc:Subject:Date;
	b=MYfI4Lp/dFiZGO8pQmAe29cveF51wN6ouafsd3mMStQDVkqcWaFD+g0BnvC1oBFxw
	 ot7j7qZ5QYK6PTX1/k4Zh1M85okaR9wrjC+xdQCGHIFvovXJNzJHu7eAY7DFkuc4g1
	 XRvUtrM87Hn96uTHSPsxtdFTCys3iEkLI+Tbehj7aCw+CfvaslVq+PFg3mIvR/gk+L
	 70iIEgjqvJj8JGEi5eQPRYTkkKyP3majufxECYcwiBmBYqdo1rUfXUTP1hNeiA8sj1
	 YKW3ZZZB6v5ejfB+t3E2lE4/6/1ClJMhiZwl8gd8904L+gXI61+DMUxA4CNJFdv4NS
	 HYx2Ldl+tUIxA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/6] ethtool: rss: fix a handful of small bugs
Date: Fri, 22 May 2026 16:06:41 -0700
Message-ID: <20260522230647.1705600-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a handful of small bugs in the ethtool Netlink RSS code.

Jakub Kicinski (6):
  ethtool: rss: avoid modifying the RSS context response
  ethtool: rss: add missing errno on RSS context delete
  ethtool: rss: fix falsely ignoring indir table updates
  ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
  ethtool: rss: fix hkey leak when indir_size is 0
  ethtool: rss: avoid device context leak on reply-build failure

 net/ethtool/rss.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

-- 
2.54.0

