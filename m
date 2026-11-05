Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891273;
	b=oZgWDar4TNF7EoCOEyyPc9WPu++J3ZyYaMx+5c/pYpmSrQRKwhNOPP7XBYsqZeVv5ui3
	 MOUJFhs6MoZMis5vVbWWWkoGM0fJ/gu7CSNxfERo782erM0nyj7Vfw1YiaxlveMQQ61Iz
	 9Oj/nIXmQhScBfNXSXO9bXZzuJsIBW+0+HhpRS9byiEbAwssZDZx8mhjtivO6M7kDtsNe
	 7qhAI86hwlxw9X/Ydhqk83JSG3bBbrHUwZ8RpteO+BHn8IqStgNrtdi2iadJiQKdKGhly
	 kfN8j8qOVL5ulU2N8xmTkXuS7N7XkPxSZ7lfyBO6tnGn4l3Kk1AOWMxG20UDf3/A8Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k4lAZXF634haTmHf/i5p2AigpE4w64cfJ6rIv2nQMJM=;
	b=JxqyQmPRiwQV1/lOZLkqlwrdQMU3YbEakMmtlZ7DayiK6XSG9FsjTJbBMbAwJjp3ix2I
	 +IpVfHxLKf7iQV5opG2Vj7KZgT7Dun6XvGS7ii/VfA3gCNN0b28YmInlWFSnt4IP8Slft
	 0wwwgi5HT6RBkZSD8PXsoTdPeW94op7wdTLBseDARCgZeSadSlrQlUDPWsLkWewHyH8IL
	 iXaL+PjAtQxIKElbYEhT1SXx/cpC3IdOvfT/g9tRTyOT41iWEunLTgK8u1dGzlgZGyxEy
	 ZUoFSx28hy07j2+ruLzTwfxVpAxnkq3QH6oZvhuy4Ugy4s4oKcn9W0k2arV2+1nnjtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y5B/nidW";
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D773606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 15:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D773606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y5B/nidW
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so506238241.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891272; x=1794496072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k4lAZXF634haTmHf/i5p2AigpE4w64cfJ6rIv2nQMJM=;
        b=y5B/nidWRQu7hph/E9TROo0pFFeFkHfz7RY+zmqPwDz01Il/jgguKcdV7/Cfhq+owB
         azchre2G44+ETvbIvnHkQGDFhaP8ae52m/NPVEBjJvL9kOwpHJDB1hT2zMSTUavvGZMy
         uTS2KnGAlwuS1AzEoBTtzurCiBFu95q/J62gIZfze5nVy2XFOF1g3A/W68oBfVydqPd+
         2woOgkvlcAFcrRPhzIaKhSRrYCiU/Z3lbUWPEylhr+mb3WWYEOwgqGjKdg46LFTOctPD
         SJmLdYNSkiG76FFpnb/sqa1H74QN7+D5cP20sTKL+TMHPBu8EzUlay1DEFEghYKpdWn1
         acKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891272; x=1794496072;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4lAZXF634haTmHf/i5p2AigpE4w64cfJ6rIv2nQMJM=;
        b=MfFhl3Ra0mKcIQ4jajlvZbEyBR7bZNeayDr+5a/MH78KFQXWy3yD/ekpv35RcpZ9px
         gi4/IHVvWENuLWHzYf9ffspWp9BcI30g+02BxKum7tkMo6oaPRHKU9qr0GjtJfDyxsaa
         9DI0qVqfnI9fT8V89mw0hfGY2SfrJcLJCNF3sP3nYPNTm6Z1w6MKhs0trINBRebRXLlh
         TVE/aX5WmqEDdOf9r/TofBLGahzF8PjIjyP2yqWhCQ1kN/e0k2psBfJXDwAhh0/6qU3o
         ihQONo8EaocCZ05W6zU/Rg9GcYb6a9ooDdPrrdKF2HtGmXApg8hUwWQj6Rg9SopASBiN
         ciGw==
X-Gm-Message-State: APuU4Z+Ur1EISKrihjLY2YmDm261MHEhKKcYWdE6h/dXzwT3fip/x8+m
	RyAFrUS7AwTdAq8pJoBDjSc8bYijRdHfHe3X0K9+SlxfD6kXdIdkIdAf
