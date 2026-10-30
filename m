Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331250;
	b=kQCFUOzNbciwLKTXsPbhiAxmhCTL7YERJZFph8QiogNc2WZU566EzSdUQye8ylrQJWff
	 Yu2a7pwcYXQWX2Yyk14oMRZNgLTknhHJpT340VY0AjSpELbJEEMUMoE9qQxUtHcpLY7RV
	 PCUwAsfWGBvsoh+3Vt9k/XV7n4nuTEuGlxGgANDsDjQw5lyPmQlUR5I3DvywGolR3DYCO
	 3may3SQ2srAp5kaZh0MHNkFfT2NgMYi4VN0TmeVcVQDqi9sXAR/dVKOn2MLLdeYd3HIdS
	 i0gDF9hqxUODw6RpI1964g52zs9GpjLdJLU00pFOU0IFPE/rDMPn/2qv6iHBkSgn6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331250;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ut3h8Z3NwdR/pZ5OEt3IhKBu1YSO6/1hSwR9VC1HyvE=;
	b=fDBkqLA1vbjHUGmy+PqTTOyPI2wMBGoXKFtU3RlxqWpvM7vhh1z5jqVnT4/wG7ixWTTP
	 Mp+Nylh94aLjX05yd+79GS17c5HZJddBFiVxD/HfZB7UwrQI1X/NP5YG5OdPQhwYGp1HM
	 2pr8ejlPYnjvrCPRbVgbySTiERtH/Rp8Yt0GMMqeIaEsAKsHVz4YKSJYyWOGbAsb/kF89
	 jOAEdwbp8bYogQj2SsMHRpvY91BSV0VxqbOk3pc4a1vMcWIQq3sInQ6ByEMiYh+HirmZx
	 Vch09whHc6USeIx9WUuEZwMmtGQMpy0tUny/akRu4hg/LRsgd8Cd/wG/MawYCzNg8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=bYU65cA2;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2F606A31D;
	Fri, 30 Oct 2026 03:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C2F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=bYU65cA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ut
	3h8Z3NwdR/pZ5OEt3IhKBu1YSO6/1hSwR9VC1HyvE=; b=bYU65cA23VZZ7S0RdB
	0psX+ZY6Mk7IAlEztJe2kh8cLNGaaZ/Civ+2f5I7R/h7kausyourvSRJfhJwigkC
	YYPARAWxtKlnpTUiYRco5slU60bzDFHLuBRvq7maMoVSSTOTRLC494w5lQZpOFCV
	eikUuaTv4tPwtvxNyphE+ugUY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXv+kOEORqy4KnCg--.7858S3;
	Fri, 30 Oct 2026 11:33:36 +0800 (CST)
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
Subject: [PATCH net 1/2] devlink: param: do not dereference a missing param item
Date: Fri, 30 Oct 2026 11:33:31 +0800
Message-Id: <20261030033332.3685172-2-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDXv+kOEORqy4KnCg--.7858S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFW7tw1rtry3XF13Aw1kZrb_yoW8Wryxp3
	yUKF15Jw17XrWjvr4jqr4xZry7u3WUAay3tFy7tryYyas3Aw1vvF1rGrySqF4Yy395Gwn3
	tr1rC3ZY9w47XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0uWdUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRDbsmrkEBBapgAA3i

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
Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
---
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

