Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7740096C
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671647; cv=pass; b=SvPWVmjdUBDebvUMRKjMkS6lu5MYcf8XHm7SdUuRpNQEB5BW8IJ/a+JEw/GrKuUZM7vuMbZaVyJrWWIp+gOvAyhHTiiXU/sE0fTV7Zh9dXSYma1mYE+05Lhr276JVvexJcp4uvlbGrhrBBpnD7BE+9yXucyqvQmtz8A/TaWVPzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671647; c=relaxed/simple;
	bh=P3UPOlvZlh3GuZ35VcNZ1W1dyaFhn8s8hYU0KFPZ3jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbk2NPruTGAUhUsCx+/IU11MpzI9HgmIi5FxX4SCyDoU2GhPW03/3gut/yvb7QqGGHMWlAVvFf9yLd2gMBFD0hCKklNAyDPRvBnxYTo92kC6+8H/NwHWGM2oD+1wcTaAZBHSVVd6d33fTJh2IvfJcNd9Wnc98sYHNM7MtO6MhyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPagUQuX; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPagUQuX"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5b048375so223563285a.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787671645; cv=none;
        d=google.com; s=arc-20260327;
        b=jL/u/Xjkkb0MRdlEBRfBIdt7/u6yD9ssLDk/cJZ+m6QM12d+oONFfflD/qeAl/P7lh
         BjI5+zZmwkHQiYaaTM7oMrZPnJW6M5QJktnAKQyv/1BRD2S5P0CpIUA9i6kIwXKtCNBC
         usQEP5Yln+TpA6eiQXMug8EkEH1FHMMHDiblQyR7SBnBw0xZ2Fdah5Tu+oD0r8+nMr7b
         folczTCTiuni2WVbclJF6W2/TeIttn92bNH4/kXNBO+Br830p+T2U6i+uA5Y//QTyI+C
         ha6IUtsvcIfMT8NHyehb2YJbQAPwjulfIK/e9M25uYzVvSSKCpEos8AjPiYkPQMTdyrg
         y5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X3Z1RwE9Pulx6lUVcnRl5ysQQDH57FtFv8Mr3dUHZ8g=;
        fh=BrVrfElvWGNGbbwZXRr301FccjPaqGtLPdSlBQaxk40=;
        b=U6iW2XEU6Fvzi78ETYXBYqmj6ZRp9aF926uswYhfU9/ItVIu+YkclPWjOyCKCbH8sA
         xfT0HGndbtwzpmCpAc7XQdJsihN3+5rzkIGM1bgM87dSLq3heHOWFfVtLAth4WOXRO62
         hiY6woBXeiWGLWlYtNHiHefbGHMuaeC2OUqo4p0K7uYrikVZNrZpmh+1imiSGex3QV7V
         CaXpySGbgmtiVeGx3kzm0BUwv+wVQOSP9KCJSUfh7xB6bh+4eGDpqJ1SPy/jN7acBsLm
         VyMKuGBWGSJWPdw5l5nMG+9k0TNabnftJF30ImWEWfstHLNGbeat3hOETqXXjK94/Gbg
         y6RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787671645; x=1788276445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X3Z1RwE9Pulx6lUVcnRl5ysQQDH57FtFv8Mr3dUHZ8g=;
        b=MPagUQuXrXhqhQYp1EaiPvATXc2L3u0NBgkxcmNl48eyEi8tO3kKFj3EHjSa1oU0Is
         bZa1nGg8oljpqe6KAKK/EQZvxtc2JwfxDRYIO96aJJD340Nn+2axZtSMnJclhd/T0ya5
         XjjvUw1HQQzFOSRftKr8ICNu3h+n/BmMp7mamKa5ippovRQKE78a4IwUIuH3tpMIG73W
         jRUdEjhTcXhT0s033ERSkbKttKDMqLmyqFkdEXUPUYtBeiNZG4eqLG8ITgo0lqdCxlAK
         /DqWeFSxSoFSqPLy+cs8KgKOLlItK1LKy24vThKNsbmeUtbZICMLmPWz8G4yWjD9fBl0
         g0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787671645; x=1788276445;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3Z1RwE9Pulx6lUVcnRl5ysQQDH57FtFv8Mr3dUHZ8g=;
        b=s/yJwf2qsKdX3iUepUDPJJMi0FXVrurWfrrDeQtpKICnbZ9T2wUCIqX4+nwg3SU53J
         EbjK6Y43RX0pZqtUAMfKo/ed8HqzqmRry4DFAk2zOBt2MG+LWoA95L9wHSTZsjqupLNU
         /Y/6BW1jQoJARQ+QGvWUByDbOFSJ8roYSeoZlUimgp4sd4dSsMKI5/DaBAkYVUVh0kov
         wsA9hmpkSltZKC1P5WisrPgicImFi1/rGI4uSeiXryGYFcSqhsQfxlUPrj8qcZL56w0V
         023PfOKUopE5bdTcXDabjQOJvHzZAesqGL0v39S8fJ4Ay6n4Es7jXekEnHEI/4orLw5P
         V0RA==
