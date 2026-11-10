Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282631;
	b=jZ8E3ZlRWp752ML7V7QY1SfxteROL6Km50uhUh8q0P1g1vLpDil/+2EzfhK8YNyBKiqm
	 vTqNz8y45gygfSwbl0aBun2iaSFWD66L1z4ZIXoDHcX4uj9ZdBO5cJVXsLrO5XPdvVVbt
	 ccyhR6tFG71h7oUR9WvUlo9uofGl4x+he30yCkOGJd/x66P4Ljfa8cjFI9Mjeus29WR8U
	 gje1H3ruHOiAjnveoaIueZu8iyWskU1fwNSlc1OxISWm+7aBJC521Poy1gMtlx73OfHvY
	 B/W5wy8MCq4lR64D7STMGGt1JDIVUAZgf4wPDGASsI8Qovp7fdqVL4trVHZe0aK2cCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282631;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
	b=SA2bgmlaMy8EF/qnwaJmKyVpuiHcfldCxS36Ab0wceKdKfe+7bxPQUWp8QrcVcOr7EXc
	 RYiARmnQ3CHrfpVaPOKRy+WsRu1P/zpURqdWgQGqZtXl3z7J4x6eu8IK38TnzlzIqf4mm
	 RnZlXiYbS4H/qqh2JCCBpVFSdQ3kPT90h/E5tXLfSG+16d9bGSQyeLgwHXyyDWMN96O5S
	 bdMkNW/omG6mSh27v2tVY2hLGahTzuVrmDkwGDtVG0RazUm9WV2g/P9eY3eQQtAWT7vyN
	 Oy8mfesUANYdR9e1/cxRjI1x1a6D5VGVOMUirmtuNt67tF8Gjs+S2qgchuq+zoY83Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QnY6vrr8;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0360A2608
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E0360A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QnY6vrr8
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e635220b4so144396985a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794282630; x=1794887430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
        b=EPklrc8dLZibhWe0GVKb51zXPw38F1cknmLQy7lDn2Hzz2iONuciEm36H/ybB6yREn
         so3ptPbMMhfn4STAl0CyuG4rMYfvMoyqdDqCZqeTuS8jQkUGFleqfGtmvHfV1xI61pxC
         HKIZeoPjxsabZmNpz/iCasbYAzkyy/Uvqgb/p3li9DMcoRgj6YjKiqQljXoiKMEhLZJn
         wvvzo2QTxALK7nondLXssgW4EbO40eVmbisDpygZjobqxyqdrESCO6Upf7bKEBqX3BWx
         KI5fl5SQlurrvr2jKgJab/WqJKduK1G4ntoTtwBTAPj3Lb6ifWBJBDy78WC1vJkiDTTS
         dHsg==
X-Gm-Message-State: APuU4Z91mfR2U791wqmlW8/tsPOpJs2Qws9FOQMHSPYKuOh13I3LBGPM
	c6loqy87TisP5uONyVWlqfYtaSmO2+N6UiRC2gYjD0xxVTaoOvrT2BQqYeeiLKuNvBBNCGT+N6G
	Fb4mJmUfByc81HEEF43PtT4Zoki1tTc+vGnd3JsME6ZCs8zrEcecRtdlYh0HvMbjrdBzW2d51BT
	oS68VS5jbUMdBeBC9b3AqqMqn1HgpNBGWtlq+4IL8Socp1Aisn8ac0Rrz5JEj57h9Z1zgjKAME6
	cIl/xkMib3rxFuB
X-Gm-Gg: AYBFou0Rgrq8of1lz9zB6oSoPVaHvIQkcHICi3OubOOYMQ901nt0bAdXJhSaFbNR1Ka
	jNP0hZ33u/uJnb3ogYwzvJwFbx60U3CITGJvp4Ny+Lr8ejeqtZJFxKYAhos21sVGnRjI5jFx8+y
	iXffsMEr0ASpgTnvlSfVFIfZoZvi7TazCves/bXvzvEqvI6uzTVcNlEunrDrYOIwdVAzwd/8FvH
	eYXqqJaQBDlk4mNUj1u4v2k7Tj5GfhMVTsSjDj0ZsJl69J7xvDEyPfnMLIJX5beQ4XrRQ8qyqxE
	51Gqfsa/GVynJ3BpCBENZ7zZDm0H9I1dojf9H/kjLDmgnC88s/w2nZNbD2zRpfmgbpUCI/yxWsg
	jldJUOHBZn8vwAEO6E2YaE4kWMlLnR9Puo2gnGSQJyxkq9o1Yb6xDVeW/ZnpvPy/fVZmkZ4KyRr
	tb4OQ60nVs0srSi7biJ4uy33sj/PljbmYvNAXlE620
X-Received: by 2002:a05:620a:199e:b0:946:e1:7d0a with SMTP id af79cd13be357-9479f2faed9mr238865885a.22.1794282629641;
        Mon, 09 Nov 2026 19:50:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9479ef8a7f1sm16994185a.7.2026.11.09.19.50.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:50:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-535252004e9so27338541cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794282628; x=1794887428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
        b=QnY6vrr8xIC7YnMzLbzIz8YJwqojtSAp7FLa84QosP6Pq1lXZBJHFwq0Xq1madPGIg
         DEvj+3iuOGRAP622iG/j0Csu+pSF77zs6zU9ZZy4bvLYqdlyXH9e8wV4F0wBl3CIO9AO
         SQ0h5o/4DX1FBrBZEYUIRjPf4haAp1a2pMjXs=
X-Received: by 2002:a05:622a:34b:b0:536:33bf:7bf5 with SMTP id d75a77b69052e-5552791b822mr25725781cf.29.1794282627739;
        Mon, 09 Nov 2026 19:50:27 -0800 (PST)
X-Received: by 2002:a05:622a:34b:b0:536:33bf:7bf5 with SMTP id d75a77b69052e-5552791b822mr25725501cf.29.1794282627206;
        Mon, 09 Nov 2026 19:50:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm13740951cf.8.2026.11.09.19.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:50:26 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 1/8] net: dsa: b53: initialize the jumbo frame size register offset
Date: Mon,  9 Nov 2026 19:50:11 -0800
Message-ID: <20261110035018.2169370-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
References: <20261110035018.2169370-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The chip data specifies both the jumbo port mask and frame size register
offsets, but b53_switch_init() only copies the former into the device.
Since the device is zero-initialized, b53_set_jumbo() writes the frame
size to offset zero instead of the chip-specific size register at 0x05
or 0x08.

Copy jumbo_size_reg from the chip data along with jumbo_pm_reg so frame
size updates reach the intended register.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a2a5754c413c..ca2ba8c157b7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -3172,6 +3172,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->vta_regs[1] = chip->vta_regs[1];
 			dev->vta_regs[2] = chip->vta_regs[2];
 			dev->jumbo_pm_reg = chip->jumbo_pm_reg;
+			dev->jumbo_size_reg = chip->jumbo_size_reg;
 			dev->imp_port = chip->imp_port;
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
-- 
2.53.0

