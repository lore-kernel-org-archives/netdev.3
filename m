Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0A25B08E
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704196; cv=pass; b=niXCkop98MC5GqLBIx66xdGl9fdjsbDYXHu5HWa0UgWhJ/+mNdGuj+SXqwBNVI7WJ9QtfA9qFFPBtGFMpVMF+H2Fy1994w41KW0u0XKDw12SUi9AF0iJxYP+DtBbWRxTzbf6QORsaRf/fzO6w3lyfXNXW1IkuE8+SQ0diRqwfjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704196; c=relaxed/simple;
	bh=f3jPvUnTp7pZHLKgu3GQqV/OfFzjQtSwU89KhbiFQjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv25cra1XVP/rBbxkdl5NJFdvqqsFSLrCzmRWvU5mG0G8D/B1J5VpO7HngY6hUW9OFxMcbkhcIPv7HMbuFbSzFZC7yyvkN4i2UmWi/hXkSRI+jvtrxIONIuP7Udhzrg6IeHuSMAxt2PmP2SsfYMCh3IOs1MOIS+wfkc+cE6g7WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEPOvzym; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEPOvzym"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so649a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783704193; cv=none;
        d=google.com; s=arc-20260327;
        b=EB4CGN9ER+054LHp2VjDwPlVJE8wIC5jnc4e5nWRWYFKCeDMrxgY/9dwb/zkg4D2Ry
         p55aC/PPvAc1VH+A9BdcPsVSmlHscTKerp/yPd0DJYoxxn3x8GYau4B8FnWx3iDkHHO3
         Av2xXg6j0wNPDzAZSNsft/zQy3yMRgRb3KMjngB7lHU75XzQ5ETzDiF6nod2z4qZNKZO
         3mCkc0BmmuVP5YteUzZaK3/29iD3h6lPyQ5Ox0YAgMXZ0lV2wihOSgCe6isegl7PKjgW
         B3gKeFsQLIYZCDEMSCgxHE+UH91zIBoJU8lghrsi/h4vhj1zRr4phjJvi2qxCkjXvrb+
         eeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        fh=zXaqLsN2DkK4myRHvHQVmsqTR4s6tgS0GTuRhCQFCbg=;
        b=CdchZE8pUEJ9XBkYbOGey6LzchNy8ETgb9T7cX2MasxQ0HZgZE9gKnw9QIDFsdM5jX
         HlKhV4328fJG3EFPM5NA08lwoDns8Wi8ezI1swJ6ZrRsAEIIBE75+tzw0qr36/6O+UVg
         gAQ8QMwHKGoP4FKctnobpHP9IGR/xZzq7jYGR4Z8OSaUx7p+422n8sOnllKSH914p4Xz
         1inqfyTDiJ73eP/nPLnDGnUH4QKVAINIIdm/h4p/S06GFL10OHCeCNMc1NdYlGxph7+I
         ur5OsdgNwEE11zhIyJnpVt+AMULJbQgsO5n/9gYSB2Ff7kkli00KPuMWuEQQY508uAZm
         Qv/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783704193; x=1784308993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        b=sEPOvzym5xCP9zmA95i9I6SHatabSYIcqNU//GTqBRZC3HOX7ye/nvzXA9ukBQafWv
         bOtlQobP3dqEcZgY9SxbO3cg+u3qxNNvV4z1o8A0Uef2FU/k/jSEBTUwtNYpyUf88U/v
         BgmFrOSgsJQGNHqzA0cZ/ONIlNo67rKWQ5pvkyuJDivhx3NHRtALPevSQbOCv7RqZyDD
         ZnHYRr4r1LKkIfD1duYtG4vc56bBamzkZpVFZ7fCEH10rdqUHx6v+tq2gqdzDCW90ABE
         pm5URmVKEkbzfK8oQIibDs0mwpaMaAta4+VkcWMi4i7EbD++IvUVN1tLu5K/tu8hc98J
         l2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704193; x=1784308993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7AFl+xfaIV4qDK/vCa6ZXugiVbCy0b5jo7a6tQbsI0=;
        b=AlJu6pNpKyKNiFcByVeZjakXQD+4aGcWkzdOs2rmcSUzxsbrJ6ZnYFuzCE7vBiGKfd
         Fc5WPnN8Wcp/nEbs86HYw2LfBNMjsWlrDLCau6zW2dLQxzQGPNdXKBk25VvKpzmfKUlF
         5qPb1JJOhAA0InzF7J8FUGo+twjP04SVJxR5Re3/cgFtLM60G6yzcCJc8HahJ7wYvVOD
         cGdANzKqkrRXNS7RL8i1njZ5YL2CxBSpKj3MbzdkMeo6irvEARd+u47zE3oxFN7pQa0w
         1jY9xCSmZsdn5BFV2AY0S+KV/wbChfLOToY6zVAgT/1gLrDTzmciHruxA1y+cA+hsfKz
         42vQ==
