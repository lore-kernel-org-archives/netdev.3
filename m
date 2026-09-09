Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8103AAF53
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980762; cv=none; b=r7fqLdFbucBAF5IAcOz4THBf81ml07yP7K3FtMnJ4lktjQRxGwSWh0WyiyDvqvdvESARISxMSFQAVrH6DCdRMTP4Xwg08iw/T+rBXPY3lpmd17OZeyBCSsQqJ9yA+FPTa/rhu1f8godtjVdWBvW1d53iQGKBNpkpi8gQKNnNQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980762; c=relaxed/simple;
	bh=csUnlEbhOeXy/9jTUSoOBwNu4P86P77sQ0DCQP3q2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWnlQzb9k9X966Cmz5dXq7xsLdOYJni5yBNgmVwKnU0O9v3v/0qg10eMwiOxApBaiQzdSRp6TkgMwDFgZNN5VB2YAiYrP2rbZHr+tMsOA62qfkdZevue9UmoQzzZFxkR5zMBjX/ctsWieSg+nGxtRpM8E0yD05ew8X06oMPO+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9Qrbn53; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9Qrbn53"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d91ff7d9acso54540965ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980760; x=1789585560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zv3r8Pr/gPLGPaKoMMMXq0qLzS1CADwZNQKVCLAM70c=;
        b=N9Qrbn53V45zV1pFOyY4MTEjWsvzW27NbMKAt4B9520tFgu8astcXKaeXYXIRv/Q1m
         e5L19M26r30pIpvXgNAy0bQHwa1eTMkZN4KDRfI+c8V6koYE6KCNzUOq9eg/PmAe2FbN
         iHifLmHedPNJl5BkT5A9V8XBhPWZZZrF/wr5M40upKLd8JZvwLcUJrxdcjPhizAa4uGk
         zvEvrgekDXMvQeLIumyb2/dvu9lBnqTG3vg/gmu55M9RrKFwQ18jZA4GszErT14sombf
         6uhZ4C5ekooUby9YNcFq8NhMXzpLpZCtF5KuxStDVMdZSpiC95YNMDoFTR1G14r7rFVl
         hvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980760; x=1789585560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zv3r8Pr/gPLGPaKoMMMXq0qLzS1CADwZNQKVCLAM70c=;
        b=p1PjmasN3RQawoq/EJH3LE3FvX+2hCZLN+I8VgqeA2QmYLGw2UCv2zx/y/XU8yy9vS
         bMH0qqTN2bNGqVc6LRcvrmqh764+fnjcZ7oiC6V3PFJAxusGlclGgiDsLG2gIq3ra0Rt
         ZHDPFLI36OaNIQ0UVWAbTCJ6EbBZI/SgMqvZzZHr6iAIY/ea0zQtPNohhfAkGqHopkiM
         dGAIKC3XWSt7YPofvRkO+RCdTedUtwczys9I2P1Wv1SYvTxF83AG46S47ScefLyc03Xq
         vZ7XZ+stARgz8wMhiVuhwKMVXjsJ9SQlHGekqIg0DCAimXWRNnjEPPRD4o9dRLg23cGy
         t11Q==
X-Gm-Message-State: AFuF++kf74SWFzBf8PZQYPBNE/gI07pnta2KF3Yg/6t8TmGx8GxDD60m
	F0i353HYI63PvJo4A/gj9DJxKDYNkpqlSFWrz/JearHnx3RJXjN/ot4TobqSaLLMNY4=
X-Gm-Gg: AYBFou0RH7PSTGuB/HF2eSCLTHd2AqIDBNPlXNzO7rRu9HBkxwvY+GgwEy+qEWv6hMW
	jcyAiA6puA7Ga4VRqrXunO1kvzuyqEvTAXzBk/w67R+43KGTZmr+46Ael+P2SUsDHv0oaCl1e3+
	ahZmi0b76PlvnMthLreY4yF30511/L/OThpOjGeZB+GMNLXrPceKjcSCNpjzndB+kgD3lYvQeDW
	CSasc4YH8tYAEIuAoDzqZZpMelTUpiXDNug8eHskf79Bh/V8r7AOk4ARfU9WGm8VutxWDE5QizD
	Py2u3LQYH/N/CVt9I4qyBS9dpqjj4vpjG251VbveDOSAGFkAL+V0QfVQI+zUlFgmnwxov8IxoEG
	5N5P3AJdTryNXFaxjM5DoNVV3A8L8fshgb8nMR+Lon+UAWASQMCGVcppKDB6N207umralMBqtlK
	072eZJiPdgiQBs9SdZdSLrD/RGl3lb7JWYnQTn+xQBMKY1t8P3jjuSo8UNb0trxv4Si0+MSQKR2
	EkAX3hnESMsdN8zlCLetnPM
X-Received: by 2002:a17:903:1a70:b0:2dc:feee:3963 with SMTP id d9443c01a7336-2dcfeee4413mr68077395ad.9.1788980760004;
        Wed, 09 Sep 2026 12:06:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dcffa9827dsm13988515ad.66.2026.09.09.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:05:59 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: dsa: motorcomm: Add SerDes PCS
Date: Thu, 10 Sep 2026 03:05:28 +0800
Message-ID: <20260909190541.466476-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support in-band negotiation of the SerDes ports.

David Yang (7):
  net: dsa: motorcomm: Split xMII and SERDES port masks
  net: dsa: motorcomm: Check port type with runtime info
  net: dsa: motorcomm: Fix port control/status register bit field names
  net: dsa: motorcomm: Introduce yt921x_speed
  net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
  net: dsa: motorcomm: Split MDIO bus module
  net: dsa: motorcomm: Add SerDes PCS

 drivers/net/dsa/motorcomm/Makefile   |   2 +
 drivers/net/dsa/motorcomm/chip.c     | 490 ++++++---------------------
 drivers/net/dsa/motorcomm/chip.h     | 129 ++++---
 drivers/net/dsa/motorcomm/leds.c     |  14 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 302 +++++++++++++++++
 drivers/net/dsa/motorcomm/mdio_bus.h |  51 +++
 drivers/net/dsa/motorcomm/pcs-921x.c | 209 ++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |  13 +
 8 files changed, 769 insertions(+), 441 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h

-- 
2.53.0

