Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED453B19BA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821876; cv=none; b=mc8qSp9Lc4KCDEX/CQldm6RBGbTSXUTH3gk86ojwqF0GJJjfoySg6f/ldpr6dmmVIoVe7P9uzT6DjAB7s2o6NiuWNcqoA6ofAb4ht/4HvfpD1hIhUwpArkz7B2nAon4yUuO0BepqMTPHhjOZIMvq780Ok+7UsYSuU9SZyXM23pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821876; c=relaxed/simple;
	bh=xZMHYZHtWy0wa4A4svL/RzMbCC0aEYcZiTj1vBD/81I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNWxgaEH1cZNvBpa3fs5MD7JG+RtX3sJPa1ZwQkINILWYepuzaRVA2Ok2oYFUHZxwDyJ7tBuGPMD5/uxPojCbcDzdCMfQiz4yYzg58D0ReFa53Z7vNEgyQB4mThk8XutuO1R370FsY3lgwy0mUeB6k6B19o1NQHTyvWKsZhLpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJueRmv8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJueRmv8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so3023372b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788821874; x=1789426674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sl68zE3FFpTHMBRbqsY1/seQEtcoINTSg5HXdNhyMsU=;
        b=aJueRmv8ja3xHFOwt2z9IHAOrK61G46LyxkdJr/YQ8hqyEeQdMEg+YNLfM/ndhuX48
         YgQcYQ0HSjFe52/X2pOR/dYRdLnZIm+eCfmPMTmJ97oZKDl3W6E9WKGG4syMB4Dvzxkq
         64od5h13Rb/cwhStDCrn6NoRFf+cOlY1WnMknndQSM+Vj7UUWyf+3uOTNPX+X8aTjnCn
         pKe+G2EK4VwYL9Eu3M0+iNtfhzc5uHWpq/nOAw12DhwswbBs6wce8HqhXSbYRMF8gywS
         OXuV8rPj6n/lkJhBfTORd+dyqqKmnDnnllAT5TWWpoaP+ZXhK4yBoRoJAiIy8XejxsAO
         f6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821874; x=1789426674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sl68zE3FFpTHMBRbqsY1/seQEtcoINTSg5HXdNhyMsU=;
        b=nnkjGla8nhOO8x+IWXDsCjd1OV5zDj3ocPBWWdSJHDaQNuaIvcGojgkOFXjMHBqn3f
         +FGcy4guleOzYNLrI0PCRo4KFXCg1vDvZRCV6TLq1JFM3/pDY6q5d5ky8U8uBQOL3MBY
         nB9lKIXAz7Ntq0bWnW3y0PCyzpeghlHfk8lkYkf3E2PJt3o/NjDO504MgsFQ1Zi96knq
         m4atHZ1Mlf8DvpaX0EtPnXdkvElJ2N5fGSoU045gWAuxeTEKCm2p2Vr+V433u57QFp4f
         RrV9mqkbPl/8xvhkup+M4ipLOb0etoEWYkvV9vnsYgJX0yQMNtn+wnVCV2eBT3qee/HS
         jrcw==
X-Forwarded-Encrypted: i=1; AKwUvByvZAMVcUmJyaL5aJQZkl9M8EwGsHBZQHuo2b4l+kbTg78rjJy7DrTdSnV5VWePbIG4YzdpSLY=@vger.kernel.org
X-Gm-Message-State: AFuF++kRx6GACzigV4IW3KqIOQs38byE3HzZqoVW7o+iLkkdz9/9x/UB
	uyEunrGzwsnotkKZAhSSz6jxkqZojxJh5cfsW5sONpyRVwGQWLlQMODYvsIsRHfwevs=
X-Gm-Gg: AYBFou0SxxitsZ3IHTAhvKhz69NRS3mfpAd++rHLLdFjE/JegivwsuDHbhdskGVkKJt
	tZd+yXN9W/ytObY63yt/EMP6o3nNpyiFT2fkpkS1g6Ui5ns/sEFDppgomxu6IFiY1zLXSqoOvSU
	CfqOak7Vdk/8KJ6jmlsG+6Z+p50ZkhLog6EZjaeD8r2FgaZhYjLUnMWWK/toFuSokiqLhjgqtoY
	LxQyt0dBhFy6/U3h0DR9Olxltbp4T93JpJTQxxw/Pcl+bdP1pknh2bi6qCLcsjNmYuLckocLdBc
	4bFBcaurZcHoaUUDDO8PLKvx6w77dMii/WylWFF+4xlltusW+4pAoKOn2HQfde8CYCEXMLrn3D6
	qF4NkLRu3N3ZvVTnxEHXIbe5aZ2AAviwaAUb/CcCq2bzgNmCIOfLj+e7a1MXKF1kZrDOzFhy8T7
	0d336+xbhydjArehQPdfFYZ58X4hJGqSsUpaBPcfHXkdsRQ8XWw4J8ZQ==
X-Received: by 2002:a05:6a00:4c8f:b0:84f:5cd7:e3c6 with SMTP id d2e1a72fcca58-861662d4ce4mr36353360b3a.5.1788821874350;
        Mon, 07 Sep 2026 15:57:54 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::3820])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153e3ac30sm4709967b3a.56.2026.09.07.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:57:53 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: ionut@badula.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH v2] net: starfire: fix ioaddr sign-extension causing ioremap() failure
Date: Mon,  7 Sep 2026 16:57:48 -0600
Message-ID: <20260907225748.167279-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819083731.GL265046@horms.kernel.org>
References: <20260819083731.GL265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioaddr is declared as a signed long, but is assigned the result of
pci_resource_start(), which returns an unsigned resource_size_t.
On configurations where the BAR address has its high bit set, the
value sign-extends when passed to ioremap(), producing a bogus
64-bit address and causing device probe to fail:

  ioremap: invalid physical address fffffffffe480000
  starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting

Change ioaddr to resource_size_t, matching both the return type of
pci_resource_start() and the type ioremap() expects for its physical
address argument, rather than unsigned long, which is not guaranteed
to be wide enough on all configurations. Switch the associated error
print to %pa accordingly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
v2: use resource_size_t instead of unsigned long, and switch the
    error print to %pa, per Simon Horman's review.
---
 drivers/net/ethernet/adaptec/starfire.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index b72b393e6fb2..b2f3998e128b 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -634,7 +634,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	int i, irq, chip_idx = ent->driver_data;
 	struct net_device *dev;
 	u8 addr[ETH_ALEN];
-	unsigned long ioaddr;
+	resource_size_t ioaddr;
 	void __iomem *base;
 	int drv_flags, io_size;
 	int boguscnt;
@@ -664,8 +664,8 @@ static int starfire_init_one(struct pci_dev *pdev,
 
 	base = ioremap(ioaddr, io_size);
 	if (!base) {
-		dev_err(d, "cannot remap %#x @ %#lx, aborting\n",
-			io_size, ioaddr);
+		dev_err(d, "cannot remap %#x @ %pa, aborting\n",
+			io_size, &ioaddr);
 		goto err_out_free_res;
 	}
 
-- 
2.55.0

