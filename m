Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE04DA541;
	Wed, 16 Sep 2026 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554739; cv=none; b=hxlLapwLF2ELFPPn2RTj3VQIj6jWdBySIxnu7TsLJGpsmjXy8HU51o7Tvl4RJd5nUA2c/lAhLLunymChSCt6mb3kmEoB8pwHb2iBD8CWcHUyQD7IKdvniwJjwI0ecHkTaso/uDg1MCEcZk9a1uqs8v1UUFzjo/xiO8xyulDjkAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554739; c=relaxed/simple;
	bh=ZeBO1WaVOfsP+Em2Y5eYxyAZYle64mos8YlvT4xUPCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaUJq/FaoRgQz+QvOibcWR/yc04YJ+5yi6BFGvawh2KiXHD/1uVdxL0nCsk3hCFTXQDxjoFhYgOL7xqJhIqisnvxVUEPJzksSIlDSvvVwPdZfuNIUr0orrwrG6kri+aiZLqmhH2Y4AQ62YHEB/cfPZYOynlUB6FVn35kPIIOv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYcdNNl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYcdNNl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2161F000FF;
	Wed, 16 Sep 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554723;
	bh=MFYzKEzUmH9/6ooJLpmj7OiMffG2rD2vVwZz0sGagMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KYcdNNl1/dcSJA/bfT0DzFcEx59svERwddq1zlB+RvV20GLiiCRSOHH99g8kf6CuH
	 Ltn66ThRw50dy50QzScLY9jTQO3SjZlNtnRYcTN2AVJx05IsA4n/pOur9EMmBdRAZF
	 WiG+AnI5+lOnrTEYBOKsSUUvNxtSJjupVIHqtXk42JV5vlzxir6/i1OmlNskOzAcxi
	 +02LPrQEcRvdyYe/0mbG+6flat+LGjF0lmDAnk3RjngG+GcvzFRRDrDHTDLu1l71S0
	 JpPqKYW+hBEnH263yUAlOisT0kbsd3J66ugws8onQkfKVgTU1PbZBHiUVQPA1ts0d9
	 08PNOCmOcjfgQ==
Date: Wed, 16 Sep 2026 11:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: xps: reject an out of range traffic class
Message-ID: <20260916103152.GA51261@horms.kernel.org>
References: <CE030A45-D573-4310-8761-01431156F0D6@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE030A45-D573-4310-8761-01431156F0D6@doyensec.com>

On Sat, Sep 12, 2026 at 08:01:06AM +0200, Norbert Szetei wrote:
> Only the entries below dev->num_tc are valid in dev->tc_to_txq[], and
> dev->prio_tc_map[] may only name classes below it. netdev_set_num_tc()
> lowers dev->num_tc without touching either array.
> 
> netdev_txq_to_tc() walks all TC_MAX_QUEUE slots and
> netdev_get_prio_tc_map() returns the entry as it stands, so a leftover
> entry is handed out as a traffic class >= dev->num_tc. Taking that
> class from netdev_txq_to_tc(), __netif_set_xps_queue() rejects only a
> negative one and indexes an XPS map sized for dev->num_tc classes:
> 
> 	tci = j * num_tc + tc;
> 	RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
> 
> Any caller that lowers num_tc leaves such entries behind, and
> mqprio_destroy() tears down with netdev_set_num_tc(dev, 0) rather than
> netdev_reset_tc(). After mqprio with 8 classes then 1, tc_to_txq[1..7]
> still describe txq 1..7. The splat is from an XPS write to txq 2:
> 
>   BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1eb9/0x2440
>   Write of size 8 at addr ffff888110e978d8 by task xps_oob/573
>    __netif_set_xps_queue+0x1eb9/0x2440
>    xps_rxqs_store+0x24d/0x360
>    netdev_queue_attr_store+0x61/0x90
>   Allocated by task 573:
>    __kmalloc_noprof+0x246/0x6c0
>    __netif_set_xps_queue+0x8ca/0x2440
>   The buggy address is located 0 bytes to the right of
>    allocated 88-byte region [ffff888110e97880, ffff888110e978d8)

I think it would be useful to provide the stack trace with line numbers
decoded. This can be done using scripts/decode_stacktrace.sh

And perhaps be a bit more explicit in the description about how
an overrun of attr_map occurs; I believe that is what
the splat is telling us has happened.

> 
> Reject a class the map has no room for.
> 
> Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic classes")
> Assisted-by: LLM
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> v2:
>   - bound the class in __netif_set_xps_queue() instead of clearing
>     dev->tc_to_txq[]/dev->prio_tc_map[] in netdev_set_num_tc(), per the
>     Sashiko review of v1
>   - dropped the memory-ordering claim from the changelog
>   - retitled
> v1: https://lore.kernel.org/netdev/16E3A318-5532-4B5E-8D03-86D21B463A2D@doyensec.com/

...
