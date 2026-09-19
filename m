Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BF3CC337
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815736; cv=pass; b=Cf43wGbMABnAVKuiyb6cBzzElI03uFG5QPMMEeaYB1k9v2UPV7pbT+sFLixoCrCfdw5WYSuRhK3IkkKjc1aM0h8/l4ySAVwDVlSskOSJbz0hfJlchQJR10Va+y45SpALhv6+4NuXGSPodO3QZ22rJjcGanW9/iHUGkUcTTZEZzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815736; c=relaxed/simple;
	bh=bByw82JDW+jqybuuMhYcN7brXCJg3RksqvUBCfrdXss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQZ1OPay9/Rk6Vz7onrKh+tPJPyxXwz/jacksays8Njsrqp2bC5evbKQsi/yMjNNPRLnXMiAUcQFqrBJSxoN8XN+nLVG64KMcO/W4c6RVEnC+eITW1ZmKaGySR4oGn+qsjifqzOKGnmHmwkUOwAqkL3STNwb0naiMG4PD+2wNQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAbB2LNd; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAbB2LNd"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c20ce3c118aso232925866b.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 04:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789815733; cv=none;
        d=google.com; s=arc-20260327;
        b=g79Xz5aS8hdVDzNU75QtLMf5lRIM+COnyMx3sD2oo4Mlnth1VYuBRB/w0ciu88c1YU
         yD+x1AIWiSeeTg8niXr/ANMtRTekKOlsewp85IGkuLDLnw0cQJM4Xr1TEmIgaRJCIHWr
         tL8yBEtdAt4IIqYDh2aTBY8+lm1HS+k5cBMiWTRz6Y/+Wtz0Q4GsrwJhy2MBCyQGDXRQ
         kVmcvHsGEPg1CiMFScB1sUrQnnm0BjRMDkXv+kcEjvnZ0rdkLUNebxgHgBtclgcNvDjj
         WPIp3T+SMCfpGP3Z4ioIU3eMrNJKghYlm8meG23F846cxT3IiVNdnT/npcomwQVqkmPK
         +/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        fh=vc1jNYIzYuSUTSld4HYmjoBtv8ZvFXY8kQu+qETKQUw=;
        b=aRH2zV0DLGiWfxHGyPWkpmDrN+9JBKuLJ5OJhBT3i2CNrNYO4XtKFrnGed1v+ceb5j
         qZKutpDgAwZ4JubRAMICpNAhzQVeHpldScOhpXwyS5YBCJbvldCECmO+EeMiLmhRtrqA
         yXZmpXfZi3USe5F+R3E5B9KUYCnr3fR7KPsTsOftN4XbJC2Dj2Iic83PTqnHFj2+th8b
         OzehYRNJUgei+fbbwxJai4xe/kdPRu6roCIVqRqMBwNwFL+Kcs8r9C6rt+bo40HRE29W
         ANyg5zneUrVcpueX/JuX3VVaNCX/xgPylvIXfVpgcMvTPSjEVsf6/EVjM1q8Mi0EdD50
         lYqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815733; x=1790420533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=LAbB2LNdX2ZXU95IudQkd50Et/wrIRK3vWTqrdvl6aJbMlY73Zip5VxDj+5MHHbIeB
         o3k8aPzxr6PxfSTLdkO64Hb6Githl8YyUmdVfbH/rosHNPivY04s7QnO9Ym7CdmcVZao
         lda7r/3UndP/cOU//mPBdBiXaZZ8Kse503u4xG0cuU+Elb9aH8ElhtbSboBnrX5BeG9T
         A5CiwMUKiCsPtvHZMtOKviOiy7pvoRYOXMxEZb4WPuceg7P8lMok/cjmEfGMBJENyQZI
         6K4sEUD0E6IPuazC8Zuni+CDE5F3N/e4mQhp47yjKR59TDf8r1dtPbsS2TckgOjhndAn
         m76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815733; x=1790420533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cpsEklAU6BWvkOWc7YHFf1b2b5F1Jin2qoj1wfdPzo=;
        b=dlgPa2wj1nqyRrMH0OL+wBRCexujuex2YkZ/sO5gDkWec1bTRUm44jn5+GavxYnC5w
         1lRhYagFuWpmjyRYZLk0VOXjuhnCd9VD8j9BVqqQHINqkRMs/WlE1muIld2V59X46BF2
         gcVLiwZEynEhURH/rrheE4dxOf98vgh+pcq05WUv2HZvPG0oMrrIsWLaWm2Mmn+KIqxX
         KngUfz2XOcHrbU2P5UNMPYn7/3GYYjupqEZp5ig8h4aisRXyU2YPuUnz7T0VJdVTHJyG
         dPejAr8cQygp8awCu9G9VTsZDUSsCd03oWVwSE1/rce9b+XXGuLQT+Pz2girzs0su1d6
         +fVA==
