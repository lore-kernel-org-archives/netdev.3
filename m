Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EF481FAA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184826; cv=none; b=b1CXzXD/dEzDZ1krFzHWYyrGftUgG5/A568iH4Q6exhDJ24liFEh6sVYbkmYEwVwD+u9USKKZubxmf7zi0WdXuM+6oGh78PGRcj6lj8FcIi8JJmJaX9c0YiB83F+VSpnyCMGqS7nVNA3QMxMYMa9/9cSmFPhKeq0zVjv+hNJnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184826; c=relaxed/simple;
	bh=c6j/vB9CdvdjYotYX7FFWOlKVtKtt+FCEAYgInssYas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snPU9ghRR2uvErxzV0sUlJQu7RdVV6hpuFYC5tS9PCbxL80s3IslR28TukPoU7c34mCvRA+4gMuQLJh0BFLzLYhWvgDN/xmsnAet7gUl20QRdokOPjs6t9Kx6LfuGza0BaNQt4KiJa+pNEU0EQbDzn2fFeBhL/QtQWt1kv0/w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=xloLjshu; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="xloLjshu"
Received: from kero.packetmixer.de (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A2CFAFA13B;
	Mon, 31 Aug 2026 15:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2Ryi/QeX7FdJbC48aswsJlSSwRqMY+uinrprrTyKPc=;
	b=xloLjshuGQXZrUK9dBSgus5hnPemouYW6EhQhftHd/nKcz8Gm0hVjZygdg4J9GGOS3Ox1e
	mHBBoQqLOXeIuFLvwNSqxwO252TpdR8FjMmvwoDMCbj/v9+JYyXuQ2YMMiHaGjopZuiG0m
	iOy8ZBC3CuEzovdi5ejQrMG8pdQCNQViWFVTo9zneogEar4sgrOrRoIYqjQ4b4akToj1Wp
	Urp4KHeQQSkzyhVvms7EWVzHzngrALQfhtNCIQBjYFIybhfEyCU3G6PVXG+UnEve9Giyvt
	2yYLBxxt/zdtyoNfAjwlJJ66oxU04q2DEmx2nI33SWaUfyOz2LeSf0SFZBifFA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 02/15] batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
Date: Mon, 31 Aug 2026 15:51:04 +0200
Message-ID: <20260831135117.574836-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The _batadv_is_ap_isolated() is called by

* batadv_transtable_search()
  - tt_local_entry is the source
  - tt_global_entry is the destination
* batadv_is_ap_isolated
  - tt_local_entry is the destination
  - tt_global_entry is the source

It is therefore incorrect to document the tt_local_entry as sending client
and tt_global_entry as the destination client.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 68f79853032ed..88aeefa97db6e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2437,8 +2437,8 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 /**
  * _batadv_is_ap_isolated() - check whether two clients are AP-isolated from
  *  each other
- * @tt_local_entry: local TT entry of the sending client
- * @tt_global_entry: global TT entry of the destination client
+ * @tt_local_entry: local TT entry of one local client
+ * @tt_global_entry: global TT entry of the remote client
  *
  * Return: true if traffic between the two clients should be dropped because
  *  either both are WiFi clients or both carry the ISOLATION flag; false
-- 
2.47.3

