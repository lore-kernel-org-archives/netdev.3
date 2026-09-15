Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C53638DC44
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436399; cv=none; b=ACmfGlQ1gTxVOpdGkf0Ri1z6CqGMMVI1qcq+6kNxmKIw4TCeMaGjLHNJQ+OOHMhC8KcS6nH31jMYxHk9ruf7vIO8dEPmhoKpEZcaIvKMuRZv+ba9xqrjUgRW0LydXrw651J03ISDogHx63ou6Osw7gKTu+HEr75L+3WH4B0L54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436399; c=relaxed/simple;
	bh=eegAhnVrUCevIMwR4a8J4nvt5iV1r65jSQgaC+VQDZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS0ZW1FBhzEoqyS2fXVpGwj0tS2SpeIguldTgYs/YsuVwdtle4KigaaLBNO08MRRTVlG9F7ZDI6B2wIDOIE/+QeJKMIRgHWwWEfWH63BwDBBiqdPBL+JhR7NcRr9wzRrrWYt1Z/bqj7srdkrOPmmq6tDNg2P3xDfgLRtOryB2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiAbgYl4; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiAbgYl4"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso32800106d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436396; x=1790041196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzOO1UKhv3FRQXtJhYy1irle0OACEUNuvCoqDtGq3w4=;
        b=JiAbgYl48BPaiZSK9Ktt/CEBX8mnt0R7OflZchHm3l+bxRvdyP/hBYC0IjqmTEhYK5
         D3k+H68vzGwngUekHSHGHKAxtG7KKp6hNGYpoqjNfJuEfvhUWQfghIY6xbvEiTXtY8ez
         YGKutpnFav31gin0uRbRCiZQE1qJOkAQKMywC4I5V6xYGrvcEsu53d0YAtM1MKG+T9Hw
         xbSZwxO4rARs49xDXTPnpDSEZ1+Fvz85kAmVdIqpmeTGI5ozNrXwPNwgjJzsMIWJTqSn
         xN5PLMTApyf6YUxtDOI3RvUylcYQHWwiV6JLtDsGzUZTx0DeZt4sp0el4N6g+BCZE6OU
         4Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436396; x=1790041196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzOO1UKhv3FRQXtJhYy1irle0OACEUNuvCoqDtGq3w4=;
        b=GM2daD9bIVhFKCtBOzl8b4hL8urmsC0OXPMSAIDu2y6Fc76PCQ5hdkH7mB6E1MYNlX
         XXXmF1AkDrj3gCwYAx4ohEomlgNU5C3lVpR2tLuKaD2+lQn+Mu5eDbaoS7HDttlDsQml
         dIJcBoL+7HzyVhO4VnxgNGvPQEuIkF2fgrkMt9tiVN553SAM5Wm6rgPH9tv/BOX0dW9r
         6MGAK18Xs2KFgb4YAI018f3PPdGDOgdiCHADdb4TymWnuv1KsDtjlvt40QFyvr9eC5T1
         xY3ZUZpgn/6wxZZuD6QSqkpOOkKb5+aqhe3/uxvHOUMHa+ZfrpnG7IqLNIADaJPdbB9R
         maQg==
X-Forwarded-Encrypted: i=1; AKwUvBzVxfDwRxClQpe3hrmrL8q3lcA1C7VAm4VXR0fuJyJ7h3zAVfMdIXRxyJ7OimzSGgryTZ4yWWY=@vger.kernel.org
X-Gm-Message-State: AFuF++mUPzvrujb4pxM3usZmK1nKglT21O2yNERLXUK8XnDcxAmZML7n
	9QDwtK2q8KS7tzbd3unPMzIwLouBnTOXh/sU0yrl/tI5WaE481a7LiY=
X-Gm-Gg: AYBFou1bF+V/uoHkEGjgvMx2QKvIraxsBs0wAwvAm7MVrI5IruCUrZmSNGylipEaaep
	IZYr12wuJz9348UwBebTCe9rI8zODFY0Ou2j+ItovRnstp+or9k3Bl6MMGhHQxrPXa7MDrOeVnE
	KQkVsrE4LwRLZkVjW3hpsn7NqXrnDzkZS64FSKpsH0Ioy9bzhi6cMq75y+zBJ+hCgBAfxrEHw3H
	h+iWopV1pu1uxpeZ1SeEM2Z4l3uPsX3bU2tztWJ03Mxg3iLUuFrOiGK/4KVV6vip/iGq/oPJU8I
	jlHi2hu+uf5Q+E8PDxIHHct4jHIxnHWVewZdEjwMSAgo00DFQIkKw/KJ3R+DXfJqmiD6RrgZ0R/
	4m3IF20Yc/Y4XUXnUQCmSTKJNnTuoLs42jJ72su4xet+slihV/8YLfAol/9qvsMsruZXd2Fp3Ct
	5qG6U87yE4gn0JuVwpRb3HE6TCVueress2mywlSBG1drB4JsFZzEn09QN0uQ/p0CR048nUN4alH
	S4BP5Xww7ircJRrAsKPvrzRMPRnfjlWLJ8Ulrm85lbS6hk5NHi5NB35N/4rPex3qqeLbhuBEJnH
	4W3T+DHWH0NQ9Z5EjEet/6H85NTv2TvBbwolmhZxknlc14bZpzEMz7BhzLBKgS2+/liX4A==
X-Received: by 2002:a05:6214:e88:b0:912:1fca:531d with SMTP id 6a1803df08f44-9122e4cf515mr93110326d6.2.1789436396274;
        Mon, 14 Sep 2026 18:39:56 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4787eesm108637906d6.21.2026.09.14.18.39.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:39:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: arcnet: com20020-pci: balance PCI enable on cleanup
Date: Mon, 14 Sep 2026 21:39:46 -0400
Message-ID: <20260915013946.73963-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915013946.73963-1-mhun512@gmail.com>
References: <20260915013946.73963-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

com20020pci_probe() enables the PCI device, but neither its later failure
paths nor com20020pci_remove() release the enable reference. This
imbalance already exists in the initial Git import.

Use pcim_enable_device() so PCI is disabled after channel cleanup and
after managed LEDs and I/O regions have been released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Depends on patch 1/2 to tear down registered channels before managed
PCI cleanup disables the device on probe failure.

 drivers/net/arcnet/com20020-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -133,7 +133,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 	ret = 0;
 
-	if (pci_enable_device(pdev))
+	if (pcim_enable_device(pdev))
 		return -EIO;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct com20020_priv),
