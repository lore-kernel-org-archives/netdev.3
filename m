Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B93367B6D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896763; cv=none; b=fl0qWaCy8lTNc+nGtU1xjSPnOVYdSFm7H8Nb8ahqRDFKBoeiRNHKCscJicHS6OVKdP9dP86i9ptQLSmQeY441Y2LNityIhmrFNGo2X8qAT7RM+oOMVmRVfM49FbAhT6AZZtE5KXrXHpZrXZ/NtxnXy5j32v5Lll41GeZ6+njfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896763; c=relaxed/simple;
	bh=KsD1LVlw+1Kr1B587KDn1/9Ew+g5GADS5l3OjuXK7ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5ELF7ZDzjMIWnIk/IDtIIIu2WUDbzRJOkFBSeQmfV0qheDeDzWlaHUJRwZg5l2dbalncx2+2+CEOADpuiqTq0ncPpfebDgKZG8hRU3dTq49d/vCG5rk67tDsGKdoYFHmqtmCLx5F9YT14qgzyyI5CK0rKIJY8tMEi+qsGTjfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I87Id51I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l9g9JaQ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I87Id51I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l9g9JaQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791896760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
	b=I87Id51IG20miEiQV/cPLb+NOILYA8fBf2e/YmG/YxDvdYdJBKYRG2uUtkhk4tTPDvjxAp
	UkYe0euhRaA9NY12QVXkjslkJOnVYh1rI4eGfJgSWC7PXlMBaEDfz4Qb9umMHIaynN44C7
	5vGtH7Mac1gJlJycKGIoR1G3APvPEnc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-G05glFw0OnCU9KWml1e-Dg-1; Tue, 13 Oct 2026 13:05:59 +0000
X-MC-Unique: G05glFw0OnCU9KWml1e-Dg-1
X-Mimecast-MFC-AGG-ID: G05glFw0OnCU9KWml1e-Dg_1791896758
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c31952e5afaso270547966b.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791896758; x=1792501558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
        b=l9g9JaQ47U0uEmVFXkEKL/L0TntgxbTI5tSc6XzhkkMpp1fSZMA9U9ivkbnZaYqe0Y
         76Xw0Hjx7iOyQS/7j275NDLOiV3Y5mkAGtz1g9rWwuy/qgl41wK0x3po2U5VJXiPMvYo
         LKstyTe5IryafxFTu+xfrGx5lwb+357IQUi5jUYjlLM8Sw5zHLlcbNOG82V7NRAtHSJ0
         SYnl4L+ShLPDi+NMHc0JkCJCc09G5bXZNMSffMZNj4k3pUI5a0qENb2xz81uUL+ZYE6s
         J51sZk/cV4ea1rhfrGGzR7AS9bOaDvT1MZMAX/rNbNSpkeOIDf0iz2NkljlRK34wIkDc
         Uv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896758; x=1792501558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdqiLExlH2Tq6MbaQcUrlE9HuVHbfGn9a51KFwL/x4o=;
        b=dLodZ0VXTgn4csvGjoGsmx7Dn8fCz0XBB/SkwY830/D9sAQNiCBeQq6ctVU3wGNahi
         NKJd0+HDP5RvM440MMwzQnMBK4nHZhkPvEAN5BoiT5U3sL1ScGdFShSTmlgEzKNqX/Cl
         GGCFuzbwejYQLkREatKwFsIpu5K3m3/V2H1eYYsh7y8kqnKfMo0mmMIPYDsYfxqFWjiM
         RNJr6YJso3fjlPYY16J689EK5JqAOFQnVjdtvdQ2z2XZxmnScvsIOAWnPRHXNDW4XaPE
         57i8sDR+kNGINo4dzPwgKR+TiGGb0pEFRvSzGXz5UZ7+kvT7hcX17s1/iKJlBDDFA/Iw
         aIVA==
X-Forwarded-Encrypted: i=1; AKwUvBwdibsLTbyOqVh+4CqjVuZgdvKhb0xZI4AvKvao2ldBgoBr/P/xKiMoGtpmNMmq5ob7rQXFubE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9EAqTVCjZSkSktrBQNF2mIxcxGaU/VOrqo0Jlp1kU+PbGYZnQ
	QEcVZQJNWDX2PgCsQ3LJgju/ICUUdNO/fgeWds0E9enR8wpLCvuvREiIoesqbOcoR6wCf4UIAyl
	usSqMe7x7S3U+bMpxwmFPsT6TcKpkvh+o463U1q4dpAOLjHFZbE7n1sPGPw==
