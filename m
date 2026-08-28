Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAB2F7EE6
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924240; cv=pass; b=NYvdLV7zIlDHJKWlpFdPc9hbmt8QwxAHBzyY9gLpILpxmUGyZdw6T20QoQ7vGNRCHEq3eCFDqnyuoTQMbsrdTrGKrfc6zsG/1L4HieSRv3Bu6HqroAV9t1PvVnhjE6MNnrfpnDmfhrg3Xb1l+jZmJTAy2oI5fZxcINlmr1Fbsr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924240; c=relaxed/simple;
	bh=wg57sUsILpGzs3wMFdfqrDr8NvoJKRhA9queg8TUkrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwicIpksFyrFZ/meqs0QG4H0ThQfGC/0BnrpGuExZ3xZp8tEF5kihBNkt3zuLXVAyV+oLJH/WnPVhaGZMKttbFaMj3rcpw9jx/2giMPAiMQba7pPgGDgApRnzlEu6aS0nRihkjFWoMiTAHb4xTdII+seHecnDHeAD1r6brNE6wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NyFb4WQi; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NyFb4WQi"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52f9e79ed93so8199691cf.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787924230; cv=none;
        d=google.com; s=arc-20260327;
        b=SNNIRn07ayZNXxAbiw2HLlkWcI+KX9vyoZJtq897sfoLniXR1ZSPH0coaXi2q+Inr+
         rHq3NQ2nJ3NDUrMwJl/egYsS6NZEpCehwMh5ad2+PzwiAEr5ph7KbEEssTn2dTcFl/Pg
         6U5yEIq5eesxoGpsAyMDNGsn/nEraC6Dw9fGeaZUYkTI3rG3vUc14QjqOwnjqXodwiH/
         JcEMPIcnTsKOOQ2T0TKGPcXE7LZ58uNyx7HDZwguL06MBh96lL0toLiUL2n3i5bnwZqL
         eE4fT6CgGx/CZsPyXwaqeodTZTq3zfmIKM0lz72lu2WJm9Sc3jhkVxWm8deGxy6nOPPX
         CLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+znoSvKwCcjdVmh/xj84lHzBatuQaO045NE7rMTcrI=;
        fh=QsVX5QqQh9wlixgvPgw3yJa/JRSQ2b5WqhoiOryboqw=;
        b=C9Ss0ujJqGagC4Glv46l/G4wlXkzzLVDFmxoC4Qm0XqEtRAgGW2B7cwlsTHINuzWJx
         +LIEx1Kf+wume7gbZIy8wRPTZ+xWzQ08ekb0lwHPSlvxSILttRai1D9WksXC3PCIw3Ae
         R5WY+p3/i/w4NrwO4+z3li0u2t+BmbBs8tW3UAeeY03XHgutxE5asaiFuOoQiQlmfQpe
         mRV9OGHYxWS+7243w3yLZUursFDGUMWMPcQ3AVCdgs2umXiZjOoL9CEiZiVPrurW5V4g
         drf3BcN2ocf7g7hw7MFiBVy77+nfVK9AQ0CItrbRtoC+O2H8txibZd3XZFflHGNlSbjo
         ai2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787924230; x=1788529030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o+znoSvKwCcjdVmh/xj84lHzBatuQaO045NE7rMTcrI=;
        b=NyFb4WQiaGLfAULrCjeylPBqb2qr8vv50nCP6kwoN36toOMYk+ba4NN2veqT6ASy2Y
         HKrCBbf9l9CD3VaWCJIP3bot+3qe92u8ZHuFwrAkhKsOe+slCE93hz0WHm7CJAXpWHoj
         iep1l/bkGI8peCE/vsrFsB9NJ3JsorLg1GJ72R9Ui6mRuJ69qoDMZvg3nS2jj33MbKin
         EnUq8NtPLZFGfBkOMcKIXaM+dlTFv20udx1bwuXqm/XCKVi1Al8ZKDfV7PrCmGJyi35H
         fQQ8fMmOUXOraM9NDsSXL8AB+wWlIqHEfwfArhzJbhvHFeGxbNIvhX2nu8CigaETTF/q
         iWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787924230; x=1788529030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+znoSvKwCcjdVmh/xj84lHzBatuQaO045NE7rMTcrI=;
        b=kkYInVG8GmCJZrutUvSSisUvilwYcQnDa1Smm2xtFPIljIK5gLUue0jVxVG0VJ9mQm
         i+X/+kaC3fhUgC+SqPtzfgZYdI/swLMT3lkk+d1Srq5SUZ7MK3nbluN55xhr+MmSv8k6
         1rVA7mNkQaSyih6IuT5hCk4pND9zdaH0u9v0pPypWq3lWxsk0IBFcfJ4wSaRNalyYQJd
         vCNaKo02HfcjjIoKuwjVV30Iv/gXV1RL504Z7tdwCsaEddcpzUpKQBLG8y2KppioeIgB
         d4CO/3suAGlUfY36e71o0fw55uWYl4EmoW9ls8dYXjTm9cNWK5gC6XO08YtipafrvYL1
         9n8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpiOyDuRQpjwEHnV2tKCJBZK3YgFitmd8IDxtuIQ6+0v+9LbpXwUnMKwYkavgTQgyHlNySKXLE=@vger.kernel.org
