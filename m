Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590174;
	b=v6oeihmF9MUrbZ3QmmvkPguyPnB+mXuTfFLkkkRJKo6WGtp6BZWrlV+5uPcosJmCy+NF
	 FtXtEQaZqrdCPfHKEBp1lv5lhTG948xYB7xhq0dsFovvv+XfRZB1MW/Xz8jRyvm8hle62
	 YJ/zxr146BY5El1yA0oTPM/CnH5yvk+0jfLx/QxT+KX6qdCoSJCrIPQVlGTWNPnbUbwCb
	 BiVaaobIaWtBcPBg+b+jWNg0pfsBWV1viyrcAW4/6f9Hf18pI0xWwwdk0oFY9eojxyyl3
	 dbWvrSVs3z4TZ9M02NY/gLo/ZbwOISLGW2NkwzHAbg9I6DkBILEoGrSJQzTMXCekTXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590174;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Arn8+K++I1dg9a18y21WepmyzobpDI4T/OMbR7Awn18=;
	b=Nj2O0V1VhCi3H3OWOivzxlT0VCBeYUuI79Gl93Kq18QZG3WOXRHEPhy1gmU2nmFsBwz0
	 Kt7nnKYFI1tO9ErF5bjTAMtqmkEx12P88FnyQbaROChHRjU5wVGCcN5gulxikcGccBgNd
	 eU66dpDI/RHYdqcZ2QgQrEZbTwNa8pyG2i/BWGjUJYjJv79OH5vQm9MVE4+Q+qolYqLGq
	 LBSE6VMyxyMWrvY+b8zZ37GDfThvGcaVSrlXBuJEDAnFJg7YuP0EmMiEdaKmClkopExes
	 NVO/nHnLCRdMkZ0hPEBy5+76CTNHpc3TaaWLxStaBg2au8ToUBaZk1MY3omeBR5qP0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+jSdQ0f;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lP67IOnr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+jSdQ0f;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lP67IOnr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792590173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Arn8+K++I1dg9a18y21WepmyzobpDI4T/OMbR7Awn18=;
	b=d+jSdQ0fTFGbdUyP8bXXnFi1y0iouUz/8P75/gqMfHOVi68k7po1ud1JppRHlbROMjBJho
	mjNV0yMvTg9QYyn5I+IUjMUP0gW0NKLYHWpbvYDugj0sSWjiaTKR+pAInCZRZweHr4+DIM
	2lSADYvhCd+4ovH1LC4rXiQQ5mAc4Ew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-ZXsDCwF1Na2oR462YgFRzw-1; Wed, 21 Oct 2026 13:42:42 +0000
X-MC-Unique: ZXsDCwF1Na2oR462YgFRzw-1
X-Mimecast-MFC-AGG-ID: ZXsDCwF1Na2oR462YgFRzw_1792590162
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so433219f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792590161; x=1793194961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Arn8+K++I1dg9a18y21WepmyzobpDI4T/OMbR7Awn18=;
        b=lP67IOnrQ1yivLQC43oIqrUyyjDrYOv9ayL2QZQBv4ug+thRjcSf36YBavzPphotsn
         w4mOvEa10ns9DZzxninOZ0MiyMIru665JtAgQ/AqPX3RRkL+TTtG2bKk5jYnDXGUj+Vu
         jxKjDlu72/7ZInKUEfxigSte2srRiUYW4WISdZKSyxmasYxVVgH7LPUl6ytW9OB6k1u8
         +hJyG/ZeYUAt8JJ/4b66kDjvWWsxgeeg27yIN4iLcMUDOh9csQXaMMD6eMQwoHnYSrsQ
         A9+/ng220Pvy4QU7jxaJ4/zBe0fLX6wtMHrfDfErV1ZjpQ/YfPrXihJMFkcNP7GCXXOc
         UzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590161; x=1793194961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Arn8+K++I1dg9a18y21WepmyzobpDI4T/OMbR7Awn18=;
        b=Uem9b++9Vpw2dxNEpsT0nCI2BuBnmM82X3pIjKce98wFx6DeUKbJQ1fYCGfxkw+Ntz
         yIoiRWD7iIEjLVwFOECmjgXVVwwMIsGG6zlAdFhB87pW8Aa940ZCd54aCj4TJvLWd1XZ
         BfSEqr2cNlMZ57yuSlTW/oCFMZElnpmnzXJMCFET78eRYvVgrReYeYmwRpOFekHwopma
         QVwcQHeSV6yAO5lvGh1QeHoOWmXqpX9kZqexgYITm63XNwoaZ2cE2Zt241Lxx54sa0li
         nlg2pSQVRwxwRVXMHJUxymIiXOB1x4gBqdkPrVyFPlLQ+mP4RarxC8e9X0CP8+3lyrNH
         JxZw==
