Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540274;
	b=YGdkCVlwokvNV6QmXdinqh/6d5ZJ20ldqnucJcHVeqbeR0dOyfSUQARl+gBQc1SdLzIB
	 V4RHciI6XhvyqzEdSdCyYdIul0aCFz79Uij1q89NECBA65MEyHYAUlgenkWQDC98AFXZz
	 6e3oa3JgFfsF+fupLdivhH613ZoGrJiKua8byoPdoxHNUcwo9jRIIbS/f5Akx141shSIh
	 y2kJGZjhCbdqETmhG6i7lwmZ+0zTtRJvJ1Pw3lwXk08okLh4Z76DhTEahNIqfAvnxatph
	 XNjUEGwqYMSNs/LnpJYXjpxzKcfSc/9bfd11mm9LxUlR6hcyXjGhinBZ/aSQsDA/XzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
	b=zovG/1Rf83IdeJh3n6Ipz9xhXz21fyndsdeatbqFS+WlpCLj0DXD8s3Gn/NzBjylQn85
	 aB7YlQ5oiGxyoPigOugqjE7Weaua03XzBeno30CGQXotbQpVFnoyygtvh4RufCNPtMFGq
	 Cjn/3XRCW0wsUg1qFLUYucpwZG/Uef2nBnCzv0Q/zJ6JRiJKqFPfp4lgA2ub/OtVWg3th
	 BwltG6gCFTU2rPlQoH6BoahHJjgM9Nh3GHlco2T9X94AEiPjnTenRO0BfBmknfcV2vQkY
	 aw/xuyNWH/836ulvWpRYucvyWN7lHjmVCunONQcaOC42Pmwf0cK4mz7lJyeSYkIWwRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebytfI+T;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D8606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A79D8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ebytfI+T
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso185374eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540273; x=1793145073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
        b=ebytfI+TX7POzxtndJOrL89prTf0QmGSvG89QrvM90w7uvH7cJObqLg3xhAQHEN8Lb
         dva+vyjKAvXs3R6fxm1mvadLqfL0vyzyBB6XNrjz4Xu9j5ElInUEdm1BcruiZB1vnFp0
         /4T7iPe0+jVamDOJayyRucpmYfSMuPNCl5PFNrYXrxmJn/MDqfNUHJoFssAppOzMlEBH
         PC2CoSizMExbZdTDQwEY6CQTgAaossujMaEAg5iBs6e0QKNvanjeaKHEuZGKQTS75Z7i
         p6hHDu8rfdHXCsnmiCO648sE60I8T4WboBlbU7eOzAfbHuqKcWNES6gldQWMGW8sqmuZ
         8dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540273; x=1793145073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PehXZcrvadP5J4z5HJ+PHlJPo930ZmM8+dDrOQ32K8w=;
        b=n1pq7p2dRAxMkPg8H+d4H72vWoGacv60In3tITK9UiH8nNzXrZ1b3CmveIaslNGKl/
         Kw0JPYlzU+BSMK6PnqHwM6hnB3MnrbS6kdoz45RNG9hHx1Eka8hj5jRj3ym60cAAsqU2
         Xfy3yR6y2fBTNbzAb+tDAXA+dYA5uFAHq8BqfIg2tdjuvtT3LNGYBuiluna/zh6+brpw
         K+Vkv4yOsRECa2X8fLQ7/wtXwHQp9oy9SszSc3XFAUIsBU1CevfMANZnwLeTumu+gOQS
         nohES1CCrlEyKfyZDIy16D1TKip2KHrz3AsOzTYjCJjjXeeatWLM1MdupS2rvhoHJHbA
         /tOA==
X-Gm-Message-State: AFq9FYLZ6wYAfxadegqSx3fNXM4tRAxQr+C5NBWncJa+McRsCkQx8Pe0
	j1X/Fwqt5Oa9TWntlKEDdBauoSpbBg4WAjtA+Du7KLHyiIjz4x4R4P2I
