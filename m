Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6C33556D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470693; cv=none; b=e/DK28oFckxn9CzFYjLnUmKH1DE8X0AIaM9F5taiwhnTMwPxI4v75vpjGmZEO6umc9Poch/gkqrAO/m6L0qWF+lVHrFcB6GM4r0NiTSkRgXt6sWBumpoiAT4mkKFX0R7TirUbjvAcb1rhspSr0Yx/loDaUlo+ZiOb/BM09OxzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470693; c=relaxed/simple;
	bh=P05npYSXp4I1w5rdhUkA65g+Zf8GPSBtKNcIERPK9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjjHI4yAr8jd0tbpT5klX25odYiXWDNq81SIzHRjt3adENLk/HfHIOuzVJ+792DsMq6VfbOtDbwFWuaODw+sX8McV1qIb0cOo6u6ss6cUq5uS5iWNc0CPWmLATTYpTRW8+CwZcTkkfIqHGiVsRhtp1T4OJtW2pxxUV5Vag+vHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peLnNODG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peLnNODG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49553515a8bso907635e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470690; x=1787075490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GJ2g6YofG3JxSx8GLOLJTpTx4aCvw6QCj+XHn6fkOGE=;
        b=peLnNODG/SFCvJefwlFL1xAutKDinqivBYHKdTvdZotDfXV2Uitkhj+WBMelZBoR3g
         3gSJmVyXbbvhGAezLOAqIjNZjE3U/KlHSyNuudVnxSxq+WuHtLtK5W3az64Uqk+uItiu
         EpN2rzFTEkKxJpdOmEmI+ihZfE+C8mhB9BhzLnnwcFmQdglq56tZeOslli5eEDeJbKhG
         FxjC8yCmvIaUwyPk9iKOXuCKBanJtRbHZvkEkOBqsxa317MPVOADP9fcTL7J7ohIL16I
         PjBMQrU6mcHLenAKvegPiV0VQqfHKPnpiL4XSGuIW3Qw5ph4/ZK+v4yDZv7u3T1wuNmS
         CSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470690; x=1787075490;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ2g6YofG3JxSx8GLOLJTpTx4aCvw6QCj+XHn6fkOGE=;
        b=cdOcXljHEhinDgmlMM+hw83agmmL3X+P945kXqCNBWhPmq6tw1jtNobqI8BGEo/E35
         L8TtldZ37IpEeAtMA4gwLLJk4fOhRftI3qBaIRvHOD2RsYzdWZXzeLUXKq4V/sjU6PKq
         +kze09XZe872ZJlDdalQLpiGsBA4ShRo4WE4z1R/Z2yw9txm9iBIRqqAIq2YY6mNDivT
         lFGbLW4xw9cSJt9QPAU+H+A8s9nwcHD+CwbwegLdsv9brVu3W0fWG2QcA0voZTm0N2Gg
         Xyy/TSHZj1S+5vTAUwZ81neE3T6BrSJ6XfGi5w57Iu18AQvdfrciDCe363lyepmGKcNo
         qdJA==
X-Forwarded-Encrypted: i=1; AHgh+RqQntyvPpgMehzjnnCvoWkuikcQJjd8O+sRwFkjWUwo51Cje2lBGwQWIBzF4SqiQYmLxyGRSTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOqHUrp3GIW9JxB5AIaYsIXl+wWJr6IBRItF9vRzprKBRjFvp
	e8qK6S/lAVNk1/Uiqbj+5O8rKvTbvNA9AYo2n0UFNiM7+5L0wTvzAuCs
X-Gm-Gg: AR+sD124ltMuf2BuJeTHEUDHFAr+fT1eEJPN4leVyy55Aaf8xElwUiUCUeY4OSYCy1d
	RSYR6SmsJqTPNyBkhyfLuHcrVK83Nj4HDqD7Ma40zfgwvYor1ptUcTVhF+a767qm2GpJwamTsfu
	THBN64oZsZHt66V4asIfyz7znzx1d+JNMVjlTNgXJH5uqO0APTWFMMzZtf10Nj4vUr79qGzUO5c
	Dqk1tak3lG1N89H03eRyCG1AALg2CmpGweNkXMFe1bA2Y4qlvMIV0jimN5RFI0T8Cq5M3mxfS7y
	w75IGdZRkz3MATBOlq2aVjxmrylHoVIQ0gBmKCy78j0KU7erPn+mlMG9lmg05rc144ZXnfM/an3
	BQ7Cr+DOV4A1HUhHQG3Q5CWK7IIfm3zAoK9/8Q8/7Mtbs3inTf/eBWqoj3PPxPiL+JyE+mzPlxH
	jH2BlrzcgCT0oTc1sxkNijcih1PV86JmGGguhXhBWfhGfnH7u0NrYYTgedbs2Ds8GEMoSRqR+QW
	nJtRuySY8ntUP20cm62Dg8Tjw==
X-Received: by 2002:a05:600c:6306:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4997843ccbcmr92516685e9.7.1786470689726;
        Tue, 11 Aug 2026 10:51:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997ada79a3sm5488625e9.1.2026.08.11.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:51:29 -0700 (PDT)
Date: Tue, 11 Aug 2026 18:51:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <20260811185127.0343b75b@pumpkin>
In-Reply-To: <20260811081543.26d18828@kernel.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
	<20260807174402.2dfc12d6@pumpkin>
	<anm9gImFEz6EkUZ9@gmail.com>
	<20260810222159.409357fa@pumpkin>
	<ansQ8gHcKdS_Q_ji@gmail.com>
	<20260811081543.26d18828@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 08:15:43 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 11 Aug 2026 05:19:17 -0700 Breno Leitao wrote:
> > So my question to you: can you point me to actual software that
> > passes a "small" optlen and expects the kernel to write past it? That
> > would help to decide about the two options above.  
> 
> If you are very confident that no such SW exists - we can try to queue
> this up for -next. (TBH I'm not, mcast specifically may be full of
> strange one off manually written user space (as opposed to common libraries)).
> 
> If we decide to change the behavior- we will probably have to wait
> until this makes it to an LTS release + some time for people to deploy.
> It can't be a fix.
> 
> So practically speaking it may be more expedient to add some hacks to
> cater to this case in the conversion, and then remove the hack. That'd
> be easier to revert if someone pipes up later that we broke their SW.
> 

I'm also pretty sure there is another sockopt that uses a count inside
the header to indicate the actual buffer length.
For that option the length supplied has to match the expected header length
and there is code to write back the corrected length with an error code.
I did a search earlier today but failed to find it again.
It would be in the patches/changes I did (locally) that made the getsockopt
protocol functions return either a negative errno or a positive length.
But I think those were done an SDD that pretty much lost all its contents
while powered off for some time.

I never did decide on the best way to handle code that wanted to update
'optlen' and return an error.
It is annoying because there are only a handful of cases in the entire source.

I would suggest (again) that these changes be done starting with the syscall
'glue' and adding an extra getsockopt_new() to the function call table(s).
Then changing the protocols one by one to provide the new function and
finally deleting the old entry.
That way each protocol code only needs changing once.

I'd also wrap the copy_to_iter() in an inline function so that most code
doesn't have to care about the implementation.

	David
