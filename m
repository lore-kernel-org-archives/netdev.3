Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559757;
	b=M90Chkn1vPQiD1JeckFMTpwrxrF1ZFlBMlMhz2GjGGbDa3cWYARkgS8ZM6SHAi8U0RS1
	 5URdj7pfYsk/YaH6dSFQ+oonOeSuCLM1/3fl0L56oeJFj5qwDJjrg9Hodu2RBK/YhIzvy
	 vF7lD4Z4Z6qWI1Dfc/k4XGs/gsBvHpLPLTT1qP83+Yy0mqoE/8xonglp/PoRs1fwDo2LI
	 GqRp+iNFY0upwsyfIcgg9r2PlYcIGFhMbm1uzwMWUEByxt3dF0osiYPExB9bnu94MhN0D
	 mVGnr+UzgafAs+yYeDzlHdEBZRsHAiUMDczbDJJVUClSSyaALqgIlDwPHAC1hecJ02g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=QXnJ3F0cJh2FPK/O6i6bjfEGXgvxbjb5q9E73TUH7NY=;
	b=ZvRxia5TieMczk2N79Oq2rmPSC7g2t79aRyd/cgyk6vvhCj2wD+sav6NILNRouE3N78Y
	 fe1lVyBf0zZ4REa0emHedlcN/p3cS93169R6xrVW0hIpZ3nu5SSq82vKc9ueMb1BXTInP
	 JBQDqghVFjHmdchalTeyeABNFBbHtlrvq40mNlSQl40NPuHkXY2rPJqg6AjXR9avzMzT1
	 6/7kYh+8HwweEH8BIn9Vq8J2QpGbyIKGK5vJ1aTbyiLAlORQKaXiSO9u9XPyui/BpLZ8O
	 T7wT4dzQvgGOd4TjpTEhguw+v6/1Z6QcL3muzEtpFWw7TyQO4sKWlzqUYOjPxYnXfXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJSwRDwn;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555C606A8BB
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C555C606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJSwRDwn
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-847ac7ccd85so848299a34.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559756; x=1795164556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXnJ3F0cJh2FPK/O6i6bjfEGXgvxbjb5q9E73TUH7NY=;
        b=qJSwRDwnJozevxznlezum5QEPEjGaMnHQbJxXVdNkauF0Izd0zdZHMh1BEeCcU3INC
         e7Paz6N1dNiaqFe/SnYxEKJZliXk0S+DjvQxo/DsjSVhnM0gmo27hxROU4rSS9XiWBFN
         8ZwI+O+oVzH1sF5h4nUU+GP/60DHWYN+V3d9Ir0RgmylkqNSNHuw8AkZEv8sDZPCjkw7
         JA/RrppBY2w7VrLzS+QZMssgulA6XmrIJ4LTU7aldXeCtiH5Kjgr23WKLcAT6R/GyPr9
         K4IwUdFZdf4HaOydgFpllA1wL+rxivXE25DsOlLOpaTGbGcygeBFEqtKbyk1h/3j+qmO
         IvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559756; x=1795164556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXnJ3F0cJh2FPK/O6i6bjfEGXgvxbjb5q9E73TUH7NY=;
        b=lmotZ/qc5ZKpLRt90l70oi8wCI0XvaYh68UhauDBwfwevuij4WEo0rCUPZiXSMavCd
         fgeED6KsdA5N4OKkhkB7z7f2PpeVvlBbk+1nhaOcmjeT1RdHZEcqP3XDpFLkGkGGR49z
         YlNWnyy1dniJcZ0APGWpWb87ImUVk7PwacZ2UrTq9rZZe9/gxhOHv7Q33lPVKg9w3xck
         Btpy508FWlZx+zyOeqGaLO8C+Ls9ZDxpRbxwlNP32h1ldMBEywmZal2Bj5D0Fb0k24+p
         IAfWAUnYPJ50W6w7GOM8WFRNg/aXpu9ZbSDn5dJyNthuBZJm5veINQ0O2pUoyTDgsuf3
         YXag==
