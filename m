Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A56449B17
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231937; cv=pass; b=HPFm8AJ9IrE+xdDzlQnLCHldm5Ujd64IhfJ+5sk/LD2LD2bznAS8DkhtLpNOp65tqGqR4610lA/OoEVgrq+RpV7bbI7Hq8JRt76HcEw+Xgu7wIY4ZhVJxpBMqQNijbQCOj6uS3xVobtXQOxiGKOPt7SRh4/y2kgiQJxqa9TkcVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231937; c=relaxed/simple;
	bh=a5CmOoNIhmLMkozeDFuPxx1PoFG2E6NuN+9ULQeE4aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APGPkWfxIhxlEfL/Kz/Zf3sVdgc22uCtpHb/MVsv2A69bgTaxdH4qoVUe91ELD8rTT/XEhX356B6Jm0fyV7oWaSgYTy7J8p9X74Bs2THS2LR0Y2z5hDYE9Z/myU7w0RuBqJV0VJtHvdc6pevb6rYiT6lHhDlVUAwyxO0rZH1TtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9gf2dRk; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9gf2dRk"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so2054216a34.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787231934; cv=none;
        d=google.com; s=arc-20260327;
        b=pVZcYPDpDR1qhvCiZsQNS8dRgpDqevK8/ezH8XrqFRyfaPKa6O/EVBKEl8lkMrwk+A
         arfLxpxfKPIjamw/r2/fcmDHTUh+tk5d1J7ABoZ7gxJYGwJ7QSZzGOf3l0fkJbOppQ9W
         RYbJXi63lt6DFvb1BmWiX9Q+x9UJhPVr4kmmzzoMd4Ze20wlCtiAcaH7y57SKaHk3pG5
         rXos101EA9yIHa2mzmQRf8UnLEF/iwOQKyIoyOA3YbrP7SMABuN+hjZhbpiSKsJY97xl
         nUqZR9nA3YFvrvCvY4LXNKU8IEj1o9x6VcC4nrJwUWUkVNAszLBdPykO3XSIJa1iTlP2
         7LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cf8VSsMcR9hKynJlvPQ+qlMY0MivEM576VbXapiq8zQ=;
        fh=tHFIQFV6QeHWTKB+XbLsebaGQjqs/kjXTchAbloEko8=;
        b=lpKTaC+cmBihReT2YBNtmIZvPZhhnsLc6nwyUEBakUnTAMq/+WCKzAMMZvprfHiiPh
         sngbl9sh+kNRJmUMNzA2PxOzEkrqrJJlBn81NNcKFiPYXvZFr6g452HEEQq2lZ4TwydZ
         LRGJ/gSmm551NfwBh6GaA7p9wZZ3Mze4fye2a+Tal5QkO7L11pJz5v9NPtIo73FR+7LD
         6T3ZrWnkrz94S7srcj4GQ9k8EIUTFf/udtWiZYFzQXmoawwa5WmGBDh8kV7GlOm6cfr9
         H41vGfYZfI4ssXxvxvSOn2LyhNXrLxoii5M2ccUSpybzwuWkUkdAKlsAjLWvHvIUnzXO
         cPnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787231934; x=1787836734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cf8VSsMcR9hKynJlvPQ+qlMY0MivEM576VbXapiq8zQ=;
        b=r9gf2dRkTdei/zNphFitNm0o+dQipqkKlVaPsdEvgXN9Jt5m7HmxeODimRpG/AnYaw
         iINCgpJ47yrBGVn/fsmNVf8whJBA4XhThPK6k4hjly8T3FVBxkN1xA3LZuKeJyCiKDbR
         x2QTPPhClM/0ROnlBuYBRiYUJPc8WByI1WjMCpe6JAjwLt1fgT5794IwRDo3vwygvVoA
         GxnNO31fCxJYF7/tnfRij13GAk8vvzHscK/scGVKdUtntrvF5/E7ShR5a4CmJJG0Swje
         jPFQLp1RFGRAR97Q3QUgY2UOEqKttAIqboVoOQ9CaUKaRN+F0x5T8jh6AWN/X+RLGRit
         hwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231934; x=1787836734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cf8VSsMcR9hKynJlvPQ+qlMY0MivEM576VbXapiq8zQ=;
        b=Q7RELuKSpILoSz56vmqtQQeupWS8XLTxvLeo52JOB1eULxpIxTt4pfVlNREPLmZQp0
         gRhj+gt1oz0x6xijcMFHihEZkRH5cvQRCoCOCm3r1j4IP+jrKwUbsfRXejtIQNsKcjV5
         DM38SnZY7K9IdhB6epmMcVVCJRkk1iGa9vS2f0OSWyVvBbSbBHH+XygfHGepCSAV4KEt
         gUJwxcOPOpjYgqtcCWdJDnu1ugdJPu/RKNMFySgmnDJLvJZ3SmPVXEhcrXdT31gU3T2D
         cMXkSf1uyAL0qDNyHC0+4pgmaoqAwhMsn2lvHg9RG3jFkO6w8h33P0SiPX604m57lN/4
         a3lQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNjpmZb+0IesqsRXmhDXfeMsTvYQnyOqK64knL3RBvGPizsM3RQDYyUJVRyMyF//y84lBDOSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNEJZNzNBaoRcm9uoukIi6XOciFbHVfv0ZbTTgbD0EOrbl4oW
	cPUjHseb4F1Gvvej4U/HzbrfLdFBYkzlnrFF0HhxJYGBtGw6QTIYk3L/XhiKbk5DfF8SrueWaTZ
	N7T/X3YkkH6Fnl8JEV2vTGa09o9lxNiw=
