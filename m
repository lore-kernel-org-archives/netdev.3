Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334C392C42
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416321; cv=none; b=IBGOooxLvUXC+T3IN5NouXAZ/HYmxwTG/u/REBoVkRTNndXaHw1sli/XNMD02enygYKHv4cKBVv0AJdnzhHyfuwQuVO1HcfFr0LtukuKcILfhpqtrjSO8pmlyUwgaEzJG81CsrmzceeNZDeXCLZntgW4AqO0WBIi8P7YEuhcuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416321; c=relaxed/simple;
	bh=yn5s9xE1xDD3NjH8SO6qW54Txobg24R4n0g8viFk+2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h3OrxYO0t1HMoULjtV/aNnbYzZ8tm58Y1Uee9jxtJbj2S/8n7MxVViUkl1dTXkSVd8lpXmssLWso6ysCcz8nIGN59YW+6iLpP7/tZxZjdHkWQRj6Hf38xRH1s+N/iUqDoeajhCC1ibXg2rgNEdltCa9SW8jZhkIYCoc72zf437U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcNwZHOz; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcNwZHOz"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso2142887a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786416300; x=1787021100; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JG8hvLKVYlkGQJclXs7QzmencZ29P2O6bBbsJPdcu3I=;
        b=mcNwZHOzd0JKVtpRf4dxBWv8ETm127mO6gAn+gsPdh9FCgmMki18Ga8GxiEl5NjHz7
         L3tB33MbR55IJoE4zOVojC4++yAttnk5HcDYUFB39pp2hD5qDi8fGpf2q7fN0DDwxdAl
         djdAcyndW9inx9gEngAIx9QkpEmA2YxDoHchAGi54CZ09cjSKjI/l6WYI8R6lpIMzNDx
         qIjtwuNDRxUxwPrlX1pkIkDYMuGVsk1hYyn2X2OE7g15RbkArXnUYrUMT1yICe+6s3hG
         TudhDMxq+E4UYk+1ABjo6mpyFXTugfeu36z5pbumvMd3cQ2DpdOFa+xQG4SxfyJW2+2H
         OkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786416300; x=1787021100;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JG8hvLKVYlkGQJclXs7QzmencZ29P2O6bBbsJPdcu3I=;
        b=AXNzbUz3LksHkCaFz22RU6/0GYQOnBDIJNq+YcOQjurliTAJS6nU+1B9clIFTgycC7
         RnHJ0AUOJ4/CClLV9fIgJCWN+TL0m4vVBWh4c9MwaH/ayV3U861QpvqI+7HSBffVX2SD
         ZP8CTcO6NZKVopmcnSYpI21Gz/EuSsbkzJHjP1HtmhJH72ThFEOJtSpnFn9GDEtwwbL0
         NA609+7bjHMa1wdw3LNrGhhXdiOO/aPFJQhfu3nXJVviam9dWfUqx5bga0nK1Djp8qNo
         E7ohCymnjDGsqUoqbFX6pfLYqFZ1cvZky4SmFwE/xiA3c/cRTkLfoAZZPHez8QOnBYfI
         0/1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8EHpx6WveRcLx+spl6DP/OyjOVGYdQzI6hUeE33DMwdYQo+pSO2S0pUHaKxX09OuaugcReaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd+4TWV9aldshSuaw4SV5jWE8yKqxlMm1pOl8lQowfjsKuTHJ
	dsoBGSVppI8Lumr64hT4xNuKnH911K/DYF0D+pSDmMJaYEZWNGgCobXL7nGyG6qW/hNM0SKkXli
	Cj2XgoQ==
X-Received: from pgch14.prod.google.com ([2002:a05:6a02:508e:b0:ca7:7de:194])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3992:b0:3bf:6237:4d49
 with SMTP id adf61e73a8af0-3cc2baf926bmr409649637.23.1786416299972; Mon, 10
 Aug 2026 19:44:59 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:43:49 +0000
In-Reply-To: <20260811022012.5416-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811022012.5416-1-a0yami@mailbox.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811024459.139352-1-kuniyu@google.com>
Subject: Re: [PATCH net v3] gtp: serialize PDP context updates
From: Kuniyuki Iwashima <kuniyu@google.com>
To: a0yami@mailbox.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, laforge@gnumonks.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"

From: Qing Ming <a0yami@mailbox.org>
Date: Tue, 11 Aug 2026 10:20:12 +0800
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. The issue was found through static analysis and
> reproduced on a KASAN-enabled kernel by a two-thread program
> racing GTP_CMD_DELPDP against RTM_DELLINK:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range
>          [0xdead000000000120-0xdead000000000127]
>   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
>   RBP: dead000000000122
> 
> The second deletion dereferenced the poisoned hlist pprev pointer.
> 
> Serialize PDP context updates with a mutex shared by gtp_pdp_add(),
> gtp_genl_del_pdp(), and gtp_dellink().
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
> v3:
> - Rebase onto net/main.
> 
> v2: https://lore.kernel.org/netdev/20260808124322.5800-1-a0yami@mailbox.org/
> - Use a dedicated mutex instead of RTNL.
> - Protect PDP add, delete, and link teardown with the same mutex.
> 
>  drivers/net/gtp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..8ee516debeed 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/skbuff.h>
>  #include <linux/udp.h>
>  #include <linux/rculist.h>
> @@ -108,6 +109,7 @@ struct gtp_net {
>  };
>  
>  static u32 gtp_h_initval;
> +static DEFINE_MUTEX(gtp_pdp_lock);
>  
>  static struct genl_family gtp_genl_family;
>  
> @@ -1555,9 +1557,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
>  	struct pdp_ctx *pctx;
>  	int i;
>  
> +	mutex_lock(&gtp_pdp_lock);
>  	for (i = 0; i < gtp->hash_size; i++)
>  		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
>  			pdp_context_delete(pctx);
> +	mutex_unlock(&gtp_pdp_lock);
>  
>  	list_del(&gtp->list);
>  	unregister_netdevice_queue(dev, head);
> @@ -1833,6 +1837,8 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
>  	__be32 ms_addr;
>  	int family;
>  
> +	guard(mutex)(&gtp_pdp_lock);
> +

Please use the plain mutex_lock() / mutex_unlock().

---8<---
$ cat Documentation/process/maintainer-netdev.rst
...
Using device-managed and cleanup.h constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Netdev remains skeptical about promises of all "auto-cleanup" APIs,
including even ``devm_`` helpers, historically. They are not the preferred
style of implementation, merely an acceptable one.

Use of ``guard()`` is discouraged within any function longer than 20 lines,
``scoped_guard()`` is considered more readable. Using normal lock/unlock is
still (weakly) preferred.
---8<---
