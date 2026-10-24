Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792820199;
	b=UPwDeJyOn3Yvsh/ZptotyiMqUR5yZaC/ggX+nj/nLuCUQrDeXqEpT8ejiFhawSEIn4Nz
	 VB5yAM6tifnFdkxXavqX0nq/9ZDm2p2dF0Z3u2VQpf5wZZ/CwQN6YvQdFcVQeeJsRo2wf
	 p22Cy0Cp4UTtfBZyR2tFYIcCPNxjFIrG/jSlqvrDUZJb6RYlQaeJDrXI+sJ5tYROv0wP5
	 Llga8uGXk7Ylmx4glZKe10AN1K56NSHAOOH/A+CaZ/U2tuvs9eIKTyrX8iPkIKe5WauQR
	 7bu3odiGNeG8mKbez9KcCGHrYw28Y+pnfFgulNdLzfmJEDAI6rtTsAkzHArAHZPzHPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uOhtVlIsXaCqD9aysCR6LbQn+NNrDAK283YUAw1IIn4=;
	b=eMb0h43qcsbvuGq5DDZvPXAgM8I12MrLfYkpBR+3xIefiRR+MLxIsDVWOg9Uyk1bTw1p
	 fgRUd11tT7Igs1goKoXsqAr0WhdJDFocXvOlPQp53j0Q4bjBEeOfxdkaDK7PTZCzMrwbN
	 qexMA12Gj/RV29bn9OlZI5Am5CYEQu4tFMhPuUybnrMrU908qjRnWcpFTZ0ZYUgfCa66p
	 +ntAmDx/lNF6mRSMWdwfN4ww+K/d+XWj4EGZ+SQSRabS+B99c5daJp2yilf6peKbUTF+Q
	 9Nk49uPQWnNgNrvO9AjJJb3jYp79cI0HCHPcqsczm4t+0YBpN0naT3t+9ttEWVTGkew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b="c/iqOkGk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2163606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2163606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=c/iqOkGk
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so1617921c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792820197; cv=none;
        d=google.com; s=arc-20260327;
        b=UriRY9flf21hxpXZhFW5wZxfm2g1oIr0dttmngB0DJAYJ7CkAym6gWNxqTWSHfAX79
         zth7f5L66e1r2t8t6v1RxDvrT+z4BFwwTSe9fHk1g7bL6XQTeY++aIewpl7vuN2nRcKf
         /BeyKxzbp/TGUFkNYx9oBxhK1JHkHfbGWJ3SPlClDZ3blHJkFX5zANykiMDLRYlSvEPN
         jgXGNhbG/B6URtjc4tCqon3iWxa1FMx+hdvtZeAVZZJPh+Dq1qNeH0TG03mLXvkk4wcu
         WNLTZwA30Zjj6OKhYHfhsdc4LP5EsSJ7RUDuIijKeCsYidA06Mf3GvIlCqu0WIhkABm8
         kirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uOhtVlIsXaCqD9aysCR6LbQn+NNrDAK283YUAw1IIn4=;
        fh=gwZKdrV+WoOBqWdni51EjiE8YHotD5u5OxI1s/Idjrk=;
        b=fyPMaPbpJjc1abwzWUqYWk0xAVaBmyDQF1jGOwYYh3k+Utn2NYofnrtrs2n6hhIiSJ
         a9Fv1JSk8KKL2wZsHtSTE6l9w/FxtEAxQh9gS6YgtkAmNsHabMAjJgQbEA6o9R8fe3O+
         jbc9Fz6jCzlBRVE9G5kRWwzjLzZOFzxPSZiWyIlbi0/cMT7GbLEjLXRpStfCqhFgNvSV
         +5ZaBFnX6NMVcjBhc1HNZ359jkqHyGG/VKCST0/KKDNhsnSrnKUEmxk/BU2pB19L/K97
         J6pICtUBUzqCvpgAzsFsySiI0R5xMFriiMWuF86rKbt7qjvNj66d8Hctz8EYamJj4csv
         tT6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792820197; x=1793424997; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOhtVlIsXaCqD9aysCR6LbQn+NNrDAK283YUAw1IIn4=;
        b=c/iqOkGkTS9Qs47aOf6e892MeASztmFycAAzTnCLVisWPaHWWZvg/n0D4eDUtYR9QM
         nyCV5ZVjdppsaxOiOqsScF3o0rKgXgWYqpsxMqFAKHAhgVDhIHyHkyMmnJRC0jmwalZJ
         E21vuNbtmvPfVolSDaqVdknrFCUd3MmIh9Jlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820197; x=1793424997;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uOhtVlIsXaCqD9aysCR6LbQn+NNrDAK283YUAw1IIn4=;
        b=dbv71u51o97dpZT2VXk17cgLHoVLuqPXOj02XFrjyDsVDap3i5jSZ5FPUkXSnKa3no
         6HgVyQBZlUcvVx5c2qlZnhImNL2RtljaAnxoyAty6yzm77N/rBFuJ/+zA9JIaMr5ViNG
         oD3LmagDqIdsaFY+MXPgP3ls0cC5Ya2nAtADiQgcXWjDRdpfuoZW/zjacRHD0nAHL/vJ
         bTjzjvfzfX37p4qYooNGgvcYQ78Ro31DN0Re1UL0g0DVvVRAlNFgemMqrQ63spMF09oS
         vNaV2K1T0M3AbGKA77V2IAzF/1udAifCFxH+tbQdrJVRY0axfV5QSCk2a707C6JW23Fb
         g65A==
