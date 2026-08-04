Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80614377A89
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846598; cv=pass; b=sHCdP4csBiw35Nyr+QjADPLuSSBujOiy3Wpkt81kDbUSfSgRDBtB7aRICElGJdpwIqToDl63AuuHjZp6aj+nDceqfIC5Gpecc8ilW7Ir7V98edqARe7IY76R2PR2XZo98iLiZ/6gVscF56Snss33yFhCtUz9fKd9E92yHegfNO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846598; c=relaxed/simple;
	bh=CTJjvMfktTayr1PKPGZUs7/D5/OhTcHQezN0Bw9GX3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRxZDDnvMtzAcZPniAHwdnU9bDZxGUgVBui/evM9kzR21VDn5oU29MxodYRfxNx49CDpklsW7d4r+HIoSt7khV2E/26bL0V535kDkoliLSQnrZgB17d33q/yRs1+TjjmMQ5jp5o2eGQ/9w/7ZQ8qLJYutSH2+H7XDNNBf8+ai2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YvRZCTGB; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YvRZCTGB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aea0fff535so5041884e87.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 05:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785846594; cv=none;
        d=google.com; s=arc-20260327;
        b=pGEomHkfMPSJZHxYKlkYDBSndda6sH/SdwB8mvhL4rcE3wmCwDY7Cm09bByddknr1l
         mmLF7sEGb6mAhKJR4dlYnhY5y5KXlqzHMVJvzvNUTM1IQPIN+iRFYws2Zg6I7AEsNpVn
         WrNKkGM+CIwB3Bh77ANWe0NSBCZE7CPYEoMS8EoDRaZdqZ91a0L86Io8gjOwRa7LlnZ5
         eEcu67N9jxBGTDTE325NPVv6D5QQGQLcbuoyJAvuQFpWu1RoUXSN9rzaXmlaU6HYeos/
         Vk/3yN9UzVZ88YCr3IppnAE416nGEHWe8cohtUfHBRO4rNcweZwH0vHRCELZOyz3G9+k
         r+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QvpdS8JAzoXxYd124gDiKzDcNlVD9vL8K8IZo6IJ0xs=;
        fh=GWtHI249Xszl+icZpwEIuo/X0DDVzHctDKUEJsAD0ac=;
        b=WOOXPwLGRpwt9W560tLWSZoyXgrzlu7yrocZr71WiVA3aV7lg8oqOljupznEb3WrsB
         TFpmE++1zQZcugsWkje+hku46QZF9Wt32G8oZsyYFvZL8Qj5TVUswyBMNj97Vnp+daTF
         GK/RkhxPbKIC2huNjjvFRUvKUSZFVe3dm9irKtpzsECwwXfcsRAK8D4PWLgrFxteSJaQ
         vm3QTMPp8fzr+e3tv402BSiuVqo+IxpquArP/nfeiH+qc/kbV496umfsPCvE6rYlYhNO
         7Vlz1+YMlLdNHSWwadCC0ZYPx42nMQzOGKaDyYdvQje8wCzGCA/4jwDWJ2ibpMgSX2WS
         6BlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785846594; x=1786451394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QvpdS8JAzoXxYd124gDiKzDcNlVD9vL8K8IZo6IJ0xs=;
        b=YvRZCTGBYfPDLS73vCtxQIwuGn/wOnJDgF5t8U81aiPWCDnqOeiyXQ55V8u/5EDGNf
         3RIjKC7inzlkEsrj0ggHy0/iWv5wnJ1ouFGmNqSJ1N6oi+N8/bQ3KHv/QyX2YwoWksY8
         jyBqbwPz2fLF0fzeaxbn8KzLkeRd1pXYKp7OEyHebrtLNHewuUPZBrkUq8mi5zFj7971
         tQMhdit20GWzFyzJBwjUFBjJ0tI2g/aWnrz0mXSpbPl/ORtJn6lSYPerpNpCDmSt6p/T
         H+I8guG0NzjQMHEYM7eZ7LcjfTKzsZDBx9g0TtfAicY0z7B2EivlXRJL5bHaG8bUn/az
         jLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846594; x=1786451394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QvpdS8JAzoXxYd124gDiKzDcNlVD9vL8K8IZo6IJ0xs=;
        b=Wc2Y5GtvHAvqblfyMkUHciq0Jn4qFpi2StDW80IyUuUJ9BLudk7aLRRsG8jOGL6KdH
         rrUOthiGlDtDJwcyCiBi3xF0MG/6lUHP8myErv/KyGFMeuqUSFdarkoliVLnYxUGEqIB
         x2S7X2RnGUNtyYSmvvzdSbRGyjkcuhXIzD4bsKdwppw1bht0xW/UuwxNw+862WNFYW6Z
         pI+3uC5wBiyyGiIkFJDrQQ6h5ugKrXNotiaWmGJb7V43g/l9e7pemIxTGzTXYlGNT6Zf
         AFfxu0CY7TNb9/ITyOwCHNK6DsGzaZKikf5AaP/+mANoQ0N330YVe3phSd+tngJnkcgR
         vPHw==
X-Gm-Message-State: AOJu0YzrckCq6PbZkgFV43OjZmNQTkN8PiPYVXQamyvf7HP32JwrIVJo
	3MsttcjHyhnZyg8+dKFa/97ZsrlO9Z9WKWFcVqod/7gT2fhd1ObdbbwErSnD3QeTSvMWjpW2xE/
	iblPUtpZ9qdJmL8AU/+qysM2QI2MZsxX7PbtkeSChr3E=
