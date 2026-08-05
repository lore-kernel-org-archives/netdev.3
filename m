Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3F472556
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946466; cv=pass; b=bL4sJ5vpYqNHQtSO4Vpz5zAfK2Z1n3h31XoKz0uo49yYP586m8+dnXE+XcCdBhxgfUgH15LATJfKxj0prR3oeWQSQecTCdD6eBeZ/+etjb9tuL34sjJJjU7q6fhMLxlEU0/IF0LGst0KOjQ3L7S5pDrBi3ohMV/cgNJ8aNoyQ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946466; c=relaxed/simple;
	bh=0Qk6cZq4o03gndyzZz+HNeDI3avPQbggjCc5GYVRIfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMtXVHGJyvexQWDuFc1bUobKC+0pvCELmHxmx4OAsSIZws3yHhY46aTg7PCI8dEyG0GxyBMBOup7k27i2iIT8unK474+8PhZlsbQmnKs+M7Vm98ddpdmfGD0szOb/eCjfl3OCY85IVZZuy1v0q8Ojo2WFuSWuGlQM2odBZi1Yhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j27Op9UZ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j27Op9UZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1844030b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 09:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785946462; cv=none;
        d=google.com; s=arc-20260327;
        b=BLffP9ns8CYhvqP+FGxn0STnms7Iu7ZG5IVnay4wv+oBImZqWOxLOO5J5066RUq8km
         YMzAAj9nDmo89pyqEzWiqlmFJXzi5HCXm+dLnqY727RUb693JNIuW3mRH4NyN4I/+Suf
         S/ns/ygIvAhkHOUJqd48EYifPvFAWholtR2kBh1lKPyjm24/DtorkOLnBzaWTK/x5DCf
         r0gfFhhU9p0WNSbMOpQq8Phw+iEKIcf5EIEt/r2PiUO2eMBz3v1Pvac4uX5NYLU9p6cn
         X4QNhF7TmFtupj38q3OK3HaskcJiBru2qS5ILRiJXGBp69JJzSlPf+9YI19o27rm9ppJ
         EXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLlPuz3HFTtsHol1M3m1DfJwxywNL84sVaYKNwosCcs=;
        fh=fCgnWFsGnLM7EBf1HselaX3ot6k5pPPfWeFtxvmzFn8=;
        b=e+GYYpdtx2/pqhTErqF40Jh5EfhItS95ufstZSae+fRhdUwGY8tXPww2Y45Wxw1Mt6
         WD5mzvstYACXUGUdBp6lnyu7jvj73ior9q6VLLyL3hmmvDoNvHLgqjQPazxH+hLLRzwE
         irVfupRLLethUyDfdilHDP/kII0wLBqrLAas9yUNR/uX1eUppedwAc+4aDsx8vrBOLtp
         lajKry1kaFPkwVWvU1/U1Vavm/EyQRMSIFEkBdqWADujFYahr0pX0mXHG2oieJkCjwLN
         RHUuqfnWhPqN2Uuz0lr0I/1/XwY/x4ylwpp5GcddBMS86/Xj99SeLHvNZaXTvOuNHJ4y
         /+RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946462; x=1786551262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLlPuz3HFTtsHol1M3m1DfJwxywNL84sVaYKNwosCcs=;
        b=j27Op9UZxecS4deYkncLbe4vpZPUJClRzy6njUPuRqmRT752ZnirDo8Tr7LnY/eEB8
         c7Cwa0/wnbkntQF8e9Ai8gpUNVvt2ezKj4CozuhRbeJVsxqSYdw2Y9WMp9Wkl3/Gpn5g
         RdKaVmR35P0I0MMZvTcNlirQRA9HzytxULB8DSwbm2v5lA6q4M8VIj+YHEKGKMjQGIJt
         xgXAYIQDI2r5KD6XTdzKib3OHJafiFmVWR8uuhFU/Qr2Tv3hjHXm/Qje7IdBbiIlHAM8
         o8c4ANYNPkVKLVndymnzDNi85jUT0l4ZmC5b764cc5rJ5xXqT0GK1bKQaz93BRtieRlE
         ADvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946462; x=1786551262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLlPuz3HFTtsHol1M3m1DfJwxywNL84sVaYKNwosCcs=;
        b=moIQ33qXXra8V27sTthJ8ZP4X78E7YHpQDCV+I4K4Kc+HkqSwUF9R0qSUjS+oXa9kF
         elY7TQw3NoEPPTrc3MdlMbm57MpL/H2AmvvMrBGWlegs4Jus1kYowrt8Oa2Uuh7BC4Aa
         KbzEPTnig95Q58N+rVgc6vQWsc5AxPDKsiu9F5rXVuAoiAMa13vynFBnmEQ2eDCBXT4U
         bG4d6LC97ZlJROKCPeTbv8BAdvyzhShCrX4RRWYwrLNs9PB9+ilb64Zl3EWH8/yms8d1
         hpiEoMObz1vNmkwUcEHhCU/666szloNeHidkfR5jKHfBcczd00AEeXX48zhLTJ0AtFlL
         fWvg==
X-Forwarded-Encrypted: i=1; AHgh+RoxxMVwKSH7fh87sda4h9AsXuLAV7D4jjpHKTPK2RsABNKBhmUMgR9ynoHngOY/dswD1O0l7tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7JIBrn0jd4jYkumBdav85dsVhJtjVuiYSPU6iHeJAbD5rBsbH
	TUDvZ+PbXCfWoIuIKy3r5vB2zi1pxHCwEq2fZO16tImwlWCFW80oNnmK9VMhKO/VXt/ribo1EFZ
	TGX8u8ZFW+aXPGGIiqw9g4c0FSMZVNN8=
