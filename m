Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77893ACA6F
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337583; cv=pass; b=LFT3S+mZBvb24F0b0mnvmnsjMfWFcLizZcAwSxXq9D8sHEX/04kBFsPTrZAYLYAz17ddY8XbW2YI73xkwC19B9LzjFNtiAveCU3/3tj1zWAmY/2K4jcC3T1Giwfw3yhyAnsB4ViAv4oF2wdHB4aEbUiic+fXMBsp8/gt7w6ZjKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337583; c=relaxed/simple;
	bh=H5ipRC5ikWPs4GHwCKt6WGiprEkcyH6ySvuXZqumRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVmfD2nh7uA5tE8RZrQuRCzuGB2GdnpXpauGZtMetNwBHpylcE+73d8CX5NQ2KaC4+phSVqnQWnnBszQq3zeVQEu7aJkIhVbKalAxRNiL183RJttSWYsT5KaaatgMeZUH3vxhvtFvzf2wl8cS8R8xS8XQmBYfu/drllz+KceQaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxsouX6A; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxsouX6A"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so10096021cf.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787337574; cv=none;
        d=google.com; s=arc-20260327;
        b=Vfi1WZT4GmoiNrrOC3jldSi1TWKbKozHBk43g1qPJpAA3pj74kieRnSoakKo4xHkKz
         /vF8ff7dYFqe1GLEYQ+722KzWpE6HQC1TQwfmAYMculhAXBwG3I+0++o3R62hhKvHvK+
         ZFUBke7rHqwZT8PukYT5a1AThGmT3kfsDC31QsO/3kirNBocY6ZjeC4MD2aE+hyOVdK4
         G3nK52jZOVvXZfjBIbm2qvU0Tx1AQMHXsx2bG53fONlSf0A5Po+uu33lNorK3cT25rKm
         /F97KwA4Lhly7fdHIiPW1jcyB5f/pQhHGGH6W3qbA2f+wmxIBT3aYD1R8a0CALQFRReJ
         /crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        fh=rnZWnkRDZ1dA71MOf9dHU/BWLZwP0OghouUvm7dTw3Y=;
        b=pj3H70O8H4anNv5BIH7I26uoUMGGlVqrrCcEZXi0EwSR/JcGs8eLExmGxWx8u7abdd
         Ec75i6BkUx0I6xyd1ela2V8GM3Yr6uDcWPy0jaLGcXr5NFQcMQ9ckNCusFGvDC/jl3a7
         Wo/FRzDU3b9qkpgMAOtnoKlHIISjMs/nUX8TArqTwV30OU47eJc2KOEUoVg7GwQ5I/3A
         vY/Ug9ycnsot3ln+VbqO6y/Iooa+vKQrthz9erXc+R8O5TconfRNbO8Fk4UrYU3KlJEs
         NlM7ko7m7Am9DAaQSJm6In+8z/DYcetOGqHnqk7evPhk/W46y/uQs4G/qC0snbkmO6o9
         LYWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787337574; x=1787942374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        b=AxsouX6Am1z6mIFATKB2wf+1uiSg6Jz4ujyimlTx0P3DvvvAQd4IKX0wlLY5pcPnwI
         Z8H0CHDan5XbRuiT0x/3bnYE6fkWSb2kGpek4eIjQKn29FhojK+keY2B9F+uYI/95Ep0
         bns8vtmE88fJdYBNq4f9g5dSdbtYvJs1bDdWZWa2v0bVqXPDGBULcv1qURl+ltp/lJDX
         YFw/l6mczIZRSYHHPvf8fqo1YkOqZZYsQuP/yH6jD8zbOnvoT7f1XSX3g5zAdI3KsonS
         H5frOTCBNb+FPo/ybRy6sfwYHcq8dFW3s8k4MfiuAhn1lU4G4NAcKZgG5dBE4h8QiR+/
         FFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337574; x=1787942374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IThE4nMDn/1KYzHCuK6EXhKBsZ+s3+Zdwpu521vHb0=;
        b=fEWfcQB0gtgBDLswknlHREgxqAhj9DysC8lIZEdjXcUs0IlfNJ1b1BAnKg0L/pKHZL
         jKMjzXLXxPMRkSCZCVAMiPvXcTgnWgjlzFSqInIDRddRtuhl0yRaHtZmKNULEpmbm9cU
         xMgTdBwrTAJQjKajtvl6Y2+TbeboPM/eY+/0R9lyLiGYkjizdEC0pMHJ+2fa1wXimfP5
         ur9SZVSM15vhhHvQkTL9i9aR7hd4oPvnLQGVXIdQcQo59RHZdP2zr2S3gLJVjbzTb0US
         DO+6ku2aY/ossAi3UUfJC4eulNmP0g8g9I8ypkG2IoQq9nOiGuIxjbJYj+SyctjN45mu
         JCYg==
