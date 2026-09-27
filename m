Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC6254B03
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468713; cv=none; b=UYJEYtWFK/a8KA0B1C2/RYBR6N36INR4LBW003eBOvXRukl9kpJyC9arY/vfcld2ajDvmlKiJWMTVVM1nGHYFlnUk3EW8qovq6/aU9ZfcQdgBBsOe3gZBjwKuacGFlQ2uk1W/1gXjxRiWJ9QCL/XlfKTswcWNgp0tuiq3gPieXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468713; c=relaxed/simple;
	bh=7ym8eCannUJoplyLEig2XRjsDs0s3r99iL28MZ1+Bek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXILF+7OKkIEcVp1kCFKnYxniBJco84usumrOT6zE7AFY+nesQRFhRgaGhVtpz7RMCsvJ62yQcQOOe/XzHvJiA5XbW1CenyWQEIwR4Wwe7nz+eLYvgqwECChNhnG2bRKv4MSP1mVfhMkY7VBgxMh+EKR+VsMMB4TbY8dkVL0etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKoSBqW/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKoSBqW/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso1433559a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790468711; x=1791073511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pvI2CLJV63upsK+i3iXF166plHPTeUWc5AYad+dRYdo=;
        b=ZKoSBqW/7ZRkpRhuvjRWeHx3476/nIQGFnuum4MibYlUFK1BlxAxmXzYccMevn8PoC
         DR9q76dgVUQOh2P8Ms4HF1RH/caX4KL1CzMc8227aZ1mTkBx5mgJGtAm/RKPc7xNXEsh
         6e3XetlppqKKFxy6GhQfSXZntewnTfDmXZ5cqdqzkaKwGPXyNU3wtpyZpkixpl0FtWzR
         unxVrrB5wgnEU3ADbpVo6IRlCqURmkxs9wQ6iplrHFdGF8uya1LHZP59f3mrYTLigb5m
         NwLCWmzDlVuZ5NI3FK1hnd3cglMNQFPi+hYyOHVOaSj3czuML8kLwJGnj8z2UmxpyjpC
         uh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790468711; x=1791073511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvI2CLJV63upsK+i3iXF166plHPTeUWc5AYad+dRYdo=;
        b=JqEJ+UHQxk2frxNn8cu1vh2pd8f+DtchJg48kNLbDUfktjT7fbnfGqfGZ08mrHlgti
         Dak+zzyUaI0cUk20b+vvrjTakpEgv0BdNUtfuAVQg9tb0Jojqz6cz+eNgbHjjeY7sndW
         HnqUhHlZoOjmiqiXReSCb4jFISbXizvAco4D5uKKHT5MoYrdUsWnZ93EJBFNBHZS8kuF
         sHLyKZNoTEUFZLHZ+W2n8OQgFjIA+IklP9cbrF5HqE0pxMjBDuwvE3fsytHv/rYwTsrh
         CmFz2uHZuteHfMNUEixaCYfCQyfU28cj3mif6mRyWdxNs3ubTt0shdPdtMEjHpX9GPp9
         h5EA==
X-Forwarded-Encrypted: i=1; AKwUvBxDwSIIr0vwq91fyEu8CcvczQiI+vlR1aG3YYzTsh3NJ5/mPGvdhfZRNiPIkzLUlickbc/lk9A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOZPFd5zZKK08l9rlYIbVJmJv8gZI2kSaX8aZlApwbdAk6T60O
	0fj/TOf6zJxDih0cpOpFeRNNwWIi6zKbkJFenPWcPqWRyqayrlsnq13q
X-Gm-Gg: AYBFou3aJVwXYkNZolFuwnBBPs0aXiLUonSESWyobOKFN1UfiD1R46voShBKK0XsG8R
	56vunIP6nU11z+WmKOgq0lHMsKK342La134/kCDZElCPi+wBCiGxjPpVA1nwyyBgKdygUNOwnt2
	SW56S8jz4CHQHdH2g/FpIZYfCAbWVZbKkIBRRtSxxzbAAaGyzkQ0y5RKOR6Pm/uB+HHKVmr4Wcn
	Zy12u/b/y6jnvB+1ohg+l7+c0sMLZ2xfCWL+rTnH8H7VluJVFM3fpGAeQqtZEGyIKlkMd9MRcGM
	uhgmzOT/19MCzBxBfM1JMky7yQc/ea/YoilBvxepn++yfOw+Twut/T2bq4RwpWproqxxeUqhRtT
	a/QB7NbomvYD734Zom24wTSzA4OMLm92wovCQaYWrkm2YtbGvD6gAi58fs5qEt5Q9lELDnQYhcO
	20hxB+RZH0HxWVx4ZGjoPSvJe8vNNGXgjJ3Xw0vPtmOP3cNVPnyyRDw3fcOiJ/geaZOGOyZ8iA6
	5Ed04AsnVddKNr952hStG3hln+rZ0VLFzoxCii+JM5cuTgWg7stIQ3jc+ge
X-Received: by 2002:a17:90b:4d85:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-3a098d9612fmr8725519a91.21.1790468711049;
        Sat, 26 Sep 2026 17:25:11 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:78b6:7bf6:b1de:12ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c680sm2698224a12.16.2026.09.26.17.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 17:25:09 -0700 (PDT)
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
Subject: [PATCH net-next v8 4/5] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Sun, 27 Sep 2026 09:24:26 +0900
Message-ID: <20260927002427.4519-5-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927002427.4519-1-sigefriedhyy@gmail.com>
References: <20260927002427.4519-1-sigefriedhyy@gmail.com>
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

