Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3E2EA75E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767579; cv=none; b=ecFFVQ6PrSp5xFsBRodIB0VbZCnnoOJkrU+VI6uOWoSjmUEYzDq6nsfL27OS5pNxgkWMteTp7Uoh+2+9sTZL8p5DmEToxJ6gBtjn+sa1eUnZqFpRgGTA/7p+eA/0y8Hhblo7DIcUNJpco1K665UCWDRmuU9LEsEiPpWXKMZYMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767579; c=relaxed/simple;
	bh=YZJ61eFfvReBupAod2kvWhHnn4QDKxkEAslDrdpHu+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLf9JoeL4nvXPo3GZIBwtRsGLZP+7b0IdsH3yAw7mXhgdnUpwe/A5cXi1JAALMY+5Zl2eT1jqyhetikaUmUHvWbTyqO/rjHq5pahUQJNWj/I8ilZ2r0gJYe8Im5K/k8r96aIvv8Bnp8GuBAHHvCSEVEzMYahSZSqesTGiBpqzIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Du5Tdl1h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJZWs059; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du5Tdl1h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJZWs059"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785767577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76NPEec58Tb1M0PywXo7lghUl4mVI11dXUa8hA9GYgI=;
	b=Du5Tdl1hQs9hocW+YFIKliooHdDOtKMvPseKqHpEYNXWRu2QsP40Hb/efywwv0l/aNjnOu
	SvRmVpnSUOSPtYc3/GE207l5CHRTuT3reu7zO5HvzxwWqhMtoOuhh8H31t1DHNdxmNorGq
	sLjw23eExOKugDVLQ8szSh0hoymoqUA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-lOHEMpjJMkGWpAczjd7JXA-1; Mon, 03 Aug 2026 10:32:51 -0400
X-MC-Unique: lOHEMpjJMkGWpAczjd7JXA-1
X-Mimecast-MFC-AGG-ID: lOHEMpjJMkGWpAczjd7JXA_1785767570
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6648d902a6eso10239337d50.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785767570; x=1786372370; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=76NPEec58Tb1M0PywXo7lghUl4mVI11dXUa8hA9GYgI=;
        b=HJZWs059adXQo0/7pqBwTn1wQZodkTVa5YboSb51o2+1DQzOUgeDmXgsnrizmZevM0
         rZloB18lK3wnnJ4ZEOYMOBiZLyJI3JDv7TrBkrjbNDR5wTul5rIABIJ3OBA11UjB0URV
         bNb7DBWPaZuUjbaLx81mtZLTY1DniySny50HPWdyNBav7P19F06+5xu9dDugIZPjc69W
         76FcMPoJJH4nB269lW2r4l2Lq1SjXRHikYmDN92A/T7ALNVywUDbvlNGATOdM5oPx54n
         UJEDEzh8+JwtncInVmbk4S9bmbjpZqfZLK8DUrDHsSih8IsHP9iFGLoU256OuPc1pl8o
         Qk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767570; x=1786372370;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76NPEec58Tb1M0PywXo7lghUl4mVI11dXUa8hA9GYgI=;
        b=ASQofL1gm+JJhOohTpACo+NbocGSEtZjHD9esjucpNXAYTn9hELbCXCoLElgdOy0ef
         C7GPN9M5Qj76/xtcrcTaHVg4pCj+NyeRSr9RQdl6U63Pj1C576mHCjAO8iwe0xjAkezl
         Q+pu8j1TCeRJgEK9ZguV6atZg64ccYdpOe67xzFcpNNuGJ8mO7M+7y5Q3CFYy8uB1W0D
         eS2bqGc2H9ea1AABFuxZ7luJK3/NspxLNIcS9grLc9mW8Mp9dcsnf2ZcEOEAh8m5phZn
         1/vz/+TEDzY05q4mHNYT5++MNRCQ+A6gLgZ3goTuadFK/Tbkp6T5SDMDfR33A8mQMORH
         LxJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIjJ2HsnZI4i/Hkg/Fz0pCkxSf/xk66e0QsE9E8LkITFvsQLNNhGcHRHZtTwnKvmR/iFeolpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnqZ+cLb4vRmMz7BLB//DZs+Vamz2ZjfkuviZlEDEvZ9MM6aC
	X5vjp+cbhQSPF5aTb8Vivt5+hIcfjqX8PNdVxlGWIxPAmXIBRte1OKobaWbAXmdf5IVIZDOrdBa
	Gt5BjEam20foDCLsR+OynfOWtAnM0O6+2jDHoShguGq63bLPUIib6702Hkg==
X-Gm-Gg: AR+sD10zdNhNWFqwrhkzi+EebkjZccLZ6AerHHj5HaXBqaaH0nJ2PxJkpDHRxL7yUAL
	QY6yhnGRjZTNmiSw8FmcBNwjCa9AC5/cbqvTa6aIErfeoODy1gXfKzuAiHUjxGo/slneh9XllCi
	RdDDZiGq+CTEmNeHUxq4CMQS4tzfPworUL0b5q+rDVOzTRJF/1VEIUsCXISnvnLjz7cufNoX17I
	Fvz87ujfz1n2bJDNVCxG7C2S8apU50+Ly49OJQHeTfj+3CctBCnh8CZQVtAW5LEi7T43+npJnE/
	2sj5F/1pj2TBEQo07pTAza+knGHX0d8yC5nlEp56WWL6p+ZgycO6zeuVVNacFDwwOu6niRct8px
	2ojOUaX80nzrz+kkOJfbTVHxemoj848wcCz0=
X-Received: by 2002:a05:690e:43c2:b0:666:2274:f9f5 with SMTP id 956f58d0204a3-6694f1d38e2mr8779918d50.37.1785767570651;
        Mon, 03 Aug 2026 07:32:50 -0700 (PDT)
X-Received: by 2002:a05:690e:43c2:b0:666:2274:f9f5 with SMTP id 956f58d0204a3-6694f1d38e2mr8779869d50.37.1785767570090;
        Mon, 03 Aug 2026 07:32:50 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948ffb54bsm5747947d50.17.2026.08.03.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:32:49 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:32:46 -0400
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
Subject: Re: [PATCH v5 09/25] clk: mediatek: Harmonize mtk_pll_fenc related
 symbol names
Message-ID: <anCmjnAVH1MRkNUS@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-9-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-9-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:20:55PM +0200, Louis-Alexis Eyraud wrote:
> To prepare for the new clock ops set addition, with support for set/clr
> enable logic only, rename mtk_pll_fenc_setclr_ops and its callback names
> to harmonize the naming with the same suffix.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

