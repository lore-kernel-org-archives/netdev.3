Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D51477998
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394769; cv=none; b=LGfQC9C3kPBE9nnCUe6Qri7qWCPQ15ErjEunwh0EMi24hrJNurPy5z14gM5KQExh1ZT/RP7oJ8RXHI1imoifCWS1sVoF6yMZHJP1/pe8IF3LN31SbMsBOMMJfg5QaCuvzZNXm0IAEtFenNX/mgDQzT0/0HLiBUiclEiPHRnYcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394769; c=relaxed/simple;
	bh=ntRH/yJFT8bnr3NA7fpl1u0UWwgPQd1nw1mxGnJ3x0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG/wpcYJXm9RcGvRyUVRX21f3gaFoC3vGFtau8qN3OdghDBRmNRRziVBiyiUn07haRar6KfE7OEBNzcEVZH1j4n83548UhqNodaO8rH2xdJjBPh/bfp8ENW/Cn30tGnq7FTweBGK4SWUCSr3jPnmbbo96lufgDWel8Wig35OXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5LpRl7f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkJlbGLE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5LpRl7f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkJlbGLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789394761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wHJSL8csboMYxIPrt9fIoOx8qVsPB687MZL7EWYIGI=;
	b=S5LpRl7f7638xXAMrD7Ef1/RnI/eoZwKcWqosBwe/7vmqOQZOKVbFTR58VFSgsw6q+GTLl
	QYEhRuw5fASUgutg/YETlluVJaD/AMfei2mQ6udNPNtH0/Vyh+Gbxng6n3O6kJeY4gs7KD
	B/7/i5C2POUAFa5gQVBHS1KUnG6agUc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-WV0JKJNuPB2dbv_hFaBf4Q-1; Mon, 14 Sep 2026 10:05:58 -0400
X-MC-Unique: WV0JKJNuPB2dbv_hFaBf4Q-1
X-Mimecast-MFC-AGG-ID: WV0JKJNuPB2dbv_hFaBf4Q_1789394758
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a0050a554so546401485a.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789394757; x=1789999557; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/wHJSL8csboMYxIPrt9fIoOx8qVsPB687MZL7EWYIGI=;
        b=VkJlbGLEz32i8yz7Q7ZzUsNem939tZzGbpGPO86beCNzR/mBD1CnhJ/9EYTdKvU9qi
         EQkCBrUB1pRztnpgCoLnASbsQeQZwBKsggMsqmMMWVg6r8lyjNwiBydJgnfEPze0uT+n
         Gt42rzMZ5aObpBUFIoQlx9gVUPcKGRaOMiw/88qCsH/MqFJzFE1kuNEkkIQbQlVxx5Pz
         Idddjbii1BFy7JgMViZ520wmh6pgyaHmFsc9G/EbYhnWskOHsNHCJlA7rTDoOKiireKk
         UMTe6FOGludRzAk/h9j5bDt7TKYHzBEw8rzrUrPXXPaviCbb/BuxgnBGyRFy43mkE2Xf
         hiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394757; x=1789999557;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wHJSL8csboMYxIPrt9fIoOx8qVsPB687MZL7EWYIGI=;
        b=dkd3Gi82c2QhipIUioBiukNFfbUoAHEHQkEBjosjMQSZGQ3bTO+1UvpDGc37TZpcNE
         ztpyvKgJ9FNkrgdHZYnWxHpxhI8Yrzow5hnZB3knrNm4kVwr9DuxoAWfk0Y1SPCCCsBG
         UTESVQCx8qK5wjPgBzJtO54HnGMscey1D/YARR8mmqSo05p8oZ8ygeM+JRMdz/mxFij7
         01E9Xt+2a9rGnQo5+ovdTRXz5XAfPe3Jso7W35i5xb5Cqs366yjFg38yvY31sTP6rxcD
         6boHaBf+MLlMaY28IXx5frd8RomMFRa7wWaZmeq+6w4L61rgv3nt+7KK4bvZEBKX5Yi3
         AYDA==
