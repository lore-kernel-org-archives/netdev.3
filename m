Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429878;
	b=s82GFjIDCZ6k61fodEo3sL1+8guOHb4iVTzFb5EmSskMU1YuMqYrKrpX6gcGZWp/fFok
	 HQtIbdWw64oJlYs2vRMigm0YQhIzQFut5+qXQQ/KvVOVcJ6eZ/ffTvbi0JksVLpeltvIM
	 iS7wp8G1gALVRO01+BiO3l8HKiyh2aud+ZfE/zaAXTS50Al2UM2o5ym39afjLKkMdJ0e1
	 tdtCwUSlGUlcHb5Xk7gEhaTzI5U+ZBUc5K7j89JzJobdfO9djGUtEIGuoX3ll+mw85i0s
	 eQ9lwjGtkuegTyBiW8142/aTrZ68/oYOXwdUE539dF2j5GBHHhPP+5ux0vFPw8JP8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dZ+FADptfXuwg6J/s7FnJwVE/R0FofS1vvClhnLinmc=;
	b=4kU8mltCsLZCJlv1uy9jdOevMAOzhyp4/Gdns+lmIJeL0aTV4zxAOgDUlRALd/oZkemm
	 Er9oA4oZWhOi30KEr4H0I8pbQTb/YM5Rpr4OhLOkyQ3gk8yh2wteqdDX0hkcn9f79jSfd
	 /3kZ/FcpgkS87GcZuh6lKSilkPpzsrK4aXtg9/UXyK8oioukAwyb00ffwgYJ8XClE1mZl
	 OHNw4pecTg0EI5nGSDeJJYqOhGBjfTSK8odfFc9XpdNxDxVgb7O+HvNfn/iq6ReKtnAgj
	 k2silaQKOnj9jN8+ZEV569hOLD/N/z8o0RKjog1GllklhnerGY4eFeL3tYOiWgmmBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bQnKNlDq;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE12606A321
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bQnKNlDq
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso12688555ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792429878; x=1793034678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZ+FADptfXuwg6J/s7FnJwVE/R0FofS1vvClhnLinmc=;
        b=bQnKNlDquFjCGHo5mmgu/AN3xE2E8llvpipemwUgCMelsuGbwcp3iRb7IdZIvf1C0Z
         PGt1Lzd9bZJ2OJ3YktCJsF+Y36E/pw/Fn3YDQZKrZNSk3bEKiEOWdowuVR/qXnXf1myz
         8v+s5Qhpi3cpxOIIMB9SbOxTYeTkivJ1HkGG/76V5D0jPWnsaI76Mz6PAUHNltCQs6vz
         qht2vyeT6BoCtQe4egfig4HZ1FrD+3Cl+GerdYBrpfxSzRWrc023D0zHDjIXdt0qC4Ke
         unTWG++PUTMOIf97/xsobr9hKOdD7jJZTYFocSXihD6vrGGvkO2Q0cI7bOjiaBTMS/Qt
         2QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429878; x=1793034678;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZ+FADptfXuwg6J/s7FnJwVE/R0FofS1vvClhnLinmc=;
        b=TU8O8xpvlsubdZKRZgrhbyRmBFDRH0Qc/k60UGB1Eb9a9DmnpCNCSpWbBQ9VrCKh4w
         2LjtvDvjy+gvkpSeXjAYGoWCxQfkKF14ZrC5xdKMRZboV21DnSxWh3lS3uMySmnpXmbf
         h4erBzUoS19bwKSznn/eDbbNx7AWZmA0EYsmm4qYvoOVlbFMPufl6U21bhSJjbMLeZ9M
         Sbl460huaJ75BnMHg1KRoIVA8AFCT4xr8g1T8NueywWfFmH6z9zRLo+Nr00FbCCNTG8r
         Vf4xSfcEdjmHMTT79cPbIGt2BnCdVldx3viS6n27akxt2ZpVwqWSPcZnUwypdbHjas2F
         Gh7A==
X-Gm-Message-State: AFq9FYJTUSzDFU5DS8R0aKtIj9tQuMlv4JF879Owlzd6NuQXe9E5b4qb
	lCW6jYnYMhvIeReNELYMqkUHe7u+5nZMvgaswQ8dAP4UkIe4vzS0Gkbo6vmfI5oRs08=
