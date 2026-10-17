Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF7348463
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235164; cv=none; b=KTRRolw42rlFa7+n2uPd93pTQgJS4oUbs0Y57LEvWrZKyLQRZL843CfWpsoPW0BPVsATJVhjH1B8YRorOYsXBYQL8mUPtMoyvDJkOlMPc51HIbgFx0fcmQCjB4gspm/aRdOQv7YwoccB3zyqPFaYw7wH6l40AtGbi2490dY+JuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235164; c=relaxed/simple;
	bh=5vSJeRW0ANPhARuHFh5njb6tNgaMCB6qsnuHC52Td0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzfQicVdLst1qDL5zHOfLuTA853eIspDo2Xmh67O9M0aB5ZsYCCWQXt+x2pp0xdYotyHTHkURvMn671G56iI9w+vs5Uvewq4zsYK6CnouiGiYKuE0aeclfQXypOP2tGFOaiNMe5oAz1Ni1r8fGYjuaqu+q9vzH/KfOY1rLQ/2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHticw7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHticw7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6531F000C6
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792235162;
	bh=4Lyf79/CFRfNECJZi3p/V7HeAozJnCmuLEKy9AB9hak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lHticw7OGAS+NXKzlRHVu1J5txowCerFqQngVWTumUvfa8+JvXpHfAbngPwQSJjPy
	 kb8hKU+EqZZrnSj+rpw1cVApepk20J43DKlHep9nQXmLwlvZ6kHe4TK01u8C83lgnd
	 YCAculdeA+Q16EMEx36sCySDFX9qXbS2jF9vnOGPKAHe7vf2JxgAqTzsoOj49cbYkn
	 +GUtuG/GOd53EWjSMaQ9ABx4cLgbV+GHvasoTHBYn1Yni8e1vYp1oHIxRIk96OpPgg
	 hzPmCg9BVdUmTLRi2Qi63K4ILgZ0skGe8zgrdhlv5wMYngUDwxBkoFrB10A1GfPqaV
	 obJVxOBosunuw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-483d290f398so415889fac.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 04:06:02 -0700 (PDT)
X-Gm-Message-State: AFq9FYLU/I+fH/irc94cZwZS+RwuYoWKKgnEvsHf5NdfecI2QbuPQfVh
	tRQg+UrsnH442C7s7Ds181qVIyol5OEGRVu7eAXwFHhwnZh7YKyOhD/OLgKPIc91IZIdKCk6dZJ
	cN+kWNZXRB2TdcIaN9jgfbp3Sj/cfbZQ=
X-Received: by 2002:a05:6870:70a0:b0:4a2:4dcb:fa75 with SMTP id
 586e51a60fabf-4a7575d2b72mr2344146fac.2.1792235162011; Sat, 17 Oct 2026
 04:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792215075.git.zhilinz@nebusec.ai> <192b5c65be8b370c1e6e4f6a31edf03d2606f427.1792215075.git.zhilinz@nebusec.ai>
