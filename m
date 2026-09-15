Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC3351C20
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475192; cv=pass; b=W5aX3Y6UZP2AyWt127KeX7tr0FZDK2qi6Pm+MjWaZW82KNU7lpfmMAI22p2+Qp1A+YfKOs3ITyU+2cinUsh/9xA+hA/DCVmluBLoElUstK4ylgSvRni4KIiJ6EeGqnbPbSnHBXtE6ctUofESp3DBJXYj2R/yYsSO95ujKV3vlfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475192; c=relaxed/simple;
	bh=GVPTKUBJIvk1l4BuAnmPBBzuEjUGC3oVeb97GO7vzC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsZuV8C2wvttur3G3SNxz4uf62ghE+/EDafun+/zUM6Sizcq3SD4LnG1q3Rg8ktUbdhoYGekK5ClSz2u49rXTGEHCdQUzkagqefQaORWeTfpUw7R0yZvW7F69Mxh7VeNFq6hddHVLVxLGyI7RW5wMV3JnAkubuu0Qij0wz3Vg8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjkIIvHO; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjkIIvHO"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb769ca02so46566551cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789475189; cv=none;
        d=google.com; s=arc-20260327;
        b=QWqPMXH/embg4zjAvb3DFOQrQNwjuhZPDpMzPU2hwKytws5747nU06IkHV3XjC6tuX
         MTXBtclTen7Ykzoj2+PPjadVhwjJ1UFtyRZ3pFuw+p1oOBsLpRybmDXXsMBODE3NRSOK
         osqrchslby7zz2/eQSsNKsrCNhnyy9lSojRxlIrXv2gmU2ZjIZ4yv8he/yBu4Eo3YLBt
         VW8a251af3H6DAPaFz3znd/XTZKQ/tVNveNnMRq9GLXvLREc/uv8cJbTrbd12NT86FKX
         jMA/FpzBLMKT0kfVEl+83iQ9ZzTG2u0CTk2VPualuunVcBYt/OXtDFUVzz6sofa6j5GS
         PpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iHxIsPyYHVnJ9HCD3Bii8M95ATqaLQRBGYMsVz3U6ZY=;
        fh=zKaComGPcWn+F1q5Vwmnb2aUa6ZVobv9lqgq+bZgtoE=;
        b=FpcBU/mV7jyut0e9t95xnLhrnIikFUHVk1em0IvYzUiJMqVDlJBLEBnmIpNLW+P8Hc
         mqLWB01BcUNT/9wqwOBZnOgnxnOUR0IkVSdX9/hht6tMPaWoWs73EDj+8RyjLzuoSp+A
         /f5srYsxxFA1VyqoJKEIGWkzcQMz06t/YupjbxpF8xej9wXG2EAJEpHmcSxKROp/wm2a
         42dRM864TUc9/IrKE70Ncc8YL8ayHIQE7xljvhRxhW0iqX6Cq5q2m/6Y4LOg9tmrRXAD
         iW1pnM0iN2zIpv1pfLxF/5crZVEEtlSPtKHtsRDtoDan95oS6Oz+jo+YWZv5Un9JWqid
         3aWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789475189; x=1790079989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iHxIsPyYHVnJ9HCD3Bii8M95ATqaLQRBGYMsVz3U6ZY=;
        b=AjkIIvHORSVxA/fHvNK8lgjR/J5X0Dxha1kRlSSjgj2u9EV0Rjcb1TlueXwYCYHdci
         5oVY2Ki784heN/pFR2Zg0N06lWy1R3VnCMH3VY6By0I3ESyGGbpRPI5P/4J6I4NNO18v
         DY4rJr3oTzBw7nFUCw0rI+jQxyFroZ2xnl/+NhDB/CkjHmNdGl/HHB01DSvYZNdSFoK1
         ukMr+qr3fhqff2Ocrplk5VuOsJwKONE96QmLl3DRACc7QhB6YGl8uu1U0m1VP+01cGrM
         D5LIHNPSPJyHtbjJB/LJJLo4ZgiI5N+19HslyX1avMO0bck3nKG/qqZl1jMXiJt0MAdH
         LuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475189; x=1790079989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHxIsPyYHVnJ9HCD3Bii8M95ATqaLQRBGYMsVz3U6ZY=;
        b=DbxysSiiCVeKX3e/gZa+KB6yhlZOfaHG17HuwTB3Zefmr1yrqTeCugjxxRmiH85IJe
         UHYkixyjB5GJP05g6NVs9jZFqQ9xwvhlKl+aKlBrrk0l3AbjljwpidPJucoZD6LW22LQ
         mZymm1qc+boG3OpL2Q4ggBrfnsSRdeDKgwBhjJ7iANtQN462Q65rrrbnFwuzjIm6sJu9
         E2KaFSIijK+cE6kyw9/I5mb6073/CWPP4uAoEoCa3W80Fj5yGjb9n2hklJVWlvHHlfCi
         vDR21isvbE1B6b2DPPcl95UOs5eFcyFEhW96Q5DDjkyY2Tge7HJjcZesOn4dBUWtabhi
         LUiQ==
