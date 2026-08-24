Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FB41F5C8
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576225; cv=none; b=agJK9z57nIoTw+rrBAbys9aHqipDEqPJ8zU13gGLFKePHqRie5DPkG0BNvLDnO+dJCQXgKxCxWIKLJul6w3M5gehwCLH1sLKbh1BWQBmsNh5WJO5F39fwPEm3N6L/OfxB4mPEiDpiPbwz7Rg+Fda6greOGQ7AGAX6bglYV5SBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576225; c=relaxed/simple;
	bh=WVrNzzyYObpiv0Uap3WSySe8S+iyNjfdJ7YIaTKuRPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgOlhNGSEut/gg0qPC/1LHGy1EnCfPD34w+HZUNRAj9qc7yPD4xYOT2kjSeA4dQ0G2pkBWfBBaWZ9N6hzcDefHvQcrEVFRLy7jPE63NBAZXvrIw9mywcUc6waN5zCRUgeOkOAVWayoSnmGmAWl6lDnM+N/dgFdCVgEK+OwTIfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuV0D9ol; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuV0D9ol"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce98cb8165so34286385ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787576223; x=1788181023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtiqIWe8cuq9ozGHSFWPgt4/EhaLJJEH1fcmAY1Ox+w=;
        b=PuV0D9olIf/cwurlX9GpUP3Y4J+ciCPH4P9OZwUNJReDzuAPaEikNvEoneMmZG2KjD
         PE38Oz4AH4X4zEYvs34k2oLRPclH/hxkTz3K7QpcoM+PKN2HcocX8TT0zui7Ge8tfVEx
         mywJnE9Igb4ep+HV0tj7qFZgNHk4LGuxi0MIiNJAsawmes1wHAyAQD8zunld+9ZnydPc
         LJHCKGxG8JT9zz2QsT5th5lPnQcVFohjhM5VNP9VHs5YzGJWddzFrp2Yrb7ZWZ3c/DSG
         nGb6vsdEMTvufJVsnl5c4CZbqtEBsqVVBWeDn9wgN2KPXmcIisgATt7BC0SH/IZf1hPf
         wucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576223; x=1788181023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtiqIWe8cuq9ozGHSFWPgt4/EhaLJJEH1fcmAY1Ox+w=;
        b=PvrJja/Mv4He/1jV8422d0szFsYy9q7E5VifI5B9TsnkR3DVz66cy87+8ruC0Y84nY
         A2J6y0OiSDgM6Lt1H6wo7v4SIFE/pfWdR0pRM8JAPIA3NZZJGMLy3rjqnjM8Bec60MVR
         lwT3xt+yIf+dM4fw8MDs5EWpA2A5xoX7J8/stA/XzMDGs5+zx1XTHYuounEFF/AlZvZQ
         88Re3fqG1xwvr01ADk9JL241G1YI8+H4if2jpPmHHKGVU9rgpEeFo99C6n03ECOk0kcR
         vFjraRcC1tVAqOYzwC1rzP+LNUqvg/5HgsM/5QgxX8Z0VqEzygf9Ks0NrAT3So45XrJB
         5urw==
X-Forwarded-Encrypted: i=1; AHgh+Rrajy4iqk6gpopfPVjw13l2IwS/zCpFeG6CM8oUVIqUHzjjbGiNAWuReFR+vR/1lJJSSznFLJw=@vger.kernel.org
X-Gm-Message-State: AFuF++ny+i5uQellR3mPy3WnRysLliGHKqyFTrWbsmBGDoItp07U/GA9
	cJC4aLM8zS2sP7x8a8pyD4rYpWOK9ElGeQZj+r1JqBt5+yog3C0KRfj8
X-Gm-Gg: AR+sD12xjHBR4eKves+PEkPZubdomwKFza2QyTbVZb5N2Bb99+9ggQGdH4nqTX2P/vt
	rWBIzH/DySaYPDzBBonze9jm5ufi0D8/4HAqC0F/wOeK9cEDqUAin6jk+Ox78kCLg6sRM/zfD7y
	rWTZS1WxMadahSlDHzh6iqiuH8D+hfC5RH/aYs7FoaMD9cm8MnXEZiOZm1Ck445OBFyPLiczwgn
	5eaNwKk0EaCAIyTCltobr1gYgMPN1xBwTd6JbfshzwWj+2GgnkrUzycCm1Z9YcaGgHE1JzrmxK+
	uhOHrDBEF0fmXH084QoWEwYnxv7Kt8DP6d8Rd798rk0hZ4xgQcAdwcSRS12UhSPhlJGgmo+usJ1
	mzwTxJDX/kSjTqV2dPQVN/7KpP6eQjAoC+LK1/8bKvJ/uN8HRonRdYUfhKTK3DZzBZEibCcA0Xg
	oziDyvW7vXtFc6TKrSTkcdEyrZ0HQHiSzWfC5SZYgNyX0po+yg5C/bDfib3ipOxYUquRTVBaq7g
	RNgdd5xl/IFRdkjNas=
X-Received: by 2002:a17:903:19c8:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2d6501d2265mr288458665ad.10.1787576223241;
        Mon, 24 Aug 2026 05:57:03 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761bdesm17893315ad.1.2026.08.24.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:57:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:56:56 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
	idosch@nvidia.com, kuniyu@google.com, horms@kernel.org,
	willemb@google.com, andrew+netdev@lunn.ch, kees@kernel.org,
	jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, ij@kernel.org,
	martin.lau@kernel.org, shakeel.butt@linux.dev, matttbe@kernel.org,
	martineau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2 0/8] net: fixes for requests completing on a
 socket that no longer listens
Message-ID: <aow_mC_284ws8WXR@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824093044.595dd0fc@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824093044.595dd0fc@pumpkin>

On Mon, Aug 24, 2026 at 09:30:44AM +0100, David Laight wrote:
> On Mon, 24 Aug 2026 12:32:44 +0900
> Hyunwoo Kim <imv4bel@gmail.com> wrote:
> 
> > connect(AF_UNSPEC) and listen() move a socket back and forth between
> > listener and active session. IPV6_ADDRFORM on top of that turns an
> > AF_INET6 socket into an AF_INET one.
> 
> Is it even valid to call connect() after listen()?

More precisely, it is connect(AF_UNSPEC), which is a disconnect. This 
is a valid operation.


Best regards,
Hyunwoo Kim
