Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625398;
	b=OyjfkbRIuOhp1SnN997Gx+UlOpuTWBgEdIREgcpDFYtYt3pDmzaxvtJm2DN45ADjFqht
	 /1SBl5sGjft0O5Bp5U0BZ+H2mwl85AFvNAEOTbqoLO9/xKjeOuI/U45MXBhVVX27elG2/
	 MLI6RiHiu2qe9MQnA6MdP+aBSnT2xGVoo5ulG7aXDjGSEF3qIrxTML6XQvKYOHPaPBYDT
	 vemD9W0sm0xa3/LpbJwj7Ke+r4yxnRWlNUjDyyyVt9TLUAnvNrwEnIQo1TTwKEalnYmTF
	 9Po24ZJ+p60fnPAefd8uCgVY3R/n5T4lSO07xtloXWs68QNQftyhiM1B8j2FckvgMDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625398;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=SkkH7x9s8JL3yN8w1k76EkVgY7lYJ4FqWf0PrknsMro=;
	b=vVpdI2bu9BnzWNt22XmzjPvwB4w5wqAoWLSmrYjVPVbSZxC2QpvY7lnJl97bjCyEfPCQ
	 CCsMBh/aQgFAPdkfz46K78KChxeXw9z6W6mJnIjTkPKpJhvV0oHnXnNfga8P4uZmV9JQ3
	 PvRY7D1rhB4ZnYmHRLuGCWxSbt8CIPc8T55vl9bnxXlj0tGMJ2+SVivF7SN65p06pglvC
	 XsIk4lZWWxq9crrS3vxDNhejD1HvufwPdtVgDeannBcxqV/4CemEPwjLz8DvWRVBpwI/I
	 7jzfth9JYq2UihacIEG9A8905LwPmjWd+uBeNIIYJSmmyfNao0TvnXkEvcxtGoOz5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=S3hk5Egn;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575B606A332;
	Mon,  2 Nov 2026 13:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C575B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=S3hk5Egn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Sk
	kH7x9s8JL3yN8w1k76EkVgY7lYJ4FqWf0PrknsMro=; b=S3hk5EgncOQvqjOru3
	QCHVB8VQ04NL4vd8lJXdvl5xKRpo+mOugHvvtYmWoIpaM3DszV1rSo+pPfUytm7z
	P8Vs6NzB+ydsAGJ4WJx7oSk2Rjmg5bL9cS+MShuu2NTScjdAVJ4jK1hWPh/E+6OM
	Play6z0P5I8JHL5qyeOs5/WGk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3dz_ajOhqBgW6CA--.35094S3;
	Mon, 02 Nov 2026 21:15:08 +0800 (CST)
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
Subject: [PATCH net-next v2 1/2] devlink: param: do not dereference a missing param item
Date: Mon,  2 Nov 2026 21:15:04 +0800
Message-Id: <20261102131505.611343-2-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wD3dz_ajOhqBgW6CA--.35094S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW7tw1rtry3XF13Aw1kZrb_yoW8Aw4kp3
	yUKF15Jw12qrWjvr40qr4xZry7u3WUA343tFy7tw1Yya93Aw1vvF15WrySqF1Yy395Gwn3
	tw1fZ3ZY9a17XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0uWdUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBwvBmrojNxoHAAA37

From: Linkui Xiao <xiaolinkui@kylinos.cn>

devl_param_value_changed() looks the param item up by id and only warns
when the lookup fails. devlink_param_notify() is called with the result
regardless, and devlink_nl_param_fill() dereferences param_item->param
in its very first statement, so a driver that passes a param_id which is
not registered on this instance turns the warning into a NULL pointer
dereference.

Every other user of devlink_param_find_by_id() handles the NULL result:
devlink_param_unregister() and devl_param_driverinit_value_set() return
right after the same warning, devl_param_driverinit_value_get() returns
-EINVAL. Do the same here so that a bogus param_id costs a warning
instead of an oops.

Fixes: ea601e170988 ("devlink: Add devlink notifications support for params")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
Link: https://lore.kernel.org/r/20261030033332.3685172-2-xiaolinkui@126.com
---
v2: reposted against net-next at Simon's suggestion; no code change.

 net/devlink/param.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index 95ac9db8c993..474fe009f22d 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -1008,7 +1008,8 @@ void devl_param_value_changed(struct devlink *devlink, u32 param_id)
 	struct devlink_param_item *param_item;
 
 	param_item = devlink_param_find_by_id(&devlink->params, param_id);
-	WARN_ON(!param_item);
+	if (WARN_ON(!param_item))
+		return;
 
 	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
 }
-- 
2.25.1

