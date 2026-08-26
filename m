Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C53B71A6
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733518; cv=pass; b=ikEcYQTWx420/g3xLcoSxI1DdpXk2srGie7c70rX4HcRbKq/tG9/2ew0qVU7IzmKssnGsK23Lmb5kD5HX1mi0e1xBLZRbQFyIkcVbffSo+MFD78qkOdJiyvxueQglW9SZRTYFBCc7GB705UVKTrvuCE1waSExltnsNK29Ek5FLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733518; c=relaxed/simple;
	bh=24N/sCv8A+Sgxe2K/2t202PGrqGrIdKpHKk5dX/bzXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai7kGVXg1vPevV7T7pAtQqh+5n9EUnjH3EiRhzIeakI0xiin9OMUER2ndr2Z9ChvZdXF3oKQQ9Em/MPDocgmANkf/6gD3y8cyr/RRxmBnYK4Po+U51f5cIxKnOyC47Js4gI1bB1Z5dCKRO+PanQFqJWBk4JqF6UcHz6Msu6RlI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=xLByd3BI; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="xLByd3BI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e507b079dso620387b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 01:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787733516; cv=none;
        d=google.com; s=arc-20260327;
        b=R97n/kHVDKiqYtpCVkfKVIeuayB5rYLgw69OlFf/rTzCqk++e9mxr7cNWLEJYEVRdW
         XgyFLhmAGZcoivLbwlz/qzCRtskI9SE3IKNzlUBSD1Hh+veYMs5jBW6G+UjSLc7Kp8tS
         WXtkbF9BJorm1YHK2Bkwh8y8dXyAPf+7NsUQroD80I74yZf1Beznp3V3prLcSbrfcaJ/
         1OK6xvrG5TM3Dz2lte9StciLifmHb9ODmYEqU+ZUwrenUEZOM6UxPn8lfJRouGItkrTt
         aMxOgA4YD/DLXnNLm/QB9dJPIkI+IpEFE3XdiaMUU2F+R1sSOp0PdcJB3LOfmYObgwtD
         S2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        fh=iiWNtmNKuPTuYC5yBTc/CxAhsY66ryz9haIkEMV30T4=;
        b=fgKqZfkSl/Y28S8q7YA34RLwkdmjT9KWDelDgb3ZG+kDPwUD4qTZYUqk6Y6iwdD7t5
         cwd1GgkbehyLIFsT4N/CFFXgwSueSlurV3lge/v6hBuTd0iASVeeayCrxyh1YLrnGfFC
         HWAV1C9Svvpqp5LPtNmglkE/+xBcGLYOsl4wqR90OrwLVdfiaBMotcnePE9p1cunEP5N
         KuCBfEictgOpxAFhl7Q3qAhVum7fHvZgXwpJtYRBKkUOvWPT02xVg8uEJY/aLY6qgnDz
         9pi1kGsbXJzHRSbFw73kKFIQiS/au8S6sYtMiEAxiB8X+jplnghUddk4iSiP2/xsd2pJ
         4Rrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787733516; x=1788338316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        b=xLByd3BITMnHfpPPRp1t6iTMC3n+zOW2xpgTPIYghA1Eo9Bz8J/E4rJ3FgfamuLe0Q
         p8ROXD8GlB5ZCTMXl9/p2+MO6XyjW9wOErU0j3cr93XcyjDTulQrbWAT84vrpVByW72P
         eC1VgLLLLhemAtMG1RCGCss6uY3x+N0XRiKyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733516; x=1788338316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        b=PTTsdurmGB+eg3NmiDrlQdG+qRrZrMIIHCxbs7ZMv2xhanjC4pGaj9JZzjPHXrnth6
         I1/bJM2n8ydcvhcjR3o3H90BEt7tVvq+VJ4oIl3oV5ZmI6arMZyOIVjk+/ooiQzcTkJ5
         6uK1UPvb6l5uNC5ok5vMCWZulA8WlIKihC5t4rCqaJTju98HpBDrC4wLY4yXJF4mlpyR
         Bo2n9uccfOxSU4/fiAzNxrJpPLEPGZ9w2TOLbB4fgubxdu7dJH079wANdEUobqtaMJ0N
         oZK0x3auvnLMfU0jpbaTfipDfqBzxavn4ro6BeXgYUwLd6W/Sm+86Zk4E1FjBc0edFWJ
         O4nQ==
X-Gm-Message-State: AFuF++mJIt8AK0qqCu/jU0kLH3MWhpvFj8FQhqmQcMeoiEbNeTHTENIT
	oP1AYtvok/BAxrwUw33Ue/GaeO5uuSXgCwUGpuZ5HeQGcO9bY8zdoUTclnbbtIl96kEeKjHA9Zw
	pQ7jd3HWiULM9Joo+4q/RKLj0jaCUST9F35qAwGQ2
