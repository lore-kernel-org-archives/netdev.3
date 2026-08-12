Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316D40861E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572820; cv=pass; b=PUOnK/X82BMAzwyf8tVARVMU4JXC0SNTCGSFP83AK05s0ijmSF1A62oRdu1Ng39KbReBkIuaoRSy7+2EwNWCRA8FJGAC2k5gvpaa8qoCNCKrpNbFrDKDdpJxAeaGeQP9Piyo7suf+HjcNoYfQmQf1Y/AR1YRv1VVXdFwDDgxaRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572820; c=relaxed/simple;
	bh=byyagvsc1UjkE8b+SW2ccxMNYjbe0DMj7QW0GEW3cJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtcBL4fvwRquXwyLyICCFsXi/+IV+VuXewud9uepPSYEERBFMEROLBOjnAticMN1eZ4UzxFTP04vlTb5jfN3hM8qBLCT05JoVWgcftQeeYtecSsRjYyfyERxAbcy+R863D8wmOzVbQytiELJKY0LPuRKLt0Sr4D+aE5BuqaEuIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/9mm1CP; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/9mm1CP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d01663d816so15765395ad.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786572817; cv=none;
        d=google.com; s=arc-20260327;
        b=a50Xxlou8VRIOXl6cd/tjOobD1GTxEQ5p1e1gcrS1b3Gqsw0oNy6OQxnzsH3Kdgjfv
         xp9N7RSJyE3hWSa2HN4PwHHAtzNepz8wtnV5Bk09oRlTWdoigKjuOA3HDhobNf+nIpMv
         bvZdPUJZiLl3uEOISmFmfQth/xJILj7ZKfZz2Pxdrg6Xje3VFQCCev13ylYmCALS6gyF
         YihnCr9CdTcdcCd8oFKKAokQmM1nhSGB08DhV81ZjMhnL05fuz8VzAtVk1L7Aoh0wArm
         jhyH5RjcCIEJeeoYagg3AjHvq9E3WJKaqYSAemj82mxpb93JoWmZO4h7G4A2RcvFqfnx
         8Npg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        fh=nAvhDzIVEHxZBl0MIU2PshdvvkXr3WH+xSq2bE9460U=;
        b=AGwdUF5yew1FSU+Ryh1pCmmKAWi5rYPpKga4nIeVedcvzGRTa8U5i/c9Sl4PTpn35I
         +MzNFA+PmigjOBkOeyEDlC+TuStMENkM942h55B+QwttlKNsf57m2gOGUQ2WhHY8FJpB
         uEB8bsgXrK0qI5QsshKIn+yXvel2Qsr9ZYoYtgJ1ijiCDbOhrOqW+PYBlx/kLJDQ461X
         fyIkd/IZg9YXrlFHmNRwdeghPxPHQR1SzisIQ2q89t47IbjVwbWmCqVQ68k64FB2IUEP
         hInjo6Pr8LHEWqvk83ccWytPPArloJjoIdmW7fIqN4PNOAm7fobmoOGmA4AGuEQxmNIK
         Vz0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786572817; x=1787177617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        b=L/9mm1CPbIdg9Qw7XP9oilnJsDnMJMBwrE+hchPA7UoXCFAg8LDjYqNnw8d1czCwqe
         U/FAs7gTaieY3w0Sgpk7GZ15VWODjeOQR8UXmXUNbDIGwyfiWD6cJlUQ+KUYHwgq8QJa
         taTPO4Kew46OnyqbQyOXvVu4TlDohVnp1+ri6P55Ccu0J8fSWkidBU1MvxGrae+0v7K/
         jMMUxgUEVCJ19Diw1levlv8jEZI4vTq/oTdb0OGP7G4FbNsIw24H5xUpPWCDpAhuh3dx
         67syzg8MXi4C6E4vHJ4BeqZmy4A3eaNyhkIZCmrwParQjn2GJfAtTSz+3YolQ1bMByV9
         564Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572817; x=1787177617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        b=amJFmP2S+Iy8/bVVOeueEGP2cw3lKabjSz14hTd8Ji8KPLL9kvWwhRPLv57kuDNNvZ
         NpLJHUgEM6DYqIQSrS/TyZp2Je+SVhX8oosKvQuLI1fqjF8hVgyiL6Pgage6Eezi27ZF
         KaKBLPEOfbaLDWRnfu9fVmaRy5JwoR1lohNuMLpUgFYpSHPUqjfnAbw3BQcGkefFketp
         AHXQFe9f8fgaK9irpo/ihcAnXLwFmL1xEyWrnic2Wg3QxKhrbKsg1ZITw1iO9S8khqEl
         v9h5cNW/bDR+SEHg6Uh1uoTvrnmUZU1PpiFX+TpKFWu/rznbgEcfAtWywnGzxJXEMgJd
         WGIg==
X-Forwarded-Encrypted: i=1; AHgh+RoojjLXMyglmoYgQqrlSF/IbdAW7PCm4duKzbjjoVLhQMuqA0vPKGTfKhkhhSNAgG7pS5gNVa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbqaiRRvVBEToYWS0KxE6u7DrPIpdEZ8MvuOS+Yj/YGwXFEnNL
	veK3sa/PPuV/7rUmlRJgPcivfaqbgWm3N14H9QCm4hZZF6YZEoTRoa5mlc7XJCwt/MQIXbkt+p8
	I4V+Kt+vP/pXd9nWf3QBxPg/ZqxMYYPvIH9vmtb4J
