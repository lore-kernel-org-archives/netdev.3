Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3F246BCD
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099349; cv=pass; b=PwQpNCfM+lzmZ9L7CvwfgCqk0RHawaFgSVACGojPeGiTIJjbaf+Cp1D4zaqlv+NTPyfeG2Z92UPSH/v+h/XvQsVlOLdMLnbbRrm1QTleLGwxEX6Jj0yGlhTUj9/zFf9ENKU1c6t5kuxRARFneHeFql2tTkpAkBrsNvJZnan5r7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099349; c=relaxed/simple;
	bh=/unsMahU5AWxxZKqAdHfGOlD5WJuLIUU0biyoYkbP6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLND0nuN7iY+lRlxz+ocLa/w6Fe1wfhsnt1IIi+/KRpHTuwt+LE0n6BOS/M/D/+h9sfg0qfjzP6TR66nuiYMkUxbC6liOLPA787m4QN8/wokhBdwqncPCOMJSM0v64Re2QBDlWCpkZTQM5zPVBCcokz5fGAptqK7rTzXFBdgdYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLeUw4vd; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLeUw4vd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d9520b9155so4786525ad.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789099347; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhnLvGsPKETjc+1mQQ1goiRJ8Rt4E9v6JoDP/fqlsk78nTo65rwJS4OnuaCw8HyqHJ
         pCEJjX08mcdl9dYubm5ilYTDVKP8Qpk/qDBZkLS7ToybesXBAg8yh1arpXhU+HeJsuTi
         xGA0n20CjRuY/tZjvd0o9PkrmxdiJvhOY5eGlNDgS0qxI16/dGVp8ByVhCo9p/hIZGhY
         QHPg0JiijBvKvyyQmT8hlbtB/IatRhN/VaoPD7AKKsJXZJhA6fQI3FVhelPShKCGovPf
         80Nvrl4X4x8K84GHtioQPOmCA6ZMTIWSrBkHLFCh9yt49fIhzeFazTbe45qWlcWhWl3G
         iPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/unsMahU5AWxxZKqAdHfGOlD5WJuLIUU0biyoYkbP6c=;
        fh=wXRnNiEX5x8WyZro2a0fUjLYIIFlpIm8xbVksUQM4vc=;
        b=IERrHNqhwFD+jY1cB0Hh0EkJss8dB5ZRuU34cCKdqGZpOxB2T2FOcK9gen0u7R27ZY
         FaKZrnvuOKm5+YVHbnvfzOqlDMpV9DL7up35jH8dKZXTMlluwIrPZzMnfNSbqy9v4aXL
         DeLJnmEtELe6KZxLgEZa8hTHhtybXXEXbN9QLcWBD6jjMW/QacD2oKP/y45AfUq+oo4v
         fttf5RBDIu+mTcBvQrcSkbCkOkVvIWPaqOakaPcJv/Guo/a0WAq1QPc0SIcscIjLgQzt
         BPlbbMsFrEmF3cyQ5p3IX4r8dZQeJMoeELHw3T3bV5wet8Vxl5Nee+XclUABAi498Se0
         sKZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099347; x=1789704147; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/unsMahU5AWxxZKqAdHfGOlD5WJuLIUU0biyoYkbP6c=;
        b=BLeUw4vdjqqNSpEHvR+GPh8B7ESlVFw3WHIOz6jFGo20HHkk7RuC8cM/5yZiiqR+Ju
         j+B/2WkOn7mJTSB7DRTX+wf5LWv0O7dVy2fT84UqXbeIcely0L7AP11zq5qoJkgRF38X
         cBGpBhPlGqWsTG0VVHWU97A3u83LCnLzzWfnsKK+gD9EjWiU/ZV90jU579ulN+PrxfSu
         DETQXg9w23YilW56zWK95sQspCfjXNPO9hZaER3mIBjTnoGkUNnaAFZi00gOXImuYdQw
         xxPEA4qlytV+RWUpvtnJK7JwOB/U48OCY3VkhRF+9fo0hvdjWsi3ICqoJQYhj9xXcEFK
         qUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099347; x=1789704147;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/unsMahU5AWxxZKqAdHfGOlD5WJuLIUU0biyoYkbP6c=;
        b=Zi1dIjjci/dBB/q6o4iI7ZIYv++6laEL2iJgVjP6g6lpqN3lXJ8+W0KaE3Z/mc96Wp
         pJ51EAspHbuktzEUyJVVPwVOQmyEIFl8/J+8Jl6MOCrDzpc5HyLCaxEjYZ3e0+Vo9wBp
         QtxUisO3OssTi2uXJM/VjaMtWzaqR0xTT0lsiQNEEc8WawzGM4qHKsbzOJxq15IRceOE
         2zJt8QSVFjgTTvXhr2BD4dx8j6lNIaWl4hpY2ozwkE3A9OkNHVOJQAwjW1HYgz/V2LDe
         mhbeHXaO98CLJ3P8q0NLKNoBDmL5pZD0sjJOjR4TFXCNJWYiPaZ4lB43Uev9aoT4nl6+
         m2YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpPjTtQSygLF+ruJ7Amar0DNy+7QADziq1FO8/fjj/41KJc8Xm3oiaptH7QHV7jXPUcn0RDFk=@vger.kernel.org
