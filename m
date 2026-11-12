Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459231;
	b=dCeg/hq9N3ZU192vh0LqQVHOEBbmEB0tuFG07ILp9V79zzrvu/ySGnYKsIcUTHHa9+qQ
	 tj9ZnjCYCQc0SqatJYAhvmEVg5PC1U7KzE9kef80NBs2+9kASxXeBCF+9uGw2a7qzUmKr
	 IwH+f3mul0Mr5LZvu7mPVc3Ox8tUeVWtt/dFEGe0X8eSO2wQ6C1M6vZu26BWZ25zYUdty
	 e+uAhw2MoRQjjNVKJEUswpulKJYWC/fYMRUijes9hiyQgl/V6lFgipW2ZstdtM5teae1o
	 2iQ9Olt4J2DDK8415goLkdhlXfldWr3M/sP7/NuIKJ7hs2YG+ulPelrnLl0aEQz8VmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+gfCrFXYRMyWY3Xonnf4UjyxCNLD1fV1UxPQdwpxQ3A=;
	b=hL1JpgoNeegYO/ZGOCIaIoflD8fYXM1TKddwsDFIP+j5TyqTQ09pIcDB3l+Eu6vdARXc
	 rOYxdWnNHkqVC8KNrd87pBMkL9phfl5sYRzSbx83z1WabQnclmd7esT1DlIUkvx1QLs9c
	 tsac6Slofea95q2GfumFrR/bU8joxo117+2hpNfUZC5wVi78ERYJ3VPA9ofe6XeS3FaAQ
	 sRnLHvwOpwHROLkgokl30+qLrwkPO09CeSV9/jxaYPk6UQgmOos7JRkHf4ZjvdTevCcyF
	 vjCGxAcvyhCsK1Bf4oIBscfo10TiCpz++VRXulPXLCyCQtXofmBDnhP9nQnWAzs49UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyTFHIBb;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD14606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD14606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QyTFHIBb
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7038189eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459230; x=1795064030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gfCrFXYRMyWY3Xonnf4UjyxCNLD1fV1UxPQdwpxQ3A=;
        b=QyTFHIBbI+luA16GlKdCi75gXJO6oiFHHdS+5tVnCfRV/DoEu75AlWJt0ZsSAo6mN6
         Nlg7CXH8WIzQMcFzr5MAGlokCXMTQgvyvnkhWOQbhJUu0wFdrADTHy+I4/JYRmD71Wu4
         Am0JowvfYk+Yd1dVcq9B7M7aMu8bp5H7bY7FD3kfrvwVJP0k6j+eKBvVM0do/oVyu13l
         SGOVgX0pNL5sY5xRBsWpzHoe2/8fhWjJgrvVRD+0YXHDNkOmR6EZpeCNGAItcOwRMDhB
         3wi4WFJXXD2qOP8KuUz3FQJ/Y5L0IsjxHEJ2qMOG7APRFNiBVHWVJJAZCdbCZV2V1l9d
         bOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459230; x=1795064030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+gfCrFXYRMyWY3Xonnf4UjyxCNLD1fV1UxPQdwpxQ3A=;
        b=dQrkQ37cdqtPlejxWcCylPJ5KcIr9/vCOPMvACYXq6K7QhXsVUbcWD0+tKQcoSG43A
         xHZsKGZaYirsaMakKSalZXA0f4/L/0WKqmT/e+tZSbp73XB7scla/nB9M1U/itGv/8z0
         xBbIG3+ErE3QIj17jAaiERJ7m4eVcyw9DmU3e7B8tjd4ZIjqQ1tV8SU0CRXeR+mwOOI4
         BKaLeMKE+nQ5Sb8/BMIoKvm4yOT75yDuphnG0B9BIWyZqoX5Vp5jSbybQokZZnwt8kIJ
         AaZ41pqHY7EYan/Oja70nyWWm1y9TkAah8lFY+INtUyCL9Y20QG/+fNtUZy3fXCBdrhz
         BhZA==
X-Gm-Message-State: APuU4Z9/qX32/b/ZKt1xSTbaIENXhqCVguGQUgzB/cH2TYM+Ed+LS9lr
	/3yN4fNMV9vM+SUK14B2EjXHMZShFi3TNs1DLAVZL3XTJhHzpTFw1rLd0exdmA==
X-Gm-Gg: AYBFou17BnapdB6SmlwpK2n7LxvKQdHCglT4qE/nXHvqsoYcRQIygbnTnKl8GQ/QlhV
	7z3V7+s5WCmnVK1bVKGVZhgDZvfjDz4YRljaf/R8KYHU7x31KMYI3dmFwndEBMjterEh4qKNh04
	koySyE5f6/fqZQSurFth+b0jThFrGizpaT0VOGPbmT2bQTnUwNMw5DEKnmMG33BiX5nceDpGtzE
	rznfyaf2zJ4aAFfO4MW4e/ZqAMhkJSx2b7deAX4JDyrwqAOrWIr0QcuchkKi5X5ShuoR6A61R3z
	IdR5u+viFCtvgSlm2hzyCuNqO9M6ouLsTfEZ+qriuMPYORYnUuz5/olrSZK0/6QDFEuvSyq8e7s
	54eTn4IAExpJQ/aR9FjSwjMGWMzQjTLN0G9qFd5E9PF9YZaaaSx4knZRSCzORhDllFdEZd3HIVe
	Z0ClOFAYe3OhdvLl7Nv7dIoA819H+9awS/x1zj7wChuEvrpZGPCkF3gfuTzznR2lbA6rpMlLSiP
	r7FzV+coNWiM2xxmzjZtT8NdmCbWSJM0USrD8Kuj3YAcV92wRKCGGwigyp8CdUZWdTQC5Mjwlrd
	Rzm/Txrt
X-Received: by 2002:a05:693c:69d4:b0:36d:25e:1961 with SMTP id 5a478bee46e88-37686660c99mr4780113eec.22.1794459230230;
        Wed, 11 Nov 2026 20:53:50 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:46 -0800 (PST)
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
Subject: [PATCH net v2 06/12] net: au1000: assign a valid MAC address without platform data
Date: Wed, 11 Nov 2026 20:52:48 -0800
Message-ID: <20261112045301.3669532-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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
index 5ce106d0389f..ea8f7787dd5d 100644
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

