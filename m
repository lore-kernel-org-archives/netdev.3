Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92778401491
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706008; cv=pass; b=KcxhoPAYLcHtvxCS1O1Iy9NxIM/pBY3I/LU/57TaBISXHtR/b7BLhPSFlPFXEf7F5H4GbcnB3tAgP54xMHtD/4BnrINzKSZrm2ysQsfGOHuA2hsRbVUnYZFESgCMRse3a11pIjYFrHyZxDiLa/ijC/CdnW9C0h86JIX3PXH0hw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706008; c=relaxed/simple;
	bh=LXjj2AX0Vl2kOkkKEFA18exaCc4ribznTBsnG03/ix4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf1Q72ELOe2bEGJF6/IsLKOo5CYAb4KUEHCfXQOx+FKYKsV+YSwMTRM2XBvWU7BnAG5E6fxT5S0m42ZuNIUP1qjz/JcqPfRNAqxh8HTD93HS3QJcSWfgckVJbOqSP4Izi+QTxUBjMeLz5UC+dlcO5rWZjzKsc3acsVvQynTe5Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7RWfaQ7; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7RWfaQ7"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1649542d50.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781706005; cv=none;
        d=google.com; s=arc-20240605;
        b=YYBH7xY6Tg69yb4D8HEkvs2SN4RgvGvKl33VSDIRSlULTH0tVqTCySj8oOnwG5IabM
         CXBRDPJn1k6lRBPOsoq7I5S7OKC0yLe+wG/ZYTHzHRC+WNPhL19ghW3Azw59UpUxlRgs
         24hdyUlc2XPPTxda7JrvsQChFzoo+T11uYpMtGCqhmXbpP138p1s+Wkgbf++t8ft7et7
         pYhYSYFkR+rSspbHWIUDKDWFiEPhSGLrO0/8xwBY8vd7fNI35fto4G6LWo9BYkQXCmPq
         fPxLDpRAnwxvyDG3yNDDvLuvQCpPzLqal/y2VKTDiRanj1uZrGG25HtB0tFhuI3SW47U
         mHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        fh=FqlN4mzR/M62otW7BYdqWAkM4SYE1qS5tPrQL03S1II=;
        b=QfvZtxZt29dr43hCS8nKIKDmzLn5FT4DRpm/BdfRXNl74atCg+wgPskfN4oFfxUnpB
         cXRpOaeKwYrzMAUNqYxPv90yXotrrsrvfdSMV092HT8Eng7+T0HeGBATsE2OSOQs4Y0Q
         jDqhf3KDkKuHSoJHGm4JQXEk+g7ZsEuy8KEFva/0lF6H37rUmX/BiKOBg3M3cgx7xkHM
         zbhWKzUu6abpt5jgXhiOpco8jniWEv/X5zjVhAByv3HxnXSQwDhxWq+kRjX7CFj85Ihs
         gHQe+YLIlWeRJIG9tIpzIeJkHLur2CZWP9ZHF8JkZRlQUPrA8IP38FbrdDj8StmrmsYO
         xgGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781706005; x=1782310805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        b=n7RWfaQ7ZOd2SD1V9DFHwe13YYH0VxgLZbdiRx442lRvi2cRqo9jRgUg6x24YEJadT
         odl9vzMHey4oHjq/m8RaDqVlMqUoQRKHyNUa91Tj2yXR55n2QL1cwWIP37wFW/Lp0cOm
         dOK/ZHk8uc43n0aorJgsDCRKOurioR1SxdTL3TPpGsfZOwdLnm3sZ6n+KBw9M8aToJWL
         UZyVq/Me66SZn9oWKqpoJRWCUqY22UNCh81OaG6yMCxhXeI6uoWxDdS9c4RlYzOLBSHC
         HSN9a0wG4DqgFwDs+LEkMofRR/G08PbNsMWenM3REfuI0hFpqtUBQy47iM4rL4WZVTof
         rjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706005; x=1782310805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        b=CqJFne7vyYDlaexeshBoDWly+xdWmvrKHr2uIgaRn0YO4F+2wmwIqu+nKNmo4uIlgI
         /RPeIIzorDlREcG/zXv2VsAXnzJS6/0S6WaRXTv/w+IKjTK1pC/imKqkqBBb4CT1/LAr
         lM5ivxZJqRzQNunEgvehEWyI660K2/usnp0rKyJqqlyxaVw2SnvwF2PUz19ouV7e47jB
         rPDcpxuhL2kn5BXhRdS9hi3Khf27AqbFdWRXUECu0+IF7mUPYR0gPsnOONOwgbhdhv56
         bNPH5XEIUoLoa52JUxx8OreauIcqbAcd1CCDnBccB4QLm3RlD3kxdUbJP9cZjMWW8PXP
         OvWw==
