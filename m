Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27B397929
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945322; cv=pass; b=gaApng26JyOgo8roBDEtTuB/exX6/q1EbbwLEV8RGnmv69G/X9AOt5ta01ReibM8DDzMuuTO+XTtFlM5DwsJ3UwyyRjMpPHcjxtGBhnN2chrwhp4W3Yk4c4EE3+c50wtFy22A9aETsklYkZAH5vXqbE29kmB4O8i3R3SWk2bGTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945322; c=relaxed/simple;
	bh=Jgu/Un3onyiT+3rWTjhOggAkuUGL1OhH5rRGpBI/auA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raON5fgwK7WKspAJ6CeyRHfodXb7HVhXM1ktTYh3NQMFodLtGUdCo6q4A24C2zw1scfLvIRtPb4o//DbEWb4qSlK0LPnxHCE2+uvZlI9tT48nbiKXeR5GZKsAKkmOnrq5gVqIIiy1trbmiU5EBFG1rZ7rtJXI08tzrTKylcRSuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQujq1qu; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQujq1qu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a818fc4so19853811cf.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786945313; cv=none;
        d=google.com; s=arc-20260327;
        b=Y1IFs3XLly54hsulCCyUw70hEtmOZEv6ztCqhVEcrS/8HD2ymj9RSbTX+N+7lsnh9J
         TVGUbVN3JDg2MtqrHa65Jc15XKFtMS/3ToK82lXS5YXOmgtshRG6OWf1XBAfVfQpfaxm
         iXSG6KWwtL09q37IA9ox2qAbnEazMjIZlvX0szxxik/tWY7FawfsXoJKTxnS/ACRCkQ8
         8+o28Sruna2EmljqGAOlc4usxrOf4XMSBDSrTC5lw27o+5j7YlIegDchSBhAC8Kmf4Tp
         DuCn6eCQ/ko5BenLN60o+Mf+PGssL5CcjZUP4pzk63a82Vng2grGDTE+TWKs5QfibQ++
         IiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jgu/Un3onyiT+3rWTjhOggAkuUGL1OhH5rRGpBI/auA=;
        fh=o8PqRrq7/uAOBSxc2K6tg+EPXpOOKvfHpkDPVGINYyM=;
        b=RCd9wOZwAdFLPNwrIkG93Ls1r6UxhxvMObH2hhHGsdVszMkNX732Vb3AL72BhFoDje
         +yX8FnkXFPR+M0gjDeevvUwj71/WGskwL9hs4ssBo8wI6yjnEVFZe+7XElcM8RGg8X+q
         aS2u5LHfiHqStVBnIudVtY4kziCLAQxmkUDUsOAsuj3PC8wn5qChnXIDES141GTUwA5Q
         L6Iv2rPkOd5Hr9MM0aCYAb4DGM8ulCZKA56NkykQyUP9H0RIwbDppK7zDRRr1Ln7AjRb
         DgkR+wyRuDv0TzzSzjok1oHqRLxrM6IwoQYhi0jfGNNGu2OnvhQ/GeDSliDNkFkrO2V/
         +7RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786945313; x=1787550113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jgu/Un3onyiT+3rWTjhOggAkuUGL1OhH5rRGpBI/auA=;
        b=oQujq1qu7SVxJRT9Tig7I9AdkAE6H3wwMUkd7ZDzCSabseIYu1EzuoNT3M1/qydxrF
         Tam3z7iipxNyZickz1IbK7XXywG3plmpZbtjUyxompMDs1VaXLaE1h/fYKXDyqbZC7lH
         JDnqW+Cr31KOXn/bTeRxrStQBcQ9K4N+AgIFB3UY7gByLF+dx3gRZGgdcVW7t7oqWEZE
         NgWUz8BMDNsK3tLT0//48RRROmLrCUSuv3JVLV3+lZvkwAqwUvCsIiLCXywRDnfwkY8p
         nN42GcrHHjkvNXTzemtDWNkCnXBTBRQXDV22i+lEXt3UEolDjns/3ehKEGirtIDZvqIR
         fC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945313; x=1787550113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jgu/Un3onyiT+3rWTjhOggAkuUGL1OhH5rRGpBI/auA=;
        b=qPEacuxt8A17yQ5nToNuTh0IYSJmUFNBuVvhOjBFb4aW2gBcaSpe2IVAVgBGfLvpuy
         uLPhueapsGVVJZMnNj7uRixRB/YcxLg/pd0d1B47lwBnDXYPWFUkLYWjogBseAmK371a
         qaCYEUCPJ8XMFDzwp0sK/GaA+irohxcHPMD6NEta48UOY+ka3AVFc6Uopjy0jf6vMy5h
         vIMCdIeoPkUIgqtPKNr5zMMZebvm6c7p27jJGzLAwpNoJtYOFd5OcQ7GtXDdWpu9EhOs
         Yo1gn+DCziXaRKJNFo3f/ALSwd+SZDstXwIN4JBS0nkbl/q7aWKrKaoPkwVPSzGFN6Hv
         ij3A==
