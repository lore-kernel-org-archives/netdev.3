Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A702F691D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225070; cv=none; b=HglWNactxgT0zg4zvD+d3X1sDg4e7cag40n6LBmsZ7tgnoLsm6NVZyMqCBdWgkrGO9QmIs9RFiwB2IzHbciOUjJ2RbS4mNuJ4vMkSNyHRPF8q1i8SWBYBWQhTE7ZjIi4TtqZoojbi7QRAXOiO31CVl5tyJ7LCsNyPXPPHblkyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225070; c=relaxed/simple;
	bh=/YjAT+PTANp5RO4duL6E//TuMjIjLHUPGD7hH8q1nCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak4090kVDZ44oWb6DqTT5A/Mii/363VUpqB2Wwkgoql60uzF5NyHU3rhVb/d3sNJEX62+uoyHzwSMrmvR2ClE+Y9KKoEZFXN7Zj0KJwuEwEay99XA5BdJBvC1o/JrpzkHrPYPCIr+r/5hcI25w0OGtWZi6fZaMnFGqqwnlX7Fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPp0567a; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPp0567a"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33fb4680717so5893354eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225068; x=1791829868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6PuYbZh3CSJx/YeySaraDhA8HTOEwlS5gR3oZ9G0OMs=;
        b=mPp0567abLw7JG+WLzGJMH3XRtB8NuakHDzWTv9g5TjEdG07ni23ONXk7jRK0IVOPN
         wWm2WhuxD04bvvttEcwS2+cXKT66WtRkXBzQBhiBhPNRtKpBjop5DTOTEXSCW6OacQSP
         +Hem3A8aBZ68N076PQnd/jY2EvFAb5Tx2usUG/VUpIy2jsfCAXNC+Fp8ll1l9CkhpHfV
         26rD7s+K33w1vZ9IV3CApU5Ac0cR3ntU8L6+w1UWGpv1UM7I2r4pVPvvz6CA+K2kAlBx
         ZnLGzSk3WvqbExEl9rWrshJIwkC+Xs2dN/4TmcGxC1fDEIBbvtUXY7fxgxqnnIPVmcUH
         VWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225068; x=1791829868;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6PuYbZh3CSJx/YeySaraDhA8HTOEwlS5gR3oZ9G0OMs=;
        b=w8xxejSyfkT2fSxFuHgqVDcVtjS/c+anJpo0UmRhjubkSe/lsSAvLCJYPhQsCY/siF
         GZTpbslAEfmiEkVeb9Ekxe9erCSIDbNoguybrOYCIRGHv6QdS4JOWO1oiGROqGPbBfqU
         5ELFKiKht/LGq3JmAiqu7hvZ72LHisxZLTppswrrLC7DGiPxwQMIK32gYaUmQTXc+IHp
         HgqsSbNttDcIhD5nDYOJxsTuSmyGxkvifrm1xyKuAEB4Yk3duEWUxirzwKXBs61mb7HR
         WjsM1BL+lMY+2+E0dDPTfAHFvW4IYZxmzPPiQ2EksFyBO0I1TOtqKK45VJF11WkzdV57
         pbfA==
X-Forwarded-Encrypted: i=1; AKwUvByTGau7mMx/KefVXo7t1gm8kWbeUSDrDnu9oz3l46bB6Ks3FD1XAD6KeOMSDQ5edG+dGIqgIEo=@vger.kernel.org
X-Gm-Message-State: AFuF++miDCezDMrhpytVPp5uROg1zN3O+kZ1io2ghQD1e8kufixynpzR
	xmFZAv/KzocoHO5yY/HXBUoFhYaDt7mZiQV3Xttrp9x5T53n5aJk1wg1
X-Gm-Gg: AYBFou3RWMrXhlUHH3oEUr0/HVRfX6563wB5DE63+7yJ+iyX04UfskEc5HRGmHuN1Mq
	5ntWFkWAihGMhs2g6ohh/V2GMBIXovcTEMHvkeH7A+d7GeB8wxUWBziAKo8sWPoi0ALLDRXn1Ka
	g5XaMOMMJndpcwViCKTNpgbZFYfNdrHYw2EyiTxJphkyUSba41uNq7NIyHHpUGcCm0K2Fbqn07/
	AJ6QifkDHrFqjP/OyU2fscYYoMQ/KiV8sN/g8SGq1tIW+lt8+wQWNBghpb/PNR3hRBcojzL9U4S
	unYN/8zmAPPTfGoPzdSyDU3yrI6vkRLcsbBVWqdkejDkChqRYAatpv46Dr2iNUWbiwHORyBa2IF
	o2pvTbcIww/XcdITTblyV11fS/qaCiSYPuYXYwvQJbyJYALuYkWQ77A4LyRFi+PLB2wERDPHiNR
	VOhY5l5c84kOPLLn7Urcs8EMTujdQ2Losp5R5FS7MUIueNJoDrfDrX9yKZ21BxOK23uJfOgm7zq
	Q3G23azd+guBF/NCN/o5ZtugRhCAEOHIs3xrqQ/pDvEDTQBSOp1Md4VhDkgi4lqpEFz9AhQfePx
	tfHIePU=
X-Received: by 2002:a05:7301:f84:b0:34c:1f07:2d5 with SMTP id 5a478bee46e88-3511162fa68mr10914269eec.6.1791225067702;
        Mon, 05 Oct 2026 11:31:07 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac4dc4sm140223eec.23.2026.10.05.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:31:07 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Norman Herms <dockseed@proton.me>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Date: Mon,  5 Oct 2026 15:30:20 -0300
Message-ID: <20261005183038.417798-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junhui,

On Wed Sep 30, 2026 at 1:26 AM CST, Junhui Liu wrote:
> +static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox", &r_ahb_clk.common.hw, 0x17c, BIT(0), 0);

[...]

> +static SUNXI_CCU_GATE_HW(bus_r_riscv_clk, "bus-r-riscv", &r_apb0_clk.common.hw,
> +			 0x21c, BIT(0), 0);

I'm bringing up mainline on a Radxa Cubie A7Z (PCB V1.11, 1 GiB). With
7.3-rc6, this series and a local common-DT integration, PSCI reboot and
power-off hang once unused clocks are disabled. The boot chain uses
vendor boot0/BL31 and source-built SCP/U-Boot.

Keeping both of these gates enabled fixes reboot; either alone still
hangs. With only these two marked CLK_IS_CRITICAL, reboot returns to
boot0 and power-off drops DCDC1 from 3.3 V to 0.7 V and turns off the
green LED with power still connected. I haven't checked whether each
gate is needed for power-off on its own.

My guess is that BL31 talks to the SCP for these, but I haven't traced
it, and it may be specific to the vendor firmware.

Would it make sense to mark them CLK_IS_CRITICAL, like bus-r-cpucfg
already is? I can test the next revision on this board either way.

Thanks,
Vinicius