X-Forwarded-Encrypted: i=1; AHgh+RriO8ULp+eKXeFFFntGvmaeTaVw1ICoxFMptpLqeFxRvccdGZfMTyz4lTshmUmPl3rg3XtNi8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIsT9G9in+wpmYdlE/g7fQhvO6KdHzeLs8qCUvfjoOOUvCUJg
	+9EVjnWIassYHcHvWUUviFpY5v5cXAdG+8ZZuXFzOzn6XIyxRjmcgbjVhmh6vYAk4or5PtNfkAQ
	c7ptq96omTFup+OMbQfBlfhdqZMoBJBrePmo03sIvyHBYqu3b22rcvaS6UXT/+A==
X-Gm-Gg: AfdE7cnIiQVuUatWuutc1VyOno6U5hcD5J3vNDqUR4ICUH/jxa5byLEtj3VzxkRGzjC
	wNSH0sXwcgE9Bm2bfjj0RBE38LVuBrrFklyIzreSbCFmEf67ZzsX39tyMgVaHNHO2wFJbSQNYee
	vrdd9Kn5SgCqfzuGX6scV6MiIeYIRYDCXxYEJITD1Tv9VNTYLme6REV2ZVi6d1NDlT/ivT6HKwL
	xcxR4c04srISOc11lBZuMjNWgdyvSuM4/3xaBIOAaCAfhC+CFLcmmlQ2hl+rE7bW7KUNHvLseB9
	Rslyj1vdtMwvs8ACRh8Hcyd99/e4S1hho5sBvPkK4GmbPauivrnGkFqnXCM=
X-Received: by 2002:a05:6402:1a3a:b0:69a:f1cf:4849 with SMTP id
 4fb4d7f45d1cf-69c5f6b1c4bmr1233a12.2.1783704192940; Fri, 10 Jul 2026 10:23:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211906.3322883-1-hramamurthy@google.com> <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
In-Reply-To: <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
From: Eddie Phillips <eddiephillips@google.com>
Date: Fri, 10 Jul 2026 10:23:00 -0700
X-Gm-Features: AUfX_mwKgbiS2RO1DKhBggA5wOG5do90vw8bXFAZKZrEMlciIvxhmOXrVksnsC8
Message-ID: <CAPBb8HkwGTC_A1RVVHUVmtbhUxfUXn5VNYxdD-RTsSkN=dHi6g@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, jordanrhee@google.com, netdev@vger.kernel.org, 
	nktgrg@google.com, maolson@google.com, thostet@google.com, csully@google.com, 
	bcf@google.com, maciej.fijalkowski@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:24=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
>
> > @@ -400,6 +414,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *r=
x)
> >       }
> >
> >       rx->fill_cnt +=3D num_posted;
> > +
> > +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
> > +      * visible to the hardware, the hardware is in danger of starving
> > +      * and cannot trigger interrupts.
> > +      *
> > +      * We use a threshold of 32 because a single maximum-sized RSC
> > +      * packet can consume up to 19 descriptors in the Rx path. Lower
> > +      * thresholds (e.g., 8 or 16) would be unsafe as they could cause
> > +      * the device to drop/stall on a maximum-sized RSC packet.
> > +      *
> > +      * Start the timer to periodically reschedule NAPI and recover.
> > +      */
> > +     num_bufs_avail_to_hw =3D
> > +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
> > +              bufq->head) & bufq->mask;
> > +
> > +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
>
> nice bit-arith tricks, but perhaps a simpler condiion like:
>         if (num_avail_slots + num_posted < GVE_RX_BUF_THRESH_DQO)
> would be sufficient?
>

Descriptors are only committed to the hardware in batches matching the
doorbell notification stride. Masking is necessary because `num_avail_slots
+ num_posted` falsely includes buffers that are written to the ring but not=
 yet
doorbelled. We don't want the driver to overestimate the hardware's active
buffer count, fail to arm the watchdog timer, and trigger a silent rx deadl=
ock
under memory pressure.

> > +             mod_timer(&rx->starvation_timer,
> > +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_=
MS));
> > +     }
> >   }
