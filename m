Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94935290DBB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577874; cv=none; b=ULMa63YV6c+JyUChhgK/fsgudgsmLnRuTVQq85lDY3emEzLb4dRJsWQFS6ZYOJmyvYiFXMm81Di/2oZ0Mjtkf1mr798wh6y5Bwc999ebSjnRhBYgpDW0/Jm/ZIYPieAOccpl9xBB/rZWkUzqAw/JIv1OtkMVf23hu3pfDaYrIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577874; c=relaxed/simple;
	bh=zCcG0zycEcF5opS5BvS+8tk5FTqTS7tRZZEpnxTN1NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YfRVuWfnBh7AysS6G7+etKh4X8J+cw/FY+Oyt2HAaOwsyAhPwdBC8EeK11AFQSwa/Rj04MT7fLBj/TGsCNvyyj2uirqMD+gbB6xC1c6adTcVQtdQ0e0LO4XXEmMn/xGvrm25pQEbssSlmpQK6Sg+mXEtFSXOtK2PqfkCDdbMfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ksLpH5NC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ksLpH5NC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lxRMjpY6moeDrrxQnEZS/RUp5ZNpLvWccvW6bQxni0o=;
	b=ksLpH5NCEd2T2f8kbHPojy9FHxBQ9VDML4cjofnyEePgSaxiNx2w36t91jNGIkJcVevJb5
	LzndYgTuomGqblFC5H3NKsJMnIN8OumwDOejclp0X5oHXrmOLL/USlF6Bgpmh+2vDHK9Jn
	ZvNfI6KGF3doAwDuY2ZbCWq4yLTfTTw=
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
Subject: [PATCH v2 0/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Thu,  4 Jun 2026 20:57:03 +0800
Message-Id: <20260604125705.21241-1-fushuai.wang@linux.dev>
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

Patch 2 filters affinity masks to only consider effective CPUs before the
subset check, ensuring SF creation succeeds when CPUs have been taken offline.

--WANG

Fushuai Wang (2):
  net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
  net/mlx5: Use effective affinity mask for IRQ selection

 drivers/net/ethernet/mellanox/mlx5/core/eq.c           | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.36.1

