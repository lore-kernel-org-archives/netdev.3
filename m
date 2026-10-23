Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770210;
	b=l+pfvEIjA3YBNDptUJsRrvS7oSeklPlWkuC/hAx0nF/GJaZNZ24j9XVvPsXQ98FUSof3
	 uhmxsSgVC/SE/GoQOBYcDWX0pP/n455/Vvdq+5jATdvcqzYE4E8mVCL89Uo/Vkt6sXz5q
	 7+fV/QU/eCtVRYfiPEe/rdeNNmfILG921ZcNX0PDiko1DxWO/kRdxXCr+8CyRE0+BeuJX
	 zxUvyFpcEEWYDp+oh2JzV2BhkO4SxJpftc8qVhmrRWe1K8PnZ48NGeKw3KBBzcaT2VDge
	 fD6dUjMSkUGpAdL1ihoNi7uEw12rBoCob4T5ttCNkvyfcQohhe/5/YipOqz8nYlMAPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Subject:From:
	 To:Cc:Message-Id:X-Mailer:References:In-Reply-To;
	bh=1fLxVvU6l2OdNDtbk5He1nnqtfD8iUYuKeJc79Pm0kU=;
	b=zJOPCDaCBUECTvAstoBmJz+M2VP1fB+5gRFuWqcg32fGT+qCXY7KvC+xIucWjgkOx4F/
	 +tL6VczyYid/25bs139FJ2sIsLmr39HWtejW3EdxfbKgDt2WEzy7fUHXYWskpKa9h/kI9
	 IXh94usmclXJid0qgsVDJ1C4uxcneT/1NsDUG64r+gVV2kz9yXu5MP+4Z4A8m2kksrlfs
	 OqN1BznmRo6LpKq6tuXFis1s2zPdJNs7NZYE4Q8ySdDaA7iLETd4w7cEtVP0wIXc5GnZT
	 JpdSX0wNYH05Fop7PwM0lNdnW2qJ3/BvAKSdGv1sIyoHYhOz4/iRA2Erlld47vUgXEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KV9ZGFk+;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5D606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KV9ZGFk+
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1093947f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770209; x=1793375009; darn=vger.kernel.org;
        h=in-reply-to:references:message-id:cc:to:from:subject:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1fLxVvU6l2OdNDtbk5He1nnqtfD8iUYuKeJc79Pm0kU=;
        b=KV9ZGFk+C9ya6/MEwsixpqCe7WqLcQQ+u98/RGyrOhrU2b9BXPWxATa/tFEsiQYA1a
         i/9jLhTNhQfdypo6vapCeC2XHWZIO0OM5Y6WABR+gKMGyTVPTNzUrGWdof0LgiL7zWXQ
         0LYUJIReftYdIVggzH/ic7BQ2zdh/e7CY2NewcuqnZvvfOKu2Gn3fmjCDC1ilux4cBFs
         ectcHZ1cZ+NHTHMcCv0iXyjdtMAx0QXREm0lHPdDHlyeMSZT+eMro5jqTAjFFmLvK20p
         FC52JvuR8bJhx1z2eE+7BZdJUsPx8G0jVKnPliPjmQrwOQuBL2zuMhg6EsR2iXtbPdRj
         AQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770209; x=1793375009;
        h=in-reply-to:references:message-id:cc:to:from:subject:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fLxVvU6l2OdNDtbk5He1nnqtfD8iUYuKeJc79Pm0kU=;
        b=EB2Asdi7wuOil0xREy+I0jxYD4na8Gn+YLRmxtIJ+yACUppVzY4UfGxCuH/rnGv2Cn
         TwdQazs4vWjxK/JNhPasT+Sj314mP6rXfUiZxOWwvcmc9i+eRrjT8u/YrlRixFpEcpDS
         Z4UJJgbq9ygoSmM8II3VJG4Jl9wCtvDwi/Qp92iH7ZxmFhQ7SKwp56CFiP+hmKk/LNhI
         lhbGalMZHKYmypUchVwNWzMHd64odSYEYrF0dkKCGiSHiVL0Lq1hVhfb9nMOnlRBgkSc
         mQHGp6h/oybl43DTGShhfUqSdBgGFTTH4OQtzeTW2VNo9/BylDWXvTDyBmf7/Pb3yIAm
         VvEQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+h3igVMolHNfKh+5fR54gBiy/yJUo0YWB5qBEuOlbY7vqGYlVs0lHoS3GnhYGtoxceKzeomM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLENPGm9F17kEHHMeexXoSIpZ0f76gGFKJOKwGAm0fElcqOoGRC
	9bTYreqkm4jLMKaptLxMNxnQOZ1QsK3CVmTr9U9bSRSzTOZxlIrSt7ndb++Nul1V
