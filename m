Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741983;
	b=3z9mzo2bjfM2Qy+lzm6AZ2VenOdfl5TcbPcjfxHEXmfQ2h6CF7kpx+rEna473xosOFeT
	 qusCGWv3nccijSksGvZUIWoYRieEYpHJqxAPhYHZV3bjAqu7fJsJf/gmyQa2GOZhlQXjz
	 ThiWPzBar16zR11v1GhT/L771f8DASBp4IggSS+jetjNhCw8aPpKeU6uLe/Or0+/wkfSZ
	 4TxyRZbrS9blTSx4HwEeCsR757nElFBv6wq6agItPQxWSMl+3xyWCbUFnYZ9+OGjTCLHE
	 TiiCOMshvuWYuxW08WwmmFOpRpxfWpXCZsefTMsR5jMFQQCxpSARH+10fVJ4kC9icbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LOqLZKJMT/w+vtW751BtQ1dEmz/kTbksIe//V4Kzc00=;
	b=ik4ovxAgDZVI1mFlyV+ncCfz9ne3IsffZWKKeLApDKLO7LA4UkmOG4sai2yUizKVKqh6
	 4ab6dHZ1WKiRudsmAi1wVR6RJGBBfwXB3GS0KumNtu3m1i3xGKKoU/U5BL1KvoNCRij7O
	 D/mBcOfqUdPAqUIZozrAslkH482qw0xq+qnMPFWWQpeie6NfdKAF4V6nP3IhWBcVh351X
	 unAyvZlqHc33evVKd4Y7zVaL5UcPa69HPpCaaGp+7NATxgKfL/cUw4vyCDk46xMAeC5bY
	 Xw/in1ZOmmjey0z7FBy5SEJi728YmPisn/YdnTcY9EQbSHdLfRQD99pm1pABBzmnP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JxE1+eql;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F295606A320
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F295606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JxE1+eql
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so136560c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741982; x=1793346782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOqLZKJMT/w+vtW751BtQ1dEmz/kTbksIe//V4Kzc00=;
        b=JxE1+eqlvJtU4CQrWSvo7l2FGQCcRo1EVf+I7y3D+30KAgPqweO7FHNoAJueshagAf
         H8b5fzC7vPQVcNLJJstTuRNv6jtGaCIoz00QV7iLbDDSh5o2Ft8nwhAKv7UlvqS612+k
         c50r9vZJk3QkQt2mRpSlpKs2+TO4h6oGQjMP4Qn1hCAVW9BEmO7rOnNVsLpYYTH8Vols
         BtOrTOV7Th762QmXqnkpaL4g5fMeilhLuYJr6yjM6nBVmzdUTfuL/gAwVwmzH27wIy89
         OBlgDBbGsvrBgrrZ9N9TzHCzDJGEcnAN+ioxuAXpdznilpqqdcxiYM9Awi7n1qjahN0n
         Fmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741982; x=1793346782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOqLZKJMT/w+vtW751BtQ1dEmz/kTbksIe//V4Kzc00=;
        b=jImP9oGdRow2pbOG/+IIj/QvDfOtnVjbbuzN6WYztCyhe6s3+Vrr5r1XFXwv1+ZJng
         eBP0LMqO7hjnXL4dguzDtIgQ7z7mKHDdY9oE4YQskE5yxCBqvLajPBzFiM10ZCS6SV5Y
         Ox8tEF+HTHCyv11d/lSWGvaYgwVkej/jgO/lbVqN5ut+piJXrRLqKmdiDLn5jFLg+kdb
         +6R5UjIFleFRFNsc0h/e6sBHnuwwQ4jFKJ8yi+gQqHp6z/BZmjX3Gkocw2FbMaGJIS48
         Y/XJ9UU8mP17vV9+z5yGNI/fwIL77EHaE9cZdqY8DbRlYjhRGlfkc9H+9aoOtxbjFPeQ
         9s9Q==
X-Forwarded-Encrypted: i=1; AKwUvBysnGjZeczzcvm1PMH+nnMCimJP8BPxRaBL6QpzCxz7gc0JpboDWcpb/i6sGUth8RB6YMb7yUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcHbmBOdq+uAz4qYoIp0a+477Szl5Vyp650m5HbyMb0SMPfro2
	QUYtdZ2p6+ed+F9sb/FtIGtXK1DIrtvxJgex8dX8irJV46U3IIRh7t+6
