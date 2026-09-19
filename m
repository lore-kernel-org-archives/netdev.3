Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882C47CA61
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815866; cv=pass; b=oszPf8NbClNRlANVFbpVz8FSU9kEOgxcOBEeVu6H9eL0HiezYopImEhVK2MUkcADYbe/9FOHCfcOBTeT/UQkn0mq9N6/g9tFlxJA/wBXi/FWXlQalj3rvvqQiLMM0hs/lOlBx177j0FDU7OsN/331OGXs97uLweKGstMDceJOvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815866; c=relaxed/simple;
	bh=Uy8pdbu6T+f7Vaa/HfQOkCmS8NcxSl/AYSWfTMzxSOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG71fNHaCWmbGxhz5+u8697jFZKRsNIdyVolnzrGMDs3uoiqK/Wu69iKYgFrxoNcOSyzwHS3w2PXR3dMsCh6Bg1AVORtjI9tcT30SZfnOpV4MKxuCA/RIswQJ2yeuA7VI0PUTZXKTQJSTqdDnPHijFBhRjobOn7dVm4M4ng4O4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA9OeGUz; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA9OeGUz"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so241876366b.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 04:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815861; cv=none;
        d=google.com; s=arc-20260327;
        b=VOD+5nxraAvmMEEphP9sbgCoFMd9xAmdNkEP7d7fouPloliQKmk3j+Pc4+fIkWe4G8
         b9FaVWeSZexFPbrenIZfns6NY22HSeYIqmnDiplOHXO+h1yTGYyKyAYtxVA63dfdy9OD
         sgVHFS+AFN831N7z+bqJefKJ25xx4g10G4zo3QdIOtEZcGpRM/rLxYPtz9XgU5s81XQs
         mnYtb6I553rBnhlcILWmM/QRnikRy2gr9HRU06PodB/HzphaqipgUrUoSzCl6TA7s5qT
         wzENz3v+p+zIGvpLaK4AN1buQBdoL1zadk8VVBbErvfR7QveD7YhX3wcm4l2jhW6ksmM
         kxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        fh=2aYbltXRmFHiUFzAuh8dT4ScWJE+mtWXOhQkNUwPtik=;
        b=NToajq2LSyJTOSVjwO/zS6cdw2xaB7hRVkLFBWFvqOe+9g4ohnY5eUFJ6EG/s8g2ZI
         GgPk3s3J5LM3DCAC04cai0bOL1R44XsY/zsdmToaqSuu53mwbreqrUk9/JHa2aLa7cmO
         LHV3h2C6HxqqbAnVyOr/3WhvSFXYFoBwYhSQmPQ0TrPgPrOrtCy2NPoWnxig0LJ/fN1L
         w/kbuPgFSfJhGjiseMAxnJHG0Y/QP1A78dCMyNXZ386oXFkUyCVv0J8mNhTuJ9B2jgze
         t/0fFVY1yAupDxzKJDFtHQwIokMz74U+aj1w+0sYdmsUpPKztwC19berMaY0To2BnwSm
         asXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815861; x=1790420661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=hA9OeGUzy3Vd6kP9d4L+TDaxqU1xiw5lxsywbrcJT8yepumnd5t5E8BWcHU48ejDJo
         e0dbw6a2Cv4eH6yPzj8ZTnHhRiXNDDGYA1GHqsO5IqfCjRQRZBcld8GHhDrXMoJVY7AM
         zL1frWoKvvpueQYCvecI7zKN+nB7LH2K6PUNG7GAFvSuxqivvjqRUz+H0mcDxFqb4Q6u
         1/K/hFGKtU9H2mvCs9Rx1iZEFlwIad6IFfJyLkey2Vl2Uej+DaYWp3aDWHfNCCzMHdmA
         pjn2J8YN8YfwHeqrRiQQMfRY+4ZKxMc0Lwm1AfUNlncJSvhk0lSUcNiP40kwS8BsARb5
         LCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815861; x=1790420661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaoU/CXeNzW1XLhDMwPnWzYzMZ7xTqLcjubBtefo9dU=;
        b=1ZkoeuPrZ9jmSXkt5C8wUvsw/hgXDYqUfPVh7bkSCrNESrnRYV2FiaS/986Mu0JXIj
         VSWLx2t4kKETU3ZnoWJDtvSuRFlwXMYLfxGf+7ZrlNgJFMaj/wSdoHDWXchpxi6CzQna
         iz3hBxwOsm7wVRfdRVWj6XOnGs48WLuCCq6UZ4RmvywWHuMupuR8GNMjQj+acZ5wwevH
         2xKPgqjWeLBmSKTQOe16KH0Oui9o57XxQGMCzKUX45bnHyywdh4ZtXp/Tt1cH+wh6k5d
         S4rvOAzM3D2jCvkvPVXLBBcElbSkuHnGQlyEmYsM712lBcACyymvWBry+5qVW3+M5ANy
         a8OA==
