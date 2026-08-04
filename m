Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9647D455
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865091; cv=pass; b=VZUhE2vukAfoSFKFfz7DUcOtFCgaK4rqpccalSddM9hOdutuqnqUz2mOX+ypi6wP9wAZ9TNtqRgb2vrtZsnDfP3eQyJSe+y5TkijwbEWMCo4CtwA6246BXyvr5kNaMf7w0zVq3EGT7TNtfTmpPKFv2fcBgu40yyJHnPflu8uZK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865091; c=relaxed/simple;
	bh=XqKY1ZhYcEMsuvsg9JQgWbdE5J4e5NdUVztJuyL7NOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biGKmY88xmI0MWAksAn4XpFaniMIWNLknMjp365P/tIjBtVSotix7vy4Z+yQvNRtEUtCW+G+KILCHwP7CsmpsxyXwbuwFl+oY9SkNsOZltTgA1Y4q35Q45q3uaMTt3958wVhY9b/CYeBkXNzDP1Juwzb4fbcErc7Mr7oX+u0hQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmQur0gZ; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmQur0gZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso112749b3a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865087; cv=none;
        d=google.com; s=arc-20260327;
        b=FF6oBACF8MkFBk5Aam6jZHWM/fIwfaeVNsJtXG6k6mliGqTDUHLmh1ExBXTCl9EVxa
         MhI2qOJmkT6c72Xlsv0gkJCvCWH8OjKMa1C5QThY6k4vIYKa2G6Qx81FSVg0o6kIP4FF
         yL7c1L0NYjC7uWU+UbaTxFHINyx3aoM9dJ1SJMHUJb4vqiiGtf1NtJyYhgAFkZFZrhak
         DAedLIIdRsgA9nmhSKBrAht3scc58NMjMdpdga5X/dfzkvJ2wnUDFMBwBXHrjH76QoRf
         rFmkJ1VzljT61hJTFQ7IF7gEuTS2bT/D+aOsRv8lPMNHLgbgYn/rB0WDozxBHPGSTLYl
         xlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DpekGTSk7rTssN195Va1FbBn59VAjyN18+3zAp7ukkk=;
        fh=svmyq5jlW9kU4GVNDaMNGbsmAuFhCfO0dzzTZ93ok40=;
        b=rt+gfyI6FP0oSJmPiA0vy3zmr/uD2X6QClYPnBx+9ek6pFKp87DRPMJxIu9mO/rI7O
         h6vFlwh5sNYY992rUAHeQJHNalPAZhIxHlm71zdmRTVdlQvJdddZG9TPFCyse/LdsbNw
         9RY2JQ2FVoZMXJ/5adxcanwxIVpL2JJq5Gyq5QGpZ5lAINupuRVlDcl9hMNAq3iO5SDx
         YGfrKK3kfIup27BieWW6eRnjKWgQLweHsI5Lwm0/uyEv4dj9iZU7R3XVATME9iiW4EOv
         BZwM8j58EhQVo7MUvMuylUgAdx7iafjV8aI8W9JA8oMepVLfrTqfBO90Hx08OvYkdbHr
         PnhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785865087; x=1786469887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DpekGTSk7rTssN195Va1FbBn59VAjyN18+3zAp7ukkk=;
        b=CmQur0gZVNYgljvYON2Gxy4nWCykdXcCytY2Nu3foN4tLbEIAmjJ/O2KTLL5EWIp0Z
         CAjmbfCHUrHFxdwnQVh96OX+XQ02HIKE1uv2XAYD1qLrh/sOAZAWuem0pXi8vWIYpm5F
         tNFe36IDOXO+3JlTekjVPsetnh9rlvrmbhoPTy2GUv+FyJZ0npyzZGHqBzS/Lr6Wkvaw
         qCE/bo8FI4ngaCrMFqfYAmtBPHTF8E9dyJEcdpY3Z6AB075laRUhraSiSYE0E2l+ntDf
         Vt43XIJl79a10qjMqEFLEh7VRCc4x7OuwCs0jitXiKFjq6ZwZNyFDRgEJPoMAzZiQnMJ
         brjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865087; x=1786469887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpekGTSk7rTssN195Va1FbBn59VAjyN18+3zAp7ukkk=;
        b=ml7EapjXQPD6gX8eHDqnWyzBOlbsrE/+nRrqVuX1ILmj49GHY7UkUn+2P/uJJucGTa
         0N0KBsheUHLw9f86bkoBfvxpeeMUHFX7ET93FGYTvFTJj2injbOihWWVy36vcEPwAGAB
         T85wxhu63KfMs2xEymL1p/moCDAhRxfgaofVpOWUPOX3pCqpYWl5JEEIc+UAx07EnQFg
         EI0t0DyptGAekzj3r1F+By+dhvWaeHQzm82HXM1dMeGS0DGilX09Fpks4wNzeBHYuOTK
         wLSzNRbjw6ThrdGvAdF7tz9Ps3M9+fKuqOaLtIC2UTM8o0pk6SrRngnZz2BZgdxf9E/j
         lyXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpStsSVf/2Ey5e5RAqpxIzdVSiIZleS5GUqechJJ1QztJTUMb5Z6MfrRBCLMTnfsBaQ0WPNz70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjvXFgC9d99S/HYRJPVz7wJ/bmQECiPDhXgVipzHTIXzPF+xp
	eqMyA+lgc2V2zXPtYHvTDAY5ceQx4WG/z+QwS+k3/BHQ33M9yr7fuLS4G5yEbIctfq74z88zLPt
	GMxkrs9whaAu0EYt1eDoAFGk9bzvilBx+giV3kSUX
