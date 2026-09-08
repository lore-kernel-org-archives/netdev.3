Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A92E4257
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909611; cv=pass; b=OrYDAJUGaLK6pcW4ZXKAWGaYLDg2Fov2XZQg/nF6tMOW6k0OvuXQTxsVpP0rBUf/PA6xXMhx0M8kt96IZM+4uBTwALtwnNn8R5hpb5YWcmOMH32vpI9MrjkZ+OgII7/LN7fvLm0I4qrepyodcsgysFkgmJEBz43U0wta3jRUNOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909611; c=relaxed/simple;
	bh=BwDbGyznSdFukCRXjgObPw7cGoXwjqQHpB0ltFjAKXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVWryqi0+2ckwijpZ/6Et9zPp4YXX+j+XXId6YD2eHHKecrrybqIDD27nX3XeUjuuf2EzGtkegSYJtSHOMgCIg3d6qkxq+YYxUEOkfkAMfviyxL/V3yP8odbuwNsQX1vQJb925pcDiOw50+RGtPInkMz9Tnoo6dIPIk+3I37o/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Gd87nDEK; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Gd87nDEK"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-867a943b149so83303937b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 16:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788909607; cv=none;
        d=google.com; s=arc-20260327;
        b=BKgLJ0LvkxnQHmfJodCdzwbf2K06RY+4Ty9rEh37TTj3jZxG6Fw3LRsfj9ulrUCK2p
         WwhmATOQG4y0bXFQYoxUAzCd6n7wg9RWgvx7THXE/ui1D8WfA3JvdkhvKeeZ4ro53tBs
         p/OgfLXgKuKXdBtzJgHX+eQQyTi53p9JOcBb7ckLCS75nKL0lIdqZH+UIWz2/Umisxy8
         jarH0Aajvxe+VMGgdDX3ERgr2SWFS0ijm/sRQrlQ+jdnKtJW+r6MzTQfv0EhzMt3hGFX
         mD4yh1pl6XcZU4lIhMjzm3WDhwn8oXu74M0ehF/sfDxe/k7qNdi10l5jPEp8czZhntkA
         n1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26FP9kIUNsB+7HarEjMuFZhQLKe6YlOhbHQM1Yvl7Vo=;
        fh=dWa7W0AQLTLmyw0lQy8O2sIgh1lMG4dXIDizyyJC81I=;
        b=FL/opO8n9RsDr7+9feYl1T2nLpTwCCZbq2O1vXaR6kCDe+YPP/8ield3vMZ7JnB4RH
         LgZ0H6oPRtEMDBl38oKXyEq0csv7W9nbID1BgEUhiHnKmfRLSXpXkdOuYhyAjfmp9Lqb
         pHlmFNRPo9cnZyjPUyMKJL+MLpYc2TeCIA31zuxwms1Qgu9wbgR9VEvO6pWWHAkOprib
         KYbmSqcirY9Z1ZMBXd9/E1uJ3yRJjoDNDJ7hv9G3HiEsJBVAOnN9v/kQKbcgETwAyxgU
         BZDHj9ZVyLOWFkwLg9zZLevidlsZa+NOZ/hwmzGiECc0F4mSCNau/GZzVv7dclz7b/X9
         az0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788909607; x=1789514407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26FP9kIUNsB+7HarEjMuFZhQLKe6YlOhbHQM1Yvl7Vo=;
        b=Gd87nDEKouQTEcntjHj+rbyLzYBFLPHGRt+kodv7wqEayzfAS9Nsn1gLFF2XZbMLYH
         22trZ/vw9HXCz0ukzi74k1M6rtXLIyYeSXtP64r8JZsm1k9kPQMN+dwC9RBzJ2XXjj4J
         id9c8NY5+sKQsjlDCMgchFtSZ+7MJcqO5JcXnIklE6lZV9by44JWxUR8YTbBQZpY8D4t
         ATbTf8SVN8r328Z/yNITQTu1V+NysGUX6J2AyVeIqegduPjtbyCFiE+bkiOpcTsv32j3
         PBr2cVzeNnqpANJtJEhK+VN9HT8Wv1VNTojWb8/NjcK/yJkAZ6nrnR1POJj0tnshWQJr
         dnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909607; x=1789514407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26FP9kIUNsB+7HarEjMuFZhQLKe6YlOhbHQM1Yvl7Vo=;
        b=N8x2Q6Hl4oR//WSbyeBGWzYJQbqi6bcuJRX4Z48nmzh/HAyulN8+pVxMk/PUTAtQ+x
         5UoLbkHsSeDYqRSbhIJ2U8MjNRlF383b8oRMvo1IxuI8S63M29GoY+PM/18vQVWCa44q
         9S6XpJ4b4pxR6mkig3wBWUKPCpI0pqJzXtunMOfBa12fA8pRkvvz0bT7ZzvAlsPI9XAO
         VPdDHEkQwZB9RqIzaTDip995nV4rzlnuZgW900X8rHp5Nv+2DvikKiKGiG2VdCHWeDnP
         nrObxsvwUwE5DFkOHLOPVzYEHjkJ0EJpx96vFtP/5vuBTjZwQ/08MA1bYpMqdp02muxh
         iOQw==