X-Gm-Gg: AR+sD12VeaFUubFhzM2YHOP9HsRENUAXhPIbjBhbthgIpeofXiM+uEyl5hspMz7ww/P
	Orx3DG27uoFVJAoJQE39XWnEXgCnbpkEdPAuuKbN6JCH7nmpU6Y7PpK8uJMKdDZyUJLv9UPWkHN
	q0FoiQsnrsoHuzQqy3Os2T0ShMtVzTCnumVjnma3ozQtDBqrhjvy24BY+SNKFNhwFcpwk+Rl+qW
	BZFlBzmZlJMj806g3oNQDmi5u0FDeOZN3pgfCFDZKgm34nTE30IT1XmMojt30n4MJ6m9WkfDOvO
	AFmnlCYRrUBg8j0Uf4KaEquvEPFBNYXerLhcTD8ObAk0sw==
X-Received: by 2002:a05:6820:4c13:b0:6b0:f294:f124 with SMTP id
 006d021491bc7-6b13c58c957mr11989172eaf.24.1787231934535; Thu, 20 Aug 2026
 06:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818164825.63967-1-blbllhy@gmail.com>
In-Reply-To: <20260818164825.63967-1-blbllhy@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 20 Aug 2026 22:18:43 +0900
X-Gm-Features: AcwNN1XSfHIEaaWwL5KV7xOxpAgF_PguFQyjianovpOMMqDNoAY5TJg8df-Xq-Y
Message-ID: <CAMArcTUmACRn_h2sthPwsi3jYjKWRM6+Pnhg=tN4jn4VZThHCA@mail.gmail.com>
Subject: Re: [PATCH net] amt: do not store tunnel pointer in skb control block
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 1:48=E2=80=AFAM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>

Hi Cen Zhang,
Thanks a lot for this work!

