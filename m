Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D67342524
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825434; cv=none; b=PujMyMKNWBcrH6giAzqsTCgcr2XH6tB0SAgGJb+xztTdV1KHLt2k2mShz2nPzs4kYZa6MD0TWfN1ns4i8ujskAADj10lLXotsDv3bkQ3LP6m2+BNPToqXHRTDwqrYKmaD/seAiAE18P7mbtBtUydgC5yXAihc7Axw18SQbPqUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825434; c=relaxed/simple;
	bh=twYxm8KkBBz5TtdTcshdmfGdvKHWJaaTEKzHj5SSDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhB4j63w+9Fcgx4lHd4r2crgkcwakVzkvQtYOhX2+sD0gCYCgzomcvUzSGBYvPX+BlYNnw7KNd2Krd38DCuzLhCqhukwtA08ojCb0WRvo1hnU0Fc6vyUy7WOOhiiJKjxwYjEQQ6x08WtUBtYHLOnh7RCb5ioklUhRpUKW+l9+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvjcVNpG; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvjcVNpG"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d4688decso16488381fa.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825430; x=1790430230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
        b=jvjcVNpGBHRtQu0BjhffNo8IA3xBiC85bwcjBjGanpP/5ZkYoSY5wZiRSN5z/enPKN
         6N369/dQ8Pl/g4GZvu0qvdZfmO+mN6maFNAavhWdMiOOCJH3+mGWNoiGjNXdpUZ9CaXl
         aVnzstd27CO/+NewESnEN1EqtMQZRSUJpGwPSRDtzTupCAOb32nwS6LMhJkKOEpu0c9m
         xBcxUiLgKN9Kj2mMdk2bWIpVgAPjb9E7HHSvSmcmzbkoC03w75vq+B8tOsj3goVYaUEm
         xh7ZckHtx639rdlRy/M51l85y8uyJ2jz8U6KnVGQ4lUhClfoOdM++PgCmCaA11QbarxH
         Rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825430; x=1790430230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+J2l1gP5MhTi9oNQGHstmZ8ANZIuRJDXJgeWc7c7qg=;
        b=O9BM3brP2MJnZ9SfMbgZQ2oRU5pBZJZCK4bi4rQ3DLhd+959DI7oBtCWQDtw7SO01Y
         qsDZ0RZrdncx0JKR6vt+Q7l8utsP3Vn+B3Xx07MedohgPj0kAQZ0honSW1yNvD7Q8b7t
         +8OUn+J+EFCpGI9IaoT/D9SewFJ4dq2W2hS1uniPwYfc7oIoXdQImq/QHZZs6kODbJp1
         71I27/7jt6jbDwKOV2ZrYpk4kk6xcTT8q0vIsMxMepvIbY3aGlrhovHmH2pJ9GvZhoc0
         gPKMJzQD+l03bLB8wPGb7dlFV/1anqDk1PLr8zJTImKA7JvMgYy0fBA61hZvlgaWcJv9
         q8Yw==
X-Gm-Message-State: AFuF++nwrPIHKXN+v+39OyEJz4EvfxvYAmLDGuy0lwif1YhHW3wWZE7i
	PouNICeQ7foCZehIjKmRLBP6T1ik+p/j/0Syi9it8Be4SAhJ/H3i67D5ELVTGPOJ
X-Gm-Gg: AYBFou18PjX9LGwBgSrV1nPYLdaUlY6PQTR9Xa72EHzWZxdBgSlEoJ6yt/qZnLZ8u4F
	MWxxMyDC531zf3aw7vmp4umsqJGxaSlI44Q9Mfyznl+931xFikF3R7paX4WRIeXqEsRdOweFAXi
	7k4TIMh8gscrEV1pGxSVxray9i+7q0SsfhNqmXn2YDlnuLtz3634EyJUCJ239q+dNTCNPiecBju
	m67K6tAjM+lE7iJziU4sSYhRprFE6XrmGmooKEts3fTctoow4RWe/8SjGYSUWfL338JK4TojV9u
	LF1EPwaKj2Umii8676zyXQoYbO2alf4MGAjgdxJXlm1h9C5Qtt5miciENIEh49IL6NGWH6a0VWH
	XRB5irjM2M0teBAxqOdX69g+rI5D5A9qZKRntG8ck93u3p5pvBV8NeZPJAXnAv1XZkutnJdzYBO
	QB3a/V76xTHHqE9TBQqeLKbj4nkG+pRAHCLrCoq53wFmoV3xWDoDirGpvVMQY9IGW5sfrfIQStj
	pcy+NmAg6VCVBxkt/MWbLUyzPhzo47KuLczSTcafExePIkvvDkrea0kM7lLSRx5+WS4
X-Received: by 2002:a2e:a803:0:b0:3a3:361e:6f1a with SMTP id 38308e7fff4ca-3a5fbf5e287mr11840091fa.12.1789825430463;
        Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:50 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: bridge: fail link info that does not fit in a netlink attribute
Date: Sat, 19 Sep 2026 16:43:33 +0300
Message-ID: <20260919134333.49379-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919134333.49379-1-iprintercanon@gmail.com>
References: <20260919134333.49379-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
the inner MST and CFM nests.

Use nla_nest_end_safe() for all three and return -E2BIG with an extack
on overflow. Dumps end with that error, notifications go through
rtnl_set_sk_err() so listeners resync.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 net/bridge/br_netlink.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 855a46aec3a89..fbd91b86d4268 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -459,7 +459,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  const struct net_bridge_port *port,
 			  u32 pid, u32 seq, int event, unsigned int flags,
 			  u32 filter_mask, const struct net_device *dev,
-			  bool getlink)
+			  bool getlink, struct netlink_ext_ack *extack)
 {
 	u8 operstate = netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN;
@@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 				goto nla_put_failure;
 		}
 
-		nla_nest_end(skb, cfm_nest);
+		if (nla_nest_end_safe(skb, cfm_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 	if ((filter_mask & RTEXT_FILTER_MST) &&
@@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		if (err)
 			goto nla_put_failure;
 
-		nla_nest_end(skb, mst_nest);
+		if (nla_nest_end_safe(skb, mst_nest) < 0)
+			goto nla_nest_too_large;
 	}
 
 done:
 	if (af) {
-		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
-			nla_nest_end(skb, af);
-		else
+		if (nla_nest_end_safe(skb, af) < 0)
+			goto nla_nest_too_large;
+		if (!nla_len(af))
 			nla_nest_cancel(skb, af);
 	}
 
 	nlmsg_end(skb, nlh);
 	return 0;
 
+nla_nest_too_large:
+	NL_SET_ERR_MSG_MOD(extack,
+			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");
+	nlmsg_cancel(skb, nlh);
+	return -E2BIG;
+
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
@@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
 	if (skb == NULL)
 		goto errout;
 
-	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
+	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
+			     NULL);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -693,7 +702,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
-			      filter_mask, dev, true);
+			      filter_mask, dev, true, extack);
 }
 
 static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
-- 
2.43.0

