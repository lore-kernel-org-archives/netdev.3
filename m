Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794070889;
	b=M7hXFpG0T4WPhPTugOohJXZgAJFC2VBWhm8mLBJ+FxQTjNK/j2flXx9j6/lCWyrfekYq
	 k7goam1A+lDAThJ2ILFtx+7N3q8vzGyI/gIlcsVVbaoDE8KLzpKOGeXKzLi/puYOs3pH6
	 /ij9Lwxd2LENBiBat9cBCAaqgSRT+jUVDMEcMemVxlZw3J+804JdjXYF+UkIbRlMdL94f
	 1f0LHHgpIYrIK2R7AluFuoQWOvoLz8Tvp8GteTmo3GYno49YD6lxUbt/uZR34QVJ12Bco
	 w1V4C/0MaqTpLm4PjzYDa7QduufoGJZierU0mIjOvx7BrQbP8kIuxc4ui21bL5F+eXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f5J8oAfO/kInnm9/wvYn12c6zn0qOkt1NdzUehcv5Ag=;
	b=vzBpYqpj6eSQVgqE3F2aJSTvyZh4GDpQa1xMcFn6zAaMQ2u/BwZcidWXBiBj5PYH/dGl
	 L6aOMfQS9qOGqDG9+IvJdDNFL5MwjEKL8jUstm4L66So9ZR5cahpEnpeT8n5DivaecvEH
	 Dj0g8/D8Solmu36MCpcmpq28EF5qeZnKOUnP6KIrrSJDJi7cU4t8pXirJ4Ydyk4trR1jN
	 6zp0ZdOO+H8MDgCl+Gdlvv3LZhFq7dw6a6rbA1m2EdooUYNsJQOQpfWlzulosCCWxEFyL
	 lhcNSFgFrBkv5etfABWdWOnOxZPyw/Z80gxya4bWIdxUx7HAQsDnGHgJjMWpS136PQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INsRyrY7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE1606A333;
	Sat,  7 Nov 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INsRyrY7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794070888;
	b=sEcB/hKuTeRFY5FPSAvOXDgiU4PB4Wba0c5QWC2FDUWK8Nn+4OHnkk1SNUcEocIRLOWE
	 kTqrQ9JYlVovlE418f80xxE0UJ1qrMyAzl581n0tJaDkBo43Zt1+78EHJuFISsgBa0qPD
	 ZFviNtzwfApLDXIlLdbMUsLABhl7Y8bPQUbWOt6q8BXlMB6c+HfTykKPxNMOM+AYHAaWb
	 FgGDgxlaMKBxv7gMXH75NFYnorgxZT6/SZhxAiie2sdrgQz4Sl7QCDg2DnnKYTiNk6Z9L
	 gYHyjiJtJIgVro02A6Cm0v7o+Vz40POhgZ3ch9DnV4Gz42g5QNWCFv1FerIQuKhKVuw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794070888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f5J8oAfO/kInnm9/wvYn12c6zn0qOkt1NdzUehcv5Ag=;
	b=ZDf7+rXLLpctz5udNplKo7ZpxvFT/R3eMadFH9DVizTrRp04HglZ+PTox5TMfZhh6qJL
	 p9tEzY8dW3ORIqesruOpL2hdNibZZm8IxmHKwCcaevdAYDl+J2qT3g7wX9+uam9T9VGjW
	 hsMXADy0KZG5bJvE94ikNqdzxm5hWwH16PKlZcm0g+ir/lQFdJPoQqqv9m1yXbtMzfAMs
	 GV9lIzf/kQdiPs7+WOZQVUZVmA0WwLpxh1mVpsdV+U2OFu5hl0dxgXIxf8t1qL4U/vgaC
	 Hwb/mMNr8+jk11ln8TnImNKPUypzRJT/dzpAyUOAJnMEaSKSl9KTmQVWpUNGL8tZt8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 264E21F008A4;
	Sat,  7 Nov 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794070888;
	bh=f5J8oAfO/kInnm9/wvYn12c6zn0qOkt1NdzUehcv5Ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=INsRyrY70q6gEWXRE+4yD5VdDrh6QdRvUh+K6wrsxwBj1RrGwvidLy4pV+rmaxPQU
	 79eW6YFs5ywxy+PlG7KY6kGC7EvFUSsTElPmxr8mKRTHg+EvvEr3VhD7bcAYfu2qU3
	 xZSdJVCn5EYsW+0xTrHLT+cezmA3A1yaLOQCfpeYyxupV9hqynYNGsce/7aUraUxgG
	 u5OUp8sCUFGjo7fBYmVzqLz+FvH2DHeNhP4HRIIQQtgymo6RxhhujQ+xmXTHq2oRCw
	 Hp0/RnYT4eVI+rT0qAqd+/1Nr+15Rc7BUAmyt+6u17cx7SYqKUwFJC9+EdG3c6zi7y
	 +8zb3wtcfDirw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A41E447C91;
	Sat,  7 Nov 2026 17:01:26 +0000 (UTC)
