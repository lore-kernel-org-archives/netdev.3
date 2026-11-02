Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632459;
	b=wgt6h1N6OiT8lpndVjsMz5n/WFQN7xMy/toHwQEZ2TOr2V0qoYZ8Y9xHKGsiVZy4PYMy
	 w7LuEVtpTog8it400ksfvXC9cq/Rxp95y8LGWigAvsqnOJF1ueFUyy9Dl6zPLGK+mNLjh
	 aX4YadttP9R1BgfFwtX44S4n2VzRy1NdbwvsAJqnVM4rfPXlLQ1KnqNsZ8xK0921iSpTV
	 eyNVaVpF7fiELLBDM2oDpH1lBfWoHiZLSBvvkOHjIk21M5jpH25wOZiDr5ewXfAdLiQJO
	 VfJEmdi/byGRVcMs5TJtD4VAyl5HCkXoDQehm7pGiWr9V+Xv2/sMbjcPcsiVLArxf2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8yUDlmlI3+iGrY/dSFtrVmA03ksQdMmCOwxVGGqFig8=;
	b=cqePAipUkYHFtVT7SbKnQPhXAYbtNVyQXpm+2ftQXPq7Orcycfs1tpzGN2e9nXPiuQcZ
	 gUSmxohUTOx9odcDkEQ/O07hOmBDo/j2RO5+mWpi+5nKVIhDmr1mYp433nkyBA5hCN6Yo
	 crDYfsl4i7SembALbSmtHN+of4DFnGXqVC/hHPRAAsFYf9uv6gXZw+ZzMVgGrQcAOkFGT
	 FTvN4T7an8rHKq+0Dtamtq2V4FNLYj7/zJGZ9EYUpl83a5Mc19VPLWGq17XrtTMNP1mVi
	 G2XYVDSpl6Je997g9sFXW2bALxNMcM2FT+0BQsFdkF4AMZLqtM92oouupa+s20C73Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UW7VBpmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007A60913F5
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D007A60913F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UW7VBpmb
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so3873431c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632458; cv=none;
        d=google.com; s=arc-20260327;
        b=LQ1Uf/AN73nWaJU9Mst5NheXj6PG82jhIO6VnnIdEjAKDXhFOhtuYTBV5KBJfjvveI
         ej+g8qTeTgutWQ3SJM+GU//D3WqSo768/OcA1VEsLcMaRWSL/M09PRGlKMJJunvTAhIY
         qZbsn0urdr+uz/VnVe/1thIRVluF9G87A9pyCefNQ3iQtIlQ+xc2UWpPOjOclvhuzCZw
         4yew8JHaUaCd7h4E9SCPdLRqD8HkpEuMQjsCGZFxLMMLdb6j8AfC9eyL0HSPcqAy2uJP
         CGLrfLnRhliec+NtZfJKUpsQXnt9m9kh66HsI/FGzPHeD0CY5wNbZdjIJw4sn4eJ7wgo
         Vd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8yUDlmlI3+iGrY/dSFtrVmA03ksQdMmCOwxVGGqFig8=;
        fh=SefxRKcBZ0jbxSTE0uRjET4judhSjCLZ4iuL2FJOmF0=;
        b=QK1FsAweHe7iAYMCKLvpC9/OMeJ9zr4QUnT/vBgxfTqVdVj1184fQTeZ8AnS/JGBKQ
         LULU/xPcyByvyT+cGJqcqG4sFyu8kx4kP5SoRq2uvMn+kez+l8Snp5KZMYhTundnLBp6
         wmQ6BYxiBZfmUzJpxEcsij64G21/7jh3WrG/+XfpIK62c2r4X8xBADJ7XPJvhT74haMi
         S6qXBLyb2dfJ7Fb3fhe8Ulj978elEpiCnZS9cD4aTn1SnTLGsn97SXhLwRVPfyRl60C3
         jXUA6ddWOK1cymcUq2nKSwGbF+ebwMdnokpxO0P0YksmCuaWCxWPjlXqoqfU7fGgW/6R
         qoqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632458; x=1794237258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8yUDlmlI3+iGrY/dSFtrVmA03ksQdMmCOwxVGGqFig8=;
        b=UW7VBpmbA+R7DgWQFPW1YmAY8EEK/fr3Qcz+/ZtZMHh3wLgj23zleU/MciwV0CmwSq
         IIuqZfkmPs3AwBptvnphkRMLtpt+UDKLbzCQwKa24aSr4rykHGAIvDxlWUmVFi90sfuG
         uqCU95uYYLJaNtDOyTNUsUnDiQo5qc/zfao6V/KmjKLOsCZ/3hYH42y4QOSYpKqezXAW
         h9EatqWdNcrVuEnzf2oHuoPVnY0/gmdOge33hsezVh78T9O9R82VQyfICQcF050uYbk/
         liXbFDcZm4ya6bzjDSVdpj9XHvD/40XIpRvhB7R0ndP09JwC72RtKYUdm0JwMjDu/fTJ
         T9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632458; x=1794237258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yUDlmlI3+iGrY/dSFtrVmA03ksQdMmCOwxVGGqFig8=;
        b=Ya+RzOmNm3xrhbOiJkHjs8ScTDhtjxOqqsUdcVmOP11AfxPMzeWsqihq4P/k/mqGw2
         XPVutEIbo3G8wbpX9vEDNE/+wyxWDy57ZopUTlIlF4xXRZOMy2I3zmAFVKdSir3/BFIf
         CJQtqypbCEv26eDNMHKdPQRTioQz4B2/KDCabmIVNVhOR7WGQKldALhGPEPaj4cia6M3
         8wdvz48wTM30M1EOyjzS+gPM8thfvevT+TyJN5l3i4JipXE2gcJ/YDDk4q0wBSWcFL7E
         jQ/1ZZ2Lz46mp4lJZeIgyZfJEtbIJZXBe0oIaOJT1knvNMPaxzoLlo90F15xdGBsuVrc
         X3Og==
