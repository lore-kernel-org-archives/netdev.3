Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140327;
	b=oRMzte76jXzDjmGwAiupfnNqKqLvRRePY5XhlBt0EauSKFpCshD6pixx4n1rW2BCDg8D
	 rL6vl9Sjc9PN6IdP8dM/O8nY+mNvSzuMvp2A+BRN+CXji10HipELYIQb8KHwrd4AlNo0t
	 CJG+fiP5c4ysXyx7ZMDxv+Btz+94duTiEo21Lb5hkw6f7M5Vpnltksa8P53pG374AAgBX
	 rxds/dDUUaGXwCrZmjxT6cwMeFrUKppdZlqk6r4tV3XIrAqS11rcGhKj3benD6pbQy5ny
	 6mIS4QEbdlNJS35aSL8LNKbRbl+hN7pz9d20lxmnEHo0HWx6JiAEHoeOwT+D4bMDjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JEwn/LebwMC44j3K5FGc9e2/8pQkU9pC11hZEDGdjzQ=;
	b=tp8318qZmGLS4uqq8nAEQgtwgLtr22po7WKzmmtceb0x1T/4Qt3HuIM9Og297D8SIUHX
	 fpKolVJ0gMWzLgWrK4uYcftpDGDkDdO4NCxK4vtBcs0LHvUyTIlh+a9HfZDFCxB6oyAXQ
	 M6krpvYspw7alT8dmkztdovzqHaXtN0jAow/tJoWDyakvvP1IlwyLht7rIoOAvjjRjetA
	 WWpg47VZ9uPzdcfJzN4PHxJfv4bXNh3lyxclJ8PYHGjRqUGp9jdqR4BQcFmcBoljsNxq0
	 Dl8UYWLhkwcXBen1AIYTV8I39Lkw4YjHioNItHEANf1x3jVy9thgujAVcXGWuPRgsWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICQ2xeVG;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78260A260F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C78260A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ICQ2xeVG
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1846bc43c28so435272c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140326; x=1793745126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEwn/LebwMC44j3K5FGc9e2/8pQkU9pC11hZEDGdjzQ=;
        b=ICQ2xeVGzmWE24Bl8MUYq5aXG06gvrlMMo8wHLIEXuyyvSmITuiPetpYC0VRhKwSk2
         HbKhRUo4Xk6xayoeRdUCSHLTb3Q7pOMHWpVjxZlj51UDhQc4i70lgi1XpvckU9guYl2O
         NdFaL9nh0/Nlrr5rrYdDKmDzjj3+81b/MKPsVqAGIU3xVYIJX1p3QblGtYxYR0WunAqk
         2AWUQTQNEWmTwj8eJN8gHfGeAAW1JiECDJsAtGAT2eEQ97dsKybnfmQbnFg7vBvnVfgR
         ofbslCCTf03wiFw3u7j+kVRan2NIoWWpETPvn/zkQQMnCB9qAcfnEJzd41FpTAK7yW8Z
         1R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140326; x=1793745126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEwn/LebwMC44j3K5FGc9e2/8pQkU9pC11hZEDGdjzQ=;
        b=Bd1bTRMJcQFwgMAl4hgaqpCBFiGHE86N1HhL7WETyAWfdJl1d2mXws1lWbPRQTXF1E
         sI1Bj7dDZMdcHo+Mv5KSlhtMJT3gm2RmHQYR1ppeoXdx+tVUJ3wKZ+Ceu5d00nwBQhkV
         Rf+LnaZvEQnTq9uFI1EYBTBVVER5TkX1cfiVUU+2YVeeeSzp1mPy/TZUkd3z8zZ64To8
         Rstd8M/qGc/Lwh73j3tKgvMC5y4lbDhoMsPUU1q+gNS/yVZ3Iqtt7YDJkvL54dAJTYhs
         dwwSP3zlPohf+5NCpo1agG/2JvEIe1INbr7we/0Atr3w0gr5o2C2yKkPkWdh7pmWNxA2
         wSFA==
X-Gm-Message-State: AFq9FYKAmLEptqIQ9/nZ9GMbzQ8obwl5FvqrvpidsYA2GJeuHqlbCP5J
	/AvlEEP7szVTA5AMXnRqCCZlSyaVFSebgYAoW6hSGxgmzNlwphfGYQ0uelbbz1/3
X-Gm-Gg: AYBFou1pfSuTaOWh8NiFYDkwqN/7CA8z5prO4t409PecbHynoNlou4d/Wd8S4me1+OO
	ATIA4zsSWKtQ9+35DuWJpVnylaHobrqpZjcMVAsFv6CcCmbOCfgVZqcjBcXqxUX9gljc1bG2V3R
	ifDFaS7s0Rq9ewI4qnQtDZ98eh/wgNgCngSAqIHEObOKFKh3eTUKZpDfDFSWsHKlF5GosSGRGmK
	O23gy0ZYLVDnZlax15Mo20c/MlqV77OBWOvJLQDLbWUXsaZTg21+/Njw1Fpv4udUsZMYqVCRNCX
	xn2mzcvGXN7/arJkczGrF196avCvlkyOx+OGg97NmACV8OKp+KMIwpUCAjmBXmL6+3eKAVyHRG/
	et8a/p5UDT7KYsel5pmw0aASrQmtUsp0J6flENYQGgS/gJjKr6BtFJ5EpXNAGxqkZ2s4P+UWsfD
	Rw3a5zWeacoOhrnHCwC1NQexKkRAOJzxERvzwYywZRB9/Sa4eWzZ+fh5GP6Sg5lpg3Er6zYqWjh
	1kclYUF/EzdUzqm20sjftN7vq0H3BXCKwXPs7hG1cY5/1OEFHtwxrBYUIfBQl0W+VlkP/vSH2OL
	/czG4w==
X-Received: by 2002:a05:7022:1003:b0:19c:c396:37aa with SMTP id a92af1059eb24-1a6ce1136b3mr904232c88.22.1793140326215;
        Tue, 27 Oct 2026 15:32:06 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:05 -0700 (PDT)
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
Subject: [PATCH net 06/11] net: au1000: assign a valid MAC address without platform data
Date: Tue, 27 Oct 2026 15:31:35 -0700
Message-ID: <20261027223140.3774570-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

The supported no-platform-data path leaves dev_addr as all zeroes. The
device can register but eth_validate_addr() prevents it from opening.
Generate a random address just as for platform data containing an
invalid address.

Fixes: 7718f2c27dbd ("au1000_eth: use eth_hw_addr_random() instead of random_ether_addr()")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 90887dac26bc..c0e38a507f89 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1196,6 +1196,7 @@ static int au1000_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "no platform_data passed,"
 					" PHY search on MAC0\n");
 		aup->phy1_search_mac0 = 1;
+		eth_hw_addr_random(dev);
 	} else {
 		if (is_valid_ether_addr(pd->mac)) {
 			eth_hw_addr_set(dev, pd->mac);
-- 
2.53.0

