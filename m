Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4219644B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679736; cv=none; b=RvYZIzWR89C3SmaSR0y+FxA4IxFT9H0jVzzNRd0y0WakhCzfUspvzkkQIXVQjnkyE4MFA59dAJOIzcSYsgyPEmGbqZNNfMtpoSMOutPr/e28QHWOTuClip01ODvPTnPcoZam5WsY/93ZGgVDDLBG5m+3xAn2glLqzFZeoNBbe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679736; c=relaxed/simple;
	bh=xFMBO/tvDXeZ9ENOnwGVcMekf9MEIwoIn8N1zllBcuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQZV5MdTpkeJnIFnz2yyNb7NwVA147AtgV4nik8eBDrRFlpYxyGJIhe0p+OAwXcFuhX/5xQC8sJFoKruVFdph1H+VJN1SRXLxDjNRklSW46v3w0Zt4qUnBCohCsHkvkeZmyN/AlSMLyZA7Ht5uZorUuTolnXbXXIBAjambhCy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHhbEshY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHhbEshY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-848643382fcso12949825b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784679732; x=1785284532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6RV+pWPuLrWtGLHPRoHO6UZjcCN7SkNDZVxGG/ZxlKo=;
        b=CHhbEshYoiYrgYa+X9Wlk7+xzrqSiHbJXvRJKFyPDjE6SEtbR5/B1iz004mrHV5RGm
         H21UNWc9X/iWKWOIBQg67YnbNrjv4C7kS2Wil7Is1n74yXgICGnCD0O5A+MrHGuI5MHH
         rPazIeJV/wCBYJrnIoZo7+lmCMikBDtUi/uB9Rlea+ROd31TbB32VgB3laMAO4bu9joH
         QkR/KCljXtI6+Yl0mrxhfVZhIeKYOXeiK5xLAaOQIjd0jZi5a9L/Ghii/l8J3Cqp40vX
         N7v/m73wBbJYm4sFzlBuQNcYe+MWHEs6rwj1g0bCSh/EvL9DaOTVjmlGZS+nMewgDfIa
         92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679732; x=1785284532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6RV+pWPuLrWtGLHPRoHO6UZjcCN7SkNDZVxGG/ZxlKo=;
        b=D4dpc5nsRKLjdrpEBEbVjZ3kQZLg2X8X4ggjfg2ILevsQO0KBvxFS8eJtxIsoBnzub
         p3SkFrfFMChhqrGn9a22acPQd90REwHXURL8hESJFRQQcnebKx8qLSQAnLNwUxYNHiWV
         Scc6EosnX6qtdtemfTTOg723mbpJyEw6GVtMpIMqZE6CIgenRQ+Db3rdYXiqEJfn75Yv
         Dqj2fCaTbU82x28VwnelLacU0b9bQFe4ELuW4YFvT7+LgqAUrWMpmHM3jKc4YJToEOF7
         BTNm5YAd0JdCWDHlrQ9PTkLM7w0qU+nx5NwJtFQz7MCujsbgVsLlsubu0BqKStK1k7pe
         fnZw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9pH2fQC98HO1w3U7c+Mn8yTgFI+LkKp/3u6L8NQZRs9GcBnBClB0hq6vruH96SmxH3uykBqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOj0N1SfAxBp13iQa/6ygjn2Xsu+knTRubuiFLvrCg+aOWdk8
	2IYldx/t4hMBy0vWlMjO8CplPLNW7QljaiCFwyqzS+t3gFNCadqxkmyF
X-Gm-Gg: AR+sD13aqglpxw5BXK1RGTf5F0HazDCNpa3wPkd1XZDlBNhqiojTp6yd1lTUlXqgz4W
	0GxV0btDTvSB2G+DPP05TbsTkGT40uTg3IzBMzK7HYY4w8mT674MyHEib0NkzF8AEc4W/Yt6tRa
	522nZils+Ge9ilORgHs+oJrq8K/kwlbdsXh9rHO5khi6dXWCFeWHyFxylgHJe++PUJBvkA2x9DW
	N1nhO/mjnQy09z9iI6acdI/cvd97MuYH8f6jNff5mhLTljJA73df7J4RsD0EmTPlDd88xGQajt7
	bWAilgDfCVGtjIyMjklUtAOikVKL0GoI89HkI8Zt+zxOEpP4jXRvm89EVYB0RnyZ27TLw4vZ2Dr
	zVwWGPu0UV/YumLvmcS0R7ZJ9pNB/KOJfdUeXOSMubrLXcUv8VR3x34MZqstQfgWyg7seSCFrrq
	gPFFqoYQbnusV0s8BHyyThBA==
X-Received: by 2002:a05:6a00:a1b:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84c294d431cmr20914841b3a.38.1784679731792;
        Tue, 21 Jul 2026 17:22:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175b26bbsm406610b3a.46.2026.07.21.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:22:11 -0700 (PDT)
Date: Tue, 21 Jul 2026 17:22:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amANME8AVF7GN/ye@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
 <20260721110903.34840531@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110903.34840531@kernel.org>

On Tue, Jul 21, 2026 at 11:09:03AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:
> > +@ksft_disruptive
> > +def check_rx_large_niov(cfg) -> None:
> > +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> > +    run_rx_large_niov(cfg)
> 
> Any idea why the devmem tests sprinkle disruptive everywhere?
> Disruptive means we take the link down, I don't think this test 
> does that.
> 

Not sure... I don't think the link is ever taken down. If the worry is
ssh, I think one non-devmem queue is always spared anyway, so ssh should
stay up too, but I haven't tried this out.

I always forget to remove these decorators.

Best,
Bobby
