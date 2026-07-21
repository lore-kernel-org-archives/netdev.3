Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE240B10B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648245; cv=pass; b=QpSByrUdkdy8akfPqy9sxDK/EqhzS5fclg4Jj/7yIsxDFqqw6HO4iiTpwzltthhQp9lC3ZT52hzJhErECY258KuwpsfjCweZFrK7TNJ+pu/o7IG6CbwAXM0IcYREG7zIYjiMpfw+PmlW3N8pAo81qb01KD3WYq0uxNm+J5qwFpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648245; c=relaxed/simple;
	bh=qS6BciTxCll3ZIHOBHVpTYa96f8u6jpS8p3mYmAgQns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+fwIkk+2MbufVhLueDwlSC8SX0NdUrzFJ2WZMawUUALeIl5nof9uBi3V6Cwzj8XI7vi0T5rhw1/GIG78M8+jSVViXB9rIuLVL0IjKCKgHNECwEL76vgABvJi3R4a6I8q+AujLQU9NPKrxKN7v5H/PLlrOA7/a7Cr4emAT9/+L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2u0v9FW; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2u0v9FW"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5276d598b96so2356851cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784648243; cv=none;
        d=google.com; s=arc-20260327;
        b=RgGjkxymm+BG9MhJuoPEOVQ3Ior8s5e2FEB2/StOyCZ7c6TEuzv3McFb6RKRST3t3h
         9ezGp7lm+mkdp1B7j0JWjRaeq0ETpJVCtswV/fuK/TFwNWIm7oxWHjI98jnkRSBb/+q4
         RpkO/sjQBQFhRlyklIIuEDsfnDZqFl6MWA+lfjJ5fsxa3DtyPK0+BgtUre8RPVRW1ISy
         bw1bi4RWTAG92Xh/rFUPEAShtZ5m7mC+1x4eBbYdWOoXSNdjFYOgj0gaMiWw7l/jxHvJ
         zfsHdmqznV55TKtPaTh0SIdcLhg9yVPfix+mO0HJi7UxEwXhUfllVZ/awjk3Cvm9jEoa
         Bjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        fh=80oim0HSosdBKKQHPYlkt00+nfDAMZpxmRC7mSSLlK0=;
        b=DruL/ti8z3G+8NjFt/clrYj2GVHG8JGO2uoXofma6KYRm0Sdqp+6XSNhYquxDo/81s
         Nrt5929QPcXkFvYiNSfvy1WF3p7OjiXMdWnimr2ooyQSkH+amq6LTOPOMPZ1UX2dSuBm
         +ld0l/fJBVGxY9ZckltzMtTRfU5Bzif2FBtbSGsSwe5Zkl68fP62rUNovdQIT5aL4T13
         GXsbp6Fff9n5u9qY9P1pLowh6KW3+pxG3bb4ziVFaBIWcnucb+tIAv8eHvzlZ5xcX/81
         zzQ5AAa6lvG8xmbOrSLLgZNU1jSUQHw3Ef7fD623cNGyJGxWXMjVe8XQNUnuBbvUa9Lu
         aHKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784648243; x=1785253043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        b=I2u0v9FWcaf3xvAHBI4xZ372/AwgbzV9RjgUW1hx4r0nf4ycGPXrpqBLvqaeht0hH6
         HO2gTawLExdz07ZdcZp/C69Loj9RlquTB2q2CyJmTfgONUqLkYZJUNbGt9SlRbr5nO84
         kt2vPssGXCIICk71/OEuY4ds+bgJkM/tL/mWCYVr2ZSY5WTIZEXnHK9Pv0HAVcfVlR3J
         amgVxfzDNUuaNretqjO8b66xWQsr1q/M1SzsYf4a17/hSY7a8zuSIYnl/AcbiBBvWqdM
         oRhqIRGNQv1eifuYDmc/iJEYVVbShpA5HPFjsm0/UULCzp7YKmzqX5+E0c69+maKZ5lY
         nOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648243; x=1785253043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lePK3aUOROHNA3Mxb8ZHhUYvtbwzgB3FkuR9oqw9z+0=;
        b=NTZyPuufJHtZah52xfJf8WnIawP+XnQU6Down9ON8Bf5CIffkehrfN4rdhvi2GUmYH
         1VYN7HpkXUOYeefUdQu0ocoXL8mjnMDvYMtX7694KjPx2UfidjTQAR6uCbKJQzuwVIVh
         jBoDsaf93BdfPOFPxb9NRsI+cBllN1TVtqlDl0B3rL5gc6rPkRe9/pix4OuTvA1Z0HKt
         rof1C1gLGyzKoW2rVVIhU8D5rfgBZfuK/gtE6XEag0HwabTcVH/gvmtcibr8qskbcslt
         dOCPCNBAFDQW+fcv1jfwhdjr4aygRI5uNOu5llqQVvb75yINv1TI1mCiKemhWglQZ0mK
         4YzA==
X-Forwarded-Encrypted: i=1; AHgh+RqiHq2GkxJqeilE1qCuMuAQoYTMBfLayLhezkpT2iK24r8IlTPsgUELzqg4VaCgAuolBmZKq3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LjYwgFgWwA/024HAF3qHlKWnFa4OyREnCq0uqqm4dyeL+kZu
	kTRVQa+DFuDpNPcuP1XI8iakvtikWaMhcT0jbgj3jP8uKmBnVFJqOWqZLIkbY7gzsszBgirlUdn
	uBuqbAUwPOQkW2vejT3+Cjv4dvUq37nwTJmt1ROwu
