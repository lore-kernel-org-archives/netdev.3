Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707933;
	b=v9Bjd+QaSuPuGmY15JcKTPJhOI29eDyLgFsUtJQWDwOR0D5Y2tefGyjhxCREnpsipaXC
	 pMMZwEwbA4TiUY2rSeOyKpMJtJmvUaNoGqFa7/qudJHRjanLxZycxq9C+//5fLTliIvFa
	 jywve4ZpGhB1/G1ZvmN5QbO4opfTl22bdatDudRHoPKyjEIWyeWPmfDo46fiXXFviVtY0
	 pt/p7WbLjBo2uO9VLdWHWWuY5f+1t8hIYdWguK+mHQ3yRECY4Mctz2NazB6kNuj8Gt50T
	 zOdRb/Ae/58EI6mtI+vvolRb5mOsWCgPrmQLfw0S7i93HgGP44w4LYRGVbcywprxAuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p7XwenWdW96OgNgWcGPygbhPSyvm8Dmo6vx2RBl2lPo=;
	b=muRcQtbNFOQ3A8UU4wDmrpfkMoQGuVOb8PSMcBdDVTeuMGEggYbQtVE1+U01DxnfPc7w
	 WsofnTP107fsaTohh29oYwAPnIywQYJF7H7Jmao5entTta/kCJ5tVRN/+8qoaHxw6SdSV
	 onm5YvJ3BHuva2h3UXZIOGLwBv5qqELWiROxgbOYpp+V1H5zEUXe3iw6/Vk1OLcaAYvDL
	 hhbgUrj2F88/Dzny4FqtZBCoHvy4VqX+8acZt9KGUHAM59+yK6n2OkavaZ1yqHYMlEKJF
	 1r0cMaT8vxWiYVSo056+EUxbOLyr29nu6vkHtQKVihVuikZeDSwEo1E2DFnQ5O9WHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGkxPCLX;
	arc=none smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4134606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4134606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DGkxPCLX
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so2593814241.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793707932; x=1794312732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p7XwenWdW96OgNgWcGPygbhPSyvm8Dmo6vx2RBl2lPo=;
        b=DGkxPCLX5GXvmx7M8dJnArR00vt8VtdGbHun9M0TeHbmz4k8r8YkOtmJx2Ok4rPPHu
         +IyyaebAkT0PCI9hcq6wWzwfa4+Ir39EyF1hBUB/YTm2aqp/Od1kw10j98TRkpxAOopA
         /YpE4umx9UMpsxEa3EJScBaoG7kCMx9RaFx0J50OYl0Ug5qm1Iu3MyvpXCjT70amlUX2
         eF8iQyRRquy4+y3XIOlPL8Ompve33U3UDw4XHE5tjYNsw/J9X0bTDrlWIohLLzjCeAvk
         g2lrhjn6EqumWcrGC/u0MrminOOvZ+mrLuaBfCngZZajxspfBocPmHuNRO1M1AD2OptY
         aUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707932; x=1794312732;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7XwenWdW96OgNgWcGPygbhPSyvm8Dmo6vx2RBl2lPo=;
        b=dMA7LkmBMVzjiPSub4G/5XGuB4byoARU2SSp0UdVRdyMw76Bwbo666FPL+jMgc2imm
         imnh3+tUZVMRI+x/0tasTKIoJFHb5hC4Ov214j+atXYJx8qLd6oG25+pwoFweMAe+Obi
         RLbHfcpEH81gl1+Wv2H+J2rrM42jY1JkD8cYHLBO2rstSxE7DO+Dqy7nWWi/9jdgq/Rg
         PWbyD4CFqiAkp6aBOvuWelD8bN+sdmKBMFl+dtOWYU9U2OYifsWr4u1IdUaj+aRwlRP3
         w2hsmLd9LkSBhHIBsZQOo2BQqp9GAtQJE467uCdV0yVPQxl7fgaQGZY8Qx/DSrIcCwgn
         P0MA==
X-Forwarded-Encrypted: i=1; AKwUvBza0L1V3vkDSfRTrOEZldFVCDMg7YrAfHmqTppvGDPwPo8k9nBvXZAoaI32kE5g188V/dQ3xIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fNVmPoXwWUwqtWdLa60qWKmG5JltjEfI463lxgtQ61MhtyIX9
	1d4cKdi9gaGtwCqT/tXp2wmEx1wcC0mAau12rOYnKiegyZ3e2UCmkq6a
