Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294006;
	b=a5zJtaze61wKg9da5J/LFY4ZOVepdj6fw2HhcXca0Wb+jcJZFtfXxp8lAOJ5hcT3k02n
	 FuVdrQdNZGRsYBzP6WbwlXoRl4t3DQe8d6gxjsPu+15dWX2+mJmhMlSo5yUsprpiPWrkC
	 rze/RX6Nd/nX6efPepH81W8aIKnoOQpmIZEU4vWTzjdCx3nD0Kj8f/mE6iExf1+zJIUpa
	 E8Dkh8MarWdhFrLUH+dSv7NnGWVXQaZS0mPkv/SFG3t6I7AeqEM+guy2nOfF/F3eCapKY
	 fRfmI746vKwXtFBzLN72otbJ4m78wURfkOaJ8Xi+OWHNj4+AgPKMxkZt4iFRz5LzQnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s5+5N5HGntkmj4RcBUuDntjmqsknb79+6Z4jRjJ1xOM=;
	b=tKiMpfzDVVeksCwYbM+VhWS7Xfbuz2vgApOaSd1ubpfzeMuOI/mxPqEO5EBeKwxvV89t
	 rUEQpRwIbO8pgm/mWNXMnNtcdcrPUJVifobf95XG0sMzJtmXY9nazEI4GS777+Tf8p0nM
	 +VIkYBQtJNIdJeOaSGhmHL3iPn8q9X7skcgBfgDlU6eQCKlMNUGKTPf+tjd/9L8Msfs5a
	 s5vyMioQsewBXpWT3KyVcNNTYo5NGXbk3bB4Kbzt7M9hI5C3oFo5NsFmLRGdNEQ3iDQbK
	 tFv90t+Apuaw133rhhBI4O+1Rvt5Ug9PlD+VF05YoYMZtUo4hJi6jzHDmJPDbHcDm1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbdPfDx0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A51606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbdPfDx0
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1372275b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294006; cv=none;
        d=google.com; s=arc-20260327;
        b=IVYPx97vP+e2X7GBddwMHjCwzgMg1ii8SNvjgvKctXNuXMIVsjQlJw7UFGwrUx1dyW
         MJCAFHMThPs1zysfP7oKuc2aYUCiW6rUscHHG9zIWuoR8vf/RihPG1MdU8EnQH1LALZ1
         a573prHOMzjgBt3teIHflBJ91L9XRbRBfsvcr4STnmOxpL+j7B0FlcsJ9HiyhekGk1km
         acJusbYZkb1wKDcgvZyyQq+OAzsxwbOf9UEUDqQo2GA0kseqkz2yGqsCm2ree9ajX/zt
         5vLdVYwKrr6GZe40bBEhppLoSr2Hul1VxAZdZ7c/EVtw29T3J9bp63KsLQ4JXe8uvSn/
         9Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s5+5N5HGntkmj4RcBUuDntjmqsknb79+6Z4jRjJ1xOM=;
        fh=y3tWvUZcr227IDsQtONXvDoalcZVAT/XF6BA5pzmnH8=;
        b=CXjm9pJ83h31aOI/98iRAUsrSM1US6aYEtOL4yFi61LAEGB1srk7k3IpXQOGePNdAE
         KSORF28Ue0RVHRq21cFWwlDjGZfO8drpHynZ3Oi6fd246f5klUtgbaXi/rh/T5MhD9r3
         YpbXQqRr/VskQj1WUPvb/2eqemqDwyuQ5FtvQRKwrvv2H+pBMase3gj/A35+6VfEKpQ3
         Mhr1TGEVAMwPyyJh6zF6r+eGheRoT9Nhp9jC6Z9hnKBjJURzB3KAI8NPkNbrKAEhf7g8
         b2NM6S/3mc8wSfyONXyUs7w0hwbyO/+yM3Sp18vhkTdAf/fsOKkOZ2jHCXJNgl4QeI5I
         Q7Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294006; x=1793898806; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5+5N5HGntkmj4RcBUuDntjmqsknb79+6Z4jRjJ1xOM=;
        b=nbdPfDx0IXFjQq7RSQX3y4BmGTzipwsChuP4gD9bwZQHuCu5OhdLqqcPiUy25jRhvj
         3UItqQHXKWXO97FEqTo18XtZSjxIenYHhv/0u/d+OaZHwkJByvbD7NVP+c62HhGYT+II
         B/pUeoqGRWW4RwYOhpuvWEXv0kE0XV91UjgNXXIpp1/8NuPbq72cDY7/dxAAx6PFvkEH
         GB1cJ42ebyinkO8uRB7JGAIvOr9UjwEMVm51ApyqTinxICRwR/EocWgs7TfqFEP80AGt
         7ce26eHoO80wvvc4nlhvt7t53apKBEgXPaNDMoQbdg5vjKaZRfk9AptY0mpgFMT47Wxx
         +q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294006; x=1793898806;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s5+5N5HGntkmj4RcBUuDntjmqsknb79+6Z4jRjJ1xOM=;
        b=aU7njxYwEwcA5eEc34BykJe5FSXNgZN/YBUjMfqzX+Cm34SBFTI569s/HhxIeVnLEz
         rC/5JYJzGK5tBpLS9XXZ+B8IhJXPyiJckRtMNCqV4YPCKY/QQ0bx3X7bmEPljoRhs2By
         VVb3Up/HiJXFLY6gAGWrvauX8ZY5XBY7E3p13MwXdfdk/hKQlBjNU8rz8EyJRcT5o+do
         8xbM3R1rwfcGYCQVkrWxBWsrvhd2j/+nHNoz66XTu4TyNPl6UnURhm7/IQ031Lt3SQbQ
         uOnNnjp6/1AXbX9LyEKrkOgHeX00kk7dW8EXqsLSlJ7Ifdn6P1SV2ESl1VytIcyD9Y+U
         2owQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUtUg0DAq5jaU5Emd4AzfGF6kqPxtn5R64PbwTY6Zneu6SEWgyvu0+FuJ0a+BJVB+jbNGErM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0EYAtqVNEOspxl0myfxVRinT2IepAB0G8otv79eg4RJUAtyKv
	twHP7sKPC4CERslvX0BaQUwiHVrvS29PRkkRiwEo2qgW/9Zy4t3mUgO4qpb2NIyAtaBl48eaeFd
	68WGBpt78wYhaKJyUn3hKUUgIA8n/o634zoc=