X-Gm-Gg: AR+sD13TiyHnBuwxOpUyx4HVhVseiiu3GiBUVI0G6Vr5xngKavmTDnCRMibB7FFR5ZE
	Eyo4DiCfyG0Y0xjylkisRgU6V6a1OdlgBA2Si74iXRLvWGLFIaq3k89iL6VHfQt/cj6KQ3SyLdL
	i3xek1nbuJIiEMuaE+kmtxEw/FrDjhsKtfqPzuzfFk2wmKHNMKUHsxN/NyknF64JrZB45FTaD+Y
	nipQ3VdGLGQQwixem0DQfBy0nDZMhYM7mgjFQJuBcz/0QoF0LaEQVgZimI7c/c92YJez9b79eQu
	OvZf9urksd5UBAuMfad57x1+WlpU+lOrxoy85BpOBpcBzXO+kcBdXJCbCf3omWRNQQzPM5Xuqip
	qM0wGVO9JdUTVw3CZFUe5jdBvmN+oA65CgF2rU3W2g4OKC28u2KettV+NLbKmELaVxzwYK2faoc
	beSPoQNjZ2uQ1R
X-Received: by 2002:a05:6a00:440c:b0:848:487c:ce05 with SMTP id
 d2e1a72fcca58-84f2dfb4e7emr9608034b3a.7.1785946461780; Wed, 05 Aug 2026
 09:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804113100.37840-1-juny24602@gmail.com> <20260805123525.571744-1-horms@kernel.org>
In-Reply-To: <20260805123525.571744-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Aug 2026 12:14:10 -0400
X-Gm-Features: AUfX_mwPOxXLgd0PmxDdi0zETIO4gRLtWA2w-9OvGMbWDwXuLDWRIjYIeGScDqU
Message-ID: <CADvbK_eCKN3KqmdLAbcUem7s9BH8R-JxVHj4rOtUu5OvZja-3Q@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix stream->outcnt underflow on duplicate
 RECONF responses
To: Simon Horman <horms@kernel.org>
Cc: juny24602@gmail.com, netdev@vger.kernel.org, junvyyang@tencent.com, 
	stable@kernel.org, corvus@tencent.com, marcelo.leitner@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:35=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260804113100.37840-1-jun=
y24602@gmail.com?part=3D1
> ---
> --- Patch [1]: [PATCH net v2] sctp: fix stream->outcnt underflow on dupli=
cate RECONF responses ---
> commit 9a827b81b27b219603b09c1f04c9dbc9a6dd2368
> Author: Jun Yang <junvyyang@tencent.com>
>
> sctp: fix stream->outcnt underflow on duplicate RECONF responses
>
> This commit addresses a bug where duplicate RECONF responses could cause
> stream->outcnt to underflow. It converts strreset_outstanding into a bitm=
ask
> to track request parameter types, ensuring duplicate responses are ignore=
d.
>
> > diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> > index 34ffe6c945a4b..cb7543929d657 100644
> > --- a/net/sctp/stream.c
> > +++ b/net/sctp/stream.c
>
> [ ... ]
>
> > @@ -928,7 +936,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
> >       __u32 result;
> >
> >       req =3D sctp_chunk_lookup_strreset_param(asoc, resp->response_seq=
, 0);
> > -     if (!req)
> > +     if (!req || !SCTP_STRRESET_TEST(asoc, req->type))
> >               return NULL;
>
> [Severity: High]
> Could the new duplicate-drop logic permanently drop legitimate responses =
when
> the sequence number wraps to 0?
>
> If a user calls setsockopt(SCTP_ADD_STREAMS) with both incoming and outgo=
ing
> streams when asoc->strreset_outseq is exactly 0xFFFFFFFF, it creates a RE=
CONF
> chunk with request_seq =3D 0xFFFFFFFF for ADD_OUT and request_seq =3D 0 f=
or
> ADD_IN.
>
> When the peer responds to the ADD_IN request with resp_seq =3D 0,
> sctp_chunk_lookup_strreset_param() handles it:
>
> net/sctp/stream.c:sctp_chunk_lookup_strreset_param() {
>     ...
>     if ((!resp_seq || req->request_seq =3D=3D resp_seq) &&
>         (!type || type =3D=3D req->param_hdr.type))
>             return param.v;
>     ...
> }
>
> Because resp_seq is 0, the !resp_seq check bypasses sequence matching and
> returns the first parameter in the chunk (ADD_OUT).
>
> Since the ADD_OUT bit was already cleared by the first response, the new
> !SCTP_STRRESET_TEST() check here would see the bit is cleared and drop th=
e
> response as a duplicate.
>
> This would leave the ADD_IN bit set forever, preventing the RECONF chunk =
from
> being freed and causing the association to hang due to endless
> retransmissions.

resp_seq =3D=3D 0 is a valid value and must not be used to indicate a wildc=
ard
lookup. This is a pre-existing issue, but it would be better to fix it befo=
re
this patch.

Hi Jun Yang,

Could you please address this by adding a 'bool match_seq' parameter to
sctp_chunk_lookup_strreset_param()?

After that, please repost this as a two-patch series:

1/2. Fix the lookup logic by introducing the match_seq parameter.
2/2. Apply the current fix on top of that change.

Thanks.
