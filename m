Received: from out30-87.freemail.mail.aliyun.com (out30-87.freemail.mail.aliyun.com [115.124.30.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0096325727;
	Mon,  2 Mar 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437037; cv=none; b=ah1zmDo1nyJJ9yGPrr9+5W7eGfKa3x4SO6oHDC6+dSAcLjPl1B7xYUe0zwdw9O4bFQNBLTlOXxdLeQZOWu+x6sLWc9vv1msGwNqmofJgj5l6mif0WUkYGI1avm7fdavTy5BbdQcR7Q7pN9HN/GgB83EkD04uq9pXHWVrA1GU+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437037; c=relaxed/simple;
	bh=brnExaj1oQAVF/5Y4p7zhMF9Yv6s4dCcgw4Fe3zYvIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i4oyxRO8+8RVx3hctLrsGJcEeAnJd3ybtrzt0U+Ml1jGs2Ymag7v1kUBQM0yt8qr19vpXn54PRk1cO/+xCq96Hb/occfzcXTsTnNM6aLeMXi5FXgNIEL2I/565EOoAw2Nm2ydEjcVows/jOIUpd4vRbZut4mpRBzS68O6o/Akic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=XG4uOi4A; arc=none smtp.client-ip=115.124.30.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="XG4uOi4A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772437032; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uSf6P0bDTSshvk8ZcHeWOFwTq1M7/DYqiYXjmlaPg6k=;
	b=XG4uOi4Ao+0p+5ssZlTM/I7u9X8wDexyIU8g+wc772sgr+3tzipNB17C3niq8iLA9ifUwHgk0trGCwG4kagS6q1et22KV4tjUY4HkFwUENB0m/KZXGm/bmH/fZGcU9Hh4CHaeBVfbtd5VPnv+1z5w1PmTpYU6odUr+ax2oB98ME=
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X-284.M_1772437031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 15:37:11 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: edumazet@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.6.y 0/3] Backport to fix CVE-2025-40170
Date: Mon,  2 Mar 2026 15:36:27 +0800
Message-Id: <20260302073630.988982-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Eric Dumazet (3):
  net: dst: add four helpers to annotate data-races around dst->dev
  net: dst: introduce dst->dev_rcu
  net: use dst_dev_rcu() in sk_setup_caps()

 include/net/dst.h       | 34 ++++++++++++++++++++++++++++++----
 include/net/ip.h        |  7 +++++--
 include/net/ip6_route.h |  2 +-
 include/net/route.h     |  2 +-
 net/core/dst.c          |  4 ++--
 net/core/sock.c         | 16 ++++++++++------
 net/ipv4/route.c        |  4 ++--
 7 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.43.0