X-Gm-Gg: AYBFou1BsqP/BqrdoiNu+Y+XxOYrwhsvfQuLoju/Myo2brDDimciTD8/rrh7+1tjlSF
	iRtbmJ8pvEuftw7UjMZNXDY+Ufr+SxdPe565lKyzMKRosee27/e0HW0eGDVB5bkY6DriKrne5Iw
	LWiV/9YObLBltMP9tHA9B+M3Dg50rivP6oSPC6s1tGS1cKPFBQpoekyjxpl2vmZvM32+SO7PSoM
	emjvsnA4rqr9aHnmzCaBZ6nTxh5oFZLtGlBYo6aX1kexQC9PjL4o4HIgtvnKKmKbdn2m9B+wsf4
	+DsfX9TFwYFlwcXRi7NnDZeGP/gKdXo/7zNPtB0LeUPJsf1h0Q08WUCXZaXGcribUpSS/uaS7tV
	Gic4V6KQCQkqBOPxAXtD9Xc1Z/wgex6WYVXvpHfs/aV+67bHWuR5fR8MZj/qKf61ZCOdAJ4PM18
	PJuKyAKtEo19OErCib2e+q0LYXNdkwImSzOZ5wpJXPXprKXI6EMVx0OLCP9Ov217Z3cYmJCcwyW
	/N4S2HuJmOYi6B+VE3pmzzm5k/ycUwDN9QADufR8sC4ecn3q3Ex3NY8sosZ+irq/cXiBuTp4YS9
	7k5IoWtxxPc1JKduHEc1iLKj0ig+QBLzjobWxtP9PKKyqqAsgVG/IY6+0wgU9kBb6SchLDhmQGk
	nhwnn8soPx+UnHxX0VP6WqRYOqFuRFPh5sQ81KhD3Z4crzzbwXOWZ0huEZAjFYNVQp9gtaMHURz
	cb+kFwRhYy0mNbUdfq
X-Received: by 2002:a05:6122:1d46:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5ec68295940mr9754553e0c.0.1793891272015;
        Thu, 05 Nov 2026 07:07:52 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d37aad94sm4816212241.0.2026.11.05.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:07:51 -0800 (PST)
Date: Thu, 05 Nov 2026 10:07:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Chris Mason <mason@kernel.org>
Message-ID: <willemdebruijn.kernel.641932d269d@gmail.com>
In-Reply-To: <20261105124043.1543405-1-edumazet@kernel.org>
References: <20261105124043.1543405-1-edumazet@kernel.org>
Subject: Re: [PATCH net] tcp: rate limit receive queue collapsing
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> When a socket is over its receive buffer limit and its sk_rcvbuf can
> not grow, every incoming segment that needs memory goes through
> tcp_prune_queue(), which runs tcp_collapse_ofo_queue() and tcp_collapse()
> on the receive queue. Both walk their whole queue, even when there is
> nothing left to collapse.
> 
> A peer can trigger this walk per packet, without refilling memory:
> 
> 1) The segment lands last in the out-of-order queue. Since commit
>    b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic"),
>    tcp_prune_ofo_queue() drops nothing, the segment is dropped and
>    the queues are unchanged. The peer can send it again forever.
> 
> 2) The segment lands second to last: one skb is pruned, and one small
>    segment fills that space again.
> 
> 3) The out-of-order queue is empty and the receive queue alone is over
>    the limit (application not reading). Collapsing frees nothing,
>    the out-of-order segment is dropped, and the window is not closed.
> 
> 4) Collapsing frees just one skb, enough to queue the segment. The next
>    segment is over the limit again.
> 
> Only allow a collapse if at least 1/8 of sk_rcvbuf of new memory was
> queued in the receive queues since the previous collapse. This restores
> the "12.5 % of the queue capacity" amortization of the 2018 SegmentSmack
> fixes (CVE-2018-5390), using the same unit as the sk_rcvbuf limit, so
> that peers sending small (bloated) segments are not penalized.
> 
> The credit is the net growth of sk_rmem_alloc in tcp_queue_rcv() and
> tcp_data_queue_ofo(), so that:
> 
> - Coalescing a segment into the tailroom of the previous skb charges no
>   memory, and earns no credit.
> - An out-of-order segment replacing or covering queued skbs only earns
>   the memory it adds.
> - Duplicates earn nothing.
> - Data moved from the out-of-order queue to the receive queue
>   (tcp_ofo_queue()) is not credited twice.
> 
> In-order data is credited too, so that a receive queue filled by
> bloated in-order segments can still be collapsed when a hole appears.
> 
> In-order segments are rate limited as well: a peer could otherwise send
> small in-order segments that each trigger a collapse freeing a single
> skb, enough to queue the segment, while the out-of-order queue holds
> many skbs that can not be collapsed.
> 
> The credit is tracked in a new u32 tp->rcv_collapse_credit, placed in a
> hole of the tcp_sock_write_rx group: no other field moves, and tcp_sock
> size is unchanged. tcp_queue_rcv() now samples sk_rmem_alloc, and
> writes the credit until it saturates at sk_rcvbuf, so that the fast path
> stops writing it after a full buffer of new memory. Saturating at the
> goal would not work: sk_rcvbuf, and the goal with it, can grow later
> (for instance in tcp_clamp_window(), just before the goal is checked),
> and a socket over its limit can not earn more credit until the
> application reads.
> 
> When collapsing is not allowed, tcp_prune_queue() goes directly to
> tcp_prune_ofo_queue(), which is cheap in the cases above.
> 
> A regular flow can see a difference when it goes over its limit before
> 1/8 of sk_rcvbuf of new memory was queued since the previous collapse:
> out-of-order skbs can be pruned (even for an in-order segment filling a
> hole), and an in-order segment that still does not fit is dropped,
> with a zero window advertised, where a collapse might have made room.
> 
> Fixes: b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
