Received: from sender6-pp-g123.zoho.com (sender6-pp-g123.zoho.com [165.173.180.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3AD5B206;
	Wed,  7 Oct 2026 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344145; cv=pass; b=SSbeQ84WQuLAKnmprhCtqyDh20JNny4LenTg8Ed+35C5e4b9qM9lk5SK7EgCMo9YztNXhfcvXSe3NUzWN4U4EGkueylGgoYOqZzN9XRhB4jg7X//ybnOdRT4lT+lASK06ILCgzSoEG1wfaDrkBJZzwc/jiR7WBQ0PA2K9yLggf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344145; c=relaxed/simple;
	bh=tT28eRbBX/xWqcGm7Vdom8PM07D1NYc0Wz80OC3tjzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=u3oVNeZPw5KD5x7pkNTXG0wIu7beprWrnY57Gmv0a5JvRQbeAnID5GsdMA3FxjVArzoG6TZ1rP3GEGsmQtAhQLMDJzPOL2v1xZ81EtBSwZeN5sus2wECqcaTaAG3Lp8eZ2M/yM+6KQL1IAUfB9AUc6cKeRgDhV4y4qejSHYE15I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ngjjKCMT; arc=pass smtp.client-ip=165.173.180.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ngjjKCMT"
ARC-Seal: i=1; a=rsa-sha256; t=1791344101; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EMt2HxZjGxKqN3KMja356Ejlm4RJ3ba7GuoEX6EUHQ11KKvVi/AlTLXrVwZkxPQFoHXC2LwGWUjI5cwh53QZConfu700rGSNok0yINxejDfgC4WPDw5S0pJqMo6zSdJiN0CpO7ReMGrXY/KVAefrmvMEFgrCdz1MsMrReBIMc90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791344101; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7EEv66TfkkqDC0vBD6k5R4XJT1WUveDu+xqFWjFMwS8=; 
	b=l09IKvPiFoQMX2AX3F1fOIWVtTXZREcVQyzldMWz0+tZ8xOSQYyblRiDWkWmxg4EZ5zBLoXBv3b9B0s6Z0q2Fny0MWidmzBKZsDWz4s/sdjCyBYR5a6VNIQn40ecbW82JoQ9oCDbnNvyOF0d5ymxtqwYHoXTK3mqdQn+11WsUOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791344101;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Cc:Cc:Subject:Subject:From:From:In-Reply-To:Reply-To;
	bh=7EEv66TfkkqDC0vBD6k5R4XJT1WUveDu+xqFWjFMwS8=;
	b=ngjjKCMToI6FGmexYDJ/b1KiQmPlOSMsEgTrZ1Bj27Cu5QVcCjFprimUKNkf1sYU
	A5Bksc5nvWbdRiJ5nUGNCEssIHzFQgZ9YVyrNw6nk+G1S4Q6xuauG+CvM6kkgkftsNq
	RzjUMpRmbx+tDp0XBw4HCwVTxhtGOhNEnUh06Anw=
Received: by smtp.zohomail.com with SMTPS id 1791344099855931.7368458013717;
	Tue, 6 Oct 2026 20:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 11:34:49 +0800
Message-Id: <DLYAHDTH3129.3AYF0OSHL8RJ8@pigmoral.tech>
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney+clk@redhat.com>, "Jerome Brunet"
 <jbrunet+clk@baylibre.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <netdev@vger.kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>, "Enzo
 Adriano" <enzo.adriano.code@gmail.com>, "Andre Przywara"
 <andre.przywara@arm.com>, "Norman Herms" <dockseed@proton.me>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
 <20261005183038.417798-1-vinicius.eduardo.pedrosa@gmail.com>
In-Reply-To: <20261005183038.417798-1-vinicius.eduardo.pedrosa@gmail.com>
X-ZohoMailClient: External

Hi Vinicius,

Thanks for testing.

On Tue Oct 6, 2026 at 2:30 AM CST, Vinicius Pedrosa wrote:
> Hi Junhui,
>
> On Wed Sep 30, 2026 at 1:26 AM CST, Junhui Liu wrote:
>> +static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox", &r_ahb_clk.c=
ommon.hw, 0x17c, BIT(0), 0);
>
> [...]
>
>> +static SUNXI_CCU_GATE_HW(bus_r_riscv_clk, "bus-r-riscv", &r_apb0_clk.co=
mmon.hw,
>> +			 0x21c, BIT(0), 0);
>
> I'm bringing up mainline on a Radxa Cubie A7Z (PCB V1.11, 1 GiB). With
> 7.3-rc6, this series and a local common-DT integration, PSCI reboot and
> power-off hang once unused clocks are disabled. The boot chain uses
> vendor boot0/BL31 and source-built SCP/U-Boot.
>
> Keeping both of these gates enabled fixes reboot; either alone still
> hangs. With only these two marked CLK_IS_CRITICAL, reboot returns to
> boot0 and power-off drops DCDC1 from 3.3 V to 0.7 V and turns off the
> green LED with power still connected. I haven't checked whether each
> gate is needed for power-off on its own.
>
> My guess is that BL31 talks to the SCP for these, but I haven't traced
> it, and it may be specific to the vendor firmware.

Yes, it appears that the vendor SCP firmware runs on the E902 core
instead of the ARISC OR100 core on the A733. Disabling either
bus-r-riscv or bus-r-msgbox breaks the SCPI communication path between
TF-A and the SCP firmware.

>
> Would it make sense to mark them CLK_IS_CRITICAL, like bus-r-cpucfg
> already is? I can test the next revision on this board either way.

Mainline TF-A uses native PSCI for reboot and power-off on the NCAT2
family. Even if Crust is ported to the A733 in the future, I would
expect it to run on the ARISC OR100 core rather than the E902 core.

(Also see discussion in [1].)

The E902 may also be supported by the Linux remoteproc and mailbox
drivers in the future. In that case, bus-r-riscv and bus-r-msgbox
should be managed by their respective drivers instead of being kept
enabled globally.

I don't know if marking these clocks as CLK_IS_CRITICAL just for the
vendor SCP firmware is a good idea...

[1] https://lore.kernel.org/linux-sunxi/556cd32394062960a3ea4af0011155cfa83=
ae91f.camel@d-silva.org/T/#u

>
> Thanks,
> Vinicius

--=20
Best regards,
Junhui Liu
