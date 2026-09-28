Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A337F32C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622457; cv=pass; b=ph8D4rq/PSEUFtXh/l2oDTG+Wgi9LMcqWhp/DGPZXdusA8oJqZL5meuDBwvnvva/iKQ6+TTkyHQ49cqX9/JOa9cJYv5G7LEdwc1wToDZKjalSmp9ILGFG85BCMGEE5t7w26TUshq+NCVJC8KcC+9O7wHH14CZm0fVvA4lVw8/uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622457; c=relaxed/simple;
	bh=mB0RvlE25HuB+oI2FerQfo3MWbT27GvROGNn0YbnbZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEARVStuac5zoYC63ezUwCEDKsVDoiqauWq95AkhnzW+WO5p4gr7e4BgQa16uruhloCbp/IEsm6yXINLHcgBwlXvEBBQea9oVwS1AWMmL7SDoryGAK1DuNLHGMl3n1kpnFW0QG28KgcCHnYd25GBgwLdqkLU39B48qxfp9eOP4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZijnN74G; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZijnN74G"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a7411012b1so30723407b3.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790622455; cv=none;
        d=google.com; s=arc-20260327;
        b=ELNbABWlcjEYEGXmryyD5FzGU40am0zU4+U9wBld/qS4pf1f195jkn4xW7Zh/CaUdx
         a/ayMTNzdRPGftY9+l909zP9ML3NBM2C1wGPAy2vAc0bRYBiko2esgtzyZiwjoJVThPJ
         Yapyoem9cDv9YjEsgdLlhDvTMBLNeGk+t3MQannVKWZRFhS0PpVxAxnxN2AwJsOx9XAF
         kIBO3sWe0u7frCh7rB7Z2h7LNKa2L1BHTvDtgB/uLTgpJdgCMgSWtl3pFBKsqR7tSCpk
         gf/hpJJtfxy2yZpUMX6IH0RRHiQ59zh03DIlyLevupbezapOmyBQBdXQg/pV7AvqjDzH
         lUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1rWWFRgALxS+6OyWmcf6zXJY8MJ8HTT2vaNA3f/r2M=;
        fh=Kdzf1Sh/lORVlTczgq2Wix3OTtV2FhOvExTnOpOrBhg=;
        b=EhRUxd7YCkWSrBz3SDRKWcQ8mC9iPaJcpEc4jHyXUDROLl1tBq0e8zH6Stg5NpX10Y
         ayyd2rf44De1SF9/FLWlZfIbchZ73mINIgK/lJW39va7dpGrbw+11+yiYMC9sV0Ufo0+
         WTpJvkO/dbgw57Y/mW3y3tdtgBv+3HMGB03qIFKFwFBWnlp2hrmsqngqNGA0nBfRg1XM
         chK+hWxGFURmV1rLe/uXMZK6mF0G3u5YVZU4LZTyQafx3I9iqMU888FfznJWby0EWcjO
         JIIi/69qLtlfYw2Am3kULxe2qR4v8GxwC+65Kp+Gpe8NBqSIgS7D9ewveDZx0P+Fuuer
         +93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790622455; x=1791227255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1rWWFRgALxS+6OyWmcf6zXJY8MJ8HTT2vaNA3f/r2M=;
        b=ZijnN74GRuKAwztV7D/AwoKNiGgNSJ4eD/oSM8Mm4blW3sjKO0VUhuKEbWkd2/KwpS
         4ZVq+i8HbmFIAXDgMBorxQRjXE9KYISjuCxNszJiWWwKrCWHEEfnvpiNP8lkoYCZ5JZh
         9lymX8sr3w2EAmBiNM5wy+313VAUDfNNNllwkBhSyqBJetXzK5J7mk53uNkxCsLEY8m1
         Th4cREgk0TWXUA6PoGMRjYutv+tlxhZzgmrHe5yEs3xKS7IH+xOaYIRy8/FSPwx3PRsZ
         PR2qx7e6pjmM3RF3CJ1NWLCl/Zo7BVT67N7rA4SXVyJpbnMWQmRCCKBcFsX3Lgzkn6vA
         trTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790622455; x=1791227255;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1rWWFRgALxS+6OyWmcf6zXJY8MJ8HTT2vaNA3f/r2M=;
        b=F+gacBe/B65jkVIVOcgef+xRc+Lc5UTbdJteDZI/GrLmtxMb3ktSKh0xqMOqJP11rQ
         h57roLHhrSC5da8M1jTKJsJspnkI0m7wSuxWFd2bu6c50BkEjKjZuQhmXMhPZbQGrjY9
         /Asn7aACPsrsdBjUrtxvFmEe4isOSTVZ6Vx++gDe/qS1jCkEDF/hpPXza3Y9Tdo6GvHr
         nxPTjC9NW9n03NBHbVpHKX8KXTMMIm2x2etVlHvaJ8juX/vmAQ2nYxy0uml8Wn60/sgY
         KksWIgfWLOwamfE75hnZz5MAkX2dPdHVz4ASuyZzDi+eOGIOUn7yIZAnYUU4dKgqTM8l
         oXmg==
