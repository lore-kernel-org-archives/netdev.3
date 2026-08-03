Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC3411FBB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770628; cv=none; b=FOQ8EKEhyBekxn5hKOM3E1aIWR0oihUG5U2alDP2TYCYfV69UHkITs2uX65fk4J9A6k198KXyeMv5P/Vdv2iY+LkFvtniZR52b6M5pozOxn+g6nclOZEBlrMSNVsPksgRlRyP89SngAERa0+9lIExhkNHSoNsVQfThb74C1mwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770628; c=relaxed/simple;
	bh=OCVftXde3sBO00RpOwzolA/HUS8iy7qx6tDI5+HP70E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhkKnDWucD1DK6ENk/kLlkHgV37WoWEQvaHkOO91P6rOuXhbRFiryFktJvrnTgzHybvC2QDitpo7a59P/RQmAw875omekiLrQ/5OHZRMErhzT2wtFaHXFvuF4/6GL3zbYF8ghTkOldE9lib9pUIgnt5A5rOymDkbmfhActfqHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UftY0Tc8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0eVq3n0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UftY0Tc8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0eVq3n0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785770625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+vZ8FUC6EzJTLpIOuSsz/wpLgYkJ6eDVgEjXOFLrVc=;
	b=UftY0Tc8pKsWLMe5hB5GJQWPGlSdhH5WfSmhRFXcG6hQIPfCe6PaoxV3Lwp2Qy0nl0NGHW
	prjtY5PCl7rHmqPM02m1qXlWv9h7cHheHMOuXRHVWWAcTf3goytE584EQCj24x6yDu0p/s
	s23Gk+NZVGDGyqOWitI2jfaPrG7CXKY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-DmQmIZGePuOn8CFxY7EiHA-1; Mon, 03 Aug 2026 11:23:44 -0400
X-MC-Unique: DmQmIZGePuOn8CFxY7EiHA-1
X-Mimecast-MFC-AGG-ID: DmQmIZGePuOn8CFxY7EiHA_1785770624
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eddfe28b4so116581917b3.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785770624; x=1786375424; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B+vZ8FUC6EzJTLpIOuSsz/wpLgYkJ6eDVgEjXOFLrVc=;
        b=g0eVq3n0IGBZygi/e32CtABKv+7haKjof4XMQfYkR0i/0gzykTEQaL2r0ezoP2t5mD
         5e26HVzsc+sX3Ie8oYJdaehsuzPRxkoWhpIx1LMtX/lu3VttzEfMkJpXE+3h3Lfu2e43
         tZeEnp2IiLBfFbMkGRdvu8DE79x95rfpQBkf4hjRYhhjvAgMUPyleshAPCzJlZg49cHN
         +8g5mokC+H8pvY+ATNyxNiNTyRNXg5sruUN3HZb3ZndUe5Kh2FiYksAk7SH7Oc34/Dd9
         rSjGBhhx/tGRMCy94EHaFIUO0o08ElwRtxshEjijfv+DtPkxrN19/nbl+FTscVxrN+PL
         7KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770624; x=1786375424;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+vZ8FUC6EzJTLpIOuSsz/wpLgYkJ6eDVgEjXOFLrVc=;
        b=Tydp6b5PJRuo2k8HHfPUNFB9Qitkaktc/xCuVvb5wl5M+8YV3nKL3J0X4O5a+LMpgl
         H26c/Um2ZBmHCCJLJdoX8nmXvJ33xG6noxyv1XCGpMabtWguC8sb/C2Ut6XC4kD/nBOG
         FXti5nvTxy7/crtlQu6ldNYE5ZC6scqognNbAUnS444sCYkf+zbQJSw+hxOwSawL0yQe
         tb1dxvAmkDFrNLnTuZL0kvRr30cAShvEFy0v8WebHADXHbs2F3JaHhSKEh5OfGSl2pRt
         OjF4J/QVEnGgrM81KgzBV5DjGArRF8J8ZBNrUJAWtWJuzso9GK/1hrPsZ6SgSpS0z66w
         4vKA==
X-Forwarded-Encrypted: i=1; AHgh+RphEGIhIP0sYKNAhDVO0cXB+yqDkcsiefPTlP1HfDfUSjX9C5dI6upf6JNaMakuLy87sL4p19M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8ujg2QSscBxdMQpBNzRzbisvaFDcX5L9y/LRJRe3hXmPPLeL
	msadUVgIv5fKcG15G07xCScx5DhOGel4ZQu94c6DBZFpdiMbAvLwUw0FSdxJcK1Cw9MXNcqudZG
	5MTeqcZoS73XJuFok+DPD7kYDtHtuFIcigRK9fqimQVGnfz5fEgd4ljjjSg==
