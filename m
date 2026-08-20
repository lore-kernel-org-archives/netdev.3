Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818C314B77
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211338; cv=pass; b=LqTyNIb0Sgdmbh8OMgF+253kJt0oAXeWdX8ChL0gI9uFcotoX6BS0qNrra9BAuBwuvSGT4vsS8KrS9Smy4reA6uMybClYZXcePOGNYHKAZxceO88MSYkqYcpWBRKZMz/SVdGwmJdd0jZ3E2CNhzUDqK8zggymLUWboK2hLfpcYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211338; c=relaxed/simple;
	bh=Btp/m/YCZ68myP8qI0K25HcafOb5YLT6x2u0sT5dK30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0CEqLps7QXuztdpqYTcf89G1ptlkXlEQYbFMpkB4rf7w/0pzzWeZlZlcMfsYnUOBaYjVrL8dcXsEvkm3sv12ULIYuB609kfFbJoioSh31pilo7ZjmPf0PoZA0zKDkXgo/+uts8g3O/1a+9PGHDpUt3kZwSanKjHpQWdn4jBurM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uo308GF+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uo308GF+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso44125ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211336; cv=none;
        d=google.com; s=arc-20260327;
        b=g149iuAJ73s0ZwxM6LaVU+YzuU5jiZf4POfRmO6aFZZZaRgs8vcXT3vwexswcWzAPa
         nP/ve1dlQkQxtVKSssMyw+D/v8ZO9ezzgRCx7klt3XuYZDQ1iuIh8yyM+0P83fRtNdy6
         rEsqkYrhUBUko8zIDe3H4ki612fbe6wybIt+E1VWDGf2xpSR9cZmZ7hNlHiicBQ34e2m
         uRYLmBXux/HRpSyQ2Ake7wJ65r8h25KApv/O28GYFX3rwrMMPX9Qhv7uOwUSo3sGbg3G
         Jp/yvELrPw0tCGZHbeyV0m1dJ0FchRxKyDC7zf+/gbkduTSQR71y+wjAbRyAkUyrdKl0
         TIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        fh=x/iZuf6kn/nYw1O5jGs32BeAKIEqA5sbTIETo1GagIM=;
        b=TrpyeIRHulv+ii5q9zSbXIRU7oZgOdH2j3W51FuATw3vrDKnHvKnlxYGDxJ3RHVzpn
         Rdu3rufwYi4gEmXxdTasCUovONp7HJy3TEJoKojdGvT8dxQGaRvec8vuubZaG0WkbsxY
         3Yf4nli3GGj56Ot6oX3cJXyxa4+5CqLFj+B/q4xlUb1HkQT7PrixqPGM+vJXJgm1bGRl
         0/YU+P5XBG6+RGwRWYStqZ5EMg2SMID3VZYZXJt59cW2mbis38w2ldyaqyIsL7fEjZSR
         zqH0EPXIwythIQ5nZ9cGPWCVoQxSE+2XyOFnQfBoH1oRFxEcVk324+ZILtqhPxqBPrim
         6vZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787211336; x=1787816136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=uo308GF++4r1gGc04LpNRnSDkI8NJfWlwWN11DSXqIX17SnB8x0HNjHYwszIzKJdmw
         HjdWHPU3B4+JLXSMnTBtYfPKDkkw7O1TgGbCViKtsBsW/aeFOcdqdBPqVPp217q/H1Qr
         EY+ga6HPxWsKZy389lA9/KPQRjKbGwy6scbANK/to+iI5BwIGdiGAOrZ4XVsMRLEuCsS
         b/Q/D9q8uTcgGbAzAKVA52iN1Mgh7iv1Pi5hAG00rWDGnTQfF/79asoLYlW1ggHFcJfH
         ejQY57bLz5ZKsEWuAsGUoH8osCK40eFfKHcLT7wmc7H5rj57hNMfW5/3un2OkXvcqgt/
         d5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211336; x=1787816136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0D9OImnE1uHUsNiu3Pu4ZFSdM4f7iPTa/B6nclfiM+Y=;
        b=N4JJdJNDxud4ue0HYgebsNH7ifcZxKm4vlY1Z+qs8rOqAJRaGdQW9BhOJJZITeJP6x
         ehirl6zrJ8us2H6z8HPQ6vJui4uLo4wc0ttPSTU6b8huPAYEbroy52xcAKi6R1ib9fuG
         Dc0EdqxOCZLCcd9NYdJHE0spBgovvP6luYCHom8xlXtc+9uuL3gXq+F6l3b7E8aMwfe3
         1w8CQGAQe5ZFlMCLV+1QNN2JsjRnDmL8xJHPlgg1AAZ8qqeaQm65ELNaNvwvlkPZxvPX
         OP/8SeF6AC25VNtajABLWh6q3OtWggSay89ZRXft+zY0mDtblu6ljteTs6GA63hmEXH8
         8hiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMv85R1OL/wJwvNwQQf5La7c9/a0l7ps0LLUq4cnJM7nUzbZNo2Gol6MMY1EUqx9fA6DaXoFk=@vger.kernel.org