X-Gm-Message-State: AFuF++nBFeYsgxpdsohk55wazucP1IrnYTmIpivijojExzBo0Le8Fi/J
	XokE4owJDhdVb29ORTpUVLmR07hxB2jB4ygJy9bPq4B/M0O/g9bGBokx2FXXzv0HWG7q2VXfGFW
	0Vmbwi4RNnkI5CvYMoI9N/to5Sb0vRWp6h9sYl38J
X-Gm-Gg: AYBFou21R5FwXvBb9TXzu722kK2dTiz3ig7+6A/zyjCSzfYy90WzKRZn2pR/Xssjh9g
	3DRgieiQ3XLtcATG46uBBm/Din6VHhBkU2dC3QK/NXlONPpXw4aSdKMGU4SygJzSrT1cPK019d5
	0Zx5FXUaxjY2lZLFRlRAxpGtwQEg19qVGiNq+2I5zqxKcFBFT8UQg5XaqtYhY1KHyUPpuMc0upA
	VmBeq5harhzXnZZElPGI8VXHgT5aSJdTudpTEnokzxr20HPGsnJVCpKRPwxyTD739EOrvcItRO5
	A0IxdbUbIGn6MWqh40CzP/Oc1tqEWhapbpBHxUAh8PqFmIGf6bfJCxDY615hrzDaZPniJMzpw0a
	W0p6iIlt7QrpfvK+hYALj1tyJKHfZGI3vmBL/GgxcEP/iC9HOaE82vQZ3Rw2UHl7YuT8=
X-Received: by 2002:ac8:5a51:0:b0:52d:28f8:578c with SMTP id
 d75a77b69052e-5310d03eba0mr104692391cf.31.1789475183228; Tue, 15 Sep 2026
 05:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915121458.214961-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260915121458.214961-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 05:26:12 -0700
X-Gm-Features: AcwNN1UvGbNDZe7GoZMDuocIgqX9hSG9J6UJaEzJ1N3_vwf-LgVG-0jfBCbXNEw
Message-ID: <CANn89i+d4ny7K0QV-v+ZY6Kj735tPVrrzd0AzwRqe4vvu5r=aw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: gro_cells: move backlog drop handling
 outside the local lock
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dong Chenchen <dongchenchen2@huawei.com>, 
	David Ahern <dsahern@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:16=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> When the GRO cell queue length exceeds max_backlog, gro_cells_receive()
> holds bh_lock while updating the RX drop counter and freeing the rejected
> skb. The skb has not been queued, and the counter is updated with
> this_cpu_inc(), so neither operation requires the queue lock.
>
> Release bh_lock before accounting for and freeing the dropped skb to
> shorten the critical section.

local_lock_nested_bh() is only a real lock on PREEMPT_RT. On other
kernels it is a lockdep assertion, so this patch generates the same
code. And this is the backlog overflow path: by definition we are
already dropping packets there. Shortening this "critical section"
buys nothing measurable, and there is no benchmark in the changelog.

Also, the result is harder to read than what it replaces: a label
named "unlock" that actually drops the skb, falling through into
"drop:", and a backward goto past the return. Three labels for a
20-line function.

If you want to improve gro_cells_receive(), please add drop reasons
instead: SKB_DROP_REASON_DEV_READY for the !IFF_UP case and
SKB_DROP_REASON_CPU_BACKLOG for the overflow one. That actually helps
people tracking down drops.

Thanks.

pw-bot: cr

>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  net/core/gro_cells.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index d8c0a28671201..f46cecd246aab 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -14,7 +14,6 @@ struct gro_cell {
>  int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>  {
>         struct net_device *dev =3D skb->dev;
> -       bool have_bh_lock =3D false;
>         struct gro_cell *cell;
>         int res;
>
> @@ -26,32 +25,33 @@ int gro_cells_receive(struct gro_cells *gcells, struc=
t sk_buff *skb)
>
>         if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>                 res =3D netif_rx(skb);
> -               goto unlock;
> +               goto out_rcu;
>         }
>
>         local_lock_nested_bh(&gcells->cells->bh_lock);
> -       have_bh_lock =3D true;
>         cell =3D this_cpu_ptr(gcells->cells);
>
> -       if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_b=
acklog)) {
> -drop:
> -               dev_core_stats_rx_dropped_inc(dev);
> -               kfree_skb(skb);
> -               res =3D NET_RX_DROP;
> +       if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_b=
acklog))
>                 goto unlock;
> -       }
>
>         __skb_queue_tail(&cell->napi_skbs, skb);
>         if (skb_queue_len(&cell->napi_skbs) =3D=3D 1)
>                 napi_schedule(&cell->napi);
>
> +       local_unlock_nested_bh(&gcells->cells->bh_lock);
>         res =3D NET_RX_SUCCESS;
>
> -unlock:
> -       if (have_bh_lock)
> -               local_unlock_nested_bh(&gcells->cells->bh_lock);
> +out_rcu:
>         rcu_read_unlock();
>         return res;
> +
> +unlock:
> +       local_unlock_nested_bh(&gcells->cells->bh_lock);
> +drop:
> +       dev_core_stats_rx_dropped_inc(dev);
> +       kfree_skb(skb);
> +       res =3D NET_RX_DROP;
> +       goto out_rcu;
>  }
>  EXPORT_SYMBOL(gro_cells_receive);
>
>
> base-commit: 1142eb185b05db61a78130890fc4ed268f4cb4e6
> --
> 2.43.0
>
