Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF8279DAF;
	Sun,  2 Aug 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684926; cv=pass; b=YspJsS2tn3r6tU5c7S+kU9e6Ry428cdfQ46NY9Umz7VMDJ6b1+E6tQaf9aH/A61W5WX1TSRnpVjKyi18VNNKCCkS8p6byMbpSePg+d/lQmKHkeWtv1v/Y3NM19/EODbTKDbPeOsgo3r1X9OTyhvzTovgiJlwgcz6lSlkVgECVMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684926; c=relaxed/simple;
	bh=PDGz5SCrNMVMophBcN/bHG4ii6nob+gN+d42GATqpvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syaGtwEk5IGWUSdnqWnZevplJzg6ZsR5qp2aSsIo9xjfn3bllLpaXQMVPO5lh+8MRg76xhiX/Fg6rlMrfWJx7gFV1Cs3C99dpuy2w31PeA323BDuZ0SnBg5NQlPKfrJOTySTYG1K9ZtSUrYEszXLb10XEyJgAPOUZRKSISwxdGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=nvXwyhkA; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="nvXwyhkA"
ARC-Seal: i=1; a=rsa-sha256; t=1785684908; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dfTra2xGHjl/sJI2/LYQpkhlARuNM5ryH2xPvfHiWtSflnzyAmC2VUh1WS6wBGkoYWx5vKheQUJBi0IGW/MaOFJgJE6PFTTjsir5synJfJLqRAGGVF4LWqL+Pe3LA4iqfvfCLphYIMHz49vtrrCJ5FG33KUkcmzTA+I89jlBLfg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785684908; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cmgEGoplnbvSfAkNyhcKMAQlyjAwLXbvBJhyNzcppgY=; 
	b=PGXA1eseNmNUDUgqzUWHeP75tfruqDfXSDKbiqZB0MGjxKQ7c5vJBQHlkxRl01OPqHLDpZMmiN8zn8lU9VJ2nuwfto0MrSLJYuroa3336OM8cxcjwv20+Vn60IUaWExI8oAMvM0HXtXPPHVZICmrMYdw+1xaxA3vYQyHCMzQO1w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785684908;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cmgEGoplnbvSfAkNyhcKMAQlyjAwLXbvBJhyNzcppgY=;
	b=nvXwyhkAo0ow9xZ48vACUpnqRsJ46Y1JEONNjL9GFdM9zs1EFlLZfogfNwDnfzFw
	VaUgD6bTZ515yWJiKUSMWe1QNVVF4NcfJ7WGoeBkFa+6d9QaXiMiey5+Vx+46pveTv+
	rz0xzE5CU2gZuVZaBY3S9ua7AS7RuI+7qU/D5ucc=
Received: by mx.zoho.eu with SMTPS id 1785684904626902.4824537208609;
	Sun, 2 Aug 2026 17:35:04 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: wait for pending node-free RCU callbacks on module exit
Date: Sun,  2 Aug 2026 15:34:54 +0000
Message-ID: <20260802153454.44247-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731192545.176969-1-ali@iusegentoo.com>
References: <20260731192545.176969-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Please drop the Cc: stable from this one if you take it, and I would
rather the changelog was read as hardening than as a fix for something
observed. I overstated it.

Going back over the exit path: hsr_dellink() deletes the four timers with
timer_delete_sync() and then queues every call_rcu(hsr_free_node_rcu)
from hsr_del_self_node() and hsr_del_nodes(), all under rtnl. The
rtnl_unlock() at the end of rtnl_link_unregister() runs netdev_run_todo(),
which does

	/* Wait for rcu callbacks to finish before next phase */
	if (!list_empty(&list))
		rcu_barrier();

so the callbacks queued during teardown are already waited for before
hsr_netlink_exit() returns. netdev_wait_allrefs_any() calls rcu_barrier()
as well. I do not have a case where a callback survives that.

I still think the barrier belongs there. Documentation/RCU/checklist.rst
asks a module that registers call_rcu() callbacks to rcu_barrier() before
it is unloaded, and net/8021q/vlan.c, net/sctp/protocol.c and net/ipv6/sit.c
all do exactly this in their exit paths, vlan being the same shape as hsr,
an rtnl_link_ops module torn down through rtnl_link_unregister(). It costs
nothing at module unload and does not depend on netdev_run_todo() keeping
that barrier.

But that is defence in depth, not a bug I can point at, so it does not
meet the stable rules. Happy to resend with the changelog rewritten that
way, or to drop it entirely if you would rather not carry it.

--
Ali
