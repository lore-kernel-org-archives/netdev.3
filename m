Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559756;
	b=yskBKGWA/kkIaN0n9iMXGKCrNp5ET1VeBck+s8vp02SsLYB8oGqEuQOAonM2XRyrwLsR
	 B1JRkN7pUHKKDsL3RpyPW4cRtXpaI7AL5P0gMzMcwFQIhZxGxubdqF/VI6ut8fWSiIivg
	 Dh6Gv1Z2hTusyiZ6MnGt86vSnVxxM9XZFrk2U1NUXeaecf4oOouSvdSslxiQ7xOCHTml7
	 JN/g7BNrpswMOC4X9x6wjl+yhAO402Wc+XtJjmEIlnCUbI9/EOsbhxBK48M1l6jBWpSW3
	 6v7YOw3uJEvzHnUVQGQtDzGfKp5AmOTdmrs3uma3zsvijiilBNQ76y4i7kHkNyFRF/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=IuL3dRBiD3SJ5KZPCb6prNb4XCfFwTEE4VTqJH9O0rM=;
	b=TfbJDLde8a9HDA18b2WXl042mG/Tp7d98q8r92KHtkMUey37CyIPLnIJStECtR1wdPJB
	 zD4r1yWWQaHM+LneCM6hwBooTxKHZNitYePsUCgAwiMaPNQwuMLOPb7y6HLkM0YEr4wFy
	 YGbYNDX8VxOu8o4MSFd+RvNp4Fn5iXtI0BJRdOPo7UXCdrI+uozrFbsCWYaeLiPexeAJu
	 TlBaVZ1RTS1+qkWDoa5lxiJZG/qrRxZOogOqsKGHJP3klRj6DH2LrpNSbsiF3YNyBKhHk
	 Zg0kUUMLtNU2H2NOE5FLgg3t1iBHcDSFqQ0AfLLk4nK7nFgLTczK6/5/SMidK+KRkPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Qxz1/Avq";
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85802606A8A4
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85802606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qxz1/Avq
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85d363fb73cso742781a34.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559754; x=1795164554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuL3dRBiD3SJ5KZPCb6prNb4XCfFwTEE4VTqJH9O0rM=;
        b=Qxz1/Avqk0MJFrqIxkdchDZmhqJ94fiLcoltn4yObo5jfeh5z3Cc+J73XF5Ej6YWue
         0d6QVEQ0pLzJxQpWSRGOmr1CWjqw6Hz3ZbRNFQvr+ovz98sjSzlScdld19/EKZi4BQpS
         +hlzlh5ps4IIUz0lp/An7ajphKNCM/WYjfRa5KxW5aKrPdaRkBevLdSKnZWrlCIqMUw0
         DQoaJgyXRkhe1V9B4q6jCHOwHNMbWe/JdlfPxxZSD7j+7KdmYtpcwHGk+LaeaRnpMVAI
         HLmVm6bHIG8CbYTRXjMOtK82uPMdq4mwA9ErYuuaOVvaHP9PTpoQUtU/CXsFIxbGV7wz
         ytLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559754; x=1795164554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuL3dRBiD3SJ5KZPCb6prNb4XCfFwTEE4VTqJH9O0rM=;
        b=iJnEiyzMGuAJFw65FKNWOzCWOZwtHNKKc8fAe+hUtMfnJdzB5Pi12ULI6i3t+WBab4
         60HIxw6eq6mOMBrTbg3gfXNPNY43pFuUt6s1QZgJplGIOMIv9DudCw8Tq1Q+/rtyj069
         gbWgj7EUBqRVlzrb+hpn25uCe8WdmgmUJpPUh/Q6r0ijgcRoCC0/E0NV7XbMB5NB+4f7
         9/qnsNWdtsjV8BNoKXBDCCo9ZlseX68CZ18HEInE419rXsnnnBi2K3KuTRGKotY49Kk6
         D2gYhtAIqmVkbAquP92/AusV6TSo3IYAOsG6+dkJguvVqRpA0SgDRGFp/ZfxNSe/FvcJ
         FAtQ==
