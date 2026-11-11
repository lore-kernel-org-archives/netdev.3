Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398992;
	b=QHlYng364qp+niD0jZ9mLyaViio4uFeLs9/iY2RoL9rUCfG7M/epKABl9jKb221Ysxvd
	 fZDm8PlTgLaJ8eK/xn64Qr2SWcbzAZ+oZ6jiMMRC+baWeI1J54ZmKg3t6IEwEPDhA75JK
	 bRTG2y++eSSWK9IkUP6iD2aHbuc4l6gBakNPl7V3N/LiCdxjiyO3MOURxtRqKmawsuv77
	 lJ7thPkEv0qzOepjwxWW1EkwWNXGyiT/mm1kdQOivkWj33QDWl2QJ6z79HU/lFYWHcgLw
	 lXGyNr16fYBSxJDI+T1X6WxPZ8I8Rod3gS1YlpU7krzy8fPbmUiPHW10lkeHnRW78xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=8kDTQyiKQOfIkOGO/u8mg2T8m6Y6HEmmU0F0HKV40UE=;
	b=iD8IRm/oxMi2ST2e8m2E29OhMDGkhoTSGBZ+ALf1um8MWoP+ZHIfx+2KxFjbx7R8SYsA
	 T4JBVB53ABB+v/3uINox2qgjzdrSfBy63i7hrbBf3lTWLIVqbbF35J5b8bHZE4yz/F25B
	 Hmz/l8gdvZlEz9VUfTD7PGMgBuyQGS8QOwuRD/rzUi/+z50TPdzT7ZGk6jMlmtRsprbFK
	 CXLQqz5UWpou6f6pfRbDczR8RyJRsg/9L1sVWDxb+w9CrHmIph0RIP9rl75PeLo1ed4lO
	 zLyDLk3Vu20hcYdBGlYVVeUtSx9b989qgfRso6RRplwaRVo/ymtzqaHrm6z8+qVDuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k5TWTw6+;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AA606A89F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 12:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037AA606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k5TWTw6+
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4c5d8c7f326so1214463b6e.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 04:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794398991; x=1795003791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8kDTQyiKQOfIkOGO/u8mg2T8m6Y6HEmmU0F0HKV40UE=;
        b=k5TWTw6+QRchA1PQTS6oYaZ4PuODw3xmmgrU9JTcYXc6nGWjpHL8uSg68S7qe7XTz2
         oeqEBJrUspxe+o629HHec6dg4bPIG+7wI9+glwyPUFF/iYZxZjTqTO9QxjbzGSOjSONZ
         FEjhF/qIMBX10Evv376qVg5lfidCBavTyDN0E5tbzevNXotJVr33CrDxQ5FNkACBc/Y1
         YXS/V0hJ6xz/e7KW2Dh5fsxDh14z4P7rhUrBnYunE/EF2M3y3pNUwpbMvxh40VwgBsCH
         CoyQuMqM1hyxsDn9wzJFA0cbjJKL9dsJRW1fIKpN1mNhQvI9PpYTrdPdKe0qq2X+aJiX
         QzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398991; x=1795003791;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kDTQyiKQOfIkOGO/u8mg2T8m6Y6HEmmU0F0HKV40UE=;
        b=IpMnl8Y20Z8FoezBPYOjQSaNK1+nEVS80PdrY+cA8/cn++8p/WFmEYvM15u60/p6U6
         xb/LqoguAb6n8puy3rP2TE75bdzoKivPfzJW5qVc9vgcICU9M/cFQ8pvy2FQWVSXhPoK
         AFQtoqh3R0Q74e3Mx+wxL5+vRpc+8RG+sntwDDbl9PM7sdyORUsY014msuCqB9LytXlp
         xj4yNkq40GpI6aiBaEwRnlgr67hYbunZH3y6fpWWPtToY6C+GU51eLTeCO2yEPxH2nPW
         8CZkyZicLv42rokiDqVZvRyHTDIxSOZT0jxqLET3Fmp8aOHQsfqizOXI9H3qZZ6wyJc2
         QYLQ==
X-Forwarded-Encrypted: i=1; AL+hErHgiReb/pJYSBgZ3vcttk7sr8J2yUqEdwAPS3psCcqo0uXYfaJMnxJXclj0koCiH6GEcipR53s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VanfQcwoZK7EITzYiDQoKl1LrWKdIyJumti8pzvxz4N4Rp580
	McAKf5gaU8Tewk6xWV1dC2vCW8ee0EeMI09LVB5Pk0XZU1Xes1wGVJLv
