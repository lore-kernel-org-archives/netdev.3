Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326794;
	b=Of0AS1q7cnE85lpK2zFKlp6BfSj5PQ+GCUUa2ntimZ1weWhcjpg5dFNWqmYol4QCOq4J
	 +x3J7gOVzgeT9UE1x/18xT8hKUhsZS+86ugLYTgTUQj/KgqTpk0IWVR+f0R63VemTfpev
	 h6wlqXzkwIN77bWCr4XqJHvD1TicPWJwPjLdT1rt16OIiGLobCl6efoJo8VaCPtolFcWW
	 nDc5+2WsY1wlOYg9/EfB8rUnv46aRl++sT5Kop6PO/2nvejNDCwroNWlo6MDFYFIRVOjb
	 k/fePG1GlQU/FDkpen6XFfG7pAsBL8n+tYmtd9ladwH9USiCKSUKIUHg7O5l1/7JW1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vrfc2uaAwCa6vgkw7mtiQRrVI6iR2fXJpjV3Toth268=;
	b=UmVUzDpffQM87nADtYhc1DCk1ELGSpZ9afj9ck2mnPYtQ2+Mp9ALlU8WzfIlp9uBMhmX
	 1g9MgljL1BejImPJQ2dNTx+DRHyKoZ+GRscSN2HNlHrfCTV4W0b252C3gPklLCuOgSkCR
	 HpjiREH+E4AIfWCd94PWb75b9MekwvVEPthuNtmX/rR2uxQqc4MVi0P0grMpzXq7HOZyk
	 JeCWBEsXIBr6TC5TSd85ytYqmKDCeYmgyQSp97JurtKlsXeW7bTe3fdQU7yXgCr8LDCGG
	 6hTQbVLa3oD5L/hEqQvakF4z/Qss0/M4CrVgUJw2AMLszrwUawqgjM/LzafHU3LKVZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYvFUIu8;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19D606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC19D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYvFUIu8
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1483756eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326793; x=1794931593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vrfc2uaAwCa6vgkw7mtiQRrVI6iR2fXJpjV3Toth268=;
        b=hYvFUIu8ZWv5dNB1GaL7fkMqJA6tevDFZDf3F1b5Cpi+lokAMJ3ZnlwuLs4P/904de
         1HRWfAGVwhbAOkaKTzYAycjUdmIzM9viu4Nj+kYTSAqyRs+vq4d420OZDT+zyxmeq8Dp
         yeKxSaRe6mugmCFATS1mXydwYbRIaqIa48ypthuFz1nG59/w76l6JsvT+jrkP09BTCZf
         PEe5NJqC9qE/ZxK0udZIpnpdPtUhWAg4LLVUeYLG2YHFKLNgrnwMZKtK9ozOY/PIhk9z
         iK2YnR0xoboRrFwetO6kN8gtarh5BdGZX2FLSJ1TKfHKbcCPTpOzn8xW2wVnRxd93j+u
         yJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326793; x=1794931593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vrfc2uaAwCa6vgkw7mtiQRrVI6iR2fXJpjV3Toth268=;
        b=q+JTem54T2I8q/ZxKu6nF7stTtFkRDbBs4mWdmw6xgj7HdhhFo17vZZtpYFAiss01s
         BF9srCLMd+rbEzw/uOyJvsEeVQAmbROlVvDN5WeLzUZXxaMlDLzgD/3Ig8cD5bdPMPHB
         D8wSW3L4P3SjYtTlGd9iJJOMzPNuqzuNT1waWYaWnkJnTh0O1u9r3JN28c+Qm9ezpw+H
         kku3TWnyQohBIsRYZ8W/wHi9SEXluTEFRyBnNGxpdRdFYAn9dCdLnbaZY6v1mWFMR8Zn
         Tk97PWTWSP2avRXTs/wNEQbAiP+hdG/f6FJYsbMbULGDx1vOG1gV9sldQ5u4hKWfZ/4b
         +pow==
X-Forwarded-Encrypted: i=1; AL+hErGzNtAtrUbOtvWmWzioBYe2XDIosaeMqWyKACeKR9Odm0csWa9B/+vYAO1Xpzq8x25l9Iu8LAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rHT4J7GmIdhr4JEYhTB38oYF3Y+1h8BEbP21b49VWGmUXdL4J
	7KhagTzNjsHnLCkHH5FHT9Tj5mSsKuY1YO9L8g47J1Jj8ErEt/1bfkyV
