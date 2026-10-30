Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331248;
	b=FopJuP6MenJo8p8ho86k1nLyCCmAHXYUuXbdYouRUjR4jFdTwuY+sO7YotjnsiksonWa
	 CwyfEXqmHb/AbuRqCFNLRFCPC+rFqIq8hsvE8aUmIC8+YlViKQPo7WHkiAqv2P3DrXPTn
	 WCRmv5w60CTLfOd2mcQLSqwqvM+JpJQHPCznJV4ElH5opV0vlZuCqv5OtPbDeNn8QpoDK
	 4Ha8+lj9o77SgN5IWSeI5kMc5mF1HpiOEQiCymR/Qytj3o4S0YixmSaOU8mTdzgXY9ZSo
	 fwIcLCSzvMNagPGTt9Wq5qW2+ddOl3LuUqiXIBFOQgBHmXQDpzkdD8YSYsHVJGhNnsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331248;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=p2FEMna2P+6C5i2YOF81S1qd5LWBm/ktIzLDhNULFgQ=;
	b=CuO07DTfRcZ+fbYTC3oW0yWWeRGTM5HaNuEb/bQpwB411ZISX6MPjl7hqJmRD0NCqYv7
	 Onknu6gxWpCBZG42J6l7VOpj/tsSbkGdBbk3s4TflPS3BULfRcgwflR+NhvCd6m3bKTdY
	 lcilKmGYpYR3W5cws+GyyzYEygig02EZglpahNXKD3aHvZMvFRaVGrSi+UBLORVD4GQAK
	 303s/8TCAdjCKgbziLjCSocE/SjGTp2WDeZjXV7bDiI8q20SjfJfFfDnwwEH7HuUFDznk
	 WT+SHUyEdEjBgFgQnUZX99ix6BhRi0VSQ5eojxYoB19CVOkElZW8JoiYNI84vhzP1wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=VzRjhoYG;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1EE606A31A;
	Fri, 30 Oct 2026 03:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1EE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=VzRjhoYG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p2
	FEMna2P+6C5i2YOF81S1qd5LWBm/ktIzLDhNULFgQ=; b=VzRjhoYGMRF+f1rxfU
	gYWf6LmLxvf8ZmC33Ot6Dix9UTnpKX4AA04viLkY0wdj68AcoUtOlm99Jund7NSu
	LAQ/VVcwUvdoEpHumA4XCkowiAn+Ii8RxIw4jDFomaz8IyywDfM+e1RWmYyWnpaC
	bQfSI1cQRWCHuC7YmsFdDNkxg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXv+kOEORqy4KnCg--.7858S4;
	Fri, 30 Oct 2026 11:33:38 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net 2/2] devlink: sb: do not dereference a missing shared buffer
Date: Fri, 30 Oct 2026 11:33:32 +0800
Message-Id: <20261030033332.3685172-3-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030033332.3685172-1-xiaolinkui@126.com>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDXv+kOEORqy4KnCg--.7858S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry3Ww15WF4DWryDKF47twb_yoW8Gr4Dpr
	W3KFy5trs2qr4vvrsrXF4DWFy7u3W7GFW0krWak34fAas5Jr92qr4SqrySqF4UAFs7C3Wr
	Zr47Ga1UuF47Xr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnXo7UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBLbsmrkEBI18wAA3l

From: Linkui Xiao <xiaolinkui@kylinos.cn>

devl_sb_unregister() looks the shared buffer up by index and only warns
when it is not on the list. list_del() and kfree() are then called on the
NULL result, so unregistering an index that was never registered, or
unregistering the same index twice, turns the warning into a NULL pointer
dereference. list is the first member of struct devlink_sb, so list_del()
reads the next and prev pointers from address 0 before storing to them.

The register side already fails gracefully: devl_sb_register() returns
-EEXIST when the index is taken. Make the unregister side symmetric and
return after the warning.

Fixes: bf7974710a40 ("devlink: add shared buffer configuration")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/devlink/sb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/devlink/sb.c b/net/devlink/sb.c
index 129bd016e302..4b444f2ca0f5 100644
--- a/net/devlink/sb.c
+++ b/net/devlink/sb.c
@@ -980,7 +980,8 @@ void devl_sb_unregister(struct devlink *devlink, unsigned int sb_index)
 	lockdep_assert_held(&devlink->lock);
 
 	devlink_sb = devlink_sb_get_by_index(devlink, sb_index);
-	WARN_ON(!devlink_sb);
+	if (WARN_ON(!devlink_sb))
+		return;
 	list_del(&devlink_sb->list);
 	kfree(devlink_sb);
 }
-- 
2.25.1

