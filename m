Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181542;
	b=xTUHHv2UoJjyyPUXPCkMz5ntd1cBC873MQuEvIHSGeJHIBdvLh6As5FFt+i3wgv4fN4H
	 W62NRvznJDFE0oxlCJOoHh0whr33Qwu/0FXq3AUbXSwlPcN/GXcmzqLHXC7R8Nutxb34Y
	 o49KYqxaBi1rbf3tuVPnBpK76ZUJUVSbc4wmWPYSWmvDNBggxD9co3rMMmMhT4CnYG2xF
	 SgwiirVb3NcjfNmreIhVJKbM5P8KvgJjFTI5BtGjyVhIc4MRYTH7Ey1w7d3JY4ezYuN0/
	 35xsRmXhtDzFWNL4q/ZIX8Gqu5CHGhbkSoM0cXu4iNX4gaQAI3kWN46TNZarbYHnraw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181542;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=22ULUd3CSu+xvHleEXSSulHXhaBo3lSWI9UaZrU2MF8=;
	b=t0+wQ0ZHnBi3nwBX49rEdsNf234RYDELO/fxMdjBsGbOiZC3QLkCPccLjupuY3UUP/9G
	 f4eI9GCAKOv7++IWAx63Od9WH9FPeUGqrALM4w9nzvyRGyo15dWZxp4K1sp1vlMTgmiAY
	 aEYmR/NIQNO6e31Na4iIUq2yWtzDopck1u7UgG+t10b6L3PtlzG3Q79sGWeLSVNV7lri/
	 OFnv055cm+UmxAzz2aaV45i72glGWZdG8lL+CKP3Zm8HoRwy0TCXUOOpy7IosjHmBViSN
	 oUqTWoNgJ4aSVhNYBHAvnuy/9/N/YeBYTP2F4dFj/xTtH8QSvU7iWnxMd4b8kX95CNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kk/fUAyJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F4606A31D;
	Wed, 28 Oct 2026 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kk/fUAyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBBA1F01829;
	Wed, 28 Oct 2026 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181542;
	bh=22ULUd3CSu+xvHleEXSSulHXhaBo3lSWI9UaZrU2MF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kk/fUAyJ34QCYxcwMJXl2m7CliIyzgZfjPy7G6JwhCDM8xbN1o1a+XPtFRu+v3BCg
	 oP3XeEq1McsZeWwM7uoieGqHj3segBcVrwVQEg12ctXokcefklo3t9TltUf1UqWOos
	 D+6jmzisx5iyjJ90OVIIjpUMqfaB+jdlr3/kKQkoVKfuUVMNnxSAS3q1WLZH4lsDg5
	 ZoNtWsznbk+RSXeOaGueGlN8X59qpvIhL1wDBZcGPNwtvjP64RMx9D4ccTwdwu3Ekt
	 Tr2LLmeTRDWL+KfgUrKgNEtvJpAVIBhOQsupkE0a51yfccCiBjZEaQZshuIInDc3Zb
	 D4gUapcafq0og==
Message-ID: <f62962e6-6fa9-430c-bdf9-c15993ce334f@kernel.org>
Date: Wed, 28 Oct 2026 11:58:58 +0200
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
Subject: Re: [PATCH net] net: lpc_eth: release the PHY device node reference
To: Yige Jiang <yigejiang86@gmail.com>, netdev@vger.kernel.org
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ma Ke <make24@iscas.ac.cn>
References: <rc-review-20261022-ai13-13-8a866c920a94@gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <rc-review-20261022-ai13-13-8a866c920a94@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 18:59, Yige Jiang wrote:
> lpc_eth_drv_probe() obtains a reference to phy-handle and stores it in
> pldat->phy_node for lpc_mii_probe(). Neither PHY lookup nor connecting
> the PHY consumes that node reference. The probe error paths and driver
> removal discard the stored pointer without releasing the reference.
> 
> Put the node at err_out_dma_unmap, which is reached by both failure
> paths after the phandle lookup, and on remove after unregistering the
> network device and MII bus. Both puts run before free_netdev(), since
> pldat is stored in the netdev private area. Earlier probe failures do
> not pass the new error-path put.
> 
> The PHY device reference discussed in the linked review is a different
> reference. This patch only fixes the node reference, which was also
> mentioned in that discussion; it does not repeat the proposed PHY
> device cleanup.
> 
> LLM assistance was used for static ownership analysis and drafting of
> this change and its changelog. The review traced get/put pairs, error
> paths and teardown ordering. No runtime reproducer or hardware test
> is available.
> 
> Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
> Link: https://patchwork.kernel.org/patch/14502432/
> Assisted-by: LLM
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

The change is correct, thank you for the fix!

Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>

-- 
Best wishes,
Vladimir
