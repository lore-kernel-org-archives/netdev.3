Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524468;
	b=daz52FziwEVF4/T0FYNeEM9D9p4Md7rwekaoXq5AaL9UHrZe9SKlv4+nDHRBrwg6jLz6
	 xDocTn2UvPF3iLKy/vzEYd63fTowPYYRiePuw/N+AXvBiGmrwe3nlxMkyRVydlXmtTNLF
	 M9rbHGsis3EW2llPShj/URn39kM7wHMMi8hLHEHKILZueUxc2FL54gGdPZsTZaDeA7ZjA
	 L30ksUaPFAr8nElrwiRhjRRSaNJd9jgW+FobaR/v9C8HRKPtW2ZST9B9TcCg7ecg7bZkW
	 mFQrhMOwM8IoqHhsdcce4Z+rFO91kcvsC1wrW0R0Ef5vSNIstNfLxBgsWc0AOI7o+kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
	b=FBLnxGh9PIoRmeTgFtq6+044UsNfCKbPYeiHEaB8Igp4W8yggv3Xtb0uj+iW9HiR4Vqk
	 ofmVACLfjVmTMTy4ZVyTKlQ0FZgC82wKhrYHrdAFf6er4GvQoESZkO95TccCdzDCr527h
	 ttICttn0yoFq2UDkK+exxb4MU8IsotGLECg2osNxq68N414hX6g+OGnTn6uMDyGKER8wQ
	 z1HcO4UN3zhJDKDj2xkPRDiG+pFeoz9KDWpBjQbMfeOYEEjxSZX2yA1u1vDaRr+cConSp
	 vZjddqq6Oxetx4hUPEj4DgqNETagMsjkOUfFzTtVgLquGJ4TWKB8kvyNGYa+x4W99vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3B606A88D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ED3B606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORwCc0Rf
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so3690345e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524467; cv=none;
        d=google.com; s=arc-20260327;
        b=K02UoUvfmP/8dAWKaqSdYpLK3lNib3jILzT7RqdBZhag861ifv20pKToOLd3zLxwbr
         GbCvMqxYdphUIfb5rweO01xbLyEr1InsS/YzCf8zO1WDWCmZ/m+GWJl98/ODaqECLvDY
         V7OQwVb8/zg6qw1PMy5lcVy1hROsB13KF4//mFqzoMOofmVj7j3KjVIaOzMJF3D9cbQx
         cKf3YTCx6/Kr6ck52qD+z3iwLDqt0sWD6ofg5Gwzd0x+JzN4PEYQ6/hM2J8kV/AVKDq7
         VwaqTl0Gtxvp3fu47aDIgBY+i676TtU/3/+fBibKCOPMO5s/b4R+KYrA8uVI2+1jKrY7
         C3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        fh=8FMTimyfuzsUJ0ehbFryJMe2lZ8fCCzN7H16RupsQww=;
        b=OKaRicOLTR9kAr/KxUjtu+0Fr5kSGuASC3PYCwEibUbYZMJgD3Lj4AI7FWgCK+IO+f
         RIw/0gDVYR2onfnOuL/arXA4vSQi5wuBf+MRCJb721HisNhGSqJX6KhXojWHeK0XYvp1
         3J+PbkQlplYM3XVjwmyF8FyT+OLNRs8twXL9moaDm0o+6aXX6QHUNUQHV0Rvr5TE4BVI
         6agHcMb1bTAsKRp6vWOO6f8i3qWQSI7RYC8Dls6fn0cBxCr/+vjMmG65guOb9sVFNnQj
         smcn0FVYYZ7NOebMz9A+Fct+i3KuWmexSp0U6cR2u4Pfe3tdM2IGuUJjxoZW14zbI8ml
         sJeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524467; x=1795129267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=ORwCc0RfO5g12dP7DXRFOapIjWsMZprR43pPYuTX5mzuufCJ+FSeXnwUhWLdW5uQcT
         pUhjEZ6JndcGeqBS2exd1A6EPEaFxGnzAxxa3p1FYRbJgY/kNs2HrPyjO5jEV0eVTrCU
         MpV6JvRAyTtMc63c2sWcGhIVMtn9or0kHHYQxmTnxGzXPJi4ugNlUDjHOnnvbxlv5WQy
         j6WOnF+fX1TKbps7pGcWObt5jUeVGoqMY4fduHB+irTQuU9h+MkFBPWFJ//1njBTIxYG
         FEqOW2CkK6tHrOgCL4gg3YFE7gHukHSnJrunAODa8JKo+sBjGY0Ntec7QRCPypPNNCF8
         nZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524467; x=1795129267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeZTUBvhgpIr/mryTTLRvu/xMyKUEKxDCy6a+x8xHAE=;
        b=A0RlKASRpmZF5cn474uE/CryZ/KKz8JMIsUzbx0r0WYTx4O2ig4v4xcObyl1EW7zEF
         28PLCMDhlm2KZbGZQOTj4OlZGHtMjOAjUqf6zD/OVRfoz5GGxByPqXyYtO/oeetgjkaH
         sGg6L+clXn7IQ2Hhzd8DLRdegMdzfFlAqIl3aXd0nMR15DIT4qyPEIHM76qTnnDAOkQB
         ZAxgAXVPVnCoAqj7vH3UK/MMKetbj3Bp5YmpWR/42FXsu6H32gKo4uih4GYvTq71rf8F
         OeFtDqSyq/ELNyT5X5QL29cca0OXWl+R5tldRM88KX9Cu+DLbmdQOcc6Z09os2OdNrjZ
         r4mg==
