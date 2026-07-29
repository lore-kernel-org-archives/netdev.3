Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929A3932F7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347087; cv=pass; b=YyOxklhYj0NuNvzyBb3bLx3fqNSLMmTHOWUSEmHmv1E1tOKViPYqMHHolk6Vw++1+IyIN0V1HOUr7fQvVRSUTZ2mwBatXtkzOY73sflZtoduWmmEJZfAfB5+2w34QuJdlyQFVw5EQ6pX7vgZTX5MsKub3zQbemASe3UMP0pjaJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347087; c=relaxed/simple;
	bh=Q/+QyJiQOclfwWoO6gYqbjKNhcIRAmaOqIJQ2WC3rJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSgNg6EoYj2uM1CYLXnwp9HktVxHA3WsJ//8x8QIgeoDsSEAE7QBlVGa7IfRBhiSE9JB77kTEN263M4SsodFRRUgkIxQAJUAiGNzKwZiy0JsbqnvikpNTz5K7kjZMPhex0NfHX0pUcXAb1WDJ/aW+QGHS+m0zYJhCfI6VK6CQW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0r1mos/; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0r1mos/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f84023916so1210793f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 10:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785347076; cv=none;
        d=google.com; s=arc-20260327;
        b=qv8xY8pJxfrTZE7mqA7WOHruvkvVyDC6/pEzzOlhc5VMDLwBar8wBTs92zRI1H3Czf
         zp0RdYuaquxGikaB2+T6IpKmgb6suoDNREha6wcXQS8k9bcNvcSXXG23RAT+pPPKTyaY
         9nYDxXP/BWhBjO2MM8BHpj+0l7vcfjQwgsmpivHHPSp3uyr6PSuU194DerM2mHBJ0aPG
         RUyvW5A1A6VxPZhX2yCFW4LorqRX7RoSAdUBpqkuC0MENf+5LsMlq432Qr6JNDu84BO6
         DkDCi/5cEcf6fjQypAa39UkMl7IIar/QVkYWhH6LRPWBx9O/bsjqwsIuCXaDxGMGYTY1
         OVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/+QyJiQOclfwWoO6gYqbjKNhcIRAmaOqIJQ2WC3rJQ=;
        fh=lzEcR4KWWSXYxpV49r3E1IaPd5Ndqi3UO6i5KsXOaCY=;
        b=nT3fb4jPQmh/Gdns2mIwvVZi1XGziSlpRP+l4KzSgGGdMLAVv+Pj194BaQ5sYFFdCl
         38DRvWXQZRKjEpmdK1Ep25/cX7lB+IsZRW8i0wqK0DLejGCKOdhJpgScFPurILpwbVQm
         GR/nJUaHtnnXdZPm+xX+bmRhltvLYQ2KVxyCmQSYB1+NtbH/MOgg3b8C9tAdhwq9XfHX
         lOvibIHW5V6znSMRAICOW9o0zujJ5XH9h0Al2y0tzqNNQWf0FgeSlSahNGVDuLgzaYdN
         AQkQkW490rheGRwi4zDFvJFEStnTp1RLJ6eXqEgfLtPX+fXNLDtMUxn1d95iKoAqi+OK
         BiGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785347076; x=1785951876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/+QyJiQOclfwWoO6gYqbjKNhcIRAmaOqIJQ2WC3rJQ=;
        b=n0r1mos/B7pHjLLE0r5r0ZOIVaYKhpYH6O9STqshSaWuqInVpiKirFvEBofry+8O47
         8a+37LFwffkNXJ9Y6gZcuU7JaZdR2WGhAdRPSs35RgQrV/xLc39bfIzGJ6ImPXenLWqV
         Qm87W/lKJT0YALQNuvSUEhSxB89L5yuy2wWSuThoRA+vCNByIQbpEhESf3ZLB2b1hAos
         OdBZ/tyY6OSyPrJjMMiXMej/zrMyuI9p1dm6q2V9AUKDvkkTtrclJAlZi1NDjjFPLSXG
         EFicZ4Gli6c/QVNiQELNIujMf9vqHKKWFD3kYCM0tqVrT8aZYzbc/kuq+5zPUgj4ZUAj
         GE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347076; x=1785951876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/+QyJiQOclfwWoO6gYqbjKNhcIRAmaOqIJQ2WC3rJQ=;
        b=CzD3f3VpZsGfAkxJQecm3R+lClEJ+8620UNeT3OrnClrHXhhQZt6MKUINnoiMrNEP2
         7F0vIXi8ASAEDUVIzh5XE+x0pqlymUxKsLITrWHD6wRjSHY3v2QSCCEPWwaxLUIVSQem
         9oL90phnby/RQx5gcRnnMLHROHhxSsi/Gp40RVU83g8erzqrddz3TEiiq3ltfLBg7rIX
         TWBllLn7ceYGMWPG1DRMvGsKbUKbb37mV+PLVypyNvYhajFkx8Q99OmsvDPbMV68ClW3
         rgwUXROh9jXuIJkGecf6Kuj2Qxpyp1CznKqzrfEf350B/uqT+RTcauucxRM4UfoGc48i
         U7HQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/0izJkIF2W/ah4nqlC6I0eOEjXnm0l+AG9RAHvNI0ZVfA1fBv17iXUa1iprcbTkJLXHUluws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmIKzpHBGZMjEvDsOUtOgoQPGyzHJXK5uQ+BZpUfInMKwVab2
	T5Qx2rYlS1/6CpyU9CxRP4WEwSz1cZi4o4dgKAWPPISARn0pkB7McR0wJNluWoCHNR9O8aB9vli
	3dakTOjdCJWT+6uWoqPtqoaSxEaX/OYPKpftmORW4TVEUJD6m3h7MGNzx
