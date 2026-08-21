Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264A4ADD9E
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321707; cv=pass; b=L3MoQ3clumMza4B+Yr8WsSjzzXc9A9ubW7KkdR3ZXRd4vGScxpPWyI1+UI/Zm98UGonNrQYui+O+Nh/59xeE+9i0owELT/85gVUSsCF2ia9171kHGwyO8/CxmFVkmn9XClyjF9T0x7E8Ik4gLf0WkB7J0VuhBraTyd1ifbEUFZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321707; c=relaxed/simple;
	bh=TccSS+NIaXCENyWwJJSgaLleoIe7Il1Nz65FsBDFwkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKgmqE9benCFbFou0VZ2GuoGn/Hs72T+ixhQcU08RoZE3CubwPFpzT4dVaIqvtERQNj9v8jdPZNfIkj/cC1jWVZzu5T7QS+WJ72Tcf92Mizj6sMMG1XR9EH+RBSqsuXXZ/glS4g0qnbHsag0VTHaL+qkLrhybBnFn2XOwPiTkos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMQi2Emc; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMQi2Emc"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52b6543169fso7033321cf.2
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787321705; cv=none;
        d=google.com; s=arc-20260327;
        b=RCsvkN+h922JTuRKWTo4eX60+WBOZA0vX3pTp6JYjGEfPAt0CwRpbgqjBW43ObSwEC
         nOO0pGTJiFmV624ImIssqkr7+bf2Ywi3YsvGual++8Xz6yGlY7Q1WSVhfw0vLQIyxXXu
         KEqgd5RXkFAVOHAGspUYPt99Ezw9ZmCextOgguJMP5XPaGoFsmkVbgb88GfSsi4cGduk
         oqESbEHZi5KG5RvyAG1QitAfOkWGL2ILLxWu0prx2SLJ/3bKTvPAk8zarw9ZB3fgvxLF
         oq0IS4lq1nIC2PBZ/QvW70nsD0FgXr1xhQ5tfaIWXrq7F5wUz3k8RSwEMPg0IB0CjjdU
         ixxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TccSS+NIaXCENyWwJJSgaLleoIe7Il1Nz65FsBDFwkI=;
        fh=dpXZ7QDgE/rqIyZXQ1X4NFhUrbpgqpQOaZ6/OGlQuck=;
        b=WhFtKhRKN3WBMMw7OL9bD2pBplZC4d2RFCgZbYOqyYaDRlFaXjrurOKf2esDubwiwQ
         pMSJ3EtV4WuZ2Nm1XsQecyHIa0CYi/oof2R5ltNar/Ui+myt+N5hFVTMQ9WoMd++3qIl
         s3r11EfyYRE9qfcgk2GqqfFQgQBFXcP95SNdlkXXfDfJt7A1+1X8/mJwBFRC1IT0OAxM
         2DqGLbjex+73KPkETTImmEAzUsfA9SVv7Nl6e6M8L3lL/uTYA+0Zh7H5J9N82szPq3K2
         vL/bC3vi8l/wysLfs/P9Ywfzd0XJlqzxl+3tvManTyjar0x8EykJwdZKuwag0UghmxNm
         NWpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787321705; x=1787926505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TccSS+NIaXCENyWwJJSgaLleoIe7Il1Nz65FsBDFwkI=;
        b=EMQi2EmcElyKYJNoGKcdwi/gmd9CTRI72R2Xz+c0pt08iUBeMfJmT1quTWqXXmdllB
         xmiJ/9JYN75QnvoWEqPh9vgNGcuUkzLjBWamoEGiOzwaLBgEItiptr++xNcWpUcY/RGe
         Lk3p7j/UcL+dJLLJvt21cr3eYa36nJp0/52VV/HQPI38Ke6MqTh0nCFgM5wd4k0tPhba
         AJN9dHHM/jEujZZ4Oc8EyHFaZ6pcMO/6saitL8JGMAqnRyLa5Ge7LdpgPAvfjSw4S3v9
         cDlKJUWs4/NZtR2TeA5HinTEEBqi8L8ktZk5kHpn4FlBP6Do6mjg4JYe7CqzPNWM0SSp
         G1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321705; x=1787926505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TccSS+NIaXCENyWwJJSgaLleoIe7Il1Nz65FsBDFwkI=;
        b=X5Aa38tuCxWn2QvWngIKnYejy18VUAlenNVyx3b1CtVVGiL5evrntkmJFpYjj75X9O
         ooMNCZqo7WlEpbWx+sHYIQ0LPsBaOv1Wj13ljJ0/QuswdSORfIJrYYv5bXiIVYJJDC49
         il7qQd95JtxuSTAKER/G8+3NKKQhHGsfFVYHKi8V6GjW2BryWJDvw7Ntmjv10YKHjhuz
         hcFDKbJvqHkRBGL9kdLSPdzaoeidyIxiH7c8/fiS7Qt4Q1Hxjdvdt3YRhFkojB6gVeaa
         /HJ7Oe3fzWf7rdAvoA6Nv0fmTovYls9isAU7gMj4M4NT8DrksvQSHWa9psvFxzs3Ztl3
         juBA==