X-Gm-Gg: AYBFou2iizLxT6nLP+7I8EwDPbvMKcjb+3RUzLtx7PRLDdlIhCFEKYh+W3CzmcyNiDI
	FkAy4xRFXJYyQzVgmDBEtYmmIDG5eiVl9aADxQMA9zkjbDU8affvoAlk3q/BHUtABXDISrQ267N
	CFB4AsOGw5jSdV+gW8RgAmndWb1DfKXgNRAhp/Biu17reR9NnnLbicPcD/ogDxHoKYxyROtRTbX
	0KcldKHojyDWTPbFCrxG+Wxk/UfQhFd9u11OnvjsKOR22ZOH+ipto1r6TAKGoaD3qWbtumS5saw
	bKJ7hFhhAlO/cXoz/ZwDOzLp1m1wXfJss3BbzjikhIDoJomxWIk2+AVZPuuoQm/88I8D0JDajmy
	7FMntWxhWnHrLBhpzXBJtTzJPSW6Q09W/RFmTs5hFhgMytL15F7OX6JoGm4d7uZx3Pb5NnGJBZg
	GfzIfsYBOohGU/egyZCCe7QnUSatmo1Z4WcUL3QNcdA38ORTmzMEZSeHuhCSI5NPeyKK9Vjcu4E
	UJ9vZIFOpebTHNGOgI1Zv1lm1fmYBTlU995yINwVK6YKJEXSVL31S7opZNKDKso9UVO54b9DcI=
X-Received: by 2002:a05:701b:2914:b0:187:a2b1:7b3a with SMTP id a92af1059eb24-195c77a82c2mr1718936c88.41.1792741981479;
        Fri, 23 Oct 2026 00:53:01 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195eae0e830sm4122132c88.10.2026.10.23.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:53:01 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Coia Prant <coiaprant@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/4] net: pcs: xpcs-plat: fix runtime PM initialization
Date: Fri, 23 Oct 2026 15:52:12 +0800
Message-ID: <20261023075214.1793922-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023075214.1793922-2-coiaprant@gmail.com>
References: <20261023075214.1793922-2-coiaprant@gmail.com>
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

The driver calls pm_runtime_set_active() before runtime PM is enabled and
before the CSR clock is prepared and enabled. If the device is later
suspended (e.g. during unbind), the runtime suspend callback tries to
disable a clock that was never enabled, producing:

    clk_csr already disabled
    clk_csr already unprepared

Set the initial runtime PM status to suspended instead, and register a
devm action that force-suspends the device on teardown. Without that
action the CSR clock would stay enabled if the driver is removed while
runtime-active, since nothing triggers a runtime suspend on unbind.
pm_runtime_force_suspend() is not checked because the runtime suspend
callback cannot fail.

The clock is enabled on the first runtime resume (e.g. during MDIO
access).

No upstream platform currently enables this driver with a real CSR clock
dependency, so the issue is not reachable in mainline today. It was
found while using this driver as a reference for the Rockchip XPCS glue
driver.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index e669a7b248ac..11c4239bfd74 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -275,6 +275,14 @@ static int xpcs_plat_init_res(struct dw_xpcs_plat *pxpcs)
 	return 0;
 }
 
+static void xpcs_plat_exit_clk(void *data)
+{
+	struct dw_xpcs_plat *pxpcs = data;
+	struct device *dev = &pxpcs->pdev->dev;
+
+	pm_runtime_force_suspend(dev);
+}
+
 static int xpcs_plat_init_clk(struct dw_xpcs_plat *pxpcs)
 {
 	struct device *dev = &pxpcs->pdev->dev;
@@ -285,10 +293,12 @@ static int xpcs_plat_init_clk(struct dw_xpcs_plat *pxpcs)
 		return dev_err_probe(dev, PTR_ERR(pxpcs->cclk),
 				     "Failed to get CSR clock\n");
 
-	pm_runtime_set_active(dev);
-	ret = devm_pm_runtime_enable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, xpcs_plat_exit_clk, pxpcs);
 	if (ret) {
-		dev_err(dev, "Failed to enable runtime-PM\n");
+		dev_err(dev, "Failed to register devm for xpcs_plat_exit_clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.47.3

