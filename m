Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206057;
	b=rdLOcDJ8klzjYSVyfTktAEblbY54lZd7UljOdFrcfzg9ihC7UZDK/XzT6xUxhqDNJvPj
	 XYc0/w4hv2BRyxzZ1PbAHOhy79ItQLss8PKSs/mo2aR2kYJ5sPF0Pe1/lgXNgjO0mP2J3
	 +Tzby9PEsrJX2Jmt5Vqebo5sl6NFiaNwuVYSgnx3ZNPYZnT4VLoZPS3DdUWWIFZRjc67r
	 qRtUprXO4HtPezatMukvtmMuOL+q5LAyfSpjDAHKZosrtx6P+49MCF0GnV7uw/6VJwKNd
	 uxlHeUEUZBYixNW+ESZwLQcu4l4IYN9mn10fcMbcYTrAU14Z0Mt1Vu7OCDdTwByOQfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
	b=usI+yFvlnVre2UaNKnXJx4J1MyfJfFjBbSokaaaGuc3CmN7UCOk4JUIEwfZemuwhwI2W
	 mWfurRFYYhxhaL2sql32awrF28gGjmD5FuelfM2+/nDMXg5Nfx06kJ0Lmn9u3C5bVTcI/
	 dUA50wQG5XKItQtlMRrS7ynUfRhPemdyDXSRmysVOEs4V8Q/uVaas6rYp0cLUOKx8kYLY
	 KTH213IKlHQ5uu8hR/ftYXQWhhQ5d3IuO4ASQo+lcyXS1aCcyG1jzlulh9vCMHwRpAvJD
	 nAep+P+C3AUPQB9bPMSjHJZTEF88kTjVPEeiC7un21XOcGuXoufrCWN8xIG/Slp10cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cfcx0aUB;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4D606A33A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B4D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cfcx0aUB
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so597533a91.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206056; x=1793810856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
        b=cfcx0aUBBloC3Um2WlknXtcgPAeg79ARaWM8Tl4TpAOirDcdDRZqIFMul28wC5RDm3
         +AkumzcabixtTUqsMxodkmyyeN7HIFpfXLJA0401sv8QNhz/p+J/4WYZO9KmHiK1nlmT
         VYYwb8OQSZuJ/OwiNiLRjVAOzMgL98VZmVDiwa9MZZRbAh754sP50GmyqUynEYeTl46q
         w02lyuHxKMUOZol8RXUqPYmMHgxtgHQHWJn+FdbYzX+qFUvpyzC1lgMpLKY1zkiYXPDz
         0+TFwgE4zifM/jcdBp/pv7yV7xJrW75xLyuecg/TagLnP9SzwWxiv2C5TSONgGWcvuy5
         oVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206056; x=1793810856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyc8C+NvW8Oi6c2BSOE1temIwM0U908BwU/ZONk8yec=;
        b=ajuJUid9OClIA968hl3FRPC7P0TqTQO5pqOYkM3x3h8zMJ0sYRu9Jqg6emjFCAqqWV
         +iH5wvYhn7Ybkuhf1HgCJheJ2zL1X7oKQG8ptpGu9qe+OLqM8Aa3ReyF86ZB/iVXP4zf
         9W8hHp1AA9eno2QZwV5f5egR+NPo5xt7mvQQqKwgx+6UNDr9b4v8CCg6CoaR/hOaiuaQ
         no0dabPPQ0SiNFgN/jgI0vz8S/OtLITP/DSCE1CXFRaw9z6J9yhmTR7LXkIGGk1BYLTI
         5/0nLY7VdQB3QXY21DZufMMxVemon6trM+maCQNQJcSiG/mpujkHYkcmT7czK7j/A+Rn
         PDTA==
X-Forwarded-Encrypted: i=1; AKwUvBzhMfxMuB/YJmmAd4FreH8sKkkpbewtnLPvd5MiWrJb0NLUkcfrA+BtaNCz+gYdnZvwXXPRRCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxeBrJ2b4fJTBWpcAULITbaZvz9zqSjGEvV4QcVnebhWHlmZKI
	jnsXvEWjSFjx0/s7Pc0D/BTR6L/GqFbFCe2l7NvtJ+Nf4bydDW7U1pv1difagcS8eSU=
