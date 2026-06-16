Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCC3ECBC7
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591901; cv=pass; b=RYE8bC5UGWQTwJPQDmBrmdlYiwdmX+wGiyeEKfbs8pAGZ8bCD6AuAguZMLqOV1Grz97iANQ3TCDqdGulsizzZYH2ktJtpR58TB0EGXYAzCkHnRsiQ9hyL9l8fw4sSU1D/d8y+BzlTqNC2uH4LyDiFWFCsh1PI6/8gpCQxZFkgLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591901; c=relaxed/simple;
	bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPpB+hQLe2n+Y/JMVnnrWnSUySj+jKkrTdDfo1Ys8AJMBDD4iRZRhazmySX8KFbs3uFHvfMBW5yq6PJHDCjs1NZkh7KGdtxRJGGleaJV302cpyb6YAwMuMJ7XDGsxbpfnLZTM26S6V7qzwuRNryI/gf7VJMu6vnr9RgxEGkmK7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCdyfq/c; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCdyfq/c"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so3082490f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781591898; cv=none;
        d=google.com; s=arc-20240605;
        b=MsfmMQv+ejYMdlbWiS4lrIJE44t5QTPNQxF41InbrdP3f0dJL/riSJBSbXynfmUMEc
         YSfmufjpZ5n7oYq2nRHmm0OEY/lpGPg0KoTpvj0H+q1UeyNKTgcWECPdib51paIe2BYg
         n37Pz/09h6dCsRMlRDBZUVN0NatXIMlHJq753PCjY4DeGTfT2kJcY70qrYBd16LbtZql
         7tPKBJd8okTNX0u/Uod2K8Zu1METhM0yraCm7LI+/uCz+dFI+92XBBEeT8KmxioP8tER
         ZtTLY+DQRnQbdoTxQ/QfCwOsbGzfDNjaYaJXghfe+wSEnR92FGcWZYwoD1MYVXiNiWYE
         8GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        fh=Mk6i5Qmsnk3ztJZr1p8+W8XYqZNoFuGE2lH2AUw0HXo=;
        b=RqS8Fvli//iaJj1bIL3xYexfwAbAX9I1n24R39lbDtutyhU1Z1JJr6P5llCFdVzduv
         OmXToUBI1A8oqsWEg32ijbuCgSBqWabWcjt1fFVwZk+j9pRu42Ow1vIMjZfMVef4o7Qd
         2+3z8nX5C5QSgy89XXNhrspF3de6O7a6Z/RwXsnZD0sWVO7qI3h0aTG3vDvtH+RAC5XV
         9FAPh6HQqiW6rUZntEc3mVyaULeCvCHMM+jVLQitmsxHCASzrVDn0DOFd+94NfM3G2AF
         D0TAhJeJ5k/favkGJpH81ByxTeFtGvFzHnI44LsaBp5ywXLYk96HN0j5VbD2gwCxtRxG
         TcEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591898; x=1782196698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=TCdyfq/csbwNTDXoi0an5Gyt2xnpYlXssRzAw7yl/QEXZK9cE9pdxwEc0QL26TL4z6
         A2gG862fFBUtL0pim6vgby3kjkGNb29nJTCgTRNEP0QI6MKUA2YNCJaRExhsFwQ0hzr4
         ZivENrblWimzl5P7+92X7IvsD9yMi1umN1g61OaObNghB50ddmvw2TNeBUHa4WtS4iL2
         tSLByc52ayqAAkfEXAf8k7l7kB0591ppCMH0DThaSunxQ6R4m9O79zFq3g3JddhQVTRs
         I9xObag+6bPi0MWr8QHTYGpw8/XXW2NUcr58eFgRL4mbdXNaWIqSEI+uhtSGaWTvW8xD
         0ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591898; x=1782196698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAHE27Z0i1OSVl2fxjSynlkhr+r+LPgK1uJ+hP7Zbj8=;
        b=jxUQM2bjv0/pT5xIdeK/rmSalt0wUm4dmidIH8hf7araZgPJpBqlBAmBL0whupaJT2
         794HWOvHvwq032Em/SYH3J2nQTscCVhEHIGIpXD/cNCz9vpUjK919RokPH0D0GKyEe0D
         5hAnZLk8Lpldb/AhP33tHddUVZRmwd/WbkwXYFaL1G1OK5jxanSNvLaf9Sv6/jswn0re
         /LPHtUIzcFcgWN3g75JBmXfHlpyvaA4aLmky5HZfETeZtVLHYXlAC9Qlqe77Wusxudwk
         LVkFz5YQOTELM8LT42GEpkS3h3SBmIMYZpKXfHft6+n3d5Q2I06pV4y26WZVOEiNMcQd
         mcoA==
