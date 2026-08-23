Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95B280018
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787517538; cv=pass; b=l+gk/VE0KJsQwAIqCOWmf394wV+4BO/Q37zxWQHGyQkw2L+MOI7E9yFTlNdq3lVZvXqc0xxkuGqZOlsO7q5CFwsPENKRqi54hwYmt7ejaUhWljk7miviwhXiWi7TGg8ub1Xzz12+KLPikojC8DTHGl0oNgHgLwGdMvNZOSXASNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787517538; c=relaxed/simple;
	bh=DJJNdYFcgwSR7W4tBu+xudB5yEN+f2wuQhprkjKzETA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF+mgZiJwTB/FMAnlsKirYZgvcqvrXcOLzmJsAZWzsxGr27XNgU3X34vH/iVhVRapI4aoiyTtZj9QwmZs6Wta4zVDpgot2jTL0gOXquQ3nY00BrIAcgTHlc2J8KXU3WvyCN/uXIuZx7/N8StsogDhMalY1JnwdkMYhqh1mRd5mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG6Tugno; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG6Tugno"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3741154b3a.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 13:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787517537; cv=none;
        d=google.com; s=arc-20260327;
        b=gMwgRldbxDvImTfWq2lrFeNUiv+rpBOYfC/FEp+QkNhZD5GMHv2xWMsO1+YLwFcPw0
         ho66o5lfuxuR41d6IKUWstWjHDXEW6vrmmwHm1nGt2IEXeCkaZjFtH/mofZIzOJ7CAfj
         FP1egTNsup8HaDvh9PkeaLbJC0gmJtv12wGoMpxAQvo5iE844LFXOxiCa5khrTUVQi8f
         aYQT8CCBYgsd0rTMYPynLHI99eTRlkmaFvcgI9gVG+9H6uP01x0y4tVnPgrmw8za6Nh7
         Es2fhEVJjrqL97Fo2yySxtdBXY9mK/lSrbMatqCkFhikAcr1nFfwb6FFzOo3hXVWkJD0
         tuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1HwZJJPTJ////Jd0Y6Z4z0mnZu6T/72VRo14Pnnjwlg=;
        fh=0KxRVI7/1R7PCmnBSTiHFwxodbzUojYFkhnWHs3F6hs=;
        b=juDg5qGSQM4iopQ9tlANAehoHmvmQ5TEBZsotKoxFFHnt06JWas1CWYvzOh+Lg3GVr
         VYW+3EptOUImJyKs8bA1IOLwLgAHRLgSDnwha0XJkk/+lPgpevDtsWXOGHJzt268TKb9
         MqEmk/Wj1XxFtAtOB/BoXBcKDsDaoXTz140DPCNqGzDY4BIKDoEBBk52Ns1ESsdT0Osz
         cTDNRsX0YovCsShMgc5m9/56QshXDvfofGrfgawzytnhbXBqrTIDx33WqLbsPDBj81WN
         hCLBIzRAeJZOuuzc4U6CkpxCWZl5oknU2KlZ3gdW5aCrjHoq07u0vFdpOtOrA+YYqzQ+
         4RjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787517537; x=1788122337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1HwZJJPTJ////Jd0Y6Z4z0mnZu6T/72VRo14Pnnjwlg=;
        b=mG6TugnoWf6Il5s4UIwmxXGRRYbhN72tqX7aQjJXpS3I0Fm0LqkJHxZcUTDpoLmWCv
         q2z/QclVS3FqetN5FOUkpBRXjFaeeQrL9yOkzJBiOwzaTB4z8VoID5eMBAaW4Jg7Ty53
         jRZgJIk7W6ivh7cTD7sNzZatkU0x0zxgdsu6t5v+lyjGcAMEJdmbZ/kLgDfbjlF3w2Mj
         1j4BpytEnuJzlkCvzYE/BOOXElIXaaqUaW/Zt0KSWo2zmpzVorpTFIlQFgT43xWDCmQG
         7QbGBtRq0+IF1deE8jkhVVD8rxIK/MO9UozycUUa9aByc7sDEdbIMbpxbgFJ4mXzXJsc
         v6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787517537; x=1788122337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1HwZJJPTJ////Jd0Y6Z4z0mnZu6T/72VRo14Pnnjwlg=;
        b=VXHHpMIbQsdYOPIEAF81Z2tpbw/WitGr/nSec6awmj0g7GSfCgyeWgrrjiGL2fNuSl
         JyEVvsd7cveVYfpxtpJ4P2lKFUNb3i6BmE8+H0ZinV+NnW5q4ySZW/RHLOdP6RK7YUvG
         2JVMtMUPH05GG6Rw6oAaRNjdVMcVei6665LPSCYLb7dty+o1V3m7iLSzGkJ45XTNMTUZ
         D/zDuHzx0XAMJ8ugKth0weSOqyJoXzslMkxMm796Y05CLu4OUhq9iFbPGNkQL3diHwvr
         a54qRfq2iHeYMgEYqXyDxQ7vqylUpNWqS+AA3XrJ4lisgewsglPJK4uLxkmZRbD2PhEq
         TZPw==
