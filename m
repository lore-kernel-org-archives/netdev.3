Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C74EE874
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623289; cv=none; b=dlueeAxmuiJBp6UP/0S+wVCHKApkkxs0+TnWKcOBdOor7DvfZ5ZzrGkCpt1u5HophINYHRCrJqAIIdK3s1xWp2y8B+nMu5oI10xIILuEEbtLPcv0aAz39JxXHUs9tedV3y8c9ixd37D7eZw87ocVpgUL1oBAiIL/rzNSLKVqqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623289; c=relaxed/simple;
	bh=e4W3heWpJSSfMatKHc6jQT2QirxzrrhJb2u5eQNHmGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=th4Fys2BLSfOzQcXf3l4b8UHarSSFA+jYuVRIxcYxDZ1mbh7N3hfFnmFCMgL8rbIPRsEqN4KXbJn9ocb42kkcYb3M91l83EW7oQYPvC5buLSsMpxX1LEG4L7lIkK9+uYDk5BiQepC5hjtIQl/JUjFIOOWxnfWJ6r3qBSmQ1T8Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz+GHSZ/; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz+GHSZ/"
Received: by mail-oo2-f3.google.com with SMTP id 006d021491bc7-6d8b7178347so630497eaf.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790623287; x=1791228087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVeRClalrWLka3P0+7DfFgAskiK62atsVktrSXYS9Rw=;
        b=Xz+GHSZ/gIoBvLcPJjaQk3rDT+HEw67Hwg3rJt4chZEILO8gHA6xK9dtcWq/JDyflT
         0BAuG+Sl8zwoOOArQSDZi93W4CTdpe06z0XZ3nqC4jG+k89A65gtxvDuR2I9RT8ucY0L
         77xDGU6SZe7JtV6l6XGwH6KVqiv3VynwuSdUJIeSM6aThb2IA4M/WbCwNl6OB2o4uXVZ
         9PbVwkOMm/SBHtNFpYVbyaG4aUEz8pno3b7y9vsae02eT0oickJRlaU7oJKC3H5RpNqr
         LnL/QKLB+g2iBsI7KtWJw1naFeBXOImVEWyiUjQ/4VFvTWwM4+mltB2eVoxQO9JDpzIk
         c+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623287; x=1791228087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVeRClalrWLka3P0+7DfFgAskiK62atsVktrSXYS9Rw=;
        b=bwwplskdIFdoVeFpYbmoSXTSGi1aD5qk7EcJdRKsB/vZR94o2gVfQ6SpDZEDC6yJHa
         5sY7k7ILkrDyJdYn4bCoXxJVo8cWexi1tgoRo9d+gTZRI85zILKGMX7z7vdCuDfTZnaN
         E6stAmENAmS6ThrkhGo9oN9OWGofb9QZ+GDTDQnrhN1pjIrE7XzWqJlwyD3IMNk4ooQN
         r1ph99C+ec1LfP1YDjj/K6PDCCbHruVqagdYllkp/oOMwO7EaK30MVEvYzztSNnqtxFS
         v1zPzqV8UlcOUYw69N/izcX0G46WBXu22kdf2KuZYlw2Fb3xoeAiTtm9UmM1JgzZ83sX
         2A3Q==
X-Gm-Message-State: AFuF++ky81TGmQtIP6esu6/P6a+wwKFq0YUurihm3fzt9C8x5lKEEX0o
	pQNJreZX0HnDUWW4WBF/GVzUtSO/q3F6pqL580+CXmi1v9broq0KmlE9GWVfvMzbEcE=
X-Gm-Gg: AYBFou1hJucJGQf1QU4m/z4PFJE+ojgcWdDK79yEzXwd/OCp7Ex3OaJwQxnWvAQUdk+
	8cyl37ePI3vV9i6soc5gzNAYn4Lz//LEZ1hf9X1fwEAWYsZNZxKFES3PnBUAjgj6EpwDoAAkx1y
	gO84dnLOLwdV1tskuHx0k1yKNq3N5vNGznY8eQN/je/CPO/dHdhaxLHc0OIiEwmB5TicKePEC2m
	mqO4MyCMqTSNG4MrESaKEJwHzsK72aGJ0VWYt3BxIFxoZ2ey9dMYDNOQpHWcW9F5JEpyghVMACT
	qYcs1dLrhaITDDwezUvVdaBqnoUf09KM4Mrbu/Yr9x01MrVC1E6adD3g4VbfxZiwhPDFeeOyfF1
	JxHKQuW90uLgDraXeBaaPv5kdhfp/eylnL2vccILbEf26Kv5WpfUMizoXVg93boznQ/M4CzZSl8
	3vgQL8wMHQrctXH6aqFossdnwciykx1Xq0rfSCPgGAY5O/E9xs9G7NgbMfqpsmUPpm+k7xDzA/7
	HczGsI7PCGnO5kbAmRcFus=
X-Received: by 2002:a05:6820:214:b0:6d9:8fed:b73c with SMTP id 006d021491bc7-6d98fedb9aamr2471163eaf.57.1790623287111;
        Mon, 28 Sep 2026 12:21:27 -0700 (PDT)
Received: from Xinshengs-MBP ([129.79.197.98])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882dc49dbsm6088996eaf.9.2026.09.28.12.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 12:21:26 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: usb: asix: remove redundant PHY address short-read check
Date: Mon, 28 Sep 2026 15:21:19 -0400
Message-ID: <20260928192119.73351-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short-read handling was added to asix_read_cmd() by commit
920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
The helper converts short reads to -ENODATA while preserving negative
errors from the underlying USB read operation.

Remove the redundant short-read check in asix_read_phy_addr()
and its unreachable -EIO assignment. The existing negative-return check
handles both short reads and underlying USB read errors.

Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
 drivers/net/usb/asix_common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655..51bf887e3520 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -327,11 +327,6 @@ int asix_read_phy_addr(struct usbnet *dev, bool internal)
 	if (ret < 0)
 		goto error;
 
-	if (ret < 2) {
-		ret = -EIO;
-		goto error;
-	}
-
 	offset = (internal ? 1 : 0);
 	ret = buf[offset];
 

base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
-- 
2.54.0 (Apple Git-157)