X-Gm-Gg: AR+sD107zwhWM8f/44MwZtcnR3ehUEnyzzrO5ux2XMBv2Vp6/1af81jB4vHzQmK61kk
	nNiuD+xd6YMes0WN1Hd6Jxl7KxNvpPveqpy1Xn2hg6cSbSXyHirbqxm1mRIkk6tWs52tu9ZT7Y5
	9NlPvzc8fhdey1bKqL6t8lSpq/bhlba2Zota2pv5WmIpyx9AQSKXyHyKDaMynGS7MaLkB+GyDrt
	QeJTU2Gyypr1l/aqaQXKFk/iJIlOiA0rKH0CZaDY32UkWLXRQK564LLgBW3CB6PcTVpGvk4foix
	xXv+djLfgjubOyUTsN1Hdmsz4f3ZKFGaW2Ebje48tvpcR3srzBNzR7vhS/SW/XaExbSIiQjkDuO
	vo+0LXZ5z16DV0YlysWQBYfjUXK71rrmyJ5XWUjmJs6PyQ18wGNbGU02P2wzwbhzzOpXBioXTUz
	k6m483YEnSw7c=
X-Received: by 2002:a05:6a20:d4b:b0:3c3:a722:59cc with SMTP id
 adf61e73a8af0-3cb85ea6f6bmr493723637.22.1785865086189; Tue, 04 Aug 2026
 10:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com> <20260731164612.2148830-4-kuniyu@google.com>
 <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com> <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
 <922e3cc9-8621-4b4a-af0c-4b8b7c660027@redhat.com>