X-Forwarded-Encrypted: i=1; AKwUvBwyVZy3pxAVdjLxQIsTYMmzJQZ0NgCfo6sYJhOHDNknKOkawNP1EltPPTg616N/ZpBdMaGuXCE=@vger.kernel.org
X-Gm-Message-State: AFuF++nF+MbHqiUT9PZw0UzhJJ7FpBY3zhU16Bs+B0FGkhy/bqcx4AC6
	vVGLndPCP04Pt3BMEHuLisXDWudfo+i+ilnrA2xnPnES4gtJBv2blknZs1UkNCKxTYi5q5n8724
	Pu26FMpR9xupIHUUW5cU3vVu3Nf/swKA=
X-Gm-Gg: AYBFou1u0LNeqjP07dx4pdu/E3vUeGn9v5jQk5wjuf7USey7vs4BhvhLopM0J6PFa/F
	soJ3QVWFpwJYAdiw7rAfv0l3d7zQKIg+ZhQYw4UPhs38PlGhYg2RozUppKb10QarSM+DcVMTKW2
	HsMLuqVzcXDj3XnLDcTMvrUT1rLJlgXCqmfNHrx/JLdHbRHIQ3GRoJCPtohS3yR/k00c5XWRJAZ
	OyDftxioUsNXPWsk/7+nMEvqiiJQXsfHFzDpqrbZPiIMKz/qG9cHqkkJnH69TSiJt9nWK01yI9o
	VtO+LvZHsW556zBr0i/f2CuKu2ryZzn9/ZqwHTPZykqonLQ/Xfy7N3gXSIrVHCFJZ6+xfI7tcrK
	4yULkMsE4FmtJ2iZp8Zvmr1A=
X-Received: by 2002:a17:907:3ea4:b0:c29:6bf0:eb5e with SMTP id
 a640c23a62f3a-c29f5228faemr859476166b.2.1789815732565; Sat, 19 Sep 2026
 04:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917161335.1020405-2-bestswngs@gmail.com> <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
In-Reply-To: <aqwjutKiee-W4k1T@devvm7509.cco0.facebook.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 19 Sep 2026 19:01:35 +0800
X-Gm-Features: AcwNN1UE85QfdP_kbjc-baoQeq67vzozL6doVAA_AiHVQ5JgKm4qrrP1ao7fCOs
Message-ID: <CANgPUi3zTjaK5W3mp1-xoLoQmRmqvwMaG_68cNXN0gHmvp02GQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other devices
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, xmei5@asu.edu, 
	stable@vger.kernel.org, co+ac0a8c41de69121d@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=881=
8=E6=97=A5=E5=91=A8=E4=BA=94 01:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/18, bestswngs@gmail.com wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > __bpf_offload_dev_match() falls back to comparing offdev pointers after=
 an
> > exact netdev mismatch.  Bound-only programs normally have NULL offdevs,=
 so
> > unrelated netdevs compare equal; one loaded on an offload-registered ne=
tdev
> > can instead inherit a real offdev and match a sibling port.  An attacke=
r
> > can use bpf(BPF_LINK_CREATE) with a different target ifindex to run
> > metadata kfuncs specialized for the bound driver on the target driver's
> > xdp_buff.  Running a veth-bound program on tun reads beyond tun's bare
> > stack xdp_buff as a veth_xdp_buff.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017=
]
> >   RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
> >   Call Trace:
> >    ...
> >    tun_build_skb (drivers/net/tun.c:1739)
> >    tun_get_user (drivers/net/tun.c:1856)
> >    tun_chr_write_iter (drivers/net/tun.c:2091)
> >    vfs_write (fs/read_write.c:595 fs/read_write.c:687)
> >    ksys_write (fs/read_write.c:739)
> >    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
> >    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Restrict non-offloaded programs to exact netdev matches and retain the
> > shared-offdev fallback only for genuinely offloaded multi-port programs=
.
>
> Any chance you can also add a testcase for this under
> tools/testing/selftests/net/bpf_offload.py?
>
> > Cc: stable@vger.kernel.org
> > Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
> > Reported-by: <co+ac0a8c41de69121d@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  kernel/bpf/offload.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 0d6f55695..8c91d00d4 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_pr=
og *prog,
> >               return false;
> >       if (offload->netdev =3D=3D netdev)
> >               return true;
> > +     if (!bpf_prog_is_offloaded(prog->aux))
> > +             return false;
> >
> >       ondev1 =3D bpf_offload_find_netdev(offload->netdev);
> >       ondev2 =3D bpf_offload_find_netdev(netdev);
>
> [..]
>
> > -     return ondev1 && ondev2 && ondev1->offdev =3D=3D ondev2->offdev;
> > +     return ondev1 && ondev2 && ondev1->offdev &&
> > +            ondev1->offdev =3D=3D ondev2->offdev;
> >  }
> >
> >  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *n=
etdev)
>
> Why also have a null check here? Why doing !bpf_prog_is_offloaded above i=
s not
> enough?

Hi,

v2 and self test sent. Thanks.
