Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E9392C4B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243913; cv=none; b=H3WOHT6354lbF7/OWMuJtwR6kRFiNHlVv6rtcJD2vyfIr4ao4YbFkdI61DGBGVk8jl1R2qVXAq/cS7Q0zXGBGSM2NFYESHMcPuNC+X0xxEExYA4iwrbKQbhBxGzLpY1yPmUN3Lj9XfW3RumKRpPuQlIU77Nd9mpElFP8oMXGECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243913; c=relaxed/simple;
	bh=w0LYy/lkhOkRJ1mcPpKcBJQ8WkRX9RNPOn4dmhRbI5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QfwLrnnZhMvSH2K9wNt5CAz5058Gy2hzecw9sdh58Z62a/UoGEe0baQXH3hCuNzdJXXZdhLbb/QyCzkarWOKql9vv0lreU3rPwOlUPBsFDihWPgDy20RAh0aD2ftR1VHq7pdHhAg54CdTORW2tXMIWcNSQYKzLgkKm6EvkdM/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2wWzv3B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjIEQNPU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2wWzv3B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjIEQNPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782243911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
	b=H2wWzv3BZv/A/oZrzte7WS60CbbQ0STE4rNJq92LG2JjrFwkcOP5mx9aHfyfDtCySw3KWB
	tg8MMNe+EUUphNNkqwDHT5SI+kwrqJKeo9S2uuyLSZG9B4ug0yfpeSimNgQmZoG0x6RwCd
	Bz1V9H//fsgu/f9T3Ny+d4MduFLvZTE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-QDByUduXMhGRZiryG1bTIQ-1; Tue, 23 Jun 2026 15:45:10 -0400
X-MC-Unique: QDByUduXMhGRZiryG1bTIQ-1
X-Mimecast-MFC-AGG-ID: QDByUduXMhGRZiryG1bTIQ_1782243909
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bf4ba05fd18so17797866b.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782243909; x=1782848709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
        b=UjIEQNPUMkiH4TwPruAPCW4v81RyCjUhxAdBRCU+jiFaYQF1MeZZ3WmGmIj6y31dr0
         APSrj9pIqpIbIw3X4K8OTRWQkhWkRYA8aiE3EKhyHGI94q+NW/FHXJ9R3hBlzk8/MY0/
         Ixyhtob4WtIM1AWkGnuB/prI2d0K2nyys1scIlrmjbTZvFHib5UzPigw/BJjIv4ECqpA
         +hlmX853OkyiNu9LIQvkn42vOmYCWgvkQ3Oyo/rfoRjhVAfq+NnP3NJL438AmCToBKRd
         s04v0/sfyvGj6kghTpRdKXd3UCiMhh7qg8wttzZ5cL+wt99cX+PiusDPVfYKOzrP1CUX
         /3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243909; x=1782848709;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
        b=Q9PLilq3GcUdx7AVj9L65HvLDGY972onWjyvlTmOgz5aSL3gUUvTjwG5H0m0WYA9uZ
         W9kaSMBRldH7sVfOcCNgWTLu6R5kokdK2vlM1x3JsVYOOzaIPfm+jlX5SHU/rzN+44Kg
         R6BhRNlTdE0p1M87m3vhVEk486Qi6RbM1GOu3reLrdultSvZK7LesyMfQPF0F3UgtrQU
         xeOVVrfDiXLfaXL4G9fDk198gpYuVbS6oV6X2Zepu2wAFYmPhpkTdk88SKX26NXV/fUb
         f9uF6zGC48DEOi6q6ydcp8Kf8R26Us7yr7j1fQbcPOaSO236XN4QeCkobW24sNqR4QEQ
         G4dg==
X-Forwarded-Encrypted: i=1; AFNElJ/F7y4Qj8lUdZdyeR9CIYGEp/QwElKhkVy/X4kAXkinp6omBqKjCtBp945UpcHzDeAzAhyWsNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uNNeFwBqpC7w77xm8qe/gjJFyDtu8POrNkIvNYnLVkyZxNJw
	5bzL16FZjXDg36JbbHVG20mcelvGGRN7ZRFB7f+9QeDOSuKgX8SFos+EMiIOWgzzF3uVCXY6+Bi
	AFtQEZJ5tAgXRIZwnvtS6XXDnvPI8TShTBnS6TwJNHvIEa1GPBIHW6mc8mA==