X-Gm-Message-State: AFuF++nNuupaHw5EKCGB8xdP7s8cWjKDgoBULqAO6JjbQN2NK5dCt4Dt
	4oRFXC9lFNtqfvJF/zAXCdknCdEYArm/E5xTAnw6mCMmvJrWgf1rOgi/jT72e2KNAftBHxnEPGN
	UslG1hhdOEGOs6NS/9dCHbL2jmkYtNHSYA/ql6gSY
X-Gm-Gg: AR+sD12yrcyK4hb2FVX3IC1Vmyo8soeRWCNe3sAC7WNSQu02Tn33OHdPxYuRbhYDKfp
	5EJHmhLSu3RrAYTxxKSZUnxEZySdsLnu8STiF/RHShh3JjdUIzNzwLC4kUOtfnd5jMa1lq9jrm1
	ivkX0CLwapcPqVI3DY/U0MbQpVvHmLXHDcissI1+rndIdDav3gU+VnRDvylwJ2DX8gFlJDhdrab
	zxTJ7gN1/BfZzZ1GD8ySmNX2Y1fbnUrLaSoSxOhyicW9oELKRaA2bk65ZBfzoyxS4SwvKMqv8t8
	wHDmmH6IIXRs4q/QMIKAOicCMwUMpecrzrNsz5uwq7Y3U4bMXCze6O2PNdYSzheeta8vY3rqbMb
	xDlWsEoUNBNILljNNgYIh7770qsV/hBaj0R8UWXbHkhA8SQGE9sJcQZw3Le0=
X-Received: by 2002:a05:622a:180c:b0:52d:7b1a:d7e0 with SMTP id
 d75a77b69052e-52fb962beccmr73492121cf.32.1787924229365; Fri, 28 Aug 2026
 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827092345.2301937-1-fouriezhang@tencent.com>
 <CAM0EoMnPbkMWsUB3W2TuQDmkN_GN0Rp0MMurCGgvOXv3ROy7GA@mail.gmail.com> <CANn89iLvzamYctH5EC-4xnWh04vF2fi7Nji7JVbjawwKQUAtfw@mail.gmail.com>
In-Reply-To: <CANn89iLvzamYctH5EC-4xnWh04vF2fi7Nji7JVbjawwKQUAtfw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 15:36:57 +0200
X-Gm-Features: AcwNN1W0tSqXP32e2rpDF-QW6QYLgx5-f8L9ie_1cNcrvhzxvY4846koUm2zt94
Message-ID: <CANn89i+wsbkF87jivV5br_a=UTrHRRDxYaBGfBcmp+mVD_OEqA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_frag: reject a negative L2 length in sch_fragment()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Fourie Zhang <littleddfu@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Fourie Zhang <fouriezhang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 2:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> IMO this is defensive programming working around the real bug in ipv6_srh=
_rcv().
>
> Let's fix the root cause.
>
> I saw a recent patch which had some issues:
> https://sashiko.dev/#/patchset/20260817104128.22681-1-juny24602@gmail.com=
?part=3D1
>
> It's funny that both patches were assisted by tencentos-corvus-ai:kimi-k3=
 :/
>
> I think something like this could fix both issues:
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 51941ad656a36e739388c7da2fcd639ab0e453b5..09a4552f7f08aa8208eb981c0=
536c58a3561ecbd
> 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -445,7 +445,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb,
> struct inet6_dev *idev)
>         hdr->segments_left--;
>         addr =3D hdr->segments + hdr->segments_left;
>
> -       skb_push(skb, sizeof(struct ipv6hdr));
> +       skb_push(skb, -skb_network_offset(skb));
>
>         if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE)
>                 seg6_update_csum(skb);
> @@ -469,7 +469,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb,
> struct inet6_dev *idev)
>                 }
>                 ipv6_hdr(skb)->hop_limit--;
>
> -               skb_pull(skb, sizeof(struct ipv6hdr));
> +               skb_pull(skb, skb_transport_offset(skb));
>                 goto looped_back;
>         }

I am running our net selftests, and if all green will send this patch
with a changelog like:

ipv6: sr: restore network header before routing and forwarding

ipv6_srh_rcv() runs with skb->data at the Segment Routing Header (SRH)
while skb_network_header() points at the IPv6 header.

When segments_left > 0, ipv6_srh_rcv() previously restored the skb->data
position by pushing sizeof(struct ipv6hdr), assuming the SRH immediately
followed the fixed IPv6 header. If another extension header (such as a
Hop-by-Hop options header) precedes the SRH, skb_network_offset()
remained negative.

This led to two problems:
1. During ip6_route_input(), fib6_rules_early_flow_dissect() invokes
   __skb_flow_dissect() which passes the negative skb_network_offset()
   to flow dissection, breaking BPF and C flow dissector logic.
2. If forwarded via ip6_forward() or redirected via act_mirred, downstream
   handlers (like sch_fragment() or neighbour output) pass the negative
   offset as an unsigned length, triggering OOB memcpy or buffer overflows.

Fix this by pushing -skb_network_offset(skb) before routing, ensuring
skb_network_offset(skb) is 0 for route lookup / flow dissection as well as
downstream forwarding. On the loopback path, pull skb_transport_offset(skb)
to restore skb->data to the SRH before looping back.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type
4 (Segment Routing Header)")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Reported-by: Jun Yang <junvyyang@tencent.com>
Reported-by: Fourie Zhang <fouriezhang@tencent.com>
Closes: https://lore.kernel.org/netdev/20260817104128.22681-1-juny24602@gma=
il.com/
Closes: https://lore.kernel.org/netdev/20260827092345.2301937-1-fouriezhang=
@tencent.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
