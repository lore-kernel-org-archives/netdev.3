Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287981A6803;
	Tue, 16 Jun 2026 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573697; cv=none; b=ewNLf6drqEaw7sI9LdHiyKwWmCR6tR7qjUvYB9EtgJJnfpiJPO5wTzOYcku1DKkY2Hm7Io6xOk5nVpPJK2ztRWTP+AnzXoOjvXNMYst9Y+XQJLWzVMTTs+Krdoyk+dthqh8833eUaMsjN5ZTLoL5h9hQoggVLNvCYzt+s2QjrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573697; c=relaxed/simple;
	bh=WYV4koRPq1PmmyhNA3YZTY4oNmZIAQkKo7K0HHdslVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcweKhTLQjpyvCae5iaPHEte3jMsSO+xzjWRCzSIw24TVkB7Nz6DSLtLGYv6bL7d937jUV13SqxE8HcVQnhLZDrW67hkWhX/Gx44POPW+GCaH/fvyKQ02WnkazYoZSC0YcXqot6FJ1BlNb+7AQ301YwezS44ERclOqyfKAPWXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=kCxnGII1; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="kCxnGII1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d+
	j/xHKmzvqmS+TrPR4bqTM7CeIyRUkY+gr55pSNseM=; b=kCxnGII1a2b8r/pO7b
	xA/Hz88sjD14u5lZLS7PYvBufKiuPHnNWqeBFmwhSZbDfbrwLeey1uxaus5a/f/5
	jDEBwP0nfvQXur//U8oRyFdagLZ4C3+/If45AMSRz+lyim9dgzmECfPKtYwRDjJY
	EYVQyyF+iGLTndPRDRo12/8Ok=
Received: from zhang.. (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgDnD2wBqDBqX0J8AA--.25605S4;
	Tue, 16 Jun 2026 09:33:56 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziran Zhang <zhangcoder@yeah.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
Date: Tue, 16 Jun 2026 09:32:45 +0800
Message-ID: <20260616013245.7098-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDnD2wBqDBqX0J8AA--.25605S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw13AFy5tr47CFyDArWUJwb_yoWfCrbE9F
	y8ZF1rJa1kXF4Ykr4YkrW5u34Fkr9rZ3Z2kF47KrWYgFyDur1UJrZrur95JrW8Cr1UuF93
	AF13ta47CasIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNQTRkmowqASSyQAA3f

In ofdpa_port_fdb(), the hash_del() only unlinks the node from
hash table, but does not free it.

Fix this by adding kfree(found) after the !found == removing check,
where the pointer value is no longer needed.

Found by Coccinelle kfree script.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 66a8ae67c..15d19a8a1 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -1924,6 +1924,9 @@ static int ofdpa_port_fdb(struct ofdpa_port *ofdpa_port,
 		flags |= OFDPA_OP_FLAG_REFRESH;
 	}
 
+	if (found && removing)
+		kfree(found);
+
 	return ofdpa_port_fdb_learn(ofdpa_port, flags, addr, vlan_id);
 }
 
-- 
2.43.0

