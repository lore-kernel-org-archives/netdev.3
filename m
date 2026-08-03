Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B8305680
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767838; cv=none; b=F7h/+l8GhuYvHh3+KO9beAlm7ftLQ44ApLzjUtQpCG5BQSMkj4K6JBYgLsn7rcMSpjCgbQss9QLMkLPyLSrJr+jWUdKmFyGWQdC+ESYCq0GDIPxGQsCdjHuIUZ/ekHi55S3T0+rOPM2J1ikWZAuKSftmIAQuUMgDoY0IiOOORSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767838; c=relaxed/simple;
	bh=pb/2bJn713F2QrBfYFAcNFUuDl0EojezK6P1ZrrJCpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am2ZQDDziF+bc/ADod+2kp/cOURK6TY6+Eiwv4wbjCpdHFzt8Y7xSx2AS80vfnVSjOW/yNhbFIDXafLIU1gKGTPol9Dqwkp57mUSDLJBYzQkqVaNhpezNao1P1ET2ZO/S146r/+LIVmLOB7TKQv2HeU21nKFFP/DGUGGUvoIQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGxWiYTG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qPNkLhd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGxWiYTG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qPNkLhd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785767836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz+46xoU5Ps+EiowJN5fDiWs3w3cNh/2x67ul7cY68U=;
	b=OGxWiYTG1kvqYwBVsEPBFaJ3527M/4oUsDd/q2Dr+GRJxydw+KQq0Wsp4lx4ACg40SLxOv
	8R7Xbr8UTW0JDeaS7ncvZ7PxStSBvXjJsU5LXmCpmaPRcWXulonxVrdnEyb3AroT/uwWtJ
	1WuFsARYzk13bKJHT2CyJ7U4aeBEhyQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-AMTN60HyNAqSilkGoOw0gg-1; Mon, 03 Aug 2026 10:37:04 -0400
X-MC-Unique: AMTN60HyNAqSilkGoOw0gg-1
X-Mimecast-MFC-AGG-ID: AMTN60HyNAqSilkGoOw0gg_1785767824
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e8653ad27so117713187b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785767824; x=1786372624; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Oz+46xoU5Ps+EiowJN5fDiWs3w3cNh/2x67ul7cY68U=;
        b=qPNkLhd1XpZ6n0+waw7ob2Ef/S5em34NvI698Jkmz3YZNTALwFtdn+jv7MCNcwsFSt
         WmJsWcT1YSUD7IPRF64DSf1Z3iq8lhsTw5pxg2IrrBe2JgjK4F4FgE2gPm56W1k7+ZUg
         upOIjHmOL7XLbSI835Jhrmm2IujcdIAPejKlKoU5se150sZNLn5l2DoWN0nqqwnkgKkp
         4xvNq8J4Z9m4T+NapUV1X8B4ZW4BN4B0qG4RsUOBwEMHDso5DIsXP5CMDEbUsCUcywq8
         n8ta7fMHWVykms7CsaV1HubrG2YI6X2+wFVtX1hru59T9JT84LKsm5UMfEs7FN6N09kF
         Ds7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767824; x=1786372624;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oz+46xoU5Ps+EiowJN5fDiWs3w3cNh/2x67ul7cY68U=;
        b=P1av1/w6QgZuqd1ATmiJ7pw9GurfANeEM65GnC1RsbvqzqrSJTNbzk7Tw+0r84QJEw
         ZJ024VJtty0RWe9Ozmglla4sLhpgb1eFqo/Oxq7dgjML17BUAMurt1YqMAkQrRnzYXrT
         ah2bCBz/j0k8uR2c/AZz3crI91DIvadixNHX4Bry1mE94ISwIPOK2iCLM6gNmiNjieQz
         OuQp7FnUQJ7Ex5ASmjwsYcu8XK82DfAqwM1snpEbgex3ClNYLlC/YHOD7dwa4g3ixn4P
         bR1KCcGsmU2BNuwt12ki2xGay1cxr2RE2It01ekDJZ5Ldzx3zfNZ517UtrIKiUVKaLOr
         Okkw==
X-Forwarded-Encrypted: i=1; AHgh+RqfDZtY2RoWata0GYyWfofZ+zPEOA8y2UzMT63rk6AiVs5zGL57DsEFj15KcRT9R2/xCa1CUVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uJD9qjx3kOfN1YOqXGeZUE/WGdOmE9uhckcHCZmZb0fQVgH0
	fgr/gi+lIJkt4GeSpnoumjfEkHc5Flwz5UEUTvlzhunYGzJfOb8sL5RfOLquGnVMkogjF2NjIHn
	sApn4fb0gGU9jtRoTAWEllU/fS5vD+qAVFoIuVCo2QFyX9fAKVheIf+dBrA==
X-Gm-Gg: AR+sD11Fekxxp4DE21+Ik3HVB7FuNvaNIqEZMuMR81lhiwanm68htp2GtFNcXhvS+lY
	acqw4vt3sxkKD6MrAesAG2fYpVBU/sjYposuEKJYNkrItoFKulgWVCTs17WsMgC4D3dF83gyrOK
	4LEyLJ8j+EUB9if79M2/wZJGqnOlfeI27Fets+pOSJKp3QVC746KJTxz8Iky5Ra1D7ood/4Heem
	zxllehSKziAGew54QIeyg5fmFKWlPx5UxkACnjNCKtToU0OKNM7Eic86xHMOTPajbRSZU00EoKR
	DyVNfvdBHLhxJkP8FDmQcdqLa2w8kLhFV5QDTjPuuI+mFOm4gsfEyIa8wxUoI+9X44FSeXVrz5a
	0JtyDk+RhzWl15owi4uj2lgpZ0fBAeKcqrMc=
X-Received: by 2002:a05:690c:4d83:b0:80b:9f4e:a70 with SMTP id 00721157ae682-81fd4ba6936mr134850527b3.26.1785767824055;
        Mon, 03 Aug 2026 07:37:04 -0700 (PDT)
X-Received: by 2002:a05:690c:4d83:b0:80b:9f4e:a70 with SMTP id 00721157ae682-81fd4ba6936mr134850157b3.26.1785767823526;
        Mon, 03 Aug 2026 07:37:03 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d70besm54676927b3.31.2026.08.03.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:37:02 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:37:00 -0400
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
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 10/25] clk: mediatek: pll: Add BAR reset register
 offsets
Message-ID: <anCnjHectpXOqQku@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-10-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-10-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:20:56PM +0200, Louis-Alexis Eyraud wrote:
> Currently, the register offset to handle BAR reset, for PLLs that
> support it, is hardcoded to CON0.
> On MT8189 SoC, there are separate status, set and clr registers to
> handle this, so differents offsets are needed.
> 
> Add the new fields for offsets and addresses to the MTK PLL data
> structure and modify mtk_clk_register_pll_ops function to compute the
> new register addresses so they are available for clock operation usage.
> 
> Also, replace reset BAR address computing by its computed address
> from MTK PLL data structure in prepare/unprepare callbacks.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

