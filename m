Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD0220687
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355705; cv=pass; b=eP0fWtBS/bfDj6HJ/JQyuQpVHCBUQzMb2qNBOmWAwGdt51fbDNEdmqHzKXAeNTQV35Z6wM7RnDV+NpsqhvyQCCDQnaevTgqywS9e4ZgyPG+J2bbSnKmCLsi2IOGsWO3UXJ6pJ1intqQ1ZONtVAgmZ9psxcKllh86gwGFqd+qThU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355705; c=relaxed/simple;
	bh=jp4o02YVqFXtkcO5evY3sYAyjmc2SIxBIBpizq3qZCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI+7/Km9XN4YnyIfLLvstqmlw7uOvtJGkoDwLGsD/sswWPPPyRJf805QeyXd/TmCO37EFYYY1BCbcIWli8OX9GlIFgnGzGQDDh8qhEhMnnlRq5cVmenCWntHxiTe92JVe8YqU6kkh7g76l/mD9h8tk2VkXPrtZEOfC+jkwsYfzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOPhojDr; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOPhojDr"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so1855469a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355704; cv=none;
        d=google.com; s=arc-20260327;
        b=PdEIrpu3r06FH43LtIfHoKMLg5sAU3dPQ2vbJKh8hTWAsimGK9gn/dK5/aEEReGqHf
         3c8WbDF117HViZ+uS1Q27gnZbM7Hwr/Rzq7zprKpq+e8GJyH+Z2rgUzPFB+LqFVfYe5T
         xeAVi13kTZet4FCmHT4YikpukvJiUpOo4tDGBAeXOBzvRfRMyjQtCF4vi1gdKqm+LeZx
         USmANGEdNJJUaz6x7s2ZCk61lApFVWhfYF0CMfjYKBMPvD+ujfOA9aH36n9Hl4ZPKoE0
         EUioQLdv0qXG/MduGbRVghE3wlRXsjvM+B44/7rGpAcWjhZ9eFav6TBonevsZ+G9MSq8
         RdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/qK1HC6z6FPRZZxYaSbBC0LTsTLNWfixN1WH2aw2eY=;
        fh=ODpa+pky6NNW/T9O0LGWzl64o2roM0A5mSRkpqwKzfk=;
        b=OEbDWHs8Yrqk/hkTdOMOz9TCKX+lVqo9RpahxY7WaJdIW+1QjfRqQLqOwQC81ugXT8
         /5oonEPpvfPKjmZpbg4A5czBiqfZgcXVInaVB2/Hylw5IajWfMVMKigDbVDXfV9K4gG5
         4uVTTzBJ1EJgBXu8Bjpl2fs5ZxnM0+93UFEn64GjGeP0YGeXm6e3Mgdoqs3Rl+D9+wem
         sAIIKPn0eFa5dKRFeIlcK7iZKqrQ3Y+QpHFH7AxIKiqUUkH5x4TwZ85In6XtGeD/+VmM
         qdoEA7UMmwrrjPIFkSAxZQoCarI60O5m+h5JDPmgLSAFP3OQZ+vhwIqGyBaftR84a29W
         jMAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355704; x=1783960504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/qK1HC6z6FPRZZxYaSbBC0LTsTLNWfixN1WH2aw2eY=;
        b=vOPhojDr6/KQcYRagi3YDV0G0iS8CW7VRin3vCw1ywGlW91PNqetU11B8WTXGymx1Y
         Jb3r3DPC1TfRD05iE2Q+B2Lrc48RKPLi1My5X+7IYNj7c42BLtE1uOFI1Swen65Shmos
         AGGm3fga1Ewq0M48gP29VJELvjOZWL1U8rwvJjiZtDGk9rtQ56rB5Hc9OwcNFUnrRmHx
         coZK1I0Dx6aj6WssTWFTyQjZurCYjHz/lo+mNephDm3Rs3z6TYNpO+iLFqL7C/hvojNh
         QRBg0qNq8KCkUQXBfhwd3367HX2lBpxsaoxJeRkxSqFoeWS1GV4d82iXSbN3uRdMd+VT
         BarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355704; x=1783960504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/qK1HC6z6FPRZZxYaSbBC0LTsTLNWfixN1WH2aw2eY=;
        b=aWya4vzsAEcZyuY/z5s/95yM0bk5q2dkH2/dYcRKl0XCAzfm/3+BRSxH+KNfpFgfTc
         qxolqfEi9Zt5vW7UY0k1mYqMx9LxEAWC5OHgIq33LjVmsSoKmKuCGzcOtv67trIkLanU
         ACTLOH17b3ZMLbVo8qZhgTZg1OORvg8jaK7AbPNy6p7SLpZOd5KU9v/u2Mo7ULi2h41q
         xiBlzHCMFHUMeftUi6VjiYBtm/oDV2uK78Qd4Z1PaPVf/uXvCPp0Xl0k7wwNRABTkhiG
         qIGZH9OZzzsNfffTkdkr3kWQI4FQz73X3JMTepF68LdiqOKaoKG524jDnIkbp+HsP0mU
         xAGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpt/MaC4dvZSt2446vuvSdS55nbbTo6fIHedffdO6YdMKHAbFD1y0Wjc5kdyKF/9ILi7rmCEN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mra1nf6/1ex8HjhefipK3mOVUYcKBmpWBLGLQp3kQW1mG0y7
	CgH/sDBT1ENcNybvtnr5Ir3Qrs0b84TVhgCEZozohcaSS9ZyMGKVPyzwpkXSUGjnma2WVgWqkT2
	/KIDXSDuJEn/LFMxJbAtSGXirZJdSLNDfyHYJEXBR
