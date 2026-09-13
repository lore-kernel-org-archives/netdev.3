Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710938736E
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271409; cv=pass; b=iqiAGsE6FZx10pQfotFDRQwQk1kwfLK5nz/CtMvohyoFpVa1h+2XTEcFDkV5XcYXyU4LMn7f9r9WKR3KOhTq/rjKKXt/B75EoRxy9SWQDGOEIJf0eEIQGmMlWw3Aq6wc+aq0UMPZKZrTMhrjpqSv/EiZTiU6lXMvL4nIfCKgx7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271409; c=relaxed/simple;
	bh=qHDZNZCuNLGTslXN7zpQxKO9uh+VQZC9VcxHHMONvH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=petLjmMtKohMUHa5I//ntiAg3edMMXFr7g7erubU4rQhr6hkhdjM4tnr0HJ+gzHNJwQFeL1xtjXoXdYDrQk7q9WkbXx78JlUm+V8t6SQusZ4qVY9HZQbzdt0KLW7Xj+XbPRgilaIHsN7+mGR85apKBRGT1GWE4jUWfMIhsKHi+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbg4tKtq; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbg4tKtq"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-86265451beeso1386765b3a.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789271406; cv=none;
        d=google.com; s=arc-20260327;
        b=dCdrjhcVez4x2LHAFf8d+uHWf5j6C1W9/93uAlA6tT33pbpIxGvX5tH0URwxBzrtS9
         wj4UU5finVaFCwKL0eKW9o/bWezbbkAv8pDSun6fgA31FZYDb10W5FZjoRboKXet0LDg
         8C2M8uXfjl380ep0cVYB8x3C4Cu6hbbFgod5I/BUYwMyfUGc+cKsd0BPIVIfaCQG73rp
         EQ8EFd10qt1gpeL90dyhfD6Lk/hg63+5G1DgYrk0qClRH6LbvXbE+8zyIxi4mT0xIozU
         fXc2gA4scDoqy05Mt9887u8uIIBlighjYGa7waHrr9Mt1k4rtOZVSqMsrXdEDpAdamre
         eXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2eI+3BqfqqgWCiKAA4lWMqS7KzjiuarUSAM5ZGBwRI=;
        fh=r6ogZOK09WTDwZ3AEzxPEb/nT5LK8+Q1u7JxEm0t62M=;
        b=nYfEsxnEwn6qQ2pwHL7X5YHHc5rfaB9491QXPdo/IqJMvr68TGnHICKKaAL7O9CdHO
         Punapus6MZPb7N/k3jTc2tDOY7jL5GqiUVVftW9XjLeeifnOhCDmPP3yofVCBS1QdbyC
         pgZSPiTCeTv4rVU19GoiHZI48UH9zEhqVFvmNnRI9t5TkOjpXAZ5U8YTnzTUY32CXvGy
         u4uBurDbPdVfRyjaZybz7RSO78vgNSmF2fKsRG1DEZdnS2RCmuQP6lui2VET+fTMst0F
         29oCOysTx7NwewX64WOCOZ48RsauN86h9sAvPbPvJzAT+FUTuINCFi/kApHWC6zHWnhV
         lZTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271406; x=1789876206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t2eI+3BqfqqgWCiKAA4lWMqS7KzjiuarUSAM5ZGBwRI=;
        b=Wbg4tKtq+QKwlal4PuJJVvFlyrVbIvn+3dIvDxBXoy1zNg3ccFOUzXPxmRB2b/dXiU
         MPR9N8Y8tM/fnsN+uav4FFEWU81XnfpCACqzP6ZOLWDVyn9Y2nCmx3aCi2XcMQGXhmCZ
         GFZHfXZfn8s+sd7/6GQUoindPDSaGrF56oZx069guO2bAI3rgcdnM2ECCxatsocpnNLQ
         J545PQdMfLF1ByWovUEvQs6D9VTipj5K/L0QSd34rkHSUylnLJINKmpQ//xvUPkhrkdS
         /u/gi4Rx6I7f9Aeg8f2w8Ils12nsw8hlCKyRBhxCCD9ghDcjX2Mf9p+e7PhZo3E08Vkc
         5tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271406; x=1789876206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2eI+3BqfqqgWCiKAA4lWMqS7KzjiuarUSAM5ZGBwRI=;
        b=d3B0OVHjiznRNIUVXcWBGWHlIy85cPiv5OJpDkQVC92f3eco3OTk0saS7ppZyYXvvZ
         Ae2DxSCfHbSbNqyXhIFqGH8HoLen9WeNGIbYN2wrVQZzRa1kn8H+Eiaopuk4vEF0Q8Xe
         umtmUvbKTaogNPy4qVL0rnWGTHUrUmylRlsK7RKvnQI4y5w6w1TVvyDgk8Ey0UlsC7ej
         MghiTf+HwQ41pVJrGjQUieblczQ6jbnlEzki6WeMf8Ff4TmWIT08hM3iNoAqmFTHWu48
         wQ6aNTYehePUOTMvn5gNZvL+Rg/xDsT0R53gsBMEvV066cB0000Q9Aafif+LgDEpVFLK
         Z0Tw==
