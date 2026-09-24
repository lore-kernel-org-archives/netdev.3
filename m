Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920532143D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212586; cv=none; b=TLQJyFuJ8H/k2NEJgj4WU7cX7Jn18Z4FuZVL/2M3INYM1hveh27rF0okRom70uEgpJ3jWjnBqsa+MDj/7AhiYam7R7mFnJ3+KCq9tsKIwxJ9N44Sl4tanxvS0lvT4HrQ+wIKANbPfdobRlmYGAuhInQmjOFL5+D4vU0Xk5VdOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212586; c=relaxed/simple;
	bh=7ym8eCannUJoplyLEig2XRjsDs0s3r99iL28MZ1+Bek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opxUYjE4uIOu3C/NIIwGejy/wqHNV5FerezIpkZ25K/lFCRRrgm2Ca/MzZ526zRl9A0tleAWq7AHEqt7faqU2CrotDAA5ElSZ/kKrKb0W+xef3GQz1suuvlKCuWACHqir35B1mPHmM8lKx+E4JhXER4WhphY80KUb5HWFnEf/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fenFzEF2; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenFzEF2"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so1034477a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790212579; x=1790817379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvI2CLJV63upsK+i3iXF166plHPTeUWc5AYad+dRYdo=;
        b=fenFzEF2O0cZvD5d06ENW2dfKhk2xFVq0NMBxEQ/mtnR+ONssC858jxvzTfpL8d+ot
         A2CGGX0c5iwpwl2A7oNvYyC+bXxXsDvJohOHTffCSAJeBcPh67MAih4bqaWgrz5Tm9Vz
         pqRIzXCqcyfgOi4WdSC1gd3xA3aBOncSiF7ra400VTqSbiXBNR+0Jvip0d2riIAQE8zH
         qKhuSQ0GRHDvUyQ+9aqFKz+ws15TD/UyjEeJPpDL9xMkY4O1kgqXnq8MZePguiaZVGOP
         jewYhCjfI0o5z/rFpNuzB0uku5FpLZmjSJ5RCS0SadHv5I1cqL5Ey1F/QILflAZuxFcU
         kjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790212579; x=1790817379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvI2CLJV63upsK+i3iXF166plHPTeUWc5AYad+dRYdo=;
        b=ptzV7JwoL5IVafYA980OVMdxPymxF4EmYo3KTCCahqIFtpY1qo01donZpKN8WC8J1F
         e8Y+p+pUb8M9bBAYea69CncgbqOVM9hTcLVsFpGHXR4Io6cENu7QgYx8mMv4b53WnaeD
         ehLn+fMSf1AriM8G8fEo0cHMTTsk+kdy8huKKR045lerLgAgYFs3OtS7orsj+EbXrf27
         OXyMl8WjfOGpY4vR9ye5YfURyIaEw/Nbq3Zqra/IGstT4R2uQhaPZaAeh/jT/S2Tdc+C
         uQxHXDXmu/xDNe3F2ge5aZWScivo8ceJXSMx6aS2fP+UiGUCtLjQtPBUYCV/IwkzOLnf
         qPJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwz0L7bbaEvyjw9JBufOIhaKxC27sez+AM0GsTl4nqJQkTDkI2K71NuEiXqfnvcn0oXYoj5CrY=@vger.kernel.org
X-Gm-Message-State: AFuF++l+obZhZGshidPRMBWynubc/jtGXKR6eOSmcFxVxf6BEd+bprtM
	KeuBwlIxK18kr9e+MB8ct1JTgeHEdvYXMwd5I/y6SdZsl8veh87WWSrv
X-Gm-Gg: AYBFou19xvCRQf0NbVfH/ZiA85FOCIODjm+qo16C/DZdKX8DuuhEH6RimNch+aE1rls
	ZCrFFz8vMWjwxQkSa5WARBCaAJXSN0IFC7kIog6XsdYCT0ODtnRvftaNWYBbbVvxNW6TEiVZin+
	OsT9/NWS8cUUB/2i0YAlcLMzRbuBndgNailtOOTEoWT3dSV4ozTovBBSyGjy4u7Z4rcidvKax2p
	NSsWZWR2V8LU1sVWc6d3J+KF6X5tumaKGS43yoWmRT6+Cz6d/RlEwFOZjWn4yjnys9XMP8E4TGY
	q+iKIxTW3NF4Jwor3fzCmdKsDHZFYpCpvXcL/txMRwskKu2fahpDCZAANzntUauxuFfinrX+mtt
	KUIw4FWN6gGxAYB822BN/5+xWgeDlTW/ouhObEx696hMfZfsMY6JgBbztwMxB8/OyKNo1uAuduE
	byh4KU9Z7K09FJgnBBpubo+iZEX1DbLJKIE3Ava7S81P1GDitpzJhxq2vpk6MUYDystEFsLyk2/
	Zpeo9WEonznRQ9fGN34cWCl/p9Be3F+yYN5DNNHDUABuBu0HUpxAJ/iggN5bRrh6YDX0ql7W/Ir
	VRH4CCwicaI=
X-Received: by 2002:a05:6a21:7104:b0:3dd:d887:3e28 with SMTP id adf61e73a8af0-3de0ea5ce7fmr671544637.74.1790212578717;
        Wed, 23 Sep 2026 18:16:18 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3d5794sm1741392a12.14.2026.09.23.18.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:16:18 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 4/5] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Thu, 24 Sep 2026 10:15:53 +0900
Message-ID: <20260924011554.3494-5-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924011554.3494-1-sigefriedhyy@gmail.com>
References: <20260924011554.3494-1-sigefriedhyy@gmail.com>
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
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 17ead2203451..dc5c0ce259ba 100644
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
@@ -168,7 +170,15 @@ operations:
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
+        protocol join are reported with the global flag set. A non-zero
+        ifa-index restricts the dump to that device, ifa-prefixlen,
+        ifa-flags and ifa-scope must be zero.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
@@ -181,10 +191,13 @@ operations:
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