X-Forwarded-Encrypted: i=1; AKwUvBwd5JA5zWNh+DnErDhobpgbfoPavRO3zjRydt8Wn+x5syg+VTQkO/8NgFtPj1PreMx/4DCFSUI=@vger.kernel.org
X-Gm-Message-State: AFuF++moGMEejlG2koo1tqUp2Vd/wxSiIovBg+iAowIB+byeGc6JiUIT
	tO5bl0ALJ2NBoAuFSTcfyB4+t18S8BesOeEmldt0jVFSUHZDSoiGAn6wBRBMBH2fG3qznPy+coG
	n5qcyvmUxMQa/f20aj2N4Ok7cDQptDWc=
X-Gm-Gg: AYBFou3NANYL7JqHntA7ebieR/YtvGQlD6CUZGSWkwjxl8IVk0/SjFwJIP/p/GvNO33
	9+cS6T3ASASDvLexkQa79C/OIZbpH6gD3R9x/TuPM7DNr1qixFhlSJ9jB+nefaCBP0jMe0f9IOf
	R8EAaos+mzjcqdFfaJPqbO7DPX9JLAoDjBJnWuIG9BxaKH0A6skNYqXGqQjDxbZVwwLTA5HiLAW
	uFByBeAN+yqTF37VIq0SYk4OQEwzARgQ27y03nxewRWZCtI5cgPYj+zO1lhkaNVafke94c/NIXn
	SXBqY4x7QUCVnz/q/J0Nl8yhTQ22kxjJhozyiMh8urfaxvq+V/VA+j4qZAADmuPfHoZXDXWdXnU
	Fyt4Jpz2Q0TvJphviGj0RZ6k=
X-Received: by 2002:a17:907:1c93:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c2a159adbefmr463681566b.20.1789815860423; Sat, 19 Sep 2026
 04:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <20260919110053.497301-2-bestswngs@gmail.com>
In-Reply-To: <20260919110053.497301-2-bestswngs@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:03:43 +0800
X-Gm-Features: AcwNN1VEN7tDxPHeWKB8Nrg6EuEcehqwkEM-7eNLy9K-KJ6bav9GGVH1VcMnkSQ
Message-ID: <CANgPUi3E4g09FpaR2gz0eXuLQuLg4qJAp_Qscorb0b4Szj_akA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: reject dev-bound-only programs on other devices
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	co+ac0a8c41de69121d@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<bestswngs@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8819=E6=97=A5=E5=91=A8=
=E5=85=AD 19:01=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> __bpf_offload_dev_match() falls back to comparing offdev pointers after a=
n
> exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
> unrelated netdevs compare equal. A bound-only program on an
> offload-registered netdev can instead inherit a real offdev and match a
> sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
> bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfun=
cs
> specialized for the bound driver on the target driver's xdp_buff. Running=
 a
> veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
> veth_xdp_buff.
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
>   Call Trace:
>    ...
>    tun_build_skb (drivers/net/tun.c:1739)
>    tun_get_user (drivers/net/tun.c:1856)
>    tun_chr_write_iter (drivers/net/tun.c:2091)
>    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
>    ksys_write (fs/read_write.c:739)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Restrict non-offloaded programs to exact netdev matches and retain the
> shared-offdev fallback only for genuinely offloaded multi-port programs.
>
> Cc: stable@vger.kernel.org
> Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmai=
l.com/
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant offdev NULL check.
> - State the capability requirements instead of using attacker wording.
> - Move the regression test to patch 2.
>
>  kernel/bpf/offload.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 0d6f55695..d85539981 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *=
prog,
>                 return false;
>         if (offload->netdev =3D=3D netdev)
>                 return true;
> +       if (!bpf_prog_is_offloaded(prog->aux))
> +               return false;
>
>         ondev1 =3D bpf_offload_find_netdev(offload->netdev);
>         ondev2 =3D bpf_offload_find_netdev(netdev);
> --
> 2.55.0

 Sorry for the noise.

 I mistakenly sent this v2 series as a reply to the v1 thread. Please
 disregard this posting. I will resend v2 as a new two-patch series.

 Apologies for the confusion.
