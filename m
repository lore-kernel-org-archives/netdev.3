Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025859;
	b=nXj/hfgTgGQx0U1mc1/uCqLZfCy7aPOKn6J+FMxXTawMLN0hlhGcUi0UCvIS5eD3pmRN
	 wYqOoEHgoHfAnr0++ckCJkAp5/c8h/ufhGqDsOuESd+mbzBCI9k3ReSYKCnWQyVs+QXm5
	 lE/gINnwL/ppG6YHD68UHWK2lXzz1nXsQ2a+7372+4vkDeIL28A2EqDzEuU/vvLxZC2bm
	 7gepiyizFtp+KlK6TOLiQ0urquFYevTxDqF37qjIn3edhpb+gpqyM8lTo2hQZfcR3BgBZ
	 2y+1Hl/93j8XtwxwZJ8BcgII6OfFb7CW5vpA2H9inRk6cqVat4AeU/jTDX76k8uHiPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
	b=e9Pvi17zXjfpelBGPgazcuqq5lulHq5Bfe0i8eEoFBqBDLu5brNeiPk9TiS+p+SQ0fbw
	 64/lQN2FCEsdhQ28D6Fr5gfIInYowUVedcaWl76QPTEyrH23ixqjEgvpNdJw//3dK+AQp
	 2HhJGvOvdL5XepEZZmqZc1ee2U5bkYZGO/bIWeHjGjFIAy32oIPUWdUfZ9ze1eoCtVN4q
	 jdLkaIAHdWd20iQt1EZsO73n5UVu+B9tV4XveZFURjLTfsC24QC5DUpYC5nb5jowWg48k
	 oklqUEFy6uTbYOqhsFjx6hnM8pWojLrkBAgX35oAUEvPPhxsAId4m1AnlpqKei4m2XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="I/xgKncw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED82606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AED82606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I/xgKncw
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8565d77c277so23883937b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025858; cv=none;
        d=google.com; s=arc-20260327;
        b=rJJZE7Jb74ypI/oDAQvkQpJJt2Sn4tbuuFV5AnoEVctyjRKMQlZFhELYObZhzlcQcK
         hk6tOVMD5cA1g7xLlkWCN3AMWXb6KGtPl0TspJkxxAETNID9znP9EV+bN3MXsXIQhPHf
         /GtrruGLe972iUzqgygwbNq7Rm3e1i7vCNkan0/F+gV65wgWQb3AHBcdV5xL9k0Q3N66
         9E4NGdCyHddewHChOwgmFJKN3bLinMiWFPFY4V4EbbHZjzk8W5Cj3Nwdjr6Zxwz31m4g
         rp8XjjN3sL32yc7mpMPfiQL7FLRPAXCXoDuVd09q8jBbfItiR+7OWnWgPSGhZ0l5a4rb
         1g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        fh=ZIl3a9kjAXqxSO04jVHYpGgaOplQc+Lmqa+L9XaT6j0=;
        b=ZErhQeoyTVVHVCSj+hfnQp2d6LHR7OyUuZ5Z1IxquYMQsIgp6gbDEfLg63VKc2uAJH
         D2cr923SrAOC/p+PaV1FSvhdXK9CPggdtfqyo6vrQiRW3zxsU8LGZ03LGshBo0YMBHbI
         QtQb9GRgjX7BNy7JwBTKsEOCqFzYbm2pAib61qWOZe1Qth6Er/FhoQNW5ysJQ+IS1M6S
         jS4fw3PM8Xjn07cpetIz1FSuz0tU3IKgOXwq6DMOIYAgGP98/f+/VaLJkyAKtxnxNvMY
         kNXPc7otG+sZvVo49tdUCbZaK6SdyOxrLrp10d1K7eU4EgYOFW28B93K7bQF6fsDGVX7
         95qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025858; x=1793630658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        b=I/xgKncw7HV+TXyHup1s1Yw9AdSQRFiuKXpuTkCcgMvGeODn1vciZ1RY4PNDZxMlaC
         a7jzFx+vF2U7Dts0T/DNIM8Jp7UN5FIeqcSnZmY6MHYhAfUkcN+3sH8hRFIwZ943c6Ec
         jf7ZguBPUZkNeCJIwVhsn1f92FLYLMc22WomtJaXAelOoJG5i2L1zOmXc6Jh31qLmd37
         vwJDBZ1YaDxK+4JDu4Q/vY5P9vOOPzivy0pYCF8r6AOCDxSlBJ2EbRBqUR7FFFhO+Tbu
         q3ReC9DZPEkqD/k4c10F8Gj9867irKBeNjMPoRb2r/0RmJO4sQqEb1Fy4U8B2qix4ea8
         nxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025858; x=1793630658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        b=lrw4WmM/zcAIlD0txjZLjzmq2ntMDsxkOv/dDqwBbdFEw4M35PMJO6V+VQIOOUuvS8
         qcGXDfIhCPkvkB54uG4SiV9itX2e3PL+ehaHX/Np6uShrxLd4OkKTA0wSfCSmABFYmQd
         ysiEKKtgx4beiEHZArxPi5s8YtsEGs607CjVCwaLGt6so/RJMYMKqGmXVy/vmF5ViUsv
         NX1pbg9anZ4KHOJE6+RRAyCrocTnYOfRLEapg61WSzq+c1qwlHTVhvjCXK3c07NCeolZ
         wByQ4EP2V2SPwKERb3hV+z3LxLLPUOaFsb9A5BinDGMXvkJKoiq/be8F9kLpfFAoFl+W
         jFGw==
