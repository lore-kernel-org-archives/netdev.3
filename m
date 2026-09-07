Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1E352021
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821936; cv=none; b=p5ayPO22EoZL2nsCLVWaY+hFMkxEESo3AT0NZBxlr+0ucIlnU4s5EZLSPosH81YHdmQ2f/6yOW7PTWX12DrKAVB6eU/sYBPkV7NnbhRjFu7A4dQ/OPv48vABE0fLdB/ByC9xERhyoKDbbkB8dAjusOtYx6JNls7ZwUMeXZS/nQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821936; c=relaxed/simple;
	bh=Pop2v5/DbnH0fvUO75ng2j1XQpXra/KdXB+K/2aR3Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTOy3Abtx3aan8PEhxIxUCzgTVzmSlQJ7snpH8yg/nBW/QyeUs5RYNUzZ46G0OxpJEXgsl+iV7cr3g5hxXC+wczPCvWyW5NF3olNw2XUNud7UmkY61ctVleWsp7io2rHVv2OUmRJVbvcrmwg6NpCzKdHT2jXuAtwPWRrQZR7cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjBYgk7R; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjBYgk7R"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3d832827so23971205ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821935; x=1789426735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=luVRHM6REa3BI9V3QVekzqN5Qk+se2x+ZTm/czwa1VU=;
        b=YjBYgk7RwbiFRSxHBa3zXN455opLll8OUSqVquLI7TmSeef7InwFflUMm+GUV/seT4
         p7cgrj+XSwMxjobkzlxYNQ4JVH9igfpBm677WkqTGoE5tVdZO1uEUbVyu/MHrYJipIN+
         XpvgMqMsdb68dXncj2FgS5XroryPs0NF4lI6I/ker5vr2viR6Xp2gSGcnMx8oNjSz8pN
         MpnTRdfiWZ0ul4TYw7zszZ4aNWGXEYjEo1H5znpxtUVIvFheqJNuc6u5HYrvOJVZmCwC
         D1jvFjIeBuoCwgD72NOmGaV9Y4dBZ2+4rXPkR7Hyo5rUtjn/FxLsRw2jCxThOUasuU41
         oC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821935; x=1789426735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luVRHM6REa3BI9V3QVekzqN5Qk+se2x+ZTm/czwa1VU=;
        b=CyoB1WQZIFwffU2pjcQ7es9XzffwAgDr6o9GBePu6yv1F0kdYdCCBA74v2mmkqJDcO
         eJSxY8ItuivyoelSGkQsK8Pit5SepCTsgfRCXlyP7soblp3+Tv4q2Wty3H2f4OlkzXnr
         7mnjGukM9w73NygXFbpgIiTJ2UuXfPDc+pltJmoq24yobwEMV13z8sRabJl9gUF/iiTp
         o1JE2FVTtNnkWVJwwZMx7CXaXev+JIxPpWn6TYImPF7w3C5/OGcLiHoj9VN2abDdshqd
         pkWWXqlEGzlpZstQ1R1w4dP9giWqbG50dLNUoIcfT5huoWvxQorXUA38+p+vTyMdT0Tl
         34HA==
X-Forwarded-Encrypted: i=1; AKwUvBxC3jY2iVRD16fXX6kPSpuCjlc/BMI9iGMyyQelNC3J/flhNbnL+boJaL0IUsfObeuJ1zInwVQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mBBLc65LDgJTbpP14kKHEic/TomMDCZzMHezSdrXmgafkPFHf0
	y/GfGGKm/LcZ51WmZwxuPp5OLE9WS0UZIjgPhbMIzWPMMKeBwy2giVkyDCsasLa7rIQWGwxgKbh
	pwG7mig==
X-Received: from plcx2.prod.google.com ([2002:a17:903:c2:b0:2db:5eae:a078])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cb:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2db1248c3f4mr323543225ad.7.1788821934601; Mon, 07
 Sep 2026 15:58:54 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:46 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/7] ipmr: Call ->dellink() to remove DVMRP tunnel device.
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

This is fine because currently ipip_link_ops.dellink() is no-op
for non-fallback tunnel devices.

However, we will move ip_tunnel_del() from ip_tunnel_uninit() to
ip_tunnel_dellink().

Removing DVMRP tunnel devices by unregister_netdevice() would leave
them in the hash table.

Let's call ->dellink for DVMRP tunnel devices.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
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

