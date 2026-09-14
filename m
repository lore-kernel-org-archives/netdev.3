Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737F2E7396
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350368; cv=none; b=Q9n2ZJocMQptkeGBz+qwBiun4/EHnkxKzR3vAs+sMkyib1fRrD2m+4mY5rpd9jAxmYOgy7W4ssrqmj/Hg+T4j/fXmxHdT9jKL/tw5f3R+sa37CPMf5LIwubcerXg+Oz/g5AG0HHYU4CcjefWGQ/8z+3nW0zawKsbqe/mRzZ2mT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350368; c=relaxed/simple;
	bh=XWZSGWd0VF3BDk2Yg1A/EXE1uFX53VnoBEuepPt1BZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zefqp/xo6niywO4oqF0uz4RcPny8GR2oR80DrgJ/nkYITmEm/NQyVNo+TEfeqadURaon3WYTLMz8UTO8ofBjhy0oH/6kCArx8KZj3zZtwVYV34WsaDKD62QjG1rTVsAOMqOFm9NkzkEBB+Q5msG7CUf9H+Q648tNbIh9PPx4XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR/bgdsP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR/bgdsP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1072330a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789350365; x=1789955165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6q020bOQ0jwuBWM3LeSY8k8HYujoeSZlWF2NlYzVlg=;
        b=DR/bgdsPljUgtaFRX/bjYdAttfefBZcB7asPvpvDxFZ3heijMUWoQ16Cw5OObbBWgB
         KoXZUiO2G4+kPw0afcqGPKzIjQpKnz0CTmxT27DkjGbIw4XfBQ2liyHcBCxGCJDEJoWj
         LBL5Qh99LJmFAXb3Gm7BVfrfbE4qaTCNLXljx9y50Po6Ic5aQM9tB+FQQ8D98BDLxouO
         BRD1rjSepQ3EyDbHbefwfmwwyFu2Y4DpWDzZyHCiZrojTGf0FdogkGN9+mlxpq1K0hAo
         C4KLV4gM4NcP5CdwpZwIhVHq4jXR0v2RnAxE8dyRaGOm4ozslvXHnERq7LwdBixAJIYi
         hyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789350365; x=1789955165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6q020bOQ0jwuBWM3LeSY8k8HYujoeSZlWF2NlYzVlg=;
        b=Kq9tWjSVSEvEKouPsfA5h96GfuUOyH7qAGtSCFka6S0FzeBcoltohrEpQnMUfRfgnJ
         mR3TsB8FWxA1+EQdWlv5bkit3TX6+oSBBsR63SQh272BeZdV3RVWZwf/RCC2PXNAmsvt
         9iHrT1tkBnR+P1WrtMdky2lTrPly4g5UVUyr8kQFqoifTwmbMa2FmCCb/Bv6qvTYj9sM
         jc75zd5DZQzoo5Z+DzA2gz3AKEn9W+Kndne8/VWdfJyYOR5WX/I7iWtPgrfDIE3hqdPC
         zX4QGIXYB8NF1+hHibnaFUKKx1kNyD2vZM1N4MwnMmjFgNgP8nfE6gNDZJP9Ocj1TiFf
         iS6g==
X-Forwarded-Encrypted: i=1; AKwUvBzOCCL331lOZ51Txd4uSn2WYmEjCftJAT6KSry/KIYaCQsOxXysVRZnzimS+1QPgE0m7iOGnJo=@vger.kernel.org
X-Gm-Message-State: AFuF++mR/vP/ZXAPq6seCytrwR2+cX2CWsmf6KZLeOobXHCsrJb9NQ2z
	0o4aAFYLBVGHXWOn6EBs/dJLGzDsnpk8AsgIFCP1yT6CIiCjXd+qqx0M
X-Gm-Gg: AYBFou2SI2xeKD/1XqvyJ29rUbf4ALn7wiA0iun6g7+rl+rT4qIOwbA2VIHNRv+TGod
	sXF3qGtf01ZYbuH92FfkY+tv2aGoWDyvdXyBtFN25yQAeZ1342ku2ythIhhD55CPWKGrZ0F4rKG
	td63dcRmOsfngw+QOG53/W1xFmrIlVcHVodWGLDef/VsYfeuvaAAI2gqaKyYwJaC5vVB+yhaPql
	GgZ2CzlmAL/4zwYoK1HQc5D3pPcmxaCy4A8Gs3tciJt4KHVmpPh/xNO4NLCP+yyoDc7KajYxqIt
	t/GWQM2dBk/H1j+PMn1OCD2M9nQ5mPHPEK3tD/VudoHnZU+lnYeiK6gmidwe3aQJjSBRwVmOn0x
	7v9Scw4v9b6Pt9WHJyBbirJZqYtiFrFDOTyh6g4lsxnZtFVqxm51oYV2VrmoZfEfdvPBkemH8C4
	d0Dc/Yam6phI9nxViqvAr1hLG+dutIrpe6fmOPBqL4Z6UwtgSyFt57RwPb25nX2db8hz4gqFXZP
	DgUHAwKWtaxEJ/oLJaQ47ujfj5fiX3A2APwwFRpxfI3SN4=
X-Received: by 2002:a17:90b:4f4c:b0:39d:6f12:fd47 with SMTP id 98e67ed59e1d1-39dec099eddmr1038486a91.20.1789350365102;
        Sun, 13 Sep 2026 18:46:05 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:fd07:4a24:951e:c85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d1056sm17513403a91.7.2026.09.13.18.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:46:04 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/4] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Mon, 14 Sep 2026 10:45:38 +0900
Message-ID: <20260914014539.5015-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914014539.5015-1-sigefriedhyy@gmail.com>
References: <20260914014539.5015-1-sigefriedhyy@gmail.com>
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