X-Gm-Message-State: APuU4Z9VopkROE6oLVegfs7LVhAMgU7HA75D0gq9GRctoDKgywqCPz7Q
	dr+Cc0jUdMuFgFOgZCqHnVgw9S3ATP4SNKQvcQ+75UI+PI+zpWUgEvQ4
X-Gm-Gg: AYBFou3YHpRfTvslHjzeCRiCWOB5fjbW0vkY3qIHknB744hqYS1bmkF/SVR08rNLPDy
	hEkctiAKabsk3YR8GqyA3Furs/dSACGjz93NCPIiKahsnFdTdlKWatxLja0L1vyoOfVAOMbtR+V
	qosLwLYgTPTKx5IUlcaFbB2GhhyIkfvF3lAREqgk+fD1sbO97Fhqqwxz/c3BaKzkNdmSB/tgdsO
	Y3J59CgPJ6DdxjVezmbNDHHPkuObl+54U0So3ktvBoWJUBPE23HuccOmAG35A5IvqYl8L2XVTjA
	HGa3T9+oIt2+jFYryZ4A/jjYdCfqiQGU5EEfN10LvEjNShJ4Q6fGuRxrqtvYoMX1FTvppB0FJvD
	UiToZmCN5FqyPEFp8FhOqvQBBIfbVTZRdcZ6Ip2pik7gh9AQu/Ki5HZt8VTSilugv1UZv/dvIPS
	XSh0UC1Gs/OPK4W2pnfKLEWfosjLd3UgPgvHeLuSCLkLgXRGIpy9mJ6VcdvwyXKL80sa/HMewrp
	+u4dvAEDrwa8vMWon8l5nZjik3zhjVpdj0R/ECmYo4Er19G9wMfLk9E5vb/jQ7E/akSJKf/rwQY
	ybM/up1/2Ts6pKfZ+Y1ANr4tFvurPvZB178OGy78dyLL4k/6p/fmePXoMWnkegbMQr9wJuk2+fq
	7TAF86AMuPLS+/Z/lQJWsvfwebPiqk3hW+rvnWs2t4u2HhHqZ/YOLLAsIugGnvYgv6XRGNVepPV
	Qh8XYTK/hqb2W3RNNeLEvJdnjTQ25RS7jW4bce5x/PtDrhlmGyKyc=
X-Received: by 2002:a05:6830:915:b0:843:56a6:c881 with SMTP id 46e09a7af769-862898287c0mr2085688a34.8.1794559755689;
        Fri, 13 Nov 2026 00:49:15 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm2034202a34.22.2026.11.13.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 01:48:41 -0700
Subject: [PATCH net 2/4] net: phy: propagate MII register write errors
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
Message-Id: <20261113-submit-phy-mii-reset-v1-v1-2-02a55f352a91@gmail.com>
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

phy_mii_ioctl() ignores MDIO write failures and can report success after a
failed write. It also updates the cached link settings and may restart
auto-negotiation or reinitialize the PHY even though the requested write
failed.

Check the write result before updating the cached settings or invoking
those follow-up operations, and return the MDIO error to the caller.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phy.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be330..4ac72a1b4f42 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -350,6 +350,15 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			prtad = mii_data->phy_id;
 			devad = mii_data->reg_num;
 		}
+
+		if (mdio_phy_id_is_c45(mii_data->phy_id))
+			ret = mdiobus_c45_write(phydev->mdio.bus, prtad, devad,
+						mii_data->reg_num, val);
+		else
+			ret = mdiobus_write(phydev->mdio.bus, prtad, devad, val);
+		if (ret < 0)
+			return ret;
+
 		if (prtad == phydev->mdio.addr) {
 			switch (devad) {
 			case MII_BMCR:
@@ -388,12 +397,6 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			}
 		}
 
-		if (mdio_phy_id_is_c45(mii_data->phy_id))
-			mdiobus_c45_write(phydev->mdio.bus, prtad, devad,
-					  mii_data->reg_num, val);
-		else
-			mdiobus_write(phydev->mdio.bus, prtad, devad, val);
-
 		if (prtad == phydev->mdio.addr &&
 		    devad == MII_BMCR &&
 		    val & BMCR_RESET)

-- 
2.53.0