X-Gm-Gg: AR+sD11toGA+185d+LOApoJR4HWhBLlR85qBYrnUWvNhtvLdyKcfnjPqsOuCffk5rNT
	SOVrSZy6S8HhT0iaZBt9wY2OJQHKnleKNRzbqX6qzv4OivoyzjmGeyD8kAmtrS1wlDxq86OVAjo
	mQa8PgTKeQIdZ0jY0+9DgwKpd4iQN2wQIGi6J44hV4aHUSuUwxliVlMJFtAeZ/7MWZwDb7gQ8X5
	AmH/xhOnzyHqoDQpRSCr0BH7INpsiAyqidn65xV/OpWW5+nIUnbysqcu5zguwRFgo+LTWDQuqKx
	jP5FdsD/ZeRoO4iYONrdtl+16CUKv2iPR7b+O+H2skaIO2jpSQ6z2vI=
X-Received: by 2002:a17:90b:4e8e:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-3931dfd0888mr1664002a91.3.1786572816160; Wed, 12 Aug 2026
 15:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com> <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
 <anzvkibgzTae9eV9@google.com>
In-Reply-To: <anzvkibgzTae9eV9@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Aug 2026 15:13:09 -0700
X-Gm-Features: AUfX_mwo8Ob8itM9mFOrvjUREAOlXg8MDm_8-_pKnvDnHzhEXLZf3Bq4dnwstOw
Message-ID: <CALzav=dptFQTKyUAiDVsv4LF79pkhfHaVyaYE8FD4-5rrWHGZg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] vfio: selftests: Allow drivers to specify
 required region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:11=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-08-12 11:59 AM, Jason Gunthorpe wrote:
> > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > declare how much DMA-mapped region they need. The mlx5 driver will need
> > ~18MB for firmware pages. Existing drivers pass in the sizeof their sta=
te
> > struct. Since drivers all use only their declared state we can use the
> > value directly and remove the SZ_2M hard coding.
> >
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> ...
>
> > diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/=
testing/selftests/vfio/lib/iova_allocator.c
> > index 4a660f636f4972..c8075575e9131d 100644
> > --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> > +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> > @@ -13,8 +13,10 @@
> >
> >  #include <linux/iommufd.h>
> >  #include <linux/limits.h>
> > +#include <linux/log2.h>
> >  #include <linux/mman.h>
> >  #include <linux/overflow.h>
> > +#include <linux/sizes.h>
> >  #include <linux/types.h>
> >  #include <linux/vfio.h>
> >
> > @@ -50,7 +52,8 @@ void iova_allocator_cleanup(struct iova_allocator *al=
locator)
> >  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t s=
ize)
> >  {
> >       VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> > -     VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power=
-of-2\n");
> > +     /* Adjust the size to the allocator requirements */
> > +     size =3D max_t(u64, roundup_pow_of_two(size), getpagesize());
>
> ...
>
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools=
/testing/selftests/vfio/lib/vfio_pci_driver.c
> > index 5e65434d2318b2..52b9c2a2bbb9b6 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > @@ -32,6 +32,9 @@ void vfio_pci_driver_probe(struct vfio_pci_device *de=
vice)
> >                       continue;
> >
> >               device->driver.ops =3D ops;
> > +
> > +             VFIO_ASSERT_NE(ops->region_size, 0);
> > +             device->driver.region.size =3D ops->region_size;
>
> I'm seeing failures with the IGB driver with this series. I think it's
> coming from here. The region size needs to be page-aligned so that the
> IOMMU map/unmap calls can work?
>
> The size of struct igb is 0x20080 bytes which is not page-aligned. The
> size of struct mlx5st_device is 0x200D000, which is page-aligned, so
> that's probably why your Claude did not notice.
>
> # #  RUN           vfio_pci_driver_test.iommufd.send_msi ...
> # /usr/local/google/home/dmatlack/kernel/trees/review/tools/testing/selft=
ests/vfio/lib/include/libvfio/iommu.h:42:
> # Assertion Failure
> #
> #   Expression: __iommu_map(iommu, region) =3D=3D 0
> #   Observed: 0xffffffffffffffea =3D=3D 0
> #   [errno: 22 - Invalid argument]
> #
> # # send_msi: Test failed
> # #          FAIL  vfio_pci_driver_test.iommufd.send_msi
> # not ok 33 vfio_pci_driver_test.iommufd.send_msi
>
> Applying this on top fixes things and also avoids a potential overflow
> when doing the roundup_pow_of_two() in the allocator.
>
> diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/te=
sting/selftests/vfio/lib/iova_allocator.c
> index c8075575e913..66a160d4ff9d 100644
> --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> @@ -52,8 +52,11 @@ void iova_allocator_cleanup(struct iova_allocator *all=
ocator)
>  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t siz=
e)
>  {
>         VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> -       /* Adjust the size to the allocator requirements */
> -       size =3D max_t(u64, roundup_pow_of_two(size), getpagesize());
> +       VFIO_ASSERT_LT(size, rounddown_pow_of_two(SIZE_MAX),

Oops, that should be VFIO_ASSERT_LE().

> +                      "Invalid size arg, too large (%lu)\n", size);
> +
> +       size =3D roundup_pow_of_two(size);
>
>         for (;;) {
>                 struct iommu_iova_range *range;
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/t=
esting/selftests/vfio/lib/vfio_pci_driver.c
> index 96a940ea59b5..b31abfe2c7ff 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -36,7 +36,8 @@ void vfio_pci_driver_probe(struct vfio_pci_device *devi=
ce)
>                 device->driver.ops =3D ops;
>
>                 VFIO_ASSERT_NE(ops->region_size, 0);
> -               device->driver.region.size =3D ops->region_size;
> +               device->driver.region.size =3D
> +                       round_up(ops->region_size, getpagesize());
>         }
>  }
