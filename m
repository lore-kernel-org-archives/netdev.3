Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140314;
	b=rEt2EnW/dzJnq5GxTUhY102Jra7oubs19/wpjPswoGG896IyaP8WlOVUZTuycZS0Fr+H
	 bGFoDhREgzlFfU5fDHDHH9fpNcbEnQGohdb72GKfQPl+zjGvbumkSdglLAMDVYIxCgoQS
	 vUbGddhgGlclqvaFyJ0P/Mq2hX6CHuKRBq8LlaiImokcKJ0BsvcDCM7dQEh44NG1H24+7
	 hSNqbdSax7GvaBrsSxgz2tCctfTX7N6BzMof1RDxbEK+WdLhKSHMpvXGqQut8dxgS6+3G
	 pGMznlqz/YZaa2Eqj/nqFc871jT9Oo+OoIWp9hbn6mgIbD1Qj0DZXwc+NhE+6kujd9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QO+WEDDBqCXe3DR+7d+xZwsDicSuUOeENxwYEeiY46M=;
	b=dpOWYjHvFIkzrM4HkapWWzrAyHjvJwWuvOzR9UiiTfZni5ho0wUJqTyBbQoEHkQiRSQn
	 5IBf9GMtk8P2ih3MV4ycNzRUy2psGlQYi4LL8P/EvRFsmb3rRNkcMyJrZBdrkMVHDOu+Q
	 g5kw2xSBDIuK6/Aa5RRo9KohLkU1Fm6P+mDWCvwO6ge2NFZYATQr7lfWynsccwSvRxyUr
	 bNIeRUd+h8lhupRFFUXuqtVT2FflQWkH81Oauad/aIIDUvjy67lc8a+NenzI4P/XMDsCT
	 Fmt6VBl3Wz+NbUG4XPnHPiRhuaznh3uML129UBMc62X569VZwy9jCwFGme6u6lpxLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPhMfyJT;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783B606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7783B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPhMfyJT
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1846bc43c28so435097c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140313; x=1793745113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QO+WEDDBqCXe3DR+7d+xZwsDicSuUOeENxwYEeiY46M=;
        b=FPhMfyJT2hGmNAt9dbopO31iGF+QwsdRG7tvNBck1Qsn+uF3MfdBTO1Qje0LSO0UCR
         wYsS4+gOP2qWkglZmWm1dfqVeHz6pR7X8i36xLXpSxDckVjNhPGzc4m9m71rV/DtsVF3
         jeVCyvM/87svUspGWyj15z6FBhEKUmSNcyarzHljR5Vvxki+hvgdu0/Z8ozE5AG2Y79v
         Iw2onlnEBwK030jaNhTPdUL0Mpjl90AhYqtnuz4BVf1+Jyji4L4JD5mZgvWpg5jWrBzb
         yP58bZ7c+la+TNmTI00KgpdgbTcsXa8tnYrAaMsdNYyY9lIUboCheTOdxibOzdx5iJUw
         /9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140313; x=1793745113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QO+WEDDBqCXe3DR+7d+xZwsDicSuUOeENxwYEeiY46M=;
        b=0qoYxxz/c6HYrixkfVaqYRB93Eaade0jn+0f/iZXP3fBLjqT1pW0UAZNtFgfmmCxag
         1Z+g80/Pcp+xPMgagHo67NAa3IgrB+P3Ws17qrJoktdl6KDkmzsnmoUhdPB3yjwNZiV8
         9ua/0pcDR4B8ioaS4Y1fq5XlqFBf1ihvGbU3SsAYtIEqy74sae/51+L/kXmPf/+MaPnK
         wGwYuo00WEQ/SgXaFKnZbNDc4K0Y/WcTWCY/J4lLb8A+Lto8Km/oUKvGMl9T9JOHQZm8
         s69/DzKf28qso/E02mnXqz63bV1ZjzSv/NdyaE4c6Jw510xJQBUypt1uUE357r/jN+0Z
         RxFQ==
X-Gm-Message-State: AFq9FYLfQXISUi4ZjD852GSkDijbI5OggY5gZB5jsU+cGovI2yFHv3Em
	b7Qq9PBdff/5wAgxC3AKXan48YMr24JcFD5Z1EEmfxAbwI2st+TOPQylbNikyLVi
X-Gm-Gg: AYBFou15uwQQU6NVC7k89KNmljXSHf6fEKxkl+mGWDQB8/lsItBWmtrduXzDm2IMzEQ
	if1LTkAxB1LOFIzPzzRtDz7dvDEBsHtoFknlihhVpGduLKdB2UZhAzpG3+BRqCtoAo4j1hEU68V
	adxZEElcZtkiYZlfYZu+v/+oLuu6v3pppPQ4KptUFxEJpYvnBZweHrkS5xRQxgLiejA2O+KWSZT
	6t2aRDFH4kvAAX1Rtkdh8JbNUN4PX1AlohF5bH6AxerHd38h+v376KPgUGMTfpqgmE3pou02W6/
	2Z21OQMWg6r+9ZWm8JmZoCGnL/11qUh+PK9B6u1blDq1wiRt7h+6OeJYtgN1Qt9MsEHypZVF22g
	A6krgzt9emtMoi2CIMTezr08P2LuSgQyFJB5yvr3XtGsNI2GKkK0lCKP+inDde/KFMHMGsxgOU3
	1ZuGMgqeecHTFPgyywpBLFVIZjbKcX3rh5fmQGibno8BV8hV23vJ64/DKhUphYxsdGZZCbGcIPy
	c4Y3ILQyeKMhk5dGFCS2qrI8nYUvAd5NNQioMb8C2D9xGRb2NgOOmai1M6zAd2fOZgpE8kSvBb0
	f4BvQ2t+0DPWaYAI28s+GBvjdDA=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr764862c88.29.1793140313210;
        Tue, 27 Oct 2026 15:31:53 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:31:52 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net 00/11] net: au1000: Bug fixes
Date: Tue, 27 Oct 2026 15:31:29 -0700
Message-ID: <20261027223140.3774570-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This patch series contains bug fixes that were found during code
inspection and also during fixing the open/close/open issue that was met
on the MTX-1 platform.

These patches were tested on a Meshcube MTX-1 board using targeted tests
to ensure the multicast and open/close/open bugs were fixed.

Florian Fainelli (11):
  net: au1000: recycle RX descriptors on allocation failure
  net: au1000: clear all-multicast mode when restoring hash filtering
  net: au1000: disconnect the PHY before freeing the MDIO bus
  net: au1000: report MDIO transaction timeouts
  net: au1000: serialize TX completion with packet submission
  net: au1000: assign a valid MAC address without platform data
  net: au1000: fix buffer descriptor free list insertion
  net: au1000: restore receive filtering after MAC initialization
  net: au1000: restore RX buffer addresses when restarting the MAC
  net: au1000: keep the MAC stopped until the PHY link is ready
  net: phy: smsc: wait for LAN83C183 power-down recovery

 drivers/net/ethernet/amd/au1000_eth.c | 74 ++++++++++++++++++++-------
 drivers/net/phy/Kconfig               |  2 +-
 drivers/net/phy/smsc.c                | 26 ++++++++++
 3 files changed, 83 insertions(+), 19 deletions(-)

-- 
2.53.0

