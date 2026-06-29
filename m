Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E22379C55
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745886; cv=none; b=rZ/+vhkzBCRXgHJpKi2ZKNNH1zmcC8UMhausXexX0rH/V55HINpQR+Qx8uNLCqVrHki6+QbjzT8pIR+yQgO03Qnkong+VDaF6i6hO5NRE8oZiYrhtmER16eucrEf3fJZpmvXaC0KWntDCTObIgmkYTe/D561sJuyd5eOcDOr3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745886; c=relaxed/simple;
	bh=kwaiQeiaucp2MfWzIUzd2lPMc574qsl6ASwsK3f6icc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=taD5YBgG1b2HV75NTnW8fAGyDzC8tAk2COLprtYGjPRB9899WShiTOcBhKLRiwBnYbb4OgnLoNUQ2YzgCeWFoy+oSMMRP36yOE+uXSJHsuTNPAkGf6JwanHDFq4c58ZPw3d1gXSbvkT0EsSjAkSP/WVan7v45urdEak0mhb+DlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CujEaR9M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmWbW2qm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CujEaR9M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmWbW2qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782745884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
	b=CujEaR9MMufAq9QunZbzqLSfCxzZxETa5pnjn3eYmvDfHuCNrBLrztCryqxIT3jTD1MHjy
	GQG7we3jaYeT8QI/8UDcb9QQ4Hvu78IIP+1kAS2TESZZRjS4yTh4vTsVwgQSxwLpRQweBp
	Tqw6Zw8jLBVB36FsUzkgjLNyvf0D1eU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-mSRCiFFxOxKwpEcv5nPSkQ-1; Mon, 29 Jun 2026 11:11:23 -0400
X-MC-Unique: mSRCiFFxOxKwpEcv5nPSkQ-1
X-Mimecast-MFC-AGG-ID: mSRCiFFxOxKwpEcv5nPSkQ_1782745882
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6983e384c66so1805595a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782745882; x=1783350682; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
        b=fmWbW2qmY+wuyXZUAjxj+eVFCXxyOHCKAV+g0+A/zw66IC83GUqwlVq7JhRNjiGPhZ
         7u01ztZ+06WmPsIPyBdmq57FURBeXLojLnT/86t1A0Vfh9EMyVMCv3JP5sWf+mdczlrs
         1srCCHSWG+3Dpn3D8+l4Pv+/igi3s58Fg/4jUP/taU454btkq/hWzV5hO7T8IMKavC9d
         AmpTEEP4FDV27zD/tVaW8ElRl0moijDU2gghNWmG1bJnBtP9ROxldqe/e1/mHE/V5KaP
         F/iApMdQRRi8pF6ianKVGbk5lH46NJnwEE3gt9eIAXpNek9ZL5td5GzIscvy1m42JtGr
         BUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745882; x=1783350682;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx2gFMGxt4RZNuZum2PFhzOqoj2Qwg57W9rcXYdQKuQ=;
        b=tKJG9W06PJhk1WW1OeNWQ3fxYZFh0jfO7M67DA7VEgkX+SFb53sHxWRMUPRGqWSqEy
         cgntX7Cw3pIuEFXaeBfC39k/lQxEJdPhEjG72g2LusdVY4Bj/P2ZlhEEHUXNmpnhG2Fq
         qFYTXg3RKzW5zHMdVCcm1Kx+hIkYUlsf1M/g3i4rw2bHcbPwnsAQKWEmKyG97PDEhCMA
         xrKIcOT2jjjKPk7rVCy4jYx2UP8TykLrEqtHLQihYIoXwL1I8vE/AelvmESS2qShILn8
         Vl5BZzu/I8F4FpJFtu/3DwnGBzg7a0k+r/ZjFXIpN0/dIKgJJS0UjrSdvyUdhNzYqaxa
         2lxg==
