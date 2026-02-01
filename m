Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4A2AD20
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769955452; cv=none; b=indm1QRp89Tyy/NKZpLgQitcl8RCXC09rgdUM6rG7BWuR1CQz3bDThsHniRhGCKs/h4m80jejFH3d5aayHUvP3Zk0ODQzJCBJd2/ww0lCD1JwFhSJsE0HmPuRYpsLLGFIxZ10aCbzTUOx9V30C8srHOz93ppMcJZ4GjVGnnkGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769955452; c=relaxed/simple;
	bh=gl0lXncd62Tnf6kPllTJwc57kMyuanR54eBFQ5YuHNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyyaZg/im1f8U3epKD3U8B60vB12OjuvfkvXu4mgxrGwI3BeCFMsyDv5C5g1jxTmrwujx6cn0UAS0xfBni5Ql9qEyjTBQRgW5c1qx0/NtlD4el35Q5Ns5LGP884vSDf+7QYkpQ+ZifgTKtcKXTzXkNuSI2K2ZsomTemckwdBM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 611EHRpA029308;
	Sun, 1 Feb 2026 23:17:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 611EHRE0029304
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 23:17:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fcbbbf70-f28c-4da8-be10-1863d4a6c0d8@I-love.SAKURA.ne.jp>
Date: Sun, 1 Feb 2026 23:17:24 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
To: Leon Romanovsky <leon@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
 <20260129090959.GD10992@unreal>
 <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
 <aXuFTJZ3SvaCBXj5@krikkit> <20260201131253.GD34749@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260201131253.GD34749@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

On 2026/02/01 22:12, Leon Romanovsky wrote:
> I don't think that it is correct thing to adapt core code to something
> specific to netdevsim which was introduced to emulate missing HW device.
> Like in real HW device, the expectation is to have NETIF_F_HW_ESP bit,
> we should have that bit in netdevsim too.

I posted https://lkml.kernel.org/r/cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp
as what I think we should do regardless of netdevsim module.

syzbot is reporting "struct net_device" cannot be released because xfrm_dev_down()
cannot release reference to "struct net_device" unless NETIF_F_HW_ESP bit is set.

But I wonder when "struct xfrm_state" (without reference to "struct net_device") can be
released if xfrm_dev_down() becomes no-op due to checking for NETIF_F_HW_ESP bit;
I suspect there remains a resource leak bug unless xfrm_dev_unregister() is added.

Currently 50%+ reports of "unregister_netdevice: waiting for DEV to become free"
problem is hitting this xfrm path. Since there are other paths remaining, I want to
exclude xfrm path as quick as possible.

My question is, apart from how to fix netdevsim module, can my xfrm_dev_unregister()
patch be accepted?

