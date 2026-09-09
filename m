Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226A4825B6
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997468; cv=none; b=sS90BRu1pU4JS6pykoJ8KLb3NM7VAv7NIDbngQzvOxo2ZX2KIEIpoGdwgKUNLMNzIJxDnYqbmqdhA2q8eyDL+U3q9k25ycvtfpa3RfWF9SikD253sBXw3PbGEVTwmCY1OV3actWO7M5IFzGw67dz/ltwNRXmhrFJ0KqEDMOaBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997468; c=relaxed/simple;
	bh=Qq58hrzfdbqYOx9eKdd2Xl+AxAiU4jfyH2PhdTrxUcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpZ+jiSkMyfC7ywC+Al/BODiGaAojXgwHq7SOk6zygnEyXReNybiTnNzbkH6k85TbsRVkIs4RhVkuCgnDoqpWJAyNOMoNW0O8qkMUdIcpbhmbzFlM2qRtQlJLJyrmM1NP2/AaRQwohId3wBAjcgl/2M8N1qqibqF2XLlUuwuhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzxtWKAo; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzxtWKAo"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so7054319a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997467; x=1789602267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kKkfXK0n5K2M0ShPTYgtuvdAL07W6r8mBr9mphMzr0=;
        b=JzxtWKAodPQ/SnUSkcAk+zh2Cw4t9cEdpcABflK0Bl9D3kNc66+WJpV1yFQ8mfNxIa
         dAabFQZDJxMhlzIizFFzL6mFBZ7VqhkmArkNPfarOvorUQCtC6hL3J5Qu+vNav2s7/ZG
         pmhb5Cb2azi7YA/jJ4f7iCUazgO0hgHOqnuEBj0lSaNgAIImsCuFCdE88ipckbAC3Mxz
         PIxv7785nwEn+f/kWyCRi5qaqLki9pEOGCtWxFtdi7SBYW/eI0mR8HLfnYW9v65isRoK
         ogy1kKIocI60DZ+8o2tAx/e/3m3n38xGjaGbl1j3uGPHOxSGLUcTtznaFBMaNLEBAsei
         dYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997467; x=1789602267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kKkfXK0n5K2M0ShPTYgtuvdAL07W6r8mBr9mphMzr0=;
        b=K7h22KwmqX9hg0e+dUpRKPRygCa/MEa6wGFL6sI7epktalH5o2KB2MFwVVg6rgVl9u
         O4qaKaGe8tlASDqwefSp2jdrCGydfRp084BkbaacnQhAGlHSZGiUI0I7NySC6DZxlChh
         4tuqe0MEHbEVGQn9GyjddVDJIFhBT+JFPU4FYhPiUC2/+7M8wfSNibEXHZKuQpAgDSgz
         mB9UPShtrZGohiyQMuKp5OR3rm8CIGHWmK7XnmxzbF1acdO1YfiLlVNVnsKlnItdLvh7
         YVMjjPUq4EHjS/6YVgUhNkKPDaWVvmVCxtuRd1oGFnr3v6HFiLjkK88CNAmxPtX9nAto
         f/Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzhtK1tflkcc6lMgcVABctbHFdwGHgPA11FFsv1v+UsqXAUhQXmfXPKW/IgYftjaotIZpgVqKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ly6ni9dkRusHtYo0i+POSlpXpiNmoxEKX9DDGDO2nhKSOJU7+Z
	inN6Kq6t1ry7xl5YxmV4qNQIyd1OVSrV1ff5iMEqampo9Bm/FPYDjVkUB+8tyW+xCvi+bN0WFFQ
	vymBUvw==
X-Received: from pgfd20-n1.prod.google.com ([2002:a05:6a02:6554:10b0:cc4:9fac:5466])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c896:b0:3cc:917f:f302
 with SMTP id adf61e73a8af0-3da39f6054emr58496552637.9.1788997466460; Wed, 09
 Sep 2026 16:44:26 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:44 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/7] ipmr: Call ->dellink() to remove DVMRP tunnel device.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ipmr.c uses unregister_netdevice() to remove DVMRP tunnel devices
created in ipmr_new_tunnel().

This is fine because currently ip_tunnel_uninit() also calls
ip_tunnel_del() to unlink the device from the hash table.

However, we will move ip_tunnel_del() from ip_tunnel_uninit() to
ip_tunnel_dellink().

Removing DVMRP tunnel devices by unregister_netdevice() would leave
them in the hash table.

Let's call ->dellink for DVMRP tunnel devices.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Correct commit message
---
 net/ipv4/ipmr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e5f2b1c6150d..02edf9d7f4b5 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -479,6 +479,7 @@ static struct net_device *ipmr_new_tunnel(struct net *net, struct vifctl *v)
 {
 	struct net_device *tunnel_dev, *new_dev;
 	struct ip_tunnel_parm_kern p = { };
+	LIST_HEAD(dev_kill_list);
 	int err;
 
 	tunnel_dev = __dev_get_by_name(net, "tunl0");
@@ -520,7 +521,8 @@ static struct net_device *ipmr_new_tunnel(struct net *net, struct vifctl *v)
 	return new_dev;
 
 out_unregister:
-	unregister_netdevice(new_dev);
+	new_dev->rtnl_link_ops->dellink(new_dev, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 out:
 	return ERR_PTR(-ENOBUFS);
 }
@@ -733,8 +735,12 @@ static int vif_delete(struct mr_table *mrt, int vifi, int notify,
 		ip_rt_multicast_event(in_dev);
 	}
 
-	if (v->flags & (VIFF_TUNNEL | VIFF_REGISTER) && !notify)
-		unregister_netdevice_queue(dev, head);
+	if (!notify) {
+		if (v->flags & VIFF_TUNNEL)
+			dev->rtnl_link_ops->dellink(dev, head);
+		else if (v->flags & VIFF_REGISTER)
+			unregister_netdevice_queue(dev, head);
+	}
 
 	netdev_put(dev, &v->dev_tracker);
 	return 0;
-- 
2.55.0.1003.g10538fe699-goog

