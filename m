Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793570937;
	b=ho7TBl7Wr9jYXrX9J+QEbWenbf8xY89NSDXJy+l5JydA1cN9i2ehmGhAUnhsXCI9dbMy
	 CfwNDlgnYWstjym+96KFLNnqFB+xp+BhbuuClW2sHqCBVFSaUR9juuGPCUaly5pW45mEG
	 3Ydy8eDQe4cAVamc5LAcrn0MK5ug9VpODEGPh1VQx2Y0QANAb6o+2QHeAcnIocUnWsHrC
	 LazVAAWuodOGY1xk2FUolCz0CIq+qQ0f512fmm2Eey38woIL7x9Y5pzTBmxLEWtywbS1P
	 xYYE+y8Pa66TINIWFi+KIa9JnnjgUG4a7WBJxgfDI2brSraznaY8RO1Ti/kaZSmaQHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8n/anYiLG943D5EygjwRlnHVbCkU3yfav7PkLTwYj2Q=;
	b=oYErK4UaTntj9rwKWT7zYnV2k+8gsn+ihfV2bToPEnu1/Se8JIjyK6glXUyDHck/TcR0
	 bNYoXcPeobbaUO2oo52rKc0M2AzmjuSZzhOYyc6T68Q7NnC5uUIdkj4E+iMo4qjjvlchj
	 quFvnAkBx5acbJ8a56noNDT7PEJF9gv2AoP8555I8aqYaMQr9iWU7LcXaAZtpZ/SkTYfJ
	 zrthJeQrpproIzEN1IxZ0zebeMvNqPWf186CLfkoHQZ4Bs58zxBlYAHi38ZfMvZ1zwRqB
	 5FLusUhRCn8W1waYonNZznIDROrCtqHgz5B90RCpVU3cVQm3VlcWR0rDPxgKAJa15Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbyZmfRS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F3606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9F3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbyZmfRS
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso18203337b3.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 14:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793570936; cv=none;
        d=google.com; s=arc-20260327;
        b=HxQcQuxnDfdy1hTngKaIo9OIBiLf25EyFsVnX0CEgjsvjcGUSf3GfodJXlZvKNWX5Q
         lHBmr5ehvJLcztRL4caSMSNryBkCpkTDcH4kFkDYSPaZ4gJaMYtTKkUtVT19qY0hxaxa
         6//QBVVArNyMSzq0gilhdjobAawgPLlnl2+8kQBePpsvyq+YJ+XEa2EqiC7OfBKlj4dw
         WGADvcjPAFQ1w2IMUoc6f+186BF+GmgsfEgSB32IiJDdZM26yIZElYeOt29ef6Zloxhp
         yhmLy6pS3pBXBm2OyU0plIAzd62iLmG+7tudbUzuZvUE/35oAFWXI8IuxxppMmPeZSKV
         AZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8n/anYiLG943D5EygjwRlnHVbCkU3yfav7PkLTwYj2Q=;
        fh=SH4xECfYU23JOav2o1NenMVa4bA8BYZLZIvXSJ93KxM=;
        b=gBQLzg9aWH7WLmeDAaOgLpxkA318meoBARLXAAPQjL5JL39h/Slq0m/yZerhjHZLd3
         tlmZIdjY2kIdFkuuqqjpXCvILhS1INxr74qRL9v/fDnNaOYlYk+KSz4cfTFyvBibUvpP
         uMa9v61/VhCLDmxRTUbUjX7bPeoQtFXeQw1UHDb28RhmMXf7Jw1eSNm8s6Q2M0eLJVmB
         /ZdY+H0kuv0hhhO3soXjDRlEyxFDxLAXOLGYb5cjnu33puo2bmcenIU0/+FtUbpRInMV
         N9fIWvciRgPilpWMUi/tgNYv5xktElkN+Crdy7sB15kRE4Ggl6O5PVNyBhmhvTZEun2A
         udsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793570936; x=1794175736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8n/anYiLG943D5EygjwRlnHVbCkU3yfav7PkLTwYj2Q=;
        b=NbyZmfRSnlR07rxCGz8qtFy5O5pLkKb41xrU2F0jPZoFiRJAqopH2gmZA2LIGwIA2O
         zdMHrveUgwpbckMETuBNOcrtQHGflc/p/OjNwYTvLhtKtYkwCvOhq7W1hkpDyOHj8bmm
         NJmvEzClpm/fM372xoJV5tEXXAR5IVKwCRr+TOuBlZlxFwZDiSWNfL2jI0Le1gvMp8u1
         ntde6200hjK63sXOFCaYPUvTb4jRgdWDdUHLWpf6SOhzczXQmwKmXUQVJy/h7kzfmeye
         o8zEMj09OKQNNLP9QIbLKV9VQwnYp70rkvJH2cmWTP8FZrOe0YPMohvuKhKI0IAtHMoi
         tYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793570936; x=1794175736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8n/anYiLG943D5EygjwRlnHVbCkU3yfav7PkLTwYj2Q=;
        b=LWIF2/G8tD12cMaHUZG4MPloDxVkSVzpbEW8RuB4/mChkVzEwvUz7msMdIki/40fh+
         PL5H/jtFmJDADSgUK8kpwlHYZKuTW/riEJCpP2vLgWwkZu/FYmEORIPN8yX6qC8QZQJD
         nwH21wdzMp+k/kWsxr3O5xoa/p26fJe5P7caGr3uKt7zJkxH5AMVUO3R4/irHfv4Lfi1
         YPdlI4nCQz9V7VVrlAPYq8Hjl5MNDM0DZwmphWJk+XQsY6UzDQZAYvlW/Oobaaj2SDE6
         1mT2NxhbZluAAWEF0Y5ctY74cn4AOA/oat6sH0AzF4DDqp+ib+anw4xoOFQRFmh/qrxn
         qukw==
