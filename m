Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F01353A6A
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790410903; cv=none; b=nqdmVPhxtnSw812LC3gnnFN5klVMydTdmCTZciG1KHl0DUpZfwLk1Lc3eQvbuWzvJ5TxyiaUDLO/eaKwT68EN4AZTddWcjEDMhFpw2RbLmAjq/vOnFLbD4DPF0mO/AokWBcqVvhFk8/sPRL5klpZxGGJPnQrZ/0lXTl19/9t3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790410903; c=relaxed/simple;
	bh=42ncMuF0hJOCZTSNQcVScQZ4OLbQtyIuJ7lJJJTb56w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpm73ufJVQlU3CBJlESGzghDOZgivxMu6Nf6S1YBtmxBpMab6xDZnz2LinN2nuYgx2/uPHhnWedOuFcdqOK65HN1ltpuS5y8RdK5hzqZGSpLeLyDBp8dcIb+pCtOnTH3yuysaL4HC/IPFQyAMCls5dmsbOA6sjtmwQkn3nroNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iipG7UFN; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iipG7UFN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so267184766b.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790410900; x=1791015700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNJvgLaOMMaIX1HcfX+1NsIf1Oi9+zZ060VpifOgBLY=;
        b=iipG7UFNjD0G0tYq/d+GFM9w9c00uaXMi93ftWgJZM9h+NOMXxlwfdlhE1TUCWgg3j
         z13r88YW42qE8mszVRGdtg+PsVWt8NbjFy4EZr1BCaecrXEGPZr8fhnT1y87umdNLOP4
         HL24Yuqzweht6XGSXZCTaMgAeUAy8o6oENZ4KyYAR6uccWQiNrgsRw4ZuHUld+5RdW7J
         jLtnCXlvUxbXTTUJfYeJsYN0GD9Xcj1ENg+OXbvwPiDqSAKfGos+5XfCkkwJb/kTQbAE
         6DGnjKwxXzlwkccHklFtvJ+dAdgNHjOLtQ39+qxSz5ltZegxRFdU4Qjr1RyGbClSqtgS
         DcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790410900; x=1791015700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNJvgLaOMMaIX1HcfX+1NsIf1Oi9+zZ060VpifOgBLY=;
        b=vRkJNkZVt65Iabd8h82+k/LbjxNjGwS77Gs7/WFDWmB8oPdQt7um3M9MyCbZm3irhT
         oM3z8bRZCg9DeH2sV3YLDQMBmThN2sB4bqzUeH6rzyaze55vSf+sxBm8qrGeDT0Y1er8
         nK/6JPSwW74WBu0B0WDFW7RQWW5xrO0MOc5gogh+bKRJrx9we2t+UaPHWmkdg9YLWoxn
         lsHOcN7XN89TVtUm/WwsxMyy9wcfAEqLlSfiDR9Y9J1N+H+K9EEcJM2+i8f6TAPZVqJ+
         YzVatfMqukJifc0dx9cZibdgouEnGHmqiDpvSItxUE7Yp9A+fWTo3XGD15nXLkFWELlp
         1wAQ==
X-Gm-Message-State: AFuF++ke42wyVGRLAOfsRpmOLfYq4DoMTH0Dvw0tsFh28+NAZw4dk8l3
	vhLGJYMlGZDEDCxHP8BMVMGFZLXuUfoYbKGvXFfNAC63a32ga/aFl04p
X-Gm-Gg: AYBFou0ZHZaB/wV0p3j7Z/PkPISSnjohjY60KEHZu+NXijJFxXibe2hoebtyQwU6fo8
	A3zgqQGBPkm2d/TrPrAm3u/t5319xHPq+GW3gvS4I/n0DCNKK4DL7FqRJ6+hAMEiWoumvjwcKHG
	dvfyM1vjO2K18Jh66MlysA1qeePYHpoRmVNXgXZ3i+3AfFgvyqP0lAJegwi8JjAI2iOb7tf4iYa
	jPy+Q2LkQ4bov+6abMubh9C/NV123tl5SDxy4d6osdCMYP6GjbgjAbEWjMP6ZZws9WpLdV1MgrN
	vMwoGhl5J233/iCV04deqqCLXc8bjpyEsbVFlFywqDe3gyN50WnJHhNabsXBGFzMTh+bJgBVKb+
	01KzAqLSF3kCOkKap+PVzOrGTDLDX/yL367EnRUua9d8bwT5Z/2HAPfAJ8GWlodyEHwH0hP50KG
	QFDd4V6/KRQ/JmC1MKfMLH1HeB4arG1nBwKGwWlAXc7/ljvSo0qGWk47CWijP28FO1NLvt/G922
	X/PHKV9zG9oE5NZntnghJcanLUUZYjqGwu4O2w1Tq/bn1T1So65bEyj7CsrmCF4ImEdH3qWSff9
	+wPjWc9LtfU9lqx3nxKMcmpuMWANq3I=
X-Received: by 2002:a17:907:7289:b0:c29:52dd:317c with SMTP id a640c23a62f3a-c2ac24c5d47mr702668766b.30.1790410900001;
        Sat, 26 Sep 2026 01:21:40 -0700 (PDT)
Received: from localhost.localdomain (83-233-221-53.cust.bredband2.com. [83.233.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae735737csm218957666b.11.2026.09.26.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:21:39 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Sat, 26 Sep 2026 10:21:29 +0200
Message-ID: <20260926082129.1632-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch> <20260924234814.1734-1-yongzhao.derek@gmail.com> <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch> <20260925210153.8717-1-yongzhao.derek@gmail.com> <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

> How are the two ports coupled?
>
> Are there magnetics? Capacitor coupling?

I don't have a schematic and have not inspected the board closely
myself. What I have are third-party photos of the Redmi AX5400 board
(board marking M74). A teardown with the shields removed:

https://www.acwifi.net/19451.html

Full board: https://www.acwifi.net/wp-content/uploads/2022/03/DSC_4718.jpg
Close-up:   https://www.acwifi.net/wp-content/uploads/2022/03/DSC_4725.jpg

And a repair forum photo of the same board with the shields on:

https://remont-aud.net/forum/103-124057-1
Photo: https://remont-aud.net/_fr/1240/2027121.jpg

In the full board photo the QCA8337 is under the small shield at the top
left and the IPQ5018 is under the diagonal shield in the middle. They
are a few centimetres apart, judging from the photo, and I cannot see
magnetics or common-mode chokes between them.

Just outside the chamfered corner of the QCA8337 shield, between the two
chips, the silkscreen shows eight capacitor positions in pairs, C548 to
C555. In the forum photo, parallel traces appear to run from this group
towards the IPQ5018 shield. That looks like AC coupling on the four
pairs, but from the photos I cannot tell whether they are populated,
what their values are, or whether they are capacitors at all rather than
0 ohm links. I also cannot identify any bias or termination parts, so I
cannot say whether it matches the arrangement in the Micrel note.

The OpenWrt DTS for this board sets qcom,dac-preset-short-cable on the
IPQ5018 GE PHY. The qca,ar803x.yaml binding describes it as adjusting
amplitude, bias current and error correction for a PHY connected to
another PHY over a short distance. There is no equivalent setting on the
QCA8337 side.

Thanks,
Yongzhao Chen
