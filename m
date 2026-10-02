Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2C37DEB6
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967126; cv=none; b=X2HYoZ4UivIu9v3JPc+OkinHvd91EB6G7iSb3zMskGZ3jXNt8UqgWk/HT80j5dQszeP1hMKgzjaHuGOh0If7FFOANtBSK0AYdfymSIxfRgR1X8etN1rxi/uqg3PzeYLnUdt88i7IvKh/cLrjRrPaLR36li1S3HMWiM5HZPZYqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967126; c=relaxed/simple;
	bh=d+7Dzq3mPeyFPY32y86AvdtMGs9/cR+SwwsFl7j1jgU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=oSuiK+Qr37lkKoSCBCFtrNfRKYn/QSSvHJcheCx0GjmJieXp7o2CY8krM6DybWkEcfAKJE4r084vFwa1dnllirq6NAxWUsPw+hqW2Omujez6v37TYlA29XM5d+ppSBmaqcxJB7GHCqUIv/bonWoTi1cUZxMDzNOlHXaXY9fjaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cULvCt0c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBI6+CaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cULvCt0c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBI6+CaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0MvWYWwsu7LG0V0ETPW58ud5t6tmXACPDGuesfQVDA=;
	b=cULvCt0cs8apdmrxu4txQhDo5LIDOvTG6ohkt8OChz18DsHuvG3AozkhuuRh/fAIihvQjy
	CkQ7yydJ13cwCI/TxJslZSRz9o82nvjSWRwjxKMOxOoT1yhwzs7kzJYy9JylWLax2WHySq
	+wDXwWweSEbEOAXEzwodwqmmpEZ1xrA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-U6H4R16sMD-YKaDAuSVdcA-1; Fri, 02 Oct 2026 14:51:57 -0400
X-MC-Unique: U6H4R16sMD-YKaDAuSVdcA-1
X-Mimecast-MFC-AGG-ID: U6H4R16sMD-YKaDAuSVdcA_1790967117
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caa0ce0cdso368933685a.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790967117; x=1791571917; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r0MvWYWwsu7LG0V0ETPW58ud5t6tmXACPDGuesfQVDA=;
        b=mBI6+CaK0VPmeI3cVu1PU3PD7RbV1HuhM4Ec9Ey+94hWHhmQ/efAt93x0359oUESUh
         o84iWcn2UKdw5BxVdjoZgOTbHoSEJvER33KkdVG9NliIsdF/mye6DY69YecSZctayYiF
         NyGExUQuSOycgO6SjwC3BJ3YJD4c3EzNED8RC4kUbU+lmTrS2ATY1LmulOlxCB6nqVqZ
         NgJ+BQ2y7+q0X/8rX//TRIcox77mTBRYF/dEXkwuCXlv/b6Vt5PoGPffIJfnkiU3F7IR
         Y0zp2pYYeTJJ95af7Rf6GvehD/APSgbDgfh5KzK3R1662lO/lyIT9mzEAe/Ir70TKZC4
         mItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967117; x=1791571917;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0MvWYWwsu7LG0V0ETPW58ud5t6tmXACPDGuesfQVDA=;
        b=26sTyV3KqIn8MUqBBXwNAZECWZA1eTDgT71UeLs1Vu9oTVAKBRysyj5BHegY17Munb
         /PoFJSZfCsHAzD9XyUKKILpGNlciWxGmoRdpKUBw9jgPP1CYX+F+ObHt7r66F5Emf7be
         3MgsKH1vi12L2mm5thj5yol71u2N/wQWZpOZBxGdLOtGPlT9KzAINaHr+osaiCN5yy9D
         OY+vNiWQW269uVyGD7z3L8ad+jd4zqMFmloEggOIyj92x1tJ5r3a7n6m9Zw5pZWwaoNW
         8viGqlCH7L8TBTwQGEqLUHyw42+tEvHbbV/PQXuklS8uMNRuQf5Pw2BZjql1DKeGFHcW
         Ujxg==
X-Forwarded-Encrypted: i=1; AKwUvBxAy0MsHvfqhduO3v1EIzR0zgWWTcFHwstlORbFSfy+R2gRF7VFK2osGzYm/By+MbB9ZAKcblk=@vger.kernel.org
X-Gm-Message-State: AFuF++lG1Eiecs8iqbQhoggEwH1d/DC0WQGIOCg3/FzmESRs4bSVWCe3
	6pdVoiIym+NpA6OZZOMAMcT4N9JdUzrxU7pmZVH5NEycQqa5p6N/hvg9j5fqxAig/M7E5WYXDXh
	4qeVuDnWubpcXCSKA7zdawZd+hTjtUE5aiHH+9NmMOkVFPDn0zjvCwlKfXA==
X-Gm-Gg: AYBFou0nkpuxppKEVtqyJ7aQu71LHd+llEU6c1lcqGrDunm+8YYp3+I3iZC7e4rHuKa
	BhG4djoTNJsk4n2ED1X1txZqD7sn4YKJcLxjrhrXXQBDIklZxix+F5S+8Fd4zrxIB9pcdpZezjh
	8x5cj9aV1/03XPNj/7QtxA8opmqrevKBYXIUBsI1BpEQhTNZKSSNoVWUADuEgBITLE5mIuI3J1K
	T7qyEoYHCOpltVrIZLBkIkI+KF14zY6FUkOLFbo5yr5SVpeJ1U+Gv7HzC2HGToRzHVhr8nPmFVY
	jfaJhv4ilCS83m26ChR0WgC5DRIanh+z/Hy70SzozWwOvN2t2ib8UPsbYaMItQtlNjG+fYC9KoX
	aumtfkWAaXqgltw==
X-Received: by 2002:a05:620a:7105:b0:93a:824:ac8d with SMTP id af79cd13be357-93e5102406amr48503285a.27.1790967116849;
        Fri, 02 Oct 2026 11:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:7105:b0:93a:824:ac8d with SMTP id af79cd13be357-93e5102406amr48495985a.27.1790967116138;
        Fri, 02 Oct 2026 11:51:56 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 11/23] dt-bindings: clock: Add StarFive JHB100
 Peripheral-0 clock and reset generator
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-12-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-12-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707365.821688.14329539857628581125.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=d+7Dzq3mPeyFPY32y86AvdtMGs9/cR+SwwsFl7j1jgU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7Wx/KcQOOltnNfPrdMX3LuT/HC+0e60NpG6lD1rZ
 17q/rvbvKOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJ/DvF8JvNMflnwRuHRRt/
 inec9nG6u3qLz7SmebNcL5042au9L+cTw28Wm8MCxyYbZ0apt67dn7TKUV08XMTt6JZbavvlIy/
 UbmYAAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Hi Changhuang,

> Add bindings for the Peripheral-0 clock and reset generator (PER0CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
> new file mode 100644
> index 000000000000..db43e03fd60c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jhb100-per0crg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JHB100 Peripheral-0 Clock and Reset Generator
> +
> +maintainers:
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jhb100-per0crg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (25 MHz)
> +      - description: PLL6
> +      - description: Configure 400MHz
> +      - description: Configure 800MHZ

There's a mismatch here in the casing of the units. One line has MHz and
the other has MHZ.

Brian

-- 
Brian Masney <bmasney@redhat.com>

