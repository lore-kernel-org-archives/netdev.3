Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669603;
	b=fVm7wEOesiO/XXa9qVui0Pmpg9nHWwbCyxAyITrpvT+CjffX+w4OhwP1JxgaYT+/Y26o
	 6CSbTSlJL9HVIXFEwgNScnaPLN2VB15934fEkACaP/Jo3cPT9aP7ArDJmpriOAuP8tsbz
	 ugsJdr4DdsnZ/9RTWjJVYj4x8ufPBPoat5UVzlfYNlCS6TXFvKTjAQcK9d5CoTi2dA0kC
	 IALyOCZWEms8KegzTVQ5+SGHp/l0L32iGF6GHb99WITE8QpAU+XRSHZJwV5u0ASQl8wfF
	 CtAYIbUVad1bluCTBsN2JBKsHNJjf5p5kiKuryl3YunMO/nlgUS/tMiw3SLAlj3scxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5tRIaiK1TzgUV/taZKqe0e877QKWP8p0z+ea1Mbb1W0=;
	b=40LxLrvsdSCdw5Kun8z6+EqRq3Ity9KjUqY5K3HfUq1NaRzGk21+oz/MDYK0Gg1WeuID
	 Hs1wCF9cKQquW7fT2BL8DGABPhvqCdVY8752M3QIf6PLFLuRQ1etWrrfKJUwhESt6CHy1
	 TzSFi2u0eJBElqBIYXskr6BFEG2aHIfkvixqdETe2ZNzeFXTlfbkaP5BXLlBLMRJGnfS7
	 qvX4rOu04madYIFnrFKtyhR1cXM70kb1VyDqAV4tZwFctPYw9jCZejGsXs0eNoWV+kV3z
	 iGrrzR0rbWYmN9nNJ/fIch620shhxP29q9hb4yb0GsbGNZYdDzVPpbafuH7PnWio3CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgQNLUCB;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBF606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FBF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lgQNLUCB
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53cd0c8614eso27779441cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793669602; x=1794274402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5tRIaiK1TzgUV/taZKqe0e877QKWP8p0z+ea1Mbb1W0=;
        b=lgQNLUCBm2WQLGp42iXbCrYUYAs+Oi1wVQBec5h/3veTVceezeaAU3WIEwWPr+U02d
         2Jqta9KhYiNZ5r+wA66ORykt7/O7EX6mrYjoZugMnQI7BBKjwaiVlvqOwNxSpFc1mjgP
         Ki2FVx8XpKUdDwqV0xTB8ZONiEDPLqzP1RXHyn/vks/Ch4IOszlHvCLUvN2xnAjHDWk7
         P8XZW/UPtjNtT0I0GsalpPdLtMTO5gXSvZJw063l7KglxNmgIGM8vHdEEwyE0YPMMzQU
         Jp2r+69MahJzUyJv/Oe7B5Qpy0VAEJN+nXt9nO0rwgNMDj8fkMFV/odObkF+WgrigCIf
         smsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793669602; x=1794274402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tRIaiK1TzgUV/taZKqe0e877QKWP8p0z+ea1Mbb1W0=;
        b=jJ3dauPDlDg/Y/InwgGLq3b4G8EZ3Yp4pbYfKmfzfffVQTExCw8qSyYcjWX0Y3U5iA
         2e9kzC9348rCUk1mKMF08giSgh2FXxbaV7pZrh/CmDLSzbsW9cBuILPr6POv7Y6LBgU3
         2o3SuDijRgyuF01dL0JNcYxPqhe0pmf1q6YZNQMVqdJ3MRjkLKTnEYZjHTclv1sbbCNK
         WEHv2Rr9+HX62LukKLbu9RyT0XRIUHYWf46YgMYFfruBNmwl4upuxrM4Km7tfgWhJfnK
         Aymjp9Jb1YxKUxJbUN6jdNZv88sOBca6xLmO9aSoTqlzgYUUYIotJSmbrJbCMnc4zqML
         Uyag==
