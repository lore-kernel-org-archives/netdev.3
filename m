Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131AE367B77
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585594; cv=none; b=PYg2RLV4PNvBMhXzjLtq+bosZkd64fwHYodd+amga91Aute/mEkKz8O4z7Uk59cOGrZ0+HNhreB95zzp4h42sTQhG6C95soRW7ajrFBPfH3kH7Z0t+75VPZJvHHGVYEX0f0s8UUKrGyShQmk9su8+PC0XaTTA5YxRrEj6yIRME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585594; c=relaxed/simple;
	bh=sdzykupViogycc1IkiJSYzUXd4kKXkJ1zNbTv9tTNXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHsTzmnOgo2eMfrrUs3nV4DcW+6tunwjOrd88x0WJXkwO6zn/A/22oUGB1nFSfTZ8g6z+QpL4MX1DSPqutLOQhjAmz2QV8TmKr51KlvQ5Kh2ZwNH76XA0qnQp5wEMREJ7pdswIJgCySp/Nhd9dOfiDVmgWeKSEIMprOYZwPZIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGOLgiE5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGOLgiE5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so15557135e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 22:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585591; x=1789190391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9k8EBOfGDuJtIXvKucG9Bdu9gT/QCztUqra4D8q8UqE=;
        b=bGOLgiE5F9pfVT7jjNMkZ4rgXS1c5mqopVBj64sYDfmf1rfjcYKg0VwLFb97HaDXi7
         WMIOYa15bK8LlBy+QFfcSBT09UKUMQwVxobEgk1xoBed1ZlrtgJdPj3ymeJ374oNUqK3
         /Mc7noKsc6Jif3RRmXR9gGcmhad6NkB1Bu4zB2CUYIcTtyAZZw2sg562GiS42t9NJjVK
         mN/LbmXmyEcT/t2X3oKqxerLBfM4DvCrwJEWpwlym6y6IPjGwPs6aRRko6s4MbSHhcrL
         bz0Stqam3HdHFfGBdKvYAHi6E2EsI6aJAGLRAyXSjimCIDpsqNd/vR/4SblvPR71hOyJ
         2Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585591; x=1789190391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9k8EBOfGDuJtIXvKucG9Bdu9gT/QCztUqra4D8q8UqE=;
        b=isqaX3bwSCgPelbcrRhWCj4NR7TQ0zxpOuKK9NOX+w7I8PEA2++Z1QVyV7ww2Q1H8Q
         agq95fRcEFN+4S9tqKemMEPoH5NCgabd+L3YZ0rIdvATEed/bMw9BVnzySPTy/O+xeFQ
         g/dG5YdC8UBbCTmLPRVvgrzWUPBt1Xr2fh9pfgFeoX+oGcAObepDBKQn6wQwa2Sqb3UN
         TL1hHUdj/Z9mbYl8u804e785vjNZukqDvKUDmrsSK/AHZArKVZ7X4qTN0r6UWExSfUFw
         4ek0ryTxzBbSGEULO3J8utbJDwao+Ym27y6xFjD9Co9UB6u2n2K9jqJevHBELjBXhmaB
         0yvA==
X-Forwarded-Encrypted: i=1; AKwUvBxzHfGfsDrbnv0MlhqQNee6/kHTtvPw1I0NKSh5C5jzyh0T8ZKCSAyLprHZB0r4t1OKADk6WXw=@vger.kernel.org
X-Gm-Message-State: AFuF++kPI5unzZbV4BOFCfq78Ia+w5DdyZp5ty4YHlbX2e4JB83WOQ+j
	YJRZNBYcPb6Tnw8ZEGMOSyhHsn25GsiNzUtogrV96hzTpGj+MQcixzJm
X-Gm-Gg: AYBFou2+t/zkqZA3KzUfYSRjBdE3/xLjke0rnuiBjOunIxKUMwWP+ZJnmtjO9XNJFMj
	b9ShAjF7nenBApUWntEJSR+8gcE/RSMIGAKxlWHdpapA9cO9xlZ/s0GkpNCcdxoAM5Owit0kdYY
	2P/ARQh1QWIZPoRZBa5zUP1Szrsx3g09u4bTs8BYvJ430nui7zueklzJDGIpg3yOnj2PuR2s7Q1
	g3JNciMl74V4MKpchBoL8pIbJR05PmOyhWmTWt50OmIEdTR8xeMwgn8tN3PT7G/OhsdLEYaGLMa
	hcCT3gyeT4pVLmoIYXhT2xrYzQI4w7VLdzyh3AaZ9hsqDfHgRL8dyswCpOdBftK3WpUGTs8cny6
	B/wnHV+LdU3vjLpW2aJ3y0IvjcAoCAtHUXLWJhWzB8sBslZP3QXEipToHMlr0JffWFwoeqYoAgs
	zfQVXuI3inrcqRnFWIYqx+UCb+IkdrMsf4z6JJ6loqX1/qm52GxwBqntLKa/V2NYdtAjfxe0Dq9
	1BoGe/CFWX0NJR9bX3gunpXO/bx/KUD6z6ByXIKRvVjxCKHqBLGpOyMhWxnK+Zhnz1yUjARcw7a
	NkKDJPtddysG5unVxkMnkVYSEtpfx3cjnbR+I0jLHW63qccbN+YS1LM1y6JnNa2RJt0=
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id 5b1f17b1804b1-49cf7fe62admr181581535e9.2.1788585591062;
        Fri, 04 Sep 2026 22:19:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023d6sm203614475e9.8.2026.09.04.22.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 22:19:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: smc91x: Remove stale documentation reference
Date: Sat,  5 Sep 2026 07:19:44 +0200
Message-Id: <20260905051944.11604-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc9.rst was removed with the separate smc91c92 driver. Stop
pointing SMC91X users to the nonexistent file.

Fixes: a3fb9a5bf660 ("drivers: net: smsc: smc91c92: Remove this driver")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/smsc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 66bca803b19cb..99e22d3e16ef5 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -29,8 +29,7 @@ config SMC91X
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
-	  compiled into the kernel, and read the file
-	  <file:Documentation/networking/device_drivers/ethernet/smsc/smc9.rst>.
+	  compiled into the kernel.
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-- 
2.53.0

