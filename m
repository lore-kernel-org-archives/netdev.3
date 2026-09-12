Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416F3346B4
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176769; cv=none; b=p5hSjJPjgTWmFdSiHqg+8z8GNctt1jqQi/0DyYybez7K1J+Es5bEMG1y55ogK7Blizr4T/vjvnHrZz0shU7caUi/PtKVXA8XRIWIRTh4LgnXfVn8vwKOTLM3nQVVZUiYH+83yZaBxmWuZ/qhg68CMXMBgyetjhroF0DvP4udFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176769; c=relaxed/simple;
	bh=2YWlYRxSsd59Cxr38HsvuYWsNmqjwpeBupscQi1Ng5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWbCETjdICkoGWJj0PB2rtNe1cgqbmnnK1CoP37I7XUPTtSeO3yvCE1227ttQvyKoztmD8q8HVB2oHvbOcuO6PJk1dDNvsW+D2Xwx+Emlb2NB+wa+I6jjFmL6dApBEAiJCsLZ+8e/duDDVM+Et5YMD0Ln6FIWQVlpKHoJt8aAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9QHlgnX; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9QHlgnX"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-7935ecb5d8fso60311137.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176767; x=1789781567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6zxdqyVH4a+n8GPVigkqqRm1GgEw+7DCMINwgLF4EI=;
        b=j9QHlgnXsT4NQZonJ+JtKonXH93+k9MPVA7b6zogktrQxHlxKE/fbz2iu3t1ulUfd+
         eVRo38z6PdCvVH8F4PaKFbRvsmLK8duXXhPCCu0IlWzwz5k/SHwXaQqubGD84ZRk68Mq
         c0W+80+/lgzwfsPeYMi7TPX8RCnYrNVYozP/rk8hzlt4/KDMEv58x/V7vIdgHUlVTX9G
         pffx4Ht/vtnIGdWlOpht8rBdNOheZotOT2FCRqZIzzzi8IIunfjWpkO6XGfH/sOHRM+d
         0PH+yWXOIA16UygBYdKm7379+2nzVGD1c93LPg5dt2NDJU+3ICw/ysEdLLh0/SSId3d3
         0Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176767; x=1789781567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6zxdqyVH4a+n8GPVigkqqRm1GgEw+7DCMINwgLF4EI=;
        b=rjDc66IHVrwtyEAWtdXJZnC2M0yREaaaClyS7c6YqSa8QdEhDVpn69ANf86Qn45uyg
         gdGvBYUS58B1xYAQDcXHSlVLj3y9YszincMQdsd1iPgX4qthVma558DcCFLpPir5JoN2
         L8K9JbUzHeJmvWco8AMNwxFeIT1Zv2+J7jGie6UE0tWxHmGw3z9/6AVBO1Fgi10bq6F2
         RAjCBSnMrmLUlbmtfLfZkSVLAmdaZWExG1lXyK96cs4Siicub5XTj9GBCQdK7U5Sk3ul
         J3ja6+6nUZ63ZFM1n38kvA1GWaKRo4IGTbzYdyPG7sOojVhTZNaTwVipdbrhV/1t3F82
         tzoA==
X-Forwarded-Encrypted: i=1; AKwUvBxpnHk4VL6/Mo1ji+16CZov3TM1kfTa+zmezWs/UEAh0QJpEoRQxuhmrsIU97D4VisdjnbgTtw=@vger.kernel.org
X-Gm-Message-State: AFuF++nSoD1g8FeIQD7SnNcfooGs4YGjmtzA5Oji+ZrEL6LQTHHVuYA+
	xLJ/F96qHxYtkYfxt5Wk4QPlvBHL0kUTUAbEZOE6y5RI1Y5Dk3fBrvzo
X-Gm-Gg: AYBFou1MZg9PD6ss8b4VsKcC6IXjbec2zOdtrqqbFlnWlZ/lje7eK5YKLYyY+al7oqI
	4tD+sA70tBajEdvLgNEewRceTM53ZkMwFP47UZ4dANT/t2ITBE50vyMXRfZFmILgB2z1Xq8PAXL
	Q9idU8HjnGp+3AcXuuw1Fug6f4f2i9NQiNL9YhVsl+EnXaCamI7BsngLYs4h1FvLc6XZcTea5wJ
	OPo1W9erXCPDRijLMKltyWWAUHOpIvwBqO1OqxBvJBcqqKkyRKSSSeL7ykSNp1wcm64Y7haH1l5
	wtvrpzrh6YzM70kEYQTlcsRVhakxXy2CzepZ4twVCFyXBoyCw3NJ9KUXWnnRR/jIeVZdme3CMMQ
	RigouLcAEBLpMjQ/K7bj2O9zx732xmBSUIi7QpYJTJVNeRVHSVSVTVS4i0LuaCn4nndAPOMypSw
	DrOL08gYz97gZWan76LvkqHfr+UxbY53sdSgOcCTUnEJDE3zjvgsTbVtATcb9z9G4=
X-Received: by 2002:a05:6102:c8f:b0:78f:7135:b4ff with SMTP id ada2fe7eead31-795a65b013dmr913468137.2.1789176762542;
        Fri, 11 Sep 2026 18:32:42 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84714c380sm4738262e0c.15.2026.09.11.18.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:32:42 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/4] ipvs: add flags for per-service secure TCP state table
Date: Fri, 11 Sep 2026 22:32:13 -0300
Message-ID: <20260912013216.588300-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260912013216.588300-1-adrianox@gmail.com>
References: <20260912013216.588300-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the flag IP_VS_SVC_F_SECURE_TCP to mark a virtual service
for the DoS hardened TCP connection state table, and the
flag IP_VS_CONN_F_SECURE_TCP to mark a connection and then
pass to the TCP state machine.

The connection flag is included in IP_VS_CONN_F_BACKUP_MASK,
so it is preserved on the backup node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/uapi/linux/ip_vs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
index 2c37c6ac7525..34fcfaf13cd3 100644
--- a/include/uapi/linux/ip_vs.h
+++ b/include/uapi/linux/ip_vs.h
@@ -27,6 +27,7 @@
 
 #define IP_VS_SVC_F_SCHED_SH_FALLBACK	IP_VS_SVC_F_SCHED1 /* SH fallback */
 #define IP_VS_SVC_F_SCHED_SH_PORT	IP_VS_SVC_F_SCHED2 /* SH use port */
+#define IP_VS_SVC_F_SECURE_TCP	0x0040		/* use the hardened TCP table */
 
 /*
  *      IPVS sync daemon states
@@ -89,6 +90,7 @@
 #define IP_VS_CONN_F_NO_CPORT	0x0800		/* no client port set yet */
 #define IP_VS_CONN_F_TEMPLATE	0x1000		/* template, not connection */
 #define IP_VS_CONN_F_ONE_PACKET	0x2000		/* forward only one packet */
+#define IP_VS_CONN_F_SECURE_TCP	0x0008		/* use the hardened TCP table */
 
 /* Initial bits allowed in backup server */
 #define IP_VS_CONN_F_BACKUP_MASK (IP_VS_CONN_F_FWD_MASK | \
@@ -96,7 +98,8 @@
 				  IP_VS_CONN_F_INACTIVE | \
 				  IP_VS_CONN_F_SEQ_MASK | \
 				  IP_VS_CONN_F_NO_CPORT | \
-				  IP_VS_CONN_F_TEMPLATE \
+				  IP_VS_CONN_F_TEMPLATE | \
+				  IP_VS_CONN_F_SECURE_TCP \
 				 )
 
 /* Bits allowed to update in backup server */
-- 
2.51.0

