Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C182D7386
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917677; cv=none; b=EXIQNtfPZ9YV2yYA+J4dwRZzq7HhLowwzeR24s/W9peOmHX8OVYY7jDWZPQqHuBiR8pu32U4jNQg5K33LbI7soZIjGNCn1pyVlfIWPpaqz48NBeU1ZLJaeCgdhpYfOWJmFKEPp5mmrB4MGDWLZsKe6BrxZI4UOAbMhnJQLLxf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917677; c=relaxed/simple;
	bh=2zQvRUscIgNiPZoEjC1Z5mtgLCeG0uKE2CLDirOMMRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etKlj6hlJHlPSnBVuW0haSqs4poE86phLNt8AXvo9yhXI/G0QL/YoaCHDOk1cKUJoAQl0xUHxZX2hyQFs50WLXV7AiYjyvNFX1QWhS52fuJpDEr9TjCijBHuLT8DTixIQvWvOMk4U74UgwTPNKxUfpbnL+pIOVU8J2Be1s8vy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBS31s1f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBS31s1f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d9520b9155so44147675ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 18:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917675; x=1789522475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=263Ot5CK8k8W50+c/iZQZai2Z4LPXqFiKiK4/FLJICs=;
        b=FBS31s1fgnJFehFVpftohOqC8/T3k5VLMTm73STjTooWd9FTe87YiML5RgMrY6u0di
         cQ97LwM7PaK5hg7h7enhSG8sbrGWhiZ+gLX324Fif/lLq/rw9FPaKiXHfUhYXBkTreIM
         zN+XtQJb1NqSWNG3ZWsIZ0N6soAKXpx1e5Lic0q9ymCeSKN4Z96AhjT0aYmDp8YtYC4t
         hUqZ49dLeJh/SAc0Xzy1xbQhCvW8ok+eq5ou4+ogB2FtewnYuFV7keCR7OFuNo6M4Ban
         dlVFUgjyydQUO0QGJRjfh4yhaxjAa/kAToXkLomPm9MnZ6YzNDbtFkETUhC++SMnJ/Ei
         9ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917675; x=1789522475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=263Ot5CK8k8W50+c/iZQZai2Z4LPXqFiKiK4/FLJICs=;
        b=eaBbvtxgS9H3ed4bv6+uDoYCa+iPp05EAi5PqLK6v/ucXmgSJH7JueLCR1IxXzHs6r
         LoaOBE9DtGrUCEvv8OS3i6jTIxNIv/7tGiH1aH6Cks0zyxdFrKJ9OZqle7Z8mbvKipOE
         ns/NVjmuXZhFqVBzfcvWaAg2xz5CHUNVe69A2+dWCxXc6dZS1TYjQg8akT+rlF4nynG7
         80nMz43FH4HowB7nBDJtkU5wtskz568h+QPbywKr094lHogPBRiXvrFGjT6E+YiVOdw4
         vSzBLF9C5w+UikJlcbOSBZbv+X/1Ao54e5mfAwcJFNMjJUFCnSCt9k2PrMHPvMBtaEhU
         CWXQ==
X-Forwarded-Encrypted: i=1; AKwUvByhkAI54giCLl7HNnyHol+7gbu8dLIaeFjLvYd5N0+oO4XP02+P3psA9Y3oSzeW57N0sz+eEm8=@vger.kernel.org
X-Gm-Message-State: AFuF++lR3YZvfEQmxZIAVILJB1KjkpGQgSbDr05CbGPRIoNqhhzPKcWV
	/pNhtCAcfzGPQDHD70X3boTCvyW6MrH1FnXjZM9zwlWlJVI2UXI3coBk
X-Gm-Gg: AYBFou0Xmgpz7eDpYB5Xx0WGpkrX5libKKnL0fxNuxcKIyeJeOubChwMmv/VYmUU2VX
	LExZEUwHNMrj5YayBpeHM4nO1RlskoM5b7/WKgbw3qtJHq76KdgtBwLVvNtM6ppf5UN++xFl0n0
	j278dvTE3tHwj/r9z/4TLilgutYRufJc5AdiuKlX7JZmXxpJm7lvGxiq6BseZ51rAR+HE15HVDL
	cAqO57xnNxshVlVbpGkAa9Udma4CEnWjqlY7ScfmTVfaVbzGBgi8HPEmE5rkTbcCL1XQkkeN1oO
	jAwga1ZWXjgrZccEuCqAg6WRsCXkrmILWQGfkGgMVhkDlcqRjrLZsyCdfuPhkFxAbfnrLQWTYKP
	q/+MadJTijHGgctkxVFj+9Aw7ZTCpQBcRQ2tKY9FnXBJlRfx0cpzk6WyaUDoZK0o9tftqCfTpVG
	a0ytJ138C5h2tSo24aMkdlP8KBH8fb3qa+TAn6J2xtTer8njl8oH/lse7GY1CbxHO9HUOsP7Yt2
	st/GeNCRm9k27dcns9KMfQMBUjeRAeFzQoWiDN50D29oVE8xcC2LhAvkhR/ZQ==
X-Received: by 2002:a17:903:3b54:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2db127c02a1mr331886045ad.10.1788917675355;
        Tue, 08 Sep 2026 18:34:35 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:574b:e1a5:307b:15c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db63c00837sm27975145ad.40.2026.09.08.18.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:34:34 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH net-next v2 2/3] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Wed,  9 Sep 2026 10:34:00 +0900
Message-ID: <20260909013401.14408-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909013401.14408-1-sigefriedhyy@gmail.com>
References: <20260909013401.14408-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention that ifa-family AF_PACKET dumps link-layer multicast addresses
and what the permanent flag means for them.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0ecbd24c890c..2a2310cb0df0 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -168,7 +168,12 @@ operations:
           attributes: *ifaddr-all
     -
       name: getmulticast
-      doc: Get / dump IPv4/IPv6 multicast addresses.
+      doc: |
+        Get / dump multicast addresses. ifa-family selects the address
+        family: AF_INET or AF_INET6 for the IP multicast groups joined on
+        a device, AF_PACKET for the link-layer multicast addresses in the
+        device filter. Link-layer entries added with SIOCADDMULTI are
+        reported with the permanent flag set.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
-- 
2.43.0

