Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7E471CFE
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027222; cv=pass; b=H13qPX9jcG2JO9OxM3E1XT3uo8ITzH28C3qNXRnUpU2ZDHpoNvYFPq+Tzmm9Ux39BzVF5m7+z2Qw59+qChevxwdt3YFjTE47Tv8t03IUD0+x3DAx37P6/mNzN6CILd3kjgVjKwg6crn+qUwEHYAHxIGZ+b16FCodSQAqZxsgP00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027222; c=relaxed/simple;
	bh=gcjKawjwo26uLkajY4IH3jQHyOn7PT0OmTOcUrswS9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj6d23MjUMdo1KTmHv9gTaUjMH4bg8QNn7BjEE8DmArWdeoYg7u33+uHo2Yh4nvxusHgRKuDfxUUky9BB/qJENhuHEFlI257kUA4bheVbaL1LYarrzcmHB1c6cA7BXSgrsQzqGHZYAbADLySm4A1l76ciaaNFNXE0xzZmDbtmvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alCl8suo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2xcF2p2; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alCl8suo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2xcF2p2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
	b=alCl8suoolMoyncx/Loac02th4Vh6cPgJRiDXZ+59kHgehbEBYWy/l0WH54BTV8IXug4Wt
	ezeMhbArXe/yVJXtPBWjiQtRDIOtEJcKL2TMd8v7h/uOeXBP/71vYyDtNhFA10jT2yoIFv
	FjwVXDEDFhjZYov8E8umNjr9jSabdP0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-rYUekUvzNXiZqLX7IcKpYA-1; Thu, 06 Aug 2026 10:40:17 -0400
X-MC-Unique: rYUekUvzNXiZqLX7IcKpYA-1
X-Mimecast-MFC-AGG-ID: rYUekUvzNXiZqLX7IcKpYA_1786027217
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso3208062a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027217; cv=none;
        d=google.com; s=arc-20260327;
        b=Zx1Yb+Tjar1mIVrz9K2+lUUxUHxoEtvc5fmMPeujLkRHt74HSJrzaKHSqcdQFTy86+
         LPHpKKDpEysdfuymZqFPH3vwvvcmAJ3Cr66xfNb/Ds/T1qjh+lPfSu4LVh/UafxJX1+I
         oia6SXivEH/x8KghCfG19pPr/dkLAY7rsLFc/qkMuWIRIWPssWrdv/QQ1jFU61RzQQWP
         FeSWNwQBr647KiU776A5uewJxSStJPODGIKr71inDEIFWPPYUgWS7S2lIOh0Uzb+FUg3
         0KCHOoopFCfZwLOgwIC4Upul8EvRLQHuCvuUn1N3LwzZI4lZEF18iUEN2QXpFk0QUpU+
         7SYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        fh=ywc0Lk1ScWYuyC8w0kM8a1qDnznbpuhK+rVre6fOLUM=;
        b=JzDxHqIJ/5Bs1M9scZy+NBO9JRRjgYgIxECc5BBVvBS9pVC4gOjpgwE6qskigEJN8C
         x5MjqdOcbrx72qUOfcTs3Oq90Ne+lI0Ka1f3t7NS2bWh/z7H/7JAmxuZB1H/0ZY5j1z5
         cbOY3yMkZjZWx1f525212RV8rBj5kx+gN+fVCrLdKLcuBzIqFHl96mbyzqQz7dG9SFSy
         gmf4wkQBGFFewj96aIPSa8sth/tKYySEg+qfUdwzXq4p1PywVJU5b3rcUzZOVbGOIFVL
         HoBhkHbB8+UjOgwgO5IVOEAXw4thLFk4xc3N3qsCMJsMIEMc0roV0bwdyP+ouDyadg0X
         HgZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786027217; x=1786632017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        b=d2xcF2p2N5zpPp3oHuuB64b4d+7+czSQ4HGu1O/rhsEA1xN4xgQJYow1eOnaDde/ir
         P8YgW1ahpu+wIBOlRjCtZbpEJY2fT+upAFVX3uTbrPWeDAyMiRIM75Jwhy8p2OW/9a8n
         q/l7hS73VXOQpB8aRlIEd3wxLPADgVO0hCai72/gQQNfGK870zfc4sGaNmk9H2WgIg/+
         T5SmaLYjnkg8vYet9oRi52dOaEGkMCV7i+HWJNYTTZU6XajOURJn4Peinv7S4Prsr849
         MvjM6unh59tw/009tAa2bJqicWiReb5uU8HcaWJDLPjKqgfKoDCouafPxUHPph+LP78V
         d1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027217; x=1786632017;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        b=HpNgkdXoewjNOEMABI2zEDtQjLuUbjROikzUATEo4PBn47gdJTouJkFsLdyQhP+/3Y
         P37Q5qHTv0p0qSaYaTEd8j9u4TxRR4kHrWo+C0oZh5BajaXF+cP2ObN7XTw+DVoEiThk
         JzTIr0oecrUR+JLwCR1OqqmYjxELpgjq/CId8ZFM92XA/n7cyF92YmxFZoD2NZ/pp55c
         8bHQ0+hT4eGOEYRvmI2VhdKl6DLK9ZLDu5t3yvQwOM2TmiGrAod/f0f+e25IGUbx8EfQ
         H/k+abfHGmb22vXLPdD685NWCPt3v5wq2BbZNfVT2eRVM6m320evZTD3AXr3Eo/F8mBZ
         y06A==
