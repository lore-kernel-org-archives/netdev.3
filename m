Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151D26ED40
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511090; cv=pass; b=W4hrz/jzRVqM0Cce79HHV4WpXAVLrZ3FoG/cPycMqinUhJZL+h5d+5kST+pxqnj8PNlmfiAAFkWfeN9pL4HOhbRNugCyjyCt8+0FrYz3q3YqlX9n8KGZ+8UPGCQR9N29zpQYKfJY5UllaH/D2QIN0WkvXvJ/01SB+i1jWasPb48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511090; c=relaxed/simple;
	bh=C7Cc303QoAtASz0N6FKewrMzMqxqD+wZkax6oVSWMfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMSpQGzNpkPdT7yTZsdwXais54gdOEHS7n9OEln1pW1gsjRX8NaS6i5tL7cKy1vUA+jNg59GDZEtfvjNf1Q1CvlPgK3glG2sSLD0K+f8Axhk7aCUWiRs5e+KYmY1AI3AvCqOAnD9CfiMicNCW9jNKpR91ll4yykUI0deP0BdFDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2GyjvHq; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2GyjvHq"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485b358552so1287842b3a.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511088; cv=none;
        d=google.com; s=arc-20260327;
        b=bPFDXze0Hr3GEovzcZnBDBwiE5oRCpwY3NCS2USFmR8SrZRfpAPjsmcD4a5fPm2Y8n
         J7D+oh6Is9PJpzb/g6plsdBgrzwMmnPZs8+VXZuyCw9O2EN88VvjUUExhc17Q49kapPi
         b/WL+2wU5qeG52jalIVxPTpZsYMAiB02ofj19LGYZgzSM7nsMahY64RaXHndf+Rma8oa
         0ww0OTY0yfsb7w8LZZiQLW+dzhN7ihHzfcnU3Pn+kPtjJDKLNQY8L9Fpk3UfljZw0Ozk
         6AGNS28h/wdXv13ZDpzieTZdn6FLiRvB9OBkUrf+t7oz69Gd0O9Xt0nZQnmFQQ5IXtiq
         1oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5A/8t0GiaDz5Ne/xZDa7Ogn6GPJ5N8fZ1MQ3v+kZW1U=;
        fh=oLJUBoLeaCOIW1r707ZKh7+DNyVjyd8Nzfhd3TPyZMo=;
        b=TG4IZOHx+5s+mFwn4mphIampa4lNEyhBSWLS7TvVX/M1r6vB5H5jwED8RnO8KNPNLs
         pZcz6SBOtn3pmjDyKKzjOm7E8+zLHFpf2Q+Mz6xJEQlqs6R39V5x+caGMlmHzI2pWG1u
         5tzNpKC98I/8bqSPjBbDmeaH8k94avp+YUlyDFT9PdqQfxJSkoKzSa83Si1Rw9/305lE
         1M57fmt2MU04l65IiRVQ8MO3vreM/2s6XtIzujyxm8fGy+tS4lCtgaBdOXNE9HV+RKa9
         GZSBYo1KvbnJq1OIk7Oq+g4gBOwpJLKYUceavJ1YxXngnm+7RnHnBSqkkN7dZFfydes0
         pTgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511088; x=1786115888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5A/8t0GiaDz5Ne/xZDa7Ogn6GPJ5N8fZ1MQ3v+kZW1U=;
        b=R2GyjvHqJrJ15VJUSXVUgoS8l0ERMLGHtFH+0q8Qy6gjUPKoRQTrAWPJrZ7fbteEg+
         GeX2GYNZIY/TRw4GAYOd24ictW8nLuF2zrRtnlUFALsUVhkI0N+QmpTLZWNot+yzFsAc
         ZYydKtv7aK8Rg0+AFRuVwm+Y6daMYucjVvl4Ngp7B3GsdTgUi+PEoggNeYlZJK0WyYOM
         Q7ZxL0YnFW8MQNJypSL/uCN3ZZe35kbBoCcjoll/0zLpprCrtntVEqm4UAkKyeoEumDf
         oKkgiZ41ovcW0eXswuGBWD5zQCvIJgxLp97kcFnShZFCe37F/XP9VvVd4o1lPnSOB/Xw
         8Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511088; x=1786115888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5A/8t0GiaDz5Ne/xZDa7Ogn6GPJ5N8fZ1MQ3v+kZW1U=;
        b=J1ChVbZfQkKeqRLQm//FNQnWw5bAxRNAJQ8xOt8xlv9ZmLRJ+CFHoAYPb9g0McnDB0
         9oxaN0FSVD4ofc6fMTXQHmW92Ffz/blGOxOBFm2cl3viws0DW8x8cg31xz548bsP1IAr
         3wHsG672xG/XbwHuxaFYvEr25+dgR/wmGsYNB2iXjuKG7TfKQ5g1q9Z2yrULpgGRoleV
         qfQvq1btILi1Le7MUSvNri3ty8jFioAaixuL99yNTh+4MMbslHuEAYE0zdbiER3IoXrg
         dPGAkKIV8Jx11NnoLoPsNO41aUCILGDTKJ01u4NbxhvIKGCyrV84YYLWsxkAKEyb5keE
         GS5Q==