X-Forwarded-Encrypted: i=1; AHgh+RohYm7YikjIlDExkMbM41S3Es+aX/ho5qMIGN5uwtAODfJVztfWYUAGXcmu77QoM0SoTJ0wm4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIhAWWyMssVU8v1WK4g7qffD9WRV3LlK1RAknyWUhLigGi2Xq
	/WvScLQYjyBRnhEp//JjMIKkB1o3Rug1kR+EGckPmym6/FHkB42zim/dZUhSLtFYM2f3olJ5+yl
	//A07tEwPgOqLlwEfHBneYP5Us1jcHwXnTNwxngtUtd1T4aG1FmPkdMihXw==
X-Gm-Gg: AfdE7cnpw00oE99Ujx9aopYDwqFTJmeQxmrpWDWtEy7ZCQjyUJR72+p86S0+KPnbDia
	3mCtY0k6mzRTO8psUDO4QoNsjBEx3xW/l08rZN4GFXXC75xxXVW1KLhCejaHRLQrgjtrxnRjT7i
	5zHekVvKbvjRuDB9DjtonlXb3DMTvGUzYNgMNHy9VOcfmB/8vwR1F9MKOubPSdxAD+PTRAk5hMf
	h5tztKoPreBXoBycDF8QMYbA6/mZRr71tBqPdfhl8+/3N3sD1vqOplCVlqOz8l5hsPREd0mEKRK
	WldX7sx2uTWzWmX0daDTh54uyHEAcMrZhyn07KgSbwAfs39sPO2AmqOl+F7IR7gjtD12WWnYrwY
	LIM2+qngZpT9CBOkgV3L/9c7YJA29yD0qkeM=
X-Received: by 2002:a05:6402:34c6:b0:697:dc26:340c with SMTP id 4fb4d7f45d1cf-69810a74f3dmr6670267a12.12.1782745881810;
        Mon, 29 Jun 2026 08:11:21 -0700 (PDT)
X-Received: by 2002:a05:6402:34c6:b0:697:dc26:340c with SMTP id 4fb4d7f45d1cf-69810a74f3dmr6670232a12.12.1782745881369;
        Mon, 29 Jun 2026 08:11:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69847322ef9sm3693279a12.5.2026.06.29.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:11:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E3E7780A269; Mon, 29 Jun 2026 17:11:19 +0200 (CEST)
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
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260624115442.4112419-1-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <87pl1gcmgf.fsf@toke.dk>
 <20260624115442.4112419-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jun 2026 17:11:19 +0200
Message-ID: <87pl19bcvc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

>> > +	if (flags & BPF_FIB_LOOKUP_VLAN)
>> > +		return -EINVAL;
>> > +
>>
>> This is fine, but we should probably reject the input flag as well in
>> the next patch (for symmetry).
>
> I dug into this and I don't think the two are symmetric. The egress
> reject is right for exactly the reason you gave: in tc you can redirect
> to the VLAN device directly, so reducing the egress to the physical
> parent is only needed for XDP. But that is a transmit argument, and
> VLAN_INPUT never touches the egress or redirect side. It only sets the
> lookup's ingress (flowi_iif), which picks the iif policy rule and the VRF
> table, and there is no XDP-only constraint there for the symmetry to
> mirror.
>
> tc also has a real user for it. In __netif_receive_skb_core() the tcx
> ingress hook runs before vlan_do_receive() demuxes the frame, so a clsact
> program on the physical port sees a tagged frame with skb->dev still the
> physical device and the tag in skb->vlan_tci. That is exactly the
> physical-ifindex-plus-tag input VLAN_INPUT takes, and it wants the
> subinterface-scoped answer. The 2/3 selftest already runs the VLAN_INPUT
> cases on the tc path, including the VRF-table-selection ones, and they
> pass, so this isn't a theoretical tc path.
>
> So I would keep VLAN_INPUT allowed on both. If you would rather hold a
> uniform "both VLAN flags are XDP-only" line under the same
> restrict-now-relax-later rule as the TBID and OUTPUT combos, I will add
> the reject, but unlike the egress case it removes a working tc path
> rather than one tc cannot use. Happy either way, just let me know.

Hmm, OK, I'm fine with keeping it available for TC then.

-Toke

