Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76170416847
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867681; cv=none; b=t14Y54zPk0UVTmjJsdmK/HpN7fAGL3fS8xf3Neg9Ik2wpwGIvmlw/IhQc+O6Cw2gbNMd5hU1D9osp5+s7xw2VO8ElF6k+eifjFnRT3DFH6e83tbnCnwSRHOJMtIU5/1uXUeiL6wKL1IeBzFgBpURQ7TbY4UI2VpXBpfq4BykCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867681; c=relaxed/simple;
	bh=aR5Dqx7nLV6UJhWsi7R0KVezBsxZxoIrE8c2wQhRRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPb34BuBBGsnJPvnJgV5zF/cUElNBpaMYvxXLJ7SmOt3p1iBADGok8AMUIfpCNASvyTQdpF25pBNfHL30y+JX4ScH/Q4hDfWhItRE2wIDcc5LAGa+bcprZKUVaGOv8U1+RNfpHhwvWjEX8eS/XWQfIW4XfO3N45eUMvBndaFoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so225695e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867679; x=1786472479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VE80QWO3LvitUueRxl7+6P4HbTH8bsnyr7DnSj9J2KY=;
        b=ioMks/PT/7KgxXuKuYh3yvdzVSfbM41o4l+ENTvbxkSUWXpCSkBN1FLD+X7UdGqgBP
         tLVat+zc/jkKIgCGSsDQ1Ho6r5IlartHd8pSc+RGOxe7MMwCn/0jPblyvyKxlWDR/AsO
         tdW67kA3+57mM4CoAG46yNGRmszgTVZF32n4GIijEwJAvpmfaScST1aztienyrYrmQqH
         VeZXTPhwaR7ZMd00rrGh+wCRutc6jOJdLZjVLTrH4rK75a/Zw2Vyoyj4Bl4BMwAHYNZJ
         IeIM12PX46VEaX6dgfLkUXeMFdvgKwmKEctFijAd/rlGZWBhx/5y3KLk1knJT3wpXPBY
         oCtg==
X-Gm-Message-State: AOJu0YwifpuhOYL1fNXB6yR6WUbMlDkQ8w3p/FUforYDgXq8sGCVSiMs
	flbDxQ6x1v7HSCbIXHZZUfbO42h9OdIxJCQtjMpGSWlAPhqz1xwEnUbgpHduNewQjPw=
X-Gm-Gg: AR+sD12SWeYSl3sBFQO3kKv9g4LJTrFwBMNLOD2X5+V8/iSeiRzz9cfGcF94eCZKy7g
	hZ9R1+vvN+fBjTs3h77tqcdGZ6j3uWaubRCDa5q4z2+2ZUmV0I15LoJj3IqiLSOFNe93uko6G28
	oZ8HkJnSTBKtjHc8qQoPpPwx6fqIvlzMJ1g35O5xcOK9GgTMvDVy/m2mS08a6mNdsq4zNPamFVB
	fced4JczxnyoB5lq1fetXYnXh6ku7BS85JF3HXon1YRk2c6TJ7O3azL+mk2Mg38kkQ1e1mpWOiZ
	DZQ0vLJcwqBTc7Y1PEBQ64wHisyujYWyQjSEPHFtBbLe8Wez/AwoUaFDYE/ae+NtPiwzK+Cnkvw
	rFLOdrF6c2WKro19XgyCLIJgL5TjGg9ki6j/mUpsg5EIIPjqgLBmbfpgbSatUtyYnnPcVIpKgHm
	9v2PxzrDY/aH5u3a/sQ5O/BAVKEsGgIKzCKlBeA0uj6LwMYIAd97HB94Or67U89P1q1PirT67Ew
	UMhmZS1XPrKNztEh39d+P66tQvf1Q==
X-Received: by 2002:a05:600c:3422:b0:496:c18c:f9a1 with SMTP id 5b1f17b1804b1-4994e7cb6abmr1227515e9.14.1785867678731;
        Tue, 04 Aug 2026 11:21:18 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf5c1sm4946925e9.2.2026.08.04.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:21:18 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 5/6] net: gre: remove unused gretap_fb_dev_create
Date: Tue,  4 Aug 2026 20:20:39 +0200
Message-ID: <20260804182049.2289754-6-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804182049.2289754-1-i.maximets@ovn.org>
References: <20260804182049.2289754-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user was vport-gre in openvswitch and now it is gone.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/gre.h |  2 --
 net/ipv4/ip_gre.c | 47 -----------------------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/net/gre.h b/include/net/gre.h
index ccd293203284..b55f67ecd2fc 100644
--- a/include/net/gre.h
+++ b/include/net/gre.h
@@ -32,8 +32,6 @@ struct gre_protocol {
 int gre_add_protocol(const struct gre_protocol *proto, u8 version);
 int gre_del_protocol(const struct gre_protocol *proto, u8 version);
 
-struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
-				       u8 name_assign_type);
 int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		     bool *csum_err, __be16 proto, int nhs);
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 0ba1e94e9012..6a92607401e8 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1716,53 +1716,6 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 	.get_link_net	= ip_tunnel_get_link_net,
 };
 
-struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
-					u8 name_assign_type)
-{
-	struct rtnl_newlink_params params = { .src_net = net };
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	LIST_HEAD(list_kill);
-	struct ip_tunnel *t;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-	params.tb = tb;
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &ipgre_tap_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	/* Configure flow based GRE device. */
-	t = netdev_priv(dev);
-	t->collect_md = true;
-
-	err = ipgre_newlink(dev, &params, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	/* openvswitch users expect packet sizes to be unrestricted,
-	 * so set the largest MTU we can.
-	 */
-	err = __ip_tunnel_change_mtu(dev, IP_MAX_MTU, false);
-	if (err)
-		goto out;
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0)
-		goto out;
-
-	return dev;
-out:
-	ip_tunnel_dellink(dev, &list_kill);
-	unregister_netdevice_many(&list_kill);
-	return ERR_PTR(err);
-}
-EXPORT_SYMBOL_GPL(gretap_fb_dev_create);
-
 static int __net_init ipgre_tap_init_net(struct net *net)
 {
 	return ip_tunnel_init_net(net, gre_tap_net_id, &ipgre_tap_ops, "gretap0");
-- 
2.55.0