X-Gm-Message-State: APuU4Z8rAtUvj5eXKFdALk0OO/UAbIu6y3JGXfwescIu0xpfFYBHrKmn
	wFl2Mm8F8af3UGFi9uhJHj/xn/qJkx21C+e8e8EAITOCOq77TxrqT6mA
X-Gm-Gg: AYBFou22wBpwZ1Tl60r3LxZBCCmMMDLgyu+p0WGIKWj8SQ6wmt7YdtxxlKP/7gXspCN
	fhU1sXqAJyrOhNzIYzgDiFz5Q7fVhK+UTK+xbOcgF4sGrm1IOVClGnf40AULDzGChVjG5/nGnxa
	P7bstib3gzvQkT+O57B/f8C/14Il7qPcbs/Bb3D20ou6mgYa5DRedYszBB0L4Z757JDMCy4bY85
	DXVqJ3iFuS9TVTpHAHfpsuvjtESLAFVjW98oqRpwkD8yR+OAjn637ny3sg4MdJcFXPNhiUxUv4q
	coXsRsSOg8n2lv5LPTJffyiW+Vad97zQ0ICDPLJyOiIzVGVMaSvEV+yQKg6YPQ2DwbAkCyu8Uul
	6HtMBWyeM9SF9YvW8x1NuYLp6s1e1dlejbBOZ9pcoRjU+2lC7gxoAjQofTcqDqLzyYSS6HZ7juw
	ooqX2DZ+yvggf/m/ZvCiW4Kq2/S/OTTI3ZK+9EzYdlEQP3K80dPEFujDqK7n6sbjKumTjxsaxo4
	LKrcsOPyEOrZyRLBq6+aOWaPQ58A0Mb8eLobX6yPopKClfixGSu0NDPOCzqK/D6vKhE0jPRGTrA
	8RSwZ6qtcvM3NznyF542MKlyWixXtYfBvTfJPjCxM7GHi7dkMyQMEN6bxg/j7qEPk2L1TeLgAVm
	NV3GimWp7gStHKyDlH5ZXDxC4vhYhZmLE3DPA+D2pcKIHu53GZZartKx1Enu5NNr9hv+SA0NR8x
	sQo98S74QqvUe7LfX/Yu4mXnKAzLomZ4sMf5G7F9iyvHA62QcE3/4=
X-Received: by 2002:a05:6830:4104:b0:821:a0a4:5016 with SMTP id 46e09a7af769-8628985a066mr2039409a34.18.1794559754339;
        Fri, 13 Nov 2026 00:49:14 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628817d979sm2034202a34.22.2026.11.13.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 01:48:40 -0700
Subject: [PATCH net 1/4] net: b44: keep phylib ioctls outside the spinlock
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
Message-Id: <20261113-submit-phy-mii-reset-v1-v1-1-02a55f352a91@gmail.com>
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

b44_ioctl() holds bp->lock with interrupts disabled while calling
phy_mii_ioctl() for an external PHY. That helper takes sleeping MDIO
mutexes and can wait for a PHY reset to complete.

Keep the spinlock around the legacy internal-PHY ioctl only. External
PHY register accesses are serialized by the MDIO bus mutex, as they
already are when called from the PHY state machine.

Fixes: 86f4ea63e696 ("b44: add phylib support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/broadcom/b44.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index f994636fbd5f..e9f116dfaad9 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2126,14 +2126,14 @@ static int b44_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	if (!netif_running(dev))
 		goto out;
 
-	spin_lock_irq(&bp->lock);
 	if (bp->flags & B44_FLAG_EXTERNAL_PHY) {
 		BUG_ON(!dev->phydev);
 		err = phy_mii_ioctl(dev->phydev, ifr, cmd);
 	} else {
+		spin_lock_irq(&bp->lock);
 		err = generic_mii_ioctl(&bp->mii_if, if_mii(ifr), cmd, NULL);
+		spin_unlock_irq(&bp->lock);
 	}
-	spin_unlock_irq(&bp->lock);
 out:
 	return err;
 }

-- 
2.53.0