X-Forwarded-Encrypted: i=1; AHgh+RrIXh6g+4f2YYnA6ByTacrq/BrwHwbe3b7YB+kmJdMemn+EmcItAu6OeL9jyFodFc+A+YFblLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8WosGvH88toHXfmL9vyczhwsfJIjkr+OjTSZcNB0pZHAK0EU
	iivvFYiyw+I4f/MAAQlqbQQsVXICn3AU34V81RBzJ8MM9TefEw9dgp8coxLVroU+LZaExL4m7Ss
	OzUQEM8xtZwjo8g1DHUtOhHEGFVFmvJoR9WMRDFgZbKPZn61iyTI9riow
X-Gm-Gg: AR+sD10nUTA1F+xjgW7xPWIfaNopMG0ILOHGUofoMIHBqpkHkMR2g3CsfFB0/spQypf
	QCOWg6GbZxO3UXTqklg4EpR1DDR6DHvtIHXijEul3qgogMhhkQcEDSXT11iXI3lUqg5KDkR2x4W
	sdRl2f7zouoB3REvLtGHKNhheCtYDy+OKv/Cg9qCJexPP8CrWnxKNgpMSp0nwBzdx/wadiDwWDs
	2Y18mlC+WogcNqvh2TE/hNjK4h1HMmqiTOh14k9DJ6iyek52/FWcXYJsfqAa4zD3Y4LiNp25BSl
	ICCa80PieAYsYixFZrST02ArYTyYgGJGY34izX1KOtmXBsjbV5pg0/0R0ScsFIjQe+0S03oprRM
	BbPjRZfRL0QJdq5H0T49C3zfrYXLpr67KxEOG5KFugcCACthUa16+lga4Lg==
X-Received: by 2002:a05:622a:14b:b0:528:38b1:b54c with SMTP id
 d75a77b69052e-52df56eb847mr62757171cf.2.1787321704290; Fri, 21 Aug 2026
 07:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819050031.2725592-1-shuangpeng.kernel@gmail.com>
 <CANn89iJbOs54esoGSukvMiYnXQkHadnC7NgQanbAXOeiHXOsjg@mail.gmail.com> <F1E58A29-96B2-4BB0-8840-8A168477F48E@gmail.com>
In-Reply-To: <F1E58A29-96B2-4BB0-8840-8A168477F48E@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 16:14:53 +0200
X-Gm-Features: AcwNN1Ug5BQfMCgHF1cykLrwRDkb8I8sreh-uNSxFtMO9C306K_evZ6Ynhi4Ebk
Message-ID: <CANn89i+Oz1498M1YGnMCUmFSe3TQxLhP=+z724e5vsrkUnJu7w@mail.gmail.com>
Subject: Re: [BUG] NFC: slab-use-after-free in _raw_spin_lock_irqsave
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:54=E2=80=AFAM Shuangpeng <shuangpeng.kernel@gmail=
.com> wrote:
>
>
>
> > On Aug 19, 2026, at 03:48, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Aug 19, 2026 at 7:00=E2=80=AFAM Shuangpeng Bai
> > <shuangpeng.kernel@gmail.com> wrote:
> >>
> >> Hi Kernel Maintainers,
> >>
> >> I hit the following report while testing current upstream kernel:
> >>
> >> KASAN: slab-use-after-free in _raw_spin_lock_irqsave
> >>
> >> on commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40 (2026-08-13)
> >>
> >> To help trigger the bug more reliably, we applied a minimal diagnostic=
 patch
> >> that only adds delays and print statements.
> >>
> >> The reproducer and .config files are here.
> >> https://gist.github.com/shuangpengbai/f7dab4725e2a2d57b1d302714c93c549
> >>
> >> I'm happy to test debug patches or provide additional information.
> >
> > Thanks for the report, could you test adding one skb_set_owner_w()
> > after the skb_copy() in nfc_llcp_tx_work() ?
> >
> > Something like this (untested, not compiled) patch.
>
> Thanks for your fix!
>
> I tested the patch and reran the reproducer. The bug did not reappear.

Great, I have sent a formal patch, please fell free to add a Tested-by: tag=
.

Thanks.
