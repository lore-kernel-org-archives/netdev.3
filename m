Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793619891;
	b=UV88+RvX1+EkSK4IsaoFVqT5Glfe1YaepUgH3iEP3o7ZqDWE7IHdbRmgYWo9YZywNP4a
	 dvwbOHfF+6TUSL2ShYgsfbKIGA4tMvrWMEkq5v2nhxTXBOqkRf4eopKseerO1uAMPNr9I
	 c6EP7eIlxdwDzKpYuNbYSFvmVSQmXf4PPfsNie45s2N11UaUQeCGe3wQbdZZVPHF7kZex
	 TYlg5P1wKJpWlrFis8CqLfvowHAWtkzQF3UfCEdfZk1heC/65CMx/2x9ww7a6nlhjd3gI
	 hGV1eUwitYjHNkuuRH2rP4l5sEQ2ZbRKF5TZz5M1eEuu0L4LvpM+0AWpBuoI/2HgOdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4lCaHcGUCMu2QTUG/7Oh7CJPypRTIX/8Km/fNlYAggk=;
	b=e0h2CA/fLH2FIAk3c4PjEpzUatB8xV5pWlO4fXI1PCrNWVn2lEvflFN7rMJNnn1L6W/V
	 tY5iD/L0WdFOvC0N3hFCXCaSx5sk8mGE8T77lrO8Pe6w5yb1AjR7rVZJ5DbMcrd6LOIRV
	 BkYM6hAQwRQGLjmVJMpeTjC+B+22yrmv2xUUWkcvR5H3fCVIzSGIqCybMbIj5/oe/7Ib6
	 kYBX+2CwHMHsTTzimQ+WA2Rzrzwf9pOG2uY2ck3C1qkAfWZdMiuXluf0+TCUBqKVsApBW
	 sI1hERg9h5XN5UE1jb7h+d0WtMeqiVGNvNq4OBzIWgadiAZgNvP+/RBfCAx/DzC32Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAz0NaP1;
	arc=fail smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA4606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BA4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZAz0NaP1
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso4226405a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:44:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619889; cv=none;
        d=google.com; s=arc-20260327;
        b=N+lk2HSUxewDBOIGFDuNIkx9uujAqwbzaK4QkEWbChr5tffxU910o6jjGx8E4CDVKe
         tlm5dx/wtCa+EKJe9V5JYAiNvfw5K2LIvisa4gwZQW7v7hndOHV9/iEGcQkL5iJKjgk1
         t+9g+VnfteYG/eBphDMhMyjPzoZR1frR7Nz2e5O4y4bpnOjonUvrF+He4veXHOupL1ZD
         2Um7fWkvA+LenVBVz5wTYVMsEym6/IGOoA6CVp4JLswfOvH5nurRaJjM5RhLaWr6bXno
         T7vXQHGsbFgQ0x04dw3Jt8KU4EkbIC7XNqu5H+sLgmErc7SfYwottrxotQ4xwf7M9gWJ
         xBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4lCaHcGUCMu2QTUG/7Oh7CJPypRTIX/8Km/fNlYAggk=;
        fh=d5XuOVI8a1HzvvOPm8kM73VaenVr/3v7G7chfM1CHMM=;
        b=FAqnj0b7Gqv6CIgHc0757nBC9EhGtjgeITJhv0E4tX9z/c3ZkfCr6+hb4plXOmp/Fw
         TKMi/KxjgDqkL+bFonTlARxMGVwZKpalQBO1sW2szuo8vAh9FRr2wHKTMAS67Ma6k9Hw
         MFh7Nh5ejAOiCDM6/EnuxfhMFRHACRNqNelYJpVd2XaDxdG3hylfjJWrbOrvxCOJwAox
         yFKuTzzDs8juPj/PTBTWR+FxuXXWnmSSXJQhayWqRJsCRUrAe9xrKY4kP5ombnL833xw
         4yjoP12Vcoy+tGTiSwtMJZjMdB7p41I9UagltzYQKh7FzcixiOADjnay9Cbacg/RqTtm
         jhfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793619889; x=1794224689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4lCaHcGUCMu2QTUG/7Oh7CJPypRTIX/8Km/fNlYAggk=;
        b=ZAz0NaP18BX0ezun9oHz1murpqQrqgi9yo4eVAGEKkk3vMCeq9Cy6q5CSOtDLtu2IJ
         fDzUrgJ2soNSFlQ0OTe9SwMFlf8JFoxlhLHs+CYO3eh/Xtii/WG4BYyOJXIMh2+pCAGh
         5Ke5dUfMCBUsxPpTY+wRJhk+gf0KOAqwN2Bc4+M0r9nCGOC2wQm1ojrN8iX3J+gt2W+h
         vUn1CMEEUq+qYU/DPduQne9UFk3Ja2vBTJ3bdoBt2KOtesn/TEvD8DIo1VZGjx92k/2o
         DCGyXov6w2ruhQ3UxvBsUvYFjTbQWJW8OubzqNFF3eWwgpvzqBjPn7BKxlmZBdaK0qSN
         bqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619889; x=1794224689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lCaHcGUCMu2QTUG/7Oh7CJPypRTIX/8Km/fNlYAggk=;
        b=EtfeHpXu+zX9oaSer5fxo2UGOsl18wKfUJOtHde4OUzkCeJBdzQB9xHIHeSQYKTH9p
         X10SxjjRQaFPPRgae2L/reZZbWDBOnLa8X0fu/eL29rquhntEdwYadMeKFqjINend997
         X5G31wfINPrwCI5iRlurJhgN5hTET7mJvwUhH0McuiXVDL3pk5tewm5tQQU4Mzs33Tuc
         fmY9mzdo9RcHD7SH1iv7zfBsaldHLa5/bMqW/Amxpzz1mdZa7tOzkB4uqJT/CCeM4Xoy
         wsQbw1bELrXNOqKMQ9y5QNDWbNoAY3+jopWgB5cvqTfUGX/2EQIENQAwjAqbDhYmUqCD
         /9lA==