X-Forwarded-Encrypted: i=1; AKwUvByEqtu30e7ifnl0GL9Vk5EjaWkyYE588jus9pjp2XSFWtbZgRageu0v93CM/k724mG/yjgvVZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYITPApSgPW7gmlKOZhoK1rSP4tM1EJShGcYU6lghPE5NV6FtG0v
	uy43jKncWqbaXFt7peL0VcoLYB10ve3ecUNCamKKAex4MykVOVC1650ppwju2UJBDYgboz+rPhO
	k5Hta8/4fP8JSPvJfjyrtLGG3ZQnUHPPcD3v4aklOGapqzEB+UMOK4POo5w==
X-Gm-Gg: AYBFou1eGXMvHt3XRvm30EoSWvQ6A5GA1T/rHUWG/aYl8uWJKOO3q6kuKPj5VsDdOJQ
	9r0Kml8LYTw2vOueV9M+CsN6btaxv0+/AsLAQtNLDLUfacszXm4hgEqWIZhNo01hwoQUlHeEdFT
	dTWVp1HuozEjUJcwBdv79HHLrvU/lzve2r8qE6ZnqmJCn2wyxWOCtAIQFxz9usQLWfj16w5fhAO
	hbWIgIETEANqft2p4EQIxIHZYR5z/2q34ZBSRUG7/zcP16q5v7Jg0oCUuDpBSHeof0m+7/hNTIQ
	zq18gWzSjPcKlGka7SYWDDKJkMiHTsYzM8cy3LHC8pT4GFjhRBdLDyOpzuVxAqnJw8Nrs/BPrsO
	mPBhjHWsJAGKmlk5DaFGlXCmfQW5oMVBPYGSq2cEC3x3PH4Qo/ryyH0vdAGPaHHTXfyOW9g98PA
	==
X-Received: by 2002:a05:6000:230b:b0:48d:ee59:3a30 with SMTP id ffacd0b85a97d-48e264b6937mr3990685f8f.22.1792590161622;
        Wed, 21 Oct 2026 06:42:41 -0700 (PDT)
X-Received: by 2002:a05:6000:230b:b0:48d:ee59:3a30 with SMTP id ffacd0b85a97d-48e264b6937mr3990623f8f.22.1792590161148;
        Wed, 21 Oct 2026 06:42:41 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254ef1bfsm5887490f8f.6.2026.10.21.06.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:42:40 -0700 (PDT)
Message-ID: <e0f4776a-0457-4069-9f79-3c97de2a54d0@redhat.com>
Date: Wed, 21 Oct 2026 15:42:39 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/sched: em_text: pad the text pattern in the
 ematch dump
To: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Cc: horms@kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 17:01, Victor Nogueira wrote:
> This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
> stack infoleak in em_text_dump()"), which zero-initialised the dump-side
> struct.  Sashiko separately pointed at the unaligned pattern tail on the
> same dump path.
> 
> em_text_dump() appends the text pattern with nla_append(), which is a bare
> skb_put_data() and does not pad the attribute to a 4-byte boundary.  When
> pattern_len is not a multiple of four the skb tail is left unaligned.
> 
> tcf_em_tree_dump() records the raw span as the ematch entry's nla_len and
> then writes the next ematch's nlattr header at that unaligned tail.
> Userspace walks the list with RTA_NEXT()/NLA_NEXT(), which rounds each
> attribute length up to four bytes, so it looks for the next entry at an
> aligned offset the kernel did not write.  The ematch list is therefore
> misparsed as soon as a text ematch has a pattern length that is not a
> multiple of four.
> 
> Append the pattern with nla_put_nohdr(), which reserves NLA_ALIGN(attrlen)
> bytes and zero-fills the padding, so the following ematch stays aligned.
> The emitted ematch entry then carries the padding in its nla_len, which is
> what NLA_NEXT() already assumes.  em_text_change() only checks that len
> covers the struct and the pattern, so a dump replayed as a request is still
> accepted.  This also removes the last variable-length nla_append() caller
> (sch_gred's is a fixed-size, already aligned struct).
> 
> Conditions to recreate the bug:
> - CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn is
>    enough)
> - add a basic filter with two text ematches whose pattern_len is not a
>    multiple of 4 (e.g. 1 and 2), then dump it with RTM_GETTFILTER
> - the first ematch entry comes back with an unaligned nla_len and the next
>    entry's nlattr header is written at that raw offset, while RTA_NEXT()
>    reads an aligned offset three bytes later
> 
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>   net/sched/em_text.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 4132f8c3c5fc..fbf78d61f109 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -125,8 +125,8 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>   
>   	if (nla_put_nohdr(skb, sizeof(conf), &conf) < 0)
>   		goto nla_put_failure;
> -	if (nla_append(skb, conf.pattern_len,
> -		       textsearch_get_pattern(tm->config)) < 0)
> +	if (nla_put_nohdr(skb, conf.pattern_len,
> +			  textsearch_get_pattern(tm->config)) < 0)
>   		goto nla_put_failure;
>   	return 0;
Sashiko suspects this can introduce another issue:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-7SHE.v1.r0.20261016101330-1@mojatatu.com

(the 2nd concern)

I think it should be addressed in the same patch.

/P

