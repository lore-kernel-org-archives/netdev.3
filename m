Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847A494828
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732940; cv=none; b=H3yzXvlPsB7Jz6FVSxeqkoEpISbnEKhyNxj4E/9hAVciUjar/vcNe4PBWf6t9Wxt1sCyyCxljmgpdrwBF4XCx77Xp9RDGiVgzTdAY/o91zexNL55j9PkB11ocnaG2Q4rZA39iD1W8LqVXpQbWEPeeLchNxfsSdN3JCm/5Q9dV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732940; c=relaxed/simple;
	bh=osldSqiyKOtQsq2ZkcvqIoQfUoxfOFJmFVCnwBg14a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8QoLL5MTrEz5CXU3RawCMEU/j8k+QbNBa8pmwiReAbfJ3qt0Vxs2+zCtdLBRo4fV3Fh4geAgx4V+B3+LgQGXikGPl83FLaGFVIdwsvz5Kxh5V40MFrlfTDysCK5ZF0ZvFnjqYE1DSikF4YW8L2Tw6ZTjddBChIoYaB1/xuqihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8jYvwXS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8jYvwXS"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cb057311bso924993fac.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786732938; x=1787337738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KY5l5iWLwAA98ypglIeJNOWuA4lKT98CtaEJk5P/VVQ=;
        b=P8jYvwXSxGysY5CWCntmlqMonZfgmlCXqcdpFc0fIXeTf2ek2q/BxVVyl+Pg8h40hh
         BWK6BSM3K2FV0mM4D2ID/5CuyCA5COFpKPaKAa+pMm5EuqFZ6OZh3cCwgCaIar9/ycn8
         MYQOqc7S56IRoqUZjzAZu1lDAXWc+l/1iGayOrRkMfgVfeJ8WEDe3V6ZvpiIuWinZIwY
         BesNsVbCHCarANLDeqIOUIH4JHHQUGUzjAL1Mdi5XLRBbmYfbUP+QYSW7cYAflRZESXp
         Lypm1/wrbxpdAieQRnbfEZ68wjRcfJW7UcX7HaWLzT0w9R5u8jmcKYZQCBvPWfmNkZfE
         IaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732938; x=1787337738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KY5l5iWLwAA98ypglIeJNOWuA4lKT98CtaEJk5P/VVQ=;
        b=nJ1Wf1oxK9K9mIWxVgYcG7+7k++i2c0+TDLht/MuJLOBjKPeFmxume1APKollhM8J/
         pHs/4GzFInPYlWiq4n6nueLqU13VN7LaTxotGCBYIGRD3WeANyb+mX5shfX1fZhqQOTC
         DS1LnJ1eVUOBN0mNuHdRiIsxzWFdbmS8JCXcqI3PGPGzXnlGTjTwwvZjGkLuGS+hJXau
         lu4YYWoUuolDbmCzaoVmHEi1Sl+nkgq76FRZgAdN9CF2tqd+Rd7lJq+gJy1dWAP+/cTd
         PZdRYFpVhKQzjiz5KoGl8HjlB7sYjApHU9i+Xig2w13L/l2eTMshmSo4LnXe8OCgUobX
         5hmA==
X-Gm-Message-State: AOJu0YzqQMd+rwB07FwQD4+QlffFmWz4mZTEPZsGoy+JXNysDE3NuRou
	UlxyxzC6qmbdrqs5aCc5mp3UD/8hNnP/NOxyCMsqiagSk3fUz9KidWN8M8cUiw==
