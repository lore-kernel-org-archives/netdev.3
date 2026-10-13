Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04E4A0935
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871765; cv=none; b=ruJe8RWfqAmkQ9y0oIzFi4K1+n20Nfv9oqYQXOG6tE5fp0xuIRbw9bJjdAtFGNHUDR4q/OReN5FZpGViOTL2kfTwHnXXj2xr0W/MZjUSscbS5EM7NQDc4lqPViyO6PvUvE0NL3zY5k7wTGfQXVbPGo12HW0o7Sv8nLgFqJOofls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871765; c=relaxed/simple;
	bh=QyA9WEXalwEvaOd3n4YiMQcj5LFG3ePfGKY54JOZEqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTiCBBPXo/V1p8yrr83lQh9mWSJe5z7FaNFuXxn3qEwdwaUM0tMhu7LdIsPhgU1ZZfGvhAkbE1eyPPsHGf9acEMUQ61zEy3A9dOGChz4L4u944fFmlcQujEwFXsWvjnCOKikeKwaOEX441On0Ak6pdrsC52n7w4ufVfhxYXmkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRqkcjwf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRqkcjwf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e831e86ebfso13134025ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791871763; x=1792476563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyA9WEXalwEvaOd3n4YiMQcj5LFG3ePfGKY54JOZEqI=;
        b=eRqkcjwfHuUrgE32sU9+4heEvRJVGmXp6yyiFjzQXk7ptOdXBg9wdCsCE+uIV1SZjp
         PKAvodXRDbJ+juEycny1/JcFwkFRE/TO0lvLZ9nehxZRo0jQUVMEQZ4DaL4VD3Td5PWv
         2Ryl9gH63mW1PgKzbmucjVZC7faAbL4ySZUZHhjk+O+AuT3lBITxzNCqT6pTYVLa6bVI
         Sj+tKpc7Se0V7roNUbmuxQOPNXvTYN8qQQir2KwHfuj+wyxfJFXxxHW4zboyZfYw9Q4O
         4ErFHnbwvCZIpR9T2Zkw0APp8iv8arQxsxiqD4AxUWVKiGFnp968l1Z7hKCu+mH9K5PH
         IfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791871763; x=1792476563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyA9WEXalwEvaOd3n4YiMQcj5LFG3ePfGKY54JOZEqI=;
        b=N5JlDhTrDCnOurH2QoqHjillHCCGig98gYrYp9pgwhuaY0E921+9G55CzMJQPW3t7o
         Pt0csfjuJll+Q1E26P5fiTSxwbrnuoSZjt0gjDTe2oKOP/a4uSUBJLPVWVDZFobK7p3a
         QUREstJLCcULKJ8jYNSgs9GnNK9siVpQoXKi2RC1fJncHoxPoVeygQwTwV1z6ukAcQoc
         yTtxJ/dsIkFKLm4kMRZAJP6RRHsAl5FJVIzKnxlxdm7vZTA8Sf2g7TBy2NwNZooRKV7r
         G57FweA8q+k0lRmV66wnjHRc1SgkomDPiBIh+J9In+Fn15qxV5/UB04Xj/Hg3QVeUj1Z
         3glA==
X-Forwarded-Encrypted: i=1; AKwUvByftMKunG2xnAUm3cGL7EqoFTJB+6WGxgSGHj+KUk2TaQaZkMdmK/h/h44DcHsoRrGqO/2XkvU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdu16f9HqwTceSQ76uxiwAfBkFKGPP2RFZ4oPaUGxYGL51xQb4
	Bb+eOaqGV8r/smtJsALxd/q5v2RfuWNpPFdb7hwmidBVGiyJfOA2EpeA
X-Gm-Gg: AYBFou08lQ/5uCYhvvhHnoCYQs4T7okzg9lpd+5wlePrDDSYOECfkIlnuF7tnkCYjYW
	lW2P/ALrjRDEM0bUTD6QqZZHJ8PHwVoBkS/vMDwVrfEFi0I4OmUPXfmuuDTrgT8lHv1txLJvcci
	QMfU2wbIzUWJHR6iDT0JnsCiY5m8VUHAEWoE0z573zulA+zOx3ALOOyBF2l/Y+UvPBhKCJ+u3Em
	y6mnSxoVmRRa6Kkp8Fr8SGJn8KaNBvl/HeuBDQFLXo8pZd9ONA/Z+7dj52jUawv/ae7XdJBHzpa
	3XoQ+XGvZA8qyAH9cqoFU9ozCldFXFb98GRJK1Rss514j5zzpBCRCstQC67bgO8VxQqvTeWwKP5
	dCb10vhsexVFTwaX+Jimaeu41jMnETKJWo+pCURVhflFqz/F9YeF2YGs7nNTyEaOC5ylWbRNt6s
	axenYg4fgRX0csedeuyKXEPoWBo/VxwpxduHEVUiVf9NiTjBDTqfwFkpRfT0v87z4pPA3Y2YFN5
	usCeRrtgLg=
X-Received: by 2002:a17:902:fd85:b0:2e5:cf33:80bf with SMTP id d9443c01a7336-2e842e14d43mr108812335ad.56.1791871763534;
        Mon, 12 Oct 2026 23:09:23 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:5e2a:b6c:f432:a6f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841432a03sm50770475ad.0.2026.10.12.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:09:23 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	EricChan <chenchuangyu@xiaomi.com>,
	Simon Horman <horms@kernel.org>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
Date: Tue, 13 Oct 2026 14:09:05 +0800
Message-ID: <20261013060905.2777418-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179185976266.2527009.17600570633406382637@kernel.org>
References: <179185976266.2527009.17600570633406382637@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been tested on the hardware device (not publicly available),
a DWC XGMAC with 8 RX/TX DMA channels behind one shared interrupt.
The numbers below the --- in the patch are from that device.
