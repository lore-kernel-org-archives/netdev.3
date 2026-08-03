Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264941A914
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768389; cv=none; b=qypnLhvsydgD/isGV+DL2NX4ydeDFC6k6pEV8+7TNcpRZzJylp6wrCswM1T8zZK4acEXFw5tjL496n1JJzLAjvli3TvpPQbX5G4/6lOwdTwLU+m4kFV9rRsX74PtIOdnuU/ft7Xxs0jFu8hkIpELjWshq2A5sqwJ62Z2ThhxnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768389; c=relaxed/simple;
	bh=IHJ/yuYFJFmwqLHp9N/Jmi/pCQSvKzfbgwSzSkQuZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkLcwoAheHy1f9VtkNTc6PltQDWIQ3a6SZy7ejCAmEdf2TQlzSxfbXpAsNvPn4ck+SJpbxRBJ/trnE2FO8sbNEb4OZSo7B9kpymv69+zRrNoqCaTPVPytkynbu2p7OmhvrwLlJKO4yFHqUvxIagVRCWaK9dGtykGdHsMGekInak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrlQhXF5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5ADtsE/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrlQhXF5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5ADtsE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785768386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VF0Hp4wXirEtYNRHmmEHQLkJjRzPvWFm3EoPuJFZJNc=;
	b=XrlQhXF5akzITkbHHXFOmgybz3ff4WE2owvZ4nQnAylwZyHoy1MEVN0ztn2Fc72ZL0mb1r
	7DzNYQdZovkDvI0f6z5Qk1LzNkhhjBdvEZjdl1OwtuRTal+zXAHM9WX6faUcboKv9JQdJY
	Txju6ioPKsdc05HbpZqkzD1RvT5qfzA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-mZZGrpLSO5i89lpo23r_gA-1; Mon, 03 Aug 2026 10:46:25 -0400
X-MC-Unique: mZZGrpLSO5i89lpo23r_gA-1
X-Mimecast-MFC-AGG-ID: mZZGrpLSO5i89lpo23r_gA_1785768385
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e85096e65so77070557b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785768385; x=1786373185; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VF0Hp4wXirEtYNRHmmEHQLkJjRzPvWFm3EoPuJFZJNc=;
        b=a5ADtsE/yz1IpT++o2jFDRWump6ECvj1ch91KYIiBHbXchfrQxjvmPYw0Xu2E9zJ8p
         DTjPkcn//Iig5IwhkxqvP6hXMjoFI1I9M3/gOfMp/5sGTr2aEYREJm8RGr+nURB8wTcm
         P1rOEKFWrgaTBE7y8eX8RLyYWHwrLB9AnH9hTtZ4KOvovbgLGlmGh2TuLRpboLLHJLe+
         mOQfa0GkmfKOqTo7LVF6N+e9zBLmiaxpq/eSz6rz8yW6wOcji/F63ljnAEYHpt4sF2V4
         XeT8k6XzXHpgNIXTqAI6jKTtb6917Dauz/OB5PNN9UA9PKhGEqGK7ww8wd5tEFtpWaTm
         hUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768385; x=1786373185;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VF0Hp4wXirEtYNRHmmEHQLkJjRzPvWFm3EoPuJFZJNc=;
        b=ZhyAzwUOIjbm0qyt0P7+8e8oIqStyazdEGIhI/uOQLcc7UeyDyJNk2tZVIjllckpV4
         cAj1ZBT7y4ftELoQ8dUY2YGGwIip9qXnCUncD2FVzD7/PX2LZ17Qx2KEzDFpdBlRxcNt
         qNWAT41H8hjOYkCcjhEOOcumSLgHUeOUTXjkRgCiKViI2Pv9Q2CUVpXfOvx3yUM8sksv
         nOR08XzNautD65JKj8+tFq4v+FtT8MTfLWlX1QaEYUB9NDVYwynIrNL5+GRt+BxISC3j
         nyoNaQtmzf2SKQziuh0k50PWhNyfUb3/G3jHl81x/9/rTe6XcQAaKAWRzGa4tPE9AEnv
         eoSw==
X-Forwarded-Encrypted: i=1; AHgh+RqFGazZ0brWG8g0O4JfYb6NcrmFyS9Yo+86stv26dC3M6DkbEsi6ciX/UA2rdgc4i/RvNsTKfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC4+1rWce+M4K0u2nhWyPgpCcTZKDfo7qbnZ4AN2AjFSkvCFS
	hhY4OV2M0E+XYOfHFmjc9mGvfp7udbug/WjyG2TjIKe8nApDc606zHPMrvImFsHEKXLWvRKeBYG
	DZqMwlt6J1NWK55H/hYlROS55cPPnyYehDhdWANVJV9UrJuC7Bk8FhW4G8g==
X-Gm-Gg: AR+sD11ifjWJCJniNC4z2nx94pz5qVD3JOvlP09fQMtjW+hOf5Bh04hZzA/KcnxzhAw
	9LZZvD+7ZBDl9JDGn+FTGoZHrH/ZYoWs8PJPOF0GlDBJVbZ860wn/X8sUeUZq2O5h8WFATGyXRo
	jS941uX9Hlj7iMXhjZQCbyCQqoYVpzKulsx+tCnKwAqktH/2+050hZfKaaVi9R/0kFYrwKSAmQe
	i5uK2f0KFtAua8z+RS6/3y1AYY1XDqdMHnt3Fv5GagXL1Y/J0j9cMyspS5oK8lflzYGQ0wgh2ns
	5ja8LTn3RPvs5w1pqMO2tB4QHJM2C/Nz6FxvyVRmSHYcbflr6VfiVoR1qw1/7JESsoJcH2kVSIb
	jf8AUS9Wh+zfydeczI/lzNJGTXNUleOQV/34=
X-Received: by 2002:a05:690c:a9a:b0:80b:9114:3b7e with SMTP id 00721157ae682-81fd4a2d85amr133508297b3.12.1785768384894;
        Mon, 03 Aug 2026 07:46:24 -0700 (PDT)
X-Received: by 2002:a05:690c:a9a:b0:80b:9114:3b7e with SMTP id 00721157ae682-81fd4a2d85amr133507827b3.12.1785768384377;
        Mon, 03 Aug 2026 07:46:24 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2e2bbsm55709907b3.9.2026.08.03.07.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:46:23 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:46:21 -0400
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
Subject: Re: [PATCH v5 15/25] clk: mediatek: pllfh: Add ops for PLLs using
 set/clr regs
Message-ID: <anCpvYJJf2FChBHE@redhat.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
 <20260801-mt8189-clocks-system-base-v5-15-ac4410697cc2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-15-ac4410697cc2@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Sat, Aug 01, 2026 at 01:21:01PM +0200, Louis-Alexis Eyraud wrote:
> Add new set of PLL FHCTL clock operations, that uses the new prepare
> and unprepare methods, added in PLL for MT8189 SoC to support this
> logic.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

