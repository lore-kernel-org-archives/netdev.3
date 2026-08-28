Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2B442B38
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917590; cv=pass; b=NgYN6sXHBWIzyXd8nkbG7qgLaABvCc7cyqyEW5i2mm/SHYJuiW8NbkVtfqQmAgKPjfliugsIT0hekmVe9VPEsXl5dlO/OnPOIwwxEzFLa/1BGAT378K6dlQwGJxPjV12ai2qBb5DgL/lkwieMkdM7OW12UJJwUo55pOjN0aPmNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917590; c=relaxed/simple;
	bh=czq0iY86tE9vmk1UpEtdE66iRV2mN8LTKlZ3L7FI82A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE+R8Z3Uy1XM9Ls+3TD9VV3M9inqZPhcnLPU4fdWeMshhnHD2mEsZzDt8rt2cByZuN1XOhDe3efnvYuflxrrUD3ZVarmHaiLcdovKWYmjLObJvJCCI/tM+GAj0Ok093VH5WoYmz0aoO+bmB6A6nCA+isWsDQT6rvoMg8YrxaKs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUJ2nVeq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUJ2nVeq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so998671a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 04:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787917578; cv=none;
        d=google.com; s=arc-20260327;
        b=lNL7wSynBywHXugCeq0oB9cCv/tEm+g+/pZNg2hoI3f70Vp/yc5se83oUKr3si2DyR
         jwYrpBofLh88ARwuWxX3PXmvzsL0HbpVYozuTfuLbtUHvIcWCgLstpRWcqDnNjLp8Mts
         g+JqC0kHVQINsmTEYvdFdz4eeto6LAQaO434xM3aBBxWOuj1vVUOkh8gQftbrtTuFiMH
         vFaoLxCm0CfJWPYnXLdlf29T5PU/PW3f7tCBZSPfzGa25u4dAtA84krfMPklq98/74Fh
         P7wqrREWFzXZvc+cyJL6Oy8OIAIQMfv4fxQndkJI4/8co2xgbseH++Ht/tYZli+Rl6Nm
         h1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/J9olIsIhTk7fKZiLNVC6UMyj9uo0DyblzLYos7atQA=;
        fh=e3Vp6R3zOhN+nOx4DljuUbsOPjTI3MpzoBPWKFOtqrA=;
        b=hONkXIEJc7Fz25zu+l4sgMqFIvM+XXG7I7hFxinFGGxbhnmwRoAHWqB9b47fWcrm3d
         iXEOz8DdfKT0StvnOpRj3j84t4kPCtkxqUchRMol7lrHkQo+ls6Hu4mJv+JV1rCGIuk8
         TQDY66Mv1rcZdweIkPzQ/SzVhlkY8rVZ4p0YQymF3qgYSnkJTDRTtGUp2Aw+0qYVy7Oh
         qocb/r0N5Kd6eo2McxLzTQP6r5opnYGhmAhzwfxjOFvdU5LK6jIAKbCFL9TncugGhsb5
         BNPT+FWM5mXSpdZbljbD75qW1GHpLTp1Mrgdgs2a53UOZBx7WV3MzV83Ne5Y4wuYTY/l
         icRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787917578; x=1788522378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/J9olIsIhTk7fKZiLNVC6UMyj9uo0DyblzLYos7atQA=;
        b=cUJ2nVeqOcVpyJMcBKkrcCAu4kWacl5pXWrTo58eMVvXrcGGDDYIdvSHWRta51RLtM
         M6ktSWZjpRFDORxChRQqb+R3/20PlGhKfsacV4UoLfu61+j28g2tWUYEw+qeIxHOX1XZ
         ZD0r9E/0BZJPykXfnznoojyDJPyWId0PnMakDUf+kNUkXA64sFcfV+wgNs4Y7umFLJU2
         F7fnIdSpZ0tCKiWdsOLOmFaGRfrt/QECWGb74PTEMFCb/wDumE7gQvjupcX62Y5ZA8+E
         0xn6HgFoITRKr0P5Q8oC2hXbhi4FkEZPXvNkbzejxeFt8bufKi2gUKNY+PFs+puX6tWm
         npqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917578; x=1788522378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J9olIsIhTk7fKZiLNVC6UMyj9uo0DyblzLYos7atQA=;
        b=VK5y4ZPDFaXSxa/TKYwGLg5R17z12R2llfewK/fX22Qz0UfnRAX/w84anG58OYGIiJ
         bvIjEgQvM+sGwRPU+/q2E+ikHvzeoW5ShXpn2Ehib/bbI79tOhZuykrMsle1O1PozK9q
         e6sqwIP62RzAInPHnJKm002YqMBXahCaod/dYo62JhlvM7lY0LuTsu/oKPJbzM/9M2ia
         GB9OPbSVEDMgKy1MOyi1y1OMwsXuJkRe3rNIPbMzwXEnAVgG7V5QyL+FO2mWNOOcn8Yz
         PPV+QOFniu2m2i7SjrEQH9QwiItcFbqNmFcBVWvCEYfQTjfzXh4ZD+ECARU4Zpj7CLO3
         QfGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHOj1EU18KIt7QcJFldc/YH1RvjqdoYJNpBLeIyFmVxwAtsR6s6WPxyu5ADiNm0Ca3PkVnEG8=@vger.kernel.org
