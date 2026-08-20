Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BE43F0B1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228811; cv=pass; b=CAiRdftYIS2wfWkjnxxpNHeVaX0IB1uQIOwlwprojK+mItjBEik2aW057bQDc+S0Com51SfyT+jN0n2/ChonBzXvUEANMzBY2lPHpF6O3rasGMw5fRzq6VzPHtAq7mVSE+syq2KCpnqngKdZexARlh3zoAqYMPBF+Ue319NpHeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228811; c=relaxed/simple;
	bh=IGs71nhOgGaVjpIG8DskqbqnZo+eShOgII8VvXDhzeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEie3xdfDxNG2qkqn1F0YCHewfjtgSzNFnwf6B00oKJW6MbBfilDjUMLy1ES6KLwdcDg+BCelLfAjkEDpiJXJhwbxTNQKehFfoZdBShRWti1Wdt8yws/GwA7TtRqZ+1JOjvXDkfwn4KRkvcHGM4ltl3lsMLSzNcVC77O4Kx2+JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5hwfWIP; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5hwfWIP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5b048375so124702285a.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228808; cv=none;
        d=google.com; s=arc-20260327;
        b=sB/KKCbWCCl8P6XycwWvPiYYeLXvpa4/vuLoz7VM1RzjGAfSgJK3OqNJcTcO0nLbiz
         Nf+fvZkyP6XuPCZXH13FL3SkWkVAL/1QemkZXkpiXOcd0w5RATDiRK0NbTlm417sR1gH
         VhNOWUKQQIo5uMb676SE4uwe1M6VHH1EOOGyHyQjK2xyFznAwBwiOCd9vbmj1iFcAOeS
         7jY2V10klewpR4irOtFA+7FaKdG3NglZJylbBS+bXAgFj1Of6U51npO7dX/Xg/hLXcO7
         bt1Bb6sy3xc8kXDT4RQIpO9psBhOrFI5SRoiRrA4xHltBVs94nDGlqUy+ttUXabTQo+a
         dykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        fh=bDE+EkuE13tXvsXYuefujvG/uAeLf8Yu7F7MWx4mfSE=;
        b=RwXk/7ABBwKnHGxVJAizlfau2XFkquMJOPGFDXDc4+NmCc7rQ2i03/UFNQFNnBADl9
         /LPY0XnDhbVoLB+1LoJT+zyRG/YxmF1LmAAsbdPOMwyyl6o85Mq1zGXdPcCXMT37mglr
         bvC5LhbVEswndQLc6Z8SG+Tmq1dL5e920YWmoSRyc0+DjfjFVSyAvUh6+1RHw7UkB87A
         yDo2GYuJqhAqGWzrz3kGjuCzDL+wzV0I+Pd5VQyaObtZrCNFWCADxHhz1gGvbEliK6tF
         lZVYYdmdgrTXFrOpEThgSPgQ9xXG6Rj1vNTF0r0l7hvzYWcN2JjWK07ayZBojcWGRN6m
         fIFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228808; x=1787833608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=n5hwfWIPnqF1ljShQcy5zoTE5GLPMvGnaEpSX5fb0bFKTYz8r1eMO9lzK8cRJwkNMM
         kwvSZj1LzdjgnaISVOSGsMY5lr3yA73GLej2msR0y0NQw/rW9weA/eY0jwTg71wpOC5P
         kIG/SFSOwz3olA/H4fLSs1gzX4N2cT/xytHrinYtCmG/NXOnQbt1LEAX/D9OqNIkyt+T
         Libb9QJlpBhlN7nOnFkSDKfut5WsBWtw1iOxaZ8wq9y7NNAUWgf9/MiQ+JlMS/aBEZJM
         NJLMot1DOyOkS0p86xCsyjZs8YLkHsAxUtndSlXagC99dhMD7hxvUwRq8wyTgjlEFgoL
         fJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228808; x=1787833608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=SxUFU43cZ3Cvvc3+AQgnvXWcQTDW2PpcYZf29if/cAfvCWMHAmEH7QH3ZEPaoTPLR9
         Sm+0GIuOyjKrqK2JtUBQcdhWE7ySefNeYrQGM1a4+YysJEw/1YlUQgVNE2FYLQkhJLDV
         zIZNMVDgwoRSvDqu12JHIId5gID7UzhdK7MsYifFoocdzWY5PhApsMz04jF5ASmQupFf
         qEXwDChu+BTYLLKYqwsBvL6lGiR3lBWJioS0bc4b6uXyfURR+FMh771MWUnT9c9lCqj0
         t+K3c4A2/Yxfni2HgTAg3CihNjROo9McLXOb6c6DImPGtlV4FB4fkuyDw7BBKSrwkWXK
         +Njw==