X-Gm-Gg: AfdE7cnoKVzPbXsGlef8+Z7XMJoO7QI4IIwrs9zDgc/ObhA1yA6ZMgLhx6cR1sogwOf
	CeZdQhhPySYSKi8z4K70U3hkjdi5ag1Sw7ZUappQKOgaWeKZGVxtxSU7JcS9oAY5GQZn9uBrwAp
	uKrNzV5UWsIBusvacujAcvX3h7pSm7HBonPU4SmLR3t/Ahhjpqmz14NUj7R3puNXdqsvl0b3RRe
	pb0dbK3tYrOsRWiV8FFi93K8Pg5iDqAyiWcdiZf9JZZyTdcMXEE/l27YUb5SwTsWwr4Ycs7NrCF
	VGg4k7W2+ThaqbvV3d6nUNY7GoAMd1oMiIjBCAvuSdjCp6ycZF/w4znA3BGXplmaOMeQguVpAiE
	m+RmK9FiZ0Sv5QEHvFoUVbCp6g9BZAxckOUcyiRk=
X-Received: by 2002:a05:6a21:682:b0:3bf:9e25:1a0d with SMTP id
 adf61e73a8af0-3c08ef84007mr1665765637.52.1783355701949; Mon, 06 Jul 2026
 09:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-7-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-7-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:34:50 -0700
X-Gm-Features: AVVi8Cd1DScKSpt1fSOrucCK6h5te4ybwOSBDsA3Guj0c3vPkDpBnte_OvV2jP0
Message-ID: <CAAVpQUDKoYU773xHEfVR4J1LLJyF+v66eAJupaM5XQqe2vE1vQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/14] net: Add per-netns netdev
 unregistration infra.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
>
> Note that unregister_netdevice_move_net() does not need to call
> rtnl_net_queue_work() because __dev_change_net_namespace() is
> (supposed to be) called with rtnl_net_lock().  (Not all callers
> hold it yet, but the race does not happen until all callers
> are converted and RTNL is removed.)
[...]
> +static void unregister_netdevice_move_net(struct net *net_old,
> +                                         struct net *net,
> +                                         struct net_device *dev)
> +{
> +       if (net_old > net) {
> +               spin_lock(&net->dev_unreg_lock);
> +               spin_lock_nested(&net_old->dev_unreg_lock, SINGLE_DEPTH_N=
ESTING);
> +       } else {
> +               spin_lock(&net_old->dev_unreg_lock);
> +               spin_lock_nested(&net->dev_unreg_lock, SINGLE_DEPTH_NESTI=
NG);
> +       }
> +
> +       if (!list_empty(&dev->unreg_list_net)) {
> +               list_del(&dev->unreg_list_net);
> +               list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head)=
;
> +       }
> +
> +       spin_unlock(&net_old->dev_unreg_lock);
> +       spin_unlock(&net->dev_unreg_lock);
> +}
> +
> +void unregister_netdevice_many_net(struct net *net)
> +{
> +       struct net_device *dev, *tmp;
> +       LIST_HEAD(unreg_head_net);
> +       LIST_HEAD(unreg_head);
> +
> +       spin_lock(&net->dev_unreg_lock);
> +       list_splice_init(&net->dev_unreg_head, &unreg_head_net);
> +       spin_unlock(&net->dev_unreg_lock);
> +
> +       list_for_each_entry_safe(dev, tmp, &unreg_head_net, unreg_list_ne=
t) {
> +               list_del_init(&dev->unreg_list_net);
> +               list_add_tail(&dev->unreg_list, &unreg_head);
> +       }

---8<---
Will this result in a stalled unregistration if a cross-netns device is del=
eted
and concurrently moved to a new namespace?

If a user triggers deletion, unregister_netdevice_queue_net() queues the de=
vice
in dev_unreg_head and schedules the async workqueue. Because unregistration
runs asynchronously, dev->reg_state remains NETREG_REGISTERED initially.
If the pending device is concurrently moved to a new netns via

dev_change_net_namespace(), unregister_netdevice_move_net() correctly trans=
fers
the device to the new netns's dev_unreg_head list.

However, does this block miss a call to rtnl_net_queue_work(net) to schedul=
e
processing for the new netns?
---8<---

I didn't add rtnl_net_queue_work() intentionally as mentioned in the commit
message.

For now, such a race does not occur thanks to RTNL.

Once RTNL is removed, all dev_change_net_namespace() callers must be
called under per-netns RTNL, so even if the race occurred, the dev would be
removed at __rtnl_net_unlock().
