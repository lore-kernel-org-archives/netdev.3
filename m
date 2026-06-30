Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4F233933
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856060; cv=none; b=VZJvcl2wm5YUJTmsxLAyiyV8qqJQVA+GVSyYTRqgP9gCnRmB+wHAy6+ZCvNpb4qJP5kPzoDeUNv7CZLqahJ27EGxu/xPf7s+EWY+S6Pr11dd1cAa+QsYQ1YYfgymOy+9ZcTkEvOULRkdm5YgcuYtV1+5mTDx6iARTNzMmuKLfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856060; c=relaxed/simple;
	bh=XNuW0ZGgez20bbhsopijtlTxIIjZ0NWgC3k/4NIZV7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IU0vmuqIQIZ2m4T0EM/Pey9yk2I3F9zCMh8sWByxGwONH1WiM1f/iXXpNeKCMkAvJCUdqiHfJHu5yxkDSImWj5eDqIQDHaYM0LJ6crDYpESGZcJU8ceKTN9dmJirmX8sJiu09FTL1G45J21AgpCzecdQmi9yh7QNm29mp7Az8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpHHIqfc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpHHIqfc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c8018f11fbso91515ad.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782856059; x=1783460859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGyt18YI9hlTzlAe3erqu3CT7ClGjgWwoVlpkDOVAt4=;
        b=qpHHIqfcSNEinfm7KVwJprsvDu+ajuHpxQwwRFzA6r+zC3W3Ss9FHoaBEP26uGotXP
         qxSjoErmaVxIqSw+7VPYdTrDS9zM6mlVZRnmM/yZdR9fl7VXEl3S1A60Ab+F4TU0zqK9
         Zrk5k8/jPz850tIN9hFVSF6sf/uXmB7BX6MWqwgzT+Hih4QuPjC25TbN+O2ejuixCcxl
         f7dDul9PQEaOQnN8Yin6ifuBsyryLvEraM7iXLUhVKtmYklNxaqGrDoz0qhMQAVWwdQ4
         J8ZjszCioScnOMdTIXXUqvkcYJ31H0/+CyqafSjyTn2Q8lFmSlyLYjHeY2KQyU48scoy
         8tAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782856059; x=1783460859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGyt18YI9hlTzlAe3erqu3CT7ClGjgWwoVlpkDOVAt4=;
        b=nhzQSNWmYpYZhjnojahV8zXt9tnO8AHXOrXSC5WxpRfUZfW2wdkZg+TaSXMIDEcBFd
         QMCm0p8Bd3CPfoFVeEp4x35Z2aTBQ1h1JMJWLqBvuwGb6Pw9FvgoiXI/bxBNyTRYMBIt
         vG1BZJf8nU87RkGRIRZjfy39QsLAP0GaLHz6HUXoPRsWIbDf8Z5It3B5/ad/K2HmKhjS
         9cyLs99BzShxqp39vRpAlH/e1lmc+GDvuy0GfhoDcOlIX3kCWyuuHTX8Q9o0rBE/7O8S
         re5QhxWBHKB/WbuUnjCb1vpYJX7EOLkmCZeKaHZy7KieQeciq0Le8/B+DUnPYsUQxlkD
         Pkyg==
X-Forwarded-Encrypted: i=1; AHgh+RomUoHnrRV7XqMg2lXZslN5aPyAAk4nLvasNeiOUdi5ckH9EuquoFe4Yt70Fb7DqQQk2tTueo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SD47WwuKnz7kn7uaifni/uXu2dHeEpciM7f8VQprqbduIAH0
	LhgVEncptdeV/cVkGsoRnxI+RXTGWwvZXAB6z5CXIAJS9mFjt5lx9ThoV2/6aQQsgT7Wq1/A6ZN
	sF3eWyw==
X-Received: from plkp12.prod.google.com ([2002:a17:902:6b8c:b0:2c6:be9a:d6c2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6d:b0:2c9:f44e:9942
 with SMTP id d9443c01a7336-2ca2d547e03mr43220105ad.13.1782856058393; Tue, 30
 Jun 2026 14:47:38 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:46:38 +0000
In-Reply-To: <20260630211808.50440-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630211808.50440-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630214737.3387996-1-kuniyu@google.com>
Subject: Re: [PATCH net] mac802154: wait for RCU readers when removing interfaces
From: Kuniyuki Iwashima <kuniyu@google.com>
To: alhouseenyousef@gmail.com
Cc: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, marcel@holtmann.org, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	stefan@datenfreihafen.org, 
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 23:18:08 +0200
> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del() and

The problematic part is list_del(), not unregister_netdevice().


> immediately unregisters their netdevices, so an asynchronous transmit

not immediately, unregister_netdevice() waits inflight RCU readers.
So, synchronize_rcu() should be unnecessary.

(Same remark for ieee802154_if_remove())

> completion can follow a poisoned list node in ieee802154_wake_queue().
> 
> Match ieee802154_if_remove(): use list_del_rcu() and wait for existing
> readers before unregistering each interface.
> 
> Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
> Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  net/mac802154/iface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 000be60d9580..73d82a015184 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -703,7 +703,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
>  
>  	mutex_lock(&local->iflist_mtx);
>  	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
> -		list_del(&sdata->list);
> +		list_del_rcu(&sdata->list);
> +		synchronize_rcu();
>  
>  		unregister_netdevice(sdata->dev);
>  	}
> -- 