X-Forwarded-Encrypted: i=1; AKwUvBwGVTetnlmwG39wBq3vCB8jJwBrJnxkqwJELv645N89ZE6OQlQPxH3Ei+EEAbRvvfQfHkjzGHY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiKpnCo/nF+YC72bUJcHeVmPYwXumpA04GvnUp28mQw4DXUc1O
	X5XCeV8j3yxWJf9jZlPHCvYoIr123vcLlnRHJSs4zHoaeiOW/tPzG+zublHuWMD1YWj5leWa/TZ
	5WPonjdJWZrSfz8Z7aEpSDHQRAbHEAkbLsbMw6yCG2BOSnVR1iyR6
X-Gm-Gg: AYBFou2uQhxuYzZtaeePqnau7OBHXWKrt4V1MEnPloZH8xlZrYVor0cif7JNNSpjt68
	gkujWaYzHfWdJ0iDE/f2ISJbiwjZfB1AQDtcwml3u6v23J4n+0X43LPaLaK4jn4BI5FxRnVSZWC
	6q26pwboJjxqpdrU/sWmwysFlw5C3aknWnKzabxJAXdM2Lm3NmfFk+NMuu6uBYTwIA+o8jknOrZ
	TsMj1T42ZE0E+pLE8jXwWPlFxjwT70oy9MYsGuihOMv4sWTkG3qNom2uvtpvRoEizXZggaWnnbv
	OEXcVX6LUdxPyS9AAZerd9i43Li8RPxQq7nU1JCp5004TaKNaTLor+IlfOWEwU3x3R53ui2p1Ar
	O8AZMFA3WCNCIfcM5HcWc1ghLnPpR94OuAXndcJRVVjZ3fjocsEsFBGQtoq5c
X-Received: by 2002:a05:701b:4502:10b0:185:b157:f271 with SMTP id
 a92af1059eb24-19935fc552bmr1439575c88.23.1792820196846; Fri, 23 Oct 2026
 22:36:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com>
In-Reply-To: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 24 Oct 2026 14:36:25 +0900
X-Gm-Features: AclHuK--U4y5WwbG_OvCFvKm5ZdggLi6MEGxzSrvBZK47svhkInkttu0YdkNR6A
Message-ID: <CAFr9PX=KVQpPmh076AXFaYu9dgqA-uFpRXCBVZsoJkna9ph2Pg@mail.gmail.com>
Subject: Re: [PATCH net] net: 8139cp: close race between NAPI completion and
 Rx unmask
To: colton.pawielski@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Colton,

On Thu, 22 Oct 2026 at 08:12, Colton Pawielski via B4 Relay
<devnull+colton.pawielski.gmail.com@kernel.org> wrote:
>
> From: Colton Pawielski <colton.pawielski@gmail.com>
>
> cp_rx_poll() calls napi_complete_done() and only then takes cp->lock
> with interrupts disabled to unmask the Rx interrupts.  An interrupt
> that is not masked while polling (TxOK, TxErr, ...) can arrive in
> between.  cp_interrupt() then sees the Rx status bits, which are still
> set, finds NAPI no longer scheduled, masks Rx and schedules NAPI again.
> cp_rx_poll() then carries on and unmasks Rx anyway.
>
> From that point Rx interrupts are enabled while NAPI is scheduled:
> cp_interrupt() leaves the Rx bits for the poll routine, does not mask
> them because napi_schedule_prep() fails, and the level-triggered
> interrupt fires again as soon as it returns.  On an SH7751 LANDISK
> under combined Tx/Rx load this interrupt storm was captured with a RAM
> trace right before the board locked up hard.
>
> Do the completion and the unmask under the lock, as 8139too does.
>
> Fixes: ab1e7e1d2666 ("8139cp: use napi_complete_done()")
> Signed-off-by: Colton Pawielski <colton.pawielski@gmail.com>

I tried this out on my landisks and it seems to be fine.
So for as far as "I put this on my hardware and it didn't break my
ethernet or make it explode":

Tested-by: Daniel Palmer <daniel@thingy.jp>

I don't know enough about the APIs involved to review this properly
but for FWIW I had my clanker try to reproduce this in QEMU with an
emulation of the landisk and it said it could get into the state
described in the patch so it seems valid.

Cheers,

Daniel
