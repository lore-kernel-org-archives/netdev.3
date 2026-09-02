Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944963B14CC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332324; cv=none; b=gdA39nLzdml09nSxqYvB59c4G+cDBTQG1Sx7oDzvSL+FylpwNto+5vdXL93NEW9nn7MKJg6fulu7nLHgRHjQE9PEdsHkDTBwTjKZwLj2BHjAxIPhra+4o7oA4Ij6WZ11GpE85OesBDqrOo4x0CrDLG6DJFi45ZsbizttqKyAeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332324; c=relaxed/simple;
	bh=iAzfWXsErr1U/mjSNoUC/0p6hO5HW9SOUrglviLFqQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJqBaMycq3LZf/ToKHBOigjHudzlI56pjlYPAM4AfvosS3NuFSXB4dz+N22N2PQMGySxBAvhWGypqP6zos8DkTSvk1QSyq+ZMy2tM2TYcS/OdOQsVX7LNGMdr3K6lCW2T+StPffYvnbzjX8i5LJSV2gDicwQDeQYzcifUufy/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAt3I2vH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAt3I2vH"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so686985a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788332316; x=1788937116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWHWfieau1Bus73U6m08/3Js6uHSvvzNbcHYCBGfH7A=;
        b=aAt3I2vHzJWSSEVfM++iAQpF61NehXRraj/Ws7xGSHkRpTaToqW90z9VowyDxPp75C
         qZXYPVCJXubJZr92B47JMiE6KQonLZQ6DBAQM/2spyYHQUPpcGQOmk/7MFqvfksTlRLp
         co4EU+4emN3LZXiNDXOANaE20xffJFRJUcYp+bfUScjWsw0Wpn0Iz5+RFY3c5A8FEhrH
         H+Q8ZYmyFWHFSl7lL2h8OLhmg5f42Y2YwNELq4xCGdo8we7FO531PW21mxV0WO09SRDF
         vrKmFB7TffMNi7lW/MukWRbEyT9KDnKj8ssln47GhuglSrN97r9UmSNtYQML5OzEuN67
         90vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332316; x=1788937116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWHWfieau1Bus73U6m08/3Js6uHSvvzNbcHYCBGfH7A=;
        b=feLXvgMDrtoN2f53/MVKS4irzBcNeu6VEH9T00MJpXW7rw8L3UdcMWKNJE2id+Kckb
         3ZfBIjeKATmuqX/r56s/ry3W7+L/dB0BGqrhTmK0L0yyUanicC1400eyez8h2WMDpJbG
         hveo/R8MZPBuilyEx5T49Xt8uIRG/VmvHpjEohAfLxkI9QGjcPwVMk6E3CEq0i+LWqwc
         jyotyVE+VgE6y4D5qf4ZaY2O5WZ6KMxn5JGYDc1rQV4j2SQ3tkIV9VeLYZqxBiptIrFP
         fM8WBmHWo9oR+w490tLtbRTGYY873OEzlU7GVAMJiQwPaLzCnxslrW+sI7ntWDeom0VY
         4ggQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjGfPWVLv6KrlVwKtbJd1dDpcjysYMIqDYdauU/4RTT5xwdk5HRZZWo+kkMijgZ6xc6WsMPlg=@vger.kernel.org
X-Gm-Message-State: AFuF++mIEz3aoCOu9vHB3+1107V2O6bG2fFu+Mrhbps6WPmlDpvBjgfl
	j1+rxeVOfWiJSo1SdXl0dXI10Qk20Pnlk+eRq7cA6zyiCvl5Ey/1h3dIv0YqAkA=
X-Gm-Gg: AYBFou0/DIGRthCiyH3ah2guXG37zZNtXAYuB8SrBc5pkssZ7h1hDitrJjPwluQSJJ6
	rpiDH8AMY9hYre7QO+yFcdMLTCl3lxbSJnRi0lwssolCBxHSQulz3wWDcPStF4Ghbc1YkW+Sctb
	2b1X8XxfWVsfothspMo4zP4L80iRVe1nKt6kIwWnStcmtER0hJSi/QNn581MLabZTcWw/Hv7x1n
	wgWtWGIOd6/Rdogkp9M2Uy5xLz24fgf+t6OZIXXuJxC3AkrGnjELQ1SvdYXWsr+AODPKsdJDwm7
	OT7PBKcu4CEOY4PN+PU9wCM8kfSZ7HIqNbvHGW+fL0eP+8vQ7Tl6tBxwTtIRB1ELFJFs4TB++As
	p34BD99878MaxMsxJtTV6IYGjAeuxrcXFe2WT0wcltY+D8ft59iL4yIE/aTAmxQ5NG5ceeJvIy+
	wyGDzWT3sZUEZGPK3FyeUbk/FKx70JiASdhu0RWTvsZTde16FmqnH7YIVeLlBRnGhkCTy21ZwjK
	sUT1EJYf6KHm90N
X-Received: by 2002:a17:90b:5343:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-39aedec7bccmr4308881a91.3.1788332315799;
        Tue, 01 Sep 2026 23:58:35 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6496:3266:4b24:78ee:4b4e:2dd4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d7bb9d7sm10205606a91.15.2026.09.01.23.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:58:35 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: dp83848: check phy_read() return value in config_init()
Date: Wed,  2 Sep 2026 15:58:27 +0900
Message-ID: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dp83848_config_init() reads BMCR to detect whether auto-negotiation is
enabled, but does not check the phy_read() return value. On an MDIO read
failure phy_read() returns a negative errno, which is then used directly
in a bitwise test; the auto-negotiation state is left undefined while
config_init() still reports success.

Check the return value and propagate the error.

Fixes: b718e8c8f4f5 ("net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for DP83620")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Only compile-tested; I do not have DP83848-family hardware.

 drivers/net/phy/dp83848.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index d88b1999d596..e65651ac567a 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -117,6 +117,9 @@ static int dp83848_config_init(struct phy_device *phydev)
 	 * we check initial value of BMCR Auto negotiation enable bit
 	 */
 	val = phy_read(phydev, MII_BMCR);
+	if (val < 0)
+		return val;
+
 	if (!(val & BMCR_ANENABLE))
 		phydev->autoneg = AUTONEG_DISABLE;
 

base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
-- 
2.53.0

