Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527A40DB3A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068539; cv=none; b=QioX+f5rFdifztvgmKIalmpOld90+lT4y7dZk8/fkZ+RsVEJAEoXVkDuQs1fTyOfnNhuP/ewFYWaz9I/WWgbt5oaHAMWTertYK5S3Clh89oWmZNFcp1LQ1kFq4KnUKtwcGnkMcmG8gzCV9iKY1QkT2TjPCgWtq9T+tU3nSYSEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068539; c=relaxed/simple;
	bh=/3Bna2O/4J4U3xH2aqQZRsV6SL/m+et5Ka672o1t/nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYbbMehaOEyZE1ilGPsbsh1Kyc0oFhNqooVEEcE3m35bOz12+T1IyWsINnnVkx65TeneWoKA4D7gz22crdAKNUKeJyTyw8L0vD6aVYIVpX/tHJzgfVbXdg5WlvCDueNPbOkc23mRIyne7p48eujK/pD7RiWSsnmn+8d4kqGgGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c83397eeeeso2509271e0c.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068535; x=1790673335;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hoNrikjnZUkYmVZehqVNvPOknxROXHA0utBmP+J+qeA=;
        b=p3NkyNeiCEUWWm5FGG8XvmJkFdVfdUMQIQY4ZcO4HOOtkbPZ4v1I3tsAxMzU0s6FXW
         Wdr1V+IlBk3iBN1wX8LxpXMhAKaLZdbjih5a5CXKQtfXXCT0JBU5LO58N74XfCdoi4j1
         24rpl6b+tvY6VVQslLqMCUZAhmi37PnwJ+vkCZ4WonzjtrJMJk3yyKU1apvKvMdbQe7i
         j/gxVXy3FCSTvPvff6AplfM7qOqtHuBl3CgzEf8h2JuWLHP9tRPoHlPhUCPN6QB+eYKy
         LXfuyv0ChgdwnVGvr9HJmJdB6VYeJsNVaq+0GYOa2VcnEr5e/WSowu/JNoFX6r37uNQ/
         fjCg==
X-Gm-Message-State: AFuF++mMyoqhDAzPYftcJymytiw1SV8C1PNU9JOlWzb9e0gxqEvu87jR
	HbNj6RidjtsHRVAvN1znc5EPlsPgFeNxfnl27TIiyP+6o1qLcGIMzrnrv1din6taNNI=
X-Gm-Gg: AYBFou0oLu7UEspc3P2OLwRwUWwJGR3N1S+m5K1L+HxMilVcrvlCZsNkFlD2wCfZQ4F
	aKVYcHibWxcTOCF2DZEL6PjHeh/TqC42wwOMtaQvZ05KauoJimyT9lN+19/5kgB2pzaZ0PfuCe6
	uk8DoPtod6X/lEh4/JYn6SUdIGBI8xiQORetnv9KCAcotgC7tFOc3rlwqttDXMMeWcZGFqxLVOD
	tbkLUiTIY9tQle0+1TFvjERN28HY2y1hQlkFFUXXtDANj2FykalByuOkoEBvgHX7zqdv4r/2smu
	iOeOeqrsBSN7g/3uPXDyxCkLKKbPWC0ZnmWciWjr/RDciiJSSEI2wI5CnTGYwEk2m1hRrHKhQDQ
	i/h8OYrn3l4i/stIn/crqWxs2zA3PiEGQRyW2yvuPk8842s8SHJCSAL/O8n0jXNQLfEl8WiWc8R
	1CGPTZHuSnvR1F4vLIXTsc+yD+d8LVgf8lcBZhiKN+gAeTXFcQ97V0oEAy4GgKFZJNXyFCme6GB
	AEU0sAaQVxhRBnBgf1NuK8AuAvotnf71MCUeA==
X-Received: by 2002:a05:6102:578e:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7a7cf482879mr4929766137.36.1790068535273;
        Tue, 22 Sep 2026 02:15:35 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850db87356sm993505241.13.2026.09.22.02.15.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:15:34 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7bac31so2127539241.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:15:34 -0700 (PDT)
X-Received: by 2002:a05:6102:e0e:b0:7a7:b6a:b022 with SMTP id
 ada2fe7eead31-7a70b6ab56dmr5235338137.22.1790068534454; Tue, 22 Sep 2026
 02:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com>
In-Reply-To: <CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 11:15:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZX3M_Z7hG24nOK74GeQWaT8qGxz-eiiaoKq8+fQriBw@mail.gmail.com>
X-Gm-Features: AclHuK_4wXbalEZXVS3CIQNEpSwoFQz41sEuhZgaZZhdmtWBYTm0WdpIpGGVy3A
Message-ID: <CAMuHMdUZX3M_Z7hG24nOK74GeQWaT8qGxz-eiiaoKq8+fQriBw@mail.gmail.com>
Subject: Re: RTL8125D breaks at 2.5Gbps
To: Heiner Kallweit <hkallweit1@gmail.com>, ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Heiner, ChunHao,

Any comments?

TL;DR:
    Loadable rtl8125d-1.fw does not work at 2.5Gbps,
    Firmware in ROM does work at 2.5 Gbps.

Thanks!

On Mon, 17 Aug 2026 at 16:14, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Last autumn, my RTL8125D stopped working at 2.5 Gbps due to excessive
> (2/3) packet loss.  This happened after an Ubuntu kernel update, but
> booting the old kernel didn't help. As I couldn't investigate the issue
> at that time, I moved the machine to a 1 Gbps switch.  I regularly tried newer
> Ubuntu kernels, checked cables, but nothing fixed the issue...
> Last weekend, I decided to have a deeper look, and restored all relevant
> boot logs from backup.  Suddenly my eye caught:
>
>     Unable to load firmware rtl_nic/rtl8125d-1.fw
>
> in the logs of working kernels.
>
> After moving /lib/firmware/rtl_nic/rtl8125d-1.fw.zst out of the way,
> and power-cycling the machine, 2.5 Gbps started working again (280
> MIB/s)! Presumably the firmware in ROM does support 2.5 Gbps, while
> rtl8125d-1.fw is limited to 1 Gbps?
>
> My motherboard is ASUS System Product Name/TUF GAMING B850M-PLUS WIFI,
> BIOS 1057 06/02/2025.  I am using Ubuntu's 7.0.0-29-generic kernel,
> whose r8169 driver is almost the same as in upstream v7.0.
>
> According to the r8169 output, I have RTL8125D XID 688, while lspci
> says RTL8125 2.5GbE Controller (rev 0c).
>
> However, according to the r8169 driver sources:
>   - RTL8125D ([1] says rev.a?) has XID 688 and uses
>     rtl_nic/rtl8125d-1.fw,
>   - RTL8125D rev.b (matches [2]) has XID 689 and uses
>     rtl_nic/rtl8125d-2.fw.
>
> Does XID 688 rev.c needs different firmware?
> Would it be worthwhile/safe to replace
> /lib/firmware/rtl_nic/rtl8125d-1.fw.zstd by rtl8125d-2.fw.zstd?
> Is there any other info you need?
>
> Thanks in advance!
>
> [1] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/332
> [2] https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/387

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
