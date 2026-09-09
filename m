Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07649505A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941209; cv=pass; b=VKUz7LIidb7UFJoAVwqSwrZtSwUOnQFOX2lq63R07LRwpYL/h8Rq6Wwf4oFG1diGWVl7oURPzUrxU/bmuulQ3L+mmIGDabHanoOqGs7f0yAl/2kcyKXYP8VooQpGnkqZxhH21FvBvTAPGRAU0ENhpygRhWHgR2SK+hLZXo+JReU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941209; c=relaxed/simple;
	bh=jccdgTKoA1IteJFwmLOO4A5mlgna+9dFOZN51O/IvCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiPHjKn1ASKVZ1f1WGlL4pfoIVCfzqsPla1TmhlILzGEjAA0nLkaA7mXCaoqOKi/2s3EdMtvPF+Y3FlrFC3fUG1RNMwk3JmpJdvsp9ys54p3/uxp+nMiSx2KagfXUUy1d0+efTflYDUwO20+VlLVZ//dWWr9VQblfwVXj9/zWuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLfVhODn; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLfVhODn"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so64405ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788941207; cv=none;
        d=google.com; s=arc-20260327;
        b=mrB+Zfj3KA3fboYQidFsqMRuXpX5kNauFQup1dCGTDUFy6D8+OrzXp14lro0lZSX8q
         Hm4RmwIYl4hQjXuIcWx+eCYjAXud4//AstjJursmvKtHZ+4i09tlylmjK3fwypTxytcH
         wrfEXci1hu7+ZzxRpJBjYGcGh9osv1jECOXgql8/eJAODcIh0DQinlxURkz9A0+/AXI5
         bNh/T6sYwEDehqDoolG31xRXKInPR3w4DAzn4XlhPnV887HJVomNmlcy0YfX7h9aQ8ef
         FmWcRH81bcjPrgXgeVMjiPRj3ZwdEUTnCm8o8mUdgQ8DEyljgaCvblU5xkZh2Y2mxzRj
         y2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        fh=hUN7Z6uytbb7KwCQOKspRzl8ONitGMbfhKbZCBlMycM=;
        b=btJqUjOcRNwh4GqOBUCzbhU5ThMIt8eT0r89QVYex9yMlMPR29GoHXin1cOxk8kbbJ
         pM4gKK2ZDTt7N/l8ZghiQZs3YMKbKgkVHI9Wcpk3M/C3JU7yGXS4RcBJnLpLy9MCuNJp
         JAe74MnnRhnhLSlYlRm4SSOmkwg8Hsb8c7gkzpDGM/iQCHi6PHItTLcYOCBCHXPqxeQN
         tr/9jjdn/62CTqbp66C8a5p76sUyYy+LY7jJROdvCO13ZrAIvkYyhqMEKmdSapu2FINQ
         rXwpxHpPKZp3zkyphjQoLr3GHnvy/h/BilTnktuaQ9ZgN4WyfFBfJY83+xjmLY+Uw2hx
         pm5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788941207; x=1789546007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=nLfVhODnCewsw683wfqdRs3QFOa9A7Fo9Xq7tnXPQg4zv1U7SWdx2/brrB12nXfA3W
         gSQW56ByLyLmKop0tdSRbSxsZsareM/xrgLBxHdtCLFkrGr/+LZrKcnicZCwFPs14gsu
         swB+qMuFgABEmplZulTR3lmOC4ag6GEV7kWepKC4ABJWkcNxMnW8dz2gSyMsLcnpqTDN
         aCYT2hre0vGl21hOyYufoV5QONPypEW7Oz37qlYfBbePFtX8tktBXVadyQYJP4IAJc26
         u0EPrgbpRVE2UDgm8piU+kmdgCWoSBudUiwAMzRleCwa+bbQ20CbGH5EWvjMi9pI/hAB
         PtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941207; x=1789546007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5a67p9bBINgQ7LBbBcS4dRSdhOilWoAw3aEd1cEzKg=;
        b=UFouz1DLQLQSilLwfUVRy+HNKQBjJamz8B4jl6aBPTDsPjpXAO9DbuVL8AGdMmDLsN
         QESmxLh1vtwjaQjxH8wi5TzNGo8gJwyuJiDH0pqLrypXfQLaUToRZBOTCQya5Zi9+iQh
         DSLlJMzR1vCos5fpfdjdCjqBZjTs/f0KvvY8/y8X0qbzpeBej2s/sRzJyKYovfYJk1oE
         RyBMak6RZ8C7tTwFglBTxPgZOocEAlJRjzvdYNYHW2mjsA44BvjmqjyUgGP02zyC0gRe
         O9HqMiR/QISj6uLPv3RhBa/UnMbp3oxhUJr+sXYoMwww2DGWTT2/TLc7NmE01r4nJChF
         aITQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcWkUS7+D96b59oFgVhoFSkfMfax8AEGj1QPDNNcmIbGbuMj5YzOJm19VMqzLJwm2pic4p6Gk=@vger.kernel.org