X-Forwarded-Encrypted: i=1; AKwUvBz/Tkt+Tad7hBiNeebS8xvO8RQJIdcUEWQOJ88joBred2t+yuDwfoFbVXx4JDuCZR8hngwKr+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpPGwTDtttuDFFhaJ/4fgNWRzrEd4tAc9C29SBRZQ9MNp9ue9w
	O8heRp7LnGYIrRTGcGZYqPEMvUTwYthNm9aad5IJHiUUjlJK105JaoM86qG03aWjfNvSrfhm+0P
	oqWLeuvIaE2GxUl/9/7+Oo5l5Z0xstW0=
X-Gm-Gg: AYBFou0GeFpNqdf/Pyd4R9o+fKMRucweI7rOjTx4MXP3HbkQTFH7thLnt+QIzPNaFrN
	vEzgPwv3pBqRoqYncqNtibjhSi0kF0CND/FpvTZwxGSnjFp3lEKp2KhqfYfbH4DQ8KeDOm5X/5w
	HpZwTuCYkhhA9csQMZmeE+jVUCW/wnbIo4Pncu08DzOfRzp3dcqQjZvRQulohBkJFpDBhzFo3mr
	kat3TZqpfKrftjQ5aZZDtcnQHgInMat5sOEgsHwdgQD6nNsZk7TbxBblLjQM5oSWiOqZ1+yO3zm
	NGNAhIgdSuqc6u7gex8VF5k/+15mk/9QNzdSaQD+5KrhxkmGbY/Zy3NTfltzgscJgeWyNPzNNme
	iBmoC5Ws6EZi2oKlRgDw6etsNLiClc2XSsbhZDBc=
X-Received: by 2002:a05:690c:e3ce:b0:8a8:8945:c423 with SMTP id
 00721157ae682-8b166c5d5ebmr46729927b3.56.1793025857715; Mon, 26 Oct 2026
 07:44:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
In-Reply-To: <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 26 Oct 2026 22:44:06 +0800
X-Gm-Features: AclHuK963cbP9FFGoa6Gs50d3hUXJxO6-lmlfnE174He_utWipWjNu9DcJLD_EM
Message-ID: <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: Eric Dumazet <edumazet@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 20:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Adding these stack traces without symbols is not really nice.
>
> Time to use scripts/decode_stacktrace.sh

Sorry about that, v2 carries the report decoded with
scripts/decode_stacktrace.sh and trimmed to the relevant frames.

> msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
> tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
> under rcu_read_lock() is safe, and stale values are fine for diag.

Thanks for the suggestions.

Best regards,
Cen Zhang