X-Gm-Gg: AYBFou0s/69vQ4K+vWCg35ETP4MT9pCq89jX78trfelUtinYB1aszX6wLbOAUI6Mf4Y
	bK+2SKFU6A1iWBy91844QHnrMaqTFBJSRLE5TgL5FhDVvViMUXkydQk+aJXr9Z4mRnE35R9APV2
	YioGlDme8z6WX1vmdgLsd1Qr7t/pA/Ow2Ns7cJtaKSrGS3YaYmHyPrUc21mHjlB4pmfB3zWzrex
	FxGHKGL48E3a44pEp9QPSqsNc15jv24X2ot7VcCyZvm6bg6L9RURbnnzBfn3o3socVw6M5Pgo/n
	6s8L8DG6N090Gk1eKkzA+0yIUaZ4pjbTFWhdvTb0qB2dCgUK1ojzkYvlfX13mGLMw/gxct38HVI
	hRR9OVTEUfz3eKZmrTAJ3sPlbWqpUNh79ukH109ieKgClEgbYVU2cl1mZADjQIU0kTCeC1Kk8DJ
	fvJ1unteBq67mBCsID5S6PqC19yh1C5eEGnOEteDI/s8iVnowBL4HNvFIIFo0YskdZe1qk3P2XJ
	ZLtCOpwunDJ5FNHcsd520Ghf8VFzOiwVF2jUkYE3aYespdhS05om1qeM0JquPpjm2f6jNyCdDre
	pzk2MDiyjpDQ5MqrBiHca9nuyjYb1ZG5qvB38eHnnk9Zr0PzjS2l3wIH79MYmBZHbAv24sB5bOU
	CjnHL
X-Received: by 2002:a05:6808:244f:b0:53b:1d13:dffd with SMTP id 5614622812f47-56b92c464dcmr1457460b6e.7.1794398990670;
        Wed, 11 Nov 2026 04:09:50 -0800 (PST)
Received: from AMD.home.internal (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm4958534b6e.3.2026.11.11.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:09:50 -0800 (PST)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: junhui.liu@pigmoral.tech
Cc: Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Norman Herms <dockseed@proton.me>,
	Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Subject: Re: [PATCH v6 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Date: Wed, 11 Nov 2026 07:09:48 -0500
Message-ID: <20261110-a733-fwclk-junhui-reply@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DMQEUUHANG74.30N8VT6UGHO0M@pigmoral.tech>
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech> <20261009-a733-clk-v6-3-ae8178fce7e8@pigmoral.tech> <20261103-a733-ccu-v6-fw-clocks@gmail.com> <DMQEUUHANG74.30N8VT6UGHO0M@pigmoral.tech>
Content-Type: text/plain; charset="us-ascii"
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

Hi Junhui,

> I'd prefer not to mark these clocks as critical just for the vendor
> firmware. You can see my reply in v5:

I agree that native PSCI and a future OR100 Crust port are separate from
the vendor SCP on E902, and that future E902 remoteproc/mailbox drivers
should own these clocks. Vinicius's native-PSCI reboot report used locally
modified TF-A on A7Z [1]. Upstream TF-A still has no A733 target; its port
is under review [2]. The immediate problem is that the new CCU's
unused-clock cleanup breaks reboot with the firmware these boards ship.

On one Cubie A7S, RAM-booting v7.4-rc1 + CCU v6 + DT v3 and its dependencies
with vendor boot0/BL31/SCP/U-Boot and no clk_ignore_unused, the run without
critical flags stalled at reboot -f. With only bus-r-riscv and bus-r-msgbox
critical, two warm reboots returned to vendor Linux while r-timer0,
bus-r-timer and bus-msgbox0 were 0/0 (enable/prepare); five flags also passed
once.

> Since you've already submitted a separate patch adding these critical
> flags, I'll leave that to you.

I will narrow my separate patch [3] to bus-r-riscv and bus-r-msgbox.
Chen-Yu, Jernej, Samuel: would you take these two flags as a separate patch
until E902/mailbox drivers can own the clocks? There is precedent in A523
bus-r-cpucfg (1dba74abf3e2) and Meson AXG fclk_div3, kept critical for SCPI
firmware until the driver claims its clocks and a handoff exists
(drivers/clk/meson/axg.c).

I have not tested power-off, suspend, either flag alone on A7S, or other
boards or firmware; Vinicius found either flag alone insufficient on A7Z
with vendor BL31 [4].

[1] https://lore.kernel.org/r/20261011200153.575096-1-vinicius.eduardo.pedrosa@gmail.com
[2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/55200
[3] https://lore.kernel.org/r/20261031020640-263f7b05-a7s-clock@gmail.com
[4] https://lore.kernel.org/r/20261005183038.417798-1-vinicius.eduardo.pedrosa@gmail.com

Thanks,
Enzo