X-Forwarded-Encrypted: i=1; AKwUvByG5rGRAkWwfUVqdNltneGmsE4b2ki03Puzr1a01bujc4OeAJzs2+a6jcYOCrv5JrcfHXovZwA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9z+9P2imN3NZDiEVD5Iu/L2tAmbGEwGbNO9TLXe+8pIcC7POlt
	8zbjnwAudktwvtIPVZ2sG0nGjdVORQFSn9AHlfc24+peSNSdyou6qcw2YwV5YwDvkDKjrgirH6Y
	Jqz5O8MjIBaU5xhYAo1Fcuog+ZBVqMPA=
X-Gm-Gg: AYBFou3jkoyRLB7IMIl4q5GOKDOXNwW28MSShv0TimBB4CWGjJ8oab3io5GGIOB73oJ
	BgpUkd7vSSftKVB8wBqycsZAToWuDtFbF+cK9wZTjq6g2Cg+01agFRVKDB1uX9yaRtaBYtGwUEP
	VUhb/EETa6n3BJII3x7mgAAsz0lo1BtvurxaN02J8B37z7O/ynQBAj87m1qqZMTt+4DEiEACnD4
	Cup27kPmJcg+hi7yUMOpTxbPNYHQRUvTM5froWsXEnPB/yV31PVOEd2XFQIAzfI7ysaTZxmxKf+
	EbyPONRLpjrIeW5yi5USTU+IwovkXBTkv1dc0mcDSirzBLYH/huMK+FNriFf6tj6mBcuan3xDZU
	ZOUXSwLdqfZBgrY0kJ7CmdEtucw5p1Rgz4EruRtJvxY/JnAMDXqaSM7YX8S8YdJQNEbO+uaWTKO
	dCE9vB/Rbcl9GmDlISB58y09I=
X-Received: by 2002:a05:690e:4006:b0:678:80a8:9a02 with SMTP id
 956f58d0204a3-67ba4ede517mr6000936d50.42.1793570935715; Sun, 01 Nov 2026
 14:08:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
 <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com> <179344707641.114606.12665582704521593779@cmss.chinamobile.com>
In-Reply-To: <179344707641.114606.12665582704521593779@cmss.chinamobile.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Sun, 1 Nov 2026 15:08:00 -0700
X-Gm-Features: AclHuK-zfUDuhrVjSiZBc3Vdhahij_jloXH0-toEDdIfq8O2PD6sh-2K1QlBU84
Message-ID: <CAMMLpeQKJO52qhba=G-ZudUA57iAdX4SOapOv7YuprBZ3FzM-w@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	yana06070@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:44=E2=80=AFAM Xia Yan <yanxia@cmss.chinamobile.co=
m> wrote:

> One question on the clamp added by f4bcbf360ac8, separate from the
> wrap fixed here - I don't think this patch needs to address it. I have
> only followed the source and have not run this case.
>
> As far as I can tell the clamp's termination relies on cfg.valid_lft
> and if_public_preferred_lft being finite. Consider a public address
> with both lifetimes at INFINITY_LIFETIME and a large regen_advance,
> with no wrap involved. For example with regen_min_advance=3D2,
> regen_max_retry=3D3, dad_transmits=3D1, an RA Retrans Timer around
> 28,600,000 ms and HZ=3D1000, regen_advance is around 85802; raising
> regen_max_retry via sysctl has the same effect.
>
> If temp_prefered_lft is set below regen_advance, the effective
> max_desync_factor goes negative, desync_factor is reset to 0, and the
> clamp engages on every creation. The clamped preferred lifetime
> regen_advance + age + 1 then passes all three checks, including the
> new one. But the temporary address inherits the public address's
> tstamp, so addrconf_verify_rtnl() finds it due for regeneration one
> second after each creation: one new temporary address per second,
> each living about temp_valid_lft. Creation is only refused once age
> grows enough that regen_advance + age + 1 exceeds cfg.valid_lft,
> which here is just temp_valid_lft, so the accumulation is bounded,
> but with the numbers above it can still reach tens of thousands of
> addresses.
>
> Is this finite-lifetime assumption part of the intended behavior of
> the clamp, or would it be worth tightening separately?

Hello Xia, that is a good question. In that extreme scenario, creating
one temporary address per second is intentional. As you noted,
regen_advance is not a constant. Before I added the clamp, Linux would
just stop creating temporary addresses if regen_advance increased to a
value larger than the preferred lifetime that the user specified. No
new addresses were created until the network interface was restarted,
even if later on regen_advance dropped to below the user's preferred
lifetime. Temporary address generation was effectively disabled,
eliminating the privacy protections that the user thought that they
had enabled.

When I wrote the patch, I did not consider that the temporary
addresses might be based on a static address that has an infinite
lifetime. If having a static address causes Linux to refuse to create
more temporary addresses after a certain period of time, that's a bug.
However, I have not been able to reproduce the problem: On my machine,
with a static address, max_desync_factor=3D10, temp_prefered_lft=3D30,
regen_min_advance=3D60, and temp_valid_lft=3D90, Linux 7.2 never stops
creating new temporary addresses. Is there another combination of
parameters that might cause a problem?

-Alex
