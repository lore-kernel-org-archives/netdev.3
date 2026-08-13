Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A74779B0
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647198; cv=none; b=EcBC2jdz0F8WaY2PpQaLdfMUpYkDrvgHcrAn9ZxA/eON/R6Uzy3E+tZ4JRrmsmufUSiRrrMqwP3ENU3GK6mr9zWR8/KVxhD06yXBAEbhi6RQaYZAQ5R2GEagCgXpM7zdpapOM44sdDp08VqaTgiu+xvRoto256/INZosAHmFZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647198; c=relaxed/simple;
	bh=XR7g9p88J7Jv3lRFX16qn0UgWKl90nn7NX6TSsJRbhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvm1NPG9ddeSwLsfF6TPP3mdlaG4ht7bCFsGkuSUm9mkPVSj9jI0nfmCA4eG1pGIBEWs/RfEt8Edex6NCKKySe4IVSEhwYug30U8LpD2MtIkcP8WcPCp+Q//J7QzNXIiMl6ce2xXXJsIfIAeAicU7Ds0aJqo8WWzY96PTlgJcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUDH3LxN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUDH3LxN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4994d41ceb9so302975e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786647195; x=1787251995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gYq6ARPSHDC079LDT6haspAFwms/8GstOieZE4K9c8g=;
        b=kUDH3LxNVNLkB1Y4r/a9QwOdIy1qsapToogwB2wJdgyRKO3U+xS3PDJOP7ILDVc8e2
         wjFqFmI1A291gFMwZeWv6mtFCwgAAWpil/A9ChPjAlRUQGrjmKszOD+3kv/b8d/vQhia
         K83GR2AoYP4tgLkNU0wbrUSrOk4E19Mp9FnhhmiN/7nzrGFxWeepsLVf/L+HCmslv4P7
         cOGHIBvSOVe2m/8FkVxNZMmIBeRRLbXHvW/L0Z04gHmIw/CgIN2mVw9FVSLlUNalDyMY
         Pg7sDWqM+7wKSxU8atV/4UjKTUKXknKlQvuYgGbDKaOC7kuEHKWK7IfiRksl9zzrwH4I
         cwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647195; x=1787251995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYq6ARPSHDC079LDT6haspAFwms/8GstOieZE4K9c8g=;
        b=sF8tG31jyqiIaEMXu4WMUK1PK3bvg9H95g1e6dBPGO+hzESK4uw08AyjcfSaBvAZii
         yqUQvUJTUJGpTbKffbk9m+l9ecpNlPogbvyLuffw6feLSjgqLUZ6SiwWnwPfCNHlZc+K
         lCvr+3tZ0+Zq9xbkh7au6WCg+oWThwBd58VENPgiUo4h9jQmx2mciJels9+/Nnn6TaJy
         3jgNgnTFpAKIsFzX7Z8pFuR1+/cLZLH+bpnnxkK60HmuBzxqOiN16F/WQAAFwL671aOV
         eWuABIikPoftSs2uFqc5dGE6ad4vZJHlpfra2wgp28KTnEQ3kFqmSF4QWWT5833VdAuP
         H5Sw==
X-Gm-Message-State: AOJu0Yw476zNTWy+KcNAKdfSYhFVPjP4SU4bmHK5y4aWXmj08T4sY9gi
	hIxrUphj/tJTrkF9CuihQiBox1FGF7JqH1v/9tcnfXEojUvHLwiw1U0k
X-Gm-Gg: AR+sD12hbOfuYzW/soj6cSWoEKgAhJZWAtGTEvgtYlfVj1BrOTE7cOJcBtEd5ZBh2tv
	hXTiV0xusBtg8ElwgNtJbGuUFsTtp/vJGzyyDCuaHgODr+kyfxdhRS6w1PYedvq/IbVZUDVyGGl
	G8TO4cNDU+roUpngICikte19xLFerSxgeTEbiqfr44OTvzRxZ3TGIMVbJ8AziRbM9CbpoFfxBNx
	7V9hNuMqwYVcvIYz/4R4jUCiF/m+ysLS6nkuq1L9jJ4FepLjjjfC2iLxJgvAGEKnwXRokEAKckR
	QiuVGyBfUHdFsOYcJEi2NKH2g5EdBvAtnejGIbL6FH/Z/fnQYv+P9IvD+B5PcJqdk6EQf7fEydP
	0zNdu5XdLQjTmSHjxU9g8fVk7SDuG7XS2XU21Mp1abVI+uUcrY5XpuDbHWy6FqKFpl+iHrDojVR
	Mkm5YmJDiwEMGqPxVQcfcwfXUD3U9unHBMnMsaaEl88hwkR0+m
X-Received: by 2002:a05:6000:402b:b0:481:3db3:8eb with SMTP id ffacd0b85a97d-4816072df98mr200797f8f.1.1786647195123;
        Thu, 13 Aug 2026 11:53:15 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d90sm1434225f8f.22.2026.08.13.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:53:14 -0700 (PDT)
Date: Thu, 13 Aug 2026 21:53:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix PCS link check on CMODE
 read error
Message-ID: <20260813185312.ikljy4rqx6r2e7ci@skbuf>
References: <20260813153131.3952970-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153131.3952970-1-ruoyuw560@gmail.com>

On Thu, Aug 13, 2026 at 11:31:31PM +0800, Ruoyu Wang wrote:
> mv88e6352_pcs_link_check() ignores errors returned by
> port_get_cmode(). If the port status register read fails,
> mv88e6352_port_get_cmode() returns without setting cmode. The link check
> then compares an uninitialized value and may incorrectly treat the PCS
> as active.
> 
> Save the return value and fail the link check after releasing the
> register lock. marvell_c22_pcs_get_state() initializes the reported link
> state to down before calling the check, so a read failure is handled
> safely until a later poll succeeds.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 85764555442f ("net: dsa: mv88e6xxx: convert 88e6352 to phylink_pcs")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
