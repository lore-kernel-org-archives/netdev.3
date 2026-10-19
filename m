Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442243;
	b=NgXnEHtnHu+IWa/Bt0Fh2ROWEo5HAcoWoNtO0nJlTlib/nj9jOdHsoJl7+yJnze+iNx/
	 jzUVb7/Tdv0cVx+GxQMSmiwNW/JzhFV76XliJU3iTObYOVv9/v/jmbEJTI2jL7/TaSS8Y
	 SLafhtEDxWX7rkrG2Dt6AG9a4lt7FK7HDKvWVRCNowTEbmwEGfbEdw3kIkFBXvhb2lIYD
	 mmKJQzKTFw3c/LblieSEvF968WZFnRIYn7ibRz725iB+VBM0ADgAUAMkEjO6p1kodxFuG
	 BDTFCfj/fUmjUxxDQoAl82Ug41b6f+k8izVXfgbiigW6BnKkqlXni2MlmakEJZFudVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
	b=xVSdQJjZHIxfmWxuV8/YCGURPjf4Di0IBIMF1IEL5uqmvvXPAPTa9QWLWxbWkWDNQszT
	 m4Prjh5unU8TJLW+UMBEWpLuiOJXskOH70Kv+UIMqYK7JcEAFuaQXd2Fz23wt3/86TNPF
	 3Ax3qK00nh2hceb2mgNng8oaw2kmdMx1QrgCFwjD/wOAtzoHaJcXfvWytt69jrUaTZSbr
	 WosungEFirqDyC6oT3no7GeAmD3C7Pjk7ftAl2Q+0GjxKk39pbOs3xeN7KSXga1aEHRjY
	 xLe5TYtU7wnQ74c991pC+IolMe49HkyafGmgTq7P3+NS82y7LkWwAUZHLQNzxI6u54w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbdVKbnQ;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71C606A31F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB71C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbdVKbnQ
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so22302835e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442241; x=1793047041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=TbdVKbnQRRp9vEsLOXaAXOe8RCtxTDKUbwKg9QY2mqDPSPar/3P4WhNaodDxDY+BkL
         z5fhNg+9YEHPJPYwu73YuJ24D3oaA7K6HDZKf5aH+c1Pe/B7GdlWJdKoI7eTwRUs+eNR
         XWTT2Bvx1AyIFnoplHVTcghLleDAmLt5NYnTajZ7eY321BIDTd3dT989KlGwDKD9NDGP
         cr4C9uSJVWcYwgvwncn6c7MjZTP1GInixxG1DDJuJeIPCWhUwBxCX3CPl8BcL+65FzdA
         UkvSpS6m+3pS+D/8aBkplRzK1r/Qv+7uSg5JACP5SEL+A+he8lOE68px7ghnG77sVgpW
         fEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442241; x=1793047041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=er7S2ybQr7BBEutLRjOIbvpzzXOjH269geRzag+cbr2XiIkGo5L+RBsKIezfH6h4k2
         2i6OrcIIEmEi/rEp3CPt4ZJufHQbbK1YhngOopXxiBYC0LgHUuvlWfD410yKYu+aB9mc
         a+ZDwVow+j4xRuUJJT3KG4cnR6n+gPX/HRT3aO5Hub/IGSNwwjwJ622fMSXsUtiPDUS4
         OdZWLuCjyF71ymt0NPwDBJLLaDq0qZcujNJcCyrnUyDOkMV6zQ7ym+js0ydajNoB2UMz
         ZczjDbUTYvSznK3ia+vhkBXfZiTMaEbudldBTxesLiYITJwkVpEGt3HNerT35CRGwePp
         Qvmg==
X-Gm-Message-State: AFq9FYJeOSVewYi6k/tLUsK6zgpJtMNFVmJ/pyiTZ88a9f5WSIxlAiHS
	fGoRSQRtxV6+TId0ZqlZqNdB6F+/WcatkmiZ7+WL5d4O8wEJ+AbLJDPY
X-Gm-Gg: AYBFou0+udNeXLCk4aQqmEDmPtjF4GPSIN/03W0fXhdT6vOBOMFN3B3fQLhsb3g7UQj
	AahBvTN1ipvccchRKC3IsxpSKy6BjzNLNInCEYTSLBembJdZJBwwkvJRKyPbauysR6VYS31LN9o
	Zl8Nu1onFralMrWzgHPK/vbPEuqFm75fpRJ/zZ0mnfCdy3NcCb1OSclnGx8jB9mbRsz/0/qGJHq
	TVpJ4nA/BGfCI9MhboJ3+PD1nBkd6hoXP1oRJLwq6aj2xHlVQkPTR+0+WPe2YiwvVnIdFfITSt+
	uIBflaxzhXwzV2vqAtkG+1Mw8dytkee1I/puC/iiGVBCnBQXPWB3kxe5KmaQlPyQ6xv/kOWNO+E
	6XBbx6K5hEDRlKtLeNrdvqhgXBwi9sl3QJcTwc3shSaD8/9PhhnPEkTcGt/60Xd3MxvyI4QhGMr
	zojgNZtMsKZzUcIuQi06BEWv+NXz+vh8KvlXd3jmJdXM9SiZ4LA4VUfdPn/uZxzhJ71RaxM9mNu
	UbyKplF7B9wVyZjyzDQeWdQ+Ft5/D+ob/bOWxjneU80EiAu3saHEP8nfWroGaWQJW6uIUdYo+HN
	rlESrORNP/4Od8sg44cvzQfyogV0S9aos+YsiQXG+F9kYkpm/iriDw0P48Hs2Q3pkrIWNCx/nw1
	ARXUSgrt4
X-Received: by 2002:a05:600c:3e85:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a1d798b0d4mr175531195e9.21.1792442241144;
        Mon, 19 Oct 2026 13:37:21 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de. [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c9e9c3sm15967405e9.3.2026.10.19.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:37:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 22:37:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, Kevin Hao <haokexin@gmail.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Message-ID: <atZ8lCW0VVPzoHwb@gmail.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
 <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>

On Mon, Oct 19, 2026 at 12:19:11PM +0100, Siddharth Vadapalli wrote:
> > +		unregister_netdev(ndev);
> > +		disable_work_sync(&priv->rx_mode_work);
> 
> Although the above code is a refactor, it appears to me that the correct
> sequence should be:
> 	disable_work_sync(&priv->rx_mode_work);
> 	unregister_netdev(ndev);
> RX Mode work (cpsw_ndo_set_rx_mode_work) does have a 'netif_running' check
> so it might still be fine if the sequence isn't followed.
> 
> Please correct me if I am mistaken regarding the above. Rest of the patch
> looks good to me.
> 

Both orders are safe here. The worker and unregister_netdev() serialize
on RTNL, so a worker running after unregister exits at !netif_running().

This matches cpsw_new, so I'd keep the current order.

Thanks,
Karl
