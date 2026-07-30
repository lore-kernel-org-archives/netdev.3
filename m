Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E67406270
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403345; cv=none; b=ig7nOPavqanPE/QYdR8Vwz1fjoUvyjL6PlIJ/h788uj4liksuy4hKGAZrhToSgOx1iQYDSIub3j/ryUzbao2vMm9+hVT9/5AkX7doNLLkqkGzVWmD/HODoU8w/g//0a6YT6QnqlsRGSqUFJMtO6CgS7Zwtu8OAWF356mUh0TdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403345; c=relaxed/simple;
	bh=+ZPUS+pWBIyobZk02S5SG+Jfpd9YvNmk6RAjNBVIEik=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jcftg15ZkxqNf7FSDGvlhkOpDDmaUEHxSplJ4wMBY93ZUXp34lxnLfw76c0mH775nzPweKTVM3TRf+RjuPEUhTY0if+JFkvhoiPYR3+pT3dl53GiFqPQZGpspyqrvKzu9NnTUmugWmCdmIQ4Ho7CPjXfYMw1Srew7JkKw7ODNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/K24zff; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/K24zff"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7ff05e5d009so24227367b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403343; x=1786008143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/uGz8/en7PP3yUR7bLkaXn8KlTTvQzld3gW8RE4GTA=;
        b=X/K24zff6w60/fMyWEnDA1lOOZrMM42en6VUTpBPgQcE/0zDlv2XlL/u+4PCRbxoGL
         /N3U5K93b9iQ7Brn+X3D7s31AZUb/FS+1uBwMRH+8wJK9ozE3+r8dM0kqgkJFwfI5b4u
         amaoGBW3Wc6GG4DgHs1rW7FIFsAAMOjZUgIDVaLxJOqjojeHNoKhUqm/CrxIDA+udrhG
         M0wkNDSz73gc+gFjm/qIBAF9CAnFiJ1V5/B5cGuz4pIhv90SRzN3m8m5xaFBMb7XRiZr
         UDrMZBL5eFYfkeEu9f1ckapapaN5FA3DVfYiL0GeZjt0mWr7qSDCLKXqWoA2Qn5/kTl7
         f2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403343; x=1786008143;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/uGz8/en7PP3yUR7bLkaXn8KlTTvQzld3gW8RE4GTA=;
        b=CpLUtUHTEnXKPixdA/ef15yEkFDYCmM3dEgwO2aXYUeqNd43kIYpyxqjdjio4n8Xd5
         91cR4KsUcQiqGakZ13vuYS5VlZpVRk8gl6wFwVij9Ys8xptRhS+MRQI7PEMQpfyiOaJX
         uxyn4CYVgJaGiy/AvOurOGbOazKQpB04zasNQ6Y8lWoFPMWSsuiYO/MpzmEPAiHR8EwM
         UZ/c8ITDhDEBuOji0J8jqYw41ID8eWbJrpzvEC8rbV92nRMDM9RWEPrAk5YzHfiaAzRo
         JhhW38pRbdkSJQKL4ZERB7rM9hMf0JXBJhdycX6pCtrTLoWPYiVIhzr2d+sKxLKU0Ooi
         DgRA==
X-Forwarded-Encrypted: i=1; AHgh+RoIxrGIseM88OIK2EjaDDLA2WkO1b1U2RTFyha+KvCwWfpBg4zAkh/pNrVqUv99HTh0rhLaDII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJqSCaeE2fBosJtk36zhL9Z9KF6YmLMHDNpddIOHsdIeS65yi
	r4m4OmGyF+eVy2JyuUtTd+I7NVOx8Jql5yUDPfJFvYD9h2aW2L1qoMRL
X-Gm-Gg: AR+sD11Aw//GLtZSuswHHYI+VIkqL0/PFpXiiQQhyofCZ08+84G+TOVIaSVapJ9PBvT
	EuU9notKnuJuzb3tfcNPkFnA726HvZwrlMQyD9x5smFYaGzdhSX7VP8Oa6KNRX8I93kQtRQedwx
	rHatKxA3hkF0zJntZ19BiAav02YOC9kmgZYo0Uacu/nZ6x2B8LQNOJZ+ifvNc2HNdCXxe/JPnBC
	+EO4qVoxMlQ4HzWIvVe9bJW8Kzjk5SnQvqR6M7hmnAYEr5U3/PCV99GQe9YcySjRaHlBBMdi4vd
	5/M0JnaZI9JP5YHz1EdeO0+lsDpHnw0UQL3HynP0SYViS7w2ZIjsQI7kE78PSsz9kgcxQ3qevm3
	HcAuzN1xpmqov3WOWtwXf5zKv+mSf5IjIPN/FYgmKRSqwR6RAYE6pMFG3ZliyOvy69oXA0ZbbOP
	VKbAz4nVIANRlpNpcEkOWRV+l3Wp7XzaXE9ufJ2lINNKKbGNZ2VVUFwqrTAMYVdznmMC+zHQFe2
	5v2H+ZlWIGSBGPtAEZ9qlzN5tQnUrx2Rajk
X-Received: by 2002:a05:690c:6d10:b0:81f:3dab:372f with SMTP id 00721157ae682-81fb88c616fmr11936857b3.12.1785403342691;
        Thu, 30 Jul 2026 02:22:22 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8acb5f0sm6856507b3.38.2026.07.30.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:22:21 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:22:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qihang <q.h.hack.winter@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 stable@vger.kernel.org, 
 Qihang <q.h.hack.winter@gmail.com>
Message-ID: <willemdebruijn.kernel.f39af6152c60@gmail.com>
In-Reply-To: <20260730082925.93759-3-q.h.hack.winter@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
 <20260730082925.93759-3-q.h.hack.winter@gmail.com>
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Qihang wrote:
> tpacket_snd() reads dev->hard_header_len independently for skb
> allocation and header construction in tpacket_fill_skb(). Concurrent
> netdevice reconfiguration can therefore make the reserved headroom
> smaller than the amount later pushed, or make copylen - hard_header_len
> negative.
> 
> Snapshot hard_header_len once before processing ring frames and use it
> for the frame limit, headroom allocation, copy length, and skb
> construction. Pass the snapshot to tpacket_fill_skb().
> 
> The separate SOCK_DGRAM consistency problem between hard_header_len and
> header_ops->create is not addressed here.
> 
> Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