In-Reply-To: <192b5c65be8b370c1e6e4f6a31edf03d2606f427.1792215075.git.zhilinz@nebusec.ai>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 17 Oct 2026 13:05:49 +0200
X-Gmail-Original-Message-ID: <CAL4WiirgJTWD4sqz_v_1=gZx6DKC5psXxEB77hPk1PSGQGi2Yw@mail.gmail.com>
X-Gm-Features: AclHuK8I9ohLPOlAF5sGI9Jz-SI4empVjirSy5EzKLD2g7kwg6zbOlo4qJUQN3Q
Message-ID: <CAL4WiirgJTWD4sqz_v_1=gZx6DKC5psXxEB77hPk1PSGQGi2Yw@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] ipmr: only copy pktinfo to cache reports
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, dsahern@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	leone4fernando@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 17 oct. 2026 =C3=A0 07:40, Zhiling Zou <zhilinz@nebusec.ai> a =C3=
=A9crit :
>
> ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
> ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fiel=
ds
> when packet info is disabled. Since the skb can continue through the data
> path, preserve and restore its original control block around the helper.
>
> The original implementation copies the entire control block to the report
> skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted a=
s
> IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled=
,
> corrupted option offsets cause out-of-bounds reads or a stack buffer
> overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
> offsets when their header is prepended.
>
> Clear the report skb control block and copy only the pktinfo fields
> prepared by ipv4_pktinfo_prepare(). Doing this after both report branches
> preserves the input skb metadata and clears inherited IP options.
>
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v5:
> - Save and restore pkt->cb around ipv4_pktinfo_prepare().
> - Prepare pktinfo after both report branches, clear skb->cb, and copy onl=
y
>   the pktinfo fields; this also clears inherited IP options.
> - Add the Fixes tag for the older WHOLEPKT/WRVIFWHOLE issue.
> - v4 Link: https://lore.kernel.org/netdev/d8a36c317f6216d20f9cfd7e49f1888=
f62c35f7c.1788417128.git.zhilinz@nebusec.ai/
>
> changes in v4:
> - Clear IPCB(skb)->opt when prepending the 20-byte WHOLEPKT/WRVIFWHOLE
>   header, so stale option offsets are not inherited from the original pac=
ket.
> - v3 Link: https://lore.kernel.org/all/e93d0d2fa5725ddd06b20e3e4223ab68b9=
3b48d1.1785719031.git.zhilinz@nebusec.ai/
>
> changes in v3:
> - Go back to the v1 scope and stop changing the common path.
> - Remove memset(), since alloc_skb() already clears the control block.
> - v2 Link: https://lore.kernel.org/all/1b809975e5bd9c0a1dd6fdd1db534e701f=
e5a4b6.1785379072.git.zhilinz@nebusec.ai/
>
> changes in v2:
> - Reword the commit message to say the entire 48-byte skb control block
>   is copied.
> - Mention that IP_RECVOPTS/IP_RETOPTS on the mrouted socket was unintende=
d.
> - Move the pktinfo copy to the common path to cover both report branches.
> - v1 Link: https://lore.kernel.org/all/5bc7cd71c2d671b305f25497d88ae8a0aa=
663c08.1784894076.git.zhilinz@nebusec.ai/
>
>  net/ipv4/ipmr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c45..ef0d73e45b70 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1057,6 +1057,7 @@ static void ipmr_cache_resolve(struct net *net, str=
uct mr_table *mrt,
>  static int ipmr_cache_report(const struct mr_table *mrt,
>                              struct sk_buff *pkt, vifi_t vifi, int assert=
)
>  {
> +       unsigned char pkt_cb[sizeof(pkt->cb)];
>         const int ihl =3D ip_hdrlen(pkt);
>         struct sock *mroute_sk;
>         struct igmphdr *igmp;
> @@ -1112,8 +1113,6 @@ static int ipmr_cache_report(const struct mr_table =
*mrt,
>                 msg =3D (struct igmpmsg *)skb_network_header(skb);
>                 msg->im_vif =3D vifi;
>                 msg->im_vif_hi =3D vifi >> 8;
> -               ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> -               memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
>                 /* Add our header.
>                  * Note that code, csum and group fields are cleared.
>                  */
> @@ -1124,6 +1123,12 @@ static int ipmr_cache_report(const struct mr_table=
 *mrt,
>                 skb->transport_header =3D skb->network_header;
>         }
>
> +       memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
> +       ipv4_pktinfo_prepare(mroute_sk, pkt, false);
> +       memset(skb->cb, 0, sizeof(skb->cb));
> +       *PKTINFO_SKB_CB(skb) =3D *PKTINFO_SKB_CB(pkt);
> +       memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
> +

One remaining issue: for the synthetic skbs built by ipmr_get_route(),
pkt->cb holds NETLINK_CB, not IPCB. ipv4_pktinfo_prepare() still reads
it as IPCB: the iif comes from creds.pid, and IPCB(pkt)->flags
(l3mdev bit) from netlink_skb_parms. Whatever ends up in the
IP_PKTINFO cmsg for these reports is meaningless.

These skbs are already identified by ip_hdr(skb)->version =3D=3D 0, as
done in ipmr_cache_resolve() and ipmr_destroy_unres(), and they only
reach this point through the IGMPMSG_NOCACHE path.

Could you skip pktinfo preparation for them in v6, and leave the
report control block zeroed? Something like:

memset(skb->cb, 0, sizeof(skb->cb));

/* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
if (ip_hdr(pkt)->version) {
        memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
        ipv4_pktinfo_prepare(mroute_sk, pkt, false);
        *PKTINFO_SKB_CB(skb) =3D *PKTINFO_SKB_CB(pkt);
        memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
}
