Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5763FA5D2
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963992; cv=none; b=NjJG8w4sdbWrUyQMToQyDUa2KCWki+uCgeIDvdlFv5Q2JNui69nILwE5H8Fc2bHKixmMb4jpPzOfNlu3gGqPAvdxnChl3SPcSi60DzANUTUyi+qe7Lj6bCYQzdphzQimoeWK2IIWeqLp9AS89mtHVBDIrMPQcyqyj+grpVYKYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963992; c=relaxed/simple;
	bh=tZL4Nq3wp4mqHJBH/DZAv+D88w5KfVsWDvWVeUJUC5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXXyUbT9Y2kAB1QU+rnXsp9Ql1AXFZIuBg3x951xbOf0lM3IQNlba0xOgkIeRtlImlrvJUs9Ohkkec+VABiGiZgbCHcu8ukem0rtKJaBoYuJQ0r32GuWq0omr5y7Ufh142pRsGMCIEF2V/Mo/9V0xX9B2My07jHc7omLtbAnBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oN9m8an6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN9m8an6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2573027b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963986; x=1787568786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzF2gO3yryR4hhBOXhCUkhPNTB2+8HWWPpLokgJWGQA=;
        b=oN9m8an6RlZjTokedxJ40ECnd4KI4dt/oAzwgABbPUU8rFfcE2N3YtF1r7SJ/m6aea
         uo2DxajVtnB9P3x9bzDutqEF/jydaERnY9IX/1hukSjRp6QeV1y0sMvgEXza3z44MDFO
         gRG1VoKvWcy8Cpjj0pze6Pf7ceF4HTyvBGT2bZ8h2KgLnEbpMnJHeAzdkyNtCS4ZN+eR
         iAjyt77jwdOwn2qv41z+HyE/cHa7NTuW40Me2jAuscwTUzgbMGiUnZCQ7WXQZeWFioLM
         gC3adeyBdVRzbm2e6NaufAQvIi84H+HL78awf9+/zDcnZt+vIKcrb+dq6ZKotNPe3KFK
         Snwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963986; x=1787568786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzF2gO3yryR4hhBOXhCUkhPNTB2+8HWWPpLokgJWGQA=;
        b=IAbDymfkdpdqvl14SzI0PuG8XUjm0N3QmPs1/fSuh7QCFA8xGSHry1lOoB/SHvk8ms
         R6iXa0Ax5afCn6oyGsaorll8LGXrbYRUdBX6S1C1DPUZNInShcLgyjuMD/GGaFiCYN2p
         zLT7CNGezDnBPElfBz+mQkKd5S/uOy3I+BbiBRIMYtVSYm58O1qxODGVM/61BcbYtXPB
         aej/3k8UAAEaIXpv0xwPfnQz1fZQGaCFME4RcylJFk0EILKvN3HBSEG9LcGplRjlQ6Kw
         m9AY49Gm8cZWV0CFLgRg1wpmaKfgmVBCd4zWiDaI+9io1e7I44ScWnSs7Py0svrOBNXr
         cSyg==
X-Gm-Message-State: AOJu0YwrchY5xt3HUA+r9uPNthz1xqTmGjMr9L2KbwmOZ8KZ/ftGbAdS
	SLoe2gRgRBoXV/BENHJA/AqDgoViswMXb/UCVXCZy5L09DThRvR2KgKM
X-Gm-Gg: AR+sD11F6MBaYteG0EyFal2i/OVEEdjqpbxL12G7UuRAX7RJvK71jr102ZAsUebhVfs
	dI0wT/b2L/4206sdEKfetAUXNOsKTTyqw8bXGOKTCTJyW/WuBb31dWUtLJ23NPE64YXiV6Ax7iH
	8pPXPMqd5gEe903Tjfsgr3+3Z1N6nWNjBVsgTJDLTrY1gpKQ8TPBfDMgL6w3T0KsUE0qwd2k9vj
	YtKjOalFSDXNHxGketISb1W4NcZmv23uPhz95wdXYJvW35j+GzLr3LAgVgboJgTBTNxqgx/BNB8
	sUSr4g172GwjqigrJ+e0hyJ5u4AOVNhvTEq+//7w3zh0G5JHB+CIGS2pszqGAp3e7db+TLOYwga
	9bUF/dyf1ch+zhm9M62zPTazpmP2ObvGwgR/TQuYtxiRiCkNQh3jf/87UIMOy8Xm5xrHnNhkRfm
	j3VaqkFxRzBZmMUJYNLwOoEEfjgZWkAlfogy90wO/Oz/+NCYeCzqapKXQbMHbrP31jdiDI4tnst
	T849npgLCshAoSSfaWQTsKYLbx9dkxdkZ435Brlq0mzMLyhAcl0I5Sj/qo4x4NIiv3wgxkqKixR
	ArzsYtYEX8XjXDo7
X-Received: by 2002:a05:6a00:10c7:b0:84e:2f2e:8c4b with SMTP id d2e1a72fcca58-84fde2a110fmr19733226b3a.32.1786963986480;
        Mon, 17 Aug 2026 03:53:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b401ec98sm354846b3a.6.2026.08.17.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:53:06 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3 3/3] net: xilinx: axienet: Propagate errors from platform_get_irq()
Date: Mon, 17 Aug 2026 17:52:41 +0700
Message-ID: <20260817105241.63345-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105241.63345-1-phucduc.bui@gmail.com>
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq() returns a non-zero IRQ number on success and a
negative error number on failure. Therefore, 0 should not be treated
as an invalid IRQ number.

Propagate the original error code instead of overwriting it with
-ENOMEM.

Remove the redundant error message since platform_get_irq() already
reports errors when the IRQ lookup fails.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 50f88a38b6f6..d982ab6f8a4a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2968,10 +2968,10 @@ static int axienet_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not map DMA regs\n");
 			return PTR_ERR(lp->dma_regs);
 		}
-		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
-			dev_err(&pdev->dev, "could not determine irqs\n");
-			return -ENOMEM;
-		}
+		if (lp->rx_irq < 0)
+			return lp->rx_irq;
+		if (lp->tx_irq < 0)
+			return lp->tx_irq;
 		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
 			return lp->eth_irq;
 
-- 
2.43.0