X-Gm-Gg: AYBFou3QhpsdHNdRoEpiKq7Xa/vSDF4WLMK4vNs/kfe4tAuVd00DJigH4bU0JwEi6Nw
	eOAyChgjU0znKINMztD/o/EURFQ8GSTRHPrTGVWxr7hcmkA3v4T5HfB1+Ya6Sv6HrDikbAHR0Ov
	ZfsbxZcwxxTl2XZoHv9pWFVWS9SrJIli9WzAeHQTe8+87fJu7prLQc+c3EF4O7EZsJQJHKjNSVa
	f3KCnKGh9ISF/XzN0ilZggEHZDFeUdYx720bAOkodYyRvEnwA7uOfTXENVphba31yYwMN1Onjng
	KTy1eUle6rP7AJUuJTHMlSe0hlZNdPkxfp1AR2G8apmnIJ897BUHQRbzUhmL7UGMKSYCJwyqx3c
	/hy9jFFO6hkieBbbNVUF79b+YYqGwxdnaLbVmwBXVULsONYebrOu1G5yAO9hvlrFShqDRf4STWt
	c+1F0uhVcWCpic+asKjcoQY4qL3OHk0pkmdKxgedp0vfux5V8QZkm4M/Cokwauomg39oJ6rZAS6
	/1qy82kLWjx2SbmOrp0T3qC3xtvw5ElD+0F/qaUIg42qNhnbso=
X-Received: by 2002:a17:90b:580c:b0:3ac:c03a:38ad with SMTP id 98e67ed59e1d1-3acee276f1fmr7787887a91.5.1792429876849;
        Mon, 19 Oct 2026 10:11:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4004cbsm330340a91.3.2026.10.19.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:11:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:11:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] ss: document -K requirements in man page
Message-ID: <20261019101114.6531a476@phoenix.local>
In-Reply-To: <20261018181917.2440-1-gopalmalaviya53@gmail.com>
References: <20261018181917.2440-1-gopalmalaviya53@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 18:19:17 +0000
Gopal Malaviya <gopalmalaviya53@gmail.com> wrote:

> The -K/--kill option uses SOCK_DESTROY, which the kernel only provides
> when built with CONFIG_INET_DIAG_DESTROY=y (default n). Closing a
> socket also requires CAP_NET_ADMIN. The man page mentions neither.
> 
> Without CONFIG_INET_DIAG_DESTROY, the kernel answers every SOCK_DESTROY
> request with EOPNOTSUPP. ss treats that the same as a single socket
> that cannot be closed and skips it silently, so nothing is closed, no
> error is printed and ss exits with status 0. For example, on a WSL2
> kernel (6.6.114.1-microsoft-standard-WSL2), running as root:
> 
>   # ss -tan '( sport = :52616 or dport = :52616 )'
>   State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
>   FIN-WAIT-2 0      0          127.0.0.1:52616    127.0.0.1:58995
>   CLOSE-WAIT 1      0          127.0.0.1:58995    127.0.0.1:52616
>   # ss --kill -tan sport = :52616
>   State Recv-Q Send-Q Local Address:Port Peer Address:Port
>   # echo $?
>   0
>   # ss -tan '( sport = :52616 or dport = :52616 )'
>   State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
>   FIN-WAIT-2 0      0          127.0.0.1:52616    127.0.0.1:58995
>   CLOSE-WAIT 1      0          127.0.0.1:58995    127.0.0.1:52616
> 
> With the same kernel rebuilt with CONFIG_INET_DIAG_DESTROY=y, the same
> --kill command closes the matching socket when run as root, and fails
> with "SOCK_DESTROY answers: Operation not permitted" without
> CAP_NET_ADMIN.
> 
> Making ss report this was discussed in 2016 [1] without agreement,
> since the kernel also returns EOPNOTSUPP for individual sockets that
> cannot be closed (e.g. some UDP or TIME_WAIT sockets on older kernels),
> and per-socket errors would be noisy on correctly configured systems.
> This patch does not change behaviour; it only documents both
> requirements and the silent case, so users can tell why -K had no
> effect.
> 
> Link: https://lore.kernel.org/netdev/1463442791-2399-2-git-send-email-dsa@cumulusnetworks.com/ [1]
> Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>

Nak

I would rather not turn the iproute2 man pages into a laundry list
of how commands can fail if the kernel is configured without options.
There is a huge range of kernel config options and covering all of
them would make man pages into unreadable by humans noise.

Instead, it is best to just keep the error messages. The existing error
seems clear enough that operation was not permitted.
