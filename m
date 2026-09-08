Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B234ACC75
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857852; cv=pass; b=lW5JKp4Pz7/xqzG887u8J4Vm4WQzPUqYpt4Lxyb4K4Y45xjRU7gw96TyXPCuKtuOqExiAm8RQkyKvd+BEhBVsVc9x3ttqYOjZMPJicvo9SBTbmhTXCLR06dUbtXfRUXbTNRA/WlLOf2p+rWwmKSou/tC0K793If5UUgiRxNBLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857852; c=relaxed/simple;
	bh=MgYKEgJtez/YYmi9pH3bcdokcDtSyver5mTlkHmA9zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4uk80FV0D2Z+/gd+hbxU+PbFf2t8MMl8JF/MxZW3v+jH0TbyiOxGKIMK2EV5NrnmNFQWuLTq3S7JthNJuOYbPzXsZv765bUG5WbP36bLQ8ujVCbUsA6tXYFSfC1d1o8fraV2LQbof2BJY8X8OOJfa54t/ev9A7VBFX7AYXO9HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfVT035U; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfVT035U"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53031a57d7fso46599711cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 01:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788857840; cv=none;
        d=google.com; s=arc-20260327;
        b=TqvFm+0ysu9W+aCSNQMpPh0vu9wqxUVn6ZeI3+hHh5SrfoK8npxyb5lrHWc8+S21p3
         CKDwCGRQZISop83RjbksXos9XCHPZsHnolBLxC4MIfXrXMaxgOOKzHaQtV01ppte4qle
         DfhCQcXK/ai+drN6583oyQXF5kxo6OdvMrgN1eWuMmv3vLQN7B/kuGEHcYik/ZBCkx14
         00yra+OtrrRhIlBnErTPOD1HnzE2Op8vjHxlCrluQRuTmbdBWYrL1m5XQm2q4x8BHkuM
         Glb75eZzwIXbaNcgSoyCbfZvyp5R6N2P3THG2pw6EqWYWGlVlSMxHw9/VvP7MoB9st/I
         k1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MgYKEgJtez/YYmi9pH3bcdokcDtSyver5mTlkHmA9zk=;
        fh=g7VBG//WQGyppJZ9tFdNgLNYaNYVmCOUK+5RdiGp+sg=;
        b=c1LTtHyA4nx7N1gXv6/9ToN0uzWBwkxvWJnoy86ipxJA+H3gee29huAnPFZKabKcMX
         ECYjtsU70msLP46la9VQTGd4fOmI9gZfBeBT/HEOKAz6o0PhYKZNybz8/gJTH2ze52e7
         c20Pi83GpSdx30eo4tPfVm7CkO4KPOg0etlqOK6WYHC4HGnjFRz3sbZbTOU0ofRojb0N
         A8Ky95AUv5tLQm7/7rb+Ae3OI7K+Ib5leoc3b+jlFSeRLGRzq9hbWbKkQbtLo6vPEn4e
         Ckrj20/vb1TmiwCN4dQLHQbbnRL63CitT3Xlj4ZN1CZOuXalnUzIWCB2erRQ1bAYQYaS
         rt/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788857840; x=1789462640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MgYKEgJtez/YYmi9pH3bcdokcDtSyver5mTlkHmA9zk=;
        b=LfVT035UX5xrChhAZyKr7W89jiiXhRigfvTlYCtuEf8xy8v5gaxK1+sic9i8DVE8JK
         aKHdccWE5b8by8JjKFy4tuVnxjHy4OrqIBC/Q0fYPoz3vIxlmMw1k1q0UHYLKsMOesPO
         KoqfPLQA7lONLw5n18mbLNhXTd6T0WGgxoRj9skfcJ0GHN48ayW4G3gQW+oFlNiYw5wz
         7kvt/SD4gFbZMq/PeTvMPky5GQBbEgxP4nUK/u+WvpbM0YCj2E6DoXR+riiFWBX5WbBG
         5qFfX6z8WAg58xmPnqe9NjTuL8H+ZohuMbYjIOLzgAUJOoez+heB789QKU0BdPrIOyfz
         APJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857840; x=1789462640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MgYKEgJtez/YYmi9pH3bcdokcDtSyver5mTlkHmA9zk=;
        b=Sd9t5+FMLJzrC5mLS5G+5RWoxta6+Arwuo3rHHgM1ylPEOF4ezUv0c4bVVVYJuql80
         QXZ9CQjbcm3biG0LlHvDa9XDdArawy/b88hqRMT5L3TCn7MCvIkfEXfhNYxR9PmNAvug
         XCBw/4nd/CK3N6w0yG0XX35cB7r/jaUY7YxOGwTWc60Nnlw5sB5jb/Ew96u5sKQcFjLa
         v7NV+UvgsejYkHKTyyIAy4GsczBxzgNwC0xgTMxGpJSOyfWIAolURo9TWIfQNG21aiyo
         OtozIJ1dMy8FzRM3c3fhHtwwT9yTk+51LgYY1/RYlfpKGniFWkFB8yCsHEGnTUCltgx1
         Fn5w==