X-Forwarded-Encrypted: i=1; AHgh+RoWpDI6OT9AKpWVIR4wkthR0m8clOcSB/D0Ma+EepgBvh25Nc0SO0JM7xxyqhTGTIMd1FHo1h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUhEeazA16R4NMg14tHpi7+tEz1nRLRO5L9A/2SLilCXFBBoG
	yWcD+C7PAqdw9iAfsIpVay1wu0QT2Adif0Xbce0OXg12Chs6LEaC4y1JEyDC+mqqXJw3k3e3tqy
	Diy7tM4xGwfzNpoRoNvYVTKBEFz2R4pE3Z5SWbfBvuKoNa3Iu5xE23kQ3QO3otOyI8xKxE+KQ5g
	TkCjRG75S2f5LmodmjR4fx6ThSnnl5bY8L
X-Gm-Gg: AR+sD12aKouOUsGnDbakrHRNadWIkrY0jwX5RKFcvKbNx5smyR3VKdHPP4oa269UTMe
	pn2JkSsuuq13Z9xPB0MESUO9GGJymYH3QSsyGH7OenL8kTVz52P/AlDsvD/enN+35ei0zrgJTM8
	gmGBXzyeIUSGeMnAtPmshB7qpKYYWMxfEsPPlvV9G9MKQjR3u2y83mubU=
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3903c5c51cdmr15623459a91.17.1786027216700;
        Thu, 06 Aug 2026 07:40:16 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3903c5c51cdmr15623360a91.17.1786027216105; Thu, 06 Aug 2026
 07:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com> <anSMBpQJ8x-vXYy2@sgarzare-redhat>
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Aug 2026 16:40:04 +0200
X-Gm-Features: AUfX_mxXaE00zqmd2DiALac4VL3A9WWcVSqpkYeQGMWjXcfcP0SiHhV-7fpbPQU
Message-ID: <CAGxU2F4b7oy338gRSJyNko=Bnwyi+MCdzOKAtZSW2q_GJnT6=A@mail.gmail.com>
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, 
	stefanha@redhat.com, jasowangio@gmail.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 15:35, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
> >Every other update of vq->worker is done under vq->mutex - the worker
> >attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
> >the sole exception: it clears vq->worker without holding the lock.
>
> mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.
>
> >
> >The effect is harmless in practice, as this only happens while the
> >owning process (and thus the whole device) is dying, but the lockless
> >write is inconsistent with the rest of the code.  Clear vq->worker under
> >vq->mutex, like everyone else, so that all writers of vq->worker follow
> >the same locking rule.
> >
> >This issue was found by Sashiko AI review.
>
> Can you share a link to the review?
>
> I don't know if it's common or not, but having the link in the commit or
> after --- will help the reviewers.
>
> >
> >Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >---
> > drivers/vhost/vhost.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..dbb6cb5eccea 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> > static void vhost_workers_free(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >+      struct vhost_virtqueue *vq;
> >       unsigned long i;
> >
> >       if (!dev->use_worker)
> >               return;
> >
> >-      for (i = 0; i < dev->nvqs; i++)
> >-              rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >+      for (i = 0; i < dev->nvqs; i++) {
> >+              vq = dev->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              rcu_assign_pointer(vq->worker, NULL);
> >+              mutex_unlock(&vq->mutex);
> >+      }
>
> Pre-existing, but IIUC vhost_workers_free() is called only by
> vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset()
> on each virtqueue (without the mutex) where we already set `vq->worker`
> to NULL, so IMO at this point it's already NULL, no?

Oh, sashiko reported pretty much the same
https://sashiko.dev/#/patchset/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com?part=1

So, yeah, I think it's a valid report we should fix.

Thanks,
Stefano