X-Gm-Gg: AR+sD10j2OZ2kB8Z1V2KaO6lVQzzKT3w2ZEo9wrM0uDq5HWLHcqU0uE9BkXNKQLJo32
	GIjo8pqcG7El4OAQbkHjyvM6ecs78NF4kYMHM+nQaCI8dw3XeMciqueajZSb5xpn/HMdlqaLoQt
	NwitDtv5UB5NDZoV9ssoRvolvnbjzd2ud1zLAWmCXmtVIi1tzbTar/dGHI05rHytG8mTocqfFSl
	Ct45077UCDYYmKhOJAskqQKxZvPitRPnRchRamnnkTXYBnsHDqwBDsshuJDvYP6KnlswfzV6L4Q
	YWu00DAqPypldbkiIvKAmjJvnZSVHjZOt0sQ7iGS6x1SjA==
X-Received: by 2002:a05:6a00:1bc8:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-85372b9f5a4mr8970724b3a.7.1787733515122; Wed, 26 Aug 2026
 01:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826025123.62758-1-ljp1205831794@gmail.com>
In-Reply-To: <20260826025123.62758-1-ljp1205831794@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Aug 2026 04:38:22 -0400
X-Gm-Features: AcwNN1U5MQQ-Foz8JLEN1r_JLP27SIQF7hWiHU5_TAQqV-_hBURXNm5Fcz97j1k
Message-ID: <CAM0EoMnuw6C0MWvBiZTNYpQfr4hWccqUjocC-acBCC7h4h5e_g@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: validate mask pointer after nla_next()
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:51=E2=80=AFPM Aohan Mei <ljp1205831794@gmail.com=
> wrote:
>
> From: Aohan Mei <henrymei@tencent.com>
>
> fl_set_enc_opt() iterates the key's nested tunnel-option attributes
> with nla_for_each_attr() while advancing a single mask pointer via
> nla_next() at the bottom of each loop, so the mask cursor is driven
> by the number of key attributes rather than by the mask's own
> attributes.  The nla_ok() added by commit c96adff956191 ("cls_flower:
> call nla_ok() before nla_next()") only validates the mask pointer
> that was just consumed; the pointer produced by nla_next() is used by
> the next iteration (fl_set_geneve_opt() and siblings) without any
> validation.
>
> The mask's nested attributes are validated with NL_VALIDATE_LIBERAL,
> which merely warns on trailing bytes that do not form a complete
> attribute.  A mask carrying one valid attribute plus 1-3 residue
> bytes (or a non-aligned attribute length making msk_depth negative)
> therefore reaches the next iteration with msk_depth !=3D 0, so neither
> the !msk_depth check in fl_set_enc_opt() nor the !depth check in the
> per-type helpers fires.  nla_type() then reads past the mask payload
> and nla_parse_nested_deprecated() iterates with an nla_len taken
> from those bytes, reading well beyond the mask attribute (KASAN:
> slab-out-of-bounds read in __nla_validate_parse from fl_change()).
>
> Validate the advanced mask pointer as well: when the mask is not
> legitimately exhausted (msk_depth !=3D 0) and the new pointer fails
> nla_ok(), reject the filter with -EINVAL.  An exactly exhausted mask
> still skips the check, preserving exact-match behaviour for the
> remaining key attributes.
>

Hi,
In the future, can you please send a reproducer, such as a simple tdc
test. We test all tc patches.
I think you can easily add a TDC test for this specific patch and it
may even be worth resending to have the tdc test included.
If the reproducer is sensitive, don't cc the liists but send it to maintain=
ers,

The patch looks sane. I was going to suggest using strict mode but
noticed the fixes commit states it intetionaly avoided strict mode
with claim it will break uapi.
One nit: the commit message says "call nla_ok() before nla_next()" in
the Fixes:  but noting that that commit moved nla_next() to the loop
bottom and added the pre-consumption nla_ok(), but the
post-advancement pointer was left unchecked. Your description is
accurate; just double check if you got the right Fixes..

cheers,
jamal
> Fixes: c96adff95619 ("cls_flower: call nla_ok() before nla_next()")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> ---
>  net/sched/cls_flower.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 0e275b58151c..1cefea571efd 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1703,6 +1703,11 @@ static int fl_set_enc_opt(struct nlattr **tb, stru=
ct fl_flow_key *key,
>                         return -EINVAL;
>                 }
>                 nla_opt_msk =3D nla_next(nla_opt_msk, &msk_depth);
> +
> +               if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
> +                       NL_SET_ERR_MSG(extack, "A mask attribute is inval=
id");
> +                       return -EINVAL;
> +               }
>         }
>
>         return 0;
> --
> 2.43.7
>
