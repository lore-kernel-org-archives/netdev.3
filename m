Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1942E8F0
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412712; cv=pass; b=OfN3K37WC6NXYfXZGL2idng3K+sP7I0+fOSgtjzzF5mHrETK8M5bQHa4oIv1cALOjYfjJNow2N4+Sc1OF0iQdT0Qcw3AtwcVIxD2/S7YZuT1kJKkfBvenPOf1CUS01Z4Ec6EE+bzwo2En5JSJVj8SQYtX9BO1AQGZQ+VKYDc/cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412712; c=relaxed/simple;
	bh=JAEnd7RTYfgtqTDPsV5I82Kbf/tGt183J2FPTli0shQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYS8lbnHaC+hEy+QzFkfn38PctPTNXS7eRLf5ZwRoiIx/NZkvYYbcbBXHuvAtL6KaLRaXxdz1TJR01sXS0e2eriTYTE8bFQ+U2V8mBtehsL1UisycbvCyBjl46oJ/wLmeTvuRPo6GVigP226vT5mpDLIt/ZHc/CF0+Leay7eXjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnNGPZLy; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnNGPZLy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b1ba286f6bso72544b6e.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412708; cv=none;
        d=google.com; s=arc-20260327;
        b=jTKIIRwFE11WIOnEz7347NqZdaPkLOB+9+ftHdlF6oo7nL8AwMeywI2Re8FHlowdD9
         E3HR+P0hFVSASfNYGz/UkU7vN9/5Yyb6tulGmDDck3cauXh91xESQ3l1QSIj25Y/Ttv2
         fqFiPyhHjaG7m06y8pvJtjo5VuYIFSfdOB2FR794CXUj5FRmyBkUoRUTFIZROcnj5ur2
         q5TCn9MGGZMFBJKIrNyIiRR64iV+4TyKgewrRWQL1gYaiSz7v98phenQg+TCSK82fUFw
         ud5BHKrQdruue5bf5uHfHnbPX75U9Zj456B8M0E2rxOuWBcOLeL7BIamnVoaNAafuxQY
         aNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        fh=tImXcy9HtOaTW7zt0sRz3JsP86YbU5F6TWQCDrTQ+XU=;
        b=m6lDVxKPeXCzHaw0Y93T49DtPW9hP25lINn+JlNgevoqOQ4GzdkI8mwKvXBltcEX/O
         ikJh5Kfc3opIjDeZPxU6KbKkukuBVf8x5BNkOhnWHTNFwYFJElGKXpAPUsnlL4t1bfOj
         sEddjB3Bt1ERgl2gQgCa9sdlDGALiNEKowldWEd5vZ/KBY7rcuzpmPJqRVbJVy1COoWG
         7Cls+JEj1hDL8L5qVjM8GkOsO/tzsp9hMZD0ghU4N++mUmY6Z1OQa68/bZ5rSBzn8XFs
         QV3bwJ95lbaPq7brDryKRpFYFEV/43y/v4Ovl96CnoUTtD8nnINc/RexWUFV0wn+Hafg
         hOKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412708; x=1792017508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        b=LnNGPZLy/Y/UNQxwmR4rR0/zvX0pcv0HbRGP305xVXBB/Jk0pplrAuPiBRpf4xpj+E
         Z8QwMlZjEKRsNA4ZDwnFejcuUr0KaxJ+PgUjzBedrUeMktRX97GWzPlfyUuVLilFkqBa
         mgmgO69Ol9pCSKNxptiRWTxMrUt1bZsgGo3TsrDpONIGIOOXAxGVwcRu7DHjYk+2eT8d
         q/aN1gCp/AlG8c0DVHJY3rD1PjH7RIl/tjrFrNDecbCPhAsqsRwc9LlpPSa0peBzqnzt
         Y/pCDUKspi7UqzxUlwt9pLBQlR04yZxF7q5lyc7tzlkXK8H6+USe8U589Ht9b1Ogd79h
         9I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412708; x=1792017508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0radvBLf82v1mE7u1BEv9JCaS3DV3MO4aUccMt6BE4A=;
        b=n4nCuFOSHxNOxgcoS47zDGABdmL8myq5m6yWbOszXvDvf7npiX1EvmZPRBs5iZ4jMT
         PuyHQW+tTojiK76aSqXagMhwrwDGpfkH4HOsmluJsM9Q75buSMltos+g7XvTF+EI0clB
         BmR2IW23EHpRGTHXd1pq5QSk2TdZbcv0L7Pmv3AmpYNK/Vb+vHRIqhOFkJxEVQf3ez/k
         JRqtox7TE2unRBoQ/iJ94PmCU5HEb/D4N7+PoY9x/XltE2/CvgKUq5mugJrPxRgHRrlg
         ASIlJl5S4u2fBWiXB3Tl+vvIg9phwkNrEtlwD0rrZOd9yAsEBUdJRQBVz4fiAlia0Zgj
         9aFw==
X-Forwarded-Encrypted: i=1; AKwUvBwkpioNtOVe5S06loUtDF9xwEhAlzYrQHOm/lqbStV9r2lGC9C9+2n6nS+2wifeLZdNhTfCVec=@vger.kernel.org
X-Gm-Message-State: AFuF++lr3IE3ksYS1N7SAzXxar6mNk0bRTQ3LAUfskgcTWRJqiD24xJf
	sc2LVxq3XljAX2EqEYiWGacGSuz8iGv+cN84mhyvI/jIMHNCgQ68oHtro0tJuVwMsxxcBgbhgSu
	tn1IVOo+xrcNVFtrG1H7l3Mg469p341Q=
X-Gm-Gg: AYBFou0C5VzfqxBLbkZasJ0fryu17kfdk1owBGuWy6sP+yo6SsgGz0oivJEN9ZIqr+i
	Q+0NtMJGwJnNsxtDCMjocQtsOkMJYM4oSmxjH7aCs0QCd9B0+c41Cd1NmaiIdJfnXnFe0A4zDsZ
	smPghqRjayoLI1TXs8ZeXN9mw43O4Cnz6UEIElOXIMO1d/wv5UJ6i6EqW0zCzUUyfyFRm7qXlqD
	j+GjF3Bqc9D6IcwuGbNmkPz6JSs+Vif65Qdw+1Xk2lGYBEnYn2JGFjpcA61OTr4VWi6SxziGCbO
	FaU3q6F8GRPJGr7TTNH+Sp1uBtU0Bkanbj5ZEJFZGxiFLpYquul1e7M=
X-Received: by 2002:a05:6808:1a21:b0:4ca:9850:4dd8 with SMTP id
 5614622812f47-504b57bbd0emr473506b6e.10.1791412708033; Wed, 07 Oct 2026
 15:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-6-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-6-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:38:15 -0700
X-Gm-Features: AclHuK_lWBEeBv6ps7ou-Z4Pk4-NURj4G_TRRW1ryhPrH584Hce6fOGQe4jabJ4
Message-ID: <CAMB2axM17PR+6k9jyW+J+599in1zbnrV=vRxx_qBwYBmShF28Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
>
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
>
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
>
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
>
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
