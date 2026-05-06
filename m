Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E841C2E4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071503; cv=none; b=iNwQbtvRXdCavXnVtgva6b203bRPPk+/+gjEK3mYT29xuIXqSG4XC5RoyiGASxphyrnI4V1cthjPm0CfpopjMwt5k58qSazyJk4XondJ3/CUGH/Xr5crjUEA3HQUw5XZaAxZSQOXMffoxghPXXxrUrpzPv2uArmdsoKQGtgp9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071503; c=relaxed/simple;
	bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNjkR5KYezcUN8G8gOosKgJEvzIXhg880E1dils+sB7bfgtbKgiPk8xVW1k6a6O1cLDElgLAM5FIH+CCtj/2wAMq05NLt5hbH6JzRwEfgnicUnc+QhUw0jpOFvUPqK9l/Eg9q3VOtyBX19MiV2gtkU3vnOVH/14L9I2VAONDeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=0iVYiCHw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="0iVYiCHw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso8785285e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1778071500; x=1778676300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
        b=0iVYiCHwdtgZrSMtRulgUDqBDfr4zNjI7HC5CH6oG5NG4z/EO1E9jcW63XTVnPN6BM
         GVKOJghGl/DLC/4Z7y2wivLgF9IJIE1OIyWnPXt4vkrRoPYtA3RrBEKFK14mD9zEkW/P
         TuMki2KdXR4i6nN7lVYSBEIo7uBUDLuh9fkTqqvrUBeYD6nSwU8dn3U6n4Qu0abhbMCy
         gZovGas2YAl5C/RnbnZk3wlWK3uyCQVTBoudkLF/3H37BMtTWelb+IXglFlVEbygyI//
         rWh4VAovOuQGQmElcn5B+jCL4IWAkylJE4L8vREc+/Hq1nYBI5QDplSjx1X+ZeBY+iaN
         cR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071500; x=1778676300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+rkUegOrkmyy32FLh2DFlaV0PClzR+z6g1B8CVkeKo=;
        b=V+MG/pgE6wmDZeto2G0/VIojx80QbuQElZQxr8E4kPP2E4o5qfKIgxOQtd72gOT3Zl
         cdkadV7wCQzWfqdRoOJmY94krDLNWpjE7KZ2qPJ7W3DMOgbRahBcBUPBz98X3e/SoW7Q
         CQus3qprBM4hxijvjr5f3IaV5+CQuZqWdbRaHCFzThpA2+86Wm0xroz2mv5sRSineHlb
         Fs35o4g8AyRWyU8UDKbzyXSq+SRiOT/RCuYFyfcSXVZHmHsa7taFw9+If6jdlIvn4dfb
         2IFTk56Hm5L3QE2QZRHyb9/4loUc8G0N7IqP+frE47VzsEOZ2EwQA9ro830XafmNkKsr
         vB4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yIYqlnETEKfgVgnw/ef7niq8AWvEzKD5OheN4eCCcYjYbdu1keaGPy3vPlfQrYQZ3PlEag2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsvvR39DzIZBVtVO2JsWtIxxUhui8k77mxgjY/iNOdo4XQ7uP
	Oy2ei+duLxG9SfRZwX/YpOGplIVrukWwgU1duWVQCNO2tWyJpoIcSZSJa3vTYL3WRg8=
X-Gm-Gg: AeBDievTEgh6xSKZKApJIJcb95U2UGSCr01dOw6tv4yptNRsW9WxYxiUPKhR0p3J9Nq
	CSJcbqI/h0CVVzKvVlQE4Two92CPJaKSwekGeRJ7HCyBOcYjnteOni0iXj52Vo9MjN0KKObn77k
	d8eNG9iFgZAyth+ZvX41+iJk9ekEedvg5iipAq1VRik7zGQfN3laNdb3yoqsULM/HeQ8szAGhJO
	l2M0u5doAyd1z9NpcE/BRnUVYz/HAfh6aN1ELLvg2yhwd3hVlZ4Tqh1akdxj/Czsk61fYNhu5G9
	E0l1TJ+9tShKfBft6QSqjWGgqmw+pNZWaU+8JPqyF6pkRbo9xGqa1tCW7ZqFLoURA8khnOy0jpF
	2Gi95YtobLcYCF7cjlWKurHMAN6KqPEuNGdXGUSbkgOYhKKumHjYrfyWCfFTVjN7Xft2i5O3ezP
	YD0z3lk1LkIbbhF39ISWVUk9UcIJUZe3Ae4X5cSz9a2MTxo80l3JlCtvAoo0+v/NEtYJ+OJ+9/W
	asp8qRBoAKok5T8
X-Received: by 2002:a05:600c:6612:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48e522b71f2mr47915505e9.10.1778071500107;
        Wed, 06 May 2026 05:45:00 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53108c4csm23047995e9.6.2026.05.06.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:44:58 -0700 (PDT)
Date: Wed, 6 May 2026 14:44:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drbd: switch from genl_magic to YNL
Message-ID: <afs3cyhtAbsr6T1D@localhost.localdomain>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506123926.1944290-1-christoph.boehmwalder@linbit.com>

On Wed, May 06, 2026 at 02:39:24PM +0200, Christoph Böhmwalder wrote:
>DRBD's genetlink interface was defined using a custom multi-include
>macro system, genl_magic_{func,struct}.h. This system generated struct
>definitions, netlink policies, serialization functions and more
>from a single "magic" header.
>It never really caught on; DRBD is its only user, its internal macro
>jungle is next to impossible to understand, and even harder to debug.
>
>This series replaces it with the standard solution, YNL.
>The *_gen.[ch] files were created with a modified YNL generator, but
>these modifications are not shipped because the current DRBD family is
>effectively frozen.
>
>Note: this family primarily aims for compatibility with existing
>userspace. The next planned step is a new (also YNL-based) family,
>"drbd2", which will implement all the actual modern recommendations for
>new netlink families.
>
>Changes from v1:
>- Remove YNL generator patches, ship just the generated code

Sorry everyone, this series was based on an old commit and does not
compile. Please disregard and look at v3 instead.
