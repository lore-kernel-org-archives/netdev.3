Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576529;
	b=cSCRAECrl1OMRjFXNydg2if+d8b1S+RiHu+EGhzgOEwbx675NPz/C2YQWw570WnEipR6
	 e4+DoYOzM372W507wj23Ujt45Vh8D+P68txE0LwvOrxfOaE7RU/hdbLhv7WkoE8xZXu3K
	 PsH6iS/i3/pLrQ9FSLIyhg4Bv5/UrVBlDkGZ8Q8GnNpTgepiJBMbEQrffn/3tMfwTTsHe
	 PSfJgE/H84HfdXNrFloSLMx+AAT62SPLvz1XJuCAkksbUZoAsv4RkIXdv5a8OF7Kse6rc
	 Hpyo2nM2nyxcWwwuvLVC133nZaSOZgfwcpxwrq0HhDQQalwo4gXQsn4UqqLohhOxyJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MRo7HIV8yZ/AJq7Hb5Yi36jH8E/ybOv5u/YJ01l5Ztw=;
	b=mDMIoTGwRYDfy5qLNBqJn41gvdf083t2LtdNrULA/W8vhOPDKLTwus57bIwmB4uD0263
	 inBBZ75+ZWFsSzX9Yt4DtDhrnf8ygaHZROkWWhxT6i8+4AoJitkXtxfX2eD7Bv4gcGjom
	 V800dkLveKBgv7v4NBs1Ywu/++66shVilBWiZ/bLk8H7H4uMwjZwvvTTOl6KWZuc5teEX
	 wqWdtlKTHR0CFesZ9hL4b1kPwt12Gzc2LuJ0LRubspnlRlBGZH7AF9Oz8UC4qMh7xc02c
	 zSQ1xpTjyVYKsemrsBIelC5BPagCc12BJL7EXyy3TWPq1gr02u9AO4l1G4DW1Ju4YxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WC4t2Cs4;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A08606BC01
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A08606BC01
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WC4t2Cs4
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso1478595e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576527; x=1795181327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRo7HIV8yZ/AJq7Hb5Yi36jH8E/ybOv5u/YJ01l5Ztw=;
        b=WC4t2Cs4RyHPjYyOkqcxOQIEkwXquR0vgR7m7Ks5MSCCbfk7ABFxP1aeP8JHJ3DnYX
         SOHMIAfYA5MAkDyttah9DfG78FsOVDcdJb6Cy2i/vKhxv8gJORld+S52BuRjldbmyj3i
         tkVd15m/yprRFUTiEgpyzvvfBgO66JT3Nkv63LFGSGw9OsxDu5UuZ1FoChNmnTD7W/Nq
         vVxTlQoFoAmQ8N/7dTCdpLwgwADGGsoAs2iblQRvFUW42JsWssOq82/cCxD+lYBHgxRg
         4+a4LuDIPK6L+dtf5vrUhTu5RzlahirY6Vnhlg+ms3KziSvXmhawMTeAHFuO4OTfdNha
         JXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576527; x=1795181327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRo7HIV8yZ/AJq7Hb5Yi36jH8E/ybOv5u/YJ01l5Ztw=;
        b=IQOlIOuQLKilEM0jwcIlJLFoCUBW4IFGSg1hxIU9gnMChoiAFdJQX8Qsgi5FJBbSIH
         ayKe0OSy5d0XKUQ8uyPozjTQkUK7GAKGJhrssNKc9SVLT7+NuWxbdcQ9hjosYiaYTlFm
         cdb3otId0uQIhopn85w/gX8qaqMyH5vck5cL7Gsi+trrS4r4OITBch0HgeUH9ibVEfMf
         vD9sJzCJlhLVL6EJvGyYoEjDf4B3uwZZ6JDgvmRZCyw8aAcPDGD4Lz6RWcLUF5MYezoW
         2lR1N3yg0qnx6YqBFH7LYAVlRtU/7nhY4mfWCowL0eKHdhsKKs1g9hnPTUjSMdThDusC
         NCxA==
X-Gm-Message-State: APuU4Z9guAPGtjjiQO9iIZ5ingWl11f2AAHliWDp3x7NL4D/A1XPCp7U
	aaq4fMi6wOEYn80VBnw0ilydCQvF2IzWvwQTlJ0s/qG7Fb7+z1stuj4QuU8rGYhLrXU=
