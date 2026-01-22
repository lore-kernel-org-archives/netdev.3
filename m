Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A722B8CB
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048560; cv=none; b=bB2ZHAiK17CCrInc0e6Ik0CTgn61ko1cdGI3p51NQy6xI2cWFkDZrnNVuBxQEMncsJ7WawdMLwqPOoTz1Dy5Q0q9Pe//s/h34x0/gmhK9o9/OB2IfxYN0xx4cqswFkOTx7MdbYQjDutRHXeGfqc7N6HlVK9LNfpvZtvyl0CtuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048560; c=relaxed/simple;
	bh=67m80EIfx8S+LDELzvgo+VjCJ8YR5c49gdMB/HskW1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipIwg3qXhDLSkY4Nusi9yeRHelZTqDjopYIn9tEFIeR6iLTg8jAnnCWIWmBa4ECa+Vyl01UC6e35Wgg2hjZqc3Bh3YtTpPz76ZU8x6Ol5FD1jJMNPVor0mbNfgpPG+bxs/uSAm0atL2X2HMzjlf94680gvt55Lkn8EtR7EsavxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm64XGUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm64XGUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C074C4CEF1;
	Thu, 22 Jan 2026 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769048559;
	bh=67m80EIfx8S+LDELzvgo+VjCJ8YR5c49gdMB/HskW1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm64XGUbY5+w9UWUA3oCuuLKOJgVXV3dKf3B3JLi4XFL/2RKPAZesaCRY6oW952hT
	 MQMbRStPiDgaLhkBV7+6gx9g5j2/5WyYlKWC1wGNm1KPm06szOMfBvRpRGnLSUENjL
	 cvhpHsIwRFRAu+NUVGRCm+peazd5zt0Q1X5e6ogFsy1pgLuPu+HRhD1VhTn3F5wQim
	 qZypTsimuohiYjbZ4ERTyaKi+haPXjAr0eVK7P1egj7chJuzoYHpxvoIT3zxxw6+Tj
	 pItP7Gl79zegybuZxDK72nYwe2cbpRWfhut+sjIDYPbMNRUmBu/6nMNQK867GcVnCx
	 hZygrR3V072PA==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	syzkaller@googlegroups.com,
	andy@greyhouse.net,
	eric.dumazet@gmail.com,
	pabeni@redhat.com,
	j.vosburgh@gmail.com,
	davem@davemloft.net
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
Date: Wed, 21 Jan 2026 18:22:37 -0800
Message-ID: <20260122022237.2529455-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120152856.1694824-1-edumazet@google.com>
References: <20260120152856.1694824-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bonding: annotate data-races around slave->last_rx

This patch adds READ_ONCE()/WRITE_ONCE() annotations to slave->last_rx
and slave->target_last_arp_rx[] to fix KCSAN-reported data races in the
bonding driver's ARP monitoring code.

> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 384499c869b8..74708bd2570e 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1152,7 +1152,7 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
>
>  	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
>  		bond_for_each_slave(bond, slave, iter)
> -			slave->target_last_arp_rx[slot] = last_rx;
> +			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
>  		targets[slot] = target;
>  	}
>  }

Should the IPv6 NS version of this function also get WRITE_ONCE?
_bond_options_ns_ip6_target_set() writes to the same target_last_arp_rx[]
array:

    static void _bond_options_ns_ip6_target_set(...)
    {
        ...
        if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
            bond_for_each_slave(bond, slave, iter) {
                slave->target_last_arp_rx[slot] = last_rx;  <-- no WRITE_ONCE
                ...
            }
        }
    }

This seems like the same concurrent access pattern that the ARP IPv4 path
needed fixing for.

[ ... ]
-- 
pw-bot: cr
