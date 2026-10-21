Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608000;
	b=RQ3tOV6NBFDtCPfdHRIGLX0lp0tx8aEnMr39WdQgL6zpo7L4tlpSwEUL/Ows+Oxmb58p
	 hCuoY+e6vtMeaHzpJkZv4yxnqe6TwlcKI9uqxmnz3w2GeRa2iZbu1JoihKpugf9aUciCr
	 fQPOqK2aFxj/L5BUVrnPqjrhRi8diCevyJOb9brCsicRp1jscf88DX91qadWwclFql/TF
	 W31CzViHFRlI2IxcYy8/NavStyIoJQLo01APcX41oA/JadFAhPRjN24Ic+STivY0/MX8C
	 9q7qpENfbyufQnTEIxUMCJ32dwXWFbNRGk6KaWVqOTpAaWeWf7KIDdcRyrCcKz3xOAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
	b=z9uV2SFwCVLmeas7oaLKnktni6m6HCIVcUySYDv5x4LqJnLLdhd5ZBIqcLer82RPSaDl
	 hYUBw0EpNf82DxEYpvUYVZl8YdkUaB00u5PNDP9SpGXPqefKZxMfzcovpVIwCrVf5Ybym
	 r8Bvs8iW6nNsIuu37oclTskMfO+AdO8bRI2bSceRSPyfK+S9wm9UNq7n60JXdysfq7q04
	 fOVVNzbnG1OIxkhktnGkuJaxfQbMOsxc9Ux7Qj6FBh0QVw+FGfEXyqhutI5TWLvIfHBa4
	 qRtPk3N8gGUwieA4olPjEo304V+syjwgVECXN6/1ygbf2DTbyv2IL08XEb62m3Z2t2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="D1i/BJq9";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6C606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1i/BJq9
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48bbb06e746so651908f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607997; x=1793212797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
        b=D1i/BJq9eVs8XTcuhNqhkUYYw8TrAvsxkc9Ut9kiL6tbt0z5RB940/ahJed2a0/ZCc
         yF0oL3uN6pWw1lKve4dSejB2JxLl1/QzCYGZNDf4aMc9rPit+a1kn0IK6eg2IL0foh64
         u0fuONvYxKsrOO3Vxw8IiNzdBR/qmPQUXP29NN2IT1i0EObFTwOqkS2IJpvkLdmdUyPb
         vuk6y4jSgLjCEymCqAzmvfkOfD5BMnKf/Ura/Aav9bNR8L+wAOigT/HMXHIO4GM3klfH
         LzKp8O+BPHkxuLTP00Z4fPrBD8XtGxB3FNS/ML7ASlVbLin806NRRLngIsM3ETOxqKtj
         oMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607997; x=1793212797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
        b=Ce2T9YFDayC0tpSgqSboZJu4/iv6F4sUnQ2zinqcstT3q3tpn7pTN9a9zRVUmbmQ6w
         ABj/aVl0/2Q6Pux48GzQXuJgwhW/zQKVN2W+6ibQD9Agjpoa48Rp+M+YQd1fwYVGfWLW
         jcRWW970Bftd8jD5o3xFun7YDDqmH1mjIjUx3B5yTrUD0sloqfuTWwZxJsviKbif4AFO
         GpBYPcPl5t63hMfhZG+MEC6S/SV7tV4fhqPrlJSmT5rRLFdpyJVukjfGNICnkmKxaec1
         qHrY2XA1Zh1vW8GEL+ICBak8X2LtGILcFbMkrhLRW0vA1GZ9zugYFUS5N0DO+sIqlR3Q
         QcfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz78ESRJ6qPgBaIVQyerM6zAnt5SmSeABF3gVqkQL2GTaaWiLYn/MRqrMdlYj9XLyN9m1wGIL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWtZA+4tsqdjDzGbeoFK8YB1JeaPgEqWHHI1C4b/v0RXbig1+R
	CXHM+RtrKV5QDMvzvZYxFCUaEzN21KKEvOtAx5DZrkywzkBiukk+0c6uU4VOXYWVi38=
