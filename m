Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090688;
	b=hdQ27Q0RHgAe8CT1kuqeB6cT7CQJk+0MAmvZtUKRHtg4yDAYggxsakdAqmh4Lvoqcrss
	 jZwYBCal2A37y0SRc9cqmX1i7orlM1L0gDGAxDzt0bknS86AceQR2koVQiOgrlIoJootg
	 Lg68PT0LVAYfSCspgWY1v8qH2fasdd92W4PkkT/qgKFXYSMPA3J+PJK4a3/mDZYOqQYQ0
	 WMIb3WedDPlNwKum8l5TBhAGILGkPs9pwJ2tfgjgffgYFhtom/lQSrb2IAoJRCX09XU08
	 MPnz+dLhqQYE5oYPmL/N5gGspyZSPs5KLx+FVPQKW+e5aGVRdSUnmTGk0IfdB9Lga2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090688;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=uinof9MHd9+NHXHAsUKAXp0227Bki2gAq3CWgiYMyVk=;
	b=gpeHoumsrtevtzNyFmd/bYUWWOOVPNJmblVvrmdZ5GoL+ZIalsIPJUzvY6j3x10n676b
	 AsT8vA+qN0bJDd922qnaZCbju7vTAI49ck9dqL1VRLMyyTDnYNil90L/paeyUGfBp2Jod
	 gbT+dC0LHB/54weUac7rjHv0tYCW1lXgkxeohhVSvOtXDLqEXktkG79MQXZBgdWvw5MEd
	 hKi7btby5drlyvC3a1pklyZo8VIxwzkEW0vFGG+OQhO/UC78s0hyLQTLbAE6pWuDdbewl
	 EeMPvKH34sNJYvPUBj26gqe4DHeBXt7/xA33FXLYjE5/N78doRflNk5+r9+bYaGvfsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20E606A33C
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E20E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so4096048e0c.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090687; x=1793695487;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uinof9MHd9+NHXHAsUKAXp0227Bki2gAq3CWgiYMyVk=;
        b=H9YWCy2NkxZWK5RXTiOaVRQVl2MM15UzeBLOqnMTyTDFzknq7REWdXEYtmtCG6Nc2p
         bSn66kdDIfTSrrDbk9gJW5c1KHAFviEOwdlimEryNH51HNpmCEgs+BioCTSxjl7DaSGg
         vPTRpC7E1096I9e/2NAmS6nZkfIrJ6mvVRsDaihsFGulBukEIL1tiK5Z6+jGwulqfXrf
         l3X8MRE+Jr5+u9Z8/5IAEAPI5+45Ppv6nUpau+fwnIdTyDh3J5w2pyXf5ponCSKY7eHO
         pIYxZtTWxDq23AmRrw+6nyBrASbsK2OjDcQ++/o6MD0XpAXk/3r6/i/ej4FkMV9ajYee
         r9XQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6jdAlHJYfeehik9XItraZq6ep9Zi/+KxSk+pzMxiiIQfQzqxiWmOiDY05bGSve87MeIQ89/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3oOhJhit69oGCVoWxCHuzboFq9z2QwDI3q1Fqspm4q7NfT3+j
	TuQ7LgomWfHoTW8BivSS6TxUT/gIBjn/e7kLoO02vE9mODle90o8HTHhxNQ8NebwPyQ=
X-Gm-Gg: AYBFou1smf/QkupMMAnbfYT3THUaON5PX/tygCwoov1Jd8mCHuP26Rec6wdRvKrPnn8
	LMD/J0xkB+ZIPCfShYFQU3KiVBaUMpu7hODU7JE3s2tpibQQkSPeeQ1B6RfV44B8vRjcMuo+J+B
	6urcS09/lSFdRfkdos55ZZpFsRgiUoxZd3w69/75zPKb6EENaK0+hxJl5SWP3XRxGVfTsTOMpPV
	BawFH5YjJ3AkOdPzvulo3/EjfuUvnah6eT0AeIso1dVdeYNmgvFd+WPiA2KkIJSL+SDm6eMrTP7
	YxhnTP85Zoh0X9cHyeqPU1loin53hJn4Kmws2uZA0MfGBKjQ75vesXg9+2MU2wlzAkM0NUFnCeY
	Es0DGsfv/5XaDMIXWqnsieNsfXi2/MvFedooc76HVjYR6LbS1CKlKK1mhrJbEpc3qranMf0EytG
	vSNgok7rR8sNHbfYqqqosXD1wDmsasXlZoXVKygX73U+Q6ZPcS5HIzaAIpEZ7vzD6ThZDlckw2B
	+DhggbtBE2+RBa0BsZqn3vAjT6xLeRIvIrxE14h5fl+tyMNJPGaUli/a5L3gFw5+yAqFXCTT984
	IbgOe7tKfsHMxMb3+Q==
X-Received: by 2002:a05:6102:5486:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7ce5cc70a5dmr3868051137.13.1793090687175;
        Tue, 27 Oct 2026 01:44:47 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm1800699137.3.2026.10.27.01.44.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 01:44:46 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so3251703241.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxARPWnbpPDnrUqE0Yp/EpCzFSm0a8S9ZaEia4uV+H38xmsdSuFTwd04iPScvTssOo+qLm7BVo=@vger.kernel.org
X-Received: by 2002:a67:e710:0:b0:7ce:6289:314 with SMTP id
 ada2fe7eead31-7ce7361b5afmr2707979137.14.1793090685340; Tue, 27 Oct 2026
 01:44:45 -0700 (PDT)
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
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Oct 2026 09:44:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=oPJtRtY0M1h0dZCSn08wy-fRScPTqBsD_v6_9nGRdQ@mail.gmail.com>
X-Gm-Features: AclHuK-k9wF0--ZIaZw3cFzqUuCfXGPGVeH6MyiasstbSlNgodm_f_jKHqi0gMY
Message-ID: <CAMuHMdU=oPJtRtY0M1h0dZCSn08wy-fRScPTqBsD_v6_9nGRdQ@mail.gmail.com>
Subject: Re: [PATCH net] net: 8139cp: close race between NAPI completion and
 Rx unmask
To: colton.pawielski@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 01:12, Colton Pawielski via B4 Relay
<devnull+colton.pawielski.gmail.com@kernel.org> wrote:
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

Seems to improve nfsroot on Landisk/USL-5P: no lock-ups seen anymore.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
