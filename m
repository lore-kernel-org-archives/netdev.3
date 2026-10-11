Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6733E346
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746293; cv=pass; b=OO/5r3sw+75vM+04JvIIBe6/v7NozX1BoVqfOtbf6pE6bTGoe5u1M8pNTYQ/aLSpzlrDuM+YmBDJIXUkwzT7BxJ8apeg1JfUgzMY7fmdyN1VAtdWxicz8adHW3e7RXySd0IpmhnTvkQG8DP+WbS6qVPIKWEPjgLImNwOoaQZUXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746293; c=relaxed/simple;
	bh=IWM92jlv8+bItDuNLx6rWhbjIBftHslCpZwGdPKFMhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2ePBgLdZjIqJt1JtmSlc6zD5FT9ekpqpARgDsQJ9wMcV6COkzZLV1zRvjsENMB4Ks6iSZPPFMANQHsXx91EvhkQJK6weeIWWpc5CK3BnYiVN9w6zWaw5zp1TnatwA04dG9tXvqfBKPJVSnzJ60NRb7kAlB8lzuc4MiR4ZW0bog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPhi9XT8; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPhi9XT8"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6790844c9b0so762500d50.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791746291; cv=none;
        d=google.com; s=arc-20260327;
        b=VjH4UGSLC3TlR+QjdifPISQmRigbV3O/xpNzxcsJC4G/N1+Ixa2Lw8Tkr5ntFyR4J6
         EElB8JA+I+G9+n5X86NmM4tM/GJ0BsVFXjMjc5KUfA4tGvK44esfH2kTIKRsuYXYWnbX
         WmG/0msftFXw260ZSi5w2EckRlT86vRiO70VJEttuKD5Y9ikxKjBlXmA30msMC6OpQAl
         2dwSlNOi+l2ARgoGSREOlHAAW49pVKwYbm8LYOq5IUgWb21Jes6KpSQx/hGkd4vAcz+Y
         O/4miBSOyCNYX7Z+rMZyjkzmbQUqBufGpvEv7W2dYlFPSnQSS+6fo1zKw+P4xUDXWn+R
         V/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        fh=zis7WR1u2H4FteD4jH1zxxBycNuvd0psYkSGb0JlBec=;
        b=RywOXICbo+9AI14+PfDqlF6zxPwl1eYMp350ULI6p4RdmhZC1Lp2tGH3pu3j6NxjNG
         /3WYsR7VjV/KaSWaDKCL/jcC+ph1rfruVGLkceW+iVS92gv08PfJ0Td711D+c4/08+Vi
         bWFJX+nzKqVljq1OnZ3gpJe1BatDqkNv9lM881Rq8mdf9ZbkGZqSaUVPfIfQUommt1k0
         i7HFL03zDukycW2O5zgn1aQ5lpYe+8HZjIy6Tk/3tbETIo062D0O73vn4nRhoIFAffxO
         oj/STwuooRU19A/zhnO5YvXfUE5SW+nsPDJPT2Wd7uLgzYbTkr2V68WIHkMnLbXH5Kt1
         +4dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746291; x=1792351091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        b=BPhi9XT84rYDt+zxZ6gXkQxgHxvWlpvvlOPox30hZfYx2xsDsxCCGmjdxQ4kqO2uoT
         mehK5dqkmYwyd0P93bROzbUnemwIjqF3MsB2Etm0u9qzrXqIOXjzIpuFjvw+000+/e00
         kimg5GnrdclIHLmmFNXWQA/ErOIg2Z0P2kVHwgMumn1DWs2OdlnIAO1nnudzOocBmzTH
         VhcJUNy1fQkJ3v6yg/FMXvsbSB+zfRJRGE72XKO0/R1ZfFRUlbXs+IYX5Qzb1Wt2BN9g
         GITHrd5GN7iruDqYacitZ/MX5LmbH/Ts6ZjqGsC5Sulor/LO2OqWIpi1GmnN5cOU9W65
         ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746291; x=1792351091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        b=ZuGPU0MtmX587law/cVNeNbEZsPgSVszRjn97hO/n545QYJ9exlQy69tLB0NeGTUmx
         yzAoXxUsJcG1Y606tggK+yqpcErnrRi/A7rGccN+L95WNIDqZQJn96T12oiIrvpiKiWD
         Hhr3i86nCO9yfoxcqlf9WATsmCNg8OXbKX+gyKYxS92wttZlfX6+SBfFFQv4Suu6lX8C
         mxFp371snmiUZr3SXtgTzLUlVna2XKz5dz0tuWo1j4tFmyJzxiBcQi9y0r67Mfm08KFt
         wiaHZI951uJ5iCSe9l3Npd1f5dPXDx700ooCiRPMkRlpdt9zqv0cRXCBNMulK5aYmuQT
         qSMw==
