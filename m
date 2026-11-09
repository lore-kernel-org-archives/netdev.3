Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226372;
	b=dcdrfs/kyDF+3WhAkhcIO7WZwhyoyQbOBiVTQ5/kgmAC7HIS6NPhjM4X649lRnT7pNlh
	 swTt+33zSUJFzBAKcE3vSmnVAeYpswjnOjUQWIVOd+SFXO7oBJOFygI8iavMBhdH2BHIF
	 a+Hap6SKeASfuHnImZEhmb8GddAlZ8XwJ58MqqwLufB3pVIPrj+mM5X9e7BeL9pT7NDek
	 BLlU+VhG06KwXEKpdgdFL9zJuHFupPjvqfcwtvgmEdYRTAKBNBCdGOEpt3AqgdnJDSH0i
	 PQuSasqgXw3/3hZ5zeEkc34Mipkpe5G1vDzVVd8P+ToKG0GPOOjnJXOrCgFQ2+rbhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226372;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dYz5XasKnN4TugzUWfM3/cMdAY/x2jzfHlfhQ+galWM=;
	b=AZxEp+DPD+unjDrVytiuPyfyBvJMemWyLvK4BJqJn3xYttwReJxT5zXbA8nRWayUfKwm
	 MNkWkySKjhwtXv4pDh99TNxm84NXp+ErxmvCdjf6JIPRg0/kAy0LF8zwZiCT7cy44mV1M
	 y4vAb4Np1XeHzTZVvSnQHuwsNaAAHSf+RXdr6JWIqjJWU2ViZJbVp9bUtJ+vKH15b60Cn
	 RArV20zMly9o/0KdhCSBwflHEMVrYUmfo7/Hyc1QoqRkmXidzfC9PFDPA9xpGMGqzwUef
	 YqLvqrlmmtwrkzRQY+/+vI/nQqScOOtmGHNB5J7OkglfbwPMCo1gp9fKMcOkkwUuD6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZHCnSDpN;
	arc=none smtp.remote-ip=91.218.175.170
Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC2606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86DC2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZHCnSDpN
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OUZK1hzYgJtzU4nG/ylLO2w+RnFmaiBPq0yD7tkY4Ik=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794226368; v=1; x=1794831168;
 b=ZHCnSDpNkPq3NM5T6edR1zp/xB7qZJSfbdE8sV6x9s6+F6gMapAVhQb8vrotPpnBD7QpADkY
 WTDu/1vlU/NAeAbMgHSb/JWlgZKrNLoD5WgTPisGLTBOMXWXkGpqqnnIybhgzxReRESxBteMwZa
 yFsNK1ZMXAJwN7gJ12G0ML2c=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84c5a36d145168ef;
	Mon, 09 Nov 2026 12:12:47 +0000
X-Mizu-Trace-ID: 84c5a36d145168ef
X-Migadu-Flow: FLOW_OUT
Message-ID: <b2d2255f-c9f4-4c94-a739-b80f9bc49323@linux.dev>
Date: Mon, 9 Nov 2026 12:12:47 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ptp: ocp: replace __get_free_page() with
 kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261108-b4-ptp-v1-1-71160700886f@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261108-b4-ptp-v1-1-71160700886f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2026 08:40, Mike Rapoport (Microsoft) wrote:
> ptp_ocp_summary_show() allocates a temporary buffer for formatting
> PTP OCP device summary information.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> Removing needless calls to page allocator helps with memdesc (aka project
> folio) conversion and gives a nicer API without casts.
> ---
>   drivers/ptp/ptp_ocp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 625a85b2dc7e5..decc56892059b 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -18,6 +18,7 @@
>   #include <linux/spi/spi.h>
>   #include <linux/spi/xilinx_spi.h>
>   #include <linux/spi/altera.h>
> +#include <linux/slab.h>
>   #include <net/devlink.h>
>   #include <linux/i2c.h>
>   #include <linux/iopoll.h>
> @@ -5281,7 +5282,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>   	bool on, map;
>   	int i;
>   
> -	buf = (char *)__get_free_page(GFP_KERNEL);
> +	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
>   
> @@ -5497,7 +5498,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
>   			   post_ns - pre_ns);
>   	}
>   
> -	free_page((unsigned long)buf);
> +	kfree(buf);
>   	return 0;
>   }
>   DEFINE_SHOW_ATTRIBUTE(ptp_ocp_summary);
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20260624-b4-ptp-ed56a38a6afd
> 
> --
> Sincerely yours,
> Mike.
> 

Thanks,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
