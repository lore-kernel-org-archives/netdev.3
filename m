Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFE356765;
	Wed,  8 Jul 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490798; cv=none; b=nMA9js67wwVSTvZelGdh2cf6tMvZf7qQiBRi3L6ET5Rijys2zFADhNXW104/87KRCH0GZH9EEsMRFzJqG5dNlxVzaE3yGkscm669YvpZIPXp60LUExzzt0+GE748i/8srrE1KmuH4qa7NOf8OSse9C+Gl8KopjAVHHpcCe42Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490798; c=relaxed/simple;
	bh=+DR0Vd/N1HbPH+tl653IE8znn3Np9S8ELM3IGKflUjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YF/WL1uMsnjoZXSrrCiqtgUieeKGH8lRgV4ZL1HcEWuvWe6GefuLEPC3mqciePF2xrqCBUL+OLLENlzlqODsAf9zVUNCf+pYYr7iOeyS4SzwdFpvSVL8azGiBAUKePAYz4nDYx6z6K4LS4dUHX6i8nqMZux5CUcd8OwvJTqkJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p59YpYxF; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p59YpYxF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783490794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBH/iYWDgg2fjHB0n8MaHNuUv23VWE33006Snrd0C+c=;
	b=p59YpYxFB5zx88zzCxE7YayMoP3jQriQpAbYYh86Ajt8TKtBfSqGHWYmy4rj4a7x/OiFdu
	NCaVQRp7KfCfdT4dLXyqEHO5tNmF63A2y0yH8mzhcqiyJq1x2Fhzh7n9LSRV5uObGjENla
	+qFbqCdEhAzgg/3/zKl5DYfmNcLAmpo=
From: xuanqiang.luo@linux.dev
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH net-next v3 0/2] ipv4: update rt_flush_dev() and two dst.dev readers
Date: Wed,  8 Jul 2026 14:05:35 +0800
Message-ID: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

Patch 1 makes the rt_flush_dev() write to rt->dst.dev use
rcu_assign_pointer(), matching the existing dst_dev_rcu() readers.

Patch 2 makes ip_rt_send_redirect() and ip_rt_get_source() use one
dst.dev snapshot throughout each operation, so a concurrent rt_flush_dev()
update cannot make them use values from two devices.

v3:
- Split the rt_flush_dev() change into a separate patch.
- Update PATCH 2 subject and commit message to describe the actual scope
  more clearly.
- Drop the Fixes tag.
- Fix local variable ordering for netdev reverse xmas tree style.

Thanks to Ido Schimmel for the feedback.

v2: https://lore.kernel.org/lkml/20260701032434.17500-1-xuanqiang.luo@linux.dev/
- Use dst_dev_rcu() and dev_net_rcu() for the RCU readers.
- Use rcu_assign_pointer() when publishing the uncached route device
  replacement.
- Slightly adjust the commit message wording because this issue was found
  by inspection, not from an observed user-visible failure.

v1: https://lore.kernel.org/all/20260630094250.29386-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  ipv4: use rcu_assign_pointer() in rt_flush_dev()
  ipv4: snapshot dst.dev in ip_rt_send_redirect() and ip_rt_get_source()

 net/ipv4/route.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

-- 
2.43.0
