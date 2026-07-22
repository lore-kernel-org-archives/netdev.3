Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A51466B05
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738894; cv=pass; b=fRoOslWxqIAuokRHWpciR3/j5daB4wfHoHWR+9FwaDkb9HGnI1TqJxVumoA0v4XwKOMma+Iss6qy2a/2tXaNazhDnhP+YMGHipgpCoqUS9pPdwU6uPz0znVCIMsY0+gD9h8RkTS4NfXL5MympSs78Ca+KhoBGeuv5c/0QPGs9Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738894; c=relaxed/simple;
	bh=i8CW1lxUb4KFMu7RY3+UbAQ1WdG7XX/ECB00e0VG4lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSB6FFoWwlPBsAiNAFSgOUdu6ZB0H12P9huAEqqnUXxHR7OzpCCU17ILQhu+xqUkatyljqPh+fMMkGyVkHt18gfZijyLi5svqf3idXUWUu2S2NbLsEBGQWsL9RZDVco8IbVcOvokvpP1aTmxPRVLpTroLkAmNdDWOyV1SYMs5N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeLwPf2m; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeLwPf2m"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475417f010dso7347434f8f.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738888; cv=none;
        d=google.com; s=arc-20260327;
        b=cwciJYq37A7otYlHY9DSLW4o1/aoraexmHYcXzrZUYgbWaXQBA+ralX6Qelfqn1Nsq
         4pPHXmQoEUFyPjxXt+49GieU5G50nekBAn/F+QpXSvF5QCLFShaCL85L+w7QqfJXl2XV
         TZRKK8o1Ou9fU8h+YUYSudXbaRxdCpue0ac0D61KCef3BzjxdOEBM0XJI+jl6QXRI/EV
         a7j5fAfHBjg6L2iXGWiPENKQlyZ2t1r2c+0iAlpnIOS0MkNcHTWJWtW1Go5cKJ47oXAn
         jkb22Q+EBWendmNvQxdU9V0Av4+n21qkGfCqvrB2Ebjhx+eoPyNbugPiCE3iGZzqkyVJ
         wYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i8CW1lxUb4KFMu7RY3+UbAQ1WdG7XX/ECB00e0VG4lw=;
        fh=WypXqTTo6hwLC8cW9sMMYM9K7GMzvNc9vxtRQx7CKCI=;
        b=YgPhR8R8Q3q0Sk2xiu/u9Fhm0Y8Ag1XK4umCrdvr/HFofTGYbK5PE/GS2uDOmm9mC0
         rLLzG+HUD8wt2lRczyMLpw2CR/8dRrYUbOE/wkA5jE3cmgnbLKQQTJYHDOZo5twTQbea
         iWxgrs7Cpn465lmlnjqqNSVt4PAiukBXvL0gPNvkAW59EMw4pCcrUmukcn3qYrdZVSSe
         ptiFd/2j/7TiWpqTQKVswA6hYkyS03rRSxCL7KxVCM+cdthIvEPUpZYzmw8an9UMZxN4
         lOqChijOZoxvorVQ9jO0GZOK9Cypsa4U2VtDHuT9sbVf5dSgpQow0w/h1LwjQM8/rEnn
         Fo/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738888; x=1785343688; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8CW1lxUb4KFMu7RY3+UbAQ1WdG7XX/ECB00e0VG4lw=;
        b=MeLwPf2mdI0UYPV5HK0wzMSSD2RYkEqnuKoA8iUUt/CuDGrWPhH7BBz1zdaKX67vos
         tbOFUPdGCj1D1ipR81kpTyP37AlS9Qu2WkVrYvc3H2PMS4vbDEtzijj+VBkraXqwEMab
         dPTlaQA0j6qK7YOT7bIwRyIGolvEu3AvyE2GJWTPGmKD5sc1y7cJRBZpiE7vhgpj0utz
         4+FjyS/NyHAmGqtFQe/ogBE0xYUJH6bBjf2qzrZlE5dynl3bkOHrVBNAeM86hH4y/Jh5
         Vc4+iKGbWelZpEBvkQSyDis4830vhLNAKGKgUlup9EfU3Y2N6qecvsXJDtxgE2bBjN9O
         NFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738888; x=1785343688;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i8CW1lxUb4KFMu7RY3+UbAQ1WdG7XX/ECB00e0VG4lw=;
        b=mQzMZHP//75bMOv6IHujkIA9FNEIhGckfczX3j2WDgN9DM2VQNHjocQZd9gTIjn2dg
         Jv3vLME0vQTHKG97N43jmcTdhkL5FFBpA9qk6PQrqNZlatddeZQ260hSVDZ5w4kvJnvr
         aotYkb55o+6pAO4t46dSHi2pT32wjDXwuNpA1A5hVPJCInSekdC3K1e4U2kFIwTL8+wr
         dvNW+kSji3XMUcTqvTqeNHG5HwyFSlO5jl0wrT2yJx3iBhal/zyavlafzjliFisDAvfb
         Kef2NnEKZQiu826b3SMoXjybALgyTwh6zhWX2/mULeC3AF3NbnN0Ul22zXZfXpAU5ore
         UqMw==
X-Forwarded-Encrypted: i=1; AHgh+RqbzpomQ2NBNLsChT05+VK70s3p20BneJsovgZwXPwGcW/g7jFM4iQxLkVgNzd7NFX+z+4lY4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvqg45yfgfEg5pvbe0E8YcBbKCeg/g2B1Nlf1DjF6VN9XNh2n
	PkfZcq0vtY/kq4RFxy0ogHiYtfPHmGTUzzWacus5vCmyO9CCKx98UP3N9LErl5eJ5DsfVXyc3dA
	B5xRoBDFCB4zBagy4D3S6Hlq3mZC0sjM=
X-Gm-Gg: AR+sD10cBYrAioTUEdDVlCaB72XtGxiTbUy8gYtqzwX7F5iy8mNstQjXOrd1bdp8Hte
	IiRaDZoHdhGXByMTbEn8OqwsOEMTxHb9lgLsRm38eN5Y87uYTg+Csif8xdxOvyWgCms/X0ZflID
	75F7D3aj/DGV9YleBjHSaTUAdZzUSJY9STuWiM/Wn2bhQtGV3HupcwWTkvBLvPJSm+EZTvT8HJw
	guDEgmmEdDWMiYlH5UM9mOJ/um57AHOtPAJTfRAiQW0OtWVGl2x6M7rZ8+aOKc69WTjUmexteWa
	5XYQjjnNHbgL7El0HA==
X-Received: by 2002:a05:6000:1aca:b0:47a:e342:373e with SMTP id
 ffacd0b85a97d-47f62354329mr29419635f8f.58.1784738887660; Wed, 22 Jul 2026
 09:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com> <20260722090443.0c24a5df@kernel.org>
In-Reply-To: <20260722090443.0c24a5df@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 23 Jul 2026 00:47:55 +0800
X-Gm-Features: AUfX_mzmIGdZQ0DCU3N0ypkbp4lpZgOBsfdIhuKFnphwoksaApxBL84ojJanU7U
Message-ID: <CAHPEe=HeQw_qtrrxc992q0v5CAys4ES3x1YTge4hev_2Z4B64Q@mail.gmail.com>
Subject: Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix RX skb frags
 overflow and page leak
To: Jakub Kicinski <kuba@kernel.org>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Satananda Burla <sburla@marvell.com>, Shinas Rasheed <srasheed@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

Sorry, I should have answered the first time. No, I do not have the hardware.

Thanks,
Maoyi