X-Gm-Message-State: AFuF++m1NfCueRY+1whYIbf+B3epwvVLSniMfBnWphk3s55TVENyUPOp
	G8gRLg8CBLs2YszLhqBhTWSyMbZfOAo0ZI+TQMdy1elgHyrHro7wCwCttqusIBj+LVSH8ec8Tti
	oFSAxCtWhcKIHawuQVtl+YLRDpoiE3wFJA8r4sWUpIQ==
X-Gm-Gg: AR+sD11WnWtGBf8Dw5d+j+JJKvYmZr5DNapV6U0Vl7OsbV99gR1pL8RoGDqF9p+9BIU
	P9FItuYIL3lSUiF+kZ8EriCcpXpoimJJMEggEwYlHjYOU4YRnP77zdNr+syxYH1ECmUgcN+1EpH
	l2mpAftiE4DrfrToGV9UEPrt/mYlL5SuFsUDTf4R9fgqEgU6YqlHmDLTC5orfhEaMO3iTSFlGdf
	aLhQrZcv6M49mkQp/mFf6w22KUOz2P6vty8rOLFke+npNCwpbPabJUYG5+2q43rN9TafugGL8OF
	tWY5Pcco9IMWZlbQEFx4Vo+f48kgAiWC0MBBSMG08ec1RYm9TxaO8FU7JCU7j4ejLrFazmqW+wB
	BMvyvwzphQrme4HvvtjUQDs73s1J7b9MzfxjQnjiqzu+eVldepy80g5soNnpMp8wxH2W7Xcw=
X-Received: by 2002:a05:6402:43c6:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a60d35f215mr4409501a12.5.1787917578299; Fri, 28 Aug 2026
 04:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSTZOnSYZjqj4AyBpLg2hQfRs6JYZA5H26MwQ+G2WMGgNzBkg@mail.gmail.com>
 <025FFEEC-E57A-4C74-BF1E-D273253F4D9A@gmail.com> <CAMSTZO=2dm21hYcKKeDGCTb4KJ6R0ukDAFBQtsp4QVzPmCfcSg@mail.gmail.com>
 <1EF6CC70-90BC-4B9F-9F96-9DB1F3A69F1E@gmail.com> <CAMSTZOkWe9C2pGS75zX=_H4_Up6B6qSddkUPeaU8=br0geh-xA@mail.gmail.com>
 <AC809A9E-A3B7-4DB4-A267-7A183F60CA72@gmail.com>
In-Reply-To: <AC809A9E-A3B7-4DB4-A267-7A183F60CA72@gmail.com>
From: Mark <markmunene827@gmail.com>
Date: Fri, 28 Aug 2026 14:46:06 +0300
X-Gm-Features: AcwNN1UmI5M8lOLcrjuqT5vvcILd_sSk1zBQiCz1dA9ktvI7z9mOXknkvedT__0
Message-ID: <CAMSTZO==h8Z+mDqF=bQOBOq=icRh8O0okDS9T2x-ovPwt0g7fg@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: Comet Lake PCH CNVi AX201 (8086:06f0) fails with
 error -110 on warm reboot
To: Bohdan <boulderobscura@gmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bohdan,

I tried the PCI remove/rescan suggestion you mentioned:

echo 1 > /sys/bus/pci/devices/0000:00:14.3/remove
echo 1 > /sys/bus/pci/rescan

The device does come back at `00:14.3`, but the driver fails the exact
same way =E2=80=94 same `-110`, never even gets to loading firmware, no
wireless interface shows up afterward.

Here's the relevant bit from dmesg right after the rescan:

[174005.380038] iwlwifi 0000:00:14.3: Host monitor block 0x0 vector 0x6
[174005.380057] iwlwifi 0000:00:14.3:     value [iter 0]: 0x00000003
...
[174005.380178] iwlwifi 0000:00:14.3: Host monitor block 0x22 vector 0x0
[174005.380198] iwlwifi 0000:00:14.3:     value [iter 0]: 0x00000003
[174005.397491] iwlwifi 0000:00:14.3: probe with driver iwlwifi failed
with error -110


A few other details in case they help:

- Intel AMT: disabled in BIOS
- POST fastboot set to Thorough
- linux-firmware version: 20240318.git3b128b60-0ubuntu2.27
- Also tried it with the upstream rev 77 ucode dropped into
/lib/firmware/intel/iwlwifi/, same result
- Device is the Intel Comet Lake PCH CNVi WiFi, `8086:06f0`, using the
iwlwifi module

What stands out to me is that even a full PCI remove/rescan doesn't
bring it back; only an actual cold power cycle does. So whatever bad
state the CNVi ends up in, it's not something the PCI bus reset is
touching at all. That's starting to point more toward the platform's
own power/reset handling rather than the driver itself, though I
honestly can't tell yet if that's ACPI, the EC, or something internal
to the CNVi's own power state.

Best,
Mark