X-Gm-Gg: AR+sD12oNpDhaY8MxsIil5T7DDKaIHs9Cku8H8O5IKkzNzUI7hXvERgsGyCDVt9ZjVQ
	3rWpdo26veqNXSYq0d0iKLR8k36/0fgO+Grut3hJoWMRH324pfdwKmURwDLzy9x68hn2SCs1vQ5
	qVooabfX+SBqlEhflO3Hn+oSjoZm3WRkfcTdtq7Lfeh2TeOVSR0VHcHKrOeKnZ+9Wl5c87WJDZ7
	u6tsYs1ZhPc4f1REnlOJVeuXAKsyX4Q381+tk9n8Ni9iGvGwg7WjUiutCXQvLOHBK2cQEFAKZzP
	IYQwY158zk3U3kaOTHx5CNuMeasa+Q8gyfD0WPuNrrjkKMBoY0xfwTEkHesaZqivAn9zrrMs9j3
	jIZJ4gZg08yEn+owMwGVVa+j2VNqOL+55ilE=
X-Received: by 2002:a05:690c:3709:b0:80c:72a1:fca3 with SMTP id 00721157ae682-81fd4a8e63dmr141736237b3.16.1785770623690;
        Mon, 03 Aug 2026 08:23:43 -0700 (PDT)
X-Received: by 2002:a05:690c:3709:b0:80c:72a1:fca3 with SMTP id 00721157ae682-81fd4a8e63dmr141735747b3.16.1785770623266;
        Mon, 03 Aug 2026 08:23:43 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d5ec2sm56111587b3.23.2026.08.03.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:23:42 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:23:40 -0400
From: Brian Masney <bmasney@redhat.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Irving-CH Lin <irving-ch.lin@mediatek.com>
Subject: Re: [PATCH v5 00/25] MT8189: Add support for system and base clock
 controllers
Message-ID: <anCyfAxujzRS3wf2@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:20:46PM +0200, Louis-Alexis Eyraud wrote:
>  .../bindings/clock/mediatek,mt8186-clock.yaml      |  128 ++-
>  .../bindings/clock/mediatek,mt8186-fhctl.yaml      |    1 +
>  .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   24 +-
>  .../bindings/clock/mediatek,mt8188-clock.yaml      |   93 --
>  .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |   58 --
>  .../bindings/clock/mediatek,mt8192-clock.yaml      |  191 ----
>  .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |   68 --
>  .../bindings/clock/mediatek,mt8195-clock.yaml      |  238 -----
>  .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |   76 --
>  drivers/clk/mediatek/Kconfig                       |   79 ++
>  drivers/clk/mediatek/Makefile                      |    8 +
>  drivers/clk/mediatek/clk-mt8189-apmixedsys.c       |  203 ++++
>  drivers/clk/mediatek/clk-mt8189-bus.c              |  200 ++++
>  drivers/clk/mediatek/clk-mt8189-dbgao.c            |   98 ++
>  drivers/clk/mediatek/clk-mt8189-dvfsrc.c           |   58 ++
>  drivers/clk/mediatek/clk-mt8189-iic.c              |  122 +++
>  drivers/clk/mediatek/clk-mt8189-scp.c              |   77 ++
>  drivers/clk/mediatek/clk-mt8189-topckgen.c         | 1025 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mt8189-ufs.c              |  133 +++
>  drivers/clk/mediatek/clk-mt8189-vlpcfg.c           |  116 +++
>  drivers/clk/mediatek/clk-mt8189-vlpckgen.c         |  285 ++++++
>  drivers/clk/mediatek/clk-mt8196-apmixedsys.c       |    2 +-
>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c         |    2 +-
>  drivers/clk/mediatek/clk-pll.c                     |  130 ++-
>  drivers/clk/mediatek/clk-pll.h                     |   13 +-
>  drivers/clk/mediatek/clk-pllfh.c                   |   15 +-
>  drivers/clk/mediatek/clk-pllfh.h                   |    3 +
>  include/dt-bindings/clock/mediatek,mt8189-clk.h    |  433 +++++++++
>  include/dt-bindings/reset/mediatek,mt8189-resets.h |   17 +
>  29 files changed, 3136 insertions(+), 760 deletions(-)

I went through the rest of the series and didn't see anything new in the
last half dozen or so patches beyond some deprecated headers.

Just for completeness: There's still the maintainer issue that I brought up
in v4 that needs to be addressed. I saw the message from Angelo about
responding to that in mid September.

Brian

