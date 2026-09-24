Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352843B9922
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242552; cv=pass; b=gD75pBsOUsad+UiGzp6408Tq5QmRtRmx0jEJQ7ypvFGO+eoRgT5s4i4fo4n47lDew/pnNE+NNrazyrZz//iRgS5gdpEoqxQopWAxyKz1GYWTyfRPeEQbWE2EDKHUiTPyPXfPPoia0eN9tC4eZ7MCdf4vns508skcNcxd+MREo0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242552; c=relaxed/simple;
	bh=nWVJkgh6v0OqckNbFT0DrWjVwyF8kZpU9defMGtQRv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG7Ur/DY9ccKkBrhP666pJu1+i3w97dWHhKxkwr96K12qPLjFnor8URxID+o7/BOkri04YcukoJuNPNYxisO8WLcBwdqtPMM99lHOPD8IiogpR23lDhcHbXwtembj3n/P0Z3j8yWaEaR7/07goTZSJmVdV9B+2RdYrwYX41ObfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pgw3UzkS; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pgw3UzkS"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb76ec504so11737661cf.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790242549; cv=none;
        d=google.com; s=arc-20260327;
        b=LbIQCrS7I6hGI8Tf/vG0ntwhagTslzJAU/wpoErQsl53mQAbM/AXm4zo4eTORWrSd9
         WfU1sr8AxmbqwHvO+PgtQPJgM8PeVDbUu1bgEiFc269jSGPG/TtLobPw3dTDGlyarSHo
         +FgLTFMmkmqe7nyVodjOiUfW5KRBi7LzvbgeOkAwKIcci4YFBQx7rMklx66ZCL/yHDc/
         n7HJFz1m4fIa5RDmhhSEA3eOHQp4CYL+2KOO5gEufKNYYMkrI5aZJC7zduVwnIGbNFU0
         0H5LaOIqtjlzF2VRl/NW3dlGrbFqAPfVcoAzK8knbjw6geBDasor1ttdH6J5MqkseeCg
         uk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dObnSyq7Q524W//2DcmkBmFSB16ZHOQqAqIVcmv+gqs=;
        fh=+zkx6QabisdF9Xa2MXRckZj6KM/1ZvzDZgBMUvzdahU=;
        b=KrpBiyqECzP0ccwuvuQ6ijm1eZrqJGokc9WyR4SKwfjTQ9225Jg+78Uwq6COqm3w/p
         q94BItCfY38+x4MzpWWBXoOHLh1KTkczlRvNbOidLhNzRX3O8my3nE1cGigG7FzwiiS9
         Y8TBqxxy93o8D/5ksZJ+l7ieBE5FQLS5EvkU8duOF0hExm8iqBDM+Zwg7wEQi+ak/Ri+
         vLCl2hcwGK7ZRCNjx5ulm/Eb2germ/jY/YILgF/SpGT03hcXRJt4PPaepjsD04H0GyWm
         Kuc82gF5tF1whsCtgwIGqGjZnmcqzEfp/yJVxv1etKM17FeuSJCaXM4AogUVoRdoKH+s
         R2+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790242549; x=1790847349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dObnSyq7Q524W//2DcmkBmFSB16ZHOQqAqIVcmv+gqs=;
        b=Pgw3UzkSS5G509XDtJqprYWpMHuzkjGDqg5X7dxV3Dp+WSB8ESX59+UK7d2SHIYtK9
         HImH8TuzIeP4jOMVt8K1+R7goL2juDW53mGSZI1DwLU5TJD+gHRhbLU6wROxDO7DBZoh
         9ocuP577Znz1WXMC6p1Nmm2WNnR40JrRtTpIUduOiPYMwri/OBunGV9jZ6Rd9kF/Yxzj
         Oo+1LUdUwJLqcgrjIectGJDSH7l+yJ6B12ijGQTDAZjFAU0DDXpZIUzI9rnsSP51D4wQ
         tWqPwpQTPcEJIMFVgixtq0D5hhQfGg9Gk7a0VPJ1+ND/cDxyLZiKwCkq9tW1mnF49zdz
         MkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242549; x=1790847349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dObnSyq7Q524W//2DcmkBmFSB16ZHOQqAqIVcmv+gqs=;
        b=GAp9NqGZcwmtRHClX4oUOyNQnNEEfU+qTg7nEOUkH1lPPzxUm4iQPsoxsFQbUsL1wb
         1smUKkyvjQTdFfSXfGrWfnrtJfxpHHSraY+aQH5+3o+UAHHDjXeER4FZYVPny7OwHYIt
         DTjly5Ba0Qwi0IdHVWNcFYtvgIJ2NbcY0NaNlf/U3epENciqqDhgDT2IvKK2Yb7rN953
         +nsH9t9EI8uIKJyn5F7f6tmit1+FlD/wn8fusxNjOSDrD6IH5UP0/y2nLQKBYe4dOER5
         aJXtcgJLwtqkgstyb+vNXQJU8WTyXp/66762UEBThBCd5m3NAjn+zcRmtBJQ0OdTdnms
         BKBw==
