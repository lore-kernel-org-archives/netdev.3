Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E83A9013
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168663; cv=none; b=rbGlRBK3ce9zkq7MdUDiTvDKhc7YKgRXG59n8wIkSJhOIa7eelmg8C6GuiZ4NOznCPzfZQWcYdOpjsWunWyi3jN5BUskzaWTtRyI070ReDrsY8luNbIA/8C1mqw+YuoWIOKvraYxYFR06jSGLlCrMUDu4/q6sEv4GTY8++fZFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168663; c=relaxed/simple;
	bh=Z+QxkOwZTebWGhdloR8z3hb4zcv63YIqdGCWwtqSb2U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KZ85Ou4PhgSAhXXBSBz/aIFy6BKS8D/q2d6B3DBIYMqsv2sJEJqUssblULE3t66Mxc+wZN5F2mHyrekQJUiqlR4l7jHFICBB5YkjQpQXNW2u64WU0JKw5dA3UuWkO15+RTZHwzezIssb8PmDJEa2GZ416W1tGcLQpMBNstaoXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=badCG73v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="badCG73v"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1794515a91.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787168661; x=1787773461; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6dToT+SoDmLEhppV2wNvfcF6U10Bdergy/VLIZNHkt4=;
        b=badCG73vCRYVe1YP3HK9FiIn0uJs1oNxvR1OIM1CQjlX//4TvTt4THJ6ukicyoMsjf
         ih/cThNAj5x1oKK5JfWoZ+HJewOUWWWPoI5C+Of1S6DKyR4SsNg64x/KAyKyGlZXjhum
         HsUf9aWnLB3NXSS7odeXDtASpsyoKsfg1AeUi0+/oDYX9R81jhlNWy20yr9CpcHBNyOr
         XYE1h7azgJWjzDTrqmWBvTkS1Uc8RHh73922p1QfMrpKYkipwEL5abfNQ4BfcgCnkwA7
         RB8HXJ8fdqe+aBDg8jboZvLYENJYM+pRl1VpnQvGFxGbAFf7Woy29iys3O5dkU7g3+Hf
         XIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168661; x=1787773461;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dToT+SoDmLEhppV2wNvfcF6U10Bdergy/VLIZNHkt4=;
        b=dgNivuQ1dFxlZ1SX6WJGuiekBBcJqpLFcWFouaDY14SkBqO5rLg5uqI7hcIDQVvokj
         Jy/MIN4Xl7752SmNYJ9YTCZXTicPmOCFDvJ2FYC/QwL45Oxf/0lBFff1g3Bc2Yq0JX7z
         IH48F6J8Ullezr5S8tHWNkwxxyCyFCT+W5o9/Tb87tDNDPj8jTyrvIq7FRFkBEKnA07j
         zHEZSFhmvw54/TmeKi2cVJDVlfAKjOBIiKc3nN0cgmn/3PCwrSPuDmo/BbyYEf8kdA99
         x6n3aMFxtZtQe9se0BG0wukhLFk9X6+jRagjdobsVBAXbLxcBuQtBDU23dDA8MsR65A9
         o4Vg==
X-Gm-Message-State: AFuF++lnczGUk2ediPgM1J7PjCNVVz6cjinDiBBqenLBpYDiDd2Swvge
	cL4JH1YYM67mg6iGS7VXYHJMmHpMKW1YT7uYktgospcqaFSr40FMKZcG5BLIbPQrxI4=
X-Gm-Gg: AR+sD13vac8rBekiiZ5J+7LbM0xYUSHH/IcGzlcX6/UIn0WjMtQifOPy/uD6jMFGwyz
	uEl/L37sIdAvvi+0wHTjdgQX6ScB7B94JTmlVchZfdsYOxMOWpSP8S7TYoba8xAhDKftgrZltU7
	xYaqpSwoOyX8BSsEiEz4M7y7xgf2OX0zJXq9dJJUvV0QsFIjnh/NppqjsUwYbwIE2rHoY1rXTkl
	ocvtIj0hJu1lioUFV51O+O3YR375XNLlk8rOnfJABaud9rUW26MvjFEqd/0ffXZLR1Lwui3aqo7
	WG1y3fYa9QrEo6UG+IVHbQrkBb1Xmsg/pc6fyCsJ7CfynRduLUt00mAIVs78VlmqYIzxaaTdEPq
	MI+qzWSRtimicr2v14lluV91E4ST/kMaOPWOu5qQvep+eEZKiukq/XRj0uFQYPk2jRDjDqTVzUQ
	G3O4e0ceweVq97/Om5vjkckVKyGS+xO3+OO01TDawlT8x9WCVzndSfuGSDwQ6WB+KJK/qm90t5X
	lsjuoxUwJ/sVVt9hA==
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39580a80a65mr13110595a91.4.1787168660704;
        Wed, 19 Aug 2026 12:44:20 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f82097esm1646692a91.2.2026.08.19.12.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 15:44:19 -0400
Message-Id: <DKT6EZTQI7LB.3ENA5VQ5OVMNQ@etsalapatis.com>
To: "MahnurA" <s.mahnur.a@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>
Cc: <netdev@vger.kernel.org>, <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_sock_from_file
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260818174253.492196-1-s.mahnur.a@gmail.com>
In-Reply-To: <20260818174253.492196-1-s.mahnur.a@gmail.com>

On Tue Aug 18, 2026 at 1:42 PM EDT, MahnurA wrote:
> bpf_sock_from_file should not dereference a NULL file pointer.
> KASAN detects a null-ptr-deref when eBPF tracing
> fentry/fexit programs are attached to points such as
> __mmap_region and file_map_prot_check kernel functions. This can
> result in a NULL file pointer flowing from context to the helper.
>
> A minimal check before dereferencing can fix this.
>
> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NE=
T")
> Signed-off-by: MahnurA <s.mahnur.a@gmail.com>

Patch looks fine and the crash replicates. Please resend with a full
name since we don't take pseudonymous contributions. Once you do,
please feel free to add my reviewed-by tag.

pw-bot: cr

> ---
>  net/core/filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..7c3caae4bafc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_soc=
k_proto =3D {
> =20
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> -	return (unsigned long)sock_from_file(file);
> +	if (file)
> +		return (unsigned long)sock_from_file(file);
> +
> +	return (unsigned long)NULL;
>  }
> =20
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)