X-Forwarded-Encrypted: i=1; AKwUvByciSdXtxHDcWxzxLUUAkgO3ki1fDbVI82J21oOdq5QhlWcjCU1cnA5nKFQG49m3sP+ny9PD/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDcXZ3iBRWFFFayy0PGhl3OXkGIIOULqh+PJSoapvCD/ffog1P
	1HV2WFtz+XnI7UDrV4dVEi2wRvJ0DPACYbeDo62hRPdske9ISHJB8smDOEm4W2uqvYuzIuGHJfB
	V64WlSZxWhKYxoLaO6jCrW8HjWU1s1hM=
X-Gm-Gg: AYBFou1pXOj9ibbw0admG0/ZQ3/Smytr1Q9ifF1ZuU0HGbrkkqo19P/2J40tdI2hRIK
	j7ka4qeVmAWTmyDg0rDBX4hybeGvCA+bSeXcN93SUmyjUvMjz3dRIGe9ab7tSZBHpvDctHVOrI7
	hZPZ2I5gGlMc7xtV4ph9qdqR0rJkcEeQU32BBFro+TUoqsKv4n553e+bFVntnFa/VJLBpoQwjqb
	BrmyG1FMW+FBVp8FsANABIk/BKqwa1jChYMDSaaJUGuN+p10M4LKoNx9naFuUEelLn+Okcvz7sB
	mPOF0x95BX46qVCd7qlJloOANee4rrKvSbz5T9r3DtbDQVZLORoABD3uWZstj5c7nLl6IfcUN+l
	pC0vz59pphOpq8LhKIQwfQckt4cGRWSS/71eFQZz9L95df1A44qm0
X-Received: by 2002:a05:690e:43cc:20b0:677:d1d9:1277 with SMTP id
 956f58d0204a3-67936aa750cmr1760899d50.82.1791746290718; Sun, 11 Oct 2026
 12:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
 <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch> <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>
 <c8bc138e-2d62-4ee8-9020-5f1091efe015@lunn.ch>
In-Reply-To: <c8bc138e-2d62-4ee8-9020-5f1091efe015@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 21:17:58 +0200
X-Gm-Features: AclHuK_XYA2IeX8EB_wQ6S_Y8XgepVmJIFtOKL2to5kfxrIk9XqHG7Csp2E4u_w
Message-ID: <CA+=Fv5RiKoE07MVn5qRS1+WtLXUVO+HrXyLpVCcXGoCb7X6X3w@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: Andrew Lunn <andrew@lunn.ch>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, Oct 11, 2026 at 3:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 09, 2026 at 02:52:57PM +0200, Magnus Lindholm wrote:
> > Hi Andrew,
> >
> > On Fri, Oct 9, 2026 at 2:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > > Is there a legitimate reason you would want the bytes are swapped=
?
> > >
> > > You missed answering this. I'm guessing, but does the hardware offer
> > > this to make big endian machines more efficient?
> > >
> > > Please could you look at the driver and think about what would happen
> > > on a big endian machine. Is the change still correct?
> > >
> > >         Andrew
> >
> > You're right, my earlier reply missed the underlying question.
> >
> > That is a plausible reason for providing the hardware swap mode:
> > it can accommodate big-endian accesses without software byte
> > swapping. I haven't verified Broadcom's design rationale.
> >
> > However, Linux tg3 alreadThanks, I'll expand the commit message with th=
is explanation in v3.y initializes misc_host_ctrl with WORD_SWAP set
> > and BYTE_SWAP clear on both little- and big-endian builds, before
> > this helper runs.
> >
> > The helper restores that existing setting. Its swab32() compensates
> > for the device's inherited register state, not CPU endianness.
> > Subsequent accesses use the normal driver path, and the separate
> > __BIG_ENDIAN handling for DMA remains unchanged.
> >
> > That is why I believe the correction is appropriate on either
> > endianness. The runtime tests were on the M3000 running big-endian
> > SPARC64.
>
> Please expand the commit message to show you have thought about this.
>


Thanks, I'll expand the commit message with this explanation in v3.

Magnus
