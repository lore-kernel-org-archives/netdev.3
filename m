Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95D33A00C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561147; cv=pass; b=G7yICoP21JgQMYcu2sz/SBP8P56spQPewdN/CYMgh91Jpa9JRg82OTUu/IjAWuxh4UZJs5WZ4dDzfFWwqU8/zanra4tnmc8sWLDX24gxJV0/Uv98WPR2ScTxJHJhsQGUx2ZabHyTL6dDJ/205epJNx/ZMMCI+50Mk5YN7gnp4WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561147; c=relaxed/simple;
	bh=Cf62AHvquiW1wPVHoLRVB//an84/OTXj2Xh68mCFV7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpG2FUoahgdvkBAwmWopTYJ50AqxujRSkruRVIKDPzUNqBuj5h5F2ap4TMOzBMVjbYQJcpK6aXcG9ebCoGPU8JsRNTnr3N454+FMTwf/bUY3oI+O/BmV0+duJrWq9BwnnLTEVQ74cDh+LVnwMByJN+NBax7Ynj4Un1hYzNICAio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXB3OdGZ; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXB3OdGZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66c5101a984so137011d50.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786561144; cv=none;
        d=google.com; s=arc-20260327;
        b=VhMxoFAfDHgd7Og0vXoS2gG+xhbUV6WAYtU0e+2nEPgxSYPu+WsvAzgAxAU46O7CPA
         v87w+D8M9yZwETvGEoC2cXxC80eQCAFy06p6RMDnFOrq+K+AY4G2hvKO1Sxmbjf/iRpN
         hYgLnCEXBoBqyKxs/h8f9NYA0lH36ubF9fNKHjTPFwedBwv7PgtwtMOX1SWaGcM5iQ73
         TPdJYwce4urgs/ZoUy4bZ0Slh33zge9xa5XuBvUVXfli9DAp7vu2H4z5BXjO32AGdHSg
         LHP2BmNaluuq282EryN9aA0UOAL/VODA0lNPISGzlhAGAvfFbpTg84j/7ZrPmIckKrCI
         08nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        fh=q6yl2xrczItIdItPi9SDP/aQSMpJz56ZBzTS1dRkjTw=;
        b=YFnBDYIDlTcVZwal+/c2uBddqOtRRCfasGo6UzehRdiblWcAy4kQsaR7GLcYu5bzVI
         TQVrrwxAHBMs1sgza6t5vmMlVIhc5HuQraNupcbOAOQXAY3MUEQuMtpS1vfX7DoSNkW1
         W3HtPyuuC48+ThGLNQIWpsHWsWns4KHAeprZ+PUcs0O0IjcgiRZniMxhhENnBsmoxmdm
         kOkAGic+449uwd2NPxsh72NazwezNoA/gYz+grVXCai/IxvFF0wuk+2XwOjf2e9WiNej
         V/tZcm9fa+gLY5hFqt9gbAiZtSMlohqciJOrL/2lTYOmeBDeHIFxcj93t1fuxyVWYofm
         +K2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786561144; x=1787165944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        b=fXB3OdGZAev40d+COszkXk7CSVP0MhbKh7Br6wqzN3eN9a6201N70MU2R3KAMNeh9Q
         gKq11Gcmy1c7pxyvL/ZgXVpj72P+bI5HPK+4upRa5tOYnSwX0SfejO/yPjKCD3Mg6eUV
         qID50FT9BFochjEr9MAUc+oWamy+hyI431fGw0NoYzivJyrxnVeb1LugjASgYS8iE4dC
         dqW1RZY++FnfC3LZBvLVjuhMLQ9ar7jmdZkDf+fYIFOvEVc1vFCeOIRobHwVl6tReciK
         zs84N/CDdZeXJlL2VO6QbKg3MKdoq63OGueHVzlZdUJILBaIcUMj1TurZj2OcimAf6fj
         6Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786561144; x=1787165944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVIxEE4O6vcmWKuih3FAEgHtBXNG2E3LNfEc3X8cwwA=;
        b=ViTr2eAzto77ebMYFpyIgpfDeExP9XgFdsMdbFBw9+7M1JTT/ZsA2AJGhGZh18Xm/9
         ytAzujzsqziF8UiQ/WtL2v84rMci4JANf+1U6Sgb8pMrdWrESyvU2cB0OskhzC9oU04v
         pynIKiupbIrR+bYLbj5U8Rv8fx3oNSCwHiSB+fK27RGUQB4heEO7xcAPb3QzeVjHvacA
         TXI1oXTqbtBwhoHjyGHXGbc9ZfQ+GTDQAhpVoSWjvdXcDD80mYWsVHzcpxm62Ihir3RE
         CjeM+K/XQptnvZWVjvFF9u/XlYv41+4axu2QaV5kGWWcPgOom7Fv2pDCXeWBuRLj/Fcz
         96Mw==
X-Forwarded-Encrypted: i=1; AHgh+RqaOzW7ddbFih7c+WDFFycPIG8AqEzFlnk4bCfAnBSsJRsjWuLmuKP8jf5i+BhvFCuHjudf5LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnQLCO5Qyx5Y/evX6t+xgro4SMVgbrRi3pP49PV3/5LNEbtNf
	dmu/VGgREUoUQmKJlb8pQK5QLhERaqNPgMvlWFTaSODjC2EaD9WjkhoSeyWU5dBLZDgAb/+7GTj
	n8bbwHpO94C12+2R2mw3WH2EV1boCBnw=
