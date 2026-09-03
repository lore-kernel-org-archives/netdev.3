Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475F33DEFD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446278; cv=none; b=ZhJ8/0WgpcrTZUD0x8fmjYONmzcKOijHLpFnTJAj65vHCLebq+fgvKz6AebZMSdvtf+5fKaMB6uVEUlXDla6b0uQw6Ei4w9minqH/mXM0UQo00d2ujEQe6FNw++N550c2zyunApsAxkBLDPWtWr4H4pnXLczqOqnjCw/q0cU6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446278; c=relaxed/simple;
	bh=vw9DD1Vx2E4GZHJgiuMPecbdPEKHD4tuL8+JVNkQCos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDPYU2fxFGRPhIgSMeeUyMsp7NM5gifQzEWUgFC+y6ebhy8BBFEhthoRmkamnyTJL+YaQmoKWV5MiA8m/JJy3iB8hOG2/ZgRKfOsvJQtzP0OyIIhBAH66+P0w+NG5Y/fwhjmJrd2ifGP9D4cjF0HyehaT8aje37AIoBd1eNjelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWTRD5ai; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWTRD5ai"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso3290048a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446271; x=1789051071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUojcmzIkQc1EwQLVUybWEhXvEmtes5ZG7e6dFMsKjI=;
        b=IWTRD5aidknznqkiF+7EDYmth1lMwxtqTFKdbUUXCxfskGB8Yq5a/MP5ZFT5SdsnO+
         aoWmI3XOALl1iMG6OOnMZnpSaRxQC0Sv4guaKW6nyHMBxMJAiNtYwsv9NhM1khXy9PZo
         4JK6Rdv8iMMT0vNRimO/Bjs5fFMPT7vWRKHlvUKvtqI57M8sVf1/IF6WdRxZuAQqUl8g
         o/ohWUvhDSj9KHX5unwKOSaPWSlwCcuGEEwIp+AWgzfnZEk5r49TEOjn6WCPcEby9XXa
         O1GpvVZgthct4u2lnAF7lBT809lJhmbfeLFJw1Nc0EJLOsZkxN7ps4irjVu7etwmA55F
         mjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446271; x=1789051071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUojcmzIkQc1EwQLVUybWEhXvEmtes5ZG7e6dFMsKjI=;
        b=Zr2vqran/Xr+B6UI+emU5l9iSy8YDZifvzpfi0ze8KN/rDIIBm7A0TeGoF1cJ9sukn
         2Sls4vCvbeLjEm9if0o+59GSN3YRDFKd4d7roKk/3piRqn0BBYMNnoMmigEGhGsyafsF
         5Al0RaB1AWy2GN4nTKWrRvZ3pkz2yW4QWYN/i1tYuZm0XulBBQa0wx0pRg2DY5l4FV2t
         STWfYSDBfyvFD/rbtJQu+EERPocJVsZ4r3xRw7FHJ5mV0XoUP4uN0CM/TqxWtsTWvRvk
         K9VkJG1LyTwZV6sWj0WVSDxiqaUr1Fpt8u4qfw5RttVNKr52bqrodI8cW5WvQEpK2Hzl
         MtYw==
X-Gm-Message-State: AFuF++n+T221sfq/juIbnDf/LHw26eWPVRmxnCG4u5d10hK19Bop+7ut
	Sqg5KU+qhR4ocHozkVS+v7y25WBrX8lq0rIUxwC7d6CV3MG2MLf+yF++zkOpEQ==
X-Gm-Gg: AYBFou1hWbWbc1a4xqFmbCS0WFzPz+c5Xvf+QZxhGcy8HPs8NNv8x+VCGJHAAX3G9Gn
	RrwQ3aDPvj+GuK7mUHP0n2P0OktZP0o6Ym2Cv4HzQqjv/dleiJLqPBmBLLNS7YxWc09Cbk+tHIs
	NOrm4pYdhysBqwcR90MIyqIAsYXNZu5H2wQaTzuDct7O1/SWtz5uRgS89BakAhQYtaoxWMPQ9c4
	oEvHANQymi/BaKTg/CMIGuGCWu4rJ/OnoVNcgIGRlK27pUB8s5q+skRxuMETHuiQf04NA2vodoU
	HliGEk0J/Ho7Iw2R0kXwg3AQEWOWsksukR9yICoFLSVPDLleQmITphyVDDCkkAJtsZs6CaFdthd
	JKsRxKnJuSWHrFYiN2zJtVZlHIf7PFU0gJk4P1WBM5BN6exhCf1jVegyyd33QvkYURKdwNSTtF+
	f1wzCugBBGuoWQlVCneOzFOvXMQTijgZ2l4h24yrhAho/ekkxGmIDZHeT5P+J9mZ1tDAN7nUhuF
	evQvzvIJZKW0SI=
X-Received: by 2002:a17:90b:2604:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39aee1f5fb7mr19772691a91.20.1788446271251;
        Thu, 03 Sep 2026 07:37:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3050::4d0:16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae9087d3dsm2741889a91.3.2026.09.03.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:37:50 -0700 (PDT)
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
Subject: [PATCH net-next 0/4] net: dsa: motorcomm: MIB fixup
Date: Thu,  3 Sep 2026 22:35:05 +0800
Message-ID: <20260903143514.532023-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix (theoretical) MIB inconsistency. No new features are introduced.

David Yang (4):
  net: dsa: motorcomm: Split MIB module
  net: dsa: motorcomm: Split MIB buffers
  net: dsa: motorcomm: Use u64_stats_t for MIB stats
  net: dsa: motorcomm: Use safe 64-bit counter reader

 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 408 +++------------------------
 drivers/net/dsa/motorcomm/chip.h   | 126 +--------
 drivers/net/dsa/motorcomm/mib.c    | 430 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mib.h    | 167 +++++++++++
 drivers/net/dsa/motorcomm/smi.c    |  30 ++
 drivers/net/dsa/motorcomm/smi.h    |   2 +
 7 files changed, 670 insertions(+), 494 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h

-- 
2.53.0

