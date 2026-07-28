Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6C306741
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251849; cv=none; b=BC6p8L46UUyd8AKiMw4NKn8JQVDQnYQxgw2LNWxcuulJHFxznh0YRd92gAdMUhG/h1MCX8hskFaSRg5y4fOhodwfBZOhIirez2Z8B+3GZRNoGb9Hx0YbXWtVbRfrO6pw8Rt/029C4BReUPcVtkH4yyNYSB3oNaipepYc8XU3Z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251849; c=relaxed/simple;
	bh=MMsOZFIxWKjNuDBxeb/TAy1uux7B5rY9HbWxz2tgKwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFt3ydfffnVe0Mte9yXEnNgFSyGFLjhhWxRKGhnim4iRT0gJaOUe2ZSEmvUWDTH331LyT7N11azAbLcOABxHS8X1Bt22i2R9K7VVCrKqqkGJSAta5CRBWWiEZN1lBeCovYIDj53N40sze5K3/nPhYfsY0bDcEMrOn+WzXN0TUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXTNIL+A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXTNIL+A"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c01089e8aso26407331cf.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785251847; x=1785856647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9R+FdXxpAje7XBicpqzP2cTrP3yux9QZLouIguYRjGI=;
        b=lXTNIL+AuEkNjSZObCP9StszSboVyB/QFTaaNU2PbjsrsaiNs08vywjc2JAZ352AQf
         WvRXrhFndASWOTS+6zjXlF8DQ+KpSzhrXMy6Nxg3fhylsSfZwNexsNlWN9Mw+YIbli4r
         HbogJDbhqaTZ9CbbOY8YJFpgjzofEL9o9joIKGuFBA6NuGdmPyvd/JJw+eK9pwe7+S5n
         XtCjZOta9neyffnv/kiXM19el6muYV0LBFoJuf/2OTpaKbFqemniJZCWejL9BxawfVPP
         cWmjAdSLBky4N0qPmwnVrHPMfRcd+9BY84jphfSrDnnmXQ1YiTWsVMzPiSyJebv2NmHQ
         a03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785251847; x=1785856647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9R+FdXxpAje7XBicpqzP2cTrP3yux9QZLouIguYRjGI=;
        b=OZf1jHBkXPHr3CQ3DioexhRi4ZatwM5JEJIREomLZz0drmNVace9h/9xW1bjIKy/rZ
         0/Pzj+HfpV9VluRir0LEPVeSQnINrMFqYVkPm5XCsC1S4RN8a6uT+tOapdONDO0PYgA+
         mKXgEa5ZdV/AyYqBWyESkHV5/n/pIbFRgpbKShQISbA3PqSgcSRZiRSzCzbcefhYCaJL
         zkAbqj6Np1pT3t+kNkEEm8zqbHQgOh/R7qPdPkFAcBS/YXOOe8bWL9iR0362Mp0k4n0X
         QRnajryU90Je3iHNzsysOKEdwMvH+qlmLNkaKVZRk4YjYLzeCWTMOyPl2DOXlsv/0qp8
         1S5A==
X-Gm-Message-State: AOJu0YwRtOMScXoGu8uo7vMZaMvlh48P3FwCIXl/M6WUfrlr/5vndObS
	GxavZLVUW4lMcVCe8cWDUNJRCEcrQkbbjwbe8nw8stCdYRUMDsGQAeCWBcYneGGlvkJ1Og==
X-Gm-Gg: AR+sD13EccjEWl5vOEtIT39jxrcKDunij7QOcy8kw8oJ4gyCK33RdZmYv9pIU/40Gg3
	q8uHZBhYJGogLNM7kyBbSWOblxxwCjkpiOV+AM3L1226quvBWQhz6gAqnNHKRKMGSt9PtLAnIgv
	ECJJX/Wyt0WqRdOlWEH04vNEo9tORWZz0eqHasxsDsXRTrdo8hCsCp8RMLvd2JQvkfA7pAkVvYI
	/iReuERwXe6BivRrfZ5YM+beT7maC42sJhDdYgF0Wg4uf8cDW3e5QZ7HRrOmXXTeX0MONfoRdq1
	QCPDQeDdyGFz4PyRgofCmEHnfWDRPkVrzMiRPNXnfWUbso2kT6ZVv96UdXtqWALYWJ4WquAQDYL
	sigF9vN+GFyIMhYtj1kfHwUktCmIUSFsmn9WYtezmyLL9Z3xa92y1D/aJwBj4RX77I5T+TVuljP
	EROEbhe5OWt0FGmyMt99sZ65pUCDZR2Ob7oBRF3L+bmG3HzNUXqmkmEOpekxfTYMFHkJ3aAXOuS
	Kk0
