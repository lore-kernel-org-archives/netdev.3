Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B893C0A00
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131879; cv=none; b=BOA+HofOM61F4VY/xE/QS8yQl5yuDUOFCMAijMlP9j2VUK4xVcNHy+wnBROxEMsg1nrG1U7iTcUWlKQ0G2x1nDb4VIBhsVMo26cBcX1++vYFcV2cOWPUYKVBDZH4VCVDFgM74Hkw4JQ8VhosdwJcRR+gSeYC4wA91V7E3AQ+Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131879; c=relaxed/simple;
	bh=H5+sSVU/RXXPTAFNa8cAVTSao63c2XL89jEu0TBthTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2bxTEUPNZOPeEpR7ZeCs2uKWI7Hn0SzHiYvmJyCtGfSYw205xN7oAoFah9WR/tTnv03iuUmOBRVXWBbYkJ7hbMJ/K5hfWPWagqx/b9VB9Np1iTQQrRBI6jrtz/B6ZtRnk7jSD1200uHhQN0VnLRZwmBOtL0sV2/cKqVn6l3iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePx9Rbnn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePx9Rbnn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so14291805e9.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785131876; x=1785736676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glcWwuAzt8vXaIVcCfbsDd8hWx5GOfxvsNItjmFdoCs=;
        b=ePx9Rbnnmnz1IIV1Wy8DxOQwq1opWfJNBcmGSzncgSlwEgULjbjuL+sY5W6gzamRjF
         08r7RGv5JxDUGytCltfvb4B2IvWIx+fgV0YM5u7rlUY1iC2BYEDmS8AMpEwiBgx6cnkT
         655kMDHCAHkquU+B+bJOASZUKfh6cf0ZQlUQZa349gfqbwi0yRiGNzR8jtaCCmcJQV+k
         mTQRusRDIbulXclqjuXLUEZfFAswU5jiPSTxi/ul0rFlAR6hB578h3dKqQP40XbEkZYo
         s6aA2xMoxn7LEPwbUNEe6QJGXod/aB8EQND/waeRVDgOhViNyzfsvoe13EmXxlVZidNv
         mfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785131876; x=1785736676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=glcWwuAzt8vXaIVcCfbsDd8hWx5GOfxvsNItjmFdoCs=;
        b=b+QIGtkL6VMdOGiqVCQU4npveIUoidZqjc8aDkfxyitl1HqiN/kGISPBj+wpY+A/tZ
         Cc9h5j1P8Za4io2Rkg76NoxReKxatzYc8+OWFfBvPiEpanwPkZi4NYsEabZNWhBIFsD4
         w1F3fP8Zl9TY5ko9dn6YTaUF23HPpAyU4RyzRf0u3GrYkbrsib6emrZElJUPUckjzw45
         XlfqFXSHs5aK6Phrwq30ARX7l9yqDRMFJe77w+NLJw31Xjrq1KlvmD6/pncOZj7MITxQ
         Q5B7pZhXJ3VxiHxW6kv1X0zUVIfsQZY0wqXNrrO0OPFzJZBn6AL4uoVLm2ptS8ky7tAt
         d32Q==
X-Forwarded-Encrypted: i=1; AHgh+RrakBAkC5uY14bGL910qqsgEtLPgia8yjutuYIC05hZXgEU7TEerrxJ8I32cOaeaDfqbhyi35o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNYMcuLiP6LnmCTAryigXQNIsg7YQ+hPVz78dbR2ymaMxeX2/
	vLhtBUlBLIBdKu6bSplok/Mee/i3NQYPPfxd2MK+Q1hMFwDowSTJrH1H
X-Gm-Gg: AR+sD120DnbUxaKK5ROPJ8zyZi9wXRh6RoIRVt7hKToigUZj4V9LE7WRASplvcQjCjB
	8E9ZcP8gXsgbARw0BHm6hHavxt09VhQ/K3s9sUNvb39KBwGQENbSjMkGsTDrTM+e6C4e54j6bAZ
	D91maEbh/LHtCXZGD0qhTfjeo4P8CFAySfuaCQL3+LYet+Ea5qi1wCd5NpCGOIBnK5BHb4aetKF
	asEkiec/gXHYVzIAfWN5mV7vwNoISz7vcteDP0hNKp46xDQkDtdbE/iLRuVQHwnIlotytqfLULL
	OdlZiFSkpomylgQ6+9n6btbpelWGnppYGs4x3aiD7ZgMuMOptG02Dw5htsJE8a3vNw9/eefh8Sa
	OKicH8bzjhgXFoC3mQD4ow517lM/r/o3+3OG8xshtDAR4qXcJ/3qPWxKIgIkkVdMRA4iT9JfXcH
	mFTjYwvLbgjtje44iM5lZFP67re6EZFUFsmGNbAdY9fimSeH+sAlTAfg==
X-Received: by 2002:a05:600c:a0d:b0:495:5b02:23b0 with SMTP id 5b1f17b1804b1-496b571dd8fmr84504225e9.26.1785131875644;
        Sun, 26 Jul 2026 22:57:55 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957e334f63sm172689365e9.1.2026.07.26.22.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 22:57:55 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
To: andrew@lunn.ch
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dev.taqnialabs@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: stmmac: enable MAC rx/tx after DMA start
Date: Mon, 27 Jul 2026 05:57:15 +0000
Message-ID: <20260727055715.4430-1-dev.taqnialabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ee639271-60dd-49f7-9e77-0ae47841754d@lunn.ch>
References: <ee639271-60dd-49f7-9e77-0ae47841754d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 18:15:20 +0000, Andrew Lunn wrote:
> There should be a function which is the opposite of stmmac_hw_setup(),
> which tears it down. What order are things done there? tear down is
> generally done in the opposite order to setup, so does the "Disable
> the MAC Rx/Tx" also need to move?

I have not seen the FIFO stall in the teardown in my testing,
but the MAC Rx/Tx should be disabled before the DMA engine is stopped.
For the normal path (__stmmac_release), phylink_stop() is called first
which triggers stmmac_mac_link_down() -> stmmac_mac_set(false), so the
MAC is already disabled before stmmac_stop_all_dma(). The teardown
order is already correct there.

> Same comment for the opposite of stmmac_xdp_open().

Currently, stmmac_xdp_release() does:

    stmmac_stop_all_dma(priv);
    ...
    stmmac_mac_set(priv, priv->ioaddr, false);

The ordering is not followed here,  I'll make it follow the similar
ordering to (__stmmac_release) in v2.

Thanks,
Abid

