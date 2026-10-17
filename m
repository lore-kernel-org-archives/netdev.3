Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FA3B19BF
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208505; cv=pass; b=FaghMN0NcKGvdlatSRhr8kslSl+Mhp97jso2jr3eF5iHCFT1CKCPs6BhiIPwxAaCOBUPwXk5aio1Ps0BynP66w8SiI4v4AoJ0y5o4qwYG+75Pn2g2JPc5vsgqQfcjLqty5BGzVVrmLwEfWZFAPNPZf4as145CwVkFGR5pfAaPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208505; c=relaxed/simple;
	bh=XzNP8y9P9XBRPn9q1Ye3+moIraqek8NEz8C1lEgoCBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6i6aHomKTInkhJj/atN+I62yfVv5NRI6rVQOJIvMpSBeD80aBW+4FMFAudUVMorOiAB7Wi1L35pe9ybrpTG2NnfFKi7EJKWAzraqTUOEUAbcjJo7lwuRP54Mn/IsItFCm0S8ALRD2IbVTi6Nh9VwGw27ISDo8V2F1PEwz3KESI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBFfcICB; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBFfcICB"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a9e87ba7f2so2986871fa.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792208502; cv=none;
        d=google.com; s=arc-20260327;
        b=S1i0++VFdjCiw6A+BZEYQTNVtpqUGFX4JFGkRP4uknfNzRlYwSJne3NYZI9fVrklDd
         ZXwhs05FInGzNdRB5G6s0wYGx3bfohNBvc38/TgpkahIYgCA2mtA8kSIdFxhm3+mfSfw
         EbvhPuj+KLrlCXgY5cqDsaBCwE8zO43c/eD4nFc6Lc6RDDCwhSqPB6BulW98+SSWcxtP
         zP5SySQkRV/pv9Z0D0I5F5q4Kl6Y5BgC46NFAF4pR/Ut1g7iDHpv3t22nq/Uu0JvBfh9
         9hNrHfg5tZ0/dGhiyfU+tDYiVuWnoEKAqUyUtk1PzHtE3/DPyuMjyDfdELc/wo2cC5Jn
         HPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/T8Wqe7w+zffENQg775/h8BcnuG43eGgkzjzMiS/JEg=;
        fh=ndo03VC/6rDxaTqGlqm7XVGmVcLo/V9dSNWff0went8=;
        b=BLxwdAJTvORCZF1AKAORZKvu1qG8AfzS+0EwhwfnKEBOUBloHdbeGQ+e5ABkv0PBLp
         RnCYXGxya52c4YwnmAQaZm+tyoEGZjLg9utS0AgVrcZOUdy29t/1Gvx7sl2UYx7StiTD
         HwIQ9AzSii+evhXj9dA+5jjUcZuOPFGhYkEDq8+j/SJzjQkrR8bETFj+yYwOLd26UE5V
         k4k5AZAz6jy8GbkDLbfn0t5vbFrzyPupgl1QeAQWVBOjna8ObE/Hr9ULsfGC03bexs10
         wcRWlCWDAzTAsbsAPawl2QqgZMkmOh3AUNlT74VNsW1MH/aDwAO5okdWO3PAYmoJ5xMm
         ZPDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792208502; x=1792813302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/T8Wqe7w+zffENQg775/h8BcnuG43eGgkzjzMiS/JEg=;
        b=NBFfcICBHVWC7fTm+w8/3B3h+RiwAta+9OHD5H8fYnrrgg45BnGsBut4QvEd+188yE
         RiFM3nd61GcGyZhYJlpII+GBD4UTC10cYdTvc8heJnX1Ml4pEVbQ4Neigx+Ln17kgJeW
         pJYneAKZn/IAKH5y9Q7NDKme+q769VQNtvbaiad+5KaIb+y+UEniaB5xZyZ0izzv+SfO
         hoL7Jw0Q170Tt6bBcK07ar81WORQWc7iTLURc58lRKVPUn7gg1W/FIp/ZlhdJ+ZrdhTk
         aUzPY318gvm+et/mfvDSzCOtjAMbGdMQZX4D7OUB2+jttz4nYe+OrRifsiCleitrvhm+
         p6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792208502; x=1792813302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/T8Wqe7w+zffENQg775/h8BcnuG43eGgkzjzMiS/JEg=;
        b=wGWH/q6O1OYIJGt9K7XDdaMHXsfjmeuhgFn3Pcts0a8vWijyXReZ542Al47xxwsKZd
         za5a68uBlGm+tEG5sAi+CbK0caLNg2ugT5SoSRr9t68UjolYSPl8tQgi6sbmPynldDyo
         lzloaH53+TOPALMNOAUpMQh5BqZMqQgX+wJCVqvxrEFelfd7AX0RqVJfulnnr3OOd8gD
         9YCIktkxs/3EJXpGruvCnCOaSzGMCNwtJnNNWL4xmi3IBR+LdEnrkbACBo0zIOobZmBf
         5DEn+YtPSz230xlF1CotfvZwb0DU28Fhbyhj9ktQdwS1GK+4xWRtprAdkws/7HA5FDhY
         lElg==
