Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F33CCFDE
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290514; cv=none; b=Tex93kUn9YC03fEWAvabSpNk8HE809x7NsdQxorInoPcVp20oMmupHL51rZZqOqLcKDr/lk06Ra6N7p/m/mneatUXdY3RYT9RDrDIBEV5QQaYuXLJwJPi6NMcMrY0RhjiNblgwIgnVoyUPlVjU10rIsK6bTeQqcZE5gTK4Cfm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290514; c=relaxed/simple;
	bh=SOKRwxDlDZlKiYi/jrSARj0ARB0EEcDrmHsL0id3dGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RITJGN1nntvgnwJFTDMHFc2oBIjw6bqJnj8btl/mlBe9KBU9XtEIUsDdX58mFWdFT9b5I66cndkpri3UGGmJ9r1gS0jjMutXVevaWb3FxfG15l780KNYV30lYkF6s5JcC+Osct75ME1MeFdRb1ON59Ge1/msBvxRM2JnhTbUBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvnVh5E6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvnVh5E6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so27332855e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290507; x=1774895307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
        b=FvnVh5E6wh+gHStwCqmHLOixYxNEoQJEakNdZrwpmQ0hyAvANmWh4eDzunNcGllo0W
         +v7dvr78OyEBlnkT/daYwE6Yq3RyD0+5DOnFJEpAEVX7JpxrHON2Wz+3be4Ll7TFeAXh
         IEj+w26oa2vnT3cexsNCS1NY1x3xlV0Naybz7opaJ6yyYnR3BG6Xt89VePK8wy6PXLwc
         LXT4szYihM9stDjzpZAkcYVR0/SAWHo7Q7xWAySF6kuq+QCIubs7beW9GulR9y01ZhwX
         9NuP/yE923/JOcn+qV5K/wBtL31ekUono1H+zpGqj9pgxiTfDRStULG8Wk0qBgAxSykx
         Qj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290507; x=1774895307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
        b=LBkZflB7Jv50tws3v+LGAY22iiF3LataFOYqyeKYzeL3XdsqmLdbdnJQbnXT7aCDfQ
         6h/yXphJ1HvOC9nlbPdGmuK9AxHPdijYRUogyCaovn+5BKbgiZuI3JgAdOTHKqPlHSDb
         MeMKmBaqzsJiB7EQXfmIkoPh0luoCvQ1SBOcc7zGyQ1jp0zuI8xYyV3Rj0AoKSvnHTo7
         hZg440L3uLAgu/wdtwyp3J1CZNFuCbAtqiyqJ17genSvMzV7gmKT8sEQ0ggRWxuh4Ne1
         BXhQAmx5mNDjAvchQfq3guhu7+m7TPtVyTSkuV434v6Z9abQFpCC/2OBYFbvV1rrHUD/
         LrrA==
X-Gm-Message-State: AOJu0YywkY//APUPnjwNdkQcYM5L5oTKpMtk966Ou6BTHwThToGkre6B
	a5LC7wKQt6YFmnmr58lOybMOv3nsCbfeUGE5pz+uM+qX5eRKcgeE0Qr5
X-Gm-Gg: ATEYQzxCtP0cyNbrYeYm+0VfszR+qC1ZCvmbiWjIOgxtVjTU1fcg44SYc3HAHlA03k2
	Lp8e6R0w5UORu+VkweSBsbQF+S2wkFo+eIwt55KyR2iVgEvER5ttrfRa4y5026ylRerNvLnh/nN
	t+Sa7cSnTIINS1qVlGjgm9htudm6YoO7JROd4ScbIcH+igzD/E2MJsG8iUbQZKLO8Zq6rRNlbMy
	x+zPGSPN8skZ7Y2ViAmv/jArd7cc4EDN72z/wdCbCgZLAW0EkmGZagIUjZVXDHRMIvzlPugrxIe
	ytWPOk7WH0fbAnZBk1ZrW5iXjhEe8oqxqtAl/oR/v9wNit48arM83oehJdXOmVphZclgxlptd3z
	WOnL7iXKNFhYCb65Gsxt3BhO8nrIDrKLAsnbRBISJgzRm75HB0pmbzXDwvgmkEcSVHgsyWsIYLZ
	xxgglOLib/0d2GoOfRFOgRBjjyHOOCf6CTtdPrKJ/1hqfPQ4rQUWmYTSsCY/E5YxL9IHLoiQ56k
	l4=
X-Received: by 2002:a05:600c:3b07:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-486fedab424mr187730755e9.4.1774290506520;
        Mon, 23 Mar 2026 11:28:26 -0700 (PDT)
Received: from turbo.teknoraver.net (net-37-119-137-97.cust.vodafonedsl.it. [37.119.137.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm28448751f8f.31.2026.03.23.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:25 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] e1000e: add XDP support
Date: Mon, 23 Mar 2026 19:28:21 +0100
Message-ID: <20260323182823.5813-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XDP support to e1000e driver. First patch adds basic XDP support,
while the second one adds support for AF_XDP.
Tested on an Intel 82574L Gigabit card with xdp-bench and xdp-trafficgen

v2: added a missing 'select PAGE_POOL' which triggered a build failure
with some configurations.
v3: removed a leftover file.
v4: bugfixes

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig         |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 610 ++++++++++++++++++++-
 3 files changed, 617 insertions(+), 12 deletions(-)

-- 
2.53.0