X-Gm-Gg: AR+sD12N9kFEexCSENfzpSgh4BktDkDX+gXu5XrNs3C6LrVC7lKtOis4Ij902udRvN7
	nd99vA4ln80Rp07vyAK4HqY79FnO94wvPo908uU3YewB0BRNrntotJv15A9WK85vd/5Pq3nlL0b
	9BrbpN74trmXBNPU3LcptIGEPPXjwkzqGqMDglpF7RMn4iSzoq5KB1XSSZMyMyKZRdO6vmdFhJb
	FvplSsGBnpbl7nnaB+cQqOmA+JSqTqO+EmxkSNaaw03ULFxpF+GHsRbpUaEoA+Nte5PTbC798cP
	1Jv5XSq2ADcJ7mMvH/OKLJtMezxc5vFqo6Gb4oDnAu4U
X-Received: by 2002:a05:690e:11c2:b0:667:b72c:8120 with SMTP id
 956f58d0204a3-66c513a08e2mr268067d50.5.1786561144090; Wed, 12 Aug 2026
 11:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-13-ameryhung@gmail.com>
 <DKD3TPJVVM4G.2N5G3FVGL6V73@etsalapatis.com>
In-Reply-To: <DKD3TPJVVM4G.2N5G3FVGL6V73@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Aug 2026 11:58:52 -0700
X-Gm-Features: AUfX_my-PInsN-P1EfS3zOiGkbRIRYLHBXB_ez0mpmKnPqr-Yr1YA81_1UAsAvA
Message-ID: <CAMB2axPqGPjo-NOVgU+H0q8HhtT3NJr=q_C8d8=_1g7Ed3YmxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:19=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type:
> >
> >   parse_hdr     - parse the options of an incoming skb on an establishe=
d
> >                   connection
> >   hdr_opt_len   - reserve space in the TCP header for bpf options
> >   write_hdr_opt - write the reserved bpf options
> >
> > These mirror the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, _HDR_OPT_LEN_CB and
> > _WRITE_HDR_OPT_CB legacy sockops callbacks, but are exposed as struct_o=
ps
> > members so a program can implement them with normal function signatures
> > and per-member helper sets.
> >
> > The reserved header window is shared between the legacy sockops and
> > bpf_tcp_ops paths. tcp_{syn,synack,established}_options() first run the
> > legacy BPF_SOCK_OPS_HDR_OPT_LEN_CB and then call hdr_opt_len, so both
> > sources accumulate into opts->bpf_opt_len; at write time the legacy
> > options are emitted first and bpf_tcp_ops writes after them.
> >
> > API design
> >
> > bpf_tcp_ops overloads the sock_ops header-option helpers rather than
> > introducing a new API: bpf_reserve_hdr_opt(), bpf_store_hdr_opt() and
> > bpf_load_hdr_opt() are exposed per-member (reserve for hdr_opt_len,
> > store/load for write_hdr_opt, load for parse_hdr) and share the existin=
g
> > kernel option-walking core via _bpf_sock_ops{store,load}hdr_opt(), with
> > the bpf_tcp_ops wrappers synthesizing a temporary bpf_sock_ops_kern fro=
m
> > the program ctx. This keeps a port from the legacy
> > BPF_SOCK_OPS*_HDR_OPT_CB callbacks mechanical (same helper calls) and
> > adds no new UAPI helper/kfunc surface.
> >
> > An alternative considered was to drop the option helpers entirely: have
> > hdr_opt_len reserve space purely through its return value, and introduc=
e
> > a dedicated TCP-header-option dynptr used for both reading and writing.
> > That is a cleaner, more self-contained interface, but it is a larger
> > change and does not reuse the legacy helpers, making a port from sockop=
s
> > less mechanical. It can be pursued as a follow-up; the helper-based
> > interface here keeps this series focused on moving the hooks to
> > struct_ops.
> >
> > The hdr_opt_len fast path in tcp_established_options() is gated by
> > cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
> > per-attach-type static branch: it is enabled whenever any bpf_tcp_ops i=
s
> > attached, even one that does not implement hdr_opt_len or that is attac=
hed
> > to a different cgroup. In those cases the block still runs but
> > bpf_tcp_ops_hdr_opt_len() no-ops via the per-member check in the dispat=
ch
> > macro. A per-member/per-cgroup gate could be added later if the extra
> > fast-path work proves measurable.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> One question I've had both for this and the previous patch: Why are we
> defining new functionality as helpers and not kfuncs? Is it that we can
> allowlist with helpers and not with kfuncs?

These are not new functionality. bpf_reserve_hdr_opt(),
bpf_store_hdr_opt() and bpf_load_hdr_opt() already exist for sock_ops;
the patch only exposes them to bpf_tcp_ops per member and shares the
same option-walking core. I think we have been overloading helpers in
a few places. Adding kfunc equivalents would create a second API for
the same thing and make porting from the legacy
BPF_SOCK_OPS*_HDR_OPT_CB callbacks less mechanical.

Note that allowlisting is not the reason. kfuncs can be filtered per
program too, via btf_kfunc_id_set.filter.
