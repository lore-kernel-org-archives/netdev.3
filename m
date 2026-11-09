Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794200159;
	b=U9jDEZqFw6PQ7MonLI2RBPvMC3ckEWSbISf5aTqWa8EXDxygG7G/j6xseVlGDoFSTNjh
	 2XeW22mLVfqyIWkluPCWmSJrcJyAWgRnJlydWlHLmeax5LtpVRQsjCxrVNT5eEkQvuImh
	 cCxYYb+RKJW2eycU3UEu6ruUzk5tEsn8UuwdHUzRFj9bJWA09/OG+UWvX3M1nehxv/Qb1
	 Yl4ZGR8xl20jX6e3CV3HMocofuqBNwwRgqyloySoXNRuEAlImXI6XOfZDyu3Hx4NuZJC6
	 RaSbF0LP+hyPvTEldcKawqJ6G5NzZz5A2t+RWdKUjxn8YBtsQniuWRd2+SRSN0ECsIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200159;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
	bh=TVjYb4BBcraXHmLMuxAJ4VYWO2AEgU5Dcu295blPONo=;
	b=OKr3grgO6rtK6BtnQXTCX5qbJ0pcMAr8rdWmouCyGE689svuEVA0m3eCRvtEUa4JQ1WY
	 0WECJIucFKY4Qv9h6ODeVYcQZWoKDIRty5/AOabCOa/oroCnKtDthUnXPfWPzUVYomd7r
	 wKeA6NvIHIrfW/f3z4DYvHPwr/8pq043FGs2p6rMVmjdTt9CJAQIRtS5vpkqz3QFJGp6O
	 KVze9l7DVRh/mgFeImwRviRWG3d84DsdDqBMJcKLbC/Js3R2agytSa8o1EgSmyfX45jM/
	 ZOrQJrpU7AXotxexe0oJirVBkjsecHtfcdAjUlh6TYvyBSNuhDYlGeoJ7hwAegybRjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=JhM5iZI3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9660606A31C;
	Mon,  9 Nov 2026 04:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9660606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=JhM5iZI3
ARC-Seal: i=1; a=rsa-sha256; t=1794200117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kgJ06YONRy5PtT6LHHPXY7TeZ2USZKKkLv8VZandB6V0/jYTAD5MvY/abxIpfJJFHvhFWImCLYhTZydSTic0Z01jk7gYNT43rJGqer251Q++Ix2yk2HeUdVCujgY7ckjqQ1u9FFJderC3M8BUeYFhHh3B+5fVMXYF8u/gYTxadM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794200117; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TVjYb4BBcraXHmLMuxAJ4VYWO2AEgU5Dcu295blPONo=; 
	b=JpBUlC2mqu54blu6aDoBbT/qtR6O1cOs4yA9O0dwWCfAC5hfHKXxxVVVWJfoB4yqdA2NQxjl8Ug8RYyhZSgVnQeCJ2gRoi37EChlObs7aDKGX1YWKFBK/Fce/Am4weGpuQV0GXb4GjoDItAkXP4RWME0kT2mpmbgsvCFVtJjpfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=JhM5iZI38onPijDbb/bTo6SBqko9SM8euQYqdXR7Rge9qDB6vu8o53ARCnp9UqaIVhzgBI0Xhj1icaq7Bd+WrCPBNMtUwAjy0+Oc6xUN9gl8IIcATPbCKWj0FOz2sI69wwQoMKuXHh1KUF6gB0U8eHn9aU+LJ5zu0+HSNvQZHu4=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=TVjYb4BBcraXHmLMuxAJ4VYWO2AEgU5Dcu295blPONo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17942001166001004.3701295111581;
	Sun, 8 Nov 2026 20:55:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 12:55:07 +0800
Message-Id: <DMQEUUHANG74.30N8VT6UGHO0M@pigmoral.tech>
Cc: "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@kernel.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel Holland"
 <samuel@sholland.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Andre Przywara" <andre.przywara@arm.com>,
 "Norman Herms" <dockseed@proton.me>, "Vinicius Pedrosa"
 <vinicius.eduardo.pedrosa@gmail.com>
Subject: Re: [PATCH v6 3/8] clk: sunxi-ng: a733: Add PRCM CCU
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Enzo Adriano" <enzo.adriano.code@gmail.com>, <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
 <20261009-a733-clk-v6-3-ae8178fce7e8@pigmoral.tech>
 <20261103-a733-ccu-v6-fw-clocks@gmail.com>
In-Reply-To: <20261103-a733-ccu-v6-fw-clocks@gmail.com>
X-ZohoMailClient: External

Hi Enzo,

On Tue Nov 3, 2026 at 9:33 AM CST, Enzo Adriano wrote:
> Hi Junhui,
>
> On Fri, Oct 09, 2026 at 11:52:08PM +0800, Junhui Liu wrote:
>> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0", r_apb_p=
arents, 0x100,
>> +				      1, 3,	/* P */
>> +				      4, 3,	/* mux */
>> +				      BIT(0),	/* gate */
>> +				      0);
>
> On a Cubie A7S with vendor boot firmware, v6 reaches a Linux shell but
> stalls at warm reboot. The system-controller firmware uses the R-domain
> timer and mailboxes without Linux clock consumers, so disabling these
> clocks as unused can leave its services unavailable.
>
> Could you consider marking r-timer0, bus-r-timer, bus-r-riscv and
> bus-r-msgbox here, and bus-msgbox0 in 7/8, CLK_IS_CRITICAL in the next
> revision? My standalone patch has the diff, firmware references and
> board results:
> https://lore.kernel.org/r/20261031020640-263f7b05-a7s-clock@gmail.com

I'd prefer not to mark these clocks as critical just for the vendor
firmware. You can see my reply in v5:

https://lore.kernel.org/linux-sunxi/DLYAHDTH3129.3AYF0OSHL8RJ8@pigmoral.tec=
h/

Since you've already submitted a separate patch adding these critical
flags, I'll leave that to you. If the maintainers agree that these
clocks should be marked critical, your patch can be picked up.

>
> With those five flags, two RAM boots of my A7S integration completed
> warm reboots without clk_ignore_unused, and all five clocks reported
> enabled. That is one board on vendor firmware. Vinicius reported native
> PSCI reboot working on an A7Z without local critical flags on
> bus-r-riscv and bus-r-msgbox, with TF-A and U-Boot built from source, so
> the boot chain may matter. I haven't tested suspend, or shown that each
> of the five flags is needed on its own.
>
> Thanks,
> Enzo

--=20
Best regards,
Junhui Liu