X-Gm-Gg: AYBFou3GcEcxsiisnkgox0MwtEIT5PTp2N816Em/UZkcYzSxTUUCNNYEQZhz1Rqbluy
	FwptFWl88ay4/lnATelXrOVmhsZUaYzjjoojn9HF137P6fsxn7p0RtPQak0v+Qtp0MEAtuy+5F7
	2AMAjIFUbzhaeKrDYRg5BBjPi8zS7U1isGtebMWCgLJCH0Vosj4zxaBGr3svJUz1+W6z6xaxfWU
	LGsCkKVj7YZzD6Nw/Ot6lJAWhJ3HeSODI1kCngIaUd9xb/6S9U/dXefmUArW28wtHU4fecy3eKU
	MOfPMgic5kNg3ac71TSg8FajsjDFGpz6shtGwxl+5W/H13P0lOEF7FYHiJ1W2+vkGeyGhWahHz3
	FYu145s1EfjvFifpOTtbloz5lcWA6VhVEi/8SoLt2TIReT2mptor1Dg7CbAZmZ1awBFvQQWtZ3n
	FCOks2dRHIDk9SeaprEjCJ3nh4+YjJ5PwxobJqRuFOynYpWN35rgibTUuxrwzcAvvUTo5fN4ttO
	ZlrcT2ilx4VCTSqEAonN96DgM5K+bUxl8WRTlMYY5LoLXTVRpHR1Ak+OyE7HYVB3FxK8wm5oM0Y
	QBqwW+yhV2vp0DYMDOJVXTIHBVuVO/R1ftBqW0A=
X-Received: by 2002:a05:600c:8b4c:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a1fdd15484mr62637735e9.18.1792607997368;
        Wed, 21 Oct 2026 11:39:57 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a447c8sm10641255e9.12.2026.10.21.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:39:56 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:39:55 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
Message-ID: <atkG-5eqB8LfVxSa@gmail.com>
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
 <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>

On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 20, 2026 at 8:59 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > The motivation is to plumb more of the socket API into ksock, thus
> > supporting sendto() in addition to send() which makes a lot of sense in
> > the context of UDP sockets which are the only type currently supported.
> > This is useful when ksock is used to reply to specific addresses or send
> > to multiple addresses.
> >
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 69 insertions(+), 27 deletions(-)
> >

[...]

> >
> > -       return ret;
> > +/**
> > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remote address.
> > + * @ks:                The BPF kernel socket context. Must be an acquired reference.
> > + * @data:      Pointer to the data to send.
> > + * @data__sz:  Size of the data to send.
> > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL to use
> > + *                the connected destination.
> > + * @addr__sz:  Size of the address union, ignored when the address is NULL.
> > + *
> > + * Sends data to the specified address, or to the connected destination when
> > + * the address is NULL, best-effort and nonblocking. This may sleep
> > + * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
> > + *
> > + * Return: Number of bytes sent on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
> 
> This would limit API to fixed-sized data only. Have you considered
> passing dynptr as a source of data, so you can send a wider variety of
> data? I don't have a strong opinion whether we should add a separate
> API or convert this one into dynptr, but I do think that having
> ability to work with variable-sized data is super useful and should be
> added early on.

Oh wow this is really cool that you send this now. I was working this
afternoon on trying to see if a ksock sendmsg() would make sense, but
with these static buffer limitations as arguments, it actually didn't.
I'm not familiar with dynptr so I didn't think about it, but after a
quick check it looks like it would be a good match with the ksock API!

As I understand, since bpf_ksock_send() is already part of 7.3, it's
best to not touch it, and having a simple send() available with a
fixed-size data might make sense.

But since bpf_ksock_sendto() was just merged, we could make it evolve to
use dynptr perhaps? How much time do we have for something which was
merged yesterday to be part of a release? Is it going to be send with
the 7.4 pull soon?

> 
> > +                                const union bpf_ksock_addr *addr__nullable,
> > +                                u32 addr__sz)
> > +{
> > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz);
> >  }
> >
> >  __bpf_kfunc_end_defs();
> > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
> >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> >
> >  #ifdef CONFIG_BPF_LSM
> > --
> > 2.43.0
> >
