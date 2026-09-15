Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D1485515;
	Tue, 15 Sep 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469370; cv=none; b=XoPigupy/Dek0JP5eGgXyr3LSsnh25EFiUHjwmZF9TfVFtmMU0xjYHtn4wEB3Dr3dDZPDBqciy8yDTv0cXPzWpyvc355a6qfMAhw42+ycMngp1NTmp0cPQABQ7yZvnA4igmYrILFfe+05xYkqvTZ07ClbvXkaf8TMEmIDWR0m6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469370; c=relaxed/simple;
	bh=XgVCsOLjmbFb2z4XbqmcewTUrS6jdn/31WWVeWefKY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mFUnxGPpxgZvBdcdsg2UYjb6IiEE4zVI0EwsZICkDLSZZWH/eC9UJkOM0PEAYUyPk1T47SiFoa1UEezjEsodnP0BZUePhbuNEosjvnzyHRABn2a4Jk+Ar6Sry5BRBMoYrXIoPD5xGHzHw2xM2DOcf93cRwKIGlqbtQPAN4zosxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfhVli0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfhVli0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE2C1F000FF;
	Tue, 15 Sep 2026 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789469367;
	bh=zkMb2nJe0pkNxSEqKgHEYDu+NLnR17wL19N3I18TO4U=;
	h=From:To:Cc:Subject:Date;
	b=jfhVli0tUePEjbc4nFkld3qWTUs4nbOpYwZAn5/TpnyR38oD/mWAEEEhk1HnPUxz4
	 VkkHdNYEyYaRO41UFnUO24OmUgjAcEh1Bwvuc11Rst185wLDDv3KudmXUl6IG7aaYN
	 bWV9tZOCM+KvIDDVSBJlulJfwt1PMZ9ia3K72PgsbW9oBqpfL93dnDztTd53Sp6vvf
	 a8Yj+kqxV+F08UEySmbxq2RH+6fO5qPTbIF7erGNgX+m+7v2h2jXWuJIfbkj7ZVezd
	 B97qOSLZDow8omDgZ4JroDAePaZ/uKXpO7yhQQZeb6sKu1MKSpI0ZsHLKwBFnmaL9j
	 XqOhcV9+Z7Ieg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: [PATCH net] eth: fbnic: Fix payload page pool error cleanup
Date: Tue, 15 Sep 2026 12:49:15 +0200
Message-ID: <20260915104917.3978113-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The payload page pool pointer contains an error pointer when its
allocation fails. The cleanup path passes that error pointer to
page_pool_destroy() instead of destroying the header page pool. This
can dereference the error pointer and leave the header page pool
allocated.

Destroy the header page pool instead.

Fixes: 8a11010fdd96 ("eth: fbnic: allocate unreadable page pool for the payloads")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 401f8b8ae1ca..528d72071aff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1599,7 +1599,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 	return 0;
 
 err_destroy_sub0:
-	page_pool_destroy(pp);
+	page_pool_destroy(qt->sub0.page_pool);
 	return PTR_ERR(pp);
 }
 

base-commit: 18a6fe05fb6e18de29fa90d388bb34044114b3d8
-- 
2.55.0

