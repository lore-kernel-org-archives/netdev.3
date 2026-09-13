Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A638B140
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272887; cv=pass; b=XUBx1m167w5OT3484CDAYcAAlMTBnc3mAbTQ+bZCllGBDd3n1pl/AZOnzOEOqDxM8SOLLuvCzAboSTS5UzA9e7BFkghTHLvEpUl0fhZIbYOfIDwqkiSiASNBib/RuuLLHeoEiiVvtQPRk1KL4uQhiBDC1ioVvp/kDizX7NTUj1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272887; c=relaxed/simple;
	bh=aUDsLpihMC8AfClUqBSsvhaMDZoSQupSjow+fr1hzKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1XsZ9sXQgaaNhLxkIUniG69VWluTk18ROO/SAnYbkOdFVxeAmgrV6d/5InYWi2cZyHScgfbvx41GyuVCrLwB5ErUagEvTAl8AryKpDrrUGDfP5GTg3zONI3fHlSCOU2+FpjhXpBA2J1leUGf/7oxc7UlUQy7CivHO/ODNId7WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voufvrI+; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voufvrI+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-530fa1d2b31so1767431cf.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789272884; cv=none;
        d=google.com; s=arc-20260327;
        b=RAaCGg5xgOz8UxZ6tgoacbEUuPqtf+NRV7IxgWRbMh8i74r/vNwm6gL9jRTHkv2Lv2
         bdZU0qmn7qNqZXJQJpm8Q+1BlJxuHVBQAYGi8PQJpn9mzosXBS3XnHmt4jGNp5kahsNw
         sB5DuytDh9qKk/YZjpdFpNMYomwswPF2Xu31zmBDAm2cAwTOJZm2Sa8FGuTNM35bEyF7
         dEPMOMU3munKjWe3f7sEBAKXZqzeBf5BcxBBdW9nNakonM28klxTQRE7I8gmRLbROeI2
         QcJoY3QD+lqimQ3qIcgeRSdrAyR9h+us3PHlSpe7K8tU4nSvCP+ZpfeQwVYtlXomzw90
         yhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcgeooS9DqrC6P6k5y+0MJSSvjSsZ9UJn7nTw2UMf70=;
        fh=4oynwKDSL3TYcX8AUL4r3aRaHBhTGVaXORboWk4N/y0=;
        b=KZFbeSicleAcLc3kN8dUWeibwkT//adwmDgjd+D/7axoM2wY1v+88tv3489t8GFljI
         HCNbsmp64eLYuFO4hvXh2aJobmV/agFt+bg0ac6nWB0gfE6yzZE856JQorpWOuLtdVcJ
         11gSrX6Yj5xlPJ4LDtvOf22SIn5fUwGVYdr+ekGvaSVFC+NUWTiSovOZVGoY7ucPSHzo
         YP+/3J98a8UTcmy2GGmu3o8RngXEKX82bkTckX/xIB0gFHC6KcCfaaJfXQcO7vLwSVBl
         l/oMmrmkdUIpBpeFN5GLz8FtIyRzKgwf1tBZaVw4PHo20Iz4LrMaLm4EHRCiQjoLxm0S
         AVsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789272884; x=1789877684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TcgeooS9DqrC6P6k5y+0MJSSvjSsZ9UJn7nTw2UMf70=;
        b=voufvrI+89AadJazLpr4G5STlaOcrkQahPegXTxwZuOg3nFgGcGAiPKd1TBVV2pivV
         H4dir0HznEqFzaQbquXsHfq+kr+toRDjp48qPUC9jNzKLLkUq21i5a1mB6ThpsrJJ/nQ
         giqg80fw47pk8Tb9AglJ9wQ8kMiDAfsChXcRevp5j0M1vKCSSC/JK1+a0teFXUcuCMPw
         Ryqxqen0r8NB5JTUQdrxLNi/GyjgzeHjJ5yKrcDcjFjhz07JiFqO0xDCewbZftNErdhX
         gfF9fphezkVNzYo3fUnjzDsplHkejNcZyeQtQpI3ucYYmvqyx2odaFP0DxQpIb2fXy4W
         HuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272884; x=1789877684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcgeooS9DqrC6P6k5y+0MJSSvjSsZ9UJn7nTw2UMf70=;
        b=TbFJvB26jNJ5MqZFw7LlZKstYiUdpRuOAco20iHNuQzFxJsiSUZ6KsXKxM2CHtKd0e
         hpB16qoyUDiEq9CaAkfn+NJK0XI2900PTBpLYSNW356yfVOlB5UEAqQMdLF0udpvRtjx
         vj0CKNLpzv7ca1yH4PqtEitYbQ3g8Q2V1lEXgbcJWU6rG1J8K4k4ZUzzScu71zdbySGs
         9vgxpPlIZG78frbGBQEGaYjyPWLsO4vetByAw3m2v6PVAGp9pMkrJHnVLbAlTplcRJro
         lNTGMtaZ/eYEcka5MAuaPM+ipw9kMzQY31PUE7oUKmBLJj8aLcwQ1YFiw74hzzFdA24C
         7ZXA==