X-Forwarded-Encrypted: i=1; AHgh+RoQyyC8RVEPGjFTwGpp2DwRaJusRRaxH0KFsWP8laObH0ilfAvvmnun6KOGhuq7UcPYAdddE3E=@vger.kernel.org
X-Gm-Message-State: AFuF++kMsXgHRR2L8zNUxC9FToccuoaUFv+PrPjtd2DWClQZVQ/Ko/nf
	HQsVglB4RcKSTApk2Xw3t0hV9nKlX9K6Kgkw2Zr8IbqNt3yJWU9b3MOFSOctiNhl0QMykYfJF6E
	j6MzdHY58YHhyTxU8rHh/HEzzWKtESPhijUe0
X-Gm-Gg: AR+sD10Dqq30mLsbVkNvWBZM972nD0nRiI+/uOnXmz+u38LYtba6m7qBOunaunptBbT
	bpe3imBB5fVJQMNW8HDQCjFVbu/46poS0xSLMKA3LM4+PETzCSP3+qAHuNZ9yytTU8gs0kvjL91
	z5SvYHN0Y/9MPbPfNyzPAzuX4Qlom0YtrQlDoeV35ayumVUHo/arhs+lrzw4v8Vqry+avIHgT7A
	6zs0HfAD5WCxZ1N8FvJWRmqUUd2lBdbIETpg2swfbgFik4PNWFbZPhxLme4mXLYAbHvsSN4D0IO
	ZJKiUFRIWrJqQCLVuIPHohkbTMfZ39zZk5gXRDxcnH1yAs+GEXL0Qf50Aahwjncf+A61Cl2BOtB
	Y7OvKeyGIr7+bY0lLJfSCmdriIO04nAqQBFNvHgnzIck=
X-Received: by 2002:a05:6a00:849:b0:848:467d:293b with SMTP id
 d2e1a72fcca58-851f9fad812mr34125434b3a.11.1787517536858; Sun, 23 Aug 2026
 13:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821091440.6496-1-junvyyang@tencent.com> <20260821091440.6496-2-junvyyang@tencent.com>
In-Reply-To: <20260821091440.6496-2-junvyyang@tencent.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 23 Aug 2026 16:38:45 -0400
X-Gm-Features: AcwNN1Vtdpiyi-mad4Kq_Ow6hY5unHMhUT1IH4gML7cm2btc5kpkQuUlRebDKCc
Message-ID: <CADvbK_dAyck-AsK-b1JYcbUXdhr7FR4ndQiYfNYkCxsu0F5tEg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] sctp: distinguish sequence zero from wildcard
 in reconf lookup
To: Jun Yang <juny24602@gmail.com>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 5:14=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> Zero is a valid response sequence after strreset_outseq wraps, but
> sctp_chunk_lookup_strreset_param() currently treats it as a wildcard.
>
> Add match_seq so response lookups match zero exactly while the one
> type-only lookup can still ignore the sequence.
>
> Fixes: 50a41591f110 ("sctp: implement receiver-side procedures for the Ad=
d Outgoing Streams Request Parameter")
> Cc: stable@kernel.org
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
>  net/sctp/stream.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c..cfca5aa 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -482,7 +482,7 @@ out:
>
>  static struct sctp_paramhdr *sctp_chunk_lookup_strreset_param(
>                         struct sctp_association *asoc, __be32 resp_seq,
> -                       __be16 type)
> +                       __be16 type, bool match_seq)
>  {
>         struct sctp_chunk *chunk =3D asoc->strreset_chunk;
>         struct sctp_reconf_chunk *hdr;
> @@ -499,7 +499,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strres=
et_param(
>                  */
>                 struct sctp_strreset_tsnreq *req =3D param.v;
>
> -               if ((!resp_seq || req->request_seq =3D=3D resp_seq) &&
> +               if ((!match_seq || req->request_seq =3D=3D resp_seq) &&
>                     (!type || type =3D=3D req->param_hdr.type))
>                         return param.v;
>         }
> @@ -564,7 +564,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
>         if (asoc->strreset_chunk) {
>                 if (!sctp_chunk_lookup_strreset_param(
>                                 asoc, outreq->response_seq,
> -                               SCTP_PARAM_RESET_IN_REQUEST)) {
> +                               SCTP_PARAM_RESET_IN_REQUEST, true)) {
>                         /* same process with outstanding isn't 0 */
>                         result =3D SCTP_STRRESET_ERR_IN_PROGRESS;
>                         goto out;
> @@ -816,7 +816,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
>
>         if (asoc->strreset_chunk) {
>                 if (!sctp_chunk_lookup_strreset_param(
> -                       asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
> +                       asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS, false))=
 {
>                         /* same process with outstanding isn't 0 */
>                         result =3D SCTP_STRRESET_ERR_IN_PROGRESS;
>                         goto out;
> @@ -927,7 +927,8 @@ struct sctp_chunk *sctp_process_strreset_resp(
>         struct sctp_paramhdr *req;
>         __u32 result;
>
> -       req =3D sctp_chunk_lookup_strreset_param(asoc, resp->response_seq=
, 0);
> +       req =3D sctp_chunk_lookup_strreset_param(asoc, resp->response_seq=
, 0,
> +                                              true);
>         if (!req)
>                 return NULL;
>
> --
> 2.55.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

The issue reported by Sashiko [1] is mainly a changelog improvement.
It=E2=80=99s not a big deal to me.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821091440.6496=
-1-junvyyang%40tencent.com