X-Forwarded-Encrypted: i=1; AKwUvBxpXbvgg09Pm9DoFxDGjZDQ2ZV2pzG9egNV43VPn7gLZm9Ht+f50epboTPhSdcoUbVgxaQhydE=@vger.kernel.org
X-Gm-Message-State: AFuF++n6KxmYCd+tMZDY3kjvu3BumOrDRs7gt9jX1PBuvmJL+L2YJTIE
	X+HZPfPr6zzU+adVepXI2YB5GczTqqIDekBnO/je8+l+NRTEyqPnThtOwRmP09Lq5121j/nUOHv
	gAPH2XfWJMz5nWfLzVq45LPAZwaXHnnTfFWSXIwLkDg==
X-Gm-Gg: AYBFou27V1DnQVJTecTPEIb+8VfF4wT3ZBHQj5NgvZpzIkIJmQ/8Wki/G1pwMO7kzsx
	meaw+vxKqiA3tT0SFQj9e/obtCJITLKug8Wam0fP8RBl0wTTTLM0l4BFaAvaNxeDcJWfawkEvh6
	OiYujgQCkub7YlJFYH+knQse2aUGNA0hcxePhqBBLia9pmOlu7DOyuQkmJdknM2jtfSCklEqAZx
	kEc4HHmT8A88P9ONAb/JQaoXeb/QuHqfoi/jmqEGWvIJXd9cpO6elOUkIEUeYht2hjqBk1fF3EJ
	/fIXszfafxbzLTQOKIVbgIlxjv52XFm81Z63XoMlJxSHJiPQy4tRun8=
X-Received: by 2002:a05:690c:388:b0:873:5bd1:98bf with SMTP id
 00721157ae682-8735bd19fbdmr94689867b3.49.1788909606864; Tue, 08 Sep 2026
 16:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901183151.16648-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20260901183151.16648-1-cenzhang@linux.microsoft.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 19:19:56 -0400
X-Gm-Features: AcwNN1UfREHp2kMvmYLiVPmJrmYLz8bqciXAdv8jBq1uXxNAjBv_hZQTifzbsuw
Message-ID: <CABFh=a5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9MVZZG6gSJAEw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix non-linear SRH access in bpf_update_srh_state()
To: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, ihor.solodrai@linux.dev, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	m.xhonneux@gmail.com, dlebrun@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:32=E2=80=AFPM Cen Zhang (Microsoft Security FORGE
Labs) <cenzhang@linux.microsoft.com> wrote:
>
> bpf_update_srh_state() locates an SRH with ipv6_find_hdr() and caches
> skb->data + srhoff in the per-CPU SEG6 BPF state. This assumes that the
> returned offset is within the skb linear head.
>
> That assumption is wrong because ipv6_find_hdr() uses skb_header_pointer(=
)
> and can locate an SRH in non-linear data. The direct srh->hdrlen read and
> the cached SRH pointer can therefore access memory outside the linear are=
a.
>
> BUG: KASAN: slab-use-after-free in bpf_update_srh_state+0x1bc/0x200
>  net/core/filter.c:7027 bpf_update_srh_state()
>  bpf_lwt_seg6_action()
>  input_action_end_bpf()
>  seg6_local_input()
>  ipv6_rthdr_rcv()
>
> Fix this by using seg6_get_srh(), which pulls and validates the complete
> SRH and reloads its pointer afterwards. Pulling can reallocate skb->head,
> so refresh the BPF data pointers inside bpf_update_srh_state() immediatel=
y
> after the call.
>
> For End.DT6, make the inner IPv6 base header linear before removing the
> outer headers. Pulling only the outer headers can leave the inner header =
in
> non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
> directly. Clear the cached SRH pointer and refresh the BPF data pointers =
if
> the pull fails.
>
> End.B6 and End.B6.Encap can modify or reallocate the skb before a later
> nexthop lookup returns an error. Rebuild the SRH state regardless of the
> action result instead of assuming that an error leaves the skb unchanged.
>
> Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action help=
er")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.=
microsoft.com>
> Assisted-by: Copilot:gpt-5.6-sol