X-Forwarded-Encrypted: i=1; AKwUvBzPNoJwcuBIlXDM9IBlOd4SDB7ZBO6bCA6YcX92FCJSw4WbLisGBkmlZsHJ3gn2ISJj9V3SaPk=@vger.kernel.org
X-Gm-Message-State: AFuF++mSo3SqR+jitHJzZQDWaPjR9iTPh7vk015Jws7UqH53UKQA4ZXF
	4f4c+A/AhCGYtfdydO2+bRqiZwl6JVoAn96QCpuykXiy1epsHyozXp2aF7o4Csbl4gHQx7hnlmv
	OlU6JrMn3dkR4A0NuEDTCbWI1rahdGnR8PGj1SIyE
X-Gm-Gg: AYBFou2Dry/nut7GcZC/waLUnmIdCt1KVnY8ElOMEor10o7Y8WgN3Bu+JONvc63m3g8
	HMWYOE3q7DTEpkVBaLp8uytr+mC+QSPVwJUBv1DsibDfyIyr7Y87P3NrBuwa4VmehI/i5Q3mWsX
	dY5uQLEDdLAtm1T+woVDIn82QaqD1d6qPKcYVUQ76Qaole8/palyObn75HmkdVuxVfKxlyItOtS
	vaBY+LJZnfN3KE5yuYofR6+ZIMFhVBHEn4GeOxFcV2gyroWr0vpATscss+rrYFeG/fGD6/azz1I
	XSLN7EQ4vDPtDcP/GbT0BUWYIRV7B6i07KX2dCZldGKDhvnh/8InTSwNIVE4YBEJ120N836wt3l
	tXLGu17Sw5O20+7EPcK+ouQCeEJJdMALoMWE1yH/W2TVCHWvMYcNycN075g==
X-Received: by 2002:ac8:6f15:0:b0:530:cf0:5861 with SMTP id
 d75a77b69052e-5305484a626mr316590181cf.15.1788857839954; Tue, 08 Sep 2026
 01:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788262122.git.petalzu987@gmail.com> <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
 <ap2ksmdL1FFulLnF@lore-desk> <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
 <20260906224300.21884-1-iprintercanon@gmail.com> <CANn89iLjMMsKLYkv8J3uX-FvzfMvkzi5wtLfY4pZYW2G9C601Q@mail.gmail.com>
 <CADTzad+RD6z0C+0xCoDx8QCm_UztuPncjfPH_87Ce2QJzE8Naw@mail.gmail.com>
In-Reply-To: <CADTzad+RD6z0C+0xCoDx8QCm_UztuPncjfPH_87Ce2QJzE8Naw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Sep 2026 10:57:08 +0200
X-Gm-Features: AcwNN1UEbI90O3JvPv8hSozZwhiLhAw-Wbl1HzuOMRN82TnZjRGJxMPMAVzWpGs
Message-ID: <CANn89i+JiN-wfeq4=u2O_VD5sx=w241BThKNjCLuXZ+MiM=7aw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
To: Zixuan Chai <petalzu987@gmail.com>
Cc: Artem Lytkin <iprintercanon@gmail.com>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Ren Wei <weir@nebusec.ai>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:50=E2=80=AFAM Zixuan Chai <petalzu987@gmail.com> =
wrote:
>
> Hi Eric,
>
> Thanks for the update.
>
> Does your SIT tunnel series also cover the ip6_tunnel encap/headroom race
> reported here, or is this still a separate issue?
>
> If it is not covered by your series, I will prepare v5 with the fixes
> Ido requested.

I think this is one of the sashiko's feedbacks :

https://sashiko.dev/#/patchset/20260907075846.2913645-1-edumazet%40google.c=
om