X-Gm-Gg: AYBFou3ynOVyWyHa/UOh34ctO1d1Qg7XDfZH4d+LZ4ZZgZTVRxLX6nqG9VDcCplEUIv
	eZkGKoiPoblUZThvP1/9Sbff0tK9APK0P7amBf8aXlduq6vt/imPYl08wrm3L9uAVD71xlGh7l0
	z1SyNXhaMS51E9jqqYVwshesMhdycDfQ8N25GGBP9zENWC5Dz+xN615OoFpGES3AhiAFntaTG+A
	jtXEYghjBrqqOC6chbqVUZ60YNMUgjSxxiqpkVxgdAZoZm2AVkNFL/FsptdFjenjPbqzDuMGbmF
	ZP1eEt51WIrzOjVX+66QqMROb6ObCbEWXvU6oKNAJdNC8UyO+kSwE8Ot9QKyl+A3cSo0GVb+5Jn
	tby6mu/Un4d4vLQMz4xCxaHsSz2wgjj/2Hjyfkf+3k0Wc/p7PF8jYtUisvhacg5sYPeYGptYwWZ
	cfk/mkMKaLeRQOa7ElIF8kMb+xRzUqQfzXoCRj0UskI7AKCbxOG/at4tcgmoaizLOzKQHv/RVHw
	tqM5Wjt9AjWSrtNFZMlq5lSljZ2VeR5Y00xNNk7LpzZ/XWBHgYWcTR+80Cb/UE3aHbNhusxTRC8
	gcE9GBTaahVYTdqdvClCIfFWPOo=
X-Received: by 2002:a05:7301:4d05:b0:369:535f:4d12 with SMTP id 5a478bee46e88-3751c53edf2mr3716461eec.3.1794326792549;
        Tue, 10 Nov 2026 08:06:32 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm8453403eec.7.2026.11.10.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:06:31 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v4 0/2] net: phy: fix PHY interface mask initialization and XPCS usage
Date: Wed, 11 Nov 2026 00:05:52 +0800
Message-ID: <20261110160554.918652-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This series fixes issues related to the handling of the PHY interface mask
(supported_interfaces) at the core level and in the XPCS driver.

Patch 1 fixes a local macro in the txgbe driver.
DECLARE_PHY_INTERFACE_MASK_ZERO() incorrectly uses PHY_INTERFACE_MODE_MAX
as the array length instead of BITS_TO_LONGS(), which wastes stack space.
Move it to include/linux/phy.h and base it on
DECLARE_PHY_INTERFACE_MASK() so the bitmap is correctly sized while
still being zero-initialized.

Patch 2 makes the XPCS supported_interfaces mask authoritative. The
generic compat table advertises modes that a specific integration may
not support. The Rockchip glue now builds a platform mask (1000BASE-X,
SGMII, QSGMII) and intersects it with the inherited core mask using
phy_interface_and(). In addition, xpcs_find_compat() now checks
supported_interfaces before looking up the compat table, ensuring the
core respects the narrowed mask.

Note: checkpatch.pl reports "Macros with complex values should be
enclosed in parentheses" for the new macro in Patch 1. This is a known
false positive for declarative macros that expand to variable
declarations; wrapping it would break compilation.

Changes since v3:
- Rebased onto net-next as suggested by Paolo.
- Patch 1: drop the Fixes tag, as this is a cleanup/optimization rather
  than a bug fix.
- Patch 2: move DECLARE_PHY_INTERFACE_MASK_ZERO() to the top of the
  function to comply with the reverse Christmas tree order.
- Patch 2: clarify in the commit message that QSGMII is currently a
  no-op because the core does not support it, demonstrating the
  intersection behavior.
---
Coia Prant (2):
  net: phy: move DECLARE_PHY_INTERFACE_MASK_ZERO to core
  net: pcs: xpcs: make supported_interfaces authoritative

 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h |  3 ---
 drivers/net/pcs/pcs-xpcs-rk.c                   | 10 ++++++++++
 drivers/net/pcs/pcs-xpcs.c                      |  3 +++
 include/linux/phy.h                             |  3 +++
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.47.3

