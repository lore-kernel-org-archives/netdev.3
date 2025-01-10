Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B31F5FA
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736469907; cv=none; b=FIolUEG8CU+o/LqUXQ65EvatNB5ifVEKYGhc6bcZ6GnoIk8hJHt5emPT35k1mJ9WNU0EclBkPBBqeQdogx+uRiAqrhtlNm6bD2QyYx/JujpWnOl+7DZDCVAz2AGeucLVbc1r4RB3m0WtWV9GhF/KvrwJAwQ7HxZYmqzJGokvPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736469907; c=relaxed/simple;
	bh=UYZHKEanUHLMCHTg1uDK5GieDZgOWRfAtRZmt98BJuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ey8e23G9aRh0bdrbiX17jPVmhUv1L6S8IaFue9oJUVDXU1BnCWIo9zjnnaS2aZiXvOZnCrmx87NgtHAYIVWCSafwqz6582oiW/iJNmsbfJ2U71CJSmxMHp7gC42rmEaTpKG4Nv4ZjRPoBeaSZW646m0Lt1kec76Se30anPFo4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEg7N+L9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEg7N+L9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3807C4CED2;
	Fri, 10 Jan 2025 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736469907;
	bh=UYZHKEanUHLMCHTg1uDK5GieDZgOWRfAtRZmt98BJuc=;
	h=From:To:Cc:Subject:Date:From;
	b=hEg7N+L9kC3xPnmnprPbpsLkmv6ESOrvih22h3yKeR14FMPpK8gkYmcYNDUIxy/Z+
	 dPL6fLlXv6pf9c6v4a8VtByXYb5HJkUJD59QkGio8S7tCU/Rf5EL6ypnRjSEMVnVfL
	 NZ5huED3Z4fQ4W5OZrcjq+5SioojsDnoDM17wEd7Y4qA86QoTgvLpI/wNRMj6rPBpj
	 390eRbgDkSmc+5NAZUtUhocxH/aoqRj7mrpTY6tjXZA2fihbzWJntG49Gb/AS9stVC
	 ZQt+kCBbFgRpObPhpZXkI83nA9MuApphcRxQZ09BPday05a2P6hgQyPIFum0KfoPQl
	 YHFoPUpKAYhPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com
Subject: [PATCH net-next] net: warn during dump if NAPI list is not sorted
Date: Thu,  9 Jan 2025 16:45:04 -0800
Message-ID: <20250110004505.3210140-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump continuation depends on the NAPI list being sorted.
Broken netlink dump continuation may be rare and hard to debug
so add a warning if we notice the potential problem while walking
the list.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This is really a follow up to commit d6c7b03497ee ("net: make sure
we retain NAPI ordering on netdev->napi_list") but I had to wait
for some fixes to make it to net-next.

CC: jdamato@fastly.com
CC: almasrymina@google.com
---
 net/core/netdev-genl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a3bdaf075b6b..c59619a2ec23 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -263,14 +263,21 @@ netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 			struct netdev_nl_dump_ctx *ctx)
 {
 	struct napi_struct *napi;
+	unsigned int prev_id;
 	int err = 0;
 
 	if (!(netdev->flags & IFF_UP))
 		return err;
 
+	prev_id = UINT_MAX;
 	list_for_each_entry(napi, &netdev->napi_list, dev_list) {
 		if (napi->napi_id < MIN_NAPI_ID)
 			continue;
+
+		/* Dump continuation below depends on the list being sorted */
+		WARN_ON_ONCE(napi->napi_id >= prev_id);
+		prev_id = napi->napi_id;
+
 		if (ctx->napi_id && napi->napi_id >= ctx->napi_id)
 			continue;
 
-- 
2.47.1