X-Gm-Gg: AYBFou2SK4sXC8/7lmbHscmdYVbSOXkXBu85AS+UvWTnANxhx5LJPmI6lJWd8r6cKdJ
	UQDU/CwGih4aHG9GAdkC0CFghehRhG0u1d9bX0XaXP8wOY1Q/YvDFYFZ2i4H9jQIIS+Ucgqf6TP
	RFvzmhR9xxq8ktIixPpxfJd/ysiSqw9ycWHVDGYHXn/4kMcx9Svc/WAbwuKH8WxuVVjDUaZSROA
	50NT8XMaIqfnX1fchRk6VuqwvkCDMpv7Y+ZD9lbq1kNNvlx6lgYPwRW/L+eAx456h7YJ0mGuOCx
	4nQimhKM4f/eRujIxJJtva9K2grWEWstAAC2UIaIeG0jmx/Sl14Ofvc0z1Cf/zbtqopu3orDH5U
	G3WsNA8lCNEgesiaw3F/+LDfdFkPhE3wnNHgyRW6KDuNHv2ps5hmxTLin5uzddb5rp5YVB8cVAQ
	YE41VhUj3LdBrcykACEgUTTLhSiwagX1Gq6CQU6dgVq7U4eZ7lyRxRhajB1dEqW/q83sjakZuFT
	UgC+LFMRrW7Yqg8sQVo2OVaS76X4a+L5h85mQlIQwFrHl5c2BrYkKu8SsuDwzW3ZWKKJ4dEE3vS
	w82R/yPMY9dlnbCHlE7Y
X-Received: by 2002:a05:6000:24c6:b0:488:7d08:edbc with SMTP id ffacd0b85a97d-48e385b1f9emr4318077f8f.24.1792770208492;
        Fri, 23 Oct 2026 08:43:28 -0700 (PDT)
Received: from localhost (bzq-79-181-189-120.red.bezeqint.net. [79.181.189.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d421f65sm510921f8f.48.2026.10.23.08.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:43:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 18:43:25 +0300
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: "Pavan Chebbi" <pavan.chebbi@broadcom.com>
Cc: <mchan@broadcom.com>, <netdev@vger.kernel.org>, "George Shuklin"
 <george.shuklin@gmail.com>, "Lenny Szubowicz" <lszubowi@redhat.com>,
 "Michael Chan" <michael.chan@broadcom.com>
Message-Id: <DMCBZ8FR2UYP.2G9NV2OYGYYOD@pve>
X-Mailer: aerc 0.14.0
References: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com> <20251224165301.2794-1-noam.d.eliyahu@gmail.com> <CALs4sv0BdhVHawBkkxN2v2o_jqGyFRAe1RVJjGu9d08HM2Jwug@mail.gmail.com> <DFE8DLTGB5Q0.1184HJSQ0DHK2@pve> <CALs4sv2Fua=QqutN01raaUojNxJr+jrUshQ+riLZAMPKKhCv9A@mail.gmail.com>
In-Reply-To: <CALs4sv2Fua=QqutN01raaUojNxJr+jrUshQ+riLZAMPKKhCv9A@mail.gmail.com>

Hi Pavan,

Thanks for circling back on this!

On Fri Oct 23, 2026 at 6:40 AM IDT, Pavan Chebbi wrote:
> We haven't heard back from Lenny but I think this solution should work.

While waiting to hear back, I worked around this locally across my environm=
ents with a custom kernel. I also shared the solution in a few Reddit threa=
ds and received positive feedback from others hitting the exact same behavi=
or. After getting things working locally, pushing it upstream slipped off m=
y radar.

> Hello Noam, bumping up this old discussion... do you want to submit a
> patch for this?

I would be happy to submit the patch.
Locally, I had taken the quick path and stripped out the code in question, =
but for the upstream patch I will implement the proper approach we discusse=
d: keeping the DMI table to guard the conditional tg3_power_down (restricte=
d only to models where the original issue was observed, e.g., R650xs) and d=
ropping the AER handling entirely.

I'll adapt my patch to this logic and test it across different firmware ver=
sions over the weekend to make sure everything behaves as expected due to t=
he date gap between then and now.

As this is my first kernel submission, could you point me to any recommende=
d guides or things to know before submitting the patch?

I know about:
- https://docs.kernel.org/process/submitting-patches.html
- https://docs.kernel.org/process/maintainer-netdev.html

Thanks again,
Noam