> An skb queued in a qdisc can outlive the tunnel it references
> through a raw pointer in skb->cb. For example, a netem delay of
> 180s exceeds the default tunnel lifetime of 135s (igmp_qrv=3D1);
> when the tunnel expires and is freed, the subsequent dequeue
> triggers a use-after-free in amt_dev_xmit().
>
>   BUG: KASAN: slab-use-after-free in amt_dev_xmit+0x2763/0x2e20
>   Call Trace:
>    amt_dev_xmit+0x2763/0x2e20 [drivers/net/amt.c:1262]
>    dev_hard_start_xmit+0x22f/0x620
>    sch_direct_xmit+0x12e/0xac0
>    netem_dequeue+0x333/0xc50
>    net_tx_action+0x35c/0xa60
>
> Store the tunnel identity (ip4 + source_port) in skb->cb instead
> of a pointer, and re-lookup the tunnel under RCU in amt_dev_xmit().
> If the tunnel is gone, the query is simply dropped.
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  drivers/net/amt.c | 30 +++++++++++++++++++++++++-----
>  include/net/amt.h |  4 +++-
>  2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 182a41d59a75..a85ba0dfe18a 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -789,6 +789,18 @@ static void amt_send_request(struct amt_dev *amt, bo=
ol v6)
>         rcu_read_unlock();
>  }
>
> +static struct amt_tunnel_list *amt_lookup_tunnel(struct amt_dev *amt,
> +                                                __be32 ip4, __be16 sourc=
e_port)
> +{
> +       struct amt_tunnel_list *tunnel;
> +
> +       list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> +               if (tunnel->ip4 =3D=3D ip4 && tunnel->source_port =3D=3D =
source_port)
> +                       return tunnel;
> +
> +       return NULL;
> +}

This looks like it adds a per-packet linear scan over all tunnels,
so I'm concerned about performance when there are many tunnels.
Do you have any idea how to avoid this regression?

> +
>  static void amt_send_igmp_gq(struct amt_dev *amt,
>                              struct amt_tunnel_list *tunnel)
>  {
> @@ -798,7 +810,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
>         if (!skb)
>                 return;
>
> -       amt_skb_cb(skb)->tunnel =3D tunnel;
> +       amt_skb_cb(skb)->tunnel_ip4 =3D tunnel->ip4;
> +       amt_skb_cb(skb)->tunnel_port =3D tunnel->source_port;
>         dev_queue_xmit(skb);
>  }
>
> @@ -883,7 +896,8 @@ static void amt_send_mld_gq(struct amt_dev *amt, stru=
ct amt_tunnel_list *tunnel)
>         if (!skb)
>                 return;
>
> -       amt_skb_cb(skb)->tunnel =3D tunnel;
> +       amt_skb_cb(skb)->tunnel_ip4 =3D tunnel->ip4;
> +       amt_skb_cb(skb)->tunnel_port =3D tunnel->source_port;
>         dev_queue_xmit(skb);
>  }
>  #else
> @@ -1259,15 +1273,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>                 goto unlock;
>         } else if (amt->mode =3D=3D AMT_MODE_RELAY) {
>                 if (query) {
> -                       tunnel =3D amt_skb_cb(skb)->tunnel;
> +                       rcu_read_lock();
> +                       tunnel =3D amt_lookup_tunnel(amt,
> +                                                  amt_skb_cb(skb)->tunne=
l_ip4,
> +                                                  amt_skb_cb(skb)->tunne=
l_port);
>                         if (!tunnel) {
> -                               WARN_ON(1);
> +                               rcu_read_unlock();
>                                 goto free;
>                         }
>
>                         /* Do not forward unexpected query */
> -                       if (amt_send_membership_query(amt, skb, tunnel, v=
6))
> +                       if (amt_send_membership_query(amt, skb, tunnel, v=
6)) {
> +                               rcu_read_unlock();
>                                 goto free;
> +                       }
> +                       rcu_read_unlock();
>                         goto unlock;
>                 }
>
> diff --git a/include/net/amt.h b/include/net/amt.h
> index a0255491f5b0..59c4bb88fb1e 100644
> --- a/include/net/amt.h
> +++ b/include/net/amt.h
> @@ -231,8 +231,10 @@ struct amt_relay_headers {
>         };
>  } __packed;
>
> +/* Tunnel identity for re-lookup; do not store a pointer here. */

I think this comment is not necessary. Please remove it.

>  struct amt_skb_cb {
> -       struct amt_tunnel_list *tunnel;
> +       __be32                  tunnel_ip4;
> +       __be16                  tunnel_port;
>  };
>
>  struct amt_tunnel_list {
> --
> 2.52.0
>