X-Received: by 2002:ac8:7f04:0:b0:528:38b1:b54c with SMTP id d75a77b69052e-529d70bc715mr24272691cf.2.1785251846971;
        Tue, 28 Jul 2026 08:17:26 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29f92bbsm76755461cf.23.2026.07.28.08.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:17:26 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] ip6_tunnel: avoid racing encap setup in changelink
Date: Tue, 28 Jul 2026 23:17:13 +0800
Message-ID: <f4a1f215a63268d5b1028521537e8f292d5f41a6.1785221754.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785221754.git.petalzu987@gmail.com>
References: <cover.1785221754.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chai Zixuan <petalzu987@gmail.com>

ip6_tnl_changelink() can change encapsulation parameters while the
tunnel device is still accepting transmitters. A transmitter can
reserve headroom using the old encapsulation header length and then
build the packet after the live encapsulation state has changed. This
can cause skb_push() to underflow the skb head.

Validate new encapsulation parameters on a temporary tunnel object
first. During live updates on running tunnel devices, stop the TX
queues before waiting for existing transmitters with synchronize_net().
Then apply the new encapsulation state and tunnel parameters before
waking the queues again. This prevents both rejected changelink
requests from mutating the live tunnel and new transmitters from
entering after the synchronization point with mismatched state, without
leaving stopped TX queues on down devices.

Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Chai Zixuan <petalzu987@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b0..429f8151fe99 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1562,15 +1562,26 @@ ip6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p)
 	ip6_tnl_link_config(t);
 }
 
-static void ip6_tnl_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
+static void ip6_tnl_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
+			   const struct ip6_tnl *encap_tnl)
 {
 	struct net *net = t->net;
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	bool running = netif_running(t->dev);
 
+	if (running)
+		netif_tx_disable(t->dev);
 	ip6_tnl_unlink(ip6n, t);
 	synchronize_net();
+	if (encap_tnl) {
+		t->encap = encap_tnl->encap;
+		t->encap_hlen = encap_tnl->encap_hlen;
+		t->hlen = t->encap_hlen + t->tun_hlen;
+	}
 	ip6_tnl_change(t, p);
 	ip6_tnl_link(ip6n, t);
+	if (running)
+		netif_tx_wake_all_queues(t->dev);
 	netdev_state_change(t->dev);
 }
 
@@ -1705,7 +1716,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			if (dev == ip6n->fb_tnl_dev)
 				ip6_tnl0_update(t, &p1, false);
 			else
-				ip6_tnl_update(t, &p1);
+				ip6_tnl_update(t, &p1, NULL);
 		}
 		if (!IS_ERR(t)) {
 			err = 0;
@@ -2105,9 +2116,11 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 			      struct netlink_ext_ack *extack)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip6_tnl nt = {};
 	struct __ip6_tnl_parm p;
 	struct net *net = t->net;
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	struct ip6_tnl *encap_tnl = NULL;
 	struct ip_tunnel_encap ipencap;
 
 	if (!rtnl_dev_link_net_capable(dev, net))
@@ -2137,10 +2150,11 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
-		int err = ip6_tnl_encap_setup(t, &ipencap);
+		int err = ip6_tnl_encap_setup(&nt, &ipencap);
 
 		if (err < 0)
 			return err;
+		encap_tnl = &nt;
 	}
 	ip6_tnl_netlink_parms(data, &p);
 	if (p.collect_md)
@@ -2153,7 +2167,7 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else
 		t = netdev_priv(dev);
 
-	ip6_tnl_update(t, &p);
+	ip6_tnl_update(t, &p, encap_tnl);
 	return 0;
 }
 
-- 
2.34.1