X-Gm-Gg: AR+sD116R/fhfH/2+TZmD9Acf95sXfD2ltiHH4TvkulciTiUNgaN28C/HFWW/XDRoKM
	3dNkgj+x4v7rAhs9XUOr+sayNRjbP6WUTx2snx7p8gJjBusJKlWG71urYuiacar8gIEuoic0Nry
	zFiElwZDyPKIQC6cDciLKMgU8HoVJ2mighE3MjTG5o9fdpd01MdjyBzvlVimsirOPraucspoH+8
	KEZwMz6nYpcEXN/8Je4mhQ+sW1WikGlRhVR4KP7X1boJOQfHtns+7X0kJCNHYozv8brvw8f+QCU
	CM1HpQsLYNnpkc2BnuAhtDRimKdZTDZ/n8D7Soc8YgDoFULmdUfIG11iCwin/f0Cl0pk8gkCvUb
	QEMKhmls/15Rp6yDw85SgE66Jzd8tY1pnhr9dHhVGTId1SuDsp+OL3J+TgmziG15NlDZkCONCv3
	86xnyqHq5OCY4pIncTCvfsnsWXKfE5PgdFWDRaJD+1VZfFTzP4tJSi2IoYQBJuutnajpj9fiA=
X-Received: by 2002:a05:6820:1896:b0:6a1:4040:97cd with SMTP id 006d021491bc7-6b0d5fd35b3mr6997138eaf.3.1786732938073;
        Fri, 14 Aug 2026 11:42:18 -0700 (PDT)
Received: from capidev ([2806:264:548c:900d:c985:8bca:7059:269a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0dd2e52d5sm1885406eaf.10.2026.08.14.11.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:42:17 -0700 (PDT)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	jonas.jensen@gmail.com
Subject: [PATCH v2] net: moxa: dispose IRQ mappings on probe failure and device removal
Date: Fri, 14 Aug 2026 12:42:16 -0600
Message-ID: <20260814184216.388-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260814175404.1616-1-diegomancera.dev@gmail.com>
References: <20260814175404.1616-1-diegomancera.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus: Norton (VPS 260814-6, 14/8/2026), Outbound message
X-Antivirus-Status: Clean

moxart_mac_probe() maps the interrupt with irq_of_parse_and_map() but
never disposes of the mapping on the error paths that follow a
successful mapping, and neither does moxart_remove().  Every failed
probe (for example EPROBE_DEFER from platform_get_ethdev_address(),
DMA allocation failures or register_netdev() failure) and every device
removal therefore leaks the interrupt mapping.

Since irq_of_parse_and_map() is not a devm API, dispose of the mapping
the traditional way: all error paths after a successful mapping fall
through init_fail to a single irq_dispose_mapping(), and the
register_netdev() failure path additionally releases the handler with
devm_free_irq() first via a dedicated label, so the devres-managed IRQ
is never released against a disposed mapping or a freed netdev.
moxart_remove() releases the handler and disposes of the mapping before
freeing the netdev.

Fixes: 6c821bd9edc9 ("net: Add MOXA ART SoCs ethernet driver")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
Changes in v2:
- Use the traditional IRQ mapping cleanup path as requested by Andrew Lunn.

 drivers/net/ethernet/moxa/moxart_ether.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 8bd60168624a..8f79ff24aa05 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -543,15 +543,18 @@ static int moxart_mac_probe(struct platform_device *pdev)
 
 	ret = register_netdev(ndev);
 	if (ret)
-		goto init_fail;
+		goto free_irq_dispose;
 
 	netdev_dbg(ndev, "%s: IRQ=%d address=%pM\n",
 		   __func__, ndev->irq, ndev->dev_addr);
 
 	return 0;
 
+free_irq_dispose:
+	devm_free_irq(p_dev, irq, ndev);
 init_fail:
 	netdev_err(ndev, "init failed\n");
+	irq_dispose_mapping(irq);
 	moxart_mac_free_memory(ndev);
 irq_map_fail:
 	free_netdev(ndev);
@@ -564,6 +567,7 @@ static void moxart_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 	devm_free_irq(&pdev->dev, ndev->irq, ndev);
+	irq_dispose_mapping(ndev->irq);
 	moxart_mac_free_memory(ndev);
 	free_netdev(ndev);
 }
-- 
2.54.0.windows.1