X-Gm-Message-State: AFuF++mHSWBNUhmil6B9dz8Pg6n/OofeFABvwbraXjpsGHRVf9kCHquJ
	Ahys0ttQLxb2mf1eEyTtphRk5KJ/11BSq5BCpUBgJ1B6cRfzdaIM2aFhXMh1z2a0wpcsXUv7i6w
	y2HmzFYXDkX8UvMMgoBjGpukcVckBjPzZR5cToC+j
X-Gm-Gg: AR+sD10XCswzw4DnOPCtArNsZPX49cvcCBquLtXqXowdQcGRdJTcEOEjMBb3NHkplYi
	3sQCcnWd9ZnFebNDKdvSytFzbfMkeRIdVCX5UyzcnIGvxHxP83nSr1AAEdUr2P3CkLBnPI+VC+l
	gmFns/WgfLz346fXMZjf2S/sMBcVoKICZi6Eklc/NH/hWDN5uyVe70LQXVhaEttH3Ho4/k2rLug
	+Y5UcNOrJBYfwz0wYMr6j+HwaXs4R/1pQfwugdKLxHva3HZCdZzY0Z3HPc8MDmsyatHxcvQqQSu
	njzjsuzdqrPHsQLXQ/FBw0oUnVqIK+XF4+tq+h9NVe79dg==
X-Received: by 2002:a17:903:26c4:b0:2d5:db3d:1a43 with SMTP id
 d9443c01a7336-2d61eaf2a00mr5392465ad.16.1787211335900; Thu, 20 Aug 2026
 00:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com> <aoaoERD5m1MNvMWd@infradead.org>
In-Reply-To: <aoaoERD5m1MNvMWd@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 20 Aug 2026 09:34:59 +0200
X-Gm-Features: AcwNN1UEas5zzKqBrgfMq8L346ulYCSqqrdVmLWHWX-HHf-jbZz6J4McJCDiFEU
Message-ID: <CAMOZA0JrLia8NU1-4JEJAe+p65C19HsRGU6VK7sLAjNFKm8G3w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 9:09=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 12:43:34PM +0000, Luigi Rizzo wrote:
> > Configuration is easy and robust. System administrators specify the
> > maximum targets (moderation delay; interrupt rate; percentage of time
> > spent in hardirq), and which interrupt sources should be moderated.
> > Independent per-CPU control loops adjust actual delays to try and keep
> > metrics within the targets.
>
> Can we find a way to autodetect and autoenable this?  A magic go faster
> mode that needs very specific tuning is annoying compare to sensible
> defaults.

As mentioned later, the tunings do not need to be specific,
because the control loop adjusts the delay to stay within the target,
and the target is generally just a "don't overload me" value with little
impact on performance.

Of course there are many cases (eg small systems with little I/O) where
moderation is not needed at all so at least one bit of user input is necess=
ary.

What I normally do is use another small patch to pass the initial settings =
via
module parameters, using values similar to those below
(enable on all interrupts, delay_us=3D100, target_intr_rate=3D1000000,
hardirq_percent=3D70)

> Also how does this interact with adaptive polling code inside drivers
> like NAPI or the upcoming nvme variant?

GSIM acts at hardirq level (so below NAPI, and above device moderation e.g.
the one in ethtool -C ...) and is completely orthogonal to those other
mechanisms.

If NAPI etc manage to keep the interrupt rate/load below the targets,
then the adaptive controller in GSIM ends up using zero additional delay.
Otherwise, it gently adjusts the moderation delay so the combination suffic=
es
to stay within the target.

All the above assumes the parameters are sensible.
GSIM or any HW moderation allows up to 1/delay_us interrupts per second, so
setting delay_us=3D10 allows up to 100Kintr/s per CPU handling interrupts,
so there is no way we can throttle interrupts below 100K/s)

>
> >
> > The system is adaptive. Moderation affects only latency and only in
> > high load scenarios.  Throughput and CPU efficiencly generally benefits
> > significantly.  Targets don't need to match precisely the platform
> > limits, and one can make conservative and robust choices. Values like
> > delay_us=3D100, target_intr_rate=3D1000000, hardirq_percent=3D70 are a =
very
> > good starting point.

cheers
luigi
