Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68692471266
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865127; cv=pass; b=ZL1WQmwctR4906Wz/rmC2UgT5t/1JLBmTlJYG6xkal8Vjlp2sWpTX1vBY9S4oAk/W0lCYj8tZ4FaDd9Ya1jsaNmYoxd7VHVxgXmXlg0vedx8qbeRXB1UiYkBmsf/WW0ZrpczHdldXoG4pewTugpeNIgk5T4HU65asAT2NKleo2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865127; c=relaxed/simple;
	bh=5zXDz8BQeXn7p8JZo2vsSpr1PZpdTPGp2kGv5wYdk/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLAm3qubQ9lqrb0/zWmjlE10pLMX9cR773sp/SwWwicFunW8nMt1bXzx+zu+JSgwdsorOGjuhx3HMqZnCYHojBEcknNUwISU3ryvexwkW9tyTockW3RZTgQkGOwz+MGTHOYpnC/nZ9C4w2dLgzaiIOreWedaupiDOhmKYDq2fCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYL06NZT; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYL06NZT"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso33288a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865121; cv=none;
        d=google.com; s=arc-20260327;
        b=nPb8B4ddFh/2K5pLjgzYSyPXiA/neGuasrlH4/btfhlZPg7wL9QGkDJlI+ThXjc8UQ
         2+XXTt1R5NuHrSEFGxl+nuAxyWzBPqzY5AI8DnjC0V/GjuUFLXUcbua0SCivR2wQAOEu
         SHZSwT2su0WbhVep6cOVy+ZCa86Ao6uf+39rW7p2yVKSuNiBy5e6lgamTQhz6b3LAob5
         N4HP3EHmx7bSSDXWs7aEgQ+KUsKxvqQVN/yFftjQq9yl4tsnGV8JXf5XUd4snN5wnEUq
         Y24V8Idd0dcEUs6xsY9UBiIgDB58RwxDuJi7MzbxWJhhcyu5hk3Mnil24Ly/cgb/XcXz
         q5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmE0SQCRuR0QB74v6wohw/MTmm8RZLtgtewiGG0CKOk=;
        fh=U5dHsQoNwfMMRU/TdctKhL4rGmcSqcxCBhuai87H3M0=;
        b=URgIQuaDGmdWVt9HFuw0NKsZAaz89h6YlqYB4RMA8do2a2FmmQpcxIlD67gGBo5hGK
         zQ47ez2ZADxizn4wcarHVAuwywD1zk3jZ+HP1w81DBBaLd8rzSpqTJsyI9kW+7WeMst5
         or1KqTpFV9aMe7H2BspImV/7Bc69kNfT0nFI44Jt4M6QeND46Lm0Bg6lqXE5n6dkHcP/
         jOLskKeyVD08vp1ZFvkv1DfFJPEQxgXGyvxmHKRFsDy/lgEn/1ZqpFPDRF0enn1HeGz3
         /60U0U3YqFBRYvI7SRU2S5mbLaWnsvNIvWKX8hKP5Qj8QnVEf6rWdPms+94TZy7qsBit
         /GVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785865121; x=1786469921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmE0SQCRuR0QB74v6wohw/MTmm8RZLtgtewiGG0CKOk=;
        b=FYL06NZTiqXZlTUISbXDBQvIeLk6vsuigXes9Chbn4Ytzp9KK1XGRHMLRAZmaWsnma
         ewv3E9HoSKUldXezfaJupt5FfeikiDVjcyGGUej9U+WlUvZAPSTe4/BcE+dfCD2BW3vJ
         CDJDYGPY1giDkX8V7liWj6165/AJ9bNqfn9QQugUs48zXUmtQwtDaB87Lq7PTDMSp+Wf
         8kIDc6GHkLLDIZlDXMM2kvbw1AcT8IPAV04QuxAan7ccZ0fhWR5TYmT+O5q4bemSqnq1
         fzl1JJBPeJLNmBBS1CYSGC9ch9XLvx9q+asKg49H47S11LZUnDqJYRM/13rfggtajNla
         23kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865121; x=1786469921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmE0SQCRuR0QB74v6wohw/MTmm8RZLtgtewiGG0CKOk=;
        b=dqfaHC99JmcYqKjPa9pSvxL1UKQNETuYw6ZnLSeGWbz5vdUBHEip8cUKD5ZUJYZs9F
         a27dvIO0nePo2QmM7dqvTUopdlcZkidzLLRKGFF19OzDh96Hz7PdwG9zMYOPk4AgGsOD
         8VAWo6HhiI+RfBxVin/YgIy9JmshjJ/IPImusBAm3Qptt17kipQuzXg1LqF6KBeTBIQO
         61KdjOXI6XlMufv7Nd64LxSx7mVuFo3Rv0bs4PvxjWnBZcYMZcBgmdnf/iZRdnWuMC2X
         ckjWo5elq0/2CM7L6y13PuJpX7sFdbrXjzzaqOWbAN4+LLVBuQsNDI2v/ejFY9uT+MHN
         +MMw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1pJyDyxIofKUcZ+G2VTbtJE0RmrVUqc1d5Yh0gE5wL5AZpuVt+Qa0p+OOJH59Wjn+AWWD4UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11E2LjQuFr4rxGrfVelfc8PwjyE1JIu145ou5XOW+mx3K4Gac
	AS4Pv3oh4UZyJ5JjrtZqo8kEfJll1vZ7JuyYn7as9NCiLQAGz93S3Rzv5PGlrK2IqTwmbbCTuUi
	4LNVzv6UM7tx8Cq6H/kuFKpshU10dU0HTllW7YLUq
