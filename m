Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8253BFAD9
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829567; cv=none; b=NC+8XOyeKLvWt8S0vWyPek8sjZpkjDeOWziShYwv9XF/jjsVAuoSryYt6Uv7rGLsNt4hEv/fVc9vK8Jjjrb9iDSvjNilady5KclL0lmNv5pPJZKHoorTWWtffoqryeWTcmBHWx/WyQKFF4JYBPUHYykBDqiaTbO3pcbd3U976z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829567; c=relaxed/simple;
	bh=SxL7aIselSeVkJQgx98etKVzBZMns7vJQbD/l7L+jFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xsp0RUXHUi6n8K8qKQb0Gd99zrxbxMTmSppTQmwii+s+dlJTKejUuUmpt8tYdfK1hO54qdn56PTlvBVttK76T/yeXaSSk/JIDjtm7bapg5m95goifK/p9SpjBfa/E2NL8TaErmLM5XTlnK0WNqRFCL7U3Zvh71exzOcwaQm/Tl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEFLDcfn; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEFLDcfn"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f0c89e34so4316222a34.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829565; x=1791434365; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3lo2Y0hgRgiPSnYGSDe7Yf1GMCBIGPwRSlX2+EmhVtc=;
        b=PEFLDcfnsnAGhyfEZkE0rRag3W7PX3qCUnYBZpWp1sbyF6GwWfd5rStaLfpztuwo4t
         LsDl/l+WrZKjBZ5mk+Z5sY/GFUBNQTx7L5jC+NFj3RibT1u3nkvhxkRJeNSn6pdhgzmT
         DPKgvF7Ma4Rbn+U73H35H9/cc02SK5F2SLDEi+NclZ2bOkZrkbFzOPTguz5jOrCNCEx7
         mX2m7a+5OTsOd45v5AOiGx29IcSrui9bt5BLUInviJwsP9gchTblNLqqlDziDpFsznsq
         tMnTI0BLWBTD51eUT9E7AotMxNUAOYPGajA2w98t8uixq8wK1mJFVeiuY1AFt4vXZtJC
         v7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829565; x=1791434365;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3lo2Y0hgRgiPSnYGSDe7Yf1GMCBIGPwRSlX2+EmhVtc=;
        b=w3KyeWhR7W9HS3f2FXa0ZMYnPlMw7yAQK6aZem4EUQkOAFYYlZ50r5id0lCxUhlYEI
         NQiGAMZbZzLRriBsAbG3kviOv/cHT5To+KZPPclJJGUN8xqxNbxXL4StfGw8YxLtpc1G
         FnB+q4piurWy4NhS7i2R4oNyqXUoWfMsnNahlJP8qxgJnKbSVEpDk94BuJ5awyDIxu2Z
         o9QCSVWX+OTEUQghyQOxgX/ePlWtT1nQOq+fIcutQxIASMpy/erZdleC58MvLKEBtNUq
         l9o5KelR+5S8xzLiU04xWiLI1p/UV7YLhwtXQM08KE3iWX5OQurshpsVIinxwCGxKhN8
         rdRA==
X-Gm-Message-State: AFuF++micVA8JnmAJn+bWrIhDvpkUXSjh1Zz45CdgmrrYCatijd6Zrew
	yHFlBtObhgbQTCJRbteFgS3nPaMHrdXLQaZjIiPMmcGtqCb4rhLnneDL
X-Gm-Gg: AYBFou0FA1uee12IVub3PFQCoJnwS1ZEdLuVxgSlkbNt06Kwy78Xfqlnv0mkrMyFcxU
	YHPImFaUPNbCRbts+cSkCTDtwD/s1lWxz/fD4g4xWSMFmNlrPYEIqNcyOnvhuvdnjc2KqpAWFw2
	0iV8quWwdLV+KzaJ47O9mC19TQXYRclH/lTxbVNHAvzsIfE0+qNgiJ5IqFK5bLgE1lw6846Nvqy
	cQZK90y9osCcNrEEu52aaCJ7c8XGwo8nex5yGWBKH7TbBvB1m+bQUuAgIqo+uvpOPcnwNwmT0Xj
	fSN8W0wp2ZHZWLb6ppbOTF/+BDe2dZ0ohhus0e5Xwb22ULNpHKlS7q/BfW/dT923b1eDJEtPmU4
	nEz8vf8WNlg/SZfMI3bRetaBL/afSKGA8nKgEVFtURhv3NeNvNGreGKr8Q3AU/dT63FCXQAxXtC
	85HMA7ialj2RF7MUq8zpPIUij9NGIhgGzp6ztpROeY+FQ/6tt5IQe/f1mFwJLNfQssnBvYB7BZC
	9vQR1aFLHJpWWo+GUwUFGlV/HSZlvzW+a1Q0g40HXYTezqcxrr4N1guvCRKA1ddRsLHxVbD4rV4
	WRJBuy72yF9pIKbLMsOU7pGev/SXh4+nE3vi7oYj1yDDlquweRJrj/VAAxJRtCPQuIgkee8IQtW
	voov/AAWldErFv+fUxsBBAWsGEitnKlSV
X-Received: by 2002:a05:6830:6d4e:b0:7f4:eb76:881d with SMTP id 46e09a7af769-82049119577mr4659618a34.5.1790829565141;
        Wed, 30 Sep 2026 21:39:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212aa1a2b8sm1792815a34.13.2026.09.30.21.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:39:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:39:22 -0600
Subject: [PATCH net] net: stmmac: leave the datapath running for
 normal-size MTU changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-mtu-fastpath-v1-1-fd73f378c071@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ6DIBBEf8XsuSQIFrS/0njYxaVyQC1g08T47
 yVtj28mb+aAzClwhltzQOJXyGFdKrSXBtyMy4NFmCqDksrIQUuRS4zoRCy78JjLhmUWpu9bzTh
 pGiRUc0vsw/u7eoeFC4y/MPFzrw/l3xBmFm6NMZRbg5Y8Ena90qxda65ESsrO2Y69t04OxlhFz
 sJ4nh/Y9ncutgAAAA==
X-Change-ID: 20260930-stmmac-mtu-fastpath-68813ead3b90
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

When both MTUs are at most ETH_DATA_LEN, the receive buffer size and MAC
receive limit do not change. Update the MTU without restarting the
datapath.

This also avoids rebinding a live AF_XDP pool to a temporary RXQ. XDP
rejects jumbo MTUs, so all supported XDP MTU changes take this path.
Jumbo transitions remain on the reopen path until the rollback change.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f34d491c959..03cd14d10356 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6161,7 +6161,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260930-stmmac-mtu-fastpath-68813ead3b90

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

