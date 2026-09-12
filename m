Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97D301486
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254048; cv=none; b=ckpkdqd2S6mgJPa62z+4GX25ceWafH7kLVVIeR7NZkDWQXr3hkOL1GJbp2e0Yb8uAgQW9LWZH77J//il5mOfKi3I/EFEBWR3mRCMrIkSlkqaNaaRZEJbjJyW3qBTU/ktuvfI6hSVORbqNZEdZ5ZV2ZBY9+EOnmV84YC64+/okjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254048; c=relaxed/simple;
	bh=GjLck5O+odHu4pmMrrmyuptfXopM4Fd7JVnXJefyCk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZm9q7BL/dfGtUccVza1RRg4PnQJAs0yPJfnH2ENe4BYk/8DMMEp+1GM8pfPYrkw/APe0EYVMDrAgjN4Ey+ie80Sdvn7lG+YKnz0HIMBwlmqxaOhRwumf4FnHmse+VBLpjy44SFSvxFrSfDU36bm+lLeKDq/kVEpNifk+iW6jIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzDVLUzq; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzDVLUzq"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8688139460bso1867920b3a.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254047; x=1789858847; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rW+UqWLxL7REpMHpw0m+rYD3EenNpjIcIRoFWW3l5Gk=;
        b=jzDVLUzq9ki7VF//OfLYU/uEyhHRo59ThVn1j6YqqBehLkRSi2zFb9+VfwlyNjGvHp
         UkCSpV21VgIGOhAp/zJ3uBai+UZ15bb51RjiuVCYbtmonZwiKJsEm44UbxQHHAfCndp6
         ieLlUndzddEwheSql1SbVyeFtbJbTGkxSTxLPGYIMBBwZ/jt7DLBQEqoy6ESipGE2A8K
         T9PQzULXLBEz6J3V29ptBLQIMoTYvMMv1ERbNyMOb2DmyNhPJ4ZL7mo/vMhuNalI2jTE
         6aB53auCgtYk0pItq5vEVHSkqa/5Doq/DBY+J5uANtE58LK2yHqM/2iAEoysqUBAMpeh
         BiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254047; x=1789858847;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rW+UqWLxL7REpMHpw0m+rYD3EenNpjIcIRoFWW3l5Gk=;
        b=LJdOZY5ZoAOIQlqIHVcLrMx2tzY/yTArBX3c4d1PVa5UbC5cR3U2WqNfxK7JCiO+jB
         dqH0Arjpp//yC75+wWZonLTLkPgAxxnRJ1Td59hhyzLP1smUpkh7xyONEPHyQ8HoFVrh
         FCFqihrRmeo8RF0bprbqchfERyseGC5oD+eoMZ4JwA1cByHzi3ceEWyg/QJ1VK8kDVpJ
         oW43eSMOu6lA2vaLOuS4yWCm5QT7SGgAdJRg8Aqvkozu3AgpW0wHH+aT+3aUeX9/DK0K
         /EeLT576q8q/68Jj7rpH7ex/aMYYLFoOIotMm3u5Egv3PuDuNLpWokXaixeAWUpMcSpi
         U89A==
X-Forwarded-Encrypted: i=1; AKwUvByJ85UbrVo2Hzoz3Eqa7xTHs7AdH2f4VxTJJo1iwV5bf8yuweHIwyfSJbVyqaZKaWiPgaPU4TY=@vger.kernel.org
X-Gm-Message-State: AFuF++l6bJE+AJuTKpJIMoC25VEhEfy9KDP1FQNOMoV04ygMZrh2xMBB
	ELzuKMjYWD3qrlvQU2nr9Muv/0hNgiZ/jowZOKphAlAE5wYmeCJcVu2WZifvvFRJhOmiKp+oL2X
	S5ipZdA==
X-Received: from pfbcq20.prod.google.com ([2002:a05:6a00:3314:b0:84c:23c5:6759])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178a:b0:857:73e2:9108
 with SMTP id d2e1a72fcca58-86ccd033e76mr7484107b3a.24.1789254046497; Sat, 12
 Sep 2026 16:00:46 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:27 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/7] ipmr: Call ->dellink() to remove DVMRP tunnel device.
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
index b9c544d48c45..f9ecacfb092d 100644
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
2.55.0.1007.g17ff1f9808-goog