X-Gm-Gg: AR+sD10uf0n6mUZxFToJvm/bScO2rgEcD91xvzTfI72W9dPBLPt5TUqgH1ZHTBKdfUP
	IWG4XugsxRYU+ZrVJ07MiHOsj5X2uhYbJwuGxh1Y27OXb2vBaqnhDZqw9H7uM5HjTc3MRdcLtYU
	PWHb251hKtGY+eSH1y3rJ/0s0cR8r8tHbX4NHhDxF19ebPiVFPe/5GBHbW9gTTI87Bn8sNqZSZF
	ZwYiNqq41ZAXREYjHf5eaBc+eAhu1xLnwgpBgKU0ohvRX4Ty7Yahjhfzp+1hHLJUX9A5lkpbvX0
	Veav9OYrpKXUZ19wSQl9vfbN1y0iDP3/ocyPrQGpMVM=
X-Received: by 2002:a05:6512:668e:20b0:5b0:1dd0:f20b with SMTP id
 2adb3069b0e04-5b2e4f1add2mr1671801e87.6.1785846594217; Tue, 04 Aug 2026
 05:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785691607.git.zihanx@nebusec.ai> <a25901403c69929d6f72ba802b3ab912f2adbe63.1785691607.git.zihanx@nebusec.ai>
 <20260804120753.GA1073788@shredder>
In-Reply-To: <20260804120753.GA1073788@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 4 Aug 2026 20:29:30 +0800
X-Gm-Features: AUfX_mxjRs-Rz73Nw3mH2VTWXaJDVEm2mfNEPPbf0-PeIKqgF4VVrUBCp2gMz-Y
Message-ID: <CAANe3eT3u8KDnSjmiAanAMQRHt60WaQ_qGz_gMK=yYRwfDxcDw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net: ip_tunnel: reject excessive tunnel
 stacking headroom
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuniyu@google.com, 
	gustavoars@kernel.org, runyu.xiao@seu.edu.cn, jlayton@kernel.org, 
	michael.bommarito@gmail.com, kees@kernel.org, willemb@google.com, 
	lirongqing@baidu.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:08=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Sun, Aug 02, 2026 at 06:49:17PM +0000, Zihan Xi wrote:
> > raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
> > storing skb header offsets in 16-bit fields. If an egress device has a
> > very large LL_RESERVED_SPACE(), skb_reset_network_header() stores a
> > truncated network_header offset and the hdrincl path can later copy the
> > user header to the wrong location.
> >
> > The reproducer creates a very deep gretap stack. Each new tunnel derive=
s
> > its needed_headroom from the lower device, so the stack can grow the
> > resulting LL headroom beyond what skb header offsets can represent.
> >
> > Reject IPv4 tunnel configurations when the computed headroom would make
> > LL_RESERVED_SPACE() exceed the skb header offset range needed by raw
> > IPv4 hdrincl. This rejects the bad tunnel stack at configuration time
> > instead of checking every packet in later hot paths. Keep small raw IPv=
4
> > and IPv6 hdrincl guards as a final bound check for devices that are not
> > created through the IPv4 tunnel control path.
> >
> > Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct sk=
buff")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> > changes in v3:
> >   - Rework the fix to reject excessive IPv4 tunnel headroom at
> >     configuration time, following Willem de Bruijn's feedback.
> >   - Drop the broad skb/XFRM/GSO/ESP/IPTFS runtime checked-helper change=
s
> >     from v2.
> >   - Keep only small raw hdrincl guards as a final bound check.
> >   - v2 Link: https://lore.kernel.org/all/cover.1785529351.git.zihanx@ne=
busec.ai/
> > changes in v2:
> >   - Keep skb_segment() default error code after successful checked skb =
offset
> >     updates to avoid returning ERR_PTR(0), as reported by the kernel te=
st
> >     robot.
> >   - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
> >     transport-header recomputation paths instead of relying on raw hdri=
ncl
> >     entry guards alone.
> >   - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@ne=
busec.ai/
> > ---
> >  include/net/ip_tunnels.h |   5 +-
> >  net/ipv4/ip_gre.c        |   8 +--
> >  net/ipv4/ip_tunnel.c     | 138 ++++++++++++++++++++++++++-------------
> >  net/ipv4/ip_vti.c        |   4 +-
> >  net/ipv4/ipip.c          |   4 +-
> >  net/ipv4/raw.c           |   3 +
> >  net/ipv6/raw.c           |   4 ++
> >  7 files changed, 111 insertions(+), 55 deletions(-)
>
> The patch conflicts with another patch from nebusec.ai:
>
> https://lore.kernel.org/netdev/0ae4aa29223b89049727aec4d36f144bad41537e.1=
785476387.git.zhilinz@nebusec.ai/
>
> nebusec.ai cannot send conflicting patches and make it our problem to
> sort it out. I think we should proceed with the patch I mentioned and
> drop this one. The current patch doesn't handle IPv6 tunnels.
>
> Related, please make sure the team is aware of:
>
> https://lore.kernel.org/all/83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784=
884817.git.pabeni@redhat.com/
>
> Thanks

Hi Ido,

Thanks for pointing this out, and sorry for the confusion.

You are right, these two patches address the same headroom issue and
should not have been sent as competing fixes from the same team.

Let's proceed with Zhiling's patch and drop this series. We'll coordinate
internally and follow up on that thread if any further changes are needed,
including IPv6 tunnel coverage and Paolo's related patch.

Thanks,
Zihan