X-Gm-Message-State: AOJu0Yzu5DGA+18i8Sb7RObFjWm1rJi5luFDdsdU8NPuif+kcGNAaSWO
	ZoltbklYR19NsG32Bgu1DuCKT/I46TTo+HFmtT1/eQNu6xiY/EsSZO8eZFszMI9aX9F8HZnlzRC
	evigXi2El8OQy44vB7xOt6oBxDaPposg=
X-Gm-Gg: AR+sD117IRkiFBLQr+AZD/ZOZCC6Mceb6NWr4i4Y+xLXqZnFoogNTFpaaMmrgVbvaEz
	YonmtTNivUm8eg/BTsXrBfdhN/OvPaT2Diond1s+59TlbD3UHeA+rTx46p/v7Dk94KRChMopbDB
	2tKxT3vWNMXL+e1lLslA3wK/iL6/LsBEHvIKnCyjpekNTYwwnYoaFHG/OQuvc0fvb0GgNNAA7V3
	HyKNXr+ahHHWo7zE0hBaQ9a+TOsHSo1rmubfkNJscRxnXkpyuJnPDJmz7GQQRPj3pbST3XCBdxo
	NF6OY0mShpfYLzEuarLI2v/7H+5bdKQd2sg2ob4S57t7HDQ2/KdR/+giSAEa/eEKwgQuE4g1Dco
	9/KYVT/29gKrAFoHl2R5vivejWUp/1nLxDRn+4yBRnEpL
X-Received: by 2002:a05:6a00:178e:b0:84e:915:d7eb with SMTP id
 d2e1a72fcca58-84ee48cf36dmr73628b3a.37.1785511088185; Fri, 31 Jul 2026
 08:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730110225.37371-1-juny24602@gmail.com>