X-Forwarded-Encrypted: i=1; AKwUvBx/TY2W1QZu138Qsdq9LIFvUHqh759PmmOByuFDtz4IP09E1mGVbGMrKpzzBboTYFncJW6VGdw=@vger.kernel.org
X-Gm-Message-State: AFuF++kJkyaAXyxQ0Dsdq+nVtU6pt37OnmYfWDgPDA+GATm7cP0h4fZ8
	8FnmblWbkzgZwIL0QTeawan2vvN74VQ+f2OJanf2Gnex2wDPbI41AYMOaViPUbkDR2eoOflBIm1
	rog4nilqJh5C1h4yxzYxPfGMaCQMexrMzQOVTBZA5EQJ1dF7oHYP8k5kq+Q==
X-Gm-Gg: AYBFou0SC9KPQdVjWrb/dh9yXQcZO0mQA4m7UO3XrLRG4rEsty6brO8ucmsGJFoeiz8
	LFU5HMT1jquyLfRsW7vFOq7z3CqJoeFa5Pe4fbet/KbPyodpl56TO5v8SmV6yN0Q/67b9XElljF
	gNTbMd3vfPRYpGXa1ryGyBQmCuPibL0XYE3M9if1MgDKbnick3x1vqcvlKIDBG9feQ+q7l8l5Jo
	AebQrumT04GIENYnjGc8hZiCPWwej/3zD1shZIN/wMoX5OVNd0l5H0bqKYlhcCeU7YRmLPPpAb3
	7/eWPmXu3E5b77dhtOc3btORBjbCUqyJBe2bykgMM3oVaGcbkInEZy7K7T9Vm3pmxoQNkBnktUu
	DJsahrF/FPycklgXd4wH4WZSmBwLK+rYbNJs=
X-Received: by 2002:a05:620a:1a29:b0:939:6ec8:6928 with SMTP id af79cd13be357-93a2985d5c8mr389773985a.16.1789394757374;
        Mon, 14 Sep 2026 07:05:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1a29:b0:939:6ec8:6928 with SMTP id af79cd13be357-93a2985d5c8mr389765885a.16.1789394756851;
        Mon, 14 Sep 2026 07:05:56 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ed67a93dsm906151985a.43.2026.09.14.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:05:55 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:05:53 -0400
From: Brian Masney <bmasney@redhat.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: Re: [PATCH v4 00/24] MT8189: Add support for system and base clock
 controllers
Message-ID: <aqf_QZpOIj-170Am@redhat.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
 <amuWdRD-TBQtFT_4@redhat.com>
 <1f6bdf69-c3fe-4e1d-8ff8-0e36d9f4e063@collabora.com>
 <aqf6NH-xrMtCQppv@redhat.com>
 <f2bb7446-bfbd-4598-ba95-d9561a4e132b@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2bb7446-bfbd-4598-ba95-d9561a4e132b@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Angelo,

On Mon, Sep 14, 2026 at 03:48:20PM +0200, AngeloGioacchino Del Regno wrote:
> On 9/14/26 15:44, Brian Masney wrote:
> > On Fri, Jul 31, 2026 at 12:04:49PM +0200, AngeloGioacchino Del Regno wrote:
> > > On 7/30/26 20:22, Brian Masney wrote:
> > > > Should there be a new MAINTAINERS entry added? There's currently 221
> > > > files under drivers/clk/mediatek/ and there's currently only one
> > > > mediatek maintainer entry:
> > > > 
> > > >       MEDIATEK MT6735 CLOCK & RESET DRIVERS.
> > > > 
> > > > Is there anyone from mediatek (or elsewhere) that could act as a clk
> > > > subsystem maintainer similar to what the other SoC vendors do? Help with
> > > > reviews, send in pulls, etc?
> > > > 
> > > 
> > > I may be able to step in, but I have to check if it's feasible, time-wise, on
> > > my side.
> > > 
> > > Though, that won't happen until mid-September... because, well, I'm about to go
> > > on holiday (in a few days from now).
> > 
> > I'm checking in to see if you would be willing to be clk submaintainer
> > for the MediaTek clk drivers?
> > 
> > Brian
> 
> Time is lacking

I can relate...

> , but I get that one hour from me is more than zero, which is
> a good thing.
> 
> Let's do it.

Thank you. Please send a patch for MAINTAINERS when you get a
chance.

Thanks,

Brian

