Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331084;
	b=oHP8uqZXQqkOYJFActsQF4i6HmcfPhcwGnNxC7WW7yRwP+nLRqMh4ZbeQSPObJGUgr7f
	 pU+rnGXTJqSrOPX5lOm2jVaNFJAof+ulneihXFsZO2YhkU7U5rlprIFJLpkJ/mUYqfQsu
	 tcUq1+jKtHVEuhAxIjKJkRzCuSWCoIJlUVXjkfIjV1PP/atAtw5sQ97Y8Q6GObH/TdJ4R
	 hDcc/P83eNOaQS8sZEYbujX3y/Jd25GyzqK+XFmsRWFFBZdXQz+sfIX7Xmx0721YAA9nX
	 N321Wa6yEoVs7oXVlnmDxizN12SkuamvEERxLQx3BUHjXu5vID/HNJlO1dylPIilY9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331084;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8ktqWfSef3AXz7FND5pOxckiQELIeSzD/uEmAhKFSN4=;
	b=WWWXhRN51Jcz1CFz0sBUL0R1AKNkumikq03q2Krbs7csA6GKDp3OFghfgIKp5+XJZ4Vm
	 /1KK3habk/dDO7wtuhdvYJPgxk7MGCzvuWaVZjIfMVypAO89IwMdHWAY6W4vBUR5csVo2
	 T6LcQFyV7TKWbpaO9Ye7atqwoZbJq8SfecD3U00P5KYCfWMxDqcIy3ny8isukb2AlwDc+
	 SPfFfpACeKDOt3CJbLW2vhWyNZGkkwnQkts5FqILYsqJbMXNwv8TDF3Wu0blARM4VgFHw
	 RCGj80NyIaMdfpKMw4NFVMW0mpK3RKGfolIvgdlteXKvWwkcZEElftYLInS0fFw2r3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qP4XW4f2;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DB606A31A;
	Fri, 30 Oct 2026 03:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=qP4XW4f2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8k
	tqWfSef3AXz7FND5pOxckiQELIeSzD/uEmAhKFSN4=; b=qP4XW4f28Uio8qY3Q4
	sZfIiClVGpIuaQKGgHQH/8jZFEgSNsfk8jQNPBb2kEhpReEQ+gs4wZ5NJFGen/3h
	xuerkNRat0t1ghnobMXMOMyqJngV1+dXv4xXl+Wb8GTWG5dQt/a6i0ibLv0Osi2p
	M01oBLhgBlrnYxIZFbXM3/vvI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDn7+djD+Rq5VDKBg--.22802S2;
	Fri, 30 Oct 2026 11:30:44 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net 0/2] devlink: do not dereference a missing param item or shared buffer
Date: Fri, 30 Oct 2026 11:30:39 +0800
Message-Id: <20261030033041.3679526-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgDn7+djD+Rq5VDKBg--.22802S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF18Gr1fZFyUWFyxuFyUJrb_yoW8Ww1rpF
	WYgFn8tr1DtFWvvr4kZF4xZFyj93WxG34FkFyrtw1Fvan8C3s2qF4Utw4avF4Yy393Ww1j
	qw13Zan8uFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlD7-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlASwh2rkD2QmmwAA3-

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Two devlink helpers look an object up by id or index, warn when the
lookup fails, and then pass the NULL result to code that dereferences
it. A driver mistake (a param_id that was never registered, an sb_index
that was never registered or is unregistered twice) therefore costs an
oops instead of a warning.

  1/2 param: devl_param_value_changed() hands the missing param item to
      devlink_param_notify() -> devlink_nl_param_fill(), whose first
      statement dereferences param_item->param.

  2/2 sb: devl_sb_unregister() runs list_del() on the missing shared
      buffer; list is the first member of struct devlink_sb, so it
      reads and writes through address 0.

In both cases every other user of the same lookup already returns right
after the warning, so the fixes just align the remaining callers; there
is no change of behavior beyond avoiding the dereference. The param side
follows the example Jiri set for devlink_param_unregister():

Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/

Both Fixes: tags point at the commits that introduced the unguarded
WARN_ON pattern; the current devl_() functions are pure renames of those
originals. No in-tree caller triggers either path today (the audit is
part of a defensive hardening pass), so both are aimed at stopping
out-of-tree drivers from turning a driver bug into an oops.

Linkui Xiao (2):
  devlink: param: do not dereference a missing param item
  devlink: sb: do not dereference a missing shared buffer

 net/devlink/param.c | 3 ++-
 net/devlink/sb.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