X-Forwarded-Encrypted: i=1; AHgh+RqewbgOL+XS4v5C8VH4XY1E5D0Ow2uN75FV/fGn5bdmgAjWoTKqRD+dnkH9XNNlQAPqzg/QTJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0a0xoCxud432WWFD0CXmJk2PKtqkuZzOKvidICMd8jPBNdPLQ
	cM9Q9uKROVDrrUOGIzwflwT7TwzCMBajnPorB35UXEwmHK5mBqaQYEikBKIqHz6Kz7ZOMkF1Nc1
	DeQnN4YlPVbei0mFLiv4Ff+TnRU35rBk=
X-Gm-Gg: AR+sD13Ic/1AlJI4koHcdlYCPzJdOqpVKJ43lMpvJCqfQ2Ba+JjvjhxspPPafm/Jqmk
	3FWnfsAFj7OG4tI+kNDMdlbxN4ybMQ20rJ38p5BRsASrbUuG0iX7I03e8gAtfD75p1xPxBUUD+u
	P1Hfht5Ok/p9Et0IektN1LCR79giFrezJwBM95EC1h0nlEgnHHN8+yjxAHwpNvhZEAzn/Unovn+
	B0AcBFLIRfKBOr20cUEj9SiBCQBl1Oty9ozpCFzV1UfOGzrqVOcOBJxSi5F/8t6ypgp524Udl8K
	SkTaNdmwJYyu0jk1jXVcYhQBRQsIESbRjrz2+hEFXFmf
X-Received: by 2002:a05:620a:44c9:b0:936:d9ad:67fe with SMTP id
 af79cd13be357-9371e2029f2mr1042764485a.3.1787228807799; Thu, 20 Aug 2026
 05:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com> <aobEwtvZ2WELwX15@sgarzare-redhat>
In-Reply-To: <aobEwtvZ2WELwX15@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:26:10 +0800
X-Gm-Features: AcwNN1W9WrFqa6rrna4A1-P2dxuYVQJvqoSZIMHeqb-Fn4IWrxAmb7MsiC3ZMZI
Message-ID: <CAJwVaMLrp4+d_6cx9mHEMC+FoD3UUu-Z8QVDAm7Ekt7SrqjACg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
> >Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
> >Otherwise descriptor translation can continue to use mappings installed
> >before the feature change.
> >
> >The common helper invalidates cached vring access and applies the
> >transition even while a backend is attached. The backend remains attache=
d,
> >but userspace must configure the vring addresses for the new address mod=
e
> >after a successful live transition.
> >
> >Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> >Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vsock.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 9aaab6bb8061..e1e9d002d6ae 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vs=
ock *vsock, u64 features)
> >               goto err;
> >       }
> >
> >-      if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> >+      if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>
> Unrelated change...
>
> I think I've already pointed something like this in previous versions:
> for a patch that fixes a specific issue, these unrelated changes should
> be avoided. Please keep this in mind.
>
> Stefano

You're right, thanks for the reminder. That was my oversight=E2=80=94I shou=
ld
have cleaned it up more carefully. I'll remember that going forward.

>
> >               if (vhost_init_device_iotlb(&vsock->dev))
> >                       goto err;
> >+      } else {
> >+              vhost_clear_device_iotlb(&vsock->dev);
> >       }
> >
> >       vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQ=
PACKET);
> >--
> >2.34.1
> >
>
