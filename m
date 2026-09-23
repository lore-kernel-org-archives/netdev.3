Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031C568FAB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177992; cv=pass; b=t2GVem/R/xMIugSKyPWAxo652PMDC15oBJffhFS8vTlWZJiGUbNxjxvKrVfYA8NhcCJ2ynxcqqx3AU8gbdVcwj0BMbEJApRKKUbpoN2AfFCCu/UyFt3eJh51IqXz0j801esjxuqGwPzkSLzpeOM0trz1etqu6c20XDs17n/GT8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177992; c=relaxed/simple;
	bh=AdYkHfJ2zDSaBM75Wmc+UjEZmUI3CCQP3TZvEyF+sDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXAyk7cVQsSN3TqJOYnLJHFD00WnY6mzEfK1IqDbTAMyZyRs8vA2lsyojTKFnRV/VNyvaOzRnYfVYVpoIKJySd8m7Qb4CvsIdZ/IuvLtvCb9oCKWj4aLELlGkGYeu7N3bAf8RiHOif13kQhl3tgrtcfEenO3riMhaxC6lMkBwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d794Otf9; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d794Otf9"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c556f35e70so168175b6e.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177989; cv=none;
        d=google.com; s=arc-20260327;
        b=sbXW05qRdRBhlArQWlyupHE4DGn39MeQuvOskga8t91Fhsb7Po43vqt+ubqMhbWtmC
         fJbR3tPjBPCWfOEYrvlfbpzsNBzKJXHPvu2TtzmS+6n3S6pKh4NWy7AAW3BYH9lHkqQT
         5+MHSZTn50cTF+HIVaDDs6n1IBb+qqFUwzTGObzYIaEfSTDa+0Tb+9Qzho6xhw20uvuH
         CgRICGhekDDVCmzX3FMcCkoYC7wjIBQT/YuNRVQEHhTRenYo74u6NLYohEUhIHuSl515
         YzRf/L1+2pbeKLsNNZhD/+dn3syeAKEEepdggovZ4fjccuotGKHW1ZfFj3MLTTTrq/zR
         2Q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdYkHfJ2zDSaBM75Wmc+UjEZmUI3CCQP3TZvEyF+sDs=;
        fh=hWmhiveQLeiVahatgwQo8CFE8fLVaDhv8pwI5FtftQU=;
        b=UVfrGfui9E13l6+rfG9O3QIC5zhLCpqw3IPQma6F8UQp4avGCGeKSYdbduWAuQGhaz
         wo9vy0IPGYwi3NpEvy3bLvRXBWgaka9P9PQWA2QBn3U/OTHOb1vA47UGC8sbJH4gLTZ2
         vdsHd02XiqNVb7/z571wX48ZH1IuNKxooEicOa22KWc0azmggyFOVw7FLWxa/91XtrPy
         AD+L6e7P8wDvrluX4KeZB4f2nGn8kTS20JOx7jc7IqVGzx5lJMwZDcjJu3Ug89LjvD4c
         XhuHK9xI0SEuCNTsX4cqrLUyf860noTTubQSy8GShm/iNzsSZdFuX29+fMcsFWLihhsP
         Kb/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177989; x=1790782789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdYkHfJ2zDSaBM75Wmc+UjEZmUI3CCQP3TZvEyF+sDs=;
        b=d794Otf9N2nr7JynGRvuTcTvw6yB3KeB07VCCGBAknOphv9T0y6GE33VKjsGGb0SmT
         MEtlyTV6PonQ2qrBEOpVmMYtQND0dqkPprXpXw11N7PWQM/VJXgLQmewZwLxSiWa77jg
         ZsmnuQz0IpsMAP1EhDSH3FL9dWLVfIF21bUWRBtOPHhg7TfPGjjrFvW9Up3w0ggseCfK
         rILoT6FO/dp3QIKv6gaXDYu0HO193KKH37Pex+nW2ZEiwPHuob5iE4KRV69vVesmDuC1
         FUjX5SCzGGsRHz/LS3pxBMjyXqj0TMpbUY5VCkHfVQ5k/xlS2pzlR2wDySg8kJ7bG0vO
         ccFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177989; x=1790782789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdYkHfJ2zDSaBM75Wmc+UjEZmUI3CCQP3TZvEyF+sDs=;
        b=sUO0BkxOLFeZQh8ji4AIX0pN0e0i5k22irRsNVyRN9kmi8XqHpvjZDSnVbizImpK6T
         qti6k+t0g6fuTYif5Osx17jaJbCmyiz3uzqqZUUIPgNJMpIDTxCVPxLqC9M1e6K/9cLn
         QncNWXYTEUnWlDjhK9L1t5MMANpoSei8T66nv1AYy8moekNhU3TcPLyl1g3P0fTyOFgX
         0dYllZSseiW9MOdXiIWKUHrLMsYYINEJOqrxhAy7nnE6lbEnMPLV8ooRQV+6ulLWd91W
         0v4bC78IvjnaR2ldHD8p5YYQUC69w0e8ApCJjasY6TvapMoVy0DAkqlNxiZfAD9uPCT0
         96/A==