X-Forwarded-Encrypted: i=1; AHgh+RoXFNJLjlAwwlrktsNPL89j3iMQZFTAgeAayJIi9iPAOwqHI/jU7idju8vNjs0R05E2mHg7pw8=@vger.kernel.org
X-Gm-Message-State: AFuF++mabwXV7gS9uE8wKVAyFm0Fiq8lXyd9n1mYea9XN0IniC6FjxmR
	2JzS0y3Ef0AtXTRmjDHk+ltKHDFkvYQEt+cn4f5S6GjqOR5KZWhcDsXPZ6DqJaTSZUMphN+lP9F
	LVMGf4jAXJP0gGJ9qdeCsd5hTAbwZBe3z4+f3lMxu
X-Gm-Gg: AR+sD1253xLP6LnfUlPVmx9wFBaztb/AIcOCSk/nXXmEDx+g3AEbWuEH9GYH0ASKn9U
	A5baz8CvMlo7w4LGS+irhQ8ioMbq/XBNOp2U+RS++Gb8sjRednK/w4i5vCEiQCZTyYAxJUxMCdp
	XGrRRLDsm85mIpOEn8rrY0ElVaksJ/+0YNY8WPr/wQVxpO6uIUmDpX11BgmBW7bOcvbVAvKB6oi
	AU75HVZ9/JqNG6wNg/r84b0rW29IYDmaKFFxIE12HJ3P9msGENFbm9MgGt0zn8es9a0Rz/3dxoP
	m/5UUnWV2VpCdJmGU2eiBIsO6OJ7IHK0kgsoIAo3QHL8l9rMHx90mdki9FM1DiPxVaDQlvR17rf
	scN4cqufEuGJnFo07hhnn0rjZeu7VfpoWib/PPlCeEPzYjQ1422fWs6LjJA==
X-Received: by 2002:a05:622a:229f:b0:52d:8679:ba91 with SMTP id
 d75a77b69052e-52e09baceb0mr2165411cf.8.1787337573580; Fri, 21 Aug 2026
 11:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821182449.79785-1-blbllhy@gmail.com> <20260821182449.79785-3-blbllhy@gmail.com>
In-Reply-To: <20260821182449.79785-3-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 20:39:21 +0200
X-Gm-Features: AcwNN1Uzk2tJZgFXNwH3oaoWgTa7_Y-gFylOUpo_j5d9Jt50Dmca5FeLa3OmU_Q
Message-ID: <CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, yhs@fb.com, 
	kafai@fb.com, andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:25=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
> get_info function pointer without rcu_read_lock(). With BPF struct_ops
> congestion control, ca_ops can point to dynamically allocated memory
> that is freed concurrently, resulting in a use-after-free when the
> kernel dereferences or calls through the stale pointer.
>
>   BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
>   Read of size 8 at addr ffff888013701258 by task exploit/149
>    do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by wrapping the ca_ops load and get_info call within
> rcu_read_lock()/rcu_read_unlock().
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> The unsynchronized icsk_ca_ops load also constitutes a data race.
> READ_ONCE()/WRITE_ONCE() annotations are intentionally left to a
> separate change; related TCP annotation work is available at:
> https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/


I don't understand.

This patch is incomplete. Please fix the remaining issues in a single
patch or series.

We have limited time; we don't want to revisit the same area  in one month.

pw-bot: cr
