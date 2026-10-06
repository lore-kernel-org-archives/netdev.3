Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F913EC83E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318244; cv=none; b=eHYw8y+yh3l7U3q1XxsSmayOZGcMmxkXxTK3yAnKGOml/vtVOos4tJiOTH9cpVc2ryLJtiUhVC8smRpd2gLHRcEVrSzMad92pBjKTVnnYtWEZ8g+0x9kHmF93DUpHPlF1BtLigcTiNvl5I6hO/32s1W9d5xmiDjMeJ/oPn0oeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318244; c=relaxed/simple;
	bh=+URRdGUal9XFQLtRU/xlYp4tgr/16QtNmNlu7sM/K8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oATg7QcydKbePBV3ScvOaBkd3+70yQnPrlBHi3dzOV5VGG7JYuxxPvkyfwh340jwEvEXZbgR9MVedELmryv3oTdexNi6JHfgKE8YTh/bc7Mp4ck3eMxTLuZNcPi0m8MwrZ5DYowSsvp+2UcRb2Z1eheOj6CQep7mMwbGGhV/tiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKXIEpOM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKXIEpOM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88a627ce016so634297b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791318241; x=1791923041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wA3wGwq193kNMSvPv/kcsZwk+hDicBszW8/PKsxbSpc=;
        b=sKXIEpOM32dHHBnWFueKBaF8VczfDTCDTGoJehyKkTrmWaN9vXtB6BTdITTS6Hj4dw
         hjikHayK6BN2GsLZbDTYPv5QLuxrYtQLNxuHxJ8CRhFz2dqvfYwg9A11jKdtnOUbge+T
         izapVKJRAGGKXdf8yucnRo4E2s4ggerRwQEloSCVals0HbWQNrOJE1ZJ+mSdSV240bw0
         ZW8otmPfwdhhtokInUeToDOZGXGyhus2P2Ysfz8vNekH4lAZ0hUMegvSggDoQ5h+s9KP
         2JvTdw/APazgPf4Bw5Eag0iaaclsbSu/9FI3xZ6itPy15ayM+VTm541PX4P+0bOsdlRL
         pfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318241; x=1791923041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wA3wGwq193kNMSvPv/kcsZwk+hDicBszW8/PKsxbSpc=;
        b=oXgs+tHP+FfEnjTkiho3tdWfQNaSDjq6WgCdXNa63NL50CcAiIqWb+QwbyeNyjhhFZ
         /RL78ITE8dd7yVJxJsGdKg4/QmxZ19/HvLgA12mAr3+fFZg7yL+KNjTx4MtcH7T8ID3X
         0H4BFdrg0S9Qp2IDjSbAaIAvF1XFj329TZuwKMgCGZ5TQPfOyNk0LOccpaZck1TFq9Xe
         cAXOTbIAsnCdY5XsOXffmGg9mzKdmu3+vzwddZahnJb95SXK+sE5hk7smpXVUXqRg+al
         8TrOEwyAQBcBSFoKsezMJRipYtpr2HCvAJL4Pcp+wIQZovgjK9Sk7yWlz/oGYChQw6qh
         D1yw==
X-Gm-Message-State: AFuF++lA14+z5ZQBqmeMSZX+2zxNGRjjK1a8O5J8yUZxq1uip3Rbv8ly
	r17vvw/DB1v+u2D9HvwyO0zLKQH20RwKZg4JRJItOasmzH8+SNjoL/slTDZlQGNj/pQ=
X-Gm-Gg: AYBFou0+nlYLxfEQygOlRTEoKtWsKKcWFQV6o+YxPu2XWoIqLcXWF4Yle3o5SBIfTaM
	f88EUfwyTjm6tDNsYR9po2QBRFERZhDG0QyYS8BDQp3c1S1+MGSDq4XHxGhn8MrzwUhK9p2MRt4
	9ip/+5Fn0HiT2It/kq7XSZcHmPT+X3Y2YqcL2WEp8odBR0DwQwhHX71UYi5KIVclgxJLRC8MCSw
	n5rzAl3Ls2BAYTCvJQJByacI+nLQEohVfHg67SBeSIXbRbQaozs9v9+iyaXL/4jN+bOmsHJNAnI
	OQBASR4iQoIr8Z7C03nkHxm2Poa7d8W75Pm93S2HyVGMvEWMMAFJ2RF9COneooJC1o4ByhADMfj
	GayH95JGcQ1fboqZ8U+eLvJnk0GfiRK1GHH5HVxMlZfbSwAlXZPjhyzl0JyfF4o2xJdbzNc5P14
	DOwZfL13WHVpeHye3JKIFZF8/ck1YosLtb1F9CRQZScpUTJe6H5hrh8vOKi+eEfSzmlOt5OTsMN
	CkiS5KHkQ9bHvVrehMR94SlYtq2mntwmgrn
X-Received: by 2002:a05:6a21:2982:b0:3dd:ff93:a87 with SMTP id adf61e73a8af0-3e1340e0bd3mr138927637.50.1791318241162;
        Tue, 06 Oct 2026 13:24:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92da735sm383218a12.17.2026.10.06.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:24:00 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: phy: motorcomm: Add cable test support for internal YT861x PHYs
Date: Wed,  7 Oct 2026 04:23:46 +0800
Message-ID: <20261006202352.1616626-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
driver. Add a driver entry and TDR cable test support.

v1: https://lore.kernel.org/r/20261004184246.1260426-1-mmyangfl@gmail.com
 - split into a driver entry patch and a cable test patch
 - update comments and kconfig
 - add yt861x_config_init() and apply the auto sleep setting, restore auto
   sleep when starting the TDR test fails
 - use separate variables for the TDR status

David Yang (2):
  net: phy: motorcomm: Add driver entry for internal YT861x PHYs
  net: phy: motorcomm: Add cable test support for internal YT861x PHYs

 drivers/net/phy/Kconfig     |   3 +-
 drivers/net/phy/motorcomm.c | 151 +++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 3 deletions(-)

-- 
2.53.0

