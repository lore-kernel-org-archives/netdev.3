Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083B400E1A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471727; cv=none; b=Voo6mtxBKAHMuu6octY+XTbeVCV+ft1aQWhnc1kDUn65Couhy1vfndSeF4yUqjQOdUqha8X2xXZoZUxVUcH2RDjHthCjj4+k4bzGP9Z/QayKFcaGg/lV7aaZjEPeGOkL38eK8np3PRqGCDuR4rTwprL2cWEPYW3VF7m3YGBKD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471727; c=relaxed/simple;
	bh=7klY1QUhcL+4MShkBnX6NQVk+G2YKNZtoaFNBtswftQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6C6339QcztbTldrlWuj6DgbsDk32UshdSom6TQJdvkVeHoQ5qSD04lkbWdiVzi4vECt1TIXU2uYBo6RPATFxSeHtWebekjAG6lzHFUwbfyJxycOBmvcVTyoaEAAJ0SjqQ0CLvVwYRXTMnnD/+xl3aQuGWaDmTeTFOsIIDVIqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiC7Kb7d; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiC7Kb7d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780471713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2eg9VVkZ9LKkV74LTCeL970klMGkJd/dvEy2RVfl6g=;
	b=UiC7Kb7dj0p+jovFsVML/VK1s0MCXab8+NY/xGsjFN/4Mq9KNLA164PKDShL7DDrvfJbx0
	8eVMmZ0Su0ZB0rIxpM88L5kbpPtA4tqRfaomGj8neSDh679NnY/QK1691E0PRSOyqLpzoE
	jgehy1VsLdZMCKj5/ykiKpyV3oiCPxQ=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shayd@nvidia.com,
	parav@nvidia.com,
	moshe@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH 0/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Wed,  3 Jun 2026 15:26:55 +0800
Message-Id: <20260603072657.10868-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

Hi all,

When an SF is created after a CPU has been taken offline, the IRQ affinity
check fails because existing IRQs in the pool may have affinity masks that
include the now-offline CPU. This causes SF creation to fail even though
suitable online CPUs are available.

This series fixes this issue and includes a small cleanup:

Patch 1 folds cpumask_copy() into cpumask_andnot() for better code clarity
in comp_irq_request_sf().

Patch 2 filters affinity masks to only consider online CPUs before the subset
check, ensuring SF creation succeeds when CPUs have been taken offline.

--WANG

Fushuai Wang (2):
  net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
  net/mlx5: Only consider online CPUs in affinity subset check

 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  3 +--
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.36.1

