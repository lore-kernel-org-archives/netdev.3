Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BA3F929C
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204946; cv=pass; b=Z+sgpkrFBTezPNrLo6lTjSWoq3VO4ai6QNLijdeuUfxFnyh2odsVUkpWsRwTbaK5SXZFGPmKEYBp8XVHeFWC7G0+hjYbLynmid5babEBWOBH9FQXMo2XzafJw72MTtgsL7/9TboxSNlIxpDSF6AyqiCAiz5eSf4thgIJF9Slwis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204946; c=relaxed/simple;
	bh=aO9zUlhZ/cIsv4TahIImjijy5eZpJLxUISCtfDgt/zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HED+w8tu6063Vd9HHE/w6HwcQpHhfsShXvzD4jD/NCzDM29eUUyFJsqRCEIYDJREke0gJcBPt7dgniNMixus2g9x6B0JbhCyi0EcF5kcmrJj5pTKe35wl/ezGNRDrz+VlEiNcyY0jOWqRPU3gMYEg/XnsCyPFPCRqGTZInKwt4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aan9x3L1; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aan9x3L1"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d1so10119051cf.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 02:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789204943; cv=none;
        d=google.com; s=arc-20260327;
        b=J+jOd22Um0snl8QpuSQhvWS8tKA6XyIhzENUQxlLarDoKf5nuMxRIqPCO3RPuveTk6
         sXh6uPZ4eIxx/H4+g4+HuXed9gRfnQkDA2kmU6jZV0jG3Bo/MHeuZiBcz8WsfdCsidLb
         MpTTnnhK/AXsz431o1hpwGGDXrIOD+oqKo7Wrkj1OAEql4ZlMckgaSjJsgPK2th5oP2y
         QJjZ9n2bPJ3QTvUZo5zrAkGX/yl/uDIh6sXyDUWPQlVyKLiIxE3zHQ6bOe7jaLCfNDCN
         tWcZwvf69ZSBDC14uqS7An5SJA2S2ulXf9dsUG5g54lQUBqca6toSGUejsmtlyEk4ges
         GX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        fh=M+Jq/vBRy3rwq2dxV0l0PpOMS5MVzA8AOvE8p2w/wLI=;
        b=agjGgKs7rF3Yx7dBPltl4ClN9OxAmdCYIXFu7UsNoWTa3Q3nZmpZFgNIzCry/fy6pT
         SZUKHEfPKwCwNU0+pCWNibDTJFNgG3qp2ipynWnY7MqCsl5jd8osQCAJAf8MgF2Igyxd
         EcqMAuh3SYurcy9sByrBxZGcaENJn8RPC7KmRjnB78Aive7rdNtfKuZM/jUARxwhNVKi
         YWgU+5FRa0lQD9fCTzk9JMWCe/FakTLwzOM7lpWrUj84WSyUsCQQqmtz4w7iLTJi/8d5
         iwkW4TzXkBj/N+7ldQ+CFxAddE+zVr978S1RJBrp+gBmSQ2+1ihx43tTc0mCYIymEV1z
         0/yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789204943; x=1789809743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        b=Aan9x3L1Lt5oHgui16Ioup1xXWhpqxzzNO2wiUMssNcxnhXGG13f9316vSC60/ytw0
         Tnp17vAc6ly0XcjzgytE0uxOjpeEu0RERMMIWn7x4iDgmOS7q/vqpVyY4HZVYtCFQg88
         9k2OcIS6j6Euv2kVxq+jn1v8sQl+T8azF0stGteBQ2ppEsYMFlWUeHi7F89Mp6hYolPu
         t13BGKo9rgnCb0iSQTewddHGq9OdNmnszSnIqvhR/WyDrV6MLvWmSYZKuyi2eMPj7fMT
         /8LE+1K/fOMkWsC6WB2FMaTnBOnhWvWRwWJWKVOnxZ++kxGZcYStPXLkCvpUHcmI6VEb
         RJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789204943; x=1789809743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Po/KtSuUEH8MfPngI4Th6eiOf/oind2PYZNZlItxXP8=;
        b=W+AauOuGSej/TFmOd64YUlN4vYabJyV5ojseW2GTbh/NHNfGp2VKaUnXEhk7NVqQRW
         3/5KjJQNwFOQjoh3ZswWlXkQSvaeGtaUS67mNJHE+A/INsUMZXl2F1FP1VTReIotR1pa
         yfdsZBqmNS3kU3Q/Xb71HU/VHKDa1e392NSlxqySXFvLjyL6jXKJzmvYOxs3GG98Ovh2
         sdr7Fq90Cb/itTOmCBF2sQsjcNgjdPT2dsfQxDGrQwR1OBpSDIfdk8RV147ryalxj26j
         Kent4OEb+n4cdeYfGECqgJXzar3TeVOlKTLt4DBbBrn65El3ug4PbJcYVRm/VhISfvP3
         oq/g==
X-Forwarded-Encrypted: i=1; AKwUvBzndLTpXM2Vfs4EtJQfEwBTrXcSOHlhJfZo/9qb+LUVwjK3oS/lpACSqIkfZhDuZLqsGuUAGnI=@vger.kernel.org
X-Gm-Message-State: AFuF++kG49CbZ06AfIOWSY6aawolPqnv8OgNXojHDrnlkqrwb4noKiGa
	2aq4FANzAlA8xvecWyssBog/IAzcM6IkuuUy0l7Ky7M/VwJpChl4uIULCGbCEcJvjS59pEOC967
	5lOLh/TIbjxhr/5LNFo6iBXzcUAlNpJGJyNJelT/d
