Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B43B47FA
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252491; cv=none; b=S4KVA9NxAEjXhGkKtpuftHCNfGXTQgDkWyiVHch1lJt1D+dPzU6aYSgUxr/87SUgwb7rShoAZfwkev/UafCir2He7xgRIkMC/Q0zHYf2S53ntRDLIa4a43+iTrtjqh4P9QfLvUxzraYXatLUQeWmcm0Hb+2jPYaslT4/fbbT7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252491; c=relaxed/simple;
	bh=C4KEQYKYMt+jPGupFXeYgtyzFlnYTdxDs0//Owq2PWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUagGffXXslSqHfNrxDCpC8o1rTYNDXBM1ASd4y+WHGqXr1vXuqWF6MtbjmRfg/ZIEEyZ58XhiwiMd4Im36fmUbiIZK+o1YEuBFLh6Lzg+EaosbViF9bwKmttUXX6zqoMU2Buo1b8zBpVDGICrOyJed7aL7knfqeGtyvax/b1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0GSFJJr; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0GSFJJr"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3664df32e91so658392a91.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252480; x=1778857280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVsAIDWuXutjxalCznuSZJzmb8d2/FmjsiE/YFxHP1o=;
        b=k0GSFJJrD1to0PbG8ZmvC0Y9LJNb3QkjjoZtb7wK/ZDczTYm3uWjZBFFtRLsX9t/eq
         +s8uZdFUFfdJz/tkhb9zkkihV4X9ZiK+TI0oRe16kpl8iYbUDquIXDqeqzOGTwJS2vVI
         5S1Jl/u0MS862SupdkPlckRMaUYyuej8xckw5Vm/alUJ3RY3tQms3rPS9lmbi1bxzblN
         KPr74+xMjODE1ognAQZHD2wDXQhDTyidKirrffNRx4FR9wX9o2Q/hxjbNO32U1L9fLgQ
         mbMr5b6mg/4oZBUt1XgFSBaygNFogyF3lxCq9TVhNSwvfPFBQV8mvBlj1bS7NjnNqhLa
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252480; x=1778857280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVsAIDWuXutjxalCznuSZJzmb8d2/FmjsiE/YFxHP1o=;
        b=WEMdtqGmzYmx4Vf7/s8cnX9CqGCLy+h8NWGSMyQ4ohGqmIT8aF9EPnocKhSc7QKP70
         DFA8Ty0imN1QCGOztmGRoGZ4UWLUILq4SJ4hlQmpOlIEBYgSP620aTQ7hGLGhJfHOopt
         dN9n/qL/ywQjJgNT4voEC6yCGSauDA6Fs/LvjX6ZmUzx/TAB2Uajz5Pi8XwAGBdv0u/Y
         GtWxV3q5TIOioNd9MQys5jyQyiaQqJwoh0tfO5kOSzMbas4cHCmKdYGhgcfKLo+VksCL
         h1wbW7GloUCMMuFwGnvoHAmuQUCwYm/+keal/sOT56pyTvM08DxwbTwLtFqw26qIoPEa
         CkIA==
X-Forwarded-Encrypted: i=1; AFNElJ9XzVUzNQeZgbnQZhecCaZjcO0DxRWZPRy2O+tT+VJ2FCjHneA/+Ldll9TY8tDT+1YavXJmEDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuebMTL32rrR4qvzhD49tLm4wnzNmlGRa+vitWHsPjqYgEqE1
	1UHxNRIGX0rC0UOZuQ224SW9inSziF3dxPxex5PF3U4NzpcNP/kAnrDx
X-Gm-Gg: Acq92OFRGbf37AFw6c/mdLj7jpQ4No+GW92Vy5O0njnWhdUzRdtJcMBd6ZfWRlio49i
	omGypjrgfDiwMRbxHZNem6sdyEOS6B47bjOsmBlu01NRde8BU2rBvcO4KUnRaRU+WwrnvAVH0uS
	vfTug51Nt8XxjfhUgXfjRC0XsnKzk1vQNJ7o3IHKyX6A1/cE6ud5fOotC47/hOX2PT+GZXgkVvy
	bSloPIWF3eUtdZCB+PmcRNC4nt58U9g99GR16I4nMyna6WqLHFNe0mOJmdFdZ6GuxPdgw3EnZFv
	c/dx8rv8aRKnqfF3axK2Lv2OKExoCyOONKu5EBPwf/F6WBRofy46R1szRe1+hLyBWUZq4V2GRKk
	N6c+0Xa59khXTh+Zdaj2qKxDpYy9SP22tSyab3/p+VPoviaM5PIfELtXpuQz0sYTUM5dH99jB2U
	5Qs1s+aEwcAYNkwCEoJInSrvN/3qNt8kfF5jBo
X-Received: by 2002:a17:90a:710:b0:366:159a:c228 with SMTP id 98e67ed59e1d1-36615b96cf0mr4284277a91.6.1778252479571;
        Fri, 08 May 2026 08:01:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c119f372sm61912a91.2.2026.05.08.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:18 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When a netkit virtual device leases queues from a physical NIC, devmem
> TX bindings created on the netkit device must still result in the dmabuf
> being mapped for dma by the physical device. This patch accomplishes
> this by teaching the bind handler to search for the underlying
> DMA-capable device by looking it up via leased rx queues. The function
> netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
> device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
> devices in the future if needed.
> 
> Additionally, this patch extends validate_xmit_unreadable_skb() to
> support the netkit case, where the skb is validated twice: once on the
> netkit guest device and again on the physical NIC after BPF redirect or
> ip forwarding.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v3:
> - Fix validate_xmit_unreadable_skb() bug for non-devmem
>   unreadable niovs (should not be dropped)
> - Major simplification of validate_xmit_unreadable_skb()
> - Fix prematurely released lock in bind-tx handler (Jakub)
> 
> Changes in v2:
> - In validate_xmit_unreadable_skb() to check netmem_tx mode before
>   inspecting frags (Jakub)
> - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
>   netdev to fix lockdep (Sashiko)
> ---
>  net/core/dev.c         |  3 +++
>  net/core/devmem.c      |  6 +++--
>  net/core/devmem.h      |  9 ++++++--
>  net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 72 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fbe4c328a367..268417c9ef22 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  	if (dev->netmem_tx == NETMEM_TX_NONE)
>  		goto out_free;
>  
> +	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
> +		goto out;
> +

Since this is a good case, maybe fold it into skb_frags_readable check above?

	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))

Otherwise it's a bit confusing to have:

if (xxx)
	goto out;
if (yyy)
	goto out_free;
if (zzz)
	goto out;

(or, reorder to be out/out/out_free)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
