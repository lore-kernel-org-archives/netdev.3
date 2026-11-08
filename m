Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170367;
	b=xtWsO2i0LhQ9jDwy8vmDUVX+UAGF4RX3pwjCde9z4R9yKBIDjnxFoEtVKx0Lb8AkIgLd
	 iOFl4VEcjXjC5g+DPxeF7+OjuMVEEr1OFqK/EIYByS6AR6w9Feuyd8FJBMDv48Q7X+Rjq
	 XE37jJcYSWcHw7ndl4UftUFdtpN4DN6Du/T7Om9EkJxFvHmmjyIBu+4gVysHd9laQZlCg
	 50r0j99iBKSXvOtlZE7zS9qBD+ICCQb9v/Ci/hmmjXcgHnlK/hZPWqGivL9qD1FC7tT8K
	 9EuevQrQwiX1PBt72tfUoXuZSvfFIp5asjT8cd2adIFsud4zIUWy0YIzuTrYcjOoA5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=jGyQa9J2GvS5QVrL62cmcRZc9qO4WtRWpjo4TF1CVb8=;
	b=Z1OVzRluTM9XSOmYDxYqUsPOrLalRhqNVrL1VXIDzsd3IFAb7IbnB6PcaC3cDXu7kIt/
	 xqQEFkbMwbP2ZFSM261sr5hNXl73wyT/XCiQd1390k54/yQ6RNYiYSs4NjKaCP5rzNvtK
	 j3PPIG5i80/nw1g7AZ6Z9s8IjUABGBd77bzPln8o+n4oYVcUaCdXIieF7eGjGbSFeNqu7
	 iST3eEP3URD4JO1oZTV6KOVlbqabvGaskGSWAFJe4F7yEN8ZcEzEc6JHhWerQx079AcsD
	 AFiGIaYXpnu3/jNdozhRcUMRR14xB1+ZwZytIRJxx6uf8Sfv/PObyjrYRQpzksWepmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA6f593x;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4B606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 20:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA6f593x
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1157475e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794170365; x=1794775165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jGyQa9J2GvS5QVrL62cmcRZc9qO4WtRWpjo4TF1CVb8=;
        b=RA6f593xb8qDiC9d+aM/c3tvR5NKkvO/W03N4d5vE6Y14J7LGcTaGISvUHk5pqIOKC
         bU3HyaEAtgSe6T7pFVm3rRfxXA4xN+ogrANlipypd8G2Q0PvrtREAH525/czaQt3SA4g
         wlfK7gesM23EAdy8GahlNycwza3UjlcePIVdM5aCbcxVwqZs7i/3HI6Wi3vgla5LhgHv
         s0JPY0+WISt1TwkhJOojAlSyPWxFaxpU93MEdy/udj/K18WXDSJeWAp3p8RlUyfmm/4t
         +CrC2cuD9CHCojEhY1EeIpSHHBuVfSRLcan7JSOj56qshjBpieEoZXq6DSpghfvqbv6Z
         /jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794170365; x=1794775165;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGyQa9J2GvS5QVrL62cmcRZc9qO4WtRWpjo4TF1CVb8=;
        b=TimNG8Fb6AonQDwstirbm+V8FxtfkJY4sn7e6i4ROxPeMZWe4prWRBjIR1TgjVi4P2
         AcQsOgqcG1B8oLiptF+6ISDvCfYVNn+jd4DlK5Kr9WuwZNmPQeksPSSBiIhJPSjgHAyk
         22d/4TgBK2WKTLg/F0hD70GimCF0VuB6pMYA0QJetwol/Qd9mHyc3B1bFQIBphl3J71x
         rDDWdeEN3t2nVHq3rLkpzCq/alKIEmko/1eWKS72wcopKPfNueYKG994IGnR2e12oTTT
         tTlZYzaj6ZSv8k9Q3jRg2YcGDAy3V8RWrcQs2QoVM0tCyofck4YuioZ6LjZ+jHOOE4St
         vKqA==
X-Gm-Message-State: APuU4Z/l2XukFtxDUo71ti65qv5Q0GHu7xoGhn84o6foXyPCBfmokGqZ
	X7LsYGG6bJh03D5vskFmsbbAnTy0PFe+XbBp9v1JeExfnrRoQZFrwIwR
