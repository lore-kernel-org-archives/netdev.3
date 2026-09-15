Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1A3E8695
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440372; cv=none; b=rfXbKzf+8l1DjJ001MuostthhbcP0/hufsUtaSvlBFVKt/kUwJjaU29tiv9x9xpM1CemIT97hW9pXKaPxZY/AsOYI7CRidumJzCWZJUOpLYz7EmfwuuQkcd8X9MWBHTbVLlkPV2ALi0ErAgr3F8/URWhrcls8IB7jMe3Z/BRO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440372; c=relaxed/simple;
	bh=ToJwOPk2WK8z4t0Q/cg/SldPxvCjqaZQsoAtu1CrDoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxnuRRHaI9fomGoX5Ho9ihlJSR/R/0cYcEbYYYzxUCx9fLOefbyz7qiYowYzmPZ8M3G1h9EVpCH4corUi6XQ3gO8jbimyBhqWmkyJRXL5Bv6ToCgdGvDDgvgU9RMZZZtc0wqxv7yenjPm/0AFHvf6eFqS1wXbxHAJbUGJlxvpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRgxholv; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRgxholv"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396a51b2605so2012616a91.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789440370; x=1790045170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgURIhAvbD9pnXkZkHKGIs3ciuxgkl5nV58X39EDlbY=;
        b=VRgxholvyPXZuxJXVgVZVP775CV8GwuKJX759LAeyfIgkKL7uzFr3Fn0vjkdMbfdG1
         Y/aGGECPzS++K/cvmuvsrLg04Qm7lelQz3DiHpr/6kHVUB0yfG3lfYaz1apQy3Yl9NHI
         XKghiriC89C/EJ5nlhRAK3GD0DF4OcJEJEbMrzTPJIDTFdxhcxd+TNxOcE1i7jTzJKXq
         Pclixyr7v/wcqAa/e08NmovtvPKizjt+QeKPambK4K/r8rcdXhSq/3hytkpVXCE+MStJ
         E8C9OhBm2jGSP6FvLwr78vQ0FFpZzptaaRFe7zk0nI+n2RWEKIrTcMs5JH09a/EMm/cu
         0Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440370; x=1790045170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgURIhAvbD9pnXkZkHKGIs3ciuxgkl5nV58X39EDlbY=;
        b=nVr9SgJjgLJ1AlpPR5t8q4VdWVliCv682uSe5/cbZM4+eY2EbK3P4fhwW5e7w5ZXB2
         qprjmGfUcdw3GQEkyf3b0M7Q9uaFGdkoOhLt2/y5/vh4HwjItAXhRApn3Lw9ldoFuYZU
         0Ng52ywlyoZRT7DUWMVScDIgLyo3j8Yh/geZrr2Drmx6qynK2jwTuinBRNaZ/JoEF2kB
         LP0fwdE3EJn33AUIq6LuHiKxTINzVuj2KJAvhqeQ5xNJ9LkzAWnLoYW64Iv387Px9gTA
         HcdIvyR+OCgus5VcgKc2husO1Vomjd5fOX6ZFoSEk7oAgCft294XuWUqldGF8+EGX8nb
         lDeA==
X-Forwarded-Encrypted: i=1; AKwUvBxWMp0usCb4T7CgE61NHP6q6rK36X9C/mabBAtojdjNOnOskAUQa/uVf4FmKYWHbGQmuLly2zk=@vger.kernel.org
X-Gm-Message-State: AFuF++mD0R5VY0zcrwNq885WI4bnfWP3OknHJCtfaqTH8H3uXw9QcpAo
	th0IkL2Rib7p1wOt/BFWJVMq4UiiRlqpxlpT3Am9R3eVZ03q/j8rYWQL
X-Gm-Gg: AYBFou1RYiuDmo2+nNN/KmyMl3bY98vDZVgV34N02YMjsOef7QUDUcUbJHOTQYIReTO
	G2J+P25zEq9eBPc0jX5nfkBaitlJLknWCNunlzPuoZr5OQwc1+8TuJW/8vTuWM+oxX/9JDq/Nsc
	LoO9raxhPoiPfhJzNRU6GZnDUivNjsEsdO05+eTAGIigC7MQphpFfk7pk3JydtCdFOyisQHnzcN
	ZnTgL4Yr7bJBl2heXpurMnRCgghlZxLDOHC7Fi9VhkN+lTajsSBqigw/aOYVXSzW4n5Q/YDXEvx
	azZ1rPNFWkjQKxvHL9gAjsYB2KjwniOFjKQwF6jXGnhbMpDsthzu4/L05vh0kUg9/MqrmwjAox+
	G/szbtHhW9dEnyHTGhy+o3l/nFobj8JTL+IbPwKUcU9p9DQ0OgO0nLHhKeWwxcddpmm4t8OTYTT
	ENt/g6t86iH4cfx2HDi2Fo57bZ+gVbi4xxiluLEBRaO9/a/JrEdXxZ+fO0lt+PfJ/x9WI5sj2Gn
	ZCaFMGDRM5yy+koHECrn3Ysf8BBv4TzwEi+9mptmzkcIzIc/zcnB/yCZ+lHFHg0PgVxD2Kv2mB6
	vAekco434U+6b0H9t7Ckx3Vp5CCGu5WNkzjdZ9mVwPuW81UzO9Jsnniy4/M1JKgzkYw=
X-Received: by 2002:a17:90b:35d1:b0:39d:f189:48d6 with SMTP id 98e67ed59e1d1-39df1894982mr8808021a91.4.1789440369772;
        Mon, 14 Sep 2026 19:46:09 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm26779949c88.8.2026.09.14.19.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:46:09 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Petr Machata <petrm@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Grzeschik <mgr@kernel.org>
Subject: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU check
Date: Mon, 14 Sep 2026 19:45:47 -0700
Message-ID: <20260915024551.196126-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The winbond-840 driver contains a check for boot_cpu_data.x86 <= 4.
This field encodes the x86 generation (3 = 386, 4 = 486, etc).
Therefore, since 486 support was removed from the kernel in commit
8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
condition is always true. Remove the check.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/dec/tulip/winbond-840.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index a5581f1d0141..c42eaf0eef64 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -876,24 +876,14 @@ static void init_registers(struct net_device *dev)
 	i |= 0x02;		/* give Rx priority */
 
 	/* Configure the PCI bus bursts and FIFO thresholds.
-	   486: Set 8 longword cache alignment, 8 longword burst.
-	   586: Set 16 longword cache alignment, no burst limit.
+	   Set 16 longword cache alignment, no burst limit.
 	   Cache alignment bits 15:14	     Burst length 13:8
 		0000	<not allowed> 		0000 align to cache	0800 8 longwords
 		4000	8  longwords		0100 1 longword		1000 16 longwords
 		8000	16 longwords		0200 2 longwords	2000 32 longwords
 		C000	32  longwords		0400 4 longwords */
 
-#if defined (__i386__) && !defined(MODULE) && !defined(CONFIG_UML)
-	/* When not a module we can work around broken '486 PCI boards. */
-	if (boot_cpu_data.x86 <= 4) {
-		i |= 0x4800;
-		dev_info(&dev->dev,
-			 "This is a 386/486 PCI system, setting cache alignment to 8 longwords\n");
-	} else {
-		i |= 0xE000;
-	}
-#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
+#if defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
 	i |= 0xE000;
 #elif defined(CONFIG_SPARC) || defined (CONFIG_PARISC) || defined(CONFIG_ARM)
 	i |= 0x4800;
-- 
2.43.0

