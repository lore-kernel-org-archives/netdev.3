Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BE43499E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468874; cv=pass; b=m9HX6CGICaaBg1dKnTNUAOeTmEd7RnuSZdQm3oWcMQwfx2sEFEyfx93M1XteXQFnqfc230VO15dh1nhCFKOskQ+S37XNdFuYrRbO9A9J56UVojami7kyiqrwG2TdSQmrKVHucqBGO59I/aWIMqfM3uI4PNJTOYikcl+y/y0uWgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468874; c=relaxed/simple;
	bh=n08CimJMEJ5UEVPtxtHuCEJMrXvySiB8v3n8L518G0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx3tmx+nlk+qyk1IRnrvgpyeNEGvX9zx7zStmaexGiJ+mIx7WXyTd9xkVp3yujMsWHREVnYL0a5cmiY+zmVAo2zFOCAv79ypaAtaMjR9MpoLyNQp0tr2uzmsHGXDKCuKlCPx+LFiviTgLuCrYjOk85Co2MVJB9KZhn3uYcM+yJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeuPWxYs; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeuPWxYs"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso12617a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791468870; cv=none;
        d=google.com; s=arc-20260327;
        b=iecOIrqcZ8q9XnewQelwD35Vr64WoxdUfD3AqOmDB3OCQi8VesanPJS7+20/uLjw1Y
         91sFPifyyagAxIumDlzsRLnixQJVuGcfMt42bOEqcsDG5GSvduHxjRndePWyUTC2U8aN
         NP0/hS6jIPqOQAgrRwqzOfG61VwCZUov9/uXCHKknAzm9sf7y0Sw35iEizOWPiZhuSTo
         5GnHuV5l4pQOSJMtk5+D/2IGS/hGsofKI2UJKCM15V5/WNcnRcqsgCJeEhKn0BF58qLz
         0A5aqFkjHrBqUSgs2dvEBiHbRa3vatNJkO8CxEoJZrTqOUc0iatpO+o8Adk7SCgDq0UX
         dVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LbNNkCXf2kCL8DlF2FAyZ08jK056pSr7lNZgoiWIQU=;
        fh=Kv67+eHyCIZpuvICY5EZ6mv8Ou3bO2ERaYQsx4stBYI=;
        b=U1ZBxQ/YdBczFi0y5i7qrOEp/iWkHC6mmNpq9ZFZf/jaudX4hyEkNPD24X/FbKr5Jm
         zQGI2Dv/gUjofp8/xnQGIOPDsR6WIxUK4NlPIwXBfKP/ae8ULNj8MunZiZ2to/4v/bG1
         5gl2IenjHMijvLmd9DkJ/qdWzgcXBDl/l5sXy2zSAYNx2w35iokJyqxvWg1CACY8cjdG
         +sDpBbA/jJU/ZVsFmSA3cNvZp0s37PKUEvJsw4jAZM6DoeVE9vM3wlDtWiyPNslikMuI
         GHUndc3MgxAlymphEe8zYy1rBV9MbykFxYLXWn1TmH78cwWcmxmyD/047w//9sfnu+d6
         KGaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791468870; x=1792073670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3LbNNkCXf2kCL8DlF2FAyZ08jK056pSr7lNZgoiWIQU=;
        b=CeuPWxYsp+eRMj68AFUXEgm8Na5s4Yi/Go+/iN46h2mCXMiKusMG3M7kg81zUOWojz
         D8Rkt2m+IGWZyUJZ0UZaQSShV8f58Upd2xXlLra8414MCcK7IHXSYnqsKl6x0Lwicubb
         jDva2v57T81Mb838RmHtj1/FJC8k9+xt9797AyH/ZDaOrfNdByIKGq6V7Yhc+NMZ/Dw9
         sy6O7bYLQ5Xg6CUGc+XyX/zJVl0LcLekN7su4WUhD5faG6+pOfYGm3S00msuzYzDoKtX
         80qe9PD8ulCTapBzMwcnjDA9OFd34S595fxi5T/JFKnd3FUXlgWU28iHm5TjyBYg+ogU
         hK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468870; x=1792073670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LbNNkCXf2kCL8DlF2FAyZ08jK056pSr7lNZgoiWIQU=;
        b=FzLG8JqZpSjXXStMY603FPgk7fXwlEtm2GpRYAIYSQJq832r1jPPq3nZgmRSw5oOkT
         umSBuE7ijgushZnklhz4ocI8PnEGVQIIOWqIg0vxn6D2NHrNgaadB8w8SF79mq6PWIv3
         HGCqSkB2e8dFfrU490qI0teR3AK7EvMxTqUpbEs28Z7PMqpJBlWY5ZH1HmUryXK5FNVa
         CZXNnxC1AP1JZobNs/FKaf7C1SaCcljcqK6PBJgJTZhkCBuTF/qvT1bmPSJi1NVkA22N
         xBgHNBZ8KnART+Q1KXpxeqV5vcTILUoo7lL2rkvZVfbS7LxtiEN5M1bK8bWVm3UhW3Ms
         RfgA==
