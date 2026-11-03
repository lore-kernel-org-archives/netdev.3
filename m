Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744092;
	b=nCCKAFoGieuL8yafv2LjffR0xYV9LY+6AV9hmQpqDEPsEWnS2CDwOSByolvzl9VwbqA2
	 48HWLO9eEyseJoWJFAwzlrPY3s/DtQ4e3IMYHcCkq2vjos06EZ3p7DWxGBPASUFkTo/sa
	 82OTD3rTRegEwVSx3LDMintC6E5w7rVHui4dyAnzXq+L3EfgWPBvh6PyXENE35SyPfc+D
	 +Qg+hikBKRp45+4FxbhEiOxUKnInBurvpSs2oo79Fn5/2hyL8sJl/xw20jnVpmsBXII24
	 WaecQtd3h4Nk/G/bxYywyoH2S8VDdNauWL78HekPsmzwsjAah1AXjaoS/l1+V8lxPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YkikqgGDTTpfPmNY7tvfFChQYii8/CyTohIduvPVkhY=;
	b=wGx/eMLuao5kwCTRxSS69HhmGaDR+Pp3pqOJ/ckyJXfQYnc6u7JCjswsoeHhIal4PvhY
	 zX5mXLd8SKgrToGN3bNPpKUxiDDu1sv5Y66bdwQWHWWPuzzpBOhthQ9CZt0sMAbIO43is
	 BM+TVpgAXUqok2oy+vQ5LlOQt+m0+b6/3KDDWh9Vy01qCpQ5MXtKZtdY6qIKobM/Nvd0L
	 uw+hHyfwrhummNIIkq0YL0hc4J+9XMbzHFztoDvCGYb8lVUw+Snr8IYqIkWybmQzV4uNI
	 Lr4jXOTQnBc1pH85erzfnGXxieIS6JzlGQFGjLVOyGL3++JtQ/BS5tp6AecUT064nFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bSgd2Xvo;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC825606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC825606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bSgd2Xvo
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b060ec084so50856f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744090; x=1794348890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkikqgGDTTpfPmNY7tvfFChQYii8/CyTohIduvPVkhY=;
        b=bSgd2XvooCZoj1WBBnU2JPzZzdGUCVkXD3CGWAFATK00BqiwAcJ2jKJSxcBlLxZnFF
         MAWpFCoUMbyKYWbzoL30cgmvnAx6Q7Kv42efz7tOQ0ORww8IHp1emlAQsq1UJN4FHaFn
         RxigVvNpPcBAQGImEvqdx2SJdTjPADH/4W0pOPQDIKG77NW3/oe3zQ5F/8c+6o/4eivG
         9G0mWq/9ELGSFsWpgQyMkA2ABh6nlbvVSAurZUiVgWkS+eJNHELB/loEtw1oPdwHINdH
         rRpo0yLEFXU4EW5eJSVdtypWY3j25L6UrqKQMcfCcYiAXgKJfkCOtgUTjk5c5/zaATcm
         Q9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744090; x=1794348890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YkikqgGDTTpfPmNY7tvfFChQYii8/CyTohIduvPVkhY=;
        b=0EVEcgKpa966/8uvdUHyz6ms2gf9gl3qHCnpZ6nYIZfzjJU/cuPAEfuQa0GqJ4c4tt
         dNX0YRa201Gg/R64l3N52yKTJjN5YuidkxKiQyzTIXKL/Ww62Z7iusFc3Uj7HWwn76gl
         sQ8tX7kDy3ohgRYQRhDopeyfSPNh2nVzQEsxeX9a2/Vo5t3KAlXvaMC5IwHCS6qHGmRU
         zs131fp2j8Ibt/CHDG8uTsceVznsx3ARkdxOF8n6iKkcxeDcPwKPTrgugjQ5S8k11oEN
         PyYOBAWFa6vz2NqawaEbwXbvDZRfLfa9LG/cFDz21JVNuwkl3kx7xlAdqDihnFi1j1my
         GGMQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8NzC9UEqPs9Dbf0DgN4hLiOOVMDPwWtXbf1GkVQ/2JX/ddhAAWqmU6Ag6WKfrJj9uRJ6Bmr8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lwSdmUx2GO3vtJRQZgYF2AmCnwUVlOgWy48ea8qi/ultX9rJt
	HqLALeOZBS7X25xHdIXBuQtHSkkO49AeamCPVteYwjRAFNhn9HF2/inG