X-Gm-Message-State: AFuF++njccirZfPkOSjcnszlQGz+dq5nb0/exeuztFJ1GuKKWBm+KXiX
	vZpkF79U37pEmo7cy7OerU7iGJH+kv0M5BLCz2QtVi+MrpCxtnR+5exFepwKjjU1gT25RyhSAPo
	eL//qnV3fQE+zIBRWhUdo98jcIvYumv29hCNdiGBT
X-Gm-Gg: AYBFou2JGJOUuZFLwXvYULkxJ/5g3+KLcEi5Pyasr0f29rPH0IoLn9fCPufvVOLhIEW
	XpWPqKsH53ObV7nr3RkwPFjjpPm4ivSWORL86Hzkq7NwonzRgSqfgZmc2Z+2MapkxmuEMxlnCnT
	R2Wbq2UbO7WVpgZNOz7BG8RgZDY+XvF3ANdI6moSokPst5WPlRngb90Prby9Bg+O+zNXAPLjT/Y
	X/E0nB3TY45QTNIOOO48sCXpBdVeAPEv0iWprZf71cZPJKA5pZnqlpA0sZ+q379+nSQ3Dzm11Rp
	5a7PZHC5CI3JBBiYDsUIa3lRpBBs5+09N6L3Ls5Y4BAglqilrHO2T3vi9w==
X-Received: by 2002:a17:902:d988:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2dbddb1f4f4mr5306795ad.4.1788941206507; Wed, 09 Sep 2026
 01:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org>
In-Reply-To: <aqD7FDvDhiEF_u0N@infradead.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 9 Sep 2026 10:06:10 +0200
X-Gm-Features: AcwNN1VkP_hnkhu1BhimxJBNF_bxxxh-Y07PAXa53bzMuSECve8p-f-Z8Pr0vg8
Message-ID: <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Fengnan Chang <changfengnan@bytedance.com>, 
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Guzebing <guzebing@bytedance.com>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
> > > it appears that GSIM is only effective in scenarios where multi disks=
 at very high
> > > IOPS; in some cases, there was a noticeable performance regression.
> > > If there=E2=80=99s something wrong with my configuration, please corr=
ect me.
> >
> > So we have a NVME specific mechanism to tackle the same problem and a
> > more generic version which is subsystem "independent".
>
> I'm not sure they tackle the entirely same problem, although they are
> very related.

There is overlap but it is accidental.
The difference between the two mechanism is the following:

- GSIM addresses hardware limitations (SoCs that create huge PCIe
  backpressure on each MSIx interrupt, eventually reducing the available
  bandwidth too much, regardless of how many CPUs can process interrupts).
  The goal here is to throttle the total MSIx rate, blocking them at
  the source (PCIe device) rather than later in the interrupt controller.

- the NVME mechanism (and NAPI) aim to amortize interrupt processing
  overhead. It does so by recreating some fine grained single-source
  interrupt moderation (something that NICs do in hardware, but NVME
  does not, with 100us being way too coarse for modern SSDs) and an
  adaptive scheme to adjust the delay and decide when to kick in.

I think there is a reason for both.

GSIM because it is more general and addresses an issue the others cannot ha=
ndle
the subsystem-specific scheme because they can be more efficient
(eg they can hook into existing helpers like the threaded irq handler,
call directly the handler without going through the full irq chain,
use more targeted heuristics to decide when to kick in).

cheers
luigi
