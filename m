Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E8443A9D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453889; cv=none; b=oSxRi/L3KB7GCfyURV4VQDs1OrzL2e0LxaF0IE6BXqtfBsQeGUyL9aFm7hezYhB7y8VS1d88g3VNSlXyBEn730TXSaBMaKMkXueKUgwEatrFS6N76Qt6X7bbF+C2yB58VUn8hNGSHMeHZCNFytCDBj8wi6zSwoUgx39KbI1IQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453889; c=relaxed/simple;
	bh=fyC7qCdAGgKFXRo5HzXaG/a9KatYhG3SnGw75Jh3aPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9VItiqSzctsMaD95opdENQHtI0nL5t8CCxxRIfftDiSiiqgSkGya2BROYKRA4tiwQgTHYlLxo9avB5Qj4heyERarMofYdO7nTosdyyf3/VPCVm+dI7li4BVErgYSTIvJx0tJ6E40fZQQrlhe33sAiDhAEc2tU01SrEKduHlBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft/xzfaM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft/xzfaM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f36179d72so43728117b3.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786453886; x=1787058686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=izDQyL6NbpJ0TpxD2kVmywM/e6A/0gtwrw2z5KQfU/0=;
        b=Ft/xzfaMst3TVPw7pqeQQFUhpRWmE0cF26Z/AAPlC8PGmYJikl4wsBaDTqVHMDbQ4j
         R35/cEk2FKReMTBc/gPODubWz87xeQXX4mqTBwg1BTi/9CSlen4mRBKlBnsIGM1SfXHD
         Z2nXWhZPOkhKdTeuc/D/BaIYIVc84Yn4XdX4KO4NgLVZeu8zLIqqXPToTrjaDdW50e70
         fUJIdL411otQmGRaxZu0PdTAjAGvBzAWsQW0UUWpBEHOk+CweaheU3k1/h6eU5mdiZ9R
         zMYWKN4ECOGGBkLtjAtdDKI2lLBg4VshoA7lbpxKnjR6vQuJi9FFgodB+yv1UxjJjb7z
         t9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453886; x=1787058686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izDQyL6NbpJ0TpxD2kVmywM/e6A/0gtwrw2z5KQfU/0=;
        b=mMF1b3RZCdIU9mBjdNeEvlTmZwBFd3xHYtaZJEkUaqxtp1GRXUFwRFdMovtYsbQUm+
         eaEQysviZpPze43h03+0jpyy5A2Dq4A92aoFDclLvrkBzlRs1U3fLXDTlrGcqaHm4rmP
         4l/MkETrhhEYMnoR06VPRdV5bqDhun6LVzHYlqdTplvaLpdKVaX/jdOfSCWvYSbaGbft
         WwA2uRsuDpAVuir3P0+rAib5BqraznDJxuQjDaxHV3wJ+Owkxl3aX9nXuM2hF7iEyL4A
         vRw1xQGeKpXZIGwBsmkELj7eEGByRU1U4domOdE5e2a7uZR/11GYwhvTKiDTjd7q0x6F
         +fGg==
X-Gm-Message-State: AOJu0YzxoimPLbxKKqzMBcFHNiMI+PeGKHUk8r8N5C15oN46f3uEJG+j
	qGq85HSn+A+BTDfXGN9f5UcO+uBwp2eX5+hL6pwod44N3XzUIvwlENsR
X-Gm-Gg: AR+sD10SiT+LcAXQHn/dXcmXWM4wxM5BzhTRn0oc3SYfFQ1er9JcvnPAg4aniZbK472
	HKqJi5h/2Us6UpxK/AOrWkt2tQdlCIagfCypGGfzGmQ1qdEDVFPHrJ8Miy6qnniBw+HRLAemlV+
	Aq7ofs1fgBCZJv9eZi8vUIX11p0ZJKVD/mFWIMRW/badBAfFqoDvF9FLTWtKYe5pYxvMJc0iehp
	0Fa9GSP9r/Fs/ep5n/VrUVEc1r0Q4oLABkHsY8FrymUxr55yMwQp87bPmaa3Spe2zCvx4ioDoa4
	+Hd1VBwp7wIaoUIY6ZD4FokQaUpKvGVpdw2mwGr0MV7B83fyziSAZdd4AmRGAesg+KNYeddpMT0
	/7T8NEpwnOgdYEkse1/I1v+HVFUzDmNkWaWhFVIyt4uQFuFS4xdWBSESjtm9xRRRgJ7W297jx7l
	+KcXwg/mTDiZntNW9thhA9HoJskDGRLuqrNd3UMRnJo0Ui4pMFMGXOBUcfZ9u04ca0VugsdcqOZ
	QJNtTM=
X-Received: by 2002:a05:690c:698d:b0:81f:650c:98cd with SMTP id 00721157ae682-82f2dc957b4mr22521957b3.28.1786453886329;
        Tue, 11 Aug 2026 06:11:26 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ec44b14fesm8563677b3.39.2026.08.11.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:11:24 -0700 (PDT)
Date: Tue, 11 Aug 2026 06:11:21 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 0/4] net: phy: dp83640: fix shared clock lifetime
 and probe error cleanup
Message-ID: <ansfeXGe8k3bwkW1@hoboy.vegasvil.org>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807070729.12545-1-xuanqiang.luo@linux.dev>

On Fri, Aug 07, 2026 at 03:07:25PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> 
> The DP83640 driver shares one PTP clock between all PHYs on the same MII
> bus.
> 
> Its driver-local clock lookup and removal scheme can leak the shared clock
> on probe failure or free it while another probe is acquiring it.

Is this an actual problem that you have seen in the real world?

Thanks,
Richard