X-Forwarded-Encrypted: i=1; AKwUvByQiT+V3HR5qjcZKJ8Af1pLo1uQw1H8xG/T46z5YlsQjFjX+wdy5RgmI6IupPXhmBVQrI6Mb4o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNhPuFJ/SrOjabbyEnE2oBBZ3/F/MVDZIV+j5MlsHWK3LKUhcX
	99V9WIYc+wiu6XzVid6tVAlbdP/C2pZJHCe6DRm8FMVvPnZDkTxfUao7LJXtNuVTzyTuf3yw9u4
	HT6r/fnvGCsY4lIcHnLrPUVe05GI9j5k=
X-Gm-Gg: AYBFou11BpNyYamck4eMatlt95fWn4OdbW9Nkn1HC0OaFMIfbqmVeXUUNeNF7qn/HNe
	x2Uwl5UNQBQTonHYsOiags+B1W4r0NlT7epfPkt5n5CRaxsY1XAFUuTWUZHDFeTnyR3ZDuFyMWB
	SfjVkBKGUFJM4xxEQ3Ij/f6JYXM4prq0A0BFUmhlUtmI3h6dL3IeIgBIzwibSQ9n9ZlBCCblbmH
	/ZZuWWTqlrjdKm5PLaWX758ZosxSFcH+/xCnmwS0psGWZGb49LYyBh96+wlSWwLUmNMucIJOhBU
	2M8UOjNyhYhGPy0aj2rCj5kDH+57+HM/MVBxhi0Ho7ZP5fNXsk0UwFeK
X-Received: by 2002:a05:690e:1c1c:b0:66f:c1bc:4099 with SMTP id
 956f58d0204a3-674113b1981mr3391914d50.92.1790622454990; Mon, 28 Sep 2026
 12:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922214150.13970-1-cenzhang@linux.microsoft.com> <20260923225630.95537-2-omar@blockcast.net>
In-Reply-To: <20260923225630.95537-2-omar@blockcast.net>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 29 Sep 2026 04:07:22 +0900
X-Gm-Features: AclHuK8fycl8FACgWAFXcvlmgw3ZuBpDgU54IdFc8YfX6UW69qRQFtPSC1guaPQ
Message-ID: <CAMArcTXsU+YbUzjF8BOLsVjL2L_Quasv54mdm8iiJN5QdoAPZA@mail.gmail.com>
Subject: Re: [PATCH net v2] amt: do not store tunnel pointer in skb control block
To: Omar Ramadan <omar@blockcast.net>
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, Xiang Mei <xmei5@asu.edu>, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:58=E2=80=AFAM Omar Ramadan <omar@blockcast.net> w=
rote:
>

Hi Omar and Cen,

Thank you so much for this work!