X-Forwarded-Encrypted: i=1; AKwUvByvgxXgn+5x6WBxynkfOWee3dx/+RE21Z4qwjnR8SxWgthuiLxB+XgmT0ThUHUVKPmCgnxoJlk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOxeDE8pKPEw2xLc8ZVcmkhl8/P+WHLSywcbmGmvgjGs3GtHxj
	k2mRh75mQr27VaUNDDTvY7OuBsJ7yS6pIFumr0NFJ7E654f0YBtl6O0m
X-Gm-Gg: AYBFou28UTonvU5HYts9i2aTp5wo7LJEznU0GoDU8dM74z/vY4uiJ7PpUxxcqwQzF7j
	U/8xwA4Dzqzk2wqYE7qTKuMi8JT3h3f2XiWieULN3+EKps897Y8JswZcVkFGtXxZyu8/YH86Poy
	FeX1P7Bdi6EmcRncwp+yrvlNOYQkF0jz5e7SY+8uL9uoPeWKTLvzNJpnkb6Vh0DmLD2NyHDj1he
	zHvqCZRo+kYt1uByUUFvrHnCXTzvkWRmkH3kt4HbMUlx/0qe87sTaegMWYTPqOr+y6MFsUskpZk
	m42q/EzjZfjwrgjS0us9PNPLS2lxdyxnYJp2+21bbpQZHiEipEMjnlEI/1Pj1Gcxwut1nsd5GUe
	TmuA+P3xolCCT9+Khx6IGFCA1Vk5tuvKzmTw4+yqDPCha0ngjJVYz3wQY/2VoyfuRT4SgFHRNiF
	yt6FDZugpDy1oA5g2av1fykV3PVlhZZeQI9sPMWwrGdLNe6Tb4UoQceRMaDehefEAtQRXtI8Y5G
	v3e7w25t+6NrEerS1OE4pRQ99VOb9GPO8BAxTsX0Vxv5/8293+ZJqidqUNEA3ucJR8I45Oai63v
	iLRhUW/ok2cu/wk1tLrvW0ZQp+sAWA1XRiyuA0X031vDBcWQg0/87jMJoJX18PNc/zSFAY9SWaH
	WjDWwdq88xyXS//8IflNooU1urQ==
X-Received: by 2002:a05:622a:3c7:b0:535:5fa:ca6e with SMTP id d75a77b69052e-542b75236b4mr201626151cf.51.1793669602205;
        Mon, 02 Nov 2026 17:33:22 -0800 (PST)
Received: from AMD.home.internal (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cb5b520sm12746021cf.26.2026.11.02.17.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:33:21 -0800 (PST)
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
Date: Mon,  2 Nov 2026 20:33:19 -0500
Message-ID: <20261103-a733-ccu-v6-fw-clocks@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-a733-clk-v6-3-ae8178fce7e8@pigmoral.tech>
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech> <20261009-a733-clk-v6-3-ae8178fce7e8@pigmoral.tech>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junhui,

On Fri, Oct 09, 2026 at 11:52:08PM +0800, Junhui Liu wrote:
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0", r_apb_parents, 0x100,
> +				      1, 3,	/* P */
> +				      4, 3,	/* mux */
> +				      BIT(0),	/* gate */
> +				      0);

On a Cubie A7S with vendor boot firmware, v6 reaches a Linux shell but
stalls at warm reboot. The system-controller firmware uses the R-domain
timer and mailboxes without Linux clock consumers, so disabling these
clocks as unused can leave its services unavailable.

Could you consider marking r-timer0, bus-r-timer, bus-r-riscv and
bus-r-msgbox here, and bus-msgbox0 in 7/8, CLK_IS_CRITICAL in the next
revision? My standalone patch has the diff, firmware references and
board results:
https://lore.kernel.org/r/20261031020640-263f7b05-a7s-clock@gmail.com

With those five flags, two RAM boots of my A7S integration completed
warm reboots without clk_ignore_unused, and all five clocks reported
enabled. That is one board on vendor firmware. Vinicius reported native
PSCI reboot working on an A7Z without local critical flags on
bus-r-riscv and bus-r-msgbox, with TF-A and U-Boot built from source, so
the boot chain may matter. I haven't tested suspend, or shown that each
of the five flags is needed on its own.

Thanks,
Enzo
