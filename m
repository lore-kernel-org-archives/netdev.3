Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB183B6347
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200820; cv=none; b=ax10OBwQTcaJ1gi3UDI6a2jT6Vw5xWLoSxJ3ONdaJqHLPMASpS+a8uH84VOR6jGPsQM/uJ4W8kKlbywn4RXwZ6NernTgO4fspNO6hLoWY2NTN7UCzVW5MmIaiUF80EkHc8H3CfmI/RvXIqQn6rRauL+I7WFTpbOTuuqsBvWfs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200820; c=relaxed/simple;
	bh=6n7H95oCjC1hgvkIqkVmsZD5RKSMNQ+H/5eZ6bZxyIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZIgiJNd1FXwBJ3SNjNlFMcuMQaPCpWFBE1Bu8/zDBwogEYymXVlEELgwUvMc1DBQqyhP4b6vU+fL7wQG4oHchjYWE7QuKHM4fDZthLaRFJP1hyFHCqwkVdR5D4+U7cKSw84NL8w6w7doLSg/758pY8OS3h6iNPS/SrzyK9btL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNTV+qo9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNTV+qo9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845397d1221so2940353b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200819; x=1782805619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiYA62dHorpFymdfXssg5HAuL1K3q/QdPM1UUVatA4k=;
        b=VNTV+qo9RPAHTudKvNZmB8Lgv8h86zoC+/5Z8YxigYmGGLHYHwUCgOfVd89E2OqS8s
         IkTZf5stOQslfBzYR2eNkrtfchtCpx3c9qil9WT6oohIYdt8ISxn4hU4AXiOiJ8lUrgo
         Exc3yGOvaf2rerFY2HcTzVd1/xl7t3rV0TNk297TX4Ne/HQBLZo+uLQSOluMBpqTVrSZ
         X6TspDnOK4ULEru+Qqzdt2eb94mxeWNih7xj+Ym+QrKX56WzvwiQMHxB9H1975169LSi
         2Xf4IrdtAN5TLiIFb6E6+uB2h2WC4lGgsFQD6Sc4yizjpzVXZt3uhBGN5RfRoHOKuhk4
         8EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200819; x=1782805619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiYA62dHorpFymdfXssg5HAuL1K3q/QdPM1UUVatA4k=;
        b=A5GgMCsTdjRxT5XgkYVSXxTr2UiG7e23GRcFagJcNkkJ0dgL07MzMUc5QN7DdDRC5G
         VWrdavEraMFaXoyYtItUzrkcvFt7YrC2l+dztHyVjrd61b9EiGCexrXoVRRB8VqtCHz8
         dm2k0AKPrAdXPvZX5Fkw1+JskFJtlidwK0go4WFvHzqi7yCmDrmNlAXXElW81CUosQMj
         ny2TWck8QTipzftJ/IKy5Q+ARy720QDJ5i95WNOQu9e/PXJ8mxLElkFrlcec+hNCsiYz
         jD3JfAnaLi8Lj2YZhwCsFJ0NupNP8xCru0tGqrGk4p/CXi/k3UJKhlgATPHGT4HH5Rot
         Hygg==
X-Gm-Message-State: AOJu0YyCxkaoWtN5zzc/U07dORFXT3d6azehKDp04dY9P7Fq8Jinr5KT
	IiE3QnHfgXVOL3wszQIx9KDMhwd7wuAv03koo0coDlJ9JsC4gHNJTntO
X-Gm-Gg: AfdE7cmLZ+4Osk+TpBJ1oya51Zj491uYxBenj+AEij2TJgUbSHSoefBe+S4HmNwTsBR
	+TJQP7sxDu3GNaI/NIdNc/olPtSAVR1MyJC/7GRq019raFtX7J88K5i4dWf+b8i5gfnAhULy8wa
	Ci02YnDA7Zx17m/rpfgFh3sSpKm+H1awz63TnxEX6+Dk9ou8kJTu4rCmJQ3TwGL/qtNRIN8kq8N
	jgRISWyhhbe8WxDL8jdTRiXQtR+xvuCRfrGrtqi54mfjh6Jos38hUBpq6TQ2wr5EGxKFe+UAaVg
	opAJfZF+0quWhOAD5PYnwjyS9/UPCQWjqncc5NesHxJGafHBxz7bn2TlqhBxupIBXIi7m0bByu4
	uqnc2/9uBC2h0IPWtTwBOMc9H+uGG3TsL0urwB46GwCUm4chhH8hkanKEl8YqLV45yDkQO/CAVd
	UjEosmaPqbLzZ6RdDfZ+MuDg==
X-Received: by 2002:a05:6a00:3d09:b0:842:5711:9a2f with SMTP id d2e1a72fcca58-845508a0edamr18772015b3a.36.1782200818608;
        Tue, 23 Jun 2026 00:46:58 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed9516sm9765519b3a.57.2026.06.23.00.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:46:58 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yixun Lan <dlan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net v2 0/2] net: stmmac: dwmac-spacemit: Fix wrong macro definition
Date: Tue, 23 Jun 2026 15:46:33 +0800
Message-ID: <20260623074637.503864-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Wrong macro definition of the Spacemit K3.

Changed from v1:
- https://lore.kernel.org/netdev/20260618064143.1102179-1-inochiama@gmail.com
1. Separate the patch into two patches
2. Use the right macro name for the LPI interrupt.

Inochi Amaoto (2):
  net: stmmac: dwmac-spacemit: Fix wrong phy interface definition
  net: stmmac: dwmac-spacemit: Fix wrong irq definition

 .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c    | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--
2.54.0