X-Forwarded-Encrypted: i=1; AKwUvBy1V820SIOB3nPrpBqGbnWdtH1NwNsMwvwrAYq1so86GsS9WtAcQRYKTcnPjWON2rWOWIBTsKM=@vger.kernel.org
X-Gm-Message-State: AFuF++lgstREeI4vrUgvzTtl7CXOPCAp+RgfaoDBj5anLYaGmlTe8UhG
	546XZphRu31HZVSxIimnQuuamTfDzyt2Y+PnQ4W3Z/BjmVjv26eA9DuXYXbs7h6cU4OuvDnkfmX
	ffczDlGE45RJz3SKir8q+m4VTfYvWYyZLklMv5HjB
X-Gm-Gg: AYBFou1M6nilRQQOpWq5aXsaoAVVq4mEIg/Wn+yuplCR8CdrI4q5Dwr0C9NnaanSyCG
	DFcXmG1ecONcypFcDA4fxw3S/jFS6zmKN7idIYtiKqQRgLoujpgDck/zk+iR/tRTIaNkkZO9AF4
	WcbXJO53c9fNPg+Rp1gC6BXrlpgdNkDBtK5r7mZrV9+Rbls/KgYScW6X0rUQJYaF0+mQwD3k6gZ
	SyRVWZKoxFtKllyJP0V3T6vZa3hlcizT0m3YpON57dHwdLCyoc69cHxFV/WLsJx0cbQDKv2EkMl
	3KJ34LtFpwb3L1PANGVjEiY7XIF6n+UZQIoB4Kh8NVTrwejOkK91fca7bIhOIGid0YRJb6FPwKn
	IQunqDq4EoyeQXn0sWLsmq7ShpSTmYKnk0UwrZreTWFHWiz7Us3o2RttqK/NN1AaDi7O+
X-Received: by 2002:ac8:5e4e:0:b0:532:ddf9:c668 with SMTP id
 d75a77b69052e-532feb25f4fmr13958811cf.53.1790242548221; Thu, 24 Sep 2026
 02:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920063419.3587332-1-yilinzhang@moonshot.ai> <8a9dff4063a2745653b7e88ceb745d75efa16e68.1790224474.git.yilinzhang@moonshot.ai>
In-Reply-To: <8a9dff4063a2745653b7e88ceb745d75efa16e68.1790224474.git.yilinzhang@moonshot.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 11:35:37 +0200
X-Gm-Features: AclHuK-rRRv07fF_euLQdzkSjhzPwlSUWaftcxHkR9xtjqpGBEK49dFgtxnRZ_k
Message-ID: <CANn89iLaofHpg9J8to+H7Z=Xs-rZfseziNN0vXBkE8zJ8DQcsw@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kimi Security Team <bug-report@moonshot.ai>, Weiming Shi <shiweiming@moonshot.ai>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 6:49=E2=80=AFAM Yilin Zhang <yilinzhang@moonshot.ai=
> wrote:
>
> When tcp_send_synack() replaces the cloned SYN skb at the head of the
> retransmit queue with a copy, it frees the original with
> tcp_rtx_queue_unlink_and_free() and only repairs tp->highest_sack.
> tp->retransmit_skb_hint keeps pointing at the freed
> skbuff_fclone_cache object.
>
> The dangling hint is read in tcp_verify_retransmit_hint() and used as
> the root of the rbtree walk in tcp_xmit_retransmit_queue().  An
> unprivileged TFO client (sendmsg(MSG_FASTOPEN)) can arm the hint with
> an attacker-supplied ICMP fragmentation-needed message, after which a
> simultaneous open frees the armed SYN skb:
>
>   BUG: KASAN: slab-use-after-free in tcp_mark_skb_lost (net/ipv4/tcp_inpu=
t.c:1316)
>   Read of size 4 at addr ffff88800604d928 by task swapper/1/0
>   Call Trace:
>    tcp_mark_skb_lost (net/ipv4/tcp_input.c:1316)
>    tcp_simple_retransmit (net/ipv4/tcp_input.c:3158)
>    tcp_v4_err (net/ipv4/tcp_ipv4.c:587)
>
> Sync the hint to the copy.
>
> Fixes: c31b70c9968f ("tcp: Add logic to check for SYN w/ data in tcp_simp=
le_retransmit")
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Tested-by: Weiming Shi <shiweiming@moonshot.ai>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
> Changes in v2:
> - Correct the Fixes: tag (Eric Dumazet).
> ---

Thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>
