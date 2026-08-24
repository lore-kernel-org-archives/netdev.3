Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727282F7EFC
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583247; cv=none; b=jYi1MZmuI9DFDZbKT7oFQmnVdlyBVyjo/I6DWtdvbl/FerWbFtCLFVzSW9d6+yi88Bccb4md9xpokmBKbLD0MtBzJ4ZvPdoJ0irjzgWVNkasB8tGsEmfUMXYONgukJUofty1F7B3pTxmyYEaBoMrHaqFRUduivGFnIUPGXyk4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583247; c=relaxed/simple;
	bh=RhVvX50TBwKIdoOlNqpyG0qsAeJU35/oo9c4csvgOTo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TAegWTK+/7kPca9qhxaYK5ymRbm7IN1dTqW6Inz06PD6j3KJr433yjyM0xJmGewKlSIG46+QYREFD+TFruF+6lmfpEeQhNgwwZmlFa/xzqpmsH4u827Ez2da8HEmQEwV1fxp5w7xascrnBuLxSUg0pRmxDrVZz23RynDT7CvfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=zknsVNxe; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=eN2Swt79; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="zknsVNxe";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="eN2Swt79"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 67OErLdB006755;
	Mon, 24 Aug 2026 16:53:27 +0200
Received: from lubuntu-18.04 (host-80-183-189-234.pool80183.interbusiness.it [80.183.189.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4913E1228B8;
	Mon, 24 Aug 2026 16:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1787583197; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIfrEskiDIaHuhRBNujIic0jExU8h0Ya4ee9Oyurv94=;
	b=zknsVNxekRKNQZ+BWf6oudLSVzHaGyVLjP9B8Q48ZcQb9pXC/thJWIW1oe42+FqbQmmLhU
	Q7q356GSUJvvjXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1787583197; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIfrEskiDIaHuhRBNujIic0jExU8h0Ya4ee9Oyurv94=;
	b=eN2Swt79iE+FgZo1ZTeRvN+EDhiuKw/TIBvmOaY2lb5yTllK2TNm+b5xtfHz/6Z1Vz9G8S
	nugh0D2l5XC/H6/eTe0JFUeXsiG+jLmXvWrNgiJ/D0vKD91Jl0xfDFhgd9xG67ltUoC2xD
	bdRUadSYp8uRMgN3egBSwrQvHmJVfDX9G34sEFpAL6E7+AAOFBhIT8x+t6e3mGaH9H+OnN
	cnpWupgEWjy60tH5BfTYMGzM8t45ISJLoQ253xwuyPYtmrXaB7MFGFodG6c3TeDX35xVe2
	JSkbV10xnMNhdxGQQbuNKAr/1dxeJtBtQGysriNfiTTuXIT9m38O50EZR5zNjQ==
Date: Mon, 24 Aug 2026 16:53:14 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, david.lebrun@uclouvain.be, vega@nebusec.ai,
        zhilinz@nebusec.ai, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 1/1] seg6: reset IP6CB after IPv6 decapsulation
Message-Id: <20260824165314.67079bfe835db90806b1acf6@uniroma2.it>
In-Reply-To: <83541e78b0eb0d5adc169a318a51e3055f6bf820.1787388261.git.zhilinz@nebusec.ai>
References: <cover.1787388261.git.zhilinz@nebusec.ai>
	<83541e78b0eb0d5adc169a318a51e3055f6bf820.1787388261.git.zhilinz@nebusec.ai>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Sat, 22 Aug 2026 16:49:27 +0800
Zhiling.Zou.zhilinz@nebusec.ai wrote:

> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> decap_and_validate() pulls the outer SRv6 headers and makes the inner
> packet the skb network header. The IPv6 control block still contains
> values collected while parsing the outer packet, including nhoff and
> extension-header flags.
> 
> End.DX6 and End.DT6 route the inner IPv6 packet directly to the IPv6
> input path. An unprivileged user can reach End.DT6 from a user and net
> namespace by installing a local SID and injecting an outer packet with
> Hop-by-Hop and Destination Options headers followed by an SRH and a
> minimal inner IPv6 packet.
> 
> The outer extension headers leave a large nhoff in IP6CB. After
> decapsulation, ip6_protocol_deliver_rcu() uses that stale offset on the
> inner packet and reads beyond the skb head. KASAN reports:
> 
>   BUG: KASAN: slab-out-of-bounds in ip6_protocol_deliver_rcu
>   ip6_protocol_deliver_rcu+0x1118/0x1450
>   ip6_input_finish+0x11b/0x240
>   seg6_local_input_core+0xed/0x2e0
>   lwtunnel_input+0x1e9/0x4e0
>   ipv6_rthdr_rcv+0x525f/0x6c50
>   ip6_protocol_deliver_rcu+0xcb7/0x1450
> 
> Before clearing IP6CB for an inner IPv6 packet, save its incoming
> interface index and L3 slave state. Restore both after the clear and set
> nhoff to the inner IPv6 base-header nexthdr field.
> 
> Use IP6CB(skb)->iif rather than skb->skb_iif because VRF processing can
> replace skb_iif with the L3 master while IP6CB keeps the receiving
> interface. Preserve IP6SKB_L3SLAVE for the same reason.
> 
> Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v2:
> - Preserve the ingress index from IP6CB instead of using skb->skb_iif.
> - Preserve IP6SKB_L3SLAVE across the IPv6 control-block reset.
> - Place the IPv6 reset next to the merged IPv4 reset.
> - Add reachability and the relevant KASAN call chain to the commit log.
> - v1 Link: https://lore.kernel.org/all/6a236dcc43d141a9105e8ee1b84bcccc628d83b0.1786894895.git.zhilinz@nebusec.ai/  
> 

In the mail I received, the From header is Zhiling.Zou.zhilinz@nebusec.ai,
which is not the address you sign with.
From what I see, patchwork records it without the angle brackets too.

The patch looks good to me.

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
