Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED18442138
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123889; cv=none; b=Z91trWMUGUrTP2EDh4qVwHw1YC5R4WpOzWCgSm3WMrZC9KbQrQe8mqxHQvYclhGt8cPETBpMXEpWqENVNT4whWzcmZzartFT18QqVuWQGi91ClrlhvBbaWlxapNyuqXW5x+qtAcc85A6fEZLiSI77l4tP6WMrk9M3xy4uARNY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123889; c=relaxed/simple;
	bh=XouwhY83PkPCv+8oPH3A0x2TeSFU2jGXltoaImnWKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvNG/40JrFzBLiQq5JRNxETn81/CYhs6d9aSGOBOOFyY3qtyrEUGimVGss+Dl1DYElbN+Uw4tJhBajkvUiL4gpgAha0nIZ03ELps9BnYaEnFFxgBdngRW7tv7MFWzDFefiOiihi5JBsmGPpy0E+OvIqrb96dm54fIuSsgvn67pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBMocu5z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBMocu5z"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso764637a91.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123887; x=1789728687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcnTM9ZGNfgVI+Tfl32IKI3WC2KahpJqjpEcR1B6a5s=;
        b=IBMocu5zu31KLLvHHp6rEsiBRcIGbZgnmxQp4brsOAkDxJvGUCK5C2XmCLLXp7AT5o
         CzTPgEjS6a0GruyItPXvfVRZV+SdEAZFDLGM7Np9hvgdnV5phPrXMU80vl0yldLo4NvS
         PPrJ0KY8gnH8Xe0e21YkOn8p2bZfq8kKnE6YZxp0lVXwAAJiKhcu2qiAJOZWR2ouLkOK
         CGXnZtnAe77zymTCbnjGAkPyQTy7Q++W2JzHi46halfILaF7mGtbDnhxwi7bTpMRaxro
         SGWm6KFvZvu2wKCZM9RIcaaepy2cgbYHdxpS9wyab5ek10KN37/rpdFkejbxpIFyMT48
         lxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123887; x=1789728687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcnTM9ZGNfgVI+Tfl32IKI3WC2KahpJqjpEcR1B6a5s=;
        b=J+FFPADLkZYYJniQQhLVY3hJLQbxlAtdQqfqy3JjwbUa4Q51CZNyyZF2vFmBvomQmA
         2EIY+yJdyBxF5FN1zDp4nvkH69HaYQ8Sya6c+Fu0WSr/GXsoD55upv6b2dNvsrYPKpIf
         2zjs/JcXiwKcl0q1jdCWs6vvfW+uLiAKwFm9mO4lSDy2Xh1R8K4NJLk8NiuI9KMbQn78
         hklKA3+g/ViWH444drlDDzskBtA309qE9oUV9Y0LBz6EEn/Epc6Xf6+Y0TKM867kaeog
         7ljSW80lKgLebrz1MgzohTjStAOCvuREd9CPWprEL2xq258RhijxrkoNmULNA/4wTQgC
         Ccyw==
X-Forwarded-Encrypted: i=1; AKwUvByiEK6c+xOiK972Jf6qzByGQjXwbjhFrIJl3TR4NUb6BZpXLtdA6Meoc3s0ABNHz//n3cuC2Dc=@vger.kernel.org
X-Gm-Message-State: AFuF++l1DKSgTOA1gKINJB+zV+vugXc9TBd5uRy7BgQZD7bjO+IydXLR
	G64wA0BfEkrgTJbGJtsZH2IX5AmxbAxT6qxcc9MQ/ETUSYl0m3P4vfa6mYwZCNOu5fQ=
X-Gm-Gg: AYBFou1Wf90neb8WV06+fBevKnN8P87qEjMWfDcWgluCrW91BLNBYV1Xk9UmavGBsaz
	QtZNJXsST6IXhsa+bZ56aRRVAwZgcnekX1l148BHdYFx15BxHGZ/PeNHmq7p0R0dSKA7uCOXEKx
	jWUZdH6o0aG03EdQoNUegQph52Adn4Igt1remKt49hmseiksoO+1t2XE0F2Vn69ZbEnTGn5cIII
	skW+iEpezD29NAcMj2cHkHlevciDbx1KkKBUGh4KY/0FljR7Di+ngSIwVrQKls2KNF7Y/xR0NkG
	9wQcyor8mDYTHog/mjFYY44m1coJSxnzQCzBsIczXyH0LrJnIKRowmpp6dH39QZj/ekG+y6NLNp
	QEGFazPJvJYvbcvv1I8gd1bvrThX/qucsmbc1zN/L7cHmt0b9mlJeCgtYCpVwPibAGmELsPus2P
	mNoHQ++vNE+miIOgBQ1xXOZ04dZDwN5E4qM/kxHXHz034F3JhitDtaEA+wGSpr8gkK9NInAD0x3
	lza2ncXkkE/zqygaOVytMKHM2eV9uK01FYHrxCAuysVEVT0G2WFX4e/CG01k2ui2CNNNHd+
X-Received: by 2002:a17:90b:384d:b0:398:e1f4:bda1 with SMTP id 98e67ed59e1d1-39d9c22ccc0mr5727378a91.21.1789123886898;
        Fri, 11 Sep 2026 03:51:26 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:f7e5:8b43:47c8:5245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bafb3bsm4876004a91.1.2026.09.11.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:51:26 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 3/4] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Fri, 11 Sep 2026 19:51:02 +0900
Message-ID: <20260911105103.7771-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911105103.7771-1-sigefriedhyy@gmail.com>
References: <20260911105103.7771-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the global flag, list the attributes the AF_PACKET dump uses and
describe how ifa-family selects IPv4, IPv6 or link-layer output for
RTM_GETMULTICAST.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 17ead2203451..1a17e55d1cca 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -77,6 +77,8 @@ definitions:
         name: mcautojoin
       -
         name: stable-privacy
+      -
+        name: global
 
 attribute-sets:
   -
@@ -168,7 +170,13 @@ operations:
           attributes: *ifaddr-all
     -
       name: getmulticast
-      doc: Get / dump IPv4/IPv6 multicast addresses.
+      doc: |
+        Get / dump multicast addresses. ifa-family must select the address
+        family: AF_INET or AF_INET6 for the IP multicast groups joined on
+        a device, AF_PACKET for the link-layer multicast addresses in the
+        device filter. Link-layer entries added explicitly, e.g. with
+        SIOCADDMULTI or "bridge fdb add ... self", rather than by a
+        protocol join are reported with the global flag set.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
@@ -181,10 +189,13 @@ operations:
             - multicast
             - mc-users
             - cacheinfo
+            - flags
+            - target-netnsid
       dump:
         request:
           value: 58
-          attributes: []
+          attributes:
+            - target-netnsid
         reply:
           value: 58
           attributes: *mcaddr-attrs
-- 
2.43.0

