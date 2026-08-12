Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052AB43745F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537435; cv=none; b=nVhGB+0rr9gaJo+rd7tqj90q4/KmwDYublOdsD+/27BrbRC4vt+wNwvcVJNjCBm2O8D0Sua3NfJN1Clz0RtDaGmoP5nFEyQSAlggxyh/5mbxbX9I7VmVsPOsL/fmX/J+MVLF9RKpJJUFxfvelAX3y5keO5n9VJ9o/mUpVntBf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537435; c=relaxed/simple;
	bh=trljROtGxFejR8U9iFPiN2Qo4mCSkNOIY3XeWe2aKmU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KAHPSBO5iOAeaZtFViWMmGO2Q8ZlHP8LC8annMnfeo87bhnPybTskKwiWNsDD2n/SJYzWwzYDYqho/yB9WWJY8J7xhRG74khv04CFE3Wsk5rWqD3AU0cdaPNETXw91brlKWVIVATEL+mZ4z5LCX9JT0RN8nWritxiVFtvRxzC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chNTR8DC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chNTR8DC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ecf499af9so13115087b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537433; x=1787142233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SFjsbw2qWVWS28zujK6De2GjmF5EcEPl4P/hY2yuXss=;
        b=chNTR8DCnrHTvHmHqRIkE1v5zZ3GRWQwCDd1j9OOGL0VGJo1wmkJE0RTuDA69f0SbJ
         LAwOt8ddlfH3JmqljerfsQcFmw2sHF3rZ600sC7xjGH0NM/sE5LIhWOq2OQ4SnKH2dN5
         7BNWklwSVf3PKNpES2CqVGJOy9JECKTJssEalesIroR6t0Y3zDOlTa2v637xnc2FHOio
         jDBVyY7l3y0bRtYUGkzOR3nQbBWwMvO2mAbK9EYJvswCIq1h6vMHE3JecCOVSCktyBJ+
         bDd9Zbud4ZPzcM7M60q5LJgzA21NAj0OPrBMydI+qLtISYUFIhVGvv1gdisgVLJPBWBi
         1KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537433; x=1787142233;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFjsbw2qWVWS28zujK6De2GjmF5EcEPl4P/hY2yuXss=;
        b=fmjhZprksU6gRo4MUgNigkReaFnZ0Od7tGyp1fC4W/IOwJBqaFryuIqpjwNW1UPISu
         2owp5WozUX+rw89+xSqYLqWDHmEUqhyKkJkZrigH3ptFaG8iq2BfrB34uIMI9nFXmkXB
         0LuBvyJhTDgzMjBHQ8CourIr3HC3ZvIMjeBwaIV4+SRQNDlZBcmwBVwWGh8+bRgy2SNc
         cuBuyV6NigOepASav6ZoRLozNcuoZEny/NvB4HzeMYNqVg82aXUN5/+sTvem1SHNTC+Q
         kQzsVuaEmPqfl7EkQ4MEFAV9q3wakzISP2dIjhA/48+zkRmlSfwWdA+I/4XU+6f1+OoC
         ddow==
X-Forwarded-Encrypted: i=1; AHgh+Ro0lTjeyGUOkLAmpJB8K2gOym4Tq04ersSG7gvxxIcewT0ABfSoD+5FkLyhjfsuIf/e6rYYHbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBvV1RFbvKC76N55EdbWz4iunVsCW3uzbGIqzvVDiO1tXhwbg
	8/2Mjigw52aZvzvIaGstVw3+M2u8G9Qq6MndEeQwTmRmM1ZZmg9VGH/5oEB1tg==
X-Gm-Gg: AR+sD11kgn/9aRujYaA3eD4OcwUinB7EdGU8DcLgk0sjY8c+ZwK+WpW2PdzCNf1vWMB
	hgdVAlnhTFY0btNe6OVe+m6GQBy4M0NXjb4A6xy9UWi6YF8pBFwG0Wn3dIm1R7v5lx+bFHVCXfB
	KIcBjHkmqZPDRfVTlJZm1Pm1hmeVNt8jwNJfnopgw8YHdlCwjTKlTzQYtNGcCSO2q7Epq3Bm9Fp
	tNhnhmGKjiHcDZEjyPiSDaWISPlLHXKUiUniqPs1BS3C7w2XotYmofEv8vy6q99ubDwXN22mTsp
	WKO0umjiohSrvj8FVc/Bck8DExcdrdUbMMuqIv9/B+YiwR5Yj+goeP183Z95CaWpknK1AhXtrtp
	jSrFm8JUrFXdpsRFX1TooF47fU3oT0Ak1a35lLZHBQKD4XAIHyVktau07O9ruXog5zwG+13tFr0
	OuEKi0qKLyeDbsDs1+N9ytLrzqa1QI3e2RmRAAaTVzoQhh8KcoxcXgPQnGUOFOnDkMRwLC6qZgM
	ICysIPFpHIiy9hN2/TTUfShNG934CN+GgfI1qryDqAwF10=
X-Received: by 2002:a05:690c:e5d1:b0:80b:bfee:c426 with SMTP id 00721157ae682-831083c6c81mr20781507b3.14.1786537432839;
        Wed, 12 Aug 2026 05:23:52 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a41425d1sm12052567b3.11.2026.08.12.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:23:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:23:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <willemdebruijn.kernel.202145d077d8c@gmail.com>
In-Reply-To: <20260812012139.2134643-1-manizada@pm.me>
References: <20260812012139.2134643-1-manizada@pm.me>
Subject: Re: [PATCH net v3] net: tun: bound receive headroom
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Asim Viladi Oglu Manizada wrote:
> tun_get_user() uses tun->align both as skb headroom and when choosing how
> much packet data to keep linear. OVS can propagate an oversized headroom
> request from another port to TUN or TAP.
> 
> When align is larger than the usable space in a one-page skb head,
> SKB_MAX_HEAD(align) underflows and the result becomes negative when stored
> in good_linear. That value later wraps when assigned to the size_t linear
> variable, and tun_alloc_skb() can place skb->data outside the allocated
> head.
> 
> Bound the headroom stored by TUN to the one-page skb-head budget and the
> largest non-sentinel 16-bit skb header offset. Leave one linear byte for
> raw TUN and a complete Ethernet header for TAP, including NET_IP_ALIGN.
> 
> Also pull the raw-TUN protocol byte and the TAP Ethernet header before
> accessing them, so these checks remain safe for nonlinear skbs supplied by
> other allocation paths.
> 
> Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>

Reviewed-by: Willem de Bruijn <willemb@google.com>
