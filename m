Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625351;
	b=oc+2coNrT4B+TrGqr3HG1CwAhUAvEYA+U1/pYmz4tbDuMeSkvEncff1EoQbRfNFRmNdC
	 7oPR+QlVjsjxMs2pwb4QU+VbcdwNcDjgqm8bNQVGZa8bMmk2AHUbc/bvokPvVllEGOxPM
	 Xf9X2JYsMOmW7YWx8q7M0QMTGoC0GOEhMcQxUe6EU1Jk69SdfZKCktWOD/i1A8Z8ySrM2
	 qsv5hlxOOljJ/CWx0zvqB40qIsiHYnvbGhz8VXnpODr/Wo6V2O1Aie2W4n0WCcahGLTSJ
	 3cXePKrO5AP06rVO1MDruD968Rmm5FDzcZU5m0JeVRikon1IvgugFU9GnMZRyEU45Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625351;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=q5gOSQTwjcGAuDj11IrSY3MJInlxkZ8bylF2TvyJsQE=;
	b=hFzubP9AVASZhcfqw4McIHuMNWPr9yCe87gtyHZoCbPyEnsftOJBraMLjc2iDMo/GGzn
	 vcd6jF+OzJ+9d4lQgrYWpmpUmtFH2fY0ZekLdu4hlKILxJkkOY5wd3W897rqxL0lT9smZ
	 0Lf7MV6Gr8meolp9dcPuS9fKfOWQ+yFxSuMx45DRAeMKE9ibw1/6LcG36s9UDqfpvn4m3
	 4uUgSwqHykaaXCUb2nt0P4GNWpk3tN34kOUvjFqJKjxtF1re3L/5Dq/hKEnudxG/KXg6d
	 ymzHjeXn/uXx8Dy+nBHdVhRAsKE0ldJIsbGpybYLcCdoj2ByHgkb0B2K1DSGQC/6fUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=gE1jVhxR;
	arc=none smtp.remote-ip=220.197.31.9
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB90606A331;
	Mon,  2 Nov 2026 13:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB90606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=gE1jVhxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q5
	gOSQTwjcGAuDj11IrSY3MJInlxkZ8bylF2TvyJsQE=; b=gE1jVhxRSiiAtOhBxm
	kCVy4JVLvTbf5rB0A9nWeC7YavlAMDPs73g1INfv/wYaIszkDDzh7KlIK6t1El8C
	shyPVFQtVWGEfiu6vnZEX+PWllBTKSM1FRXP1auuf8Yl7SGTbDs4rjfabQm3RLtX
	ZQ3RhGGIbZqd6X69/5En+1YpE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3dz_ajOhqBgW6CA--.35094S4;
	Mon, 02 Nov 2026 21:15:10 +0800 (CST)
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
Subject: [PATCH net-next v2 2/2] devlink: sb: do not dereference a missing shared buffer
Date: Mon,  2 Nov 2026 21:15:05 +0800
Message-Id: <20261102131505.611343-3-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261102131505.611343-1-xiaolinkui@126.com>
References: <20261102131505.611343-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wD3dz_ajOhqBgW6CA--.35094S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJry3Ww15WF4DWryDKF47twb_yoW8Xw45pr
	W3GF98tr4Iqr10vrsrXF4UWFy7W3W7GFWj9rWak34fAas5Jr92qr1Iqr1SqF4UArs7CF1r
	ZFnxGa1UuF4UXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnXo7UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqR4vBmrojN5jAgAA3v

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20261030033332.3685172-3-xiaolinkui@126.com
---
v2: reposted against net-next at Simon's suggestion; no code change.

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