X-Forwarded-Encrypted: i=1; AHgh+Rrry6yNZF0EPoy4vR3v/tq35zdUippZpGxEvGk1GJ+bpAqjNdH1nFBHtvPCb8G1KFmPfqluOHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcko4OmhMKX8WzlFmyq3Gh6ShpphOwhqClvoHDzG/cpStIn8vF
	pEfuULZj+eKzSA9YapoKOf6gqndFXCR6CIYfa7JxgjqPTGWmVCuphJ/+rfJJmtdUrbBeNGtt1C8
	JhTRWWDMtqyecu3kc+Lcf6jXEnbM46s7PpKnMtJN/OEBhLCrYGP46TpYyOv0=
X-Gm-Gg: AR+sD13Q6wemPM3XqerIQlve03wRLQJAZJkTpzFnrzsJWhprLUFHrOwAcvZRNhZgq1q
	v6R4Up5E1JWf/GUJoaxBfCnkj5Dve7NsHdFnTTtY2tfMVJGdgAYICwTzyvMpve6N4csexTK/a/O
	TFp9TCQ3rktsSn4n/ko/BLGFDMh7Jay1ifCBFrlr3Be8j8Gk556p6ptUj+bGzoFp/jdCJutdcVH
	eNMZt8xpENu/70ec6q0tEilaRxWQ3rggNzDdeyFXdPp7RqpxGmsNg0kfgOy3DDHdCCupFhkvAoz
	cElRA29UQxDtPSscY1PNzbPB/FqRfUv0ZmWI8aRyDEP/kw1JOZiJTx/Jm2GnKna66B6naH6A3Oh
	hjdNM92sZQ4XFEjuIzYKkXxhPjwohtHVqPV5b24yMUjeb94KtciCeIqN3+qcLQDbwVjRGeYUk7f
	3bzZ6OaVGAsFNBRpVdGHMlHYZNZA==
X-Received: by 2002:ac8:5805:0:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52d8536169emr235929571cf.16.1786945312574; Sun, 16 Aug 2026
 22:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08@I-love.SAKURA.ne.jp>
In-Reply-To: <b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 07:41:41 +0200
X-Gm-Features: AcwNN1WuIZ7DFDCMxf6u7a9haE3RDYnUCsK5_igcDJ9nyNbqWmPiEX__dayCugM
Message-ID: <CANn89iJQdMF1hDPAJib2rW8Pf72vQ_x5hZMFNO1Y-kcq19beGA@mail.gmail.com>
Subject: Re: [PATCH] net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 8:50=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> sashiko is reporting that trying to read /sys/kernel/debug/ref_tracker/*
> causes use-afer-free crash when either alloc_percpu() or dev_addr_init()
> in alloc_netdev_mqs() failed, for commit 4d92b95ff2f9 ("net: add net devi=
ce
> refcount tracker infrastructure") added ref_tracker_dir_exit() to only
> free_netdev() path.
>
> Reported-by: sashiko.dev (no mail address)
> Closes: https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e51=
3e%40I-love.SAKURA.ne.jp
> Fixes: 4d92b95ff2f9 ("net: add net device refcount tracker infrastructure=
")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I have the same remark.

Fixes: 4d92b95ff2f9 ("net: add net device refcount tracker
infrastructure") is where the omission originated in Linux 5.18,
though it was benign until debugfs registration was added to ref_tracker.

Reviewed-by: Eric Dumazet <edumazet@google.com>