X-Gm-Gg: AYBFou036IsC5Cik9GO/NuQ2jiOZaqcmW4tKRRAEBKUJ9eVlcmgZARLByJvCIMPOB0X
	gcUkvE0z9WKgNCRAmFJaQfYPrHHlQcSxqhzOqZYGVrZY5PGOWp+1qUN3c1+MaXbldfdgXch+/pA
	mx8c12v3mm+OZOsx9kPKEdS5RoaXpbaSeWwuCkUg72DnDtB3OusXSaZIyGY1LvYretBnqMLgP6/
	XsxGyPC4QuA3isjSbg2AIS5YyukAz/LhGsV8HxP9zico2w2Ht6yn+49zp93NjZRQ6EzcUHtTYoe
	4hvIKE1gROonRg1p6edN6cTqSOVrIOvhqbyQ5Bs89VPu0lk3daV7zBm/9zjhD9mt5JLJtZCTDDg
	ZDgrHC/E/GNxJxQjL2O+YTV1n5JoWKO8VaBcU3pvqr/9U/4Ajp8VT/nPoc64vOoev0Zo=
X-Received: by 2002:a05:622a:13d4:b0:530:e080:93be with SMTP id
 d75a77b69052e-530e0809981mr66816991cf.46.1789204942535; Sat, 12 Sep 2026
 02:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912055304.1415016-1-cnfourt@gmail.com>
In-Reply-To: <20260912055304.1415016-1-cnfourt@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 12 Sep 2026 02:22:11 -0700
X-Gm-Features: AcwNN1V9Y4R_ylpJWfxtuU1JoTDq0Gs2lcrzQUAf6_3bVo65JvmOfd5F0cefuwQ
Message-ID: <CANn89iKk2smjZ5OVJGQBw+F1KJ8DDdfMUmquSKAUq16rMcHg8A@mail.gmail.com>
Subject: Re: [PATCH] net: ip_tunnel: initialize `options_len` before
 referencing options
To: Gris Ge <cnfourt@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:53=E2=80=AFPM Gris Ge <cnfourt@gmail.com> wrote:
>
> The following command triggers a kernel panic:
>
>   ip link add d0 type dummy; ip link set d0 up
>   ip route add 10.30.0.0/16 \
>     encap ip id 300 geneve_opts 4660:66:11223344 dev d0
>
>   memcpy: detected buffer overflow: 4 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>   ip_tun_parse_opts.part.0.cold+0x10/0x10
>   ip_tun_build_state+0x116/0x2a0
>
> On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
> `memcpy()` got 0 sized destination with request of 4 bytes length:
>
>   static int ip_tun_parse_opts_geneve(...)
>   {
>       ...
>       attr =3D tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
>       data_len =3D nla_len(attr); /* =3D=3D 4 */
>
>       struct geneve_opt *opt =3D ip_tunnel_info_opts(info) + opts_len;
>       memcpy(opt->opt_data, nla_data(attr), data_len);
>       /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */
>
> Fixed by initializing the counter before the options are referenced
> matching what `ip_tunnel_info_opts_set()` already does
>
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_t=
unnel_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gris Ge <cnfourt@gmail.com>
> ---
>  net/ipv4/ip_tunnel_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 5168d546ea2f..8fb4742aca92 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -711,6 +711,7 @@ static int ip_tun_build_state(struct net *net, struct=
 nlattr *attr,
>         new_state->type =3D LWTUNNEL_ENCAP_IP;
>
>         tun_info =3D lwt_tun_info(new_state);
> +       tun_info->options_len =3D opt_len;
>
>         err =3D ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
>         if (err < 0) {
> @@ -753,7 +754,6 @@ static int ip_tun_build_state(struct net *net, struct=
 nlattr *attr,
>         }
>
>         tun_info->mode =3D IP_TUNNEL_INFO_TX;
> -       tun_info->options_len =3D opt_len;
>
>         *ts =3D new_state;
>
> @@ -1005,6 +1005,7 @@ static int ip6_tun_build_state(struct net *net, str=
uct nlattr *attr,
>         new_state->type =3D LWTUNNEL_ENCAP_IP6;
>
>         tun_info =3D lwt_tun_info(new_state);
> +       tun_info->options_len =3D opt_len;
>
>         err =3D ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
>         if (err < 0) {
> @@ -1040,7 +1041,6 @@ static int ip6_tun_build_state(struct net *net, str=
uct nlattr *attr,
>         }
>
>         tun_info->mode =3D IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
> -       tun_info->options_len =3D opt_len;
>
>         *ts =3D new_state;
>
> --
> 2.55.0

You forgot a 'net' in [PATCH net] . Please read
Documentation/process/maintainer-netdev.rst

Looks good, but please add a comment on the assignment stating
it must precede the option parsing, otherwise a future cleanup might move
it back down?

Or maybe use something similar than tunnel_key_opts_set() in
net/sched/act_tunnel_key.c
for consistency.