X-Gm-Gg: AYBFou1nNU2U5Badri7OuEULmGKn9osDc+KIx/bdY/Udc9dKCvmJJaM5iP/a/MpjoYu
	rHVsgEeoTjf9hreXvQ+ekp1y9gPpllT/avY8KYruh62bmcAcFuMPtcc444N7+5eCzgwxj8fEBj7
	ChLH0rNruqDWTwxaXw2B9nmH3zO8XZu92Od6SY5uUp8rFgIxEj2vECh8NGn/gwiTPSSLSX85f1k
	HVZO2ZTr7xUu0oK20P/kqwNImIZiFRnu9I5ft9tNkjkkFCXbXowIOsQDD1hXVSPz65s9RPDXPuy
	i3wfaUeCQZqd/pNU+G4Oz7av4diNog1StUp/HCpmY2MBxBFLjAnuifHBU7L0XZ6SBJc0V+Yfaep
	RO1HKZzBXM6ATlJX1rfKO+vzOiyzdNDtKuJJYvn5eeb1XdAn+NQEUyz3e4vtphwke4uVDZoc66s
	v3pPdDJWb+QXtlW8nY0GALU9fSiXJguCNcM0UMIh7z1nck7mFcL6bBOW8L4c6CI7LeRvDnrUTTT
	HicikTI04HxmNUognCxKL1zaImoKpb2eP9mmwoNang9c/P1VIf40b1h/IOIKTlNskYOtRJ9abc1
	/87WiTRQUR7O4ozwSu7WvzzkHocE9R8tDe0UrQaA62Px//cTquc2qXcSB92yyP6mjCtXDF3FUF0
	uS64P1/Lkokhg1zgPojMBnfJaOmwQ/Arkdw==
X-Received: by 2002:a5d:64e3:0:b0:48d:f876:f370 with SMTP id ffacd0b85a97d-48e6e309763mr30399015f8f.48.1793744090007;
        Tue, 03 Nov 2026 14:14:50 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fec9cd43bsm328556f8f.14.2026.11.03.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:14:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4 0/6] net: phy: mediatek: calibration for AN7581/3
Date: Tue,  3 Nov 2026 23:14:31 +0100
Message-ID: <20261103221439.30502-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This small series adds calibration support for Airoha AN7581 and
AN7583 integrated PHYs.

The calibration logic is quite big so I decided to split
the driver from the mediatek one to keep things organized.

Minor change were needed and just additional symbol to use what
is common between mediatek and airoha PHYs.

I followed the naming pattern of mtk by calling the new source
airoha-ge-soc and related config.

The calibration use lots of static table and software calibration
at runtime instead of using efuse to calibrate.

There is one pecularity where some register and calibration needs
to be done on port0 first and then with the related port.

This is O.K. as port0 presence is mandatory for the functionality
of the integrated switch and it's assumed to be always present
on the MDIO bus.

MAINTAINERS is updated to reflect the changed code.

(this was tested from a long time and also verified by Airoha for
correct order of calibration)

Changes v4:
- Fix typo in Kconfig
- Prevent out-of-bounds for zcal_ctrl
- Protect concurrent rext_sw_calib_done
- Validate port 0 presence for calibration
- Correctly set shared local variable
- Use phy_package_init_once for shared tables
- Better handle early exit restore
- Better handle phy_select_page

Changes v3:
- Address comments from sashiko bot
- Apply review and suggested changes from Airoha
- Rebase on top of net-next

Changes v2:
- Split header register patch from cal_cycle part
- Fix missing EXPORT_SYMBOL_GPL

Christian Marangi (6):
  net: phy: mediatek: export __mtk_tr_write
  net: phy: mediatek: move MTK GE SoC registers define to dedicated
    header
  net: phy: mediatek: generalize cal_cycle function for GE SoC
  net: phy: mediatek: split Airoha code to dedicated source
  net: phy: mediatek: add calibration logic for AN7581
  net: phy: mediatek: add calibration logic for AN7583

 MAINTAINERS                              |    9 +
 drivers/net/phy/mediatek/Kconfig         |   18 +-
 drivers/net/phy/mediatek/Makefile        |    1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 1882 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  553 +------
 drivers/net/phy/mediatek/mtk-ge-soc.h    |  377 +++++
 drivers/net/phy/mediatek/mtk-phy-lib.c   |   77 +-
 drivers/net/phy/mediatek/mtk.h           |   15 +
 8 files changed, 2396 insertions(+), 536 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c
 create mode 100644 drivers/net/phy/mediatek/mtk-ge-soc.h

-- 
2.55.0

