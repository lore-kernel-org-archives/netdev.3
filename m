Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3544466B5C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751099; cv=pass; b=XdIVr8cHXpBZeIM+Tm/TZK/lJ+bTtDZoaYmYYb1W7xdQALJazsUkwjdoOMd6DPTOYiCf1A8GfKMUyS6IuVN0vjr9Ne5nJR1MkilhAznJHb0tv0UzRAT4iWvAAY8pNKpDAvWg7ZqzAZwf0+yayaUlCUnN25V04OoK8GJk9ayeOzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751099; c=relaxed/simple;
	bh=gEaNQuxalrEbaejYXNUjXkTf07wYYe3nFnrB61R3T4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYojJPG7/IMEAncVNnWO6J8W0BmAJC0KoerLJ59uzrmuCpmVwVnYIbxLuW9aNhZ8bL1dDDNMJjMTiynwWrZLxt1TB3rZv1Ml6Irc2Yzd1CNr4Y+/VFY5EER2X19tcemoHPXAgsDhRnxpJgxz706qruXZTqeI8WoYsTgSmQXfIik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnah7aXB; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnah7aXB"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664b2c00e12so2634056d50.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782751097; cv=none;
        d=google.com; s=arc-20260327;
        b=gpn390HRHpyQTGhA7iuAZU6eewveOwxpC3Mx7QhTHzWbSCu3IeyVH8S55nwiMLQmq6
         RLiHcOCxpUKLkjWtaUl8xTZcCg85zjxqz5zDOBuoh8CRJCuir8piCibb+g7SrtwuhxU4
         8iQlornUZsWnwvMlutVpdtwJXDZlmaPfGv30UgDP5gsta5DU43KjDzvUxKP3sxe+30/0
         PZe3FT6b+PUXl1D0/YupqtN0AsRmWSiNWXoeiRq+J5a2fTHNcWtJmmr2DCQa/IEgGUr3
         xcBHlRchN2KrzQnUB5wzId7+w02KSRj+NP0z9dyr+IHI85AgayDV16YxTw1gvmNXsxtn
         VH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        fh=UrNmzKyD2X98/VVgL9suLhBv9wXr08gSbUcbr8tpseg=;
        b=QLnmmlJI6Pz04ddLxS5xQ9Dk7AreO1ixuoVAwLav8+lEnNG78eKR4A3iQpWpDaeJ/h
         s3q+bbX+nwiNJoOCqitH8wLF9u9xj0jD/4iMKktQ0BqTGrAS5iYT1p/l8VpCIHd+YfZP
         43ApmL0dk4I+w4Soo15b7abZ9yYRwbLEDhiSeNYDHWoISVR+GVgmY3xKvkX/LC2K63FM
         xiMQ5AKjRvcWr/qKrCCxnz62KpV8e3pGz+26xMUVe7JwYUW8chpBrphrmHQTsDwRAAdI
         Zb82PLSG+DjjXSkgEeLG+/H4HY7/g+hPbCAPwMhEHBOqY+22gZW+VYH9fpbvnOfup6w8
         5gbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782751097; x=1783355897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        b=Vnah7aXBQsEN+d7QydTxgNr5ByeHcR0FmX5TfiEkA1z6l+TGqq1aWzJTbCq9UbnDpB
         BgKXBclKsFM76dz8NRaCGGOPYgULxdltJ2ea8uqJRG4Z/FhIcBLWqQHRllqWsTv7VSG7
         e8/7GeSajdU2tGmad9dlyHDclvd+SqM/6QjxFlbqoCy0DIIDCKtY40CXYssJMg5NRmFd
         /fgzeF0tUV70dTPOAEE4RQgGiTTZMRRXw7EFeJK990Aoj3yJfBXrPJVe52+4pwgwnFVb
         gSFuUXZdM3U/L1Q0OIsqnM76jap0oWwNGh5JALDeAZQhGaBliWxGF9rtSR+Ytu2eQYd9
         qU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751097; x=1783355897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haO4vZrpMtuqtlW+X89rpFuMlePW6Ji0BG7p7a0BoNY=;
        b=qWZSM47eoJMgPhyUGSc8llLj0QG+2W3cNhGRFu+46Cq5kOdtHSLapQCC8i3lc4Ohld
         z+yHe0ngMxIZZj5Az0/krJO8t4hBBhhLk0WFnTYL9u9eQDNolMF+RkKmaUY0LFJVA4MU
         XcZfg+5EG7rRKOEZO5Dn0HKyP8dmPYurY8c3oEgeI9uPyY4Jd4VGPkMLOu1sSdRr0giC
         AOqvRaxDeKgQwtWhlKIiYuiZDHlX5IP+ruen22WxzwKtqe5WybRRUcISayn4+P+OlOS1
         vyrJSb0YyY5GSF4Q73tfOzUNyZPnnjat/Ntv+Jzn14O5e1bUcH9ymHUubhs0k6qKW12L
         yLKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6yArAK4NR3pX1gkwMNhCjzETa0FleQ0OAlVt9mZbwar86fVg+HWnX8rs8hthYx1KbtIAxqyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvvoSs/5q9u9gQPENoanHsRg88rRDRU1y3ASQwACfm9V23H2Q
	L5eKIhHC8nD1VfUMJK6eRmIUP6UW933mxJDW9Taiw4aK4vFY5jiS54RT+Cp4IcJcl96iW57HEPC
	WUIv6MqVNQ4owYYdTjs5DUSx/reGC5EE=