X-Gm-Gg: AYBFou3UMhsFu5FlMfKrgTpQ9nszktULWFyO/Ad+KHZKCRG/+/4obPWOnKzF5Xb9aZF
	2mW0Z4qvan4duPRSUWNu3rnEHejaDCEZg4iiak48xmV1MYD7pkrzz/QAJ2iD/yAvpK9YK1HRv3s
	rDMmD8r9q8GSJXjLHdUltIPOe2TbHFUcrNGMDmN3g5ehnfcgxU3tjK7b8GW/XAPleZmvmU5yW0x
	P9dxsvjIQ+McSvvSr/zWKB9bPRwzKHtHc0VoP+5EW5tXjPBbwsEX2iZ+xkvbNxeFNrYyF48QOHK
	I3mQDzSHJ+WBHJaAoqy5MDrUv3t68/KdNjMu7uDMQSYBfhLy10zfaIy1nZxZcCONXjpH2/yG+1w
	7/8pUomjG0BH785KwtPWo7MtNHja+L8JN3cqnkd4q1XCnr4n38nGHpNmuZftR3vf8RcI/puamFC
	P56V0bDLOHo6Ydy5pZ1s2vjcuYxPiknkk4yEIzulqQkknWB3E/B2/6A3RH9uVbE+Olhr9DnKUhY
	TCLNS578uh4BCrAuNj96xfY/yAa0H0ELIC7zKLY1nTwLmHuEBe1N/OQooVLIPo7DIxJBGWHQq47
	UPVYmAwIQViMfSM2lq3zm1n3MSIuVvSldhlTgnb+qNMO0NhXfTeu4g9gcbkr7ZfxnvFhZkurPoC
	6Sjm3ufLmIblytVyWP+0c6c30ZWzKArgnVrFj6w7vaRNRS0lLQ0MUNw7uXmqTks8odhDZGjFT+1
	dOtxjX/Bg6g0Q=
X-Received: by 2002:a05:600c:190f:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4b963c7121dmr43767825e9.22.1794170365006;
        Sun, 08 Nov 2026 12:39:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1b64esm184981965e9.13.2026.11.08.12.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 12:39:24 -0800 (PST)
Message-ID: <2af5fc30-4520-4768-bcdb-7b1058b39212@gmail.com>
Date: Sun, 8 Nov 2026 21:39:23 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net sysfs: remove deprecated empty wireless
 directory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Last known user of this deprecated feature was Fedora, until 2012.
See also 38c1a01cf10c ("wireless: add back sysfs directory").
This was 14yrs ago, let's remove the feature.

Link: https://github.com/fedora-sysv/initscripts/commit/4e96fcecee7ab70295a5f2c52748cd57cbab60bb
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/netdevice.h |  2 +-
 net/core/net-sysfs.c      | 25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7..ac943798abc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2484,7 +2484,7 @@ struct net_device {
 	struct dm_hw_stat_delta __rcu *dm_private;
 #endif
 	struct device		dev;
-	const struct attribute_group *sysfs_groups[5];
+	const struct attribute_group *sysfs_groups[4];
 	const struct attribute_group *sysfs_rx_queue_group;
 
 	const struct rtnl_link_ops *rtnl_link_ops;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 5c0402389c6..cb8c82d1a4d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -910,28 +910,6 @@ static const struct attribute_group netstat_group = {
 	.attrs  = netstat_attrs,
 };
 
-static struct attribute *wireless_attrs[] = {
-	NULL
-};
-
-static const struct attribute_group wireless_group = {
-	.name = "wireless",
-	.attrs = wireless_attrs,
-};
-
-static bool wireless_group_needed(struct net_device *ndev)
-{
-#if IS_ENABLED(CONFIG_CFG80211)
-	if (ndev->ieee80211_ptr)
-		return true;
-#endif
-#if IS_ENABLED(CONFIG_WIRELESS_EXT)
-	if (ndev->wireless_handlers)
-		return true;
-#endif
-	return false;
-}
-
 #else /* CONFIG_SYSFS */
 #define net_class_groups	NULL
 #endif /* CONFIG_SYSFS */
@@ -2370,9 +2348,6 @@ int netdev_register_kobject(struct net_device *ndev)
 
 	*groups++ = &netstat_group;
 	*groups++ = &netdev_phys_group;
-
-	if (wireless_group_needed(ndev))
-		*groups++ = &wireless_group;
 #endif /* CONFIG_SYSFS */
 
 	/* Hold back the KOBJ_ADD uevent until the device is listed. */
-- 
2.56.0