X-Forwarded-Encrypted: i=1; AFNElJ8Mcq17c73TVwyCmhZs2HtQxdHCd6oRHLKburEpQlOSsm3PcfZGGRkIIKSFj+yh72jflLg5XTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDo1/M7+EUjZunU28Q5+33plYBrph2uoHNttO7C3VB9LCvAOdx
	NrNH+Pch7D+TFSaN8BF0C1BPrCnoSGdOHoRYB4Q0AFjJECKjfKBQYadiFr1gzIko8uUV0thOryx
	eYF/jNCmfQ5C5alMbWvj+Hid84g5UKVo=
X-Gm-Gg: Acq92OHjNQhLgZMPqXd5irVbVpZUC0dWOgwq+zimBFQmaQ6BwZLhcaAsGrgUUYNRlXn
	Un/4JzB4YdYF/ySwBD5HJdkte/Nhb4m7oSvNICtsbdYefv1FxDb2qBd2dnPZxytHz2BEPDMvqT/
	nEWfQGh1O+ruTJk4gFGUzMfL743xWEQKrPppXvk0kOOacbBzUBjC/OF9Up3u0OoB80N995aY+aA
	FoOA4uXSYHsBJjVJaUTf1+bMBNzU8LWZ3M+HiOmslpjJmlDwPrDvUWZtzI7XrufwHmzAVhBWo24
	91EVh2YMpWjm4e8Ce2wpc2cvCGsu3XNOo6OPFk1omc2v7ECaEN261O/rcKFW4fcL4As8Znku8k+
	XJw==
X-Received: by 2002:a5d:5d11:0:b0:461:a19d:3547 with SMTP id
 ffacd0b85a97d-461a19d361emr1794950f8f.19.1781591897693; Mon, 15 Jun 2026
 23:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
 <20260616011516.4039110-1-safinaskar@gmail.com>
In-Reply-To: <20260616011516.4039110-1-safinaskar@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Jun 2026 02:38:05 -0400
X-Gm-Features: AVVi8Cc6TBHBfR45WJ_2epcrLUaiFCORhANibC721wRIalY3QlqXFyIm-p-MJJQ
Message-ID: <CAJnrk1Z_V8TShvWV6zwTMQqXra3J4J5CL5ofFMm9DGoLj9whEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, bernd@bsbernd.com, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	fuse-devel@lists.linux.dev, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	rostedt@goodmis.org, torvalds@linux-foundation.org, val@packett.cool, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:15=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Joanne Koong <joannelkoong@gmail.com>:
> > > speaking of fuse_dev_splice=E2=80=A6=E2=80=A6_write actually, this se=
ries has broken
> > > xdg-document-portal!
> > >
> > > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> > >
> > > Specifically what happens is that the EINVAL is returned due to oh.le=
n
> > > !=3D nbytes:
> > >
> > > fuse_dev_do_write: oh.len 16400 !=3D nbytes 15526
> > >
> > > (where 16400 =3D=3D 16384 (read len) + 16, 15526 =3D=3D 15510 (file l=
en) + 16)
> > >
> > > After reverting the series, there is no error because oh.len
> > > becomes 15526 too.
> >
> > I think this is because of how libfuse handles eof / short reads. When
> > it detects a short read, it fixes up the header length after the
> > header was already vmspliced to the pipe because it assumes vmsplice
> > mapped the header's page into the pipe by reference. It assumes that
> > modifying the header length in place gets then reflected in what the
> > pipe later splices out.
> >
> > The logic for this happens in fuse_send_data_iov() [1]:
> > a) sets out->len =3D headerlen (16) + len (16384) =3D 16400 in the
> > stack-allocated fuse_out_header
> > b) vmsplices the header to the pipe
> > c) splices the backing file to the pipe. if this hits EOF, it'll get
> > back 15510 instead of 16384
> > d) detects the short read [2], fixes up the stack out->len =3D 16 + 155=
10 =3D 15526
> > e) splices the pipe to /dev/fuse
> >
> > After this patch, step b) is a straight copy which means step d)'s
> > fixup doesn't modify what's in the pipe. This could be fixed up in
> > libfuse to not depend on modify-after-vmsplice, but I don't think this
> > helps for applications using already-released libfuse versions. I
> > think this patch needs to be reverted.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L846
> > [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#=
L956
>
> Uh, this is very unfortunate. But I still want to remove vmsplice.
> Maybe we can somehow save my patchsets? For example, let's return EINVAL
> for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

writable pipe + SPLICE_F_NONBLOCK is a valid vmsplice call today, so I
think returning -EINVAL would still cause regressions. It happens to
be a workaround for libfuse only because libfuse falls back to
writev() when vmsplice fails, but I don't think we can assume other
callers have the same fallback.

Thanks,
Joanne

>
> --
> Askar Safin
