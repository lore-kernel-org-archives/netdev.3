Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50E30D3F8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767967; cv=none; b=HgoF320d87AG9yc9MVQaO9rFPV+plWT3RkmKR8ZiBjqDD1bNMSIb0vAGLsG7J7LmrWMcZVUCSHPqRdWm1Pyfixci+STcycfjFHbjSv+2PUMhosvyZrEblnYScV5PsjmHhwKn8Bh/BbNAOYJzooWpCspYomRGo/vnzXSi5fDRkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767967; c=relaxed/simple;
	bh=DhELizj98R/lR2a2ctjeOkiNuCTenIyitx+zvL/TJvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF4l/zEFcPhDJQJ1Vo1b87GcUtzMG/FoJegVv7UkjksDThcxsbq6NcjPNKOwnjEdvgqWZxmXeuVyXyYX6CpiO5sJC9Yx1lh4YEJSb03rJ3v6RHmiIrXN72g/dLp6aUpXVLnngz9kaiYazhrL6NEvVOyHSNyBMvmtL/TLV2DN7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIPgeP/b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5X0jC0k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIPgeP/b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5X0jC0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785767965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JwikhXmMiyptngbwEJz5XWlF1hdjeBqdvWFYDWbslQ=;
	b=gIPgeP/bUTuNWfnBbPqTnQim+MKK4kZeKPqaYqr7CuNTh+0nI+OfwaEDKf8hCNZo3GyjCs
	ruAKnpp332GLgPsp4m9ZfE7Ld+hJhY64iZXRfxI0rxiOsNISRSOuTs50Ra5MfTZxPm0cTj
	bgRJ0btBUpMrUokJksQG9M5eoVrKS0A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-UutJMjR7PcGaBgMeJPC59A-1; Mon, 03 Aug 2026 10:39:23 -0400
X-MC-Unique: UutJMjR7PcGaBgMeJPC59A-1
X-Mimecast-MFC-AGG-ID: UutJMjR7PcGaBgMeJPC59A_1785767962
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e71be771cso121686537b3.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785767962; x=1786372762; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/JwikhXmMiyptngbwEJz5XWlF1hdjeBqdvWFYDWbslQ=;
        b=Y5X0jC0kZM+YgMQJHcgPeeEFyoRNjuz4ikW4QmXO73vOk07H4TUI4V5tSywgIE9wM2
         TcYtkwQC+sTm7etUem9SetLS5T1RWv7hCf3l1wJNarsHkZvTIm2ikTvdd/QiEXFTmqnO
         C72b6vJbBAjkeYY4IMUJWm4on8PPaKtjl9T6E4VvcudmynIfORg+XzxBCG0zBD6D64tn
         W+ao0XnS/7rfGVu5j73U2XQhVDEbyWrHoGFdJeC7qJbmDWAPBj7hR9Z1t3Pc/6y0Uuzd
         8MouKok1H3Zmpxp5WBLdihmsTQevO/MSfI/1h5ADl3HmiKT6CxH6MKsYaTu0+CDTAAwx
         vlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767962; x=1786372762;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JwikhXmMiyptngbwEJz5XWlF1hdjeBqdvWFYDWbslQ=;
        b=Y2L7bjV73cjVsn9+zW3nOg7auUVij+gSPyAwF1jcGzk8iaFHuGuizo/7eMyDbNQ1Vl
         8fD6H8ubCTsPpDickeRnUi/q6KzROPYPJst1xkjsUwDfsCUAOji71WGzTi5rf9Lplyqa
         Gw0uW1cGasoPuY+CodrlWyTqNGgcvPtv2jFLMlmlYNmLsMmkIFsEX8b3hjFrLajWPjq6
         4LejbzoRRt5GVjtXAgr4fe1Kk64VIpHh3dnKwljlpFvW5vuMM/zFbAMfpifQ0VE32YWw
         uIHUeGLZ2QsnwlysvZIeKXrf3DEoyreci4AzjawCdHiZ+cZw12ueQaDTaPCrIrjiW8Cx
         U/hQ==
X-Forwarded-Encrypted: i=1; AHgh+RoG+dgWQVN3n9X0ho6Qhl0GuO399VpoCd0q+9UuR86rIDylHE9nNeFXR7DrdyFqyDR3Yn9wOtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Jpnw45DKe1v4ODYfKt7N+2BEJ2HJqjD9Bo0aT0STTy/XEfF/
	26xK6EmBgA0gCMivKsT73zeblEIQtTUiw+HCCJkf8aK08+4t/FuYhNqiCil3MbLw58RKBz0sJ7U
	Kvn6Y6a2VRq67u6A9DwpNueIG7ZMM4qtGZUHJgY9J2YmEg/FugxVyt9Z9Yw==
X-Gm-Gg: AR+sD108bStchHY+1qMOxjd+nKvp/3gxodgscOz0q/lrgNlp2g767NgarlpqF/55Mhq
	YQAoFG9ZHduGOthUPkqTnhtHvXSGuxWTukAB6kKikbaFSktpn6EmHCcvapCT8iAAjun1aw7k6Ug
	I0W3qCy5E6tsrr+gW/j9o769OC75JG0q48Y2+xpE06CzPFidEnC5B/zgCtzxY4+HhJWeM2etZO2
	e0gwz8zoRvjnCzvWdUxjYpXFlarZ4M6m10/L1dZ+MdEGaBWszr6M7h8tBgEKo9Qg7xnfNFcgZe3
	lvhF28Gz1APdHJEaG/nRqRiSZEt0bNtAqfJeb5X3/daNrK+oOmzZ6ydGztqv67IGEdvKZBspqM2
	hy+Ca2bMBCkfWlodoaKketTcEgNTfIEBmTrM=
X-Received: by 2002:a05:690c:e3c6:b0:81f:69a:3739 with SMTP id 00721157ae682-81fcbd4e504mr154831697b3.18.1785767962426;
        Mon, 03 Aug 2026 07:39:22 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c6:b0:81f:69a:3739 with SMTP id 00721157ae682-81fcbd4e504mr154831257b3.18.1785767961867;
        Mon, 03 Aug 2026 07:39:21 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf9555dsm57109317b3.20.2026.08.03.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:39:21 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:39:19 -0400
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
Subject: Re: [PATCH v5 11/25] clk: mediatek: pll: Factorise pll power on/off
 sequences
Message-ID: <anCoF9SJ9nDHqaa5@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-11-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-11-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:20:57PM +0200, Louis-Alexis Eyraud wrote:
> In order to prepare the MT8189 SoC support, that requires different
> registers to control PLL status and perform reset BAR, and so a
> different sets of clock operations, split the pll power on and off
> sequences from mtk_pll_prepare/unprepare functions into private
> subfunctions.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