X-Gm-Gg: AfdE7clonM7pCDE0aA+mg5Qh+5pS8WrAgnkQGA7iU6mCY0q5ALeunrIr2yzS971H2Tz
	zWDLznt4E32nubWRuxC37rLF7MkZP8Mcv+E5IVlYrzj9tnFTK8YAy7FT7M1dCdbA7cZbbjpXfyw
	78nWF+4tVbr7a2EFKgH/lR33hEOPAwTnYm4fzImZqVVhOFgZrKo+eGZct/Dezp7uX0fkF+dAUyD
	pMd1NN7cHp/larV7Ahv4JEg1dp9sCG5SLBM2yLMEkQ310An1soWKqIBqYducmS+aEi1WhLOlOV+
	gyzf9sM7fRGYIK2EYqAkGVvs6ygO814IOh+mRfN5quNxCOpYTaD24PYzTmoZURaynK6O6M/kDA=
	=
X-Received: by 2002:a05:622a:11cf:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-5213e28e1c4mr178649641cf.56.1784648241853; Tue, 21 Jul 2026
 08:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720135132.3957146-1-edumazet@google.com>
In-Reply-To: <20260720135132.3957146-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jul 2026 17:37:10 +0200
X-Gm-Features: AUfX_mycCQ3lI7T05ph6-bT8dwM6bGbwo8ZivA5ulrn6TsafLZ58xKvlxuAhGxI
Message-ID: <CANn89iJqUFZYLYuhCk4htc8zxbW3hPSmuvYj3X_7vFyRsa5vBw@mail.gmail.com>
Subject: Re: [PATCH v2 net] gre: fix ERSPAN o_flags race/corruption in xmit
 and fill_info
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 3:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> For IPv4 ERSPAN:
> In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
> and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
> structure. Since transmit paths can run locklessly and concurrently,
> this leads to a data race.
>
> Furthermore, modifying tunnel->parms.o_flags permanently alters the
> tunnel configuration. To work around this, erspan_fill_info() (which
> reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
> erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly=
)
> race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldnt,
> leading to GRE header corruption (injecting a key field into the ERSPAN
> GRE header).
>
> Fix this by:
> 1) Snapshotting tunnel->parms.o_flags onto the stack in ipgre_xmit(),
>    gre_tap_xmit(), and __gre6_xmit(), and computing the GRE header length=
 via
>    gre_calc_hlen(flags) instead of reading tunnel->tun_hlen. This elimina=
tes
>    TOCTOU races between flags, offload checks, and header length.
>    Note: Since tunnel->tun_hlen is no longer used in fast path xmit, it c=
ould be
>    removed altogether in net-next.
> 2) Using local flags in erspan_xmit(), clearing IP_TUNNEL_CSUM_BIT and
>    IP_TUNNEL_KEY_BIT (and IP_TUNNEL_SEQ_BIT for v0) before passing them t=
o
>    __gre_xmit().
> 3) Removing the racy modification of t->parms.o_flags in erspan_fill_info=
().
> 4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
>    in ipgre_fill_info().
>
> For IPv6 ERSPAN:
> ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
> t->parms.o_flags even though it does not use these flags for building
> the GRE header (it uses local flags). This permanently corrupts the
> configuration and races with ip6gre_fill_info() which reads it.
>
> Remove the redundant and racy modification.
> This should remove false sharing in a fast path.
>
> Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
> and ip6gre_fill_info() to clarify that these methods are not
> supposed to write any live parameters.
>
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interfa=
ce")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: addressed Sashiko and Ido feedback.
> v1: https://lore.kernel.org/netdev/20260615140333.3161072-1-edumazet@goog=
le.com/

Sashiko said:

<quote>
 Does this code generate malformed GRE headers for ERSPAN if the sequence b=
it
 is missing from the output flags?
 erspan_validate() permits configurations where the sequence bit is present=
 in
 the input flags but missing from the output flags. In that case, the snaps=
hot
 of the flags lacks IP_TUNNEL_SEQ_BIT.
 After clearing IP_TUNNEL_CSUM_BIT and IP_TUNNEL_KEY_BIT, if IP_TUNNEL_SEQ_=
BIT
 is also missing:
 net/ipv4/ip_gre.c:__gre_xmit() {
 ...
 gre_build_header(skb, gre_calc_hlen(flags),
 ...
 }
 gre_calc_hlen(flags) will evaluate to 4 bytes instead of the 8 bytes requi=
red
 by the ERSPAN protocol. Before this patch, the hardcoded tunnel->tun_hlen
 ensured an 8-byte header for ERSPAN.
 Could this result in structurally malformed packets being transmitted?
</quote>

What a mess.

pw-bot: cr

I will squash the following:

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 442a2c9513e84e84013b4a6d447dd5e243428c5c..e102c378eeb5f0e6e9e6f710db1=
e05826e0fb070
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -739,11 +739,13 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
                                    tunnel->index,
                                    truncate, true);
                proto =3D htons(ETH_P_ERSPAN);
+               __set_bit(IP_TUNNEL_SEQ_BIT, flags);
        } else if (tunnel->erspan_ver =3D=3D 2) {
                erspan_build_header_v2(skb, ntohl(tunnel->parms.o_key),
                                       tunnel->dir, tunnel->hwid,
                                       truncate, true);
                proto =3D htons(ETH_P_ERSPAN2);
+               __set_bit(IP_TUNNEL_SEQ_BIT, flags);
        } else {
                goto free_skb;
        }