X-Forwarded-Encrypted: i=1; AKwUvBw+t5568Mez4Zb/xm4aJGcTblemHa7Q0GPNIFxzm4rS3FibtSE2cVT4DWR9/WhbSm8Tiqxcvt0=@vger.kernel.org
X-Gm-Message-State: AFuF++lxNzFF6uw7U/b2M791J/G6cbuupoz/pZXZzb7U4AwFXJhZsG2n
	sMElcnXx/AOFnRChGYWu7ArPFH8Tg+9oOBdd5pP4lLivA8Vb1JdX8JgxbvQkOAVRKjkaZjP2HOX
	gsVPi1Hhh7Q/+NFMgAzGrkqy3m6/1x68=
X-Gm-Gg: AYBFou0hqTG4t9uT8mAgRlbgoD3O3WgjVi2JYyRb3Mpo6YvB8Y9Sv3yb27MNPs0noX3
	U4dmunXw1XT+Dr/COnKW4nicb4vS0iRYINn1NEB+NQNZtdfk8aZuJlPcDd4GzQCnDmGgqXcPaVD
	DDDrvam6r84zwJFITEmgXgg4SE/OnpspXKnytACLg2jIQCatpJ19Te/eHUz4NwWdcbhXRWuKLVe
	OFuf7/sl1Vp4h22so3cOlvPVn5+2TtJq5LtzQjfgTMEDUw1YeKV8wF3603jhrsjenBLkX7gOmvu
	D+LD0vmk5EpvluIYqZ6bwOb0zydxgD8TX/jYHIEkz0neSQO5it67I9eb8HH3UaZp/LXNDuk=
X-Received: by 2002:a05:6808:f94:b0:4c5:f237:4521 with SMTP id
 5614622812f47-4d5ba9fd270mr3658486b6e.5.1790177988984; Wed, 23 Sep 2026
 08:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-netcons_ratelimit-v3-0-8e81b789ab37@debian.org> <20260914-netcons_ratelimit-v3-4-8e81b789ab37@debian.org>
In-Reply-To: <20260914-netcons_ratelimit-v3-4-8e81b789ab37@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 23 Sep 2026 16:39:37 +0100
X-Gm-Features: AclHuK-4_fTyXS4Sk79rrR4cNhFbQRH-gmM6U6Ove1uzxePDNMKXgCwckYn6xmI
Message-ID: <CAGSyskX-Xuiyrmd+z1Gs-eDwns8pfA4gGQHN+XepDreYsN=dZA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] netconsole: allow configuring the rate
 limit burst through configfs
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, paulmck@kernel.org, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:10=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> A target that sets ratelimit_interval_ms runs with the ratelimit default
> of 10 messages per interval, which is either too coarse or too generous
> depending on how chatty the target is.
>
> Expose it as ratelimit_burst through configfs.
>
> Restart the interval on write, as ratelimit_interval_ms_store() does.
> Raising the burst of a target that has already drained the bucket
> otherwise buys nothing until the interval in flight ends.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
