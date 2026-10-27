Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141523;
	b=HsQ2tXj4iMjJng2932TLhVZfXl77IeVz5RRympjgQY5hzPGf/n/5IItWPRhMLB9nfjkP
	 k/ixN1bFwCcHgwECcaHIr3HJCUv3t5K0ktOJT02Vrgup9FV+JAzt/O1HXiwSNctrqfsSO
	 U6/lSUvu4ZKfzyH7WuCUYcYdcXZDY01mWa142CUxUhI2S5L33xqTiWUAYQ7XmOvsOC7Gk
	 yPEbrWTJ05Qhzw+NVcKQ+0npv28raavIKUzr3uDqcPQosM74nAEaxJhH7x6wPyL2rLWmF
	 Q0HQUXCp0I/gzXsOcaEke09Eg1ANQx2pAmf/cHJGcWhCne01CpmhjmrUk9OjKY3zYAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
	b=0gUVsmgf/XsutRqutlpM91CL8uybrutc+3Kk0P7JxqLuGx6N5LwLO4eH1Rk+fdzVtXoH
	 nF9mg/USM44gmu0ukg8PIi73uCYMBEGkkzWSluSF6IsGPDT+B4ep6jQzeX+lfFi45p21H
	 RlRZvJcEl2sXbAlSX/ZnJk5QpDx5hn7K8bZyZ4LYTc3sS8Pt32ANkcVdyshwNa0QqdX15
	 XZes9oTmvGtzFQAM+CWdVNXOmfjUU7wHWz/cNwOfX7O7etfPjzNdnjbEIiVGZwVOR8Hb4
	 qbRPEOKtslzO2CYg27MmfIom2ctgobl2DT3pgeAcgp77EC36zhQ+VW5JLL1JF+b7BTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwEYFuI+;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F25606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F25606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OwEYFuI+
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so294064a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793141523; x=1793746323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
        b=OwEYFuI+V2YInCuRrFA7q90KxIID/eOWw8RyWuN2h8FaIr5NIvO3edmJQTySSJRzM5
         0Cxq7z4Qie2LiOAg/cad6qUCh+0olO1ZUqpxfgjv4SDB4LQEO4QpXUt3L2eqw+szy1N9
         kyaGBAzW8N81cu99ax1KGSkVb5pel5CYwgpHDMP6dfGDrY24eFm0MsCQhlvoPRj35hyp
         Ez943hgH1e8gCK1+UwE7252lecetmOND7u5gRRvQOkiT8YdrUt1LUYX6+dVoNnXDqc4B
         UIcZvV03W96gsdf3raGUuZ62VWeg2g9/CMb3Eb1TWtuFZ8ulGZavb2cuoTRJIfVtmwYq
         efcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141523; x=1793746323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nLhzNnuR7rMVo3Esh8395rEk4roZFjv/lWnMw/Mzgw=;
        b=RL0dsVT07wgRoJlG699bmoC2soAHm67eUJszM2sVRKLCXFStKZSLYR2arAF6S5Kgca
         LvC5PfOLDW3xxWrQg8z6lnywFOpkJ4FBT9Qxdil7QIkwcu5B1c1HMJ+YLUVbpGeTzmsV
         K2dkHl91RwPnl0NPnK47AhG6ESL/rsW7Q9WWv6ocCKtMxatgxs/iQGbIdIS26++7FUcf
         Qb5mpObK4RfnWEeAH2dSq387dR9T5ZpCCvHsUpVbYTJ3PCc9rS6WSE4c4R2zyeCc1GCu
         xVZr0mY62Zw6BqRdFMIa4Z4dNfZGEpHUotOn48ennbq2tBN8O4yrFlJ4Zj8nLEbJOx2r
         IwsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsH2YT14VuxPlU5uRUE3MU1BYD28DMene5ummIF7ukezkQOBhsrB4vWLqO71sUAunBlNZulw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6QPZGstbH38AC+p4jCRqVkYRPgNNlda9FmGxOZwgKUjXmbZIq
	Im8k+qzCjtxkDrQTAy9SB38+sg1O0ir2AtZdghiki8SZ9NhN/BfKyDzz
