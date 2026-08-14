Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572E4749FC
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714849; cv=none; b=fgXq5OjCvosEnmu9P1Y00Kki+BMaTchAZOXS/TTW1pBDG4Jmjn9tTieLVQXihQ7e7Nj+WiGWM6AnIxQ5WOLtJNkXx5CJ7OFp8a1qTzrqXJy88H1wLgASZQHtSSr9jJWx8kKIAkZ2As2v1uJ5ATCCalbn3ve/i0UI7cMQMAMbP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714849; c=relaxed/simple;
	bh=H34gAtKfHIky2hxwYZCZ2UlGNvzJXRmVg786uObepMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aj1zKamop9dd/rB/K9Gpmsn+V8H1wgiqaHfQ1YoRpJRYdP8Aj5bpgE04zOO0T0E853HN1PJXa92MyHi+376RrW0aTUppf+xvMXMO4nEcgVEZ7j0fyBzs2akwFM3m459lX8yzt1F0b0hkjh4l5UTvoQCQns1GxavlGow835u+Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwh78Y7f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwh78Y7f"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca12086c06eso711353a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714847; x=1787319647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HASRc0ISsvPlOTZ0JP1hWcZCrdy+n3JvmBb9XvUYb54=;
        b=kwh78Y7f/O59PEY92+lLNG3108yw0tne8GteP3Qa9ndR75lR4LktErpXTofmVt3MsQ
         LKqK0ZJI9bAC+B5GGA5W3GTU3Juc+K5ROSSo4jTVwnoKX8IYgVWAODgQIVNzLp2g4DS7
         5yyXDgqZzJ2dwSZewhIspeBGVH0iz1dT9SQHEWgdYBDzhYsSG1tFxJMHDb887iL1ZFN0
         Xek1YfsdoyzzarHP/PfhIYxh6hYDvSG+pwSCznjsqiRuAwMS1L6iRnqOh82Lulicz21z
         CIpUywe4WEmjJngC6u8hv5BQaDt0OxwAJGJ9HLaQvvLU3wbXdcp9FQk1IPVUTmU9PiUs
         gZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714847; x=1787319647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HASRc0ISsvPlOTZ0JP1hWcZCrdy+n3JvmBb9XvUYb54=;
        b=gkpaGCtWYiiMBjng3Z5puBfm7gJJggzx1YCg7pxnWOT/6MLCg0sDLL5lOv1Zu8LScd
         UlO7yK/ZyqHCf46h8bGgCZ1azIMj0DPwFdzY2GorPF8mrVwszx+H7PvOBk0Ekmif+JVy
         mE7Ntzb1LmYsngsehrFEhtvr0DbDygIaL7b0jhPhi5eCDoLcHFCCf7p+Jw0VDHRaTwWh
         OgPXs42HWPXuyiiG5qw83hpwEKhSVNK977N4kynvtSfNavBaonYh7/dO92imSNKpBGWu
         fUDJh0C8XLtQiAFp0jRtzxlR/HlUDANPhJqOdSp+wm8/K+GiW6y8oGNXNpjm7lvMhndZ
         DyEA==
X-Gm-Message-State: AOJu0YwVub7UZDwS7nUUxB9Fgns8CW3j552VH2aKSQRkfthFeTYhV3V8
	f0riozIWfx4IRY6Qg8R7McIKBfgXUB5dJMsIEWqjVPe/VI5ucs9z2T0h
X-Gm-Gg: AR+sD11Y5xYuGZ4dZzFC7k5jzTTGBr4ivRC0RNf0VIH+WEfnXHhGTyfReaTwTI5qChf
	D5XgLHld4TKa4VLTmV/5XLXUu5SPBvVKMATOtzZB28EnLHE9jmP0F8MPlSi4XZ/sQ8u9aHdRt8B
	8FdTOk1mXOdHnk+bMESwMZSk1Fz2OQHef76xILVotY6jk7W/Jq7m3CfFj5qukibsqz4Nsl2gxSg
	eeUKIWZoEh2FO5KsHjBMqS7v4a9cxLLQn/tUMSBVQ1wKitZojlDmVumIaKdKE1sHrh4heUKi3IX
	z5/QxQMpT/5EKHOTdbGl0sg8Rcy2/24YdZF7MU6F4iARMbBCoDEItIIQlh2l87rRtuTMjvEzS6f
	CqxNJPuyz76ITB4+kjMJLb/otXWcz8mhefDJOeyMvZkGt3AKAv8rHhajYxhe4Xw4BAojuxRt8Zs
	tG7nAGGnDCBMkeVz36PO4+VkvKc0ZaTTNhkOatse6W9UMmvPuZBpDdDhzBWGM6da/zckTCwtI1H
	qfyrx8U
X-Received: by 2002:a05:6a21:3281:b0:3bf:5539:f93 with SMTP id adf61e73a8af0-3cc71eb2994mr5859231637.38.1786714846929;
        Fri, 14 Aug 2026 06:40:46 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc08f388bf9sm611306a12.5.2026.08.14.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:46 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yi-Hung Wei <yihung.wei@gmail.com>,
	Pravin B Shelar <pshelar@ovn.org>
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] net: openvswitch: fix nf_connlabels leak in ovs_ct_init
Date: Fri, 14 Aug 2026 21:40:40 +0800
Message-ID: <20260814134040.1386967-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_ct_init() acquires a connlabels reference before initializing the
conntrack limit state. If ovs_ct_limit_init() fails, its error is returned
directly. The pernet core does not invoke the exit callback for the
operation whose initialization failed, so ovs_ct_exit() cannot drop the
reference.

This leaves labels_used elevated when Open vSwitch pernet registration
fails for an existing network namespace. Subsequent conntrack entries in
that namespace may allocate label extensions even though Open vSwitch
failed to register.

Drop the connlabels reference before returning a conntrack limit
initialization error. ovs_ct_limit_init() already releases its partial
state, and the original error remains unchanged.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 net/openvswitch/conntrack.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 95697d4e16e64..fbaa677144143 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -2001,6 +2001,9 @@ int ovs_ct_init(struct net *net)
 {
 	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
 	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
+#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
+	int err;
+#endif
 
 	if (nf_connlabels_get(net, n_bits - 1)) {
 		ovs_net->xt_label = false;
@@ -2010,7 +2013,10 @@ int ovs_ct_init(struct net *net)
 	}
 
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
-	return ovs_ct_limit_init(net, ovs_net);
+	err = ovs_ct_limit_init(net, ovs_net);
+	if (err && ovs_net->xt_label)
+		nf_connlabels_put(net);
+	return err;
 #else
 	return 0;
 #endif
-- 
2.51.0