X-Forwarded-Encrypted: i=1; AKwUvBxsrh8eBMtgNLQeHZrv5us8z8j7mUKvU1tJo0+XYgIqjkAfoZKbxXXlNDuWbsHUIGHgjgCotc8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX91smr/GWtNG+EfSk0KzrdOVSE8XbaZB3VZ0Vgb85q7E1PtkX
	2GrRrZjNr8e81ACrRl3Xy7FZaaLRJ0+AaS3a382FOumNRjPSAFGJSg+3nr5sG70pIkqXRmsLlur
	Fq4zp81h/x7yYzUNKi5am8wklVFxL9U0=
X-Gm-Gg: AYBFou2Tx1oczHoh/BK4lFvD+5+8jd3IrCBrPhOfL6QN0R/PkFTpLCL4kHCakxCjiKE
	AsEYYGHxsDBJ2OmqRrTPrwHlBj2fD71XVOIA/LTywS29jd0/FKDntDrzytLyM3k5Tuifa7iXPMs
	ju5kloPEw+yqm8mMO6c1UIPPfa5Cu4ruSC9Tox80/l0bBF7Ew32w9rUEAgaruEWkBgY/n9x0xbs
	xguYmCENoDDIkXGCaGwYzKIYn8qwS9LnbcartJ1pjMLHnPZfFNjvSgedJIld5C16DXFEWbscW8l
	UhCTgt4HkkdGtyHFzx2L7BjGsVckPMHFwtlXeFYC0GBXodr0JGN5u5Vpc0kqcYW5aM52ammlrkE
	hI8zZeP170E5MicydeDFF6r1o0BKHhoAN2+Lnmv8GVVkTx5NG8Tn94BIgVc3ECIKB7loSs/35XW
	pQ9TbbAPNpo3R7
X-Received: by 2002:a05:7022:88:b0:144:fb31:a597 with SMTP id
 a92af1059eb24-1ac6069cebdmr14582009c88.47.1793632457694; Mon, 02 Nov 2026
 07:14:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927131838.6774-1-demyansh@gmail.com> <20260927184414.6c0c8867@pumpkin>
 <CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com> <CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
In-Reply-To: <CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
From: Demian Shulhan <demyansh@gmail.com>
Date: Mon, 2 Nov 2026 16:14:06 +0100
X-Gm-Features: AclHuK9s_qVGMHFu-dL36Q48-lWDPnNvO_Yb6GHSTKkiWePXFsWruUJSaC8neac
Message-ID: <CAOLeWCu4NiedyXmoLwwnTvJitRwgg6PQq9LApO=k36ktN3-XWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
To: saeed bishara <saeed.bishara.os@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Ard Biesheuvel <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The scalar path seems like generic C code and not restricted to arm64,
> curious how that performs against existing (e.g. x86) assembly
> optimized implementation.
Depends. I think __builtin_addcll() is needed to get roughly the same
performance as the asm version. In my tests GCC on arm64 turns it
into adds + cset instead of adcs like on x86.
But I will look at it, thanks!

=D0=BF=D0=BD, 2 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:44=
 saeed bishara <saeed.bishara.os@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gmail.com=
> wrote:
> >
> > I would prefer to keep only the scalar version of the fused copy+csum.
> > It reads the data once instead of twice, and on real Armv9 hardware it
> > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> > depending on the core (+6-8% throughput). It uses only general-purpose
> > registers, so there is no FPSIMD state to save and it is safe in any
> > context.
> >
> > If you are OK with the scalar path, I can send v2 with NEON dropped,
> > the scalar path only, and the KUnit fix for the x86 zero-length case
> > Jakub reported.
> >
> The scalar path seems like generic C code and not restricted to arm64,
> curious how that performs against existing (e.g. x86) assembly
> optimized implementation.
> saeed
