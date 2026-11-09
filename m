Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228607;
	b=x9iF4dfohGDBPiBqyoJJu2OvxTqtSp+m9fLxdmHtA2B/5jRaRpb+I+O3iWCNgzIpyTR5
	 Tq5PmeEs4b1y7GsVv6S++NVrTqCY5neFslqODLVRxm+tRLo9Q0R3SfxoXhfo0H24VmGWs
	 zgomrqf4s7EhHVLv2DgMEwfq2hZj5i7bsH9vggN4R9G+VK33i+ZC2TDl0sCYzIcSpLZKz
	 UxBSWa/J3N5Q0ZCWCUd3mxf9ASMu3IXfeap8ZTfuvCcLtFVbeLXclI7JWYWRi7lt8Ro41
	 H20P4HvUdgio0l3Tx7VxbAArUNwXROia1bF5bMBH+sDWix2kHpEEeyFTaAMkPrDLRNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
	b=3oNFUWJ79dx+3nD9Jps4lDpacDjDdA2lKuI4FrIj0JVJhI2H3v+nTD2753ke3lxOi7h4
	 xue4ajTuBCrLMSKaoVI54PuUpj3vlkNRF4FMPmZb/eSVLT+7xGM2KaL7PyUxSjJUrBWpS
	 ox7S24qQttA8AGacP1kGy5h1E3DeYj/WSRkkMBxIN4LUcHQuvnM35+pIBVtyK4Fui/exy
	 UWGNgXogMuMTt8nmV8qKqgxCqMefr1cTgbLwFOg/RDJHfY3n+3pCJcbz1SLsDbU1ZktOO
	 +NP7g3E+2EOxiEU8IHIzxnMNl7Zmn/5J+0G0TLUP4uqdaIKsmyAhA9qNN7jQ0aYtjlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWSEio55;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11772606D830
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11772606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWSEio55
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37000e7234bso625293eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228606; x=1794833406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
        b=VWSEio55nDx45swB4s1+3i/yAB+YajUhF3GaZcaZ7QhmGyeEeDwdL5vIbNGBT5YE3k
         q+1Bg4f+Jx7sm/LjeiV30LCtDJ/eTaXYYxB19uRBRdvsWkrNfcA80S8wkQ1VAAL4RdZP
         Q4LhjnwbHYDacfReX+O3dpkl3E5vQaV2yzca2A5bg61YoyXn8Yl6Y0ANaEGHUwMGUdya
         x55v81jk+GK5zZ3PJ2eaYABty7C6oCbOj7Q4LImkYG9XVLeYGr/UfynJoVvhy2w+vnRm
         U9CqDwr/2oNc1bNt1/WXslmgCBGC676tXwonBZAI7ktN5HLLstyu0AqnOvUiugk2EAS3
         Eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228606; x=1794833406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
        b=t1z4ka87IxewBUk6damTU49a56hNtVLH+EEf+lvCAEG42oNvvSgxPXrWTrfZ8RW5Aj
         GKy24XCGRsS3ZlEHqcCOe/RWArExgLGUqUuJQiO0BlqzDSxLBEazBIT6Hfa54yTJ87xc
         tiExzEyVZBq2YX6PwmLB7OH9kGlzyzjsP3JuezRMY/RnXUC+qRJQEhj8Ix2/mTjrO33w
         umR+Pxz9b/cgUlCTKufLvLZb54XDiv8o+ommQ0Olq8RBRn/+wzi0syJukrzTvqmqLD0k
         jro+ylWYTYSezZFZxpi40EwkgUqcnWOQAPbtUI3Xx0fwe4CaW3QNDhGGxzmUFNVagnTW
         B0jg==
X-Forwarded-Encrypted: i=1; AL+hErHSIZRWtBz+nIbM21SqJp6Te2+iIxMJyS8B3IT2nGkhCMEgRg3qE7uIYa4KeWxQ7wq1LiaK9X0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pjhmHi3JZAnBNTfZnVkumDB+GRJpRS0r1uL333Vim+Nw3Xswu
	l2/UarMoUExkkI37982g5L1v+z7p5lTleclMxt2KrJGBXtn+Lg8SOAla6kka6rP3
X-Gm-Gg: AYBFou0DNBTtPPkfKY9A1RzIDrV9dks2se2MZqqA3tXLX6/esM2NKBYNk6/aJHc/gGj
	RpLctz4RpU6AJFjlQE4eJajO2cJ5YHDwe7PZjbRIMBZ8ku5VJl5Qir0ExUZTocqCyGDl3qXDYQU
	thI/7bI64wRy2mBv5j3kZo910mCJUlfMKMR1/BlVcSayf1QsgwOnYvMyUOGmJRszURxC/k2/t49
	WX7RuBxFwEuQUDGutp2e8hWeXPZpIuC2rG3RdjJaQM+hkvaSo6pZPlpMy/7UHU/p0UyQr3Z4wnn
	qHYXaZ8UYrVu8rmdC5wZuSQpr8swYpHktIaSCDxUPqzHiIvHbv6Ae0O42dH8JKHGVyYK1+lQOlr
	Y2FAfWzqAixrjGx3Sx5BJXv2htn0X1okX67RTLoA9ZkZBA/7jwRIqSwYVs+WA/Z6iJdXR4ikh6/
	wcapYvG2OylxvG+ECZGD3WvG3j5JdLOJAm41eqbxkh8MzbwWW3GLnYwrcDexlX3WmSvfV6OB0w+
	E9NGqPDx5W7dZ+L+4CAHhwx0dooxW2EOa2WEK7RkA6HCkSoom+gmHuO/jQD38WSWWcG7FiQD16g
	tYfM3X4d9yxpIUUJKVpD/0Xx62PJKCUbqEyWDteCex74g65i
X-Received: by 2002:a05:7300:a223:b0:36a:5042:85b1 with SMTP id 5a478bee46e88-3725302be58mr7671219eec.2.1794228605882;
        Mon, 09 Nov 2026 04:50:05 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm20376602eec.19.2026.11.09.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:50:05 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Lennart Franzen <lennart@lfdomain.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net] net: adin1110: flush rx_mode_work on stop to avoid use-after-free
Date: Mon,  9 Nov 2026 21:49:53 +0900
Message-ID: <20261109124953.1604903-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

adin1110_set_rx_mode() defers the hardware filter update to rx_mode_work
(adin1110_rx_mode_work), which dereferences the port private data via
container_of(). adin1110_net_stop() flushes tx_work but not rx_mode_work,
and nothing else ever cancels it.

The netdevs are registered with devm_register_netdev(), so on unbind the
port_priv (netdev_priv) memory is freed by devres. A rx-mode update
queued shortly before the interface goes down can therefore still be
pending after the device is freed, and adin1110_rx_mode_work() then runs
against freed memory (use-after-free).

Flush rx_mode_work in adin1110_net_stop(), next to the existing tx_work
flush, so both deferred works are drained before the device can be torn
down. adin1110_rx_mode_work() does not re-queue itself.

Found by static analysis and code review; not tested on real hardware
(needs an ADIN1110/ADIN2111 SPI Ethernet device).

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/ethernet/adi/adin1110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3d..788cf4d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -956,6 +956,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
 
 	netif_stop_queue(port_priv->netdev);
 	flush_work(&port_priv->tx_work);
+	flush_work(&port_priv->rx_mode_work);
 	phy_stop(port_priv->phydev);
 
 	return 0;
-- 
2.43.0

