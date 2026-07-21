Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276637A825
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618779; cv=pass; b=ljeQC+JksUWaAOCiVCJP1Xk2YUl7AHdHC1nyehz0GqAiEN1y5kQqJpJcv7aDMKfyuYG7966MOX8TAKNz+ywTWuPCNMJZYcaJ2wuZrrOnzLAGl0nqMMtI2mE1nkTI/i5zNauXIFflqWQ6dqMhMiL1bK9Fw781q2Qxezqwxij1rvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618779; c=relaxed/simple;
	bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkNnGL+wE/YQR1gSE7xfVYkVd+lJkuSzrkNYWeKjpduWXOZ4F9iRINXNhvO9RJj26wNS+CQfAAJ92BOc99MUGxRPPSf8pm/E/tNPT3OkpFFk9dYFwCIm6jl0oy13dtocZtfLVkHqVZEb+zriubOsTsDHc6EBwcpgTfTqBFVGvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzJszTdR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzJszTdR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0c68aa31so78046441cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784618777; cv=none;
        d=google.com; s=arc-20260327;
        b=feNiXI2BpAG0FX3hitwm/bCNUJUc9OyXBgUuXsKnpcUQqNhd0Fdtcz8frEwvSlMzf2
         JiVYg/TzbIdQOKg1leN+PUHf/rBJiUSf0SV+/uQmQ1zQkr9hBMlMukaTNvdJSuF3RRYn
         PhqQ83sKnjYk2XhUeEqRBgNTSjr9UrCtVweQvneSKc9bSXHW/bJBKLxHckPzJU3pAh/b
         DokLhmkP31DP8fGA2+mnqMOY14K9xYzfqKQs6h8B/z7d3/9YScWfcb03BUc9b+ZNw2Ne
         mv5QCpkUomhQxcuG4ADspcJqEeWt3aQxa4/yNh6AqnrjGv/xMZeQpIyDkaRvlFYWrYWd
         iCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        fh=3SqwHh/9GdWooIW1mOL6Gc0BRUJ7BxnT5bMSJM0+duc=;
        b=pslIO9Db4H+1R2eTs+FUeHtHUKp6UHTrDFDUlWLmNBh8/+z0lRL08iKEqG4vBf743o
         yPqHoaisqtR/X1EMS4K1zKqs/L2SFm30qGYD7PVtOp5xkF7LKg/M1NYNmP1adekoVnnq
         7XgEW/7Iqu5Wb3DsTR3a6mn22nHKgpZNCNXbuixVqA+lW3hNaZnWVXow6+GX8In8HPwz
         FF2vb6o7/NXZAXcCQji4Cg+t4hWJ6k9I+yl7IlAldeVMYVe4qglAwoqJCHXOyEJhFHoT
         yPpvLt540Lbo2b4g1PyzCic+n4mjJiaWq8+l/7C9138S6D8GrHTUePR2DJEqKPWxY/jH
         It/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784618777; x=1785223577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        b=mzJszTdRhJwPqbZ0VylPVx1nBwhJP1SrW2eR0Q75sBz8A5n6aXkP+xH1fFG4xY8yfh
         7Q9J4lZrX4pAtRw8vjdGvs/LQP2Eczw3n52GUWoQ7j1hZMlRWfxtZ7tcN5M5aqlYZ3jP
         XiKQcwhDbSswiJrzjHIdEwTiWRxvcNMAvLH/PJG+1oGktgP56kBuYTAUi1TjPamcAf05
         VPg9m70+FLIdZXd6se9Ye74qv3tt50j2IY/MkfUcez8DgZYHdTHiB30m7mXzTCXbRp+3
         ecJn01+kpgA/dA5rys1OCC5bP6E4ocQDezW2YTgAD7iwd/c9jb9IRgkKWXvpIPheXq7C
         f2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784618777; x=1785223577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzE7KXfZZvmR5yOWeMXJywazKBRUNEbDRhgMybpP/NA=;
        b=ZVwPcA2dpUkifY/ouSS+0nXDx1OxzhNHpy0qKln8r4oEj10uNBa04v8HuXaktAA/Jb
         K5yyEL/0m+r4F+iLFMUtR1LqKhQtSFWPCN2Hg+G7WYkgJeYKbK0q01wPfM7Vwem8ffpe
         nAW3YVyyuHJvaJubN5E4bIq83FHuURq23B7QBuvrXjGc9NZ99ke7TZGnW97i+pjr5GYv
         vOv1x8lCGJrv1tgcRzcDep2A8QRYRqjmnjTqYiymW+CBnePTukwuG7+kJILY5mUiamlO
         T6FTq4biVXgD4bCBccz1XcyKvAKo/efkirizyPcuYscyioWD3Ny7fuPtNsX6zigRM8No
         UeIw==
