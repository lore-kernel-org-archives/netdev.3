Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C1384256
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787432625; cv=none; b=pnoHsXqh7i3v/C8OLiMAh4w6hHzKb6VjbJ9aDSqaLImV1I0s2ZyOUlycpJT7SFaGnfUOTup4+nHCJ2FfsyfKIpyVRcyR2mkM147O/hPtwymTZKykqe3EFUMwGnAL8XEFbZ+on2/tVtXr3qToBRs6mj0uTlYoafseOUGpKqh5wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787432625; c=relaxed/simple;
	bh=pwiiJ4H3HaIWhZS+ojaNMKxfF4YFkeoAeM0o3DHBuSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGW93XHQv5yT9jojFNEl7s4rRol0Yc3mBttb6M2V67w0lY3pwsqcWyC5NpxVe8yvtLobZtBmbT8Krhe+vdglVE83VykDwJ1moNFd7Vlvq+gdJY2ANGIhr+vU7mGMSSB9Qm0JP+PVYzaPx0DTBReZ9yMiDXHtAip+R5hFhHPBnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp7jzMM+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp7jzMM+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1670dad7a8so386055866b.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787432610; x=1788037410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcpGyCIEh7F/5f7dZanL/yn6ecJPm8DEjLz6Iy2qqk8=;
        b=mp7jzMM+IGOVWJchtueg0QKTlF7o56lCJn/Fc3L+ZRVpjIGgHuHdjsUNnCAc8CNHNQ
         fmjtCCaMWSfsX6IArfc1e03jQCKkVQf7Kuo2rlKsccKryTDeU1CJj7QaY5w7WXlLnyLe
         ujirCfD2iugT1DMORAVCKcR7rEIDa/cycIVUGO3mcpkP12hbbDBGYOfO2RKRcIvMWUbn
         7QuJ8dv6uEukMWQeRpciPdswNmLMRnnPLDfnVRLO1/1FvLcQb41VS6JT5IdIvh6YuvqF
         Sp6wq4MmOeGYDeB2zMjPEQlQ0DYoUMp/fZS9dovTqv34IvSKD+A0yV9IuR5cqcJJwrXv
         zRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787432610; x=1788037410;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcpGyCIEh7F/5f7dZanL/yn6ecJPm8DEjLz6Iy2qqk8=;
        b=EmLZI7fUuhQZuxwfISg2KUA56tOFenTC0GlKER15cf8DGqwV7CgmXDjGjlgHHkaUim
         snalCRK5Qw4i4e6cfHJshsmwDwM8c/mMF7iG+9Vo6MPc/W8nFUEKiXbn2bjLJJZoPA+5
         ZK/G/OvDV6Jccsrao9u5ohzL3nj6sTcBwgh+rEIDauddix0Y5lEDw7O3wgDNTC5AlVUk
         Y/zkSr6WLzVyE0GnBFyrfEbtVmxFCUI2YONPI9kGh+gqJFyEzDWiCNoI13mlX2zFk02g
         +ipNEbuYv4w481kt1AoiEixb8GIJbWvS43XPgyBvZKkbuZT8byZZ9OdbHrT+zqi90s17
         sh2g==
X-Forwarded-Encrypted: i=1; AHgh+RrW8TKqt3yw85ONZZ6v0itF1zEYo0dRERnbW3Q7oFw/eEEwb45gOymFxZk5FGHpuoO4LVFJiH8=@vger.kernel.org
X-Gm-Message-State: AFuF++nzlnHY0Afgs0+bI1n0DqLw8OtFkKARTYbcNiNH0PnQKoBuAjAu
	e0ez+9zsVBfUHW+V923hpXYjTwrEJYN0SJ+CpO9MQBQwBe45WgWJKAZr
X-Gm-Gg: AR+sD101FWTjssRZ+FY8eCNU1i/HIpxwC+0jC3DSPsCPT3hdYkLli4rD/iHRrrLMD0W
	oXxo25kmPW6epMoZV+ECS8nEZrdwLVmGTp08xlDzMn0ApYo1NJ96fVZJl9S3NgYmIvUf0cLzW2k
	BUrUvNzrT1wOAynMih4XOqXU8Itdg1x2zJnhR6eJufVA7sthcJsIIsQ750fgKYJLQMfMPYM3vlk
	UAUoVzP71ZqsQFign47GAsOGBaVEPB+3Is6dMr4IfNWwPyABc9JSB+cSGMB6Zg+N4ur6FkZIYoA
	WEItUuiaWD/RmYUSJ0kh17nLOEab42OIcQNZCJ7EbibzSRkyM1Bmpz9b/2hSSWuK3vdPQHffjw7
	y9b+I52IjR3FLYcvw6ewfgXPBH8d4zVg8QGDrC0vfi/sPKA2cQE13wJEnv1y2C9zK1nDZr150iM
	Jdt1pbyyHBvqQxUxy58UBJXipMbcw2DNdJ5/oa/Uv/1P/neqIv5WjmW5o02cmswJ/tAPg=
X-Received: by 2002:a17:906:6205:b0:c1c:2173:d412 with SMTP id a640c23a62f3a-c246a39ef9emr1883658466b.1.1787432609844;
        Sat, 22 Aug 2026 14:03:29 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967383e5sm461503366b.45.2026.08.22.14.03.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Aug 2026 14:03:29 -0700 (PDT)
Date: Sat, 22 Aug 2026 23:03:26 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
Message-ID: <20260822230326.5d642593.michal.pecio@gmail.com>
In-Reply-To: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 23:21:54 +0300, Sergey Shtylyov wrote:
> In generic_ocp_{read,write}(), the *while* loops look very strange:
> the last iteration is executed differently to the prior ones, doing
> some useless assignments before *break*. Move the code for the last
> iteration out of the loop bodies, dropping the pointless statements
> as well...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> ---
>  drivers/net/usb/r8152.c | 67 ++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031..de9738bdce85 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
>  	if ((u32)index + (u32)size > 0xffff)
>  		return -EPERM;
>  
> -	while (size) {
> -		if (size > limit) {
> -			ret = get_registers(tp, index, type, limit, data);
> -			if (ret < 0)
> -				break;
> -
> -			index += limit;
> -			data += limit;
> -			size -= limit;
> -		} else {
> -			ret = get_registers(tp, index, type, size, data);
> -			if (ret < 0)
> -				break;
> +	while (size > limit) {
> +		ret = get_registers(tp, index, type, limit, data);
> +		if (ret < 0)
> +			goto error1;
>  
> -			index += size;
> -			data += size;
> -			size = 0;
> -			break;
> -		}
> +		index += limit;
> +		data += limit;
> +		size -= limit;
>  	}
>  
> +	ret = get_registers(tp, index, type, size, data);
> +
> +error1:
>  	if (ret == -ENODEV)
>  		rtl_set_unplug(tp);

Looks like it could be shorter still.

s/limit/chunk/

while (size) {
	if (size < chunk)
		chunk = size;
	ret = get_registers(tp, index, type, chunk, data);
	if (ret < 0)
		break;
	index += chunk;
	data += chunk;
	size -= chunk;
}

Then it could be do-while, because we know size > 0, though
I suppose compilers may figure it out themselves anyway.

Regards,
Michal
