Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBC30E82C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970594; cv=none; b=goasoNOddyCf+0b2i/CP2areDBoSNLZbaBLHGUZ0ASAwsodzWfU2VT9uEB8MHLwcZnDEFyRjRbkwcCx/dBUM+3GhNe7DpmCJe4vE/PIigRXAeiCINFQ7jCGlby0TzVdhTpKnpjCT4fgcyUI4yEti2sobFoM9L55blSHRzImIRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970594; c=relaxed/simple;
	bh=aWYeCrQom4M/G2brtCQECpyOxLUm4xnwxBFsoEZi158=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oe38wSKB/NuQviH1jOHjXCLikNQM7OKqHLKAreXmtbsnttpi4QwdavVpgeJjWELDoCbRu6QohnoO4MqcwyEMQTfiIOr/+WwYsAF/uWeAzuHXo1Elh3318JwqJSHHV1yXi58wGF4OoGVwsRrmOLVdxkZbt0BumFhFWDfHn+5wVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXYabgQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXYabgQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777970592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQfvp30cwfS1uivsGxfGaVYp4jepWjuZmklVHQFSbUc=;
	b=GXYabgQdOSEdKPXmU9XRCXGNfTJGyT+S6QNrijNagTmE8OQIkLHXNFAlov7FwLxK6Yqqjj
	a2wToZMhqWNxZ0VLxMo8QWlM9QvFEU1qCckYqF5zQgq3w0knyCWop2Ce1AsmOv+n0wxgKF
	QLPqOjgRl+O9vnyJLqoerkMcqlh2SyA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-ZdkhrZJfPyiqLf0uo_YXoQ-1; Tue,
 05 May 2026 04:43:07 -0400
X-MC-Unique: ZdkhrZJfPyiqLf0uo_YXoQ-1
X-Mimecast-MFC-AGG-ID: ZdkhrZJfPyiqLf0uo_YXoQ_1777970586
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2A819560B5;
	Tue,  5 May 2026 08:43:06 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.50.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D21719560B6;
	Tue,  5 May 2026 08:43:01 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list),
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/2] net: openvswitch: Decouple flow operations from RTNL
Date: Tue,  5 May 2026 10:42:45 +0200
Message-ID: <20260505084253.998548-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When RTNL is contended, network-related control-plane operations can be
delayed.

In such scenario, if OVS control-plane operations (such as vport
creation) take a bit longer, it's acceptable. However, flow installation
operations happen as part of upcall processing, executed in the context
of of handler threads. If they get delayed, it affects the data-plane
and can even result in packet drops.

Because flow operations also use ovs_mutex for concurrency protection and
given RTNL can nest under ovs_mutex, contention can be easily transferred
from RTNL to ovs_mutex, causing delay in flow operations.

In order to protect flow operations from RTNL delays, this series
decouples them from ovs_mutex. First, the flow_table is converted into an
rcu-protected pointer. Then two locking mechanisms are introduced: a
per-table mutex and a refcount.

The mutex protects the flow_table against concurrent modifications,
while the refcount is used to extend the lifetime of the flow_table
beyond the rcu read-protected region used to dereference it.

The following is an example of how concurrent datapath deletion and
flow modifcation would work.
Datapath deletion:

  ovs_lock();
  table = rcu_dereference_protected(dp->table, ...);
  rcu_assign_pointer(dp->table, NULL);
  ovs_flow_tbl_put(table);
  ovs_unlock();

Flow modification:

  rcu_read_lock();
  dp = get_dp(...);
  table = rcu_dereference(dp->table);
  ovs_flow_tbl_get(table);
  rcu_read_unlock();

  mutex_lock(&table->lock);
  /* Perform modifications on the flow_table */
  mutex_unlock(&table->lock);
  ovs_flow_tbl_put(table);

v3:
- Split in 2 patches (Paolo)
- Improve locking in get_dp_stats (Paolo and Sashiko)
- Use __always_unused in lockdep stubs (Paolo)
- Use READ_ONCE/WRITE_ONCE for table->count (Aaron)
- Take a reference in ovs_dp_masks_rebalance (Aaron) 

v2: Fix argument in ovs_flow_tbl_put (sparse)
    Remove rcu checks in ovs_dp_masks_rebalance

Adrian Moreno (2):
  net: openvswitch: make flow_table an rcu pointer
  net: openvswitch: decouple flow_table from ovs_mutex

 net/openvswitch/datapath.c   | 293 ++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 194 ++++++++++++++---------
 net/openvswitch/flow_table.h |  56 ++++++-
 6 files changed, 396 insertions(+), 171 deletions(-)

-- 
2.53.0

