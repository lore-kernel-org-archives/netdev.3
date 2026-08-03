Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9B41167C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768319; cv=none; b=mqWPm0Bsv/qm6sXsbBa8uyOCXKhpolCt3mcmIl+ix2NnNG5HJ0Jf0UHIDjATotaVb/odfrulWwTNIQVk1eYMgU2xqlvE7fPCV+l/0pgt1pQHP2BFX+H/Iauq40Vy9eGxyBva/nL2oL8IpF8CDV801EOQyrfuvP1Hdnzmd4ISfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768319; c=relaxed/simple;
	bh=v84q7Nh8J5RnUECRZxODitRYsGNwHdr784yF/3BQaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTnT0sX/GxG+MWKZHA756LNqIQkzKP9NCihefShRqK8tUPeFNQqpT5OIjFPS7H2ti+sbnNKQ5javSVVzNf4xpp5f2kjTdAPNgvPv5UJT6b+AKAKTt9wiZ8jNOlbuSAsKFk53L2VfSCmO1F/KDNzGkC32vC56vgqKUcNcdmFoRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZXzOZCq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHHlwttr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZXzOZCq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHHlwttr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785768317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iDCDZV2asWOBXoCVGWr+sD7YN8hRKRT86USyIoiPOU=;
	b=eZXzOZCqLrc2IW/PLpRD5TryoJmVsoxjM9Vxn22Xo+LVZ4jVJip96zxSX9HLj6LfAiB8no
	JZHnBWxoF281/MnQauE7KuFbsAFssCtz5r7vMyat4+qibZ2bSqQPX9knQ7JO2XIDRisivZ
	batErAL/hAFSnjDY8nvN3ofeBgbr4O8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-A9IAMUQLNeWHrsjEaRYnug-1; Mon, 03 Aug 2026 10:45:16 -0400
X-MC-Unique: A9IAMUQLNeWHrsjEaRYnug-1
X-Mimecast-MFC-AGG-ID: A9IAMUQLNeWHrsjEaRYnug_1785768316
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7fe835353acso53170247b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785768315; x=1786373115; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9iDCDZV2asWOBXoCVGWr+sD7YN8hRKRT86USyIoiPOU=;
        b=NHHlwttrMyfU4HslmuAEIhGVGqOZqZxUPlFx7FevPa6kt/Wt1jiMwhjHBvFRudc1oO
         nnnnYYuo4+1XdjrOKjXL/RmhL4L3nwY0C1mTiZIWEIbVBk0CqnILKs+QteOKRcNIobRx
         prkSbr+L4voXxkXNm8cQ5AHBK0FKMIpxGrtAa7PV21dlq2CyabaIUOSxp/dL+DOYgpyt
         tO8WTjo5/2wZGBwtNjjea9MDyaCOH52JUr6ulbLGGcJW/BhBtXMo6MnGJpZomEKQyaiM
         YoCxH5q5tyviWFj74iVIlpI8Dn/6MA6n+Y8mod1U6FhjVVZM15exoKv6Yzb2eJz46f9W
         0Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768315; x=1786373115;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iDCDZV2asWOBXoCVGWr+sD7YN8hRKRT86USyIoiPOU=;
        b=qsxizyZO0zCzNrFz38vDUjps+epPgNZrLSutoMdRk4uYhxdnSVLi7jPkLWCIriw7yT
         bzAL3xOQLp8iyocBHOHeGW86xkFT9ygsw5bZwHn9vsllHxlm4Zi+qEFv13e0JgbkhOXc
         RJqhuJRUxgmzar29nB2nseRLPKTN0nuFSf6MW0VM3nw20Lk+5PxosdnJLZioFd+v5ni8
         uFaYfIeB7hDiwmtXDpIlsRCdfipKIiVjcGDGDsJUfhgx8dIQRjoocVf2PAcFCjPfceHA
         A+vN0YWvrXEzRPpWmmRW8rp7DfMoAOcNpZWHVcOFezhS1V4QLpFqRHu0S7OTa5FvE/TX
         rdHA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2jtEhUEC9ds7/GBXDr/FPDLP5OCTHYio5MKTwaBkqklnVj6dsKY2lbaNRgEkr1AKk5xv4WFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBB6YrzO8lALLDTsUdY5tEnTgtwIjTW3iP3YBg9v7pRwyjkcPR
	rji3WwmsIe4+2YUjvIp6NQ4go+mdTbqthyQaUt1iGhgSBQhVq2niZwroYMqV4QvhbuNEQ0GaHxl
	zW4jmGFHQanLxPEnKEkM7txCSpnXUM3KsuYEcY59wUTLVmrgzGjzHUDoVeA==
X-Gm-Gg: AR+sD10EdBunlsd878bvTOgLJRD9tTXJO8ivL1FSde5TZMbjRkYdR9j3Gel0cwS0Mcf
	1YXM0OxFygM/SrufXUXeKL2dIHjECz4EO2bSi4GtNDwG2NOG9sxz2fJ8GZyWTqNXXnLiA5g4Jnj
	fGLEZJ+KUZnFfiLIPEUeqGzgzmqi6VwYa0fcXJxsAwThIXDSS14J1T0TDV6OpLZAe+FCoVlZAyO
	CccpuZxQcjCNO0qtuHOEzGDPPVmmoAsCvqCtn2Th11pFWJ+KHPt+yjaPm3dDAyiM2D2IOM8BuIO
	zYN6WBXgY2UMqQvHtDA5SxtFG+HSTVVuQTBBgxLF4WEN1701PKJJAZorkRPlFFP6pz9uVVCkVFF
	PlK1PHtdIP3rSm0NgviLqS6P3G4gFtSbYXQs=
X-Received: by 2002:a05:690c:338c:b0:81e:d23b:f8d1 with SMTP id 00721157ae682-81fd4bf5dbemr122417877b3.35.1785768315457;
        Mon, 03 Aug 2026 07:45:15 -0700 (PDT)
X-Received: by 2002:a05:690c:338c:b0:81e:d23b:f8d1 with SMTP id 00721157ae682-81fd4bf5dbemr122417297b3.35.1785768314956;
        Mon, 03 Aug 2026 07:45:14 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf841e1sm56661767b3.18.2026.08.03.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:45:14 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:45:12 -0400
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
Subject: Re: [PATCH v5 14/25] clk: mediatek: pllfh: Add configurable clock
 ops to mtk_pllfh_data
Message-ID: <anCpeNMp6XQPLU4R@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-14-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-14-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:21:00PM +0200, Louis-Alexis Eyraud wrote:
> Currently, the mtk_clk_register_pllfh functions always registers the
> default PLL clock operation set (mtk_pllfh_ops). This does not allow
> use a custom one, for SoC such as MT8189, that needs different
> set with support for set/clr enable.
> 
> Add a new field for the ops to register in mtk_pllfh_data structure
> and use this new field to either register it when not null or the
> default ops otherwise.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