X-Forwarded-Encrypted: i=1; AKwUvBxhZa5uErIsXzF86Gzfr5TqC9sidO8cLbhMZDxMXP5UCkJ48IsH4U4LlsxUQQWkmvMyKxZGAXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv73j+8CozN3LxNgGXDDSEcuNPTFGNT9C/+wCkP1qivycwkttS
	1nLqCKVRvjmZsqskn4F7P3FJzSCnxsCAVkfwZKaKm8spB5T5Ql4IuKzCM+kkAgVRSv2+cVIWfOb
	UHsas79opu5HFvGlTIaCjqcqlK3Gq9KI=
X-Gm-Gg: AYBFou26uN1qJck9D3+5jYy/2iI7xKx2zmuUoaesrygmZhfvux0H+opqlq5VU0oKAzh
	djehn09iiqcDFhc/XTkX/ZOafk8P6NXVySdynlscP2WVIMgD+EvpbXw7wk8tJqdfhZ3TAhNm2/w
	u35fkSpGSGwgEuCLvdMTy4L7KamB+q6s7DQXj+rxdQjdyZ9v+J4N16I1z4bFkEjRQWArY9N9nzx
	xuEHRZJyJp5Q/OG/IBvUmx7lwyIbko5JtR53F7+lznHZGlSsSOzH3+e9H26LktwXXCzTxaEpLm3
	bM/tHSZcuDsq7gxahJeD8XUJmvegIveqk+BgKNyXepTuBmxxS0MeKRd6QXKI7Tat242TaO4AFqh
	lbozGZy7IIyFhDQLUJ1Ix1rD5Qwm3HhJLdhfB/98P/EOYfSbTWc46OoWDBkbdNhfhW69XUg==
X-Received: by 2002:a05:6512:124a:b0:5bc:b4d0:df9b with SMTP id
 2adb3069b0e04-5be50a737e7mr395267e87.25.1792208501874; Fri, 16 Oct 2026
 20:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016160351.3022939-1-edumazet@kernel.org>
In-Reply-To: <20261016160351.3022939-1-edumazet@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 17 Oct 2026 11:41:02 +0800
X-Gm-Features: AclHuK_4dlswbRxYkqJbaYJJLD-LTiYzIcMmAOU0DDHFvuv7MHjW4zi2zZYsVe4
Message-ID: <CAL+tcoBoNePkUGHi=rC_mPx4YC=teoZqrQ=n=2LmCp7_YGftfg@mail.gmail.com>
Subject: Re: [PATCH net-next] veth: use peer attributes to set peer real
 number of queues
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Qiliang Yuan <odys.yuan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 12:07=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> veth_newlink() creates the peer from its own attributes (tbp), which
> come from the nested VETH_INFO_PEER ifinfomsg when present, so the
> peer num_tx_queues/num_rx_queues follow the peer IFLA_NUM_TX_QUEUES
> and IFLA_NUM_RX_QUEUES.
>
> veth_init_queues(peer, ...) is then called with the attributes of
> the first device (tb) instead, so the decision to reduce the peer to
> a single real queue is based on the wrong device:
>
>   ip link add va type veth peer vb numtxqueues 4
>         -> vb has 4 tx queues, but only 1 real tx queue.
>
>   ip link add va numtxqueues 4 type veth peer vb
>         -> vb keeps nr_possible_cpus real tx queues.
>
> Pass tbp, which is tb when no peer attributes were given.
>
> Fixes: 9d3684c24a52 ("veth: create by default nr_possible_cpus queues")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Qiliang Yuan <odys.yuan@gmail.com>

Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks.
