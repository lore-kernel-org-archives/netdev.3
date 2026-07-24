Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3143CED9
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903430; cv=none; b=duBJXFCkykMqqa7ivIGoVB3TNTDfiu4MEysTmqVCyDYgPSjmVCmX75IMq0DWJvL/mDbniXypxCD3YzsKraYreOrLR/FiJK/HVlOoyDmCja2Tf7FLpPE82hiDqYYWkCs0MMCgPkFikZ/qE1F4MG+0L65Glc1cMrOWqUd1+r3NBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903430; c=relaxed/simple;
	bh=iVqPf0w3Wo/GIzsiYZ1a+oFBB6r06/tHVjziG0Lok+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYYRP58fHvNdiHfFnQ2vqbN7XZHxviLNBfKXjEPNjvMpY//pZAUsjmXuYYNbsaw8SS2BUJBFHHbTkEvWtphSYMifeEHkvRSOkpB0K6Y3CexdfMR3sP3W8KKP/ZInrlvYDmrXxCqZC8t6uRjuVLqSfdUZZOURklU8h3n6E8Ki0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GqJW66aU; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GqJW66aU"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2caea3f742bso6455525ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903428; x=1785508228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T8bGmNm/eBf/1fzH04SYPklDjDwdAItOToITsmx1Gdo=;
        b=GeTbyn9iu0X5yJQyTANzC6bKUIdijE0g0eSiosUFV7O+5fVniTPj2Ti2O6U/+lPMx6
         XPZf4+WFnC4HUJdjEOl6jS7/CwZHiNXqMy+/VsVZykRw7WVNcuh5QCIy2QbYhBus6HEv
         NkRUUGmCUS037mTLyydQznpdw0CUQLusxhkQpWK1SBhpoIGSuDl+rw+Xc00apmoz6yz4
         aBMtD+R9APF8OHgJPDzsGlmOfrSzmNvz+xxANFRMdgvSvirrStrJS8GQy31DjozSpuBP
         qDe+XiyfxpDxXs1DB3iPa+O0AxIznP7VU5fQwoMtI10n3d6Pn9+mvDo4exHBWykTDs8X
         3VuA==
X-Gm-Message-State: AOJu0YxbBYVjzgrxBP/DrGA9jxVOj0iBzlUxZUyu/h16EX7zGfDXG09U
	vGlJMepYzclhW3YvWE8jue4fLsLALBDsOBoJPEtPSkDGZ0lkw42/l/AomTjN58SxP2+OKn7zXkC
	FXySOk7j37aKa/CM8kaDjKvdTUsLbppm9+9yAkXbCH6wMywIdwP1zIJVJmitvlN2EcSj9nlo+RG
	9ytn1F0S+AbYsQe0yDJRUoga6BLvlxS42ndH+HWfzbxkJjj/AMUCioRK+epq3ToWPutHwPrHGzT
	GZEwWXetA==
X-Gm-Gg: AR+sD118LZRjVl7MIt9rtNhGBmtA8mBte1NUoyjABukZnIb4Z9jfbSGx6ZrWcHItcoa
	zJz9SLRgAEk11IZ+ACfX5Lhb7EGWZqnN0whAJd7PRE4RWGfOdWMoo5fm1YOJFEZJWgKWaoGRf3f
	Ub67plP/FfMsE1LYO+O8EVal4kEFCjJRL93qHjRKBEnk5JZlS/JSR9Zor0cDN1gc+bR0LHuw6uU
	HF/XSBblWqjtZ8KGn9rOVm+lgUq1vj4yvGiCRH6etVN7BjAGUg94AFTQ6mQEGwDUUatMfxWnw4n
	zYat5QXSSrhqFg5EubMn3aY12mW5JrEWu0fJ9R8yHhvcA34tMaohYf3QcoOJX4K+LfUidT/2yGl
	m4zRm9u0OozX1JzvT2bCseuPQhJLaQ2oBL7zzjfuT77spj43MYY/ldYzpBTq/eFNMehNFF7/6Nu
	fAZ/vv5DNkvsErVBTcLLK6P9nQf+ii/dMh8Q==
X-Received: by 2002:a17:902:f549:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2cfba10084fmr51111505ad.4.1784903428198;
        Fri, 24 Jul 2026 07:30:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf8efdc752sm7677725ad.14.2026.07.24.07.30.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:30:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab041eced3so708923a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784903426; x=1785508226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8bGmNm/eBf/1fzH04SYPklDjDwdAItOToITsmx1Gdo=;
        b=GqJW66aUB3TGawsYE45gG+tZr22hm2rlBGsfPa4aQnryup0AG0caIkInpMzNzkPQC1
         Hr7cUoTXCrPfMLMVrt1EkUe3feWoU2mI0dxT5mR4z/+vmjulvQTDY6VmS6+I5m0FnZjA
         XXFTjbhmfoQsFnfev7HYGsDdAywt0V4Wo0fBc=
X-Received: by 2002:a05:6a20:e290:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c44affe895mr8312376637.24.1784903426207;
        Fri, 24 Jul 2026 07:30:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:e290:b0:3b4:b340:411d with SMTP id adf61e73a8af0-3c44affe895mr8312337637.24.1784903425709;
        Fri, 24 Jul 2026 07:30:25 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm259643eec.31.2026.07.24.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:30:25 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 0/4] bnge: add more functionality
Date: Fri, 24 Jul 2026 19:59:50 +0530
Message-ID: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series adds a few functionality for bnge driver:

Patch 1: Makes bnge_shutdown() functional by properly unregistering the
         netdevice and freeing associated hardware queues and interrupts.
Patch 2: Implements ndo_set_rx_mode_async().

Patch 3: Adds a dedicated HWRM (Hardware Resource Management) command
         sequence to handle explicit interface down and up transitions cleanly.

Thanks,
Vikas

Vikas Gupta (4):
  bnge: add steps in bnge_shutdown()
  bnge: refactor rx mode helpers to accept explicit address lists
  bnge: add ndo_set_rx_mode_async support
  bnge: send hwrm for interface down/up transitions

 .../net/ethernet/broadcom/bnge/bnge_core.c    |  24 ++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 123 ++++++++++++++----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 3 files changed, 126 insertions(+), 23 deletions(-)

-- 
2.47.1

