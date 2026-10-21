Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601674;
	b=hF16V7zNPNINbiSSk+99a2sOnSYsjQYFcZx33b2EM4b7MjWgf7ZCaWOQjXrRprmse3wv
	 pj3GM18JzcUL2TV5GJ+TsApfEL9viEvgELvKxQz+Y9kwZSbyHY33dLMLTCVrn1lh0fjBM
	 7/s3iEwazeDNCGxLAocXZXMA3bADsCkw9+U5P+ML43y4ZKB+IHkjDMoP8dWf8BOyqOVGj
	 pZFWeVZuLkqYGpzMnO67ZLuhjPxsbDacj7iCT5DElFK6bKG7Up7wsPS/AnHSM9M9N82jU
	 9ybK0LSuOcv8x7/HBPpa8Z8ErwdPbeA2hOcOJ0v90/xlgnWVTL0QBFckhzPAicMVjsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5uBEze/evtT5czYTyQY5oVqkl5o6ecPsYfRQN9Yw5Eg=;
	b=VszgPKxxZri4wCikTVezeTL4zTSxOF5F0aOsZWGfH8Z6db+c1+RTqvrAObWGA2ptO3Bh
	 3DvEem/2Xyr9OGQUGmViMg2We2eF0eN5fgJcRxOfjHGmej9cTVn5aQTRw9NTJWubLnPL5
	 QovQnhFeazAnwbq4qWYOEUjx/RRRDYgXTs+4xvPZW9nw491eTepfDkR49t4DO29BOPmZx
	 0xQzi5WXAnzv6nSwfQ7eHfUuAK3e7dp8vVECHG5gM167p2O2Irw4jMeyJlpaMYBVtYdcN
	 B0QTvvtQWJ2Ht4Jy6j6BJ4xZjOd9kWVU1kJxrAOh8MTCsuQlO/JrN0aJsw2zcQGKmjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hHiIbhu2;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482F606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7482F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hHiIbhu2
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99075306daaso510091241.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601673; x=1793206473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5uBEze/evtT5czYTyQY5oVqkl5o6ecPsYfRQN9Yw5Eg=;
        b=hHiIbhu2yf3WJ40YCpWRpjVhnDnS2VXKmTBdH5PJgwtDeqCr3CJl9ayTN49uxeJOg7
         H7QEhpuOngE8vpmasU1a30VhHSQQoOWtyeapTEEqYJKisReP2St0edbHc3Iy9XowPL92
         NKY36+yJPN19qkfB3wtgkcQcuzCiY/WVGoWOvLYRfSUvhJX6URGymJkzP4xidL55sgw0
         oLORWRGrNY6N1BBb31whMYKq6+V9rTLHWePK+6QNLKmzK+FwFb9zpeHH6OKlUsL24oJF
         pt4xQZu5bmEYRShub0U/gcdKAdTj4nNrRIKqRoe4j916jeK6T+NaMYEPkxld6UhTVCW2
         wYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601673; x=1793206473;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uBEze/evtT5czYTyQY5oVqkl5o6ecPsYfRQN9Yw5Eg=;
        b=NmPK78o0jOU/dPRR/UoHhZCD0laC4pCP9zc6Z7qvWLt5LSarjmXxtDYWIGQiJMOmD6
         yUcFCKG0BYr3Dq4YewVaT8IaX2xp+SwFalxue00f7Li2hw4z1CLb6qh7bbW3OdYHibeH
         tpSz1J+AElMG99GnVIp+bwcne0ijSYc9lJfgcIO7ylPV0zsggGffJTGsq94EnJkwqgh3
         bQet7rIc12z/+YjMuWaAIC0JhnGo1atzSDqEvhrI++k1bhVMmPPfhE3WivOlbqI8ShJ5
         ocGh4qNvNgKL9P4ps/qhRDW7uqjg0D0RQ+ol3Ol4qNcgN09/VFwUgMVcrBB+kF2bG94C
         Gx2A==
X-Forwarded-Encrypted: i=1; AKwUvBx6azxqPY1dxiWSAUzwW+VelNV75WW9L0tAKB5C7mu1o46EMxsjvdNxpHAUwIDxlATsvlUT8sI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJds/bQSG8A234jEORez8y2Jhz4YvXqSoXoUyDgKlg5i51AvKeq
	21xkYd/dF8ffNQD/Dsw8Q6S9ejT0H6/RnF/8wD8+yI6OQeGV9OAz20EE
X-Gm-Gg: AYBFou2fhhW0MmGCdCv6QwZAyWCdpx6aTZVLL0zSWF4O5q64O0nmDQxI9J5mka1rpuX
	K13U1u9EvdF0GUervadfb3uVJe37wcSTSz/FPi2w8a6WhjBHuspIMheCZ5J1tlDw9Rc0+r93AbW
	jTieuQkfjLVMDuuG62ttHG3oE2up9vMgI73I1enAv7Q6DCpGwZbTtwbX9g6EWeVuIEfNpXzj5FX
	z93KrnMpFrnXjCZ15kT5hbhzBFXZ5BGtKzM69duyENnuNk47KSU6t9acfjI4RyluNqo4TGeK7IS
	vvkVfDeHFWZbJo0GHxoKue0EQHc8AcdEoL9o0ikReWtBIQWYygHFdkPmXJm7PcjEPcRqec8aZZ4
	ZlcyoCmqkfDos2Wl6BbhiwYu0TmCObXgwHdiB2/JM+RYRkbNFcB7WfPXLqs/dsB4g+6+yCaMqK8
	L2NmqrEUHGrvYsIJbO9hTWJiNUysX3CstpSyH/rpHglok1diCFfD2uP7ThBw52YkB7ifj1PcOSQ
	bIqtMyeZdRcC0hTMNV95YXYlEIv+3LWvR167NbyuE+MUhZjyNJk7KuCbrtNwl1zJh4x0xONk8YI
	hH7qCE+K84zmvyS1okgeUJTqgSPuU4Ud7G021j+a6pjc6Tl9Udv+E4J0cMSWObe9r5LwLr8nw7t
	FjpeK9/T3D9dchWZVyTA=
X-Received: by 2002:a05:6102:3c92:b0:7ba:9a61:23eb with SMTP id ada2fe7eead31-7cc9276c9b0mr1062134137.37.1792601673297;
        Wed, 21 Oct 2026 09:54:33 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d1090443sm3702969241.8.2026.10.21.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:54:32 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:54:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Simon Polack <spolack+git@mailbox.org>
Message-ID: <willemdebruijn.kernel.1c909124a1017@gmail.com>
In-Reply-To: <20261021161858.761205-1-edumazet@kernel.org>
References: <20261021161858.761205-1-edumazet@kernel.org>
Subject: Re: [PATCH net] net: fix frag_list leak in skb_segment_list() error
 path
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
> skb_segment_list() detaches the frag_list from the head skb and moves
> its members one by one to the skb->next chain. On error, err_linearize
> frees that chain with kfree_skb_list(skb->next), relying on the members
> not yet processed to still be linked after the current one.
> 
> This does not hold when the current member was shared: it is replaced
> by skb_clone(), and __skb_clone() clears ->next. If __skb_linearize()
> then fails on that clone, the remaining members are no longer reachable
> from skb->next nor from skb_shinfo(skb)->frag_list, and they leak.
> 
> The skb_shared() error branch already relinks nskb->next to list_skb
> before jumping to err_linearize. Do it unconditionally right after nskb
> is added to the chain, so every error exit sees the remaining members.
> On the last member list_skb is NULL, which still terminates the chain.
> 
> Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Simon Polack <spolack+git@mailbox.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