From: Hleb Shauchenka via B4 Relay <devnull+me.marleb.org@kernel.org>
Date: Sat, 07 Nov 2026 18:00:47 +0100
Subject: [PATCH net-next v2 3/3] net: phy: realtek: register hwmon thermal
 zones
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-realtek-hwmon-tz-v2-3-6b9a69d44470@marleb.org>
References: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
In-Reply-To: <20261107-realtek-hwmon-tz-v2-0-6b9a69d44470@marleb.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hleb Shauchenka <me@marleb.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=me@marleb.org;
 h=from:subject:message-id;
 bh=HRvjZ9m/qJc8A0xrX1vhVTFReKgYes98W1JLF6cq46k=;
 b=owJ4nJvAy8zAJTZJnM368y8lXsbTakkMWe8jU538Op75bptzvW/PuZbUDslkk1MZT10m+wWbv
 +oNCt/8O7mjlIVBjItBVkyRZVNzkejTldFvXav3ZMHMYWUCGcLAxSkAE4ktZGQ4YS7769WX958N
 lsysmHBHONXXc2Zpo2XBxQP+dt6+CxS3MfyPbzmwPfLPm/70lh/T7hz+9npqo6hhxowLMu03Yiq
 zVQOZAE5xS/4=
X-Developer-Key: i=me@marleb.org; a=openpgp;
 fpr=B2837215E5A95BED457BBC6A9217063BF3FA220D
X-Endpoint-Received: by B4 Relay for me@marleb.org/default with
 auth_id=1394
X-Original-From: Hleb Shauchenka <me@marleb.org>
Reply-To: me@marleb.org
Content-Transfer-Encoding: 7bit

From: Hleb Shauchenka <me@marleb.org>

The Realtek PHY hwmon device exposes the PHY temperature, but its
channel info lacks HWMON_C_REGISTER_TZ, so the hwmon core does not
register the sensor with the thermal framework and device-tree
thermal zones that reference the PHY cannot bind.

Set the flag, as the Aquantia PHY driver does. In mainline this
affects the PHYs whose hwmon device rtl822x_probe() registers, the
RTL8221B-VB-CG, RTL8221B-VM-CG and RTL8251B, when the device tree
describes them. The internal NBASE-T PHYs normally have no device
tree node, so the hwmon core registers no thermal zone for them.

I tested this on a Zyxel XGS1250-12 B1 with OpenWrt's Linux 6.18.55,
where OpenWrt's out-of-tree RTL8261N support calls
rtl822x_hwmon_init(): the three PHY thermal zones register, and an
emulated 85 C reading on one of them (CONFIG_THERMAL_EMULATION)
switches the fan on through an 80 C trip and off again once cleared.

This patch was prepared with AI assistance (Claude Opus 5.5 and Sol
6.1), which also helped investigate the problem and run the tests on
my switch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Hleb Shauchenka <me@marleb.org>
---
 drivers/net/phy/realtek/realtek_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek/realtek_hwmon.c b/drivers/net/phy/realtek/realtek_hwmon.c
index b6b2806e2..021064edd 100644
--- a/drivers/net/phy/realtek/realtek_hwmon.c
+++ b/drivers/net/phy/realtek/realtek_hwmon.c
@@ -55,6 +55,7 @@ static const struct hwmon_ops rtl822x_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const rtl822x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX),
 	NULL
 };

-- 
2.56.0