X-Gm-Gg: AfdE7cnXVI5H7a+ud14d+AsFqwYGvqP4iVIAgWoVDIp4M3n4f/fFm+zRMdxbvMAt9Q7
	Zb+WP4Jc+Fo518WCQ/F7ov4JJjurvLZjngN4UboFn1tXA/O1gc1OSYuILJYHf4qNpABsKXMlrxp
	ngIaDwUMhoAyz0FcqVVZQhHmM0DRvH4bE5S9GliDldodjU/orljsM8YwxO7MB5AsWJLHGPhYks1
	exe4M1gxNfPo/hNyhN0Wj8/VBh3PpUmoC88VOY9oYE5ghjTUlPZj5WE+ThgiwE9xa8p3+VxFyWK
	vK4aAQbW7qzgrPLqU/zb+SkICTe7FtKEQe6JwgY7VNGpDyiJ/mb+zIYWMr3Ap7n2aBN8Z5wx3U3
	cjvQMSLx2/SoQl1bssQKn6l94fkHPegGiSJBHWw==
X-Received: by 2002:a17:906:99c2:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-c107e0dffb5mr233288466b.17.1782243908592;
        Tue, 23 Jun 2026 12:45:08 -0700 (PDT)
X-Received: by 2002:a17:906:99c2:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-c107e0dffb5mr233285566b.17.1782243908159;
        Tue, 23 Jun 2026 12:45:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e4c76sm563520866b.46.2026.06.23.12.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:45:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 25089808D82; Tue, 23 Jun 2026 21:45:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260623182849.2623521-1-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
 <20260623025147.1001664-2-avinash.duduskar@gmail.com>
 <877bnpeaeq.fsf@toke.dk>
 <20260623182849.2623521-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 21:45:06 +0200
Message-ID: <87y0g5ca7x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> I think it's better to just move the assignment of params->ifindex
>> entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
>> That way this can be simplified to:
>>
>> 	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
>> 	if (!err && fwd_dev)
>> 		*fwd_dev =3D dev;
>> 	return err;
>
> The caller-side restore is ungainly, agreed, but the assignment can't move
> all the way into the helper. The early params->ifindex =3D dev->ifindex
> sits above the neighbour lookup on purpose: that is d1c362e1dd68a
> ("bpf: Always return target ifindex in bpf_fib_lookup"), which took it
> out of bpf_fib_set_fwd_params() and put it there so a program still
> gets the target ifindex on the BPF_FIB_LKUP_RET_NO_NEIGH path and can
> bpf_redirect_neigh() on it. bpf_fib_set_fwd_params() is called only at
> the set_fwd_params label, below the NO_NEIGH return (and below the IPv6
> NO_SRC_ADDR return), so an assignment living in the helper never runs
> on those paths and params->ifindex falls back to the input. That would
> change the reported ifindex for plain bpf_fib_lookup() callers hitting
> NO_NEIGH, not only the VLAN ones.

Right. Well, seems I forgot about that patch, even though I seem to have
written it :)

> I can still get the caller down to your form by keeping the early write
> and moving just the VLAN_FAILURE rewind into the helper, with one extra
> parameter, the input ifindex saved before the egress write:
>
> 	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
> 	if (!err && fwd_dev)
> 		*fwd_dev =3D dev;
> 	return err;
>
> and the helper owning the rewind in the unreducible branch:
>
> 	} else {
> 		params->ifindex =3D in_ifindex;
> 		return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> 	}

OK, if we do need to restore it, I think it's better to do it there.

Also, wrt the fwd_dev parameter: Do we really have a use case from using
this from TC? In TC you can just redirect to the VLAN device; this is
meant for XDP which can't do that. So how about we just reject the flag
on the TC side, and get rid of the fwd_dev parameter entirely?

If we do that we're back to just a plain 'return bpf_fib_set_fwd_params()' =
:)

-Toke

