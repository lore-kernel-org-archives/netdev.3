Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0F43CE6B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976067; cv=none; b=HLr3+/sBSlLeKKalA+J4rw9UEGUhRMM1jeyVZ1surBVxUuiXRokGtnWjlQYb3ppVa2YY+32APV4blO+q4CI1v98wG55xJozZHveQO4isYrV4j+EPprrJMecCsXLpg5pGPnpKK2SIkQ21I/a/0Zbl+YWd73VkXu9tUnKDHLx5QUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976067; c=relaxed/simple;
	bh=1CVdUEftAQzNRpHORZWPGeKliVSiGuSgVcI9VGtU7io=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AaN2hHjITfmvAjm01VkUeHSaFCOPeaKSzEHhJgtyk+Gkm8wq1cx3qKMUvDATVPuA09RF2Cofy56m1IlkX6tg2eQeXf/s1P0YNr9Mg3eFgKlCILifnqX8QOKLEJqEEAGuJIvvYoUIuU9Vbt1nepugq7XprPi23At0RZaKE7wTF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so2540198241.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976064; x=1787580864;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y0b9vmbjuvWaP0tG9rVPdJ7yNqeVE34Bb4IVkLpuDLc=;
        b=i41jPqspQlyqarPudly2M5I3v38Xj/bYmmXKTAH7aWTGNyAfDO2G796ZqgNyEll2rU
         AF2lji7saf4XbOlQxkaaKWWZ3kmEOXY1m/toOkfGvmkyaxD3RPn/zVSTfnfk4NgTyD5y
         I/icAF15QALt6Z0gBp2lEh4o5Pda5rWBgqsbojBadBXjZAVYG8aDiU78ndmKS8tL+Hgf
         +hSU7ca+C+hJoYmpDyIGCJtR1wv8JnoFiX++J8aSACnBEOHRmcUbvgPYQbXiBuOYpcM2
         zTrprsP+2wjmkG9C/RsPnZi/hd0DHHvr3nv8oUEGR3G/BfI1Bd6uaz+CKfymrjFFBQxR
         /s4Q==
X-Gm-Message-State: AOJu0YyXG08SwZWeiMYds/2wg2xyfEQdQGDgQSkH+CiQsc0rDL4tuaAC
	sZNc894XOE6QHjLAr+qhvLFx35AQYI5HfZ6LmhVo7uWsjJQPfON3TVEVQG0NtyRM
X-Gm-Gg: AR+sD111QHTNS8i4MSrCin0XgoCflcp7xh4qqgsmQWiIVRyX7zK8AKuQnKWMN1lIVYc
	WP2op8AuH5+CCb/9trE4mZLvYQvFFDUEPMVtrzIhFqUqFJkjftEP9lrWgWaQaNYT4+N+G8Tduxe
	TSFLYfP2qzibY2XmMBr8A4wc/yjsNuIntZrW4xQNtS3hmIZ/rEGh5vx68gX6GZlAv8hgjLDlxli
	z9W/He52M8/LR+NfUnWdm6zct2cRELwCvgGr5LYawBtMD8V5k1i0rDlcyF6LRIOlK/FMr+YDJM/
	52lZdqni3yNK5pEFpFfroTMVKaUMYskATrcIBDr+yx0FA7qx17xbo4irYomR0HtOQ9JVahTLVYw
	03ao0IOthlGLjvNp+nQsP9oMyHlbrlyTKhVF8xKI2JUelS+qF84FJS4u3BDUjqOD/CwryKPTzNU
	zlElQ7xgL/xv8XXE75fW3XQVlFZZiwSDO1Qe7RaaCagwoiypy76bRspVwKxOuHdD7eAODft7qJh
	HF2L3e2ROCWs35NCyBcgQ6KWBpwUEhRJR22+NEXBuC8bn3J
X-Received: by 2002:a05:6102:8004:b0:738:f27:43fc with SMTP id ada2fe7eead31-76dd156e344mr4100391137.2.1786976064197;
        Mon, 17 Aug 2026 07:14:24 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c3cb6bbsm1205224241.9.2026.08.17.07.14.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 07:14:23 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7564b7a9490so2985867137.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:14:22 -0700 (PDT)
X-Received: by 2002:a67:f6d0:0:b0:744:e453:b1fb with SMTP id
 ada2fe7eead31-76dd1f81530mr2960737137.9.1786976061929; Mon, 17 Aug 2026
 07:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2026 16:14:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com>
X-Gm-Features: AcwNN1Uf260vbK7Ns0EoOkj1aWuLId-ZXITiADIbdv110yxcMumkzhENu4ZtN0w
Message-ID: <CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com>
Subject: RTL8125D breaks at 2.5Gbps
To: Heiner Kallweit <hkallweit1@gmail.com>, ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Heiner, ChunHao,

Last autumn, my RTL8125D stopped working at 2.5 Gbps due to excessive
(2/3) packet loss.  This happened after an Ubuntu kernel update, but
booting the old kernel didn't help. As I couldn't investigate the issue
at that time, I moved the machine to a 1 Gbps switch.  I regularly tried newer
Ubuntu kernels, checked cables, but nothing fixed the issue...
Last weekend, I decided to have a deeper look, and restored all relevant
boot logs from backup.  Suddenly my eye caught:

    Unable to load firmware rtl_nic/rtl8125d-1.fw

in the logs of working kernels.

After moving /lib/firmware/rtl_nic/rtl8125d-1.fw.zst out of the way,
and power-cycling the machine, 2.5 Gbps started working again (280
MIB/s)! Presumably the firmware in ROM does support 2.5 Gbps, while
rtl8125d-1.fw is limited to 1 Gbps?

My motherboard is ASUS System Product Name/TUF GAMING B850M-PLUS WIFI,
BIOS 1057 06/02/2025.  I am using Ubuntu's 7.0.0-29-generic kernel,
whose r8169 driver is almost the same as in upstream v7.0.

According to the r8169 output, I have RTL8125D XID 688, while lspci
says RTL8125 2.5GbE Controller (rev 0c).

However, according to the r8169 driver sources:
  - RTL8125D ([1] says rev.a?) has XID 688 and uses
    rtl_nic/rtl8125d-1.fw,
  - RTL8125D rev.b (matches [2]) has XID 689 and uses
    rtl_nic/rtl8125d-2.fw.

Does XID 688 rev.c needs different firmware?
Would it be worthwhile/safe to replace
/lib/firmware/rtl_nic/rtl8125d-1.fw.zstd by rtl8125d-2.fw.zstd?
Is there any other info you need?

Thanks in advance!

[1] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/332
[2] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/387

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
