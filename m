Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29F3B9D9D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528466; cv=none; b=V5d2fOBt4VusROLEgVtOT8tWj0Xq+kdzRt9Hp48FTn/2RDpbJSKnKOD+dv35mrXGMlLOr3m5orlFZPI84JyDsrnixtQG3asA6UUkvuP5tBvRfmky9lsBOXjuboF0Cs2XPjd0vxTWqFwp2baAKMi3PlNAtc0xVGPxeFAe4N/mbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528466; c=relaxed/simple;
	bh=XnUgFgPOsUuayrUBKTDQiULxihp3Q0iXhDWve90xbhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvxGnfcBAfoJQWmCphG7oJNb5xMTyfIu6LNDsu6t7w6kh8PhYFUIb/dQhZYrotU76jrNJqrYsvf/26k327AWLYr+4sy/6Ox/RM0IigCZFpTU/scJZyWQIiHKolpBHVj9RhRUNIrWnnU45nYUlj590CW+/SEYX7vBHwqQnC3z9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3YMtH5k; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3YMtH5k"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so5614705ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528465; x=1790133265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=k3YMtH5ka6h60UdPOgL0B+L9EDd1PODojlOtZXj4uOyer2EB/G2HxZkKPlc/YmAaMf
         vlSd1wfwFKuZ0zTSuJNc0FhyqYuyo7jnzoGIzKtDWqSNKkDf9bnKLjgAY2aMvYBBW/V3
         Dq/l76gH5UTfknGS+phmfIXvDABJVnbZoOUoysto6AIpVNncPDRqXPvtqaJoD3hdEcPx
         P30OiC9kV8uIOqcoAE9OwZhjJgcaWXB/qcp9fNGCrH79J14HS59371qmEqAcu+rSif9+
         UUdktKsiWJxJdTetGHFwGU6XMORuseKk3mtnbiq/mkbTsPiSq2BERWgqS13GgsuXKyv4
         mtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528465; x=1790133265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=rG4cozmVIa/HKU0bZlbwcVGoQ8B8zBVVv3NI/I4D5jXG8e454YRZ8d0IXvrOqvpRR1
         KNih7cLJw1My8PFOsCgqQWsRblwMR5ExFqHiVvCGkTIz9PZ2Vks13awNP+7tDdgHKaHL
         BtX53Wj25FaD3QL1DHegrWRxSLmH1/H76I0c5frt9p4PjFu/urBRbLGGFOMkaMRYIzmv
         hW2/osVUWHQXxuNwFXS5Q/mgEEyi1OyP+1J6DnFHFxb1zBHT9MkBcw8gofnW8CMXY9X4
         BpzKkLEsfx3RH+YvSB4nWxVWApIA+d3e6M6Gl4Frkbu1QEFVWFqtRzGsoencvI/k/1ka
         dNoA==
X-Forwarded-Encrypted: i=1; AKwUvBxO4JLdn8D1ACOt3oFT6XSav7lVLtYL3vjD0AUdFSFTvwTGQzEviyhg+MDsHpy/9oac35dRvpw=@vger.kernel.org
X-Gm-Message-State: AFuF++m3XeqURClrBK1PypRzKTeHi10mpVEcEBtJiruxzB3Sy7RwHgtB
	bfYOU0yOzaQvR/UmaUeZr3cSgjIM1tR9aP4sHRE9LiahaKy3iT6wAegb
X-Gm-Gg: AYBFou1jVKS9H0/lyXrQrNLtwEQe9+XCHqalVOfwF1q/5NijIPxYjOuMu6yIP/+QsyR
	AODV8hAoEoBKXTQgX0bXyNsPGmhzBd/jbUjo+3bsto/Ilyg9puWDfV1q77UrzL3D7hSoyCnE23s
	0oHtZtKAEzwdqnAKK2xQkIrurCgaTzu7bUuoPwIRlQK5rTWlvJ+ZbDQosWRtcqzY4xpVtOPcitK
	OAKd0fUx+WkwqJ669Il/TAyjQTdFpYlZwrQNrbThl2fxht01FEW0PNIM+xpjVuOYVi7gSUocL5o
	j8aK48745YDWSd/epstRrP9ri+AsDw6mi/bCYJDXDu97P1nV8iIerOaIg84SwbOVuWWDzaxU18R
	aTBlDycgwaqwV/KMOsspFgOeyUMCV21gBZilZKBfyDWIjRuoIJ4gct3xh6Zc15GRVfxQ/ujFVFX
	NKJDGgPeVHlJ6bq+xqB8MTPmUS5C6vO1NeB89Z17wGoXmuKuT0nXncAw==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39e1e504f3fmr2661898a91.20.1789528464931;
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1ae99ca6sm1886986a91.0.2026.09.15.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: fs_enet: fix platform info memory leak on remove
Date: Wed, 16 Sep 2026 11:14:14 +0800
Message-ID: <20260916031414.2875022-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs_enet_probe() allocates the platform information structure with
kzalloc_obj() and stores it in fep->fpi.

The probe failure paths release this allocation with kfree(). However,
after a successful probe, fs_enet_remove() tears down the network
device without freeing fep->fpi, leaving the platform information
structure allocated after driver removal.

Free fep->fpi before releasing the network device.

This issue was found by manual code inspection.

Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index d3c772ed5fc9..071e3f3de78c 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1007,6 +1007,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	phylink_destroy(fep->phylink);
+	kfree(fep->fpi);
 	free_netdev(ndev);
 }
 
-- 
2.43.0