X-Gm-Gg: AR+sD10JWE0VDiMOBBF30VtvRA2UKtiYN87qMlHp3nIO2U3DKL/KDMJGEU7h+B+BCqy
	fo3X3jvGR7lR61/ZrStxdnOOREsAhBX3eFg1hth479zznFkId7PLm2BdxwZ2psO5GuhHtmM9gOg
	kYf4USBi2krklwfSY/E96I+yEFrYBE9KXsAsCKiEi41LyOnwMkb8qlyWj9StallZovc3YV+tAjX
	Jdachp5AxEAczTEIpEwEm4vOI3ZzlzqdjM+YueES1aUYogamfMX648pA9hROVZHtmlMVuWynaIt
	mZuparVGToKUrXBehIfWHASJ/qxIZFYibDJllPdbd7U=
X-Received: by 2002:a5d:5f48:0:b0:47f:ade6:6791 with SMTP id
 ffacd0b85a97d-47fb1ed752amr9342287f8f.21.1785347075798; Wed, 29 Jul 2026
 10:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org> <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
 <20260723103607.55debff2@kernel.org> <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
 <20260728151333.2d778f4f@kernel.org> <CADWJPTuet6HTd7V104+MmgaS0EO=ZcLu=FiZs_c_CtX231w1cQ@mail.gmail.com>
 <20260728162251.24efb0ce@kernel.org>
In-Reply-To: <20260728162251.24efb0ce@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Wed, 29 Jul 2026 10:44:24 -0700
X-Gm-Features: AUfX_mwQevj58kkB_LU5ALNKvlr3Svaf18fXNpM5wxHX11suDnQPMqh2rLGhbdI
Message-ID: <CADWJPTsvsF4caziJQxdS4XyskiW4659TVE=KfPSPJREYME2qNg@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Jul 2026 15:38:56 -0700 Sheena Mohan wrote:
> > On Tue, Jul 28, 2026 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> > > > The recent updates have been merged, and the tests should now repor=
t
> > > > sub-case results.
> > > > Please let us know if any further improvements are needed.
> > >
> > > Looks good, thanks!
> > >
> > > I'm still waiting on the device node, but I assume we're stacking tha=
t
> > > separately.
> > Yes, we are tracking that separately. I will share an update on
> > devlink support once the patches are submitted for upstream review.
>
> To be clear -- it's not required to be real devlink.
> The format has to be like devlink (JSON keys).
> For QEMU virtio for example we have a two liner
> bash script in NIPA:
>
> qver=3D$(qemu-system-x86_64 --version | head -1)
>
> echo '{"driver":"virtio_net","versions":{"fixed":{},"stored":{},"running"=
:{"fw":"'"$qver"'"}}}'
>
> https://github.com/linux-netdev/nipa/blob/main/contest/scripts/vm-virtio-=
dev-info.sh
>
> Of course real devlink reporting is better because
> it may also help users correlate problems in production.
Thanks for the clarification. Yes, we can unblock NIPA testing by
providing the information via the script until the real devlink
feature is supported in the drivers.
