Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61115375F82
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075134; cv=none; b=BmllWYFPbbXysBXUeYdlxB1G8tC+CPREVVNvkxjCoHvq+/imDpy9ueIscgy2UYQgnQ54nOTo0xo6MBxzTjdhx3/WlqOBKiB7MdAqYWAMMQ/N7Cv2dTZnxrB/wRnyNLxjpl7FaltPKPEPrlwPEwAeKkGXUspdP1dILtAo9G5Cy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075134; c=relaxed/simple;
	bh=JMGu2iM1quSp3Cy+yK9EW1dG4GajR3ZNEWEAaIoU1f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRsOJVa+deVZNqUtEWwM3sLKCSCTOgo+OdY+hR81nZ1RMw1LO5/unRTGywdu2ewPHE/LSkYDOpQVyLd1vdAVdKj0LILskdxFKx0pMsk7nilNzjsiWEeElzuMxdsneK6Wf9IqgEhpYeYafhvrJucG++e9VrWUS5QvRRmJvgYADfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=AoDwUjKF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="AoDwUjKF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9178510f3bdso68712706d6.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792075132; x=1792679932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=87ArKhOz4mXpsOQz0dSA1S5HtkiIocsYKLa7zjBJOG0=;
        b=AoDwUjKFNDMIuLAQpcS31VBM16iaveOUugmbll1thuhLqmTUcZBf2k0csqXga0+k2V
         y77VmHzT57KEJwzkDZC9ezq2aEkpn8cCsCo5vzMbaeFz7RgNxMpLD50irKxpjfdxRIiJ
         pAerW6P1W7PvMLaN7EcUfGmfmN1pcyH8hdKkCpjpfmhNBExaterzBUit5igk+GAWNKS8
         7wZOplvmRG1VipSLmbmQAhzCbWxoRUHKuuDVkQw6/jompkKefOFXM5s5UGgjGgiYDfYQ
         HxqaMyi0/7Xcvhv/Wv4zs8c6kHUkPuLKBNNnCwV1u4aKwxas7MKB57JvvLzvEke9HaLn
         BamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075132; x=1792679932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87ArKhOz4mXpsOQz0dSA1S5HtkiIocsYKLa7zjBJOG0=;
        b=vBaaz03RqGGvxSfgiQytvUAR14hOxdDZJhj1A/PvE4xOaAs8A5zRNjOleuEGadejBY
         DtgpMgJi/z614W+bqGjo0YY7rx129/C7TgGbui4vamgFQfPI/uGBIPdoI76PJ3opgJXm
         meeVxqnmdCqA26lhh4PgEPYCzb/EqfMzdVdgI1WDTP7Y2KCFupwd8Na6401t/H5T1qZw
         fcQGUritT0k4kgeH9tjYL6hFVgvlDL7/m04ebkxMRUw5eOg1JrulqqLspjr8OYzB+k9N
         v1LfwRG9rqDsEDDdyhhX15slPLxUSm4UkJfOtymNAIg2feOB6Ob17vgKGDp04l4CLTy/
         CiqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpWbl+sAxpGuUchgJ9f2LL0Y0HbF4FKp8qztHAYfLtmkK8L66QJKLAlqIMqu8GZfS/PZ/VJL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxmkYE0vAgFgnAEPI9td3xq/wcaUREdmVa9f9eiQoISVLBwWux
	VuM74digHO50i38s3W5J/4i7BnCAzGO8rjx1MBIlpoPXeSOGugXII94R/m9B9Xq4VYQ=
X-Gm-Gg: AYBFou2kr8lJCNDEZ2H4G5JyJNhwmaTbUcQ6IZDlv4UjXzi4nclLlS86+qSaYrPxnV/
	L1YjDoVbP7YALnig288Ufv7vq475at97BtnQDA2s2I6ol48pzktUvFkMvuBPm7bBBWfotg/LeJT
	Uo1jqBKUaPjoQxDjz19qy/YOR08iYTzZLKUkmshF5lQbrbeXtGDPEVLEy0n0NZr82/DnE+OY+xt
	y2YbBHolIyC/ibLeQyLum1CQKVNbdBN+NOP57qnrElMmlC0ZdO2P6DDqKrHBPmvnFn0LNPOQq/T
	fMC9ko5z/4cNtUq/qCOmXqtvwky8jsv9umiL1QLieMGQiwW/cHtodl4azLsKqDMJ5nOWhYsHbh9
	Q/iJaLct+8aoTVjvIIKD+EdmaElTGcgGNN2y35vi4T67oz2Zpm5cq+vWT75lURxJ/RS3Den1GYi
	QFfbWUk4g26BsTHyxOu8YlK+lLimxRU2/5DkqsDOv3HwjrwpYnd0PaiSyCPpqXeR7zXOEhLa5f3
	l0=
X-Received: by 2002:a05:6214:590a:b0:91b:9061:b808 with SMTP id 6a1803df08f44-91b9061ba50mr181091236d6.21.1792075132399;
        Thu, 15 Oct 2026 07:38:52 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bc6d42sm82581486d6.34.2026.10.15.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:38:52 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: ansuelsmth@gmail.com,
	donggeunyoo.kernel@gmail.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	daniel@riscstar.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: phy: qcom: add qca808x support
Date: Thu, 15 Oct 2026 09:38:45 -0500
Message-ID: <20261015143849.483339-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm QCA8081 PHY (and compatible devices) has four power inputs
available.  Not all designs need to control them, and some might connect
multiple power inputs to the same rail.  This series makes it possible
to optionally specify these regulators.

Between version 1 and version 2:
- Add a devicetree binding update that was not provided in v1
- Remove #ifdef CONFIG_OF from the body of qca808x_power_on()

Version 1 is available here:
  https://lore.kernel.org/lkml/20261014172300.292324-1-elder@riscstar.com/

					-Alex

Daniel Thompson (2):
  dt-bindings: net: qca,qca808x: Add regulator properties
  net: phy: qcom: qca808x: Add regulator management

 .../devicetree/bindings/net/qca,qca808x.yaml  | 16 ++++++++++
 drivers/net/phy/qcom/qca808x.c                | 29 +++++++++++++++++++
 2 files changed, 45 insertions(+)


base-commit: 73022f605c447f31610b94ed4a983d2b4bf2c721
-- 
2.53.0