> [Resending with the list and maintainers on Cc; my first copy went to
> Cen only. Sorry for the duplicate, Cen.]
>
> Hi Cen,
>
> On Tue, Sep 22, 2026 at 05:41:50PM -0400, Cen Zhang (Microsoft Security F=
ORGE Labs) wrote:
> > An skb queued in a qdisc can outlive the tunnel it references
> > through a raw pointer in skb->cb. For example, a netem delay of
> > 180s exceeds the default tunnel lifetime of 135s (igmp_qrv=3D1);
> > when the tunnel expires and is freed, the subsequent dequeue
> > triggers a use-after-free in amt_dev_xmit().
>
> Thanks for finding this and for sticking with it. I agree with the
> analysis and the trace. Nothing pins the tunnel while the General
> Query waits in the qdisc, and amt_tunnel_expire() frees it with
> kfree_rcu() well before a 180s netem delay runs out.
>
> > Store the tunnel identity (ip4 + source_port) in skb->cb instead
> > of a pointer, and re-lookup the tunnel under RCU in amt_dev_xmit().
> > If the tunnel is gone, the query is simply dropped.
> >
> > A refcount fix would be hard to keep balanced here, as the skb may
> > be dropped or cloned by the qdisc layer before reaching
> > amt_dev_xmit().
>
> Agreed on the refcount. Could we avoid both the refcount and the
> lookup by not sending the relay's GQ through amt_dev_xmit() at all?
>
> amt_send_igmp_gq() and amt_send_mld_gq() have one caller,
> amt_request_handler(). It runs inside the rcu_read_lock_bh() section
> of amt_rcv() and already holds the right tunnel, whether it found the
> tunnel or just created it. For this skb, dev_queue_xmit() only leads
> back into amt_dev_xmit(), which strips the Ethernet header and calls
> amt_send_membership_query(amt, skb, tunnel, v6). The two senders can
> make that call themselves, in the same way that
> amt_send_advertisement() already transmits from this receive path.
>
> With that change:
>  - the skb never waits in a qdisc, so there is no lifetime window;
>  - the tunnel is only dereferenced inside the RCU section that found
>    or created it, and rcu_dereference_bh(amt->sk) in the sender stays
>    covered;
>  - it is O(1): nothing is stored in skb->cb, and there is no lookup
>    and no refcount.
>
> Once the round trip is gone, the query branch in amt_dev_xmit(),
> amt_skb_cb() and struct amt_skb_cb have no users left and can be
> removed.
>
> > +     list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> > +             if (tunnel->ip4 =3D=3D ip4 && tunnel->source_port =3D=3D =
source_port)
> > +                     return tunnel;
>
> This keeps the per-Query walk of tunnel_list that Taehee raised on
> v1. Space isn't the issue: your (ip4, port) key fits in the free cb
> bytes, and so would a u32 tunnel id. The cost is that any key needs a
> lookup at dequeue time, plus a rule for a tunnel that expired or was
> recreated in the meantime, while the sender already has the tunnel in
> hand.
>
> These are the behaviour changes I'm aware of. The first two only
> affect the relay's own GQs; the third affects foreign queries:
>  - They no longer go through a qdisc or taps on the amt device. They
>    are still visible as UDP on the underlay.
>  - They are no longer counted as tx_dropped when sent successfully.
>    Today the query branch in amt_dev_xmit() exits through the unlock
>    label, which counts every sent query as dropped.
>  - A query that reaches amt_dev_xmit() on a relay from somewhere
>    else, such as a userspace querier, is now dropped at the IGMP/MLD
>    type switch. Before, it trusted whatever skb->cb held, and a NULL
>    hit the WARN_ON(1). I found this by reading the code and have not
>    exercised it.
>
> What I have and haven't tested:
>  - The diff below applies to net at 9c572a83037a. It builds with W=3D1
>    and no warnings (gcc 14, arm64, CONFIG_IPV6=3Dy and =3Dn), and
>    checkpatch --strict is clean. I haven't booted it.
>  - An earlier form of this direct send (without the dead-code removal
>    or the failure accounting) passed amt.sh 5/5 under vng in August,
>    on a v7.1 tree carrying our other pending AMT patches. That was not
>    a KASAN build, and it predates this diff. Our out-of-tree module's
>    source carries the same earlier form.
>  - I haven't reproduced the KASAN report. Could you share the netem
>    setup you used, so I can run it before and after? The GQ no longer
>    enters the qdisc, so I expect it to stop triggering by
>    construction, but I'd want to see that before this goes in.
>
> If you and Taehee like this direction, either of these works for me:
>  - I post it as v3 with your KASAN trace in the commit message,
>    keeping the existing Reported-by tags (you're already one), plus
>    Co-developed-by if you'd like; that needs your Signed-off-by.
>  - You fold it into your v3 with a Suggested-by.
>
> Taehee, would this be acceptable to you?

I agree with this direction. It's clearer and more maintainable.
The current datapath unnecessarily traverses more layers, which makes
the code more complex than it needs to be. Using skb->cb to carry the
tunnel pointer was not a good idea in the first place.

Please send v3 along with a selftest.

Thanks a lot!
Taehee Yoo

>
> Thanks,
> Omar
>
> -- >8 --
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index bddc24e1856d..b53f8ec55661 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -80,15 +80,6 @@ static struct in6_addr mld2_all_node =3D MLD2_ALL_NODE=
_INIT;
>  static struct mld2_grec mldv2_zero_grec;
>  #endif
>
> -static struct amt_skb_cb *amt_skb_cb(struct sk_buff *skb)
> -{
> -       BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct tc_skb_cb)=
 >
> -                    sizeof_field(struct sk_buff, cb));
> -
> -       return (struct amt_skb_cb *)((void *)skb->cb +
> -               sizeof(struct tc_skb_cb));
> -}
> -
>  static void __amt_source_gc_work(void)
>  {
>         struct amt_source_node *snode;
> @@ -791,6 +782,11 @@ static void amt_send_request(struct amt_dev *amt, bo=
ol v6)
>         rcu_read_unlock();
>  }
>
> +static bool amt_send_membership_query(struct amt_dev *amt,
> +                                     struct sk_buff *skb,
> +                                     struct amt_tunnel_list *tunnel,
> +                                     bool v6);
> +
>  static void amt_send_igmp_gq(struct amt_dev *amt,
>                              struct amt_tunnel_list *tunnel)
>  {
> @@ -800,8 +796,11 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
>         if (!skb)
>                 return;
>
> -       amt_skb_cb(skb)->tunnel =3D tunnel;
> -       dev_queue_xmit(skb);
> +       skb_pull(skb, sizeof(struct ethhdr));
> +       if (amt_send_membership_query(amt, skb, tunnel, false)) {
> +               amt->dev->stats.tx_dropped++;
> +               kfree_skb(skb);
> +       }
>  }
>
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -885,8 +884,11 @@ static void amt_send_mld_gq(struct amt_dev *amt, str=
uct amt_tunnel_list *tunnel)
>         if (!skb)
>                 return;
>
> -       amt_skb_cb(skb)->tunnel =3D tunnel;
> -       dev_queue_xmit(skb);
> +       skb_pull(skb, sizeof(struct ethhdr));
> +       if (amt_send_membership_query(amt, skb, tunnel, true)) {
> +               amt->dev->stats.tx_dropped++;
> +               kfree_skb(skb);
> +       }
>  }
>  #else
>  static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list =
*tunnel)
> @@ -1186,7 +1188,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb=
, struct net_device *dev)
>  #endif
>         bool report =3D false;
>         struct igmphdr *ih;
> -       bool query =3D false;
>         struct iphdr *iph;
>         bool data =3D false;
>         bool v6 =3D false;
> @@ -1204,9 +1205,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb=
, struct net_device *dev)
>                         case IGMP_HOST_MEMBERSHIP_REPORT:
>                                 report =3D true;
>                                 break;
> -                       case IGMP_HOST_MEMBERSHIP_QUERY:
> -                               query =3D true;
> -                               break;
>                         default:
>                                 goto free;
>                         }
> @@ -1228,9 +1226,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb=
, struct net_device *dev)
>                         case ICMPV6_MLD2_REPORT:
>                                 report =3D true;
>                                 break;
> -                       case ICMPV6_MGM_QUERY:
> -                               query =3D true;
> -                               break;
>                         default:
>                                 goto free;
>                         }
> @@ -1261,19 +1256,6 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>                         goto free;
>                 goto unlock;
>         } else if (amt->mode =3D=3D AMT_MODE_RELAY) {
> -               if (query) {
> -                       tunnel =3D amt_skb_cb(skb)->tunnel;
> -                       if (!tunnel) {
> -                               WARN_ON(1);
> -                               goto free;
> -                       }
> -
> -                       /* Do not forward unexpected query */
> -                       if (amt_send_membership_query(amt, skb, tunnel, v=
6))
> -                               goto free;
> -                       goto unlock;
> -               }
> -
>                 if (!data)
>                         goto free;
>                 list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) =
{
> diff --git a/include/net/amt.h b/include/net/amt.h
> index a0255491f5b0..2846dde0cadc 100644
> --- a/include/net/amt.h
> +++ b/include/net/amt.h
> @@ -231,10 +231,6 @@ struct amt_relay_headers {
>         };
>  } __packed;
>
> -struct amt_skb_cb {
> -       struct amt_tunnel_list *tunnel;
> -};
> -
>  struct amt_tunnel_list {
>         struct list_head        list;
>         /* Protect All resources under an amt_tunne_list */