X-Gm-Gg: AYBFou2Cc8FBMGml5nKio6le6ayGXQ1mtEsmVEJNyl4B+13RHcLEkvKav68+1oIpo48
	KtwvwpACQFvr2+/mkW75Urqs3pH22ZC3I7S+wp1i3u8u2j4adYDVcGUTJf/IRK3KGtp0CkHG7uH
	5fnCSlkSlotb30VlRtfRmXHhs87apQzwpTlqg2Lyopi/fAbu5VH3dmXIFaBW/gKhWOjoa9BipU2
	f2eeKbmhU+Q9lyCIL+NdFLOS8NBF1z/GwIRF+fEY79xNHEdx/y+TeqRr1Xvs5h+b//I2pvUWCkD
	IncJGftvcCW7+swTMJGWUojZ5LkzqMRrElT+AXbisKgvFcGaAncqWj4rrD/zIQDV1M0qYqDAgb0
	QqcwneZlO2kL+yIVQpnsy+CqT4IWoJrnphEvetoJCi5hmnydarvkBrHUpPv1qNMaQunMm9/Q0Zu
	ZGd+5jehKquaUOKlb6cVX2OyjkhlS4T+FHRcm5hsSOGFo/1eZs/CHG5ThTfhk1HCjMR7f+KcK0j
	9DBMnzQW6IUKtfDUaQj/IjQiUV2mUQW4KZ7vhl7oBVpsznNldgsZZlMZo9oViAN4TmiU30wJmtT
	waiVbCktIUXh8gPpKlkRcqQCL9Jd7Qw8
X-Received: by 2002:a05:600c:e557:20b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4bb55a583bbmr34500945e9.11.1794576527138;
        Fri, 13 Nov 2026 05:28:47 -0800 (PST)
Received: from workstation.. ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fe370f8sm4802673f8f.27.2026.11.13.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:28:45 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Ali Tariq <alitariq45892@gmail.com>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net v2 2/2] net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()
Date: Fri, 13 Nov 2026 18:24:35 +0500
Message-Id: <20261113132435.434615-3-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113132435.434615-1-alitariq45892@gmail.com>
References: <20261113132435.434615-1-alitariq45892@gmail.com>
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

The emac_resume() calls the emac_open() and emac_suspend() calls
emac_stop() functions directly without holding the lock through
rtnl_lock(). These functions rely on phy_disconnect() which reads pointer
with rtnl_dereference(). But since no lock is being held,
rtnl_dereference throws a suspicious RCU usage on
Orange Pi RV2 (SpacemiT K1) warning when lockdep is enabled.

WARNING: suspicious RCU usage
drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
Call Trace:
phy_detach_internal+0x490/0x5f2
phy_disconnect+0x90/0xc0
emac_stop+0x114/0x626
emac_suspend+0xac/0x126
platform_pm_suspend+0x72/0xe4

Take RTNL in emac_suspend() and emac_resume() before the netif_running()
checks, so the interface can't be opened or closed between the check and
emac_stop() or emac_open().

Found by CI suspend tests on Orange Pi RV2 (SpacemiT K1). Tested on the
same board with lockdep enabled: 12 suspend/resume cycles without the
warning, and kselftest with no new failures.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Changes in v2:
- Moved the rtnl_lock() before the 'running' flag check
Warning Log: https://kernelci.cloud-v.co/scheduler/job/549#L2168
Fixed Log: https://kernelci.cloud-v.co/scheduler/job/589
---
 drivers/net/ethernet/spacemit/k1_emac.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 51edc95f54c8..d07d8a1aa5ee 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -2031,11 +2031,16 @@ static int emac_resume(struct device *dev)
 		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
 		return ret;
 	}
+	rtnl_lock();
 
-	if (!netif_running(ndev))
+	if (!netif_running(ndev)) {
+		rtnl_unlock();
 		return 0;
+	}
 
 	ret = emac_open(ndev);
+	rtnl_unlock();
+
 	if (ret) {
 		clk_disable_unprepare(priv->bus_clk);
 		return ret;
@@ -2055,12 +2060,16 @@ static int emac_suspend(struct device *dev)
 
 	disable_work_sync(&priv->tx_timeout_task);
 
+	rtnl_lock();
+
 	if (!ndev || !netif_running(ndev)) {
+		rtnl_unlock();
 		clk_disable_unprepare(priv->bus_clk);
 		return 0;
 	}
 
 	emac_stop(ndev);
+	rtnl_unlock();
 
 	clk_disable_unprepare(priv->bus_clk);
 	netif_device_detach(ndev);
-- 
2.34.1