This fix has an issue afaict, commenting inline:


> ---
> Please queue this fix for stable kernels.
>
> Testing:
> - Static checks only: checkpatch.pl, diff --check and patch replay.
> - No targeted selftest was added. BPF LWT test-run does not support
>   non-linear skbs, and the existing SEG6 netns test does not create a
>   split inner IPv6 header for End.DT6.
>
>  net/core/filter.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e753552..1dd3a685d1b8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7018,15 +7018,16 @@ static void bpf_update_srh_state(struct sk_buff *=
skb)
>  {
>         struct seg6_bpf_srh_state *srh_state =3D
>                 this_cpu_ptr(&seg6_bpf_srh_states);
> -       int srhoff =3D 0;
> +       struct ipv6_sr_hdr *srh;
>
> -       if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)=
 {
> -               srh_state->srh =3D NULL;
> -       } else {
> -               srh_state->srh =3D (struct ipv6_sr_hdr *)(skb->data + srh=
off);
> -               srh_state->hdrlen =3D srh_state->srh->hdrlen << 3;
> -               srh_state->valid =3D true;
> -       }
> +       srh =3D seg6_get_srh(skb, 0);
> +       bpf_compute_data_pointers(skb);
> +       srh_state->srh =3D srh;
> +       if (!srh)
> +               return;
> +
> +       srh_state->hdrlen =3D srh->hdrlen << 3;
> +       srh_state->valid =3D true;
>  }
>
>  BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
> @@ -7059,15 +7060,18 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *,=
 skb,
>
>                 if (ipv6_find_hdr(skb, &hdroff, IPPROTO_IPV6, NULL, NULL)=
 < 0)
>                         return -EBADMSG;
> -               if (!pskb_pull(skb, hdroff))
> +               if (!pskb_may_pull(skb, hdroff + sizeof(struct ipv6hdr)))=
 {
> +                       srh_state->srh =3D NULL;
> +                       bpf_compute_data_pointers(skb);
>                         return -EBADMSG;
> +               }
> +               __skb_pull(skb, hdroff);
>
>                 skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
>                 skb_reset_network_header(skb);
>                 skb_reset_transport_header(skb);
>                 skb->encapsulation =3D 0;
>
> -               bpf_compute_data_pointers(skb);
>                 bpf_update_srh_state(skb);
>                 return seg6_lookup_nexthop(skb, NULL, *(int *)param);
>         case SEG6_LOCAL_ACTION_END_B6:
> @@ -7075,8 +7079,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, s=
kb,
>                         return -EBADMSG;
>                 err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLIN=
E,
>                                           param, param_len);
> -               if (!err)
> -                       bpf_update_srh_state(skb);
> +               bpf_update_srh_state(skb);
>

Here and for the case below, making the SRH state recomputation
unconditional  can
cause logic errors. It's only safe to recompute the state if
bpf_push_seg6_encap()
actually adds an SRH up front, then fails, because then the header we
want is the
very first one.

If we don't add an SRH before calling seg6_get_srh(), it calls
ipv6_find_hdr() w/o IP6_FH_F_SKIP_RH and
end up pointing to the first header it finds even if it is a spent
SRH. That normally doesn't
matter because the caller should not continue processing after an
error, but it is still
inconsistent.

The easy fix on top of this patch is afaict:

1) Track the old length of the skb before the bpf_push_seg6_encap();
2) in bpf_lwt_seg6_action:

if (new_len !=3D old_len)
    bpf_update_srh_state(skb);

instead of unconditional.

wdyt?

pw-bot: cr

>                 return err;
>         case SEG6_LOCAL_ACTION_END_B6_ENCAP:
> @@ -7084,8 +7087,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, s=
kb,
>                         return -EBADMSG;
>                 err =3D bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
>                                           param, param_len);
> -               if (!err)
> -                       bpf_update_srh_state(skb);
> +               bpf_update_srh_state(skb);
>
>                 return err;
>         default:
>
> base-commit: 28d75dd3eb60812b3a87cbdf0d52c42f51b28a78
> --
> 2.55.0
