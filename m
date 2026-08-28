Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1113E123F
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911619; cv=none; b=gA15yLYYb05V9+U0Oe3arU5ai8UJNFUfEOf5cAjmtxlFAzt3Lpul6v2XDmQgoDGCAKP6vBKWzv7oktncXtY1XVFQdrv5TqT+X22OGvGsMdBax6l6fbbXpUDcsNfIcLo/Pfxm1SLaKUb/0Bia7BOxcnZ5R26KAAcf2nTtEsBUWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911619; c=relaxed/simple;
	bh=pW75mykq4qb5j9EYWFECBMjJsWX/64+SnhaNBfbhy8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdciYLmYds94nENFWKZFLrHS4bMe8Nvsbe81JRiskPfFrngdllBntSYcwgh+81efyCQhSbBtFm1i3UBoeqOxjkyX32amR2DrQAP0Xvorltx+mCobrrVJ7oVvuKNcA/on91RTSB0A8UFhZC6EqpMP2LUi1L+s2rAZZhVlRsq/mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aCr2Ts20; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aCr2Ts20"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f96c5b722so484984f8f.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787911616; x=1788516416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2d9aOk1DG5PJgTbHtKObATO+j7rQRq+47Wx1t8d6YA=;
        b=aCr2Ts202u4jI1hLcUVzPwh2k6G3Y1wi5elqMe52jBfN4cSDZsXo5VEIdAVSeIKtZ+
         hPqjSpgJjm4yBLeFhbaWlo4NP0rsx+1imn/9DSDGUO4Tu3geP4f7qMZKKW2syErQYP23
         TJHi4Nc9szAw9vVDvYVFwMhFPU2yIPGC/vrrCuRT00anQLgIy1Zt4TwLuU7pNDsQRBYI
         7j3N/7mvJUIa74GTykJRHTJzQcJuaBaEtLmLSPAmwDUeXA3Ht/ER7qveA05PK3IJXeQy
         otDiDypyleifcA/stnfvDCi+aMRLdJI4t4zGTZOFUXHRJ1+1i8ykafQ4SSuz3fgso+z7
         AlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787911616; x=1788516416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2d9aOk1DG5PJgTbHtKObATO+j7rQRq+47Wx1t8d6YA=;
        b=Hd3nesenXxIlnM5rTWdIMNSNG476Lc4TRKn+en5LTdgsH4XZoKqSzuFAvDD+jNUhUw
         47AFqvcjma00/Qat2bFsnX5CeE0+MkGW+zqxrApBOjc8dK86sIRDHpNj2vVb9Ft+HPUN
         XAMZ5zHxLb4Qg2LNuUEyIynwmGHMbDg/STFZUbYN1y1bT7CmTjf6EynaKEYbKmkQj2AG
         KAkXcqF+BwcmdXh/NvdCQvI6QROjFyjnrCa344pJ3a1ymTCS/FPHgGg9QzFWh/pg3HSp
         /+ez7MUphK35ry9k3FHxV/K/SLW7HD5KNSsHDZsEoUl+RTHpnbhll/WIOHBrYJl9Q1Yt
         cBTQ==
X-Gm-Message-State: AFuF++l3MtR0QRDUwDe+8V1oWbMeS7Z8xeW+vIwVpbF6w/PIdgy+k5hQ
	2Fg2J7WQX6CRbvVjXh+E5fiIsS4MX57U6WqtEEMRHstLseUi2WLDtfHjFbwcjplBi0NEyXRHjUo
	jivsSKwI=
X-Gm-Gg: AR+sD13+BiDpHQTLAm5eY5aV7fdSTnEEUSb/XjQZJlJCn56elMZruRwQI33rs1uf6W6
	axwW9K8VpTErYokiLo29+NGYxIRqXwQvMgRV42d6nxK8gisA1fZ8y9LvudNkSMITWKsU7AwyCwh
	N4ldcnwUSkmJ6aA5xvo+1gpRjLGiHCMEP8Hiln9n2mzbCcnk7JW7+d9ZrMgJGQpoxW/2lIxlHiP
	juq+aq+9O1c/sQs6zF0lTRfFQVhco2fzv0Xsz/4+mGLUPydlTMa5yfUC97u5CXKeLA5EBLL8WGj
	7bUnyIm6p1jws+fv/moPlWIP6PacjZQt86DB/BpwfkWz/eiY5IFjCWA5pK+NUz96Hz/M1ZLpeFJ
	SvaYo4YSOCQDYbfH31nXf2ho8IC8yPAVfmYbv9LW392BbuX/6kK1B5cSxzFx3aQ7V2cbJ0awbEW
	tnmOkJjXxXmfGgA65YdaQR/PrsXyzMEXTS/yEYA1pC4ZGZMFBb2WMBngHxu48lqF+BZHEyLhkPq
	cuVwPEtMjs=
X-Received: by 2002:a05:600c:a418:b0:49b:9433:ea44 with SMTP id 5b1f17b1804b1-49b9433eb4dmr59357095e9.4.1787911615692;
        Fri, 28 Aug 2026 03:06:55 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49b49cc61cfsm127971735e9.6.2026.08.28.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:06:55 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linus.luessing@c0d3.blue,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist
Date: Fri, 28 Aug 2026 13:06:42 +0300
Message-ID: <20260828100642.2664347-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
port group not using proper rcu helper that preserves the next pointer and
after that immediately frees the port group without waiting for rcu grace
period. The only rcu walker of mglist is br_multicast_list_adjacent() and
it turns out that function has always been buggy because mglist was never
converted to RCU. Fix it by acquiring the bridge's multicast lock for the
mglist walk. We can do a proper mglist rcu conversion later.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
We can do a proper mglist rcu conversion when net-next opens up.

 net/bridge/br_multicast.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..7fa5f4444c4c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4967,15 +4967,19 @@ int br_multicast_list_adjacent(struct net_device *dev,
 		if (!port->dev || port->dev == dev)
 			continue;
 
-		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
+		spin_lock_bh(&br->multicast_lock);
+		hlist_for_each_entry(group, &port->mglist, mglist) {
 			entry = kmalloc_obj(*entry, GFP_ATOMIC);
-			if (!entry)
+			if (!entry) {
+				spin_unlock_bh(&br->multicast_lock);
 				goto unlock;
+			}
 
 			entry->addr = group->key.addr;
 			list_add(&entry->list, br_ip_list);
 			count++;
 		}
+		spin_unlock_bh(&br->multicast_lock);
 	}
 
 unlock:
-- 
2.47.3

