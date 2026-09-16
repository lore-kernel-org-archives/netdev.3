Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D09460
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529079; cv=none; b=KgjPI1CqAkTv4R3SXcjOH8bBqmutDLid+qpVYlppDtl3/qHeLufQvhR+kE6/tnhxCBXumtdC1iN6t2Qk4LcDNFXL1s+ueDwEu+F2cFU60/NhMh3b+Q0IHLDyq5WkNu18Sz0QR5hgMTQXNsD3e0zFmgLRj0qO0DfN0BM/m5qqYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529079; c=relaxed/simple;
	bh=iDthSQqefFrOLg0kDxpCSPIAK7dnv2RUYvXiwlkwsRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mggc3N2zAJfSlbOQggLBRIIHk0MHJ6SbzRff2j9eluK4fbEuyonygR+hraji5XCWRdn9oHcHAYE8gKEcIvww+3UOVJAsqZClyKJcbBPIyws8Znx21Ug+EVgbfSdk0LhjAW7VXDixwcETC3GARsJJ6ZMBME6OnFJnsJFzec0gDVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwsvjzma; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwsvjzma"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso278098a12.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789529077; x=1790133877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hewLRE41ZIFiAVylPPAMUN536cPkfHAC1jqHJ9IalwI=;
        b=PwsvjzmabTVUzalQ2cu2esCbIhvgN7baFnMCGdxz8R9HspexJDJaPZTl0zZLaB1ymE
         1z3erk0KGJyRLR+Vu2iZPETmHfqxJiEvCGXZ5L60fje75hxM4IFKo3kI8CAAX7Z4IhJP
         75DPW5VT5+wZ7Z5aDCUo+C/n/EsIHuYVAaC/ktoaQ6PET7Xdfl/KmBeyoVsnwwYg8Esa
         +vNqUNdDeTMlHKsIGXQ6uER8wEHuDv70yjjwAoCjyDH4p1SABDOrdwCqJ4iLZuRceaV+
         rpJvSYGBbJNwlJddcfnUTA+yTPHmMeoj3Zc3XW5SX/thYB2cngk+D63TJKv8TUx0CUgS
         Q5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529077; x=1790133877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hewLRE41ZIFiAVylPPAMUN536cPkfHAC1jqHJ9IalwI=;
        b=FgOpGursVDxwAyP6s/S95SuVdsXO37sg/YohoxIBxp821j6GgT4yfz6BH5TnMtpU/L
         OlnClXjscxCU5CGQh4KGKT6JGRawSRaFevsOlUdIpI+Cru80X9aV61GlCf8VqF88ks2X
         zn0vA/JvR+CJVUHMd//NXzgdd5Fgy4qbPypwswDhZRDAww2+CTK5YnP35gRn1bdmzcKF
         DfdgC4/QSdIt902tsGJtsenyOuxSX/jpxZXZ5upgDRdbRaCMEckuzCUUhIiQHMUMr9vl
         g6265woVjVDe9mLNbVmzQRxuWSDaHxm6t0oDRNkXSPHCq1e5X9+SLVfseKc/coGK5s34
         cdZw==
X-Forwarded-Encrypted: i=1; AKwUvBwABuxiOljGkUk1jTou+9nb5c1IgY2q2XsG5aXceWb+fY0sQGtoZwT+rSbJq4Od1+kHxCu+NIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k67gK3yiZ562GMa1ds6k/d2nTahY3dSHSOK30rnXYeIYgI+gsk
	BhYEjxU/YQ9plMdAEvbiego/rZMnaQR0cZqS4RiYRVOn1ySwIufS1IbC
X-Gm-Gg: AYBFou337C9xJFon4NsV+scnKK1vj9EZsZde329Z0+m7E1KmJ5JMkEwgkRv6AvJ01TN
	1IhGHpD0re1fiYEuTdxc6lSkZMWDL+9WD1X1vsm0eI3xm94WhnKS72khEscmToXsbN0eiA6yFvH
	05Vm1su5TXbQiQGmT+UGs4iouhtD744vCYCN46Pb6/0MpKmS1sOxSzmmjfTbLGo0sdm8iqYeoeu
	zZ8nYryvw2eYurshZR/alcfT3sNYi8XMB0/DAlLUln+id7BTDvFokVLa1lsPfnj9l9wWy+Ue+vG
	NCW6qsptgYXQq5iLLj6w5t2NJZ6eG9udI71jxEu0Q2/M7qUrerXbb4/TLgwmkhngjL1sZEsK6EF
	iHJ58AeZ3Cti3X0HrFJtlNMLNo/qNbJQ0Ec5WbX9dNC2drxnbnAnUnSmNamQfAV5ysjVvy2L6wm
	MYKgXpfD83xT6PZ7hMgIN5qUOoJoEf5x2sNx7E+oE8qOnEYEqRQq9b36a3kzTGU10/
X-Received: by 2002:a17:90b:390e:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-39e1e424a7dmr2098764a91.12.1789529077349;
        Tue, 15 Sep 2026 20:24:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb234c3sm1772473a91.6.2026.09.15.20.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:24:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Fan Gong <gongfan1@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: hinic3: unregister event callback on remove
Date: Wed, 16 Sep 2026 11:24:27 +0800
Message-ID: <20260916032427.2899987-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hinic3_nic_probe() registers the NIC event callback with
hinic3_adev_event_register(). All probe failure paths unregister the
callback before returning.

The normal removal path, however, tears down and frees the NIC device
without calling hinic3_adev_event_unregister(), leaving the auxiliary
device event callback pointing to hinic3_nic_event().

If an event is delivered after the NIC private data has been released,
the callback may dereference the freed nic_dev and netdev objects.

Unregister the NIC event callback before starting the device teardown.

This issue was found by manual code inspection.

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 0a888fe4c975..42e2ad179a9f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -499,6 +499,8 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 	if (!hinic3_support_nic(nic_dev->hwdev))
 		return;
 
+	hinic3_adev_event_unregister(adev);
+
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
 
-- 
2.43.0

