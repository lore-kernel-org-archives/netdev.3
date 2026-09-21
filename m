Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2324CE693
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009647; cv=none; b=JaxOG9La+DZmwNL6zgwSn4lKMhW1kBN4ByQb/Il60y/5LmQcQ0SNPoD0Ww6L0geG4mmzP5Rf/AX9sz6XMdflx85aANy2mQVdTU/GSrOXECBAduUS6lvkplAHRNwCUBvLgK5SOzroy/RDRfgoQJyg0OI2J6Wvnf2UvvvP5unsZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009647; c=relaxed/simple;
	bh=rT/xXwTxWpHJqpawKJ8rz5ThjGIKxqXQoFm3t0DoVeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RO44GlWztR7g7zjqymrIbFUYyPQHTu4WyuaygQmnGXbM6fOe6D7CWk0RfRfDjzx60Qpl/ge32Vn+9QzffTUQqZO29fMhAejrS8v4qbGT3dsZQJjVl96SU+JYGcdL/Wvm7R7t1W4cyLxQOl8UhLiPUm0uYDXL+Ti/sGM6TwAK2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQxdoVB0; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQxdoVB0"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e34so2028416a34.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790009644; x=1790614444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qAXyGZrnDwRQSNRJqJ6eqSWY0PVWK1O+tcBGYpLbtNY=;
        b=cQxdoVB0gzXJ/nK5fo2+m1oTTkF+f/yTrTLH7X720quZtTkHqggvysjNCAYfgIjMTw
         wvqiry5DePWGCINx/WhUUaQtQ2apobU1RI+xRZwub+ofnIRH+jDkuCurYULDBhrbLCMr
         pP7OV0v7YaJFIQrL+hoqxeir2MYgGa270Zm7cgGtW8tkbyRsnxYKPp8NSynGtAo1WMev
         kn/vRToeMzjR87GpSNhT1sp1KedwtqZdrwGqbl0vwLtIDy2Gw4lyWRrWBkkeNKnF27zN
         lAnGh7FpDWKi9a9QtjAgaug1E/RDfmUAnwcSOqEBmiVDRexmdj+zbDlyhXcuUN0EFz+6
         nIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009644; x=1790614444;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qAXyGZrnDwRQSNRJqJ6eqSWY0PVWK1O+tcBGYpLbtNY=;
        b=P+6HlFIRoBJgtv6h2u/e5kcKZ15l+6xd8yknHbXMOUTKu2/C+XHZOtqy5YuK6e4HwJ
         dwkq+uJsay0UwAsTO1gwz0zdN69LDNB/RSrVGtgp5YfiBfsgjtMEaoOYAklL+TB2D0Ff
         3MYVyyxS3jbdtclJciDnl0Zz+7VFc9luudvAFfzJqxOs49vh8kycD5yoJdMe5BLkXW2q
         xQh+6cnk0kO6omLEQUktycbTFSYAzKz3QBrv9ibiWBbWR0EFFk18Pq76/fRWljLcMwG2
         +sI1HqrNOu59tGHEO4GN6xyFag6JNXzGbbyujnYoIGrqQn56CBOa4HHnoj9epDQA37YF
         Y/yg==
X-Forwarded-Encrypted: i=1; AKwUvBy+ydDAyoJ76W0zl6UAgn5oq0fd0McJLiVmYrYnMxuCZ/DEQH+L/TMonPUR2Tjgs1SKPLUARCI=@vger.kernel.org
X-Gm-Message-State: AFuF++knFYIece2KlNIt5eGYWM4NYLJoBYSBv+ivUVo5ZxMc6QXCpPng
	Dg01b6ix/XW5uzqKRae/NXB6fUv0TTBTFn5k56iTjMY2+pltnaEYiJCg
