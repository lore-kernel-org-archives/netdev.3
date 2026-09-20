Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D738229A
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870772; cv=pass; b=vCb62wHY/S1T4zIgSSu5Yq5EVui1Mazbq8S0jCltkGXdH0VUuBC+2qGvQhZBu4s+wSJ8TVBU8ZG1srF6S1dCKB3TeLhlOxFSzH4QWvQyZjKP5URVmjvZQobHwoEoXRPRY1hKw4qFbhvvfb/zGRKX4LsvqRxqAhpp9eq7WoRiHXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870772; c=relaxed/simple;
	bh=Oj5sg9PCyDUl3TeOjKEQSeMqK8FhKnxaUFXuz/wNJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMCjRqozKPlbZHj/VqXKmKo47zh1zh0JXIFnqUKaD7sCB2ynsC0NLhzWu7sZ5YG5M+NQIkShM2lARl5+Fh0OPkCwJd9Rfr9KW06s7p5RyZtFALhAbM85JiZ28mmap65litCoSjBN4qOx27HVqXqJmUtGgYFfsbJkKnV/DHzd5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdY/aojF; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdY/aojF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so18436636d6.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 19:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789870770; cv=none;
        d=google.com; s=arc-20260327;
        b=BooWIJeIdN5kdy7cETz//MUBOtJ0wEJRtT8FPvqBAVZ75z40ZJNjFXsk370L+thle7
         SFPldOOwtZbRg45V9p3S8SFwDfZ8LNDE5g14tDk+F6UpfvQUTMfaoGp4e3uk3dP7d2z0
         LPe3htC6I7alM68aK1hiU9wlq0ue7nHrhp1EOi4jN+I9R+lxjRRHI61ew9OdgCpKn48q
         lK1QrKT6L8aEh/MgyoH4zstHP6kd/rOIbvt6EhvvPCHURnfQbsDOkxpyXLpyMQsE5BVa
         nc48QPkaO4JS8V7ACviXHWFSklf5jTddvxU5H5Ty5F3vFDOgc1HCY36QcQlzzOEUaPtM
         J66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        fh=U9SUGJ3sJgmv4ZyIk0m9910CW97eG+Tz3epH1qOliZk=;
        b=fAHr47trZnkI3BDSjElJx09FYITNKaInwEgeBoUJKZoJvbU2+llR93obk5uROrK7p1
         XbWGueWfDc12wuHOpvsV+M4AZO7/SjPOPqF4C4D2Hmqh7KiLTwz547IBm4BYia27NgCV
         W7LJ9yVi50bkfOmSQBnRRm6QhTDri+9eLn/jxlb7tW+XcHdPv9ZnVGyHorXWTzpuh1o4
         7q5Mp9kSEqIpj4uLQlGmgHseXeVu+4RQ/vrO3LSYcQnIPZAgZP2XtlxJgAyQ0z2yyLrP
         QEvl7HfLrNdp3ovcPmn5gjoVv0PJXemquWjWvSVQ5GaNKexvb8ecoIabtyfnmQwgZ/LQ
         toPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789870770; x=1790475570; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=ZdY/aojFRC54Cf2Uxg5kJI2s7ovE/rCSqWRmZqYsrhcX5FrMmwETLowV9bl+QBfGAG
         V9RTkGu0hepuCs2TIYuIo0FoCh9W7o42lN8okRXyHvq3fTJkX6+n219g/55KehYaH0Fz
         dih1Zl7u75NLe16cg/EUIJ8cqYY32pjeZX5MGVcWaH40cnuxooGTG6UBikVes5UYSiiu
         rMt9SFFV2v8p/XqreluP5GuSnFx/JOAyanhSvajdHH4QSM/kcsNMdrs2/n3bNwnZQ2uW
         zdNXuKpO1WZOxwD01u+BtOFvRSKVeBHejKDE6kM+t9wieGv/Bfb0UeYMEyYi5doSxGLc
         NBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789870770; x=1790475570;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=UHohMA5edBDH+INPjWzs9w1WlkiJwOJ6RbgH74+Ovtv2Xl2bus3tm8aMl08ncI0lNF
         dOZ33drU4aUAN9GhoIB5WOjEbVc6NlzCx89CYbOieYqWTvIOlhaPdTluhw1JYWz2G5Dp
         hopyfw+5JXqxc7hJi1Tbk1PEnYqvErj4rURGepL8j6JA953gAAlMtgjhlTU7T/RGuooc
         4MEfI5eHRfTLHxJjfMurkGGGOEDASgkMc4WJgOOSzI7ez5oO1DEQzELFngWwYYZ50/5N
         nkXG0OKlPmWQTRrmfXr1+jaO04BlTehW9GFYXHnvQOEBTTDFhZamZA0KHlfFOHuzwTc7
         Cqkg==