X-Forwarded-Encrypted: i=1; AFNElJ/6Zi9JrX4Ty7bi+iAcHYbLIw3cJw3yjKpcALzPtj9x+thb7LO3/DVr5jwPsy2KlZ0fDjJoJpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHp0QURKscCX843evhnzYF0/mgzlPaTgzPJkqMoeQjLQy9JalW
	LQKuokkzTUAehnARjEJdsFOAzFiEFdppADUkgWLyvDDU95kt7Dffry/n0g0g1QEW2xCRedVKnZc
	/gg/Cc+gncFnV2jvrtR2vIq1zZyg/5OY=
X-Gm-Gg: AfdE7cnLKM0e9+px8cLStQyCIPPH43bK2sxTz+hQ/zW/QZeoAbURSU7jRKrQUewPlGY
	DmuvibjMwvImx/sY/WNbN4CM+3qH8r6vHWe6MOfNmQS9/GDCsjSZymINxdzhEbvC0MsremU6b9W
	lkMVLN5yhMckHZTYWt9CYCMmLVjTL/8RrkyRzB6/t3cK9FK8njqawHovJeKkPfMK7oQaz3U6v67
	vvHm+GE92nLYOdNgzVCAOqetapSvTEAG02dS3O2MhAgH31W0kIdVqviDNE1VDh5KfHHRon5gCfS
	Iaj/f3XfIsI6YNVFGDdIqw/FSjeFhAhTaq3IjhqPEV26s0+bzfrEEo/S
X-Received: by 2002:a05:690e:dc6:b0:660:933d:3057 with SMTP id
 956f58d0204a3-662cd092f11mr3027618d50.0.1781706005428; Wed, 17 Jun 2026
 07:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com> <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
In-Reply-To: <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 17 Jun 2026 22:19:52 +0800
X-Gm-Features: AVVi8CeJJOuka0GCnt7aRS0jt8X52KgHwbpSBiN7gwyo77ljDBh5CLPdi-Ab_Fg
Message-ID: <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, paul.chaignon@gmail.com, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/t=
ools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > index 01f1d1b6715a..9cc898e6a9f7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > @@ -4,6 +4,10 @@
> >
> >  #include "test_pkt_access.skel.h"
> >
> > +#define NONLINEAR_PKT_LEN 9000
> > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > +#define SHORT_OUT_LEN 100
> > +
>
> [ ... ]
>
> > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt=
)
> >             "incorrect number of repetitions, want %llu have %llu\n", r=
un_cnt, info.run_cnt);
> >  }
> >
> > +static void init_pkt(__u8 *pkt, size_t len)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < len; i++)
> > +             pkt[i] =3D i & 0xff;
> > +}
>
> A question was raised on v2 about whether pkt_v4 could be reused by
> reducing the linear area to ETH_HLEN, rather than introducing a custom
> init_pkt() with a 9000-byte stack packet.
>
> Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so this
> doesn't seem to have been picked up.
>
> > +
> > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access=
 *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN];
> > +     struct __sk_buff skb =3D {};
> > +     int prog_fd, err;
> > +
> > +     init_pkt(pkt, sizeof(pkt));
> > +
> > +     skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > +
> > +     topts.data_in =3D pkt;
> > +     topts.data_size_in =3D sizeof(pkt);
> > +     topts.data_out =3D out;
> > +     topts.data_size_out =3D sizeof(out);
> > +     topts.ctx_in =3D &skb;
> > +     topts.ctx_size_in =3D sizeof(skb);
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tool=
s/testing/selftests/bpf/progs/test_pkt_access.c
> > index bce7173152c6..cd284401eebd 100644
> > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> >
> >       return TC_ACT_UNSPEC;
> >  }
> > +
> > +SEC("tc")
> > +int tc_pass_prog(struct __sk_buff *skb)
> > +{
> > +     return TC_ACT_OK;
> > +}
> > +
> > +SEC("xdp.frags")
> > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > +{
> > +     return XDP_PASS;
> > +}
>
> A related suggestion on v2 was that, once pkt_v4 is reused, the existing
> BPF program could be reused instead of adding new pass-through programs.
>
> Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of the
> existing program? The v3 still adds both of these, so this point also
> seems to be open.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/276805=
11802

Hi,

Thanks for checking this.

I tried reusing pkt_v4 and the existing TC program, but they do not fit
the skb case this test is trying to cover.

For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
linear area are rejected before bpf_test_finish(). With pkt_v4 and a
linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
partial copy-out path. If the linear area is increased enough to pass the
IPv4 check, pkt_v4 is too small to both trigger the old
copy_size - frag_size path and verify that the copied prefix spans the
linear data and the first fragment. pkt_v6 has the same issue: after
making the IPv6 header linear, only 20 bytes remain in frags.

The existing test_pkt_access program has its own packet-access coverage
goals and is not just a pass-through carrier. With such a short linear
area or small packet fixture, it can fail before the test hits the
bpf_test_finish()'s partial copy-out path. A pass-through TC program is
therefore a better fit, because it keeps the test focused on the
bpf_test_finish() copy-out semantics.

For XDP, this object does not have an existing xdp.frags pass-through
program, so the small XDP frags program is needed to cover the other
caller of the shared bpf_test_finish() path.

Thanks,
Sun Jian