X-Gm-Gg: AYBFou2ytBnSEWpnsFdekqudOconGV9IeDI+kQYZnkP5qaZnfagh2Mzc4Hj9Xy63hsw
	9RAYAUIUf2eVvRRcZrFhvR0Q3ERRYJVKjqZ5h7khSZgp+N4to1jvUBzSSpiqoDnaLjdLBzGTwuD
	vDzVa5Vx14zLJSV9zB5fx9o2acEb9p+axWDxFPO4nKYFJjKBK/U5loxf+MwMLAWRsMLsDt3pRWk
	ywhGUS4nyfe+11+ZUsmYc9njWZVYBhJi3uSNKPacxGYlCweN15w2r95CLEctRoRke/+YNSi/178
	WLtZC5OwfwC/MpQWxGCN8SlwL1Sa9WN+egSdJN/35xgiC4prRhadqe+W5sIn0tEVfAQDhXdtpXg
	pPxpYz/0t5uueajoL7RZ9hvr6xz9cwcr2bfFlpVEqK+VUdPwVZ4K9S+9lD+CXQ02DmFu4wQSdWY
	ocF3eKdnIJu++1KZUPfEjU9vBXe4KTdMbNnAbAEfP/3lEeU1Ut4sxztMTfAF4M0Aqouj92iv2q+
	+ad2Uc9GVMDTqDweqAubGYltchb24w4A5wfJAwrfk6/JE/Log==
X-Received: by 2002:a05:7022:b90c:b0:14d:baf5:c40f with SMTP id a92af1059eb24-190a465c250mr427669c88.14.1792540272758;
        Tue, 20 Oct 2026 16:51:12 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm149758c88.18.2026.10.20.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:51:12 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:51:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vijay Nag <nagvijay@microsoft.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, willemb@google.com, tariqt@nvidia.com
Subject: Re: mlx5: stale skb encapsulation metadata after native XDP
 decapsulation
Message-ID: <atf9BogSMMrUenOQ@devvm16445.scu0.facebook.com>
References: <SETP153MB2368281B3138379C3F88AF71C4672@SETP153MB2368.APCP153.PROD.OUTLOOK.COM>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SETP153MB2368281B3138379C3F88AF71C4672@SETP153MB2368.APCP153.PROD.OUTLOOK.COM>

On 10/20, Vijay Nag wrote:
> Hi all, 
> 
> In a setup where native XDP performs tunnel decapsulation before TC ingress, I'm seeing an unexpected interaction with RX checksum offload.
> 
> XDP removes an outer IPv6 header using bpf_xdp_adjust_head() and returns XDP_PASS. TC ingress subsequently calls bpf_skb_change_tail() on the decapsulated packet.
> 
> On mlx5 with RX checksum offload enabled, bpf_skb_change_tail() returns -524 (-ENOTSUPP). Tracing shows skb->encapsulation == 1 at TC ingress, even though the outer header has already been removed. Disabling RX checksum offload makes the same processing path succeed.
> 
> The following Linux v6.6 code paths appear relevant.
> 
> In net/core/filter.c, __bpf_skb_change_tail():
> 
> if (skb->encapsulation)
>     return -ENOTSUPP;
> 
> In drivers/net/ethernet/mellanox/mlx5/core/en_rx.c, mlx5e_handle_csum():
> 
> if (likely((cqe->hds_ip_ext & CQE_L3_OK) && (cqe->hds_ip_ext & CQE_L4_OK))) {
>     skb->ip_summed = CHECKSUM_UNNECESSARY;
>     if (cqe_is_tunneled(cqe)) {
>         skb->csum_level = 1;
>         skb->encapsulation = 1;
>         stats->csum_unnecessary_inner++;
>         return;
>     }
> }
> 
> My current understanding is that the CQE tunnel classification causes the subsequently constructed skb to retain encapsulation metadata corresponding to the original packet, even though XDP has already removed the outer header.
> 
> Is this expected behavior when native XDP decapsulates a packet before skb construction?
> 
> More generally, what is the intended handling of checksum/encapsulation metadata in this case? Is there an existing fix or recommended way to handle this interaction?
> 
> This was observed on a v6.6-based kernel with an mlx5 VF.
> 
> Source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/filter.c?h=v6.6
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c?h=v6.6

I don't think we have a good answer for this, there has been some recent
discussion here: https://lore.kernel.org/netdev/amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com/

In general, from my POW, we should not carry most of the rx metadata into
an skb when there is an xdp program (until we expose some helpers to the
xdp to change it). For mlx, we might want to skip that cqe_is_tunneled
branch in case of xdp, you can try to send a patch and see what happens :-)

For more recent kernels, and for tc, there is bpf_skb_adjust_room helper
with gives you more control over these fields (in case you can move your
decap fully to tc).

CC'd Willem who might know more about csum+encap specifics and Tariq for
mlx5.
