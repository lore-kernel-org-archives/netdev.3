Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559758;
	b=KkR8alfhXvRVVDP58tT0Wq4zzcZppCzPaTeyWQbwEvhxEUWPUbGBsPDdV1HNupdjdXvq
	 WyG9tzIvLVts6ld2f0e3wepqAyp9kJ1lescvOCwNYH+Yv3QpYg7AWhTA5uEZm3VXDQPlN
	 2Q+fSrtxIB0rN4CGgUzrWSEoRmssABstrLVqEsYp0j3VjgNSU1HwqbDKosjKU9Yswgfql
	 FruU2O3ymGkNunDwirrMLUziIeyakBZnca46mLUSfCAXjWGA16jETX3xZnw0Z41I7z95d
	 J4aVxOyjYNlRMsGiNJMAQUH9L8HDselV56bKmTq4QgN70ptwP4Mu40kMVwBvKMnGgJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=4rqhIjJS9gtiSswzyzrQGj9FsyK4TI/z+J8ZIwdTjok=;
	b=hUVlzHqbzmHZ5w9zMMoirLYnUrKexRGNYn1vxFigPWONuHhsd8XUdAjevAT7/eHnv/Ru
	 +78Mo61gipuHTzgN5Jo3yx0BAtY66M7TiX3Ac5h9m7nXCvedHVutTjI/8iiuYykn04R1c
	 tR1H6Q7Re/DWn6bMRCrODMhq2EoRx90Go4czJA+OmF7p2zapCEzGvJmixlMfbZxjan1gg
	 ylNxbqooHgVlLISkFYsLVE+AaCQc2Q+mle4OORZkxQgdYqB2Iwu1ve7GvIk1oCbNs/Y+2
	 0nuRq5Kw1nnzinnIGc0KIwmWR6VdoWJ4rTGSb1hvzorrwgDIlCk6HTFJ4gFsxwR7FSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DKUK5U9g;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDC606C18B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFDC606C18B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DKUK5U9g
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8490a7d6696so869615a34.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559757; x=1795164557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rqhIjJS9gtiSswzyzrQGj9FsyK4TI/z+J8ZIwdTjok=;
        b=DKUK5U9gGeUJWk2mqTHfjf7C1eMdGZMW06/68FFMXasZ617H5gy/KsNTI+pjfV8/zi
         KlvUIcJ+0htOzjihHdr2rZwFpS+jBZ+Heq4OpBfTBvzGzfeeIPkIrJxIV515/muEiyMK
         sZEqYzR32P4dc9xKzKwBXJ/5+Eq/sOUe0NMeQ6uebt7e9j98HKMYTS3gudAzgFneTulp
         xfxRYuk0qWsN5baBRcM6fae7J7c2VXVWLu5HU3ReJR8Ehr6daJTVodBH4u9VrFikCopa
         XcEa1APKv6HcuiCuw7A0BKCAqD/94sSLK+V+Udw/mZ01AOTY9eMTowuF3dEiJTNLbb4Y
         /pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559757; x=1795164557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rqhIjJS9gtiSswzyzrQGj9FsyK4TI/z+J8ZIwdTjok=;
        b=w1+fziiNTEYxfl0pGj2FAY+pto8/QDUD83We7OH+qxL4vSttE9agX3yqSw0vKBlqIs
         NY6QifN8pGyTgmVWgo+bWbadZWtvlymzoASFvuSlJYXMEo8O0CvjYTqXLSVobkG9ZsnJ
         GZ7YueUykUZHIUreBxqQe19suVcLTtZHw/bTjz04E7uFxjd1p2Xg2X0dhRZSQpfJohUB
         2sHgyog7yQWx4dlw3nDFx+snyMJd9WTVUaxCKHykGWBeuIpNkYJMY/OcpWs1rnJVq9iy
         6MESbh5JPpqWyjNODw5qYrQ6MTbjbNO3DrCMkhunvxROzNkS2+mpVzHJy00pKrs6rR1t
         gJYg==
X-Gm-Message-State: APuU4Z/Ufziy5DL6mphPqzXNk1Br9KmjgIax6cksbYwoZu0EOFzwtBty
	GErPEYrT9qM8nIiLlyYtctbp17YrFu1cA9wFB2lti9tPicNzpmFx0Z+6