X-Gm-Gg: AYBFou1wSfYtGgkscPUmTL28HZDAuIcYlww5oJfSqIn9cMokgYxxHiiZ3t4yGajv28H
	JASNI59yBg2/2tqOpk0jr442FA2iBoZvd13Ws4T9V4JTPHOhw9jSDa/AVnBHmXGOw0nlJ81WEIl
	N5VtKCw+BJdQ1TwAa+t6T6zNfw2eJbap1xt2y1hkWos7tGeDoNBjrZ4OSiESQiLlKjW7B41jzPf
	RKztJLq3M3BIOxcwgF5uzZ7zQcnnP04Sx9SdHTVt8/G5EkcqhqC9Dr66k9wq1OmfdDbA4DpDPbO
	VMg1WVFLcGjG6xdqg4aXUkV2KHk/Z7EvFQAtUXGol5XAryHTDzfHRxPFulLE7zOeJTbZ1sESClq
	MCDt7eHE40f7Pd3z5i7AoZJMnz7gMcp/QrwH3j41fZ8okTcJmziAAY5aNTZT31igFflIK1nzP9T
	re6UDykmknRvQJIotw0dT9qAKIhMVJR6iilmzTAo00+5PKHiniRKjgr8+jNQ2rL+4va2k+bXmgm
	VuenNSqQ853LkrcjksXbMkrah5JlGs3C5UYjpZdSWlLe0Ng3MQG82hvGoBpTCdMY+VXD5it3Aw1
	sMOns0L20cVsqP8IWawa6oW9szJQisXi0yW8xoWg3jT+Fw==
X-Received: by 2002:a17:90b:3c43:b0:3a7:a463:54bf with SMTP id 98e67ed59e1d1-3ae581440f9mr1759178a91.33.1793206056440;
        Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:36 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 1/2] bridge: cfm: Store the new CC configuration before enabling peers
Date: Thu, 29 Oct 2026 01:47:29 +0900
Message-ID: <20261028164730.253238-2-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

br_cfm_cc_config_set() enables existing peers before storing the new
CC configuration. The receive timer therefore starts with the previous
expected interval, delaying CCM loss detection when enabling CC with a
shorter interval. For example, disabling CC at 1s and re-enabling it at
100ms schedules the first check after 250ms instead of 25ms, before
rounding to jiffies.

Save the disabled-to-enabled transition and store the new configuration
before enabling peers. Keep cancellation on disable before replacing
the configuration.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
On the combined v2 kernel under ARM64 QEMU/KVM, all 8 CC interval and
transition checks passed with bridge/veth and netlink configuration.

 net/bridge/br_cfm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 9dcc97d63a6f..28b40dbf4073 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -634,6 +634,7 @@ int br_cfm_cc_config_set(struct net_bridge *br,
 {
 	struct br_cfm_peer_mep *peer_mep;
 	struct br_cfm_mep *mep;
+	bool enable;
 
 	ASSERT_RTNL();
 
@@ -648,17 +649,20 @@ int br_cfm_cc_config_set(struct net_bridge *br,
 	if (memcmp(config, &mep->cc_config, sizeof(*config)) == 0)
 		return 0;
 
-	if (config->enable && !mep->cc_config.enable)
-		/* CC is enabled */
-		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
-			cc_peer_enable(peer_mep);
-
 	if (!config->enable && mep->cc_config.enable)
 		/* CC is disabled */
 		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
 			cc_peer_disable(peer_mep);
 
+	enable = config->enable && !mep->cc_config.enable;
+
 	mep->cc_config = *config;
+
+	if (enable)
+		/* CC is enabled */
+		hlist_for_each_entry(peer_mep, &mep->peer_mep_list, head)
+			cc_peer_enable(peer_mep);
+
 	mep->ccm_rx_snumber = 0;
 	mep->ccm_tx_snumber = 1;
 
-- 
2.55.0