X-Gm-Message-State: AFuF++lnj5gQedrfKakEDUNosZHVWPnIMPS+pMXJlzGRP9US/PP0H4St
	SVJeL6gpkx2qDl+mPvphXNfKKZHdOAMalVx48SbSxIV6MKh0xwGyFlaAhLCRi9m0z+x163a5FZw
	Qy2JW0jdRp1ND6DkydIe+ALQ/m3do384=
X-Gm-Gg: AYBFou3c+N/gNPRjPFxQ8eyRt9HrN/dcLMj+GkKRTw2U4uZL+orbIE72QT7OFoqALRE
	JPQJZx1FzIPKsdkM7xOLCW3JfXhLe6N7hja6XyUYrniUWpQ+TOs6wlM55yD3Yu055f5pXiuVswT
	NQaKCDS1QjxVxCuaAsjDS/imcYZ0FSeMJSC1/qyz9iJkX6M3fDkYe9Zo7egS2jFPK7YfvtNXjFC
	Tz4InwMG+ueshRkBcoF/ZeG98BTk+gOC6TVKHbEd4zx1IJZcMuvzSmxJB5A56Ncxll+hoqqvIl9
	iQPgmj4hUXkMp6OQbtdkHM1ABs6ZEcsKY8Eu2ky4qwzxT2JWFOgLqiD5CvyocUu3JZBSLzUJy18
	KsI/pTBoXtV9fGtQNNVUNbbMmXPbQ2fMNX+Hxq6j30rJ6Hw7id5IzXlpILCWqPv7DVy4=
X-Received: by 2002:a17:903:124d:b0:2d9:3bee:4f32 with SMTP id
 d9443c01a7336-2dd2a45889cmr41780545ad.20.1789099347397; Thu, 10 Sep 2026
 21:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909064712.22539-1-phucduc.bui@gmail.com> <20260910180733.2d4d48e9@kernel.org>
In-Reply-To: <20260910180733.2d4d48e9@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 11 Sep 2026 11:02:15 +0700
X-Gm-Features: AcwNN1XnERV3Y99vrub4Kb9Mq8NYZCHahFiWxUXpMZS4wj3JAmLqVaaCGWrPlw4
Message-ID: <CAABR9nERt4w_vKgnYRS5+fhTQ64yJW7=vfyBBi_C+PLmNVfzeQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net: fec: Propagate PTP initialization errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Stephen Boyd <swboyd@chromium.org>, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

Thank you for your review.

> > -void fec_ptp_init(struct platform_device *pdev, int irq_idx)
> > +int fec_ptp_init(struct platform_device *pdev, int irq_idx)
>
> This function has a kdoc, you need to document the return value now.
>
> Please repost this for net-next without the Fixes tags.

I will update the KDoc and repost this for net-next without the Fixes:
tags soon.

Best regards,
Phuc
