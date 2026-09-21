Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDC485936;
	Mon, 21 Sep 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989473; cv=none; b=SovZwkoDw5Myskh0rjGH6cVaYszBtDMmWOp69V1dpYIsXsL+00I3r43DH73ePFh02yoA5Wff9joXtsYRFT3A1t+L4q+0ikc2N7j8eiu+ZIRPMGT1hp1wcYSKQO3Yd2KMqZWbjXpxDjZImE4ehyaz5JN7s3OeiPlDrSFOU+i9Fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989473; c=relaxed/simple;
	bh=EZ21ncQrjQNm7o8Cw+zlBh2DjaJdXZNMq93zx34x0jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAMTrFj6pfz/44PUwwJGH9ZSR3YWM9fOIOQGYOAA4P/4XvonEDFn7Ty7qcWI+/Hvsln4UEkiM6LnR0Npfh2Ag4EBafNBfI8JFLNeE6Q17fBbwDVDAfUmcjDMrRxqA+vDifqTqy4LfPnqPdSswQj+KHbmarBxSQyImJZt1n/h0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [123.116.51.226])
	by APP-03 (Coremail) with SMTP id rQCowACnrTtGErFq+tZHCA--.11992S2;
	Mon, 21 Sep 2026 19:17:27 +0800 (CST)
Message-ID: <7d96c999-20db-427e-be57-3a79b0ec5119@iscas.ac.cn>
Date: Mon, 21 Sep 2026 19:17:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: spacemit: clear TX descriptor on fragment mapping
 failure
To: Muhammad Bilal <meatuni001@gmail.com>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dlan@kernel.org, vadim.fedorenko@linux.dev,
 maxime.chevallier@bootlin.com, troy.mitchell@linux.spacemit.com,
 netdev@vger.kernel.org, linux-riscv@infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260919191937.271202-1-meatuni001@gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260919191937.271202-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowACnrTtGErFq+tZHCA--.11992S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry7ur18Gw4fWrW7urWfKrg_yoW8AFWfpF
	ZYvFsIkr1DJr43Kw4xCF1xGry0vayxC34UZ3yYvrZY9Fs8AF4SkFW2y3W5JryUAr1kAw1F
	yr4DZa48GFyDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 9/20/26 03:19, Muhammad Bilal wrote:

> emac_tx_mem_map() writes TX_DESC_0_OWN into the ring descriptor for
> every slot beyond old_head as soon as that slot's memset()'d local
> copy is committed with "*tx_desc_addr = tx_desc", i.e. before the
> buffers for that slot have necessarily all been mapped successfully.
> If emac_tx_map_frag() then fails on a later fragment, the err_free_skb
> path calls emac_free_tx_buf() to unmap and drop the skb, but leaves
> the already-written descriptor memory untouched, and tx_ring->head is
> never advanced past old_head (the "tx_ring->head = head" store is
> skipped by the goto).
>
> So a slot between old_head and the rolled-back head can be left with
> TX_DESC_0_OWN set and buffer_addr_{1,2} pointing at DMA mappings that
> emac_free_tx_buf() just tore down, while software considers that slot
> free again. The next successful emac_tx_mem_map() call only rebuilds
> old_head itself; if the DMA engine auto-advances into the following
> descriptor once it finishes old_head's packet, it will fetch that
> stale, already-unmapped address.
>
> emac_tx_clean_desc() already treats emac_free_tx_buf() and clearing
> the descriptor as a pair when reclaiming completed descriptors; do
> the same in the mapping failure path.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>

Much appreciated. I indeed did not consider this.

Also, a minor nit, but it should probably be:

Fixes: 86292155bea5 ("net: spacemit: Fix error handling in emac_tx_mem_map()")

Thanks,
Vivian "dramforeve" Wang