X-Gm-Gg: AYBFou1JxBcRAPEDTduMjOMC78iUeDff+8n/ltMLzB21dg2TewcKUhkV1gfxsqjjbOi
	3jvszQjvKPFqzAQTFlztnc0BMjg6Uv56P21SFO7VkLfo6jkmdaRtavHxLgtzE3nt1mjh/lMInBL
	UKMk4lwo/C/AfpvqKngSdzus5uXFj+CMpkkr6dhiu8nvXfgTu77NEOnfJRZaV9ghGenlLF8es8V
	kDbkZLsojCKFjThlT4dkNMU9+wh683CjPVLPZxkevZqCXV1cvFpGRV2YldnYYCi6i41s9dUie7Q
	4At7ND4Coii/0I/+1jr+KTx6FWDBOPvgNEcB7h04edCBoitu9XGEJ9quNs7GFsuKvJQC1pzzDYT
	//jLOm2u/eMvM60/ydlEfPD26qS/N5+n5jav3t5AhOJ/lT52N+A2Pvwyz5lp3VWA4wul+9ulk5J
	3KhWQktZ1+orbTAk1jqyBm5FNFdeBw1mNrf1AYMQTcv6toZ+FWR/5FgXvCIxGJXOVdEkrctHvtE
	sXZZ1L/WodpToXeeqs7RU/mvXSLsg0YZ6fDDSxoahtxgwQGwrvrw9XTh5+ey5KTbrs1VlnEdV5T
	Klf4B64SBU2WUM+PqlFuMFt/5H+wjrLllYfUwoMggg+r
X-Received: by 2002:a17:90b:2745:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3ae58317899mr361987a91.57.1793141522593;
        Tue, 27 Oct 2026 15:52:02 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a944acasm192658a91.7.2026.10.27.15.51.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 15:52:02 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Wed, 28 Oct 2026 06:51:55 +0800
Message-ID: <20261027225155.49607-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179308626642.3134.14988418944940808850@kernel.org>
References: <20261023065311.65031-1-yangguoshuai@gmail.com> <179308626642.3134.14988418944940808850@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 27, 2026 at 07:31:06AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Is enabling rx-gro-list enough on its own to reach this case?
...
> Could the commit message describe that topology? Could it also say that
> this half of the fix depends on TCP fraglist GRO? That feature is much
> newer than e27cca96cd68 from the Fixes: tag, so on stable trees without it
> the pre-pass does nothing.
>
> [Severity: Medium]
> Is there still a BUG_ON() at this point? In the tree this patch targets,
> skb_segment() handles the condition like this:
...
> Could the commit message say which kernel the trace came from? Could it
> also describe the behavior on the kernels this patch targets?
>
> [Severity: Medium]
> Can fragp point at the ->next field of a member that is still shared when
> this store happens?
...
> This relink pattern looks like it comes from ___pskb_trim(). That function
> handles skb_shared() on every member before skipping any, so it never
> writes through a shared predecessor. Would it be safer to privatize every
> member walked so far, including the skipped ones, or to copy from the first
> shared member onward the way skb_cow_data() does?

Thank you for the detailed review. All three points are valid:

1. In esp_reset_espintcp_fraglist_gso(), skipping a shared predecessor
   before checking skb_shared(frag) means a subsequent *fragp = frag store
   would overwrite the shared predecessor's ->next pointer across both
   clones. Unsharing every walked frag_list member first (as ___pskb_trim()
   does) before checking SKB_GSO_FRAGLIST guarantees that fragp always
   points into an unshared predecessor.
2. In the commit message, I will clarify that the BUG_ON(!list_skb->head_frag)
   oops trace was captured on a 6.12 LTS kernel, whereas on current mainline
   kernels skb_segment() hits DEBUG_NET_WARN_ON_ONCE(1) and returns -EINVAL,
   causing validate_xmit_skb() to drop the packet.
3. I will also clarify the topology required for TCP fraglist GRO
   (SKB_GSO_FRAGLIST) to reach esp_input() (e.g., rx-gro-list on a device in
   an outer netns forwarded across veth into the netns hosting the espintcp
   socket) and note that this pre-pass applies to kernels with TCP fraglist
   GRO support.

I will send a v4 with these updates.

pw-bot: cr