X-Forwarded-Encrypted: i=1; AKwUvBw18frx5ftXCdjJJEef9eHHk08lvu8nvuekUQz02pIkypvnOUVXe+9DRJD1RzBZqlPMScL+EJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdT3+WzyeoDw28ySR7bHhrKG5TH5SrSzUn9gQPXOIlGjx8N0x5
	2aJJeTSbxg+DK3GQ5VqczlSQ50CiF/N/TLhQ1qFhAuKr8qgRnAyog+u/Z+VI7A6cKrHx/BUSCpe
	MCxvodBuCeM4hcQnRiqmDESX1ZvHohCeewkbTTQdt
X-Gm-Gg: AYBFou2a7TIrOugpf7wBKWTIWINQTT2dHO17NiNU2m4zd4kfrM4hfFnp4sxPcXXbWLm
	6SXP1LkcvcZcHEP+Oe/ZT75RzHadA8URT+vHHWSJUSTDiOcHSGhfIumzwUykw1NGV/bTsTBOG+N
	57/sdH3zCDTeOydM3zSBTT0ULil0my5wgmalzWXFWDveKBs/cNEE8qg/sKvPsvkhteq3q1LCY3Y
	pJSI6/IlMPUOtVCfdBvgW4UzlxnM8HV1OiuOAdAXcA9gP7TupTk404NhsRLnGsq6mWkIos3DVhS
	8WBpu/DW3trFOV9xZN/zW1HPi7CW4OLMcjYbR7RYOnNU2i9yabSX/CMBb9arLDueNMlffFdbvXw
	CBETE8dLnX/ZAYp5CPaNw8D5XiCFDQ+0golbJ939VQCLbmQ==
X-Received: by 2002:a05:6402:148e:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b061630034mr48613a12.9.1791468869959; Thu, 08 Oct 2026
 07:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008133252.3750-1-nashuiliang@gmail.com>
In-Reply-To: <20261008133252.3750-1-nashuiliang@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Oct 2026 10:14:07 -0400
X-Gm-Features: AclHuK_MTOq8kFi1WHmb1La130Qi1Si9uyUpIl2JmODzfEJEsh3lw3UrvyZQQhU
Message-ID: <CADVnQy==0Vor90buiY8U+DNYKjxyWRQ94zAq9=aKhyAezsB9Vw@mail.gmail.com>
Subject: Re: [PATCH net-next v10] net: reduce ARFS flow updates by checking
 LLC affinity
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 9:33=E2=80=AFAM Chuang Wang <nashuiliang@gmail.com> =
wrote:
>
...
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D rps_sock_flow_sysctl
>         },
> +       {
> +               .procname       =3D "rps_feat_llc_affinity",
> +               .data           =3D &rps_feat_llc_affinity.key,
> +               .maxlen         =3D sizeof(rps_feat_llc_affinity.key),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_do_static_key
> +       },

Having "feat_" in the name of a sysctl seems redundant, since most
sysctls are features.

Also, the name seems overly broad, as it could also apply to other
RPS/RFS mechanisms leveraging LLC affinity, for which we might want
separate sysctl control knobs. I'd suggest perhaps something more
specific, like "rps_llc_affinity_for_set_cpu".

neal