X-Gm-Gg: AfdE7cmOcyCfsDsJnvAQBbXdG91UQrNKU1qWO4d3Tj78yWqYBPGVusZVMHJrITRlBYw
	JdU55zCQmuC8B+d4pjDN7/j4MBaXO3496rt5Vqs+o1DVdJuH+KfnTLsvICUFLZ6MEE8nodWLgfS
	Y5v3Ebkgw05AIBVSd+Qal7Wd16wy00irevrKIeCx62kTxMhTas29/iM/n35KL4zJmydZBjwwo2M
	QF0x0YVAFhcM7Tt4UR4BHCwtR/kq+6FtwFjtL9Xo49J0H1Rj+VHqkpC9H5uB0t/n66OIPNl2w==
X-Received: by 2002:a05:690e:134c:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-664f97b64a8mr475040d50.36.1782751097001; Mon, 29 Jun 2026
 09:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jun 2026 09:38:05 -0700
X-Gm-Features: AVVi8CeIipXEtbZbSv-5oex_d1rzw4sFw-6Q7PYGKe29UI-pb6fsxIRxFlbWnYI
Message-ID: <CAMB2axNzh1bWG8Jz4Trp4UTcu29d1v8eqtukiGyZU9L+DHe3uQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_bpf: use rcu_dereference_bh() to read
 the filter
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 8:54=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> tcf_bpf_act() can run from the tc egress path, which holds only
> rcu_read_lock_bh(), but reads prog->filter with rcu_dereference() and
> trips lockdep:
>
>   WARNING: suspicious RCU usage
>   net/sched/act_bpf.c:47 suspicious rcu_dereference_check() usage!
>   1 lock held by syz.2.1588/12756:
>    #0: (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit net/core/dev.=
c:4792
>    tcf_bpf_act+0x6ae/0x940 net/sched/act_bpf.c:47
>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>    sch_handle_egress net/core/dev.c:4545 [inline]
>    __dev_queue_xmit+0x2185/0x2c00 net/core/dev.c:4808
>    packet_sendmsg+0x3dfa/0x5120 net/packet/af_packet.c:3114
>
> The other tc actions and cls_bpf already use rcu_dereference_bh() here.
> Do the same.
>
> Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  net/sched/act_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 58a074651176..09d46e195e33 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -44,7 +44,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
>         tcf_lastuse_update(&prog->tcf_tm);
>         bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
>
> -       filter =3D rcu_dereference(prog->filter);
> +       filter =3D rcu_dereference_bh(prog->filter);
>         if (at_ingress) {
>                 __skb_push(skb, skb->mac_len);
>                 filter_res =3D bpf_prog_run_data_pointers(filter, skb);
> --
> 2.43.0
>
>