X-Gm-Gg: AYBFou2WVm2vO2ry4tOIg/iTdjmF7GN1r0ojWFHAFgVFehoaH24JBqKE6177shLmGMh
	HZrTzRSbQ7/F4rTIoxxCDZqPo6voOVsPA7l1mllmMKq9meLn5X+Idmgkubg2PAY/izZJcPHOaVb
	ti0dcuUu9oMJdzIFxN8qgAASrK+aci963P34rumnc8WlsYOCH3zWUkDcALITG7qGHBliH+wSvo4
	vovodBy/EnMSiQJSi+82OrHGWV5olZfvHVyxXU7Yy+RoCrhmluu9dyDKZXM4eShulz3WR9YM5Ve
	K8G2ZM/SCVjP4+Y3XqOcBydZE6r7WBpfHQchUtiCmAsRNWXCLwKutTiSA7qpR/rBNmqzrplcGfr
	U1/1buHzGFI2+/GKg3SJAeBrZKfSgnwVBZJ4Ndae9Mo+9hrM2aTlC0W7RUXORiOLf/2A=
X-Received: by 2002:a05:6a00:4187:b0:886:d769:615 with SMTP id
 d2e1a72fcca58-8a6e4807027mr5553713b3a.1.1793294005838; Thu, 29 Oct 2026
 10:13:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALjTZvYKHWrD5m+RXimjxODvpFPw7Cq_EOEuzRi1PZT9_JxF+g@mail.gmail.com>
 <CALs4sv2vN3+MOzRnK=nQ_uMXbR4Fi8xW9H8LdX79vYA7tHx+2g@mail.gmail.com>
 <CALjTZvbopTcm9P7Hp1ep54R3_7yODg7r4j=OR2y3WOA1X84e2Q@mail.gmail.com>
 <CALs4sv2DgtkcWtMSsMiP9VLW98+5T9hz13j+O3qnqKYce6G+qw@mail.gmail.com>
 <CALjTZvYPsYb8FYsmN+YSO6U4UGPRGJSbVyxCmAfVQ4jSyBSzMg@mail.gmail.com>
 <CALjTZvbs2JP555bT9NGp=WePTP7KVue8qPtisG=P6sYV+HrTWg@mail.gmail.com> <CALs4sv39-Jf0_fivOeXMtF63BinbaZGkYgMPLiSa2u7Z3UxeWQ@mail.gmail.com>
In-Reply-To: <CALs4sv39-Jf0_fivOeXMtF63BinbaZGkYgMPLiSa2u7Z3UxeWQ@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Thu, 29 Oct 2026 17:13:14 +0000
X-Gm-Features: AclHuK_IUF8N0bgiO5KrGEUughNKa1c3HXPerxWihMA4gZWqZN7Ci_8NSv2REkU
Message-ID: <CALjTZvbU2PW1+sxsYbzYHbUm8wSRV2yZ8BXLP__EZjFLqbW23g@mail.gmail.com>
Subject: Re: [REGRESSION] tg3 is broken since 6.13-rc1
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Pavan,


On Thu, 29 Oct 2026 at 16:46, Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>
[snipped]
> In fact I fed your kconfig to it and looks like there is a probable
> cause in CONFIG_ZONE_DMA not being set.

Good news, that was the issue, actually. It's probably a good idea for
the driver to depend on CONFIG_ZONE_DMA being enabled, then.


Kind regards,

Rui Salvaterra