X-Gm-Gg: AYBFou0whfwTalF+UbHptqbHRISkVIEJwYyTwUQs43Og/iZVoLLTwuejw1JNuoSWQi9
	Toq5pHNbzYLEfDoIoU7SX2/voCNBMHG53bGpDx3Qi0urT/Dpg/lV6MGiBgzQMt5P0rIkN96NOlw
	CKAbXTB4YBb2EfRKekbB68Z85RjtwdfyStdk12/UW+ZT2MO1u5KfyX2RlXIUP6Bp4wgNIWpT+YL
	aPaCDHH4XkHpRmGofIP7CXStmIezm5e81nznTJ1g2WMfjRkMeZNGSCy7aIqWYqBS20WiVtc2guV
	Afieppz9m7JG6+wdLrughuhhdGaHjvv3Rqu28u5TGtT/7nZcgFszSiQcpLHbqIIO9dniBx5ECOW
	ogu30256xc97jpDundUC5y9RQ9oEr+rwqBXR3YOpFzAnUg01OLoTLV/15LzeQzDfUhaxHe5Ohzg
	==
X-Received: by 2002:a17:907:7f94:b0:c2e:34b7:8899 with SMTP id a640c23a62f3a-c31aa0790f5mr1285600466b.30.1791896756674;
        Tue, 13 Oct 2026 06:05:56 -0700 (PDT)
X-Received: by 2002:a17:907:7f94:b0:c2e:34b7:8899 with SMTP id a640c23a62f3a-c31aa0790f5mr1285592866b.30.1791896756079;
        Tue, 13 Oct 2026 06:05:56 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c353033b3a4sm218681366b.57.2026.10.13.06.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:05:55 -0700 (PDT)
Message-ID: <eb32ba07-0a4c-4bc6-acda-36e6b95af89b@redhat.com>
Date: Tue, 13 Oct 2026 15:05:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/iucv: take a private, writable frame before
 rewriting it in place
To: hexlabsecurity@proton.me, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>
Cc: linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Hidayath Khan <hidayath@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 11:21, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
> fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
> header -- and can hand the same skb to dev_queue_xmit(), without making
> it private first, so a packet socket that also gets the frame reads the
> rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
> cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
> list, walked after ptype_base[], so deliver_skb() takes a reference and
> af_iucv runs on an skb that is shared but not cloned.
> 
> Unshare, then cow the head, in that order: skb_cow_head() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). Asking for ETH_HLEN
> also covers the unchecked push in afiucv_swap_src_dest(); on the ordinary
> path eth_type_trans() has already pulled that much, so it only compares.
> 
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
> Sorry for the long silence since August: a major earthquake hit where I
> live, and I was finishing a postgrad program. Back now.
> 
> v2: the old 2/2 alone. 1/2 is dropped; Alexandra's 80230a18c164
>      ("net/iucv: filter frames in afiucv_hs_rcv() by ingress device")
>      replaced it and is in mainline. Rebased on net, no code change,
>      carries Alexandra's R-b. Kept on net; Alexandra agreed on v1 to
>      treat it as a fix. The commit message now covers both cases: v1
>      described the ETH_P_ALL tap, where af_iucv gets a cloned skb, and
>      the v1 thread added the ETH_P_AF_IUCV socket, where it gets a shared
>      one. My reply there said v1 had the delivery order backwards. It
>      didn't; both cases are real, and the A/B below shows each call is
>      needed.
> 
> v1: https://lore.kernel.org/all/20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me/
> 
> Tested on s390x under QEMU TCG, KASAN and lockdep on. No z/VM there, so
> af_iucv gets its frames from lo (80230a18c164 filters after the
> EBCASC(), so lo frames still hit the rewrite), and a packet socket
> reads each one back. Unpatched, the tap and the ETH_P_AF_IUCV socket
> both get the 48 name bytes already in ASCII, and a SYN with no listener
> never reaches that socket as a 0xfbfb frame. Patched, every frame
> arrives as sent. Drop skb_share_check() and the ETH_P_AF_IUCV socket is
> broken again; drop skb_cow_head() and both are. FWIW no splat in any
> boot, patched or not -- on lo the damage is in what the other receivers
> read. Builds clean for s390 with W=1. Repro and logs on request.
> ---
>   net/iucv/af_iucv.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af..493dc156e9f5 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2072,11 +2072,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>   	int err = NET_RX_SUCCESS;
>   	char nullstring[8];
>   
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return NET_RX_SUCCESS;
> +
>   	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
>   		kfree_skb(skb);
>   		return NET_RX_SUCCESS;
>   	}
>   
> +	if (skb_cow_head(skb, ETH_HLEN)) {

Sashiko (nipa) noted the above is the wrong helper:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me

you should use skb_ensure_writable() or skb_cow()

/P

