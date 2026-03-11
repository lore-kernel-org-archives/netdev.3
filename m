Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A45733E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190873; cv=none; b=CYuNCrkZlvjGr167KdD0HCuxKP+tEDMv+sC0/8iO0PVD4mNaErCiklDjWZCxSqCYuKyRqTdwusj3rZgcmiAb75nCq+bE4RbfrQ/ZQLCjmSttgOK8wLFE6XL1QOi2skJjT8CfQu7MYTCJgAJVEqy9ojn2SKfrn0iJ6Jhln38laVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190873; c=relaxed/simple;
	bh=BRnvxecRJrtJR52VTI82H9eQekjTHMZcpnbZu9WnyQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdvHAxjBSLpeVmpirH25iFJRGT+jamZxe9wtL3pgdEZ7aAqvoN3zy6+aDxYUs2GhD7BgyqfsspFE49x2SryKcYN3b6fKa2jtQHGv5peNhPYfxFo5b5dT/Va5GOnPk0h+h7IhEqg5oEkdq+Z70B6U3NsuzxMI8MjjHUc3FO8hIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgHUGpls; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgHUGpls"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773190869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1zI0HjdpVIeLf9hsutuK6PY4JFf5qAhFtdlVI8aS1sw=;
	b=LgHUGplsk2p9syAn/wJWFocufn0GBEBbF/HLE+Hy6ni8L7uAVzEcVw7Zi4W98y97igwNd3
	ct3hRgGLQHsuKtE95Av+ETz/CnvanrSyODESwHGyblTNbf6APrdMKTbSSTKZRvOn7KUPk/
	Ju7/rXEFjmtKd1lL3Ymwc6MgnShnvxA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] cgroup: improve cgroup_file_notify() scalability
Date: Tue, 10 Mar 2026 18:00:58 -0700
Message-ID: <20260311010101.3306366-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Jakub Kicinski reported that after the commit d929525c2e30 ("memcg:
net: track network throttling due to memcg memory pressure"), in
Meta fleet, the network intensive workloads started seeing extensive
spinlock contention in the rx path in the function
cgroup_file_notify().

cgroup_file_notify() uses a single global spinlock to protect the
cfile->kn pointer across all cgroups.  On systems with many cgroups
under memory pressure, this becomes a bottleneck as multiple CPUs in
reclaim call __memcg_memory_event(), which walks the cgroup hierarchy
calling cgroup_file_notify() at each level -- all serialized on the
same lock.

This series reduces the lock hold time by moving kernfs_notify()
outside the critical section, adds lockless fast-path checks to avoid
the lock entirely in common cases (torn-down files and rate-limited
bursts), and replaces the global lock with a per-cgroup_file lock to
eliminate cross-cgroup contention.

Changes since v1:
- Second patch moves rate-limiting code out of lock 

Shakeel Butt (3):
  cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
  cgroup: add lockless fast-path checks to cgroup_file_notify()
  cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock

 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 53 ++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 25 deletions(-)

-- 
2.52.0

