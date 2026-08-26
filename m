Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680E2D5932
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765443; cv=pass; b=bAHIzc9bQPFt6KJ9egwOnjMTfgT7kHDPTcUmUa7JWOu3E2s56hmh9NU7fzKZrKN0ScXJ9WQ8zToQixODzF41giAYo0Uh5MDxoKfvayhU9IsJj5duFY1kstLvHcb4nxK1N5Q2IGRhnJzPm2VHuxCSlzqCooZsgnQZ0OCjkza3+CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765443; c=relaxed/simple;
	bh=6I/1+qMQ471+4RYnld66Y6RCA6m5prbOV7XKezci6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHLCHA7xOC3hhC5cFsIX/RShXm5SeDLEZQKZf8zIDkEc3WwOnMvY4ZjCOvEJdK0q4HJoa7IWpmWitYcpdJwHeREZdzdClrElaiiUxKXxBIAkxkHvgiTCcYcp9QyeRLWcJelIy3Au8xecmgquHt0TVZWLmtMAIeSL/PRgImNZ/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYo6voBC; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYo6voBC"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52de50e77ffso11778851cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765427; cv=none;
        d=google.com; s=arc-20260327;
        b=J/3As0kfaHieYlFmMlVxWSK7hQeiW2QVa3ImdnK5OU0xa92P+qsnODpMYtLwGnEKQZ
         wZX90CqEPz1Slj2UvF6Hb49knhT03rTLV98m6KRKD1jA7dRmec7BEPVwz4Q7hZkz7BAi
         /XKA0ayfXTe09TPqd6KzPEPuuX1qtu8PM4QBMyZL9Q/lmfA140WD5KT1+Aa+jjPUfQtA
         LBWuFlDL4gc1i10E0kt9y2KSHTHXn91K3464X2ZWzKzGAHKeGGYGrrwwDnHccCmTF99F
         w9gMDBVb+38n8JqYu5IEzmT50Qr1ye9SOmwPwc1yHbkz9CpU/ZjcuwNua9vd0ih3G23b
         HYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        fh=Hrv6mi0H0Kh1yY/CMLxJl2EEobH0Ql6w0zOO0KKxjLs=;
        b=qhskagj+Po8Z9P2UgdoWKZ+ABCXPw2vYaMvOYmGH5V0qJb6+cOJsd644lnBNFyQX8O
         ZA+wpMrKq/5ScbdYmQseTLNFG5ajpWymrksCLcxP///rYSZ4NSnwyxza9211OZB9WcdP
         vzZfPM7BFWx6n4besx1r2mXfLV2LUApSG42qb4zXdkNeTboVasYqeii/wjt2iXGg7hVu
         D3XdCwp3WcqzS0Y8jcdhDAOvrrFbbytQZpFV6qKAMv8dwJGzqgn093fBoIaFWhPvZRCC
         qiEz/vanH/TPcX35hzkM9tGhf9ViD5hUmvqiBzfQkcso0UThOrw4D2us1YybvQpDsTiu
         lamQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765427; x=1788370227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=vYo6voBC/2BgFQ4SxwiD2n2bJd0GVjymeEjikMl35kpmLBdbj3NS+ATEh6MTsXyqeN
         x2+Ou/joYg0moRd7b5+C2fHD/vYehytTAipnHAKslOVZJFwbMk6SO2ZKlrX1kXH3/lOt
         9CE0b0S/lXKVdJsuykaDUPWbP3Orz24rAv0lEqxRce1FuHIOz1iWL5tCdHT2xAaWzemA
         LPK8dTKM3Ty7wgKLYUZXx7o26GJ6BHPcVw17LrBgDJ126Uux28+82Gn1FfVMdoCs7uIE
         Qmoai63ljmAoeGWb/eK9aZqyiNYk8bLfWNhsWmdaPptimLbIisT5uwbtukhoHO7g/kfY
         439A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765427; x=1788370227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=BMpjz2rJk6k67xOOxcCVFuNIHEI0XDYuw2e0wJqYPA2dj5MNOndSq3XhMCHApDQLkI
         69XvUNsWi8w/EDAxK4555f/8Ph6fdVnYJB30PFNFw2vAHHULhO4v/DeeqBIUp/CGcSqN
         0Y0Maf/fC4HV7es15fBH2FCSIW5v96p1t7jaYfwCIGP6Wj3vin8nzTosannV3PLAXHKJ
         gQ7wM2unlB9zXRG3BYtxj3U80UvojQgUxMVDICDqMrVEjRc1H7/4JGKsFHucrdcg+PoE
         9d3w8R+g4w0OCF7ME4yc/SxEAohb4S0qqzSMPajeZKoImlXFta9zNupgO98r+hQUpK/W
         NYQg==
X-Forwarded-Encrypted: i=1; AHgh+RoPpo/2uZpmhn1D3ya7kGxMfLt8Nr8hnk4DLhaeR8jW7oDeYc72SVCY/eOUi4fcpgfEjTkcRwY=@vger.kernel.org
X-Gm-Message-State: AFuF++nz/npbMsgnr4LiU+CcWsJ0na/usYu6/3p7RbwQ8fS+EQkO+IT7
	Yh9qt6Vht0TwI+SNMzMRzimmR3aeDnPvFKNaKjM4fLf1pzT3CuGQd8bJOBO/B7maG4pnUmH7kJz
	FogBCldGlYA7IGLQ2Xa51jcPWRY7CblpE9WUE1I0d
X-Gm-Gg: AR+sD13tYpmmEa/unNE4+xgityozMUlYDw2WRzxfSze0y4eC0Pyd8XQtV8QEMWZRd/O
	cwfBInd8Mcvt0kw0pulOUnDNmaJiwlppWK7UPyt52HlVRXg/jRJT37sGEv4+34SA8Q+7lJXrzM/
	JVfiSA+qC61Jf+3GI5VvSqw1wSUJsd+qESHokYwwgSjJgTsE8++kVAbporGOVbNcAtpUiFmCWya
	EVIxQgKhsCjElXV+bWzdZS2/0QzvlPQdZItT4CBhT3GcjfkdM4qSBM9bz8gqE0yD5NLoOHDL9Cp
	cYjXwIWIYcDyjklc4heaHal+a7zWqzRWjH4qKQld+9fFdHSAyG/32mnq+yDnbd/zw8xqJb89kWg
	v+fWa9RecQDTbsA8kpKFIXbTq7qXjTicWpws0q68KtZyPyo4F9dwfNTT9hX8=
X-Received: by 2002:a05:622a:3d4:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52e422d73camr87475071cf.3.1787765426178; Wed, 26 Aug 2026
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-2-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-2-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:30:13 +0200
X-Gm-Features: AcwNN1XFn8gzzgrjQfG4ZiFeGArbznLUn8IBe3QpZkDe5XgxFwMYGCWbJrGLGFE
Message-ID: <CANn89i+5+3-u3T0Tbu_NeDSc2L1_Fpqtf_inKB5k0tN=9SUaiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
>
>   BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>   Read of size 16 at addr ffff888013505260 by task exploit/149
>    _copy_to_user+0x37/0x60
>    do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate every explicit
> icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.co=
m/
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