X-Forwarded-Encrypted: i=1; AL+hErFYBRlvjQq8UUvyzhw0D4atXn5MJYm9HSPc2N3ycQazr8LOfMsRHSgfSSeC4r1s9F7I4u57SHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I+kzDYFMQN4RA7cDCUYmnyx+2CcQI/l9Y+rF493P+vMZVk0As
	X8cEvqRQqVG52sh/3+R8LfPl5hDYV/3pIQqiXSgKWvGhiF3Eh/qF9VCdPWCAILhXdBzpskJrCWo
	pD0br46N0I2rts3kn8VGOv/VO10nXMOk=
X-Gm-Gg: AYBFou3Z8Y0BOqITj30WLn6kPU2B+ZY/exhQV+lftavyjW0PtpFvRKznMnUd3Wik0ME
	rJYvumpnJh7bqfYkhPT/MkxqPb5UAQoY90tdReNXrZxliofHEnBIRWYg/Ay7bnSlHpWDhxFPZlU
	BlV2Hh3LrhRyPB69brmPV9g38HON0C/KNfnqSHpdEdkCZEd9e88xE8NnfPeGDAPYP9GEw4QR4xe
	FgEDtqvwNEpMvCY95ne98DXNM1PSzz+rUSvjlmMK1BUGF3eQbrC3DbVCZqnsQhcxwjwrcd05QKA
	T7t1KEA4tkCts/ATrk6F1W3Yur4AbaSy7dhyfEmHEkvDzMkX9n54ezLrml0Cb8jBi6BtcYCxGRc
	ow4ub49Vp3JAu3EoxMDzNL/RmwoAfBleO4wFKvGa2yc0BlE3F+Jsx9gGet1nS7mQXEtRqRF8MHv
	3MJKfSupLIkog5wjkdrFiprS/HOMInsqt2PQ==
X-Received: by 2002:a05:600c:840c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb5599bda8mr15428035e9.0.1794524466778; Thu, 12 Nov 2026
 15:01:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
 <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
In-Reply-To: <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 15:00:55 -0800
X-Gm-Features: AclHuK9-JNkpmr-iGpGEl47XwzmIYWiDVtXbPH3fGOAQAo_1XzuYJoGM1mVSO4A
Message-ID: <CAEf4BzbdC_+KSCN8C=+E+3n4H70p9c+xbFvEOQC-RXADWbGB5Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
To: bo cao <treebacker@foxmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:41=E2=80=AFPM bo cao <treebacker@foxmail.com> wrot=
e:
>
>
> > please trim the commit message down, it's way too verbose
>
> Will do -- a trimmed version follows as v4.
>
> > not sure this is right, bpf_per_cpu_ptr_proto specifies
> >
> >  .ret_type      =3D RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDO=
NLY,
> >
> > it already is marked as maybe_null
>
> The proto is marked, but check_helper_call() drops the flag on the
> path this hunk touches.  For BPF_FUNC_per_cpu_ptr with a percpu obj
> argument (R1 tagged MEM_RCU), returns_cpu_specific_alloc_ptr is set,
> and the return type is then assigned as:
>
>         if (returns_cpu_specific_alloc_ptr) {
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC | MEM_=
RCU;
>         } else {
>                 /* MEM_RDONLY may be carried from ret_flag, but it
>                  * doesn't apply on PTR_TO_BTF_ID.  Fold it, otherwise ..=
.
>                  */
>                 ret_flag &=3D ~MEM_RDONLY;
>                 regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | ret_flag;
>         }
>
> The cpu-specific branch does not carry ret_flag at all, so
> PTR_MAYBE_NULL never reaches R0 there -- only the ksym path (the
> else branch) keeps it.  Nothing after the switch re-adds the flag
> for this case either: the code below only assigns an id when the
> register type is already maybe-null, and clears the flag for
> ptr-cast functions.
>
> Since bpf_per_cpu_ptr() does return NULL for cpu >=3D nr_cpu_ids
> (since 01cc55af9388), a program that calls it on a percpu obj and
> writes through the result without the NULL test passes verification
> and oopses on NULL + offset at run time.  The hunk carries
> (ret_flag & PTR_MAYBE_NULL) into that branch, which only restores
> what the proto already declares.

makes sense, thanks for elaborating!

>
> Thanks,
> Bo Cao
>