In-Reply-To: <20260730110225.37371-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 31 Jul 2026 11:17:55 -0400
X-Gm-Features: AUfX_mwAXs3VdnUx9IBNMuNpKz-bfEDTMCN_rlRbjGI-kve_yDusJgOLHI-k-3E
Message-ID: <CADvbK_cr33waMA=R1RgK5sW9+SQL1hq=W6BCv2sBTda-ttdw6A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix stream->outcnt underflow on duplicate
 RECONF responses
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 7:02=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_process_strreset_resp() rolls back a denied ADD_OUT_STREAMS request
> by subtracting the requested count from the current stream count:
>
>   nums   =3D ntohs(addstrm->number_of_streams);
>   number =3D stream->outcnt - nums;          /* net/sctp/stream.c:1050 */
>   ...
>   stream->outcnt =3D number;                 /* net/sctp/stream.c:1060 */
>
> This undoes the increment sctp_send_add_streams() performed at request
> time, and is only correct if it runs exactly once per request.  Nothing
> enforces that.
>
> The function does not check asoc->strreset_outstanding on entry; it only
> decrements it at the tail, and asoc->strreset_chunk - the only thing
> sctp_chunk_lookup_strreset_param() consults - stays live until that
> counter reaches zero.  When both outgoing and incoming streams are added
> in one setsockopt(SCTP_ADD_STREAMS), sctp_send_add_streams() sets
> strreset_outstanding to 2 and caches a chunk holding both the ADD_OUT
> and ADD_IN parameters.
>
> sctp_verify_reconf() permits a RESET_RESPONSE to follow another
> RESET_RESPONSE, and the lookup accepts any request still present in the
> cached chunk.  A peer can therefore put two responses carrying the
> ADD_OUT request_seq into a single RECONF chunk.  sctp_sf_do_reconf()
> processes both: the first rollback restores the original count and the
> second subtracts nums again.  Depending on the counts, this either wraps
> the __u16 or silently shrinks the stream count a second time.
>
> SCTP_SO() is genradix_ptr(), which returns NULL past the preallocated
> range, so sctp_sendmsg_to_asoc() accepts an out-of-range stream id at
> net/sctp/socket.c:1803 and dereferences the resulting NULL slot at
> net/sctp/socket.c:1808.  Other stream walkers likewise trust the
> inflated count until a later operation repairs or tears down the
> association.
>
> Only accept the response sequence currently named by strreset_outseq.
> Each accepted response advances that sequence, so a duplicate becomes
> stale even while another request parameter remains outstanding.  Also
> reject a response whose count exceeds the current stream count as a
> defence-in-depth check on the subtraction.
>
> Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Re=
conf Response Parameter")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
>  net/sctp/stream.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c945a4..b751d0843b3d 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -927,6 +927,14 @@ struct sctp_chunk *sctp_process_strreset_resp(
>         struct sctp_paramhdr *req;
>         __u32 result;
>
> +       /* Process responses in request sequence.  strreset_outseq advanc=
es after
> +        * each accepted response, so this also rejects duplicate respons=
es while
> +        * another parameter from the same RECONF chunk remains outstandi=
ng.
> +        */
> +       if (!asoc-> strreset_outstanding ||
> +           resp->response_seq !=3D htonl(asoc->strreset_outseq))
> +               return NULL;
> +
Hi, Jun, thanks for the patch.

Checking !asoc->strreset_outstanding doesn't really prevent the issue.
When both ADD_OUT and ADD_IN are sent in the same RE-CONFIG chunk,
strreset_outstanding is 2. After processing the ADD_OUT response, it
becomes 1. If a duplicate ADD_OUT response arrives before the ADD_IN
response, this check still passes.

Checking resp->response_seq !=3D htonl(asoc->strreset_outseq) may break the
normal case. ADD_OUT uses outseq, while ADD_IN uses outseq + 1. If the
ADD_IN response arrives first, the check rejects a valid response.

>         req =3D sctp_chunk_lookup_strreset_param(asoc, resp->response_seq=
, 0);
>         if (!req)
>                 return NULL;
> @@ -1047,6 +1055,8 @@ struct sctp_chunk *sctp_process_strreset_resp(
>
>                 addstrm =3D (struct sctp_strreset_addstrm *)req;
>                 nums =3D ntohs(addstrm->number_of_streams);
> +               if (nums > stream->outcnt)
> +                       return NULL;

This prevents the underflow, but it's a defensive check rather than
addressing the root cause.

I think a better approach would be to make strreset_outstanding a bitmask
that tracks each outstanding request type independently, for example:

#define SCTP_STRRESET_MASK(type)        (1 << (ntohs(type) - 0x000d))
#define SCTP_STRRESET_TEST(asoc, type) \
        ((asoc)->strreset_outstanding & SCTP_STRRESET_MASK(type))
#define SCTP_STRRESET_SET(asoc, type) \
        ((asoc)->strreset_outstanding |=3D SCTP_STRRESET_MASK(type))
#define SCTP_STRRESET_CLEAR(asoc, type) \
        ((asoc)->strreset_outstanding &=3D ~SCTP_STRRESET_MASK(type))

Then replace the existing strreset_outstanding increment/decrement logic
with these helpers. Especially, add a check in sctp_process_strreset_resp()
like:

req =3D sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0);
if (!req || !SCTP_STRRESET_TEST(asoc, req->type))
        return NULL;

This way, once the response for a given request type has been processed,
any duplicate response for that type will be rejected, while responses for
other outstanding request types can still be accepted regardless of arrival
order.