X-Gm-Gg: AR+sD10lwPgFZizmI/b16j6nK1R21zQu/k8IcdWB82nVNJiwdOGjQvDG18yi+7XbT1p
	L5hc1aY4IomAeKfaxC0epAABwBpOySzHyMqsDVYIR4urELo+rFLreWzGSYiJCFu8RcitL/IC6LD
	48j1brg3VgnI6l9INr8yiXNLPrluY9eKnW7sVv6oFDq9Z2oY6Ezgaykwsf/kFNwjSfugZOA5tlg
	4xti73Mw/hZpWkFCvdMtjJDiLqqr2d9F2nVFpcsMfzn+73xJTOlIEucvaCiyMBK6AyN77+MGyX2
	f3ZMjF9V5vumvagIeyDAghP0KNu9HkKncZFIgKlmu/lzRxeQPGlsTUulDabW5zKcUb8T17BVkXv
	75jZl02+5Wb6IesW9M+cGKZgeD2yFgwqQrh8L+XwFE0yYU0FTR+VvRsUnDRWegkpIx7czD9iw9Z
	hbzUm+WiHbep8=
X-Received: by 2002:a05:6a20:428b:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3cb85ef9229mr521889637.22.1785865120654; Tue, 04 Aug 2026
 10:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731164612.2148830-1-kuniyu@google.com> <20260731164612.2148830-4-kuniyu@google.com>
 <bfa765c2-a3e7-42b7-90c5-9757d8392687@redhat.com> <CAAVpQUDmZEaQNDSySLayqexgTrUbhBaL7XPCt9XNQzh+NGQ=UQ@mail.gmail.com>
 <cf908cea-5518-4dec-bf47-73b4e6b5568b@ovn.org>
In-Reply-To: <cf908cea-5518-4dec-bf47-73b4e6b5568b@ovn.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 10:38:26 -0700
X-Gm-Features: AUfX_mwK6OEG41u9efNbqxPmlaqm4LXNvmkxpe5zsNykJ-zQPferB5hPY-_c8-Q
Message-ID: <CAAVpQUANCX7KiEqk+=rCHt9F0CscX9ssACwAGQCZ4F0td3PqGw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/3] geneve: Support per-netns netdev unregistration.
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:35=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> On 8/4/26 5:24 PM, Kuniyuki Iwashima wrote:
> > On Tue, Aug 4, 2026 at 6:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>
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
> > I can't find the comments from patchwork.
> > https://patchwork.kernel.org/project/netdevbpf/patch/20260731164612.214=
8830-2-kuniyu@google.com/
> > https://sashiko.dev/#/patchset/20260731164612.2148830-1-kuniyu@google.c=
om
> >
> > btw, I was hoping this series would land upstream so that
> > I don't need to care about OVS :)
> > https://lore.kernel.org/netdev/20260513183559.2141010-1-i.maximets@ovn.=
org/
> FWIW, I have the non-RFC version of this set prepared.  I can post it,
> if that helps.

Yes, that would be nice, thanks !