In-Reply-To: <922e3cc9-8621-4b4a-af0c-4b8b7c660027@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:37:54 -0700
X-Gm-Features: AUfX_myPc2DyIP8DDQhE1wtbgkqU1-9-1gOI87z2DNw-pikdf8codBYkQgoG-Aw
Message-ID: <CAAVpQUDy7GCKuBN28UNCnqHipcV8d=TU_+7B9QE8LPT3aYGnYA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev unregistration.
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, i.maximets@ovn.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/4/26 5:24 PM, Kuniyuki Iwashima wrote:
> > On Tue, Aug 4, 2026 at 6:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >> On 7/31/26 6:45 PM, Kuniyuki Iwashima wrote:
> >>> geneve_exit_rtnl_net() iterates geneve devices whose sockets
> >>> are in the dying netns and queues them for destruction.
> >>>
> >>> So the devices may reside in different netns.
> >>>
> >>> Let's use unregister_netdevice_queue_net() to support per-netns
> >>> device unregistration.
> >>>
> >>> list_del() is changed to list_del_init() to avoid queueing the
> >>> same device twice.
> >>>
> >>> Even after geneve_exit_rtnl_net() queues a cross-netns geneve
> >>> device, geneve_dellink() can be called concurrently for it.
> >>> In such a case, __rtnl_net_unlock() will perform the unregistration.
> >>>
> >>> Note that geneve uses register_pernet_subsys() instead of _device(),
> >>> so default_device_exit_batch() guarantees that the async per-netns
> >>> works are flushed before ->exit().
> >>>
> >>> Tested:
> >>>
> >>> 1. Create geneve device across two netns.
> >>>
> >>>   # ip netns add ns1
> >>>   # ip netns add ns2
> >>>   # ip -n ns1 link add geneve0 link-netns ns2 type geneve external
> >>>
> >>> 2. Run bpftrace to check that geneve_uninit() is called between
> >>>    ->exit_rtnl() and ->exit().
> >>>
> >>>   # bpftrace -e '#include <linux/netdevice.h>
> >>>   kprobe:geneve_uninit {
> >>>       $dev =3D (struct net_device *)arg0;
> >>>       printf("PID: %d | DEV: %s%s\n", pid, $dev->name, kstack());
> >>>   }
> >>>   kprobe:geneve_exit_rtnl_net,
> >>>   kprobe:geneve_exit_net {
> >>>       printf("PID: %d%s\n", pid, kstack());
> >>>   }'
> >>>
> >>> 3. Remove the netns where the geneve socket resides
> >>>
> >>>   # ip netns del ns2
> >>>
> >>> Now, we can see geneve0 is unregistered by per-netns work
> >>> instead of cleanup_net() and it finishes before ->exit() to
> >>> avoid WARN_ON_ONCE(!list_empty(&gn->sock_list)) there.
> >>>
> >>>   PID: 571
> >>>           geneve_exit_rtnl_net+5
> >>>           ops_undo_list+702
> >>>           cleanup_net+1122
> >>>           process_scheduled_works+2538
> >>>   ...
> >>>   PID: 1047 | DEV: geneve0
> >>>           geneve_uninit+5
> >>>           unregister_netdevice_many_notify+7129
> >>>           unregister_netdevice_many_net+1050
> >>>           rtnl_net_work_func+136
> >>>           process_scheduled_works+2538
> >>>   ...
> >>>   PID: 571
> >>>           geneve_exit_net+5
> >>>           ops_undo_list+1064
> >>>           cleanup_net+1122
> >>>           process_scheduled_works+2538
> >>>   ...
> >>>
> >>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >>> ---
> >>>  drivers/net/geneve.c | 12 +++++++-----
> >>>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> >>> index f456a85dca77..a6a8978e3b81 100644
> >>> --- a/drivers/net/geneve.c
> >>> +++ b/drivers/net/geneve.c
> >>> @@ -2502,12 +2502,13 @@ static int geneve_changelink(struct net_devic=
e *dev, struct nlattr *tb[],
> >>>       return err;
> >>>  }
> >>>
> >>> -static void __geneve_dellink(struct net_device *dev, struct list_hea=
d *head)
> >>> +static void __geneve_dellink(struct net *net, struct net_device *dev=
,
> >>> +                          struct list_head *head)
> >>>  {
> >>>       struct geneve_dev *geneve =3D netdev_priv(dev);
> >>>
> >>> -     list_del(&geneve->next);
> >>> -     unregister_netdevice_queue(dev, head);
> >>> +     list_del_init(&geneve->next);
> >>> +     unregister_netdevice_queue_net(net, dev, head);
> >>>  }
> >>>
> >>>  static void geneve_dellink(struct net_device *dev, struct list_head =
*head)
> >>> @@ -2518,7 +2519,8 @@ static void geneve_dellink(struct net_device *d=
ev, struct list_head *head)
> >>>       gn =3D net_generic(geneve->net, geneve_net_id);
> >>>
> >>>       mutex_lock(&gn->lock);
> >>> -     __geneve_dellink(dev, head);
> >>> +     if (!list_empty(&geneve->next))
> >>> +             __geneve_dellink(dev_net(dev), dev, head);
> >>
> >> Sashiko noted that the lockdep chain between dev->lock, utn->loc and
> >> gn->lock is not trivial, possibly a documentation follow-up would be u=
seful
> >>
> >>>       mutex_unlock(&gn->lock);
> >>>  }
> >>>
> >>> @@ -2754,7 +2756,7 @@ static void __net_exit geneve_exit_rtnl_net(str=
uct net *net,
> >>>       mutex_lock(&gn->lock);
> >>>
> >>>       list_for_each_entry_safe(geneve, next, &gn->geneve_list, next)
> >>> -             __geneve_dellink(geneve->dev, dev_to_kill);
> >>> +             __geneve_dellink(net, geneve->dev, dev_to_kill);
> >>
> >> Here sashiko foresees some problem with CONFIG_DEBUG_NET_SMALL_RTNL
> >> before full conversion to per netns lock even of ovs. Just more
> >> follow-up, I guess.
> >
> > Is it Sashiko-nipa output ?
>
> Yes, sorry I should have included the link:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731164612.214883=
0-1-kuniyu%40google.com
>
> sometimes PW reports a timeout, but the report is still available via
> the sashiko nipa UI.

Ah, good to know that, I gave up looking for it due to the timeout log.

Thanks !


> You can search for the patch title in:
>
> https://netdev-ai.bots.linux.dev/sashiko/
>
> alike the gemini instance.
>
> /P
>