X-Gm-Gg: AYBFou2ba7oth8a4bLEZICLOMS208IWgOwaA5BAUJfrcWFXOJi3ilimoqnbbPaIL7Uh
	qaEODFoDR37uO+8J+S3c3sZYyzUswDlWE2UB/IYuWK1//JnHacnMh797dtnMfpgTS7KvWwy2hpk
	asean+VmXaKPTNSvP8g0kmyZGb8QZfGdhT/+PgvRjnyDCw8Edpxi7DIGS2/2HBhMCYqOaZq0bWX
	UZzOAnMil/m3/5WbGrWX12f7HPQx/UrSmDHn+QygiC/Qb5/fqgYvoVdPSeJzsMnKr46qp9KrlVq
	iKZH7TEMZbP7OhcQaT3sPt+U8mW23wwc+QeD/RY95MSPZZ0hAG8xqZt6qGEJ7R1oxLnuJr2rtgQ
	L/RkswPjrO3p+UaPinIVvjc4VUof5PpOPqxo8o2c+sD6wP25DRRXvLC+Pq0b5kAyGiZDIqhYZVi
	K3Kfj4XvycncHo1DTcWH7W81SSyPbFFYuV2kb5Hc31/19NAhIidRiclL5H5KhD5nCRgotl6QwDO
	2fRZwwdHdvVcxR1fiLUcpT36fnLt738hwGt515xueuoZ/utmuSQ+O+MwmM1hjiCZu3f6nbO+/V5
	fbmhdzmQc1n0HLrB5NBnYXu8DsGabtf3TAa+1Wj1TXkEYUIEXRfVo7maZAlBukFshr9yFxnuqij
	9nL7LZtPza+3LJwTHReJ/+Q==
X-Received: by 2002:a05:6820:2217:b0:6b1:8ebb:7efd with SMTP id 006d021491bc7-6ca9a13032bmr11598584eaf.4.1790009644415;
        Mon, 21 Sep 2026 09:54:04 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d145bc40e6sm510481eaf.5.2026.09.21.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:54:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net 0/3] net: stmmac: fix failed MTU reopening and hardware
 resume
Date: Mon, 21 Sep 2026 10:54:01 -0600
Message-Id: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAyF4auUrA10ZmGNVxEX02mqEWaUSVqE0
 rsbdfm/B98Gyk1Y4dxt0HgVlWf1CIcO8j3VG6NM3hD7eOwpBtRlLGKoVkrK2FjZcJY3K64Bh0y
 nkeIUKRE48Wr8+1y4QGWD63905MHZvjDs+wd48Gi6hQAAAA==
X-Change-ID: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2

A failed stmmac MTU-change reopen leaves the netdev administratively up
after its replacement DMA resources have been freed. A later close can
repeat NAPI shutdown and IRQ or DMA-resource teardown. A failed hardware
resume similarly leaves an up interface with NAPI already disabled, so
closing it can hang in a second napi_disable().

Fix these error paths by tracking whether the data path is open and
closing the netdev through the network core after failed reinitialization.
For failed resume, release the suspended data path without disabling NAPI
again. Allow phylink to finish shutdown directly from its suspended state
without restarting a MAC whose hardware setup has failed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
These fixes were previously posted as patches 1-3 of the H616 EMAC1 v4
series. Split them into a separate net series as requested by Maxime
Chevallier. The sun8i MAC-reset change, EMAC1 binding and variant remain
in the net-next series.

Changes since that posting:
- Adapt the failed-resume fix to the net tree's older stmmac_resume()
  implementation, leaving timestamping behavior unchanged.
- Add a Fixes tag for the phylink suspend/stop handling.

Previous posting:
https://patch.msgid.link/20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com

To: Russell King <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Joakim Zhang <qiangqing.zhang@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Christian Marangi <ansuelsmth@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

---
James Hilliard (3):
      net: phylink: allow stopping a suspended instance
      net: stmmac: close the interface after a failed MTU reopen
      net: stmmac: close the interface after failed hardware resume

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 39 ++++++++++++++++++-----
 drivers/net/phy/phylink.c                         | 16 ++++++++++
 3 files changed, 49 insertions(+), 8 deletions(-)
---
base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
change-id: 20260921-submit-stmmac-reset-fixes-v1-7c98b92d29a9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

