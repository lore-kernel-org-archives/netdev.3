Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0093AB288
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318163; cv=none; b=fE13+5VB3xSb6QaR1Lp3p7ioyftl5eVelhnelJGVmqFiLb0FzG2Kvw17tdjOMEGXkWmznWQD7oqJnLWOwbSlXrs/fdko11ClElyouerLeWeyRZwk4aZSbFT3Ed14GyFbXs+9ZvRtg0MnywxdZ4xOeWixcPNpctJ4W2KHPhaCaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318163; c=relaxed/simple;
	bh=rFVmQtBwbpZ+hy0N7xXtfJlmmBXLIt2lrMAgZCV0ulc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG8ZJvJrg2ChnGbWa+xrwUyzHlu/nITLFv1H/1TMf1Hp3esfZwn8fTwrfigSzMV8xQYmk0Y4EpIsmO3bQh9DOtI39QSPCeKZreX/JZe5xsd1OHZkP61pGRyFZTau6fZF5eU1EQWjcSRgH8LnJxL4igTqLcfjJ1e/wWOaLv+Y794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=zw9DsipY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="zw9DsipY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e4985211ecso12434595ad.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791318161; x=1791922961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZRugNV3JlfxpmndM4rEfelj2/GgiUCrdqXME/BjiTs=;
        b=zw9DsipYBEc6myITIhwFjiChOmZOjg7lm8TmnQTGywKW3Zt+OK4y6AaFUmdK9mmvMh
         3wxlT9vOkntD/tHXyJktZ8C5p6YPuE1fcyj8lG0Pu+pqG43hOeeyt7u38j2BdDQkh8nX
         VcVCYCGj/oCUCDTDq/1Xhu/a5EAQHekW+m2MkzNUXrmOAUwLoXIoZefHAf0CCczCgBeY
         NYl4RiireUGBX4/w10KZ3gCRBQOwALZLlYMjiTfuK24Sr/cxLnpRDOHs679Cs9bLa+3+
         6v/IRgEu9047GCsQtM6IzsAel6HUj+flDTIkQ5BheXe55uLfxEPOQ3Ovz/7Cz1iI4Fwa
         Rc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318161; x=1791922961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wZRugNV3JlfxpmndM4rEfelj2/GgiUCrdqXME/BjiTs=;
        b=VN1uZW/GousgdTMxqTDbVqGrxxqLsaEc4XwONCcxwD2VhYcWXKYNQobCxkmvPlnxHd
         WAfaPno7hdC6AJsoh0pwufoCLoDoC9P1Xt+STMU0650JW5i0VyjfTu4veLQK9nA9FQaM
         fd19BTtWpdflhnn0ps5nbWlg9W1ryL67jBUwwkfzUj+TQ9krwURz0s7ZzcO9g0VY4jWR
         B4swnMzVzzZm99F1EIw4asB7qbmry85ZeQCROwCos0xQMJNfdr2ScodmOUulGHs5NAAv
         39NtCDF2DeUfhLcu9DiNFfoX6vQSomwzetXP58PvyJPME3UFJlaypSmrT+Em76vXq5GK
         A6pQ==
X-Gm-Message-State: AFq9FYL5ZPyElkrq5r5Lz3InltcrAqH4kDowi4wM2a2ZJVPg9I7EipBg
	WkwKUAg+wn45tI+ywlAYRCVyjLfIfjZuQ/YsGqSZuisQAYWe0R8U+MmQ/FQkgTJ28jg=
X-Gm-Gg: AYBFou2Xjco5XoAaAZtIyuRhFS7OokRN82LxQa+tRalUlKyFvdl70zFJKIv7fICO7dM
	3hzd64Y5SoJ8htk94GETe3BGwh2fYljBgP4l9Qkfrr019Stdhu0/AaOs0Z9ClS1xKsahCUhBUwV
	m5Ug3g4DUz9I5NDg5c8bgFZfhi8LazyDukdszK/42MLVpNXSrn/DaXHAKKAmyIJoZeOXutv78v+
	4s4Jv+QrjcDykDKmx3c3rrMiQFoYAa/NxqoK0D7O2nh+/Qx+D2KomC53NqXrAJs1xiYAmJmdjct
	EVemTUGF9fvLhLDGYevku5IqTS5xERrpL7QjjKGap+KO8GMk/5zjNwX6EmdYTYC/PBdFqwk23MJ
	DJCuH9vs7aMI7djta0l5ShP4DtsccRrmHwvzHnXNoWuqwmI9mMW5PciPWVSWF0CxBHB/5ptFfE6
	Eu6QT5RyrCtiTEJ+JP+FQmfE9vJKduk5pnpLjWljhqPDGzzB6rF/Rv/tBx9SzKDCx0fMUA5v3HP
	uPJPdtLELA=
X-Received: by 2002:a17:902:ecc6:b0:2df:84e0:902f with SMTP id d9443c01a7336-2e6003b6918mr3976315ad.9.1791318160579;
        Tue, 06 Oct 2026 13:22:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604948613sm850485ad.63.2026.10.06.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:22:39 -0700 (PDT)
Date: Tue, 6 Oct 2026 13:22:37 -0700
From: Joe Damato <joe@dama.to>
To: anmory <anmory@protonmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC net v4 0/4] bnxt_en: Make RING FREE more robust
Message-ID: <asVYjdbZGMAEck2t@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, anmory <anmory@protonmail.com>,
	netdev@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org
References: <VyyrJwrwBZEIGezDRJP8QPxbcsGROaxnmohLCnzNQY6sX5CEt0BK3AEC_0MGBx6OxGf4H5UG_xQcqgtAonwmXLdZ5Bd3INWMsof8Oj6ruqg=@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VyyrJwrwBZEIGezDRJP8QPxbcsGROaxnmohLCnzNQY6sX5CEt0BK3AEC_0MGBx6OxGf4H5UG_xQcqgtAonwmXLdZ5Bd3INWMsof8Oj6ruqg=@protonmail.com>

On Tue, Oct 06, 2026 at 04:43:42PM +0000, anmory wrote:
> Hi Joe,
> 
> we appear to be hitting a very similar issue to the one described in
> this RFC on two Broadcom BCM57504 systems.
> 
> One detail that may be particularly relevant is the ordering in our
> reproductions: on both systems the AMD-Vi IO_PAGE_FAULT occurs before
> the NETDEV WATCHDOG / TX timeout.
> 
> We originally encountered the problem after updating from Debian
> 6.12.107-1 to 6.12.111-1.

BTW there was recently this patch [1] proposed by Eric which helps prevent
a bug Stefan reported [2].

I am not sure whether the bug you are hitting is Eric's bug or the bug I am
chasing.

Other than explaining how you repro'd the issue, if you want to test Eric's
patch you could apply his patch to v6.12.111 and see if the issue still
occurs.

If it stops, it's probably the bug Eric fixed and not the one I'm chasing :)
but if it continues, it could be what I've been looking for and I'd really
want to know how you reproduced it, please.

[1]: https://lore.kernel.org/netdev/20261006042153.199444-1-edumazet@kernel.org/
[2]: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
