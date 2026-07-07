Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59C36A36B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436022; cv=none; b=FtFBlTnMnvAHmpZNUSnWp6HqYpnNwHYyKKR/5yeDa2RUvSjfrg75SfE9F+dkUM2FnyZ0yW4SnST1bgCS2LXtz/X+Qg36Qr6YPE4VlfOliX0YTVN2oA7SmfrJuh4Z9dSlL0o3hUKLe5ksn4f13wSHlzPVOA1/bCM4gtgbv5TuCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436022; c=relaxed/simple;
	bh=osaGdjArtpJWLzu0yi+aN5O+0HoNHcR67ZR49rDPYDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/AERF0tbf0F6kghDaF7gFxfzZWfBPcpv8/Htrg8CQGWK4aVSSLhHYZYOeRmM0HIFIGNIpofKAH7Csl6A8+Svkx6LZSt320pm+GO48F0PQr614bdxrCpdQXipcIUhcJFv2W/n6DpafaKtzjEmyM1oHyTFz86NiN4J09AM5H5xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLVko+q4; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLVko+q4"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-92ec91dc265so32958185a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783436020; x=1784040820; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Rn1CPVIm/kcrdcA/343qIPnjy3Ljcucz6cHAS/OoXA=;
        b=iLVko+q4D5pAdW7hEIco+Evb0bCcq9XEtmyzTkba/rzl5wMgE+y5Bonb/sfG5QG8eb
         Q+6J3KNJ1NFRpcoFDxMVdjqBkA6gPA2so3U3SzompVBgfBXcDfhN2ypaI+PyprNhCXFP
         kOapRvb0SxEQjtQ3z/5WVd8LNW5UUNbuLfI8zJthaoFs2rJnki7PHXCWiu6taHXKJxYm
         0RbEDiN46A4/HBchTL9Nq8WXGcBYOpJqrG3ZLiS/qLTRVbUNuRhbjEMvDB97sLHA8rAY
         1a0A4YX3FAHVqGORhEcyQZ94IM+Yc2vdYJaHt+Ss6cC+FmCqTcAC8qGh1Lrm1MRSzuzs
         pBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436020; x=1784040820;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Rn1CPVIm/kcrdcA/343qIPnjy3Ljcucz6cHAS/OoXA=;
        b=MgLefG2lKFybGxPjz4SFaiIm+FrgD/ESbvBnJci74TRFeeWTDNgT1+YXh4QAGDSeWi
         Q3gJnNBjQYQpPUr19boXrH1CT7iUDGlJLQujh01EnvnP/HmT8uyQmGi5aCsmxmlEirm0
         NJsj3AdQT9tElqCL/RY84cJHNk6PMhUlVP6NbYF4NpyxWsTK/Fg1/bnEDlRvaWxhgciE
         YYji1BTrb3N7W4DJ2wsyhOcIrNo8VbNbAwyUcshVm9EL9gArQig5OK2Gc1+gIQX+uBAz
         hwyDSsDq8SkakPKE8piQPuuv5CAvPxYjUvyvSytgm5D8kuk903P2AIDjUK3Tcqkc2VO6
         w45Q==
X-Forwarded-Encrypted: i=1; AHgh+RrlEfeN24hLPHVYTlrAenI6JqX0eElhUko66RFtTzgK2nNSP2dXLomFzH8+/3IK2vbIaGlqJ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhyzTwwmHKF6u8hWDiiPUtkriGxN8qpR11bmbuZIL8XuZNyGy
	NuC5a9qyr+8a4empXEoYJd2ETktRlxc2kHfOhzwRAu+de27ksfS/02ajqBP5czBkY6ecqD9X8FA
	STY4Uq/KDU6BPMg==
X-Received: from qknpy20.prod.google.com ([2002:a05:620a:8794:b0:92e:6cbc:7641])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8808:b0:92b:67e6:8ac2 with SMTP id af79cd13be357-92ebb6102ddmr619190285a.60.1783436019950;
 Tue, 07 Jul 2026 07:53:39 -0700 (PDT)
Date: Tue,  7 Jul 2026 14:53:30 +0000
In-Reply-To: <20260707145331.3717941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707145331.3717941-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707145331.3717941-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] geneve: make geneve_fill_info() RTNL independent
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that geneve->cfg is an RCU-protected pointer, update
geneve_fill_info() to read the configuration under RCU read lock
instead of relying on RTNL.

Also add const qualifiers to the dereferenced pointers where appropriate
and fix local variable declaration ordering.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index f14e019f3f3f4d861ebd9e5e81175b8149b9acc2..17bd3543d587a9e941737109df82b83023d23711 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2464,17 +2464,27 @@ static size_t geneve_get_size(const struct net_device *dev)
 
 static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct geneve_dev *geneve = netdev_priv(dev);
-	struct geneve_config *cfg = rtnl_dereference(geneve->cfg);
-	struct ip_tunnel_info *info = &cfg->info;
-	bool ttl_inherit = cfg->ttl_inherit;
-	bool metadata = cfg->collect_md;
-	struct ifla_geneve_port_range ports = {
-		.low	= htons(cfg->port_min),
-		.high	= htons(cfg->port_max),
-	};
+	const struct geneve_dev *geneve = netdev_priv(dev);
+	struct ifla_geneve_port_range ports;
+	const struct geneve_config *cfg;
+	const struct ip_tunnel_info *info;
+	bool ttl_inherit, metadata;
 	__u8 tmp_vni[3];
 	__u32 vni;
+	int err = 0;
+
+	rcu_read_lock();
+	cfg = rcu_dereference(geneve->cfg);
+	if (!cfg) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	info = &cfg->info;
+	ttl_inherit = cfg->ttl_inherit;
+	metadata = cfg->collect_md;
+	ports.low = htons(cfg->port_min);
+	ports.high = htons(cfg->port_max);
 
 	tunnel_id_to_vni(info->key.tun_id, tmp_vni);
 	vni = (tmp_vni[0] << 16) | (tmp_vni[1] << 8) | tmp_vni[2];
@@ -2554,10 +2564,13 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_flag(skb, IFLA_GENEVE_GRO_HINT))
 		goto nla_put_failure;
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 
 nla_put_failure:
-	return -EMSGSIZE;
+	err = -EMSGSIZE;
+	goto out;
 }
 
 static struct rtnl_link_ops geneve_link_ops __read_mostly = {
-- 
2.55.0.795.g602f6c329a-goog

