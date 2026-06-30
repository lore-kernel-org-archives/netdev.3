Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09763E1D12;
	Tue, 30 Jun 2026 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798204; cv=none; b=PE2dbXitwHxh9sabyq/1x70/92Ltw2l60cT47mMEB6mhqtpB23wpjpOp7AeFhLx8FfabkFhjrH97iXqd29X1chcXC+pqWT+unXb8V+Rk+PQt59ovcBy9W/N4+laBJmT924Y/hhixddpIStlaTlYREoZr2XgtWFrX38mUV/VMy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798204; c=relaxed/simple;
	bh=CS1qgN/YcunIIhSx5TxfVdcSHVYJoo750gPC1vSIdBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSW8EVd/6koYr59ZnOw+poxQA2QKBj6O3JSO7yoTvZIs+bMB55Uqxo821wDG/cW+79wFKwXb3QMuHtUeOw7vNjqg7fBnkvsXyhsDzpm9Ls2zhJgM8vuD6n446/ilIM/zhZhm3bCMckx+l9GYPgi4wTav28PF1nczWjEb/2ITNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiWf9XzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiWf9XzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3948E1F000E9;
	Tue, 30 Jun 2026 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782798202;
	bh=8aJUwxqPn5J8U7iknbujNbSqUM1cPZPdUY5Rjn7wydc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NiWf9XzNLL2hvkyu2jw4gPzmT3+0Jq5WxqlP284Z0n3DJvcRU4upVjOe97DsrYDda
	 5ipE3oEbwgkEdwj9xLthoGIp/5JcUytSm11Aa0VnNqDrDsUgLVbC8nfenW+dP+v309
	 9UFgeeGZwpRqRbFRuHbtTE00hH1eQ+flBAkiBlnZHnxgShVkgshCuaG6tVeLIc/IWe
	 BSAFJXDgjsg6eWaeUtwtUF7wt/7Ai+cJtWZcklqiIN3tXezwi2v6TrOfWiIjllfIi0
	 OAoHwQbKnjLrH+qm8C10jZRlssLFdlvxClGNZmITn3OYMkpnk8V03n9cWYY0F2PjxZ
	 rP6m7nabWdcQQ==
Message-ID: <62302ee1-dafd-485e-88a0-feb695d209ad@kernel.org>
Date: Tue, 30 Jun 2026 07:43:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] powerpc: remove ehea driver references
To: David Christensen <drc@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260629211343.3712775-1-drc@linux.ibm.com>
 <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260629211343.3712775-3-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/06/2026 à 23:13, David Christensen a écrit :
> [Vous ne recevez pas souvent de courriers de drc@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Follow-on cleanup after the removal of the IBM eHEA driver in commit
> f721e8ffa92a ("ehea: remove the ehea driver").
> 
> Remove the CONFIG_IBM_EHEA entry from ppc64_defconfig and the
> EXPORT_SYMBOL_GPL(walk_system_ram_range) export from arch/powerpc/mm/mem.c
> that was only needed by the ehea driver.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 -
>   arch/powerpc/mm/mem.c                | 6 ------
>   2 files changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index f795b74602ec..1eb8e3457e8b 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -210,7 +210,6 @@ CONFIG_BNX2X=m
>   CONFIG_CHELSIO_T1=m
>   CONFIG_BE2NET=m
>   CONFIG_IBMVETH=m
> -CONFIG_EHEA=m
>   CONFIG_IBMVNIC=m
>   CONFIG_E100=y
>   CONFIG_E1000=y
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 4c1afab91996..b617b69452cd 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -371,12 +371,6 @@ int devmem_is_allowed(unsigned long pfn)
>   }
>   #endif /* CONFIG_STRICT_DEVMEM */
> 
> -/*
> - * This is defined in kernel/resource.c but only powerpc needs to export it, for
> - * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
> - */
> -EXPORT_SYMBOL_GPL(walk_system_ram_range);
> -
>   #ifdef CONFIG_EXECMEM
>   static struct execmem_info execmem_info __ro_after_init;
> 
> --
> 2.47.3
> 