X-Gm-Gg: AYBFou3xecy7c2neCuUExtVd98ynKuDBI4DCxHlrkbcNTzXjHGHLKkuK4BdHd7JLsof
	XtjpxE7qoXBqlNOiAT0gqGgzE9YqMa7Jk6eVrPlnJwBwbfD/fHyKHaEVwBWHGwCjo4uAkvZpwj+
	vBMANgY3xmSliQQYV2r7E6WHLjzPwiPlbIyquzK5EJSkR0KCZzzByELqNlkWdNEJcGQvN6RO6fl
	nRhPNVxaWTZf9DQ6+23zjmwU0TWjac84B8HA6KZEB+rhXElVYSxAKamiGDuGslPSmDa6o91oq4n
	Lb6Py+FOd8c2fv6vHLPnJzMzORPgdeGeOtzT3mIFpVFkWBkmM8kUX1hb1m2Z84MuKK+FLlz1TyW
	bDkr0UABAOfDz+3wHlE1+adoMU/z9qZUj549ptwzih+yJWb5gzlzNxjb4QhP7UgEbXkI0UxzRjU
	V+oIFy9IvZMJ1UssjuczzbJhxPaO9Ov1PzXzFGIwId7Iuf5tG28a7s0NvJEezM9rJGImW05Qmv3
	sj05ls1IZ5a0vYH5CTdNhvwpUpxEhn9+6D56izVY283M16UkEWTOzEfGDf0jc06fbOcPcHZKTJu
	pjBUdpjO4lcuIuf5+0s6wFkF5cPQYS/aRlW/iGYXcOtbGrIelnu9jkRb/9+fHR2rNEVQiRmn5Pt
	+sWhSRPbb+1V6I5wY5dt4nzDyzw+BjjAbs1Gj
X-Received: by 2002:a05:6102:fa0:b0:7c3:9982:67d7 with SMTP id ada2fe7eead31-7d072670942mr5461054137.16.1793707931886;
        Tue, 03 Nov 2026 04:12:11 -0800 (PST)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d0775a716dsm12606282137.6.2026.11.03.04.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:12:11 -0800 (PST)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
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
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Norman Herms <dockseed@proton.me>
Subject: Re: [PATCH v6 6/8] clk: sunxi-ng: a733: Add mod clocks support
Date: Tue,  3 Nov 2026 09:11:49 -0300
Message-ID: <20261103121149.33238-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <30e43e84-e6e8-4024-b415-dedf67070c4f@arm.com>
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech> <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech> <30e43e84-e6e8-4024-b415-dedf67070c4f@arm.com>
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

Hi Andre,

On 11/2/26 16:32, Andre Przywara wrote:
[...]
> > +static const struct clk_parent_data usb01_ref_parents[] = {
> > +	{ .hw = &sys_24M_clk.hw },
> > +	{ .fw_name = "hosc" },
> > +};
> > +static SUNXI_CCU_MUX_DATA(usb01_ref_clk, "usb01-ref", usb01_ref_parents, 0x1340, 24, 3, 0);
> > +
> > +static SUNXI_CCU_MUX_DATA(usb2_u2_ref_clk, "usb2-u2-ref", usb01_ref_parents, 0x1348, 24, 3, 0);
>
> Don't these two clocks miss the gate at bit 31? So it should be
> SUNXI_CCU_MUX_DATA_WITH_GATE instead?

Yes, both have the gate at bit 31 in the manual, and the vendor CCU
models 0x1340 with it too. usb2-u2-ref resets to off, which is the one
I hit on my board. usb01-ref resets to on, so nothing breaks today.

With the gate added, clk_disable_unused would switch usb01-ref off
unless something claims it, and in my local DT nothing does (the
USB0/USB1 PHYs take osc24M like the A523 ones). On my Cubie A7Z,
clearing bit 31 of 0x1340 at runtime stops the USB1 Wi-Fi traffic, and
after rebinding EHCI1/OHCI1 the device no longer enumerates (error -62),
4 out of 4, while it enumerates again with the bit set. So at least USB1
will need CLK_USB01_REF kept enabled once the gate is added, likely
through a consumer in the USB controller or PHY, as suggested by the
vendor DT. I only tested USB1, by writing the register, not the gated
CCU itself.

Thanks also for your guidance throughout these discussions.

Thanks,
Vinicius