X-Forwarded-Encrypted: i=1; AKwUvBxDMHHGX75mDe9q+xFzBqTpuEQTxDVCNx2T2Tykx413WNqVP2zCJOaIyayRJTUjhodVQYJr4xc=@vger.kernel.org
X-Gm-Message-State: AFuF++nwEV2YsZtZVvDd//pEIcOHaUJe5zsyUiWZxOHfhd2hyGt3TfQx
	d5LQLpWYgMblWLuhlvADQORUEQ1MDnWiBO22ef3JKiFo9fx0+nndxRi9bO64LWFB+d2C8Ynv7lW
	Yj+hidWXW4ESUpSNeWSF3THRFf4rLpANXOVFA15eW
X-Gm-Gg: AYBFou2MXisnLKgLMlva2A6Sc/HnAw3rQITiXHImH/xdDyBFO1X8N6qvHUaSLB5LiN+
	chD4nWwE6hQdolXLdvwZumCec6dnJfGbPGoUx3qPOmDTnjwCJITyYUzanhofU1Hs1xFFObeItqI
	aaX2K9JrbnErlpiUKSR/7nN/LD3NnlVWNPKyUO91w3UsEInhz2W6x4Gxm/n28vJBA4kI9UFxFoq
	3gzYF7p8TC8dBYEgz1pVNGcqEduHZeITAaQW50FCv0CKTw7iZJYjaW/XTWBIcKzHS4NB0mXWnfl
	SKizKHwG+o1yTpjuQgBwQF/hSvitjluLYP80kes9qIUmKfbfDt/opEOk1VmafFiIGZVUg5elFmR
	pyUh5cXwAr6JmsCJ+HDhivCgsQyO9UUKLTalUXyl9z+srTQ+MPQmYcIL6iS62qJxpqgY=
X-Received: by 2002:a05:622a:1816:b0:530:f986:7d36 with SMTP id
 d75a77b69052e-530f9867fbfmr22653761cf.32.1789272883445; Sat, 12 Sep 2026
 21:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908060410.3982-1-nashuiliang@gmail.com> <20260908133636.2ea807d9@kernel.org>
 <CACueBy4BvJ6E0RuUDsQmwPq_zt9Xh6T19DOAkA5MW-uU1yNpKQ@mail.gmail.com>
In-Reply-To: <CACueBy4BvJ6E0RuUDsQmwPq_zt9Xh6T19DOAkA5MW-uU1yNpKQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 21:14:32 -0700
X-Gm-Features: AcwNN1V8Rwz7o8JbHZS1bOyPmJgc_MK8ZwrxVjNAkOVMHCJsis9H7ZgXQppIETY
Message-ID: <CANn89iKYQMPm_LyYY4v48QmoFc0MwkkKQwggd_BLGDJL78=8qA@mail.gmail.com>
Subject: Re: [PATCH net-next v9] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: chuang <nashuiliang@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 8:50=E2=80=AFPM chuang <nashuiliang@gmail.com> wrot=
e:
>
> Hi, let me restructure the issues.
>
> > 1) Also not sure why you're trying to touch RFS, the change only helps
> aRFS and you could avoid bulk of the refactoring issues.
>
> The scenario is similar to the one described in "[RFC] problems with
> RFS on bRPC applications"[1].
>
> I attempted to enable ARFS on a Mellanox CX-6 NIC. While it performs
> well for simple workloads, performance degrades significantly when
> running a bRPC[2]  workload on a 2-node NUMA machine. After tracing, I
> identified patterns that ARFS/RFS fails to handle efficiently:
>
> - Multiple threads use epoll to read from the same socket, causing
> frequent flow updates in sock_flow_table.
> - Threads reading from the socket migrate frequently between CPUs.
>
> I tested a PoC version using a bRPC service, utilizing funccount [3]
> to monitor execution frequency and perf top to observe hotspots:
>
> Before Patch
>
> The mlx5e_rx_flow_steer frequency is over 380k/s, and queued_spin_lock
> is a major hotspot (6.30% in perf top). The application also suffers
> from a noticeable drop.
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              387594
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              390142
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              386694
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer              389094
>
> # perf top hotspot:
> queued_spin_lock                         6.30%
>
> After Patch
>
> The ARFS update frequency is significantly reduced. queued_spin_lock
> is no longer a hotspot in perf top, and the application's overall
> performance has improved.
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                      43
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                        9
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                    207
>
> FUNC                                     COUNT
> mlx5e_rx_flow_steer                      26
>
> > 2) You put a very fast path function out-of-line, why ?
>
> The reason is that tun uses sock_rps_record_flow_hash(). When I moved
> all rps_record_sock_flow and rps_record_cond modifications into
> include/net/rps.h, it triggered the following compilation errors due
> to symbol visibility:
>
> ERROR: modpost: "cpus_share_cache" [drivers/net/tun.ko] undefined!
> ERROR: modpost: "cpus_share_cache" [net/sctp/sctp.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>
> This arises because the patch uses cpus_share_cache() to limit the
> RFS/ARFS update frequency at the LLC level. To keep this in the fast
> path, I could move cpus_share_cache() to
> include/linux/sched/topology.h.

Hmmm

If the LLC affinity check is performed in set_rps_cpu() inside
net/core/dev.c before triggering ndo_rx_flow_steer:

net/core/dev.c is built-in, so it can call cpus_share_cache() directly
without any module export issues.

sock_rps_record_flow() and sock_rps_record_flow_hash() in
include/net/rps.h remain 100% inline, retaining the zero-cost static
key NOP in the TCP/socket fast path.

No exports, no refactoring of tun.ko or sctp.ko, and no fast-path degradati=
on.