X-Forwarded-Encrypted: i=1; AKwUvBx8kFOg/xBBb5bSLFm/WmWE+q1TA2zil08upVySA+lFx2S2bidMzPVDzBVezkdHeJ3eZUQfs2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4GWtfnt9I0IBjImJ7CipnPMSmSqr4RNJXJZvmI8lC3wjzuXoj
	ZFiRNxeLMM//fpz3oQLGsYXrXT/P74/hXTkJH9wV902nE/A3zh0OBoEdut0EGJpaHJslNDvKQ6u
	tMYFhB5R635QjKxEdb+53mVA20ePsBtE=
X-Gm-Gg: AYBFou1nAcjbjSWCaO68WSIMjIruKEk2dtxlJ3CoRf6P7w6DPY5Ia7GD+FWC8ggQHwn
	suuxisABjEWfFk4YZ6hyh8qI9t3RPh3tGj2lW73FOwvqCaZ2zxWnH7ufhOKppQlfRET5R9vJq6d
	+PsuWvXeuK/hDHSEEGGd6g9eYdpLnlH8cnn4Ds/rQXDi3RbHdZrqQRlV4m7teQf6QXeD287a9OD
	ZBHyDGaWt08WiCI5HUBS3dFakY6SYvQDhcKpk7HdyJdHJnBM1ghqCS0p50KUzQHnFZ2m1cKq7Fh
	gErpF4D2tBu5M/joDEmKWpXld1UtZaLacP/e3Cy4VdMx3lviXA/VHX8HO0hYQfy1NC2HsWqNh5X
	1xJzXASgmMs3vbKT2ZSBb6rEaIgz5BCFbM1dzaqiyRiYggru8jsxmFUO8zPFxks9p6QHPobc=
X-Received: by 2002:aa7:c1cc:0:b0:6b3:f840:59b5 with SMTP id
 4fb4d7f45d1cf-6b4d4c71d29mr4850911a12.27.1793619889068; Mon, 02 Nov 2026
 03:44:49 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927131838.6774-1-demyansh@gmail.com> <20260927184414.6c0c8867@pumpkin>
 <CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
In-Reply-To: <CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Mon, 2 Nov 2026 13:44:37 +0200
X-Gm-Features: AclHuK9z8jjLcwsnJfsDSIZ0apXZZySDKKpQ7s2Xoes3fbuqIuVEpNRNi2DB1ZE
Message-ID: <CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
To: Demian Shulhan <demyansh@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Ard Biesheuvel <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gmail.com> =
wrote:
>
> I would prefer to keep only the scalar version of the fused copy+csum.
> It reads the data once instead of twice, and on real Armv9 hardware it
> cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> depending on the core (+6-8% throughput). It uses only general-purpose
> registers, so there is no FPSIMD state to save and it is safe in any
> context.
>
> If you are OK with the scalar path, I can send v2 with NEON dropped,
> the scalar path only, and the KUnit fix for the x86 zero-length case
> Jakub reported.
>
The scalar path seems like generic C code and not restricted to arm64,
curious how that performs against existing (e.g. x86) assembly
optimized implementation.
saeed