X-Gm-Gg: AYBFou1IP3oDkaoe781uIZqoVYNvMFvfRh1RiZlkDdnWkayWiQMsCIaU4tzl6l0gm2M
	zFOb7EP7Lwe11HJNHKzpcM6vw3xZBCgY8khOoFSU1A3tDogZB3rLgpp03Vm+AkirvMa8dWLjNi/
	30rroqNVyAft11erpJQdcbEifE9Wx3MfnEXnwKe3SFnyoCNRSk59yG2rBiMu53BF0M6P39yGPgW
	VKxGc2NnEWk4Gd83RxRCYJQIfMasiB6Bs9CT9F9Em4icFh8Flkp5YxNUYoT2cIzhTnj4X85iHxN
	4DY0nFxdvIp1kA4r7mWbBpFkR2SEhnQN/rpENu/5LvFukvQGFCSCmubA7RETr8tB47vYyovwiW4
	S8YL10oQmCQUPSh/6WNbPZwy+GHi3P2KSfgoiXpdfjoKpa1mdmQWeBUCbIi1JyCQ8L0NOygWH58
	j6UKSO11yHETyQMXShiwwUNiR6sRw/8CkkJmr6UDQPhBInkXrwxvFgA8BNLHfZg0bjOgSYLOYIC
	CYk/8MIcVdoR5MfdlORYT9U2KkUdGERDKtC1D4q6mDnzZulFOJ07QwRrTPC+iFHaLN0lXPuAmib
	dNbLEAY7yNPgOYhvpYncnxeS4lAnmaqLBGs8TGxNGtmg1Ubs56dxAN3IdNfmM2dJlyvPHTqgiPU
	41k07cYl/KMzO77Md9oPz7Cwo/n5yIfrRjYGtJ8cUn/JBkaxqXOgEUOGbexYiAQYlPhmkRycEuo
	xXhu3EtZ3k5JatIKDoAoFjeXU8FFWiZsR0i6rt5u6QBPNEOIkHFqw=
X-Received: by 2002:a05:6830:3115:b0:81a:adf1:ae71 with SMTP id 46e09a7af769-86289739f14mr2026123a34.4.1794559756988;
        Fri, 13 Nov 2026 00:49:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm2034202a34.22.2026.11.13.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 01:48:42 -0700
Subject: [PATCH net 3/4] net: phy: quiesce the state machine during MII
 resets
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-submit-phy-mii-reset-v1-v1-3-02a55f352a91@gmail.com>
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
In-Reply-To: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Chan <michael.chan@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

phy_mii_ioctl() performs a BMCR reset write and calls phy_init_hw() while
the PHY state machine remains active. The worker can access the PHY after
reset but before the driver has restored its configuration and software
state. A statistics update in this window can interpret cleared hardware
counters as a wraparound.

Disable and drain the state-machine work before resetting the attached
Clause 22 PHY. Reenable it and trigger a new check afterward, including on
failure. Disabling the work also prevents interrupt notifications from
queuing it during reinitialization.

Wait for BMCR_RESET to clear before calling phy_init_hw(). Drivers without
a soft_reset callback otherwise begin initialization while the requested
reset may still be in progress. Share phy_poll_reset() internally for this
wait and propagate its read errors or timeout before initializing the PHY.

Do not hold the PHY mutex across phy_init_hw(): some driver initialization
callbacks acquire that mutex themselves.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phy.c             | 27 +++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c      |  2 +-
 drivers/net/phy/phylib-internal.h |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4ac72a1b4f42..5da8a699446c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -297,6 +297,30 @@ void phy_ethtool_ksettings_get(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_ethtool_ksettings_get);
 
+static int phy_mii_ioctl_reset(struct phy_device *phydev, u16 val)
+{
+	int ret;
+
+	/* Keep the worker out until the driver has restored its state. */
+	disable_delayed_work_sync(&phydev->state_queue);
+
+	ret = phy_write(phydev, MII_BMCR, val);
+	if (ret < 0)
+		goto out;
+
+	ret = phy_poll_reset(phydev);
+	if (ret)
+		goto out;
+
+	phydev->autoneg = AUTONEG_ENABLE;
+	ret = phy_init_hw(phydev);
+out:
+	if (enable_delayed_work(&phydev->state_queue))
+		phy_trigger_machine(phydev);
+
+	return ret;
+}
+
 /**
  * phy_mii_ioctl - generic PHY MII ioctl interface
  * @phydev: the phy_device struct
@@ -349,6 +373,9 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 		} else {
 			prtad = mii_data->phy_id;
 			devad = mii_data->reg_num;
+			if (prtad == phydev->mdio.addr &&
+			    devad == MII_BMCR && val & BMCR_RESET)
+				return phy_mii_ioctl_reset(phydev, val);
 		}
 
 		if (mdio_phy_id_is_c45(mii_data->phy_id))
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b39e945cebd7..8b0c1f28963b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1232,7 +1232,7 @@ EXPORT_SYMBOL(phy_disconnect);
  *   standard phy_init_hw() which will zero all the other bits in the BMCR
  *   and reapply all driver-specific and board-specific fixups.
  */
-static int phy_poll_reset(struct phy_device *phydev)
+int phy_poll_reset(struct phy_device *phydev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
 	int ret, val;
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index 38ee294f3c96..680823633d98 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -24,6 +24,7 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
 int phy_scan_fixups(struct phy_device *phydev);
+int phy_poll_reset(struct phy_device *phydev);
 
 int mdiobus_register_device(struct mdio_device *mdiodev);
 int mdiobus_unregister_device(struct mdio_device *mdiodev);

-- 
2.53.0