X-Gm-Message-State: AOJu0YyIyTUujSCvVoit3gAmS8x5yQgzOkrs4z3TmOeX4YYH4scvBudC
	TX5LggsYFtmrnjWDM9CoxR4cd9PGatN3i/UWy1BdSLD5fpuEuvmvAdY01Td4858MQpqHflTXaQa
	Kq7OSdD1WIh2UaFiQ0B69LGStgHN72niHFFtc+9Bu
X-Gm-Gg: AfdE7cnQWPmvkx7LpHWvo0HczyUEqt2FoW/es4gzbBZ1uiMH2gPXetLK5M8EWuP8Hf6
	g5aVAdN4A2YTDJ+j/wsj+6Sg4tN+gt+e8yos0jNTpguggpxrT1mM5EuCePqTcqOykXk9JBOpIM8
	G2T+sZNC2nEx0t2lA9CNZ4e5GBYkvqrNTaXw0GvpSCo2tKHkXaugHziAXYzGWSrUmjTxWrYbAD2
	FRaPdjqgu7e99oniS+BNEEPVrEQddh7Xl2QGsGLg6b//1sAQoNhQfJFdjDaqCplV4eGqNPXPPBo
	RdrVQTxN3FkOvOHJzWPWxF9qcTbwY4PtGCCn5kNMuwCvG7YZCLuIQ1ISyd5wv2mNN8fMzaMu0Ss
	XpuaoEPlk
X-Received: by 2002:a05:622a:15d3:b0:51e:f4df:2898 with SMTP id
 d75a77b69052e-5213d4b8bcamr159959241cf.72.1784618776678; Tue, 21 Jul 2026
 00:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721015824.45829-1-kylebot@openai.com>
In-Reply-To: <20260721015824.45829-1-kylebot@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 09:26:05 +0200
X-Gm-Features: AUfX_mxqIm2PCbPMZavwj8QfyZoT8HMPVoojJD_2vUX--xC0B9_hkVqsDzEHamk
Message-ID: <CANn89i+YuuBJ1J8CGD0Eo3JKeNjEd=5tT-3h=6stE5QoYczYXw@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: defer vmalloc TX_RING free until skbs finish
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:58=E2=80=AFAM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
> page references preserve page-backed ring blocks after pg_vec is freed,
> but they do not preserve a vmalloc mapping.
>
> tpacket_destruct_skb() currently drops the pending reference before
> writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> decrement after those stores. The smp_wmb() in __packet_set_status()
> orders the frame stores before the decrement.
>
> On socket close, scan every pg_vec entry because allocation can produce
> a mixture of page-backed and vmalloc-backed blocks. If any block is
> vmalloc-backed and TX skbs remain pending, defer the whole vector to
> system_long_wq.
>
> After pg_vec is detached, a late destructor can skip the pending
> decrement. Use socket write-memory accounting as the deferred lifetime
> gate instead: an skb remains charged through its final sock_wfree(),
> after all ring-frame accesses. The delayed work retains a socket
> reference and reschedules itself until no TX skbs remain. Fall back to
> a synchronous wait if the work allocation fails.
>
> Move pending_refcnt release to packet_sock_destruct() so late skb
> destructors and deferred cleanup can safely use it after
> packet_release(). Page-backed teardown remains synchronous, and no lock
> is added to the TX completion hot path.
>
> Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> Cc: stable@vger.kernel.org
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Hi Kyle,

Rather than doing kmalloc() inside free_pg_vec() during socket teardown/clo=
se,
would it be better to pre-allocate the deferred work storage at ring setup
time (in alloc_pg_vec / packet_set_ring)?

Pre-allocating at ring setup has a few advantages:

1) If allocation fails, setsockopt(PACKET_TX_RING) fails early with -ENOMEM=
,
avoiding allocation failures during socket close/teardown.

2) Teardown becomes deterministic: free_pg_vec() is guaranteed to have
the storage available to queue work.

3) We can drop the extra fallback logic (packet_wait_for_tx_skbs(),
po->skb_completion, and the 1-jiffy fallback polling loop).

You could embed a struct delayed_work (or a header struct) into the allocat=
ion
returned by alloc_pg_vec().

Thanks,