X-Forwarded-Encrypted: i=1; AKwUvBxGztsV4uHBEwfRYU33vS6cn32KfvdUyYUQF28sVDLkVQNVUz2vDVoiDZeG7oH6k2LBluRVEf8=@vger.kernel.org
X-Gm-Message-State: AFuF++mc/6nGx/QknD/4i/ZjRDa1aEXVH/FUFZ+UbSwo/5mVQkA8b5qK
	tWpcB0fCxA8JQzIXY3RH6bikYsWnHRmJrmaDpk/ICG4tqJWB8ljxdAY0sxf3q8kLpGKZ1X5p8eL
	F7gCF7MrfkGk100iHswbIf5qjnowwb5c=
X-Gm-Gg: AYBFou02ZpdvbMulJ4RxbPyO/SU7BOnQfkxEovNLz7Wm9qXVlngXRLVEmKEaX9/HHJz
	Ml+xqnTF7AnNlGX0bkVRww91ssIggRKklxz8Khz9N1GOVtCMn2Ygdp+8Xh7Ln60V1oM6rIm/wV3
	YsnQGYtx7duJQvca0eMnIfAbyqULhEzkeGo+8crCfm5D+6PEHaGLOGr6Z8pQFb58kWD802PkBOm
	qrfjelvQ/mVO6GY4Qnlrn1QtTI5ux3lEduckEYA09ZQUPyx6Sx/epV1QuXYfyenCtT2eFUZIT9A
	hgWm+Fj14RC0pihj0FWe2gPCI9dgL3QMhgXlDUyVSvqdn/gNnH4ktWQU
X-Received: by 2002:a05:620a:a0ce:10b0:93b:d58f:4fab with SMTP id
 af79cd13be357-93bf5595417mr270410785a.25.1789870770127; Sat, 19 Sep 2026
 19:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919131744.131030-1-physicalmtea@gmail.com> <20260919152336-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260919152336-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 20 Sep 2026 10:18:53 +0800
X-Gm-Features: AcwNN1VkMN-0syiFYPeuWa4rISLvm99vUAZPB8bHXDefFB9Y34rSJVqTJuxGaqo
Message-ID: <CAJwVaM+BmE_HoN_hSYL28nhZh1ZStqH9Od3pizAb_fyTZAS+5g@mail.gmail.com>
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is attached
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Sep 19, 2026 at 09:17:44PM +0800, Jia Jia wrote:
> > vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> > completes the command.  If userspace changes the vring addresses while the
> > command is in flight, the completion data is copied through the old iovecs
> > while vhost_add_used() updates the new used ring.  The guest then no longer
> > sees the completion.
>
> I do not get what all this is trying to say. if you break it you get to
> keep both pieces. when is this a real problem?
>

Before running the test, I checked the virtio spec and vhost UAPI and
did not find an explicit rule
prohibiting changes to vring addresses while a backend is attached.
That is why I ran the directed test.
I see what you mean now. I'll drop this patch.

> >
> > Reject changes to the vring addresses while a backend is attached to the
> > queue.  Keep accepting the current addresses so userspace can update
> > VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> > that have not been attached retain the existing setup behavior; userspace
> > must detach the backend before changing their addresses.
> >
> > Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 44cac11b68d2..074590838de5 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
> >                               a.flags & (0x1 << VHOST_VRING_F_LOG),
> >                               a.log_guest_addr))
> >                       return -EINVAL;
> > +
> > +             /*
> > +              * Commands may retain iovecs derived from the current ring
> > +              * addresses.  Keep the addresses unchanged while the backend
> > +              * is attached.
> > +              */
> > +             if ((vq->desc || vq->avail || vq->used) &&
> > +                 (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
> > +                  vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
> > +                  vq->used != (void __user *)(unsigned long)a.used_user_addr))
> > +                     return -EBUSY;
> >       }
> >
> >       vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
>
