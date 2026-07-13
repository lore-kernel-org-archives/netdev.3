Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5B41CB23
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948382; cv=none; b=CPkagQ2w2o4UZXESvvv9xs8PhFrK3awJ5llHe9pCwZGsZsotY39IIXdnai1fjJeGycuLYFZMTyd+tvyya9DoQlHTAx5TnUDXsHTkVhdcib2zATfZbtAdnt3lsCmU25kEEQsndMzCY6crXQhvH3o/y+gb0k0cEPEba06C5RmlaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948382; c=relaxed/simple;
	bh=956xMFVwozemfL7mtYNdI4SlIWWqBnG7b5uwkcojwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQh4EwVTPIE2ITKbr2LGdPgrmiiwy2Ukd7Zqo6P3BEVBfu9hdOeFDigUgE2ABjtJ9SfVgMfMAucN+ZlyCgWnph4xzxe62XzqF8rROwNofKZLRGldkzUwBXw8ue1hyxd1cQFcPbQS7zmOd4hk1wFZe+8QZ0gfMKlfsQHaxaxUEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xxxH5CWL; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xxxH5CWL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783948378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pD0xLc3ojA6rSvSgLR0YiYwMwbJS+q5TEOT37BYZouU=;
	b=xxxH5CWLcq93SQTzQ3VapDKG/5dTt2XnuRfj+FebtfGMQeJkv9/4LnBrPISkd/Pbs02mk9
	a+yjUhH0K/FLJmsMv6e4Jo8eOkwOXJ0L9FYw9UNv6J46EDT75zMadO38RjWQra3G7nvFUX
	Ea+VNjqJsy9tjbmZE/wiUqQp8dpbmeQ=
From: Tao Cui <cui.tao@linux.dev>
To: dsahern@kernel.org,
	leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH iproute2-next v6 0/2] rdma: display resource limits in curr/max format
Date: Mon, 13 Jul 2026 21:12:36 +0800
Message-ID: <20260713131238.955962-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

This series adds support for displaying RDMA device resource limits in
curr/max format in the rdma tool, building on the kernel uapi attribute
RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX which has landed in linux-next
(kernel commit 5911f6d6e7cc [1]).

Patch 1 syncs the rdma_netlink.h uapi header from the kernel.
Patch 2 updates the rdma tool to parse the new attribute and display
resource usage in curr/max format:

  $ rdma resource show
  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

[1]:
Link: https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/

Tao Cui (2):
  rdma: update uapi headers
  rdma: display resource limits in curr/max format

 rdma/include/uapi/rdma/rdma_netlink.h |  5 +++++
 rdma/res.c                            | 21 ++++++++++++++++++++-
 rdma/utils.c                          |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

---
Changes in v6:
- Fix the incorrect kernel commit SHA referenced in the uapi headers
  sync message (5911f6d6e7cc, not 5911f6d6e7ce).
Changes in v5:
- Split the rdma_netlink.h update into its own commit following the
  uapi headers sync format ("rdma: update uapi headers").
Changes in v4:
- Add a Link: reference to the kernel patch; re-send now that the
  kernel side has landed in linux-next.
-- 
2.43.0