X-Forwarded-Encrypted: i=1; AKwUvByxW5l+9juXeFJFLDIeI6iBbOJkiDNcVzzhl0Ha6QHJzsJdW/8/r4KqEgLyedyB2Bi7juo6gsM=@vger.kernel.org
X-Gm-Message-State: AFuF++n6PXvxd3wcV0uPYW18Sk+qBnxUQoS7YvGGHkw4bsmUE8IwHFHY
	MFAI0wTvL6W0hXl3oR4HV+92tny/9XQW0HOOVrMprmTgzmaYg1zs3tEzp6Lj7S/F6pNFcfLSAce
	oRkW+RkQxrDirD8+YHoCj2BEr7tfhJxE=
X-Gm-Gg: AYBFou31tm53xad0Fm10AutWYsvVWSiQQU+klubF8QGMaHFJq4y7dMzwG2vZ05j6JtW
	+IqqCfYg97fTDLLFHchXfFWw1PrpdS//4SBx4Oenu61klLVhbAqR0Gh9HawkaRIRV4bng66qH/N
	QsOGb6lNUyqjCsxMnDm2FHg/GbpHef9urQoazBnV/qmV4Fm+6+h8OW3a42LKue7iYKzM9RFBaQq
	aMriBsmHNCdf63fAYRqHdpv9ee9rPgDIfsig7RkIi1qUMUvvw8crMT5w3jtR/MvjDy2cD7AO3T8
	ZsQmmHEXOhFIsOjJIiCLQXW+GUqAcBB9HM3bKxEAq8N+OwgxPJdegA0sxA==
X-Received: by 2002:a05:6a00:4c8b:b0:857:727c:a1f6 with SMTP id
 d2e1a72fcca58-86b3170e7c1mr19369536b3a.24.1789271406470; Sat, 12 Sep 2026
 20:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908060410.3982-1-nashuiliang@gmail.com> <20260908133636.2ea807d9@kernel.org>
In-Reply-To: <20260908133636.2ea807d9@kernel.org>
From: chuang <nashuiliang@gmail.com>
Date: Sun, 13 Sep 2026 11:49:55 +0800
X-Gm-Features: AcwNN1USJ6-xWXXxQWNVK2TyF7NeCudGIJsb0qkkp7Q_Wt7etGNqDQWwyy2_E-Q
Message-ID: <CACueBy4BvJ6E0RuUDsQmwPq_zt9Xh6T19DOAkA5MW-uU1yNpKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, let me restructure the issues.

> 1) Also not sure why you're trying to touch RFS, the change only helps
aRFS and you could avoid bulk of the refactoring issues.

The scenario is similar to the one described in "[RFC] problems with
RFS on bRPC applications"[1].

I attempted to enable ARFS on a Mellanox CX-6 NIC. While it performs
well for simple workloads, performance degrades significantly when
running a bRPC[2]  workload on a 2-node NUMA machine. After tracing, I
identified patterns that ARFS/RFS fails to handle efficiently:

- Multiple threads use epoll to read from the same socket, causing
frequent flow updates in sock_flow_table.
- Threads reading from the socket migrate frequently between CPUs.

I tested a PoC version using a bRPC service, utilizing funccount [3]
to monitor execution frequency and perf top to observe hotspots:

Before Patch

The mlx5e_rx_flow_steer frequency is over 380k/s, and queued_spin_lock
is a major hotspot (6.30% in perf top). The application also suffers
from a noticeable drop.

FUNC                                     COUNT
mlx5e_rx_flow_steer              387594

FUNC                                     COUNT
mlx5e_rx_flow_steer              390142

FUNC                                     COUNT
mlx5e_rx_flow_steer              386694

FUNC                                     COUNT
mlx5e_rx_flow_steer              389094

# perf top hotspot:
queued_spin_lock                         6.30%

After Patch

The ARFS update frequency is significantly reduced. queued_spin_lock
is no longer a hotspot in perf top, and the application's overall
performance has improved.

FUNC                                     COUNT
mlx5e_rx_flow_steer                      43

FUNC                                     COUNT
mlx5e_rx_flow_steer                        9

FUNC                                     COUNT
mlx5e_rx_flow_steer                    207

FUNC                                     COUNT
mlx5e_rx_flow_steer                      26

> 2) You put a very fast path function out-of-line, why ?

The reason is that tun uses sock_rps_record_flow_hash(). When I moved
all rps_record_sock_flow and rps_record_cond modifications into
include/net/rps.h, it triggered the following compilation errors due
to symbol visibility:

ERROR: modpost: "cpus_share_cache" [drivers/net/tun.ko] undefined!
ERROR: modpost: "cpus_share_cache" [net/sctp/sctp.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

This arises because the patch uses cpus_share_cache() to limit the
RFS/ARFS update frequency at the LLC level. To keep this in the fast
path, I could move cpus_share_cache() to
include/linux/sched/topology.h.

1: https://lore.kernel.org/netdev/CAHCEFEwToeQe_Ey8e=3Dsf8fOmoobvrDCPsxw+hf=
USoRawPX03+Q@mail.gmail.com/t/#u
2: https://github.com/apache/brpc
3: https://github.com/iovisor/bcc/blob/master/tools/funccount.py

On Wed, Sep 9, 2026 at 4:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  8 Sep 2026 14:04:00 +0800 Chuang Wang wrote:
> > v8 -> v9:
> > - fix errors in AI submissions by Simon Horman
>
> I commented on v8 6 hours before you sent this.
> Please pay more attention to what you're doing.
> --
> pw-bot: cr