X-Forwarded-Encrypted: i=1; AHgh+RoJG0U8Mu6fa4N4Ti0jzFX+Gb9nwNiYNQMByLH8XReenikt2XJcITlXE4OSovbMWSkmh4pIGDE=@vger.kernel.org
X-Gm-Message-State: AFuF++kATY1+iXyFzBlexWGiBFuUnSyzSD7zMdQ16OyzoUMhS0DH0uq5
	syf3dEusftsYQxSeehbhPkFlAcGOcnQivKM6m89+KDUBA860ivyASeqOqlRsC4ONtwObToXTzU5
	ywk3lMM6ZtEGiAlUtbdzIXgXvk4N1HbehU+wZUeEp
X-Gm-Gg: AR+sD11fEqI4ho7kBsc0L8iJ6KCqgvUcOVyJwiRGeY1bBwG2IOYxG745CC+xzu+5JBH
	9Lo2ltiCrw0OFSPIRVxkxXU2OniGUFZ/Yiztr/NlNmBfZ5+5h5N90Ka7au6uZm48vqjYoYakDYv
	Q3eu5V/vOr2oHoUR0qTQ1h9e5oO34scB2n2Tn8a6dff0v28/MLFp49IbLapPve0h/Sy706TF0rH
	Uf6Z+AOIubEiashwT3Qwvu4K27z6bV/CIKKAAsdcIca0Xd3CRWmPQGNMfECKrFFNsPC5QrMxkjU
	CNZGyxZbcobXH6cWKDlRSKWGiGUHkCUm22WW+Zz+h9oR5M9VK9zKefrRcuog1qkcufMFoprAufF
	IbuK4h0GFP1FlnPjeWrLUAIIZ6sVNoMfNqSNFQ1PYILiD/AbVmKI2FzEkOJ9HPfapf28=
X-Received: by 2002:a05:620a:72d1:20b0:934:9011:596c with SMTP id
 af79cd13be357-9373952c96emr2573783185a.24.1787671643474; Tue, 25 Aug 2026
 08:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825150655.1450271-1-jjy600901@snu.ac.kr>
In-Reply-To: <20260825150655.1450271-1-jjy600901@snu.ac.kr>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 17:27:11 +0200
X-Gm-Features: AcwNN1VUm2LbEWIXFxI3xJLdgHzOEpfApI2ivNqT_Ae_ueLbqRxAFNE5cTjujos
Message-ID: <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 726ksm@gmail.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:07=E2=80=AFPM Jaeyoung Chung <jjy600901@snu.ac.kr=
> wrote:
>
> Hello,
>
> We found a "KASAN: slab-use-after-free Read in slip_receive_buf" on Linux=
 v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root=
 cause,
> so we do not have a proposed fix to offer.
>
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all include=
d
> below.
>
> The following kernel config options are required to reproduce the issue:
>     CONFIG_SLIP=3Dy
>     CONFIG_LEGACY_TIOCSTI=3Dy
>     CONFIG_UNIX98_PTYS=3Dy
>     CONFIG_TTY=3Dy
>     CONFIG_KASAN=3Dy
>
> We hope this report is useful. Please let us know if any further
> information would help.
>
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

This rings a bell; I had a local syzbot report for this issue a while back.

I think we should remove slip_hangup().
