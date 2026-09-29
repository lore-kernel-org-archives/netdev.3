Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478D5293EC
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688127; cv=none; b=mqUJ1bkFZAqJ9cLa0JAkHBg8Whtn+uuBwVNAdZEUGDvbGNY5GRHz3Uahgy4tYqFERaULQSW6h8NKMZ8ZgNr7iJv08MFiNgwXCmp+WqsVpETlYOXcvTfOhRcYUdmPd5PLRJghUg2YxK02Ab2pf7szNYumyVTKCnsEbkyBg491Hp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688127; c=relaxed/simple;
	bh=qraalZWdh8TQQ6BSeD/tfmfJyOuvPZNTzPY+wsAjPps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejXuq+8c6Cyr0fqZwax6TJP/IYNyujqrGmwh/yJK981thvSUL8hmcZelDEjhH5E1uv3Kd1ClhJ/yC4MfLLM5QQKpDeimIFn23UvenniX5dFC3C9q0ukG9vN4IDMiB+Krp9hMtFBrA6mg1UZIgWbmxwU4McvJyYEy/kRWc/zujOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0FmGXIp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwxYyGkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0FmGXIp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwxYyGkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790688125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWJfgnj00gCkz7CXTr/d8e8qYHqPtAX3JIZh4ekkrdI=;
	b=a0FmGXIpNxJbQKkdq/JCFhl5BprvmzhP68xMVMOiuLTChJhEwZcpCx0L089FLgE8h0YjTS
	lpPxhQkHemwqePMuzkF4J7gSiH95FQAqFspSFhuNOtczfgh9cwXg+iVFHuhnmx66A1L3vK
	8mFVRGUrdJuPG9SnhlP/Dn3rmEIHaEk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-vZpEPfA6OougRXiWGuWlHw-1; Tue, 29 Sep 2026 09:22:03 -0400
X-MC-Unique: vZpEPfA6OougRXiWGuWlHw-1
X-Mimecast-MFC-AGG-ID: vZpEPfA6OougRXiWGuWlHw_1790688123
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48889db9974so2534229f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790688123; x=1791292923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWJfgnj00gCkz7CXTr/d8e8qYHqPtAX3JIZh4ekkrdI=;
        b=WwxYyGkVD7MHp4SE/0lUe87IOvdeqC1gUm5jutJ8DqYGgDpZO84ng7HVsGjVDofDcG
         gs9PYUACOIDF/rGZlinOE7dOrKLIQxvZfmWqM40t6zCiAEb6E47/1EIrJoPMf08Q+SR9
         p+GKZUL+EGb7P8QkNildybJ3d1k12Tcvr4g7vMZeOOSTq7eoLCdS012GB0RT0/gx3+iY
         mm32k+LIaxwhXQl6xkW2d1UgxLo+sEQ7LiPjdoo+XoOOHcKJfVv1B6SSOhvlGvwXNIRa
         dGkZboFj8S1y/z6VonyTo3PWhJt6H30e9wt5scwydD9iUxuPV9Qth10vggkjXrDdp4yP
         rPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688123; x=1791292923;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWJfgnj00gCkz7CXTr/d8e8qYHqPtAX3JIZh4ekkrdI=;
        b=qtqcLh7Cp8weQaWa5P5sCvmvkQNpxxfmbqPwhytjTEZ/cNLaTzcW//znggPtz79167
         Zx2OpMjPQv+GnUvcz/bsa9DUuStmlmiZVFveifcieSy9PKjByRKRf7G7G3NptyOheFYv
         SugxbYo+x4JA1t80qFn2NPpaJb1/XCNOillh7c6be4lBe9j7YS293PbG9RmepYKRM7W2
         CblTtVJP/NSSM05lp+l3+LdBkDPEjncCWu+1XjETdM6/Iw9ufDbWP5AgjUPN2z44UslH
         BBdX6L8Bj3ZwOaem3DRISCI3pLovemciAo7FIeRZj3TUeas22NbkHqidkN5q4FK15KcN
         nzSA==
X-Forwarded-Encrypted: i=1; AKwUvBzskaW2dmj0D1DAkCAa6In3gCrEOKgmdU2nqjxV/Q0GgtWCE+bcm+gNoV3rCEaZaKMvMPisRjw=@vger.kernel.org
X-Gm-Message-State: AFuF++lH0/h4ikALs+uzsNERqEOZ25mqtuSAU3Ui6HZRq9UM7tbNg144
	I9du6ntJSupiadJlI7tw/2k2kNMveof3glHPFre9Ee5jslsqTwhnF0+WvWobo0OKMmbfZFDXsQW
	mgVrblkWAC0pLsl9gzkb+rI00pRwbS6YtlXDgy72+/yAGpcKtpkQuxF7ROw==
X-Gm-Gg: AYBFou1xKrCiY50GvR01zrY+sImYauV40VnX8rlQd6l0ptogvn1GbU63gCN2EGg8WYq
	TyJCqnK5bivnE/FYpsoC0HO7YB/wlN2X5UTAaqr0ZDGCr36QfZfAZSBrIaqgpcB+9UIH1Co5e5O
	xJOXu+GufiR2mkfpLoZyxoYRi6y1Iz0ml4wvGR3WCdJ6LcTfg0cG97yU28n4h3xq3OA2A8bHi6X
	BbSjamOsM8GT1inMHCLlYbNYKdUrEj1a9Rv2B75kv5WlfCkrvQ28LP93E+NZKFjQAGwqyphFAr5
	rYmKBDjft6tebCVI4kxy0JHyBzMSpCswvfahb0S9RHqc66ZQY1uqcsm592M2PukiGtAJbSfsMFi
	NFitSEMyI8TTfACD7+kaxlA648p3sRM6l84LElz0L7CiP950USFKRRadqSmEW2qwpkNyTAxxfhg
	==
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-49fe66f4c72mr283832925e9.19.1790688122602;
        Tue, 29 Sep 2026 06:22:02 -0700 (PDT)
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-49fe66f4c72mr283832245e9.19.1790688122023;
        Tue, 29 Sep 2026 06:22:02 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf2d973sm93471735e9.0.2026.09.29.06.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:22:01 -0700 (PDT)
Message-ID: <a3275288-1eae-463e-ba9f-dbb2d715d1b4@redhat.com>
Date: Tue, 29 Sep 2026 15:21:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: axienet: bound TX completion cleanup by the
 NAPI budget
To: Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com, michal.simek@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 robert.hancock@calian.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260924135052.185129-1-maimon.sagi@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260924135052.185129-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 15:50, Sagi Maimon wrote:
> axienet_tx_poll() passes lp->tx_bd_num to axienet_free_tx_chain() as
> @nr_bds, and @budget is only forwarded to napi_consume_skb() as its
> bulk-free hint.  Nothing limits the cleanup loop to the NAPI budget, so
> the number of packets returned is bounded by the TX ring size rather
> than by the budget, and the poll can report more work than it was
> given:
> 
>    eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
>          returned 96, exceeding its budget of 64.
> 
> Returning more than the budget breaks the NAPI contract.  It also makes
> the "packets < budget" test in axienet_tx_poll() false, so
> napi_complete_done() is skipped and TX completion interrupts are not
> re-enabled on that pass.  NAPI reschedules the poll, so this recovers,
> but the accounting is wrong either way.
> 
> In steady state fewer descriptors complete per poll than the budget
> allows, which is why this is rarely observed.  Triggering it needs more
> than @budget completions outstanding at once - for example when TX
> completion interrupts have not been taken for a while and a full ring is
> reclaimed in one go.
> 
> Stop the loop once the budget is spent.  

Napi can process as much TX descriptor as available, even above `budget`
see:

https://elixir.bootlin.com/linux/v7.2.8/source/Documentation/networking/napi.rst#L68

The solution would be capping axienet_tx_poll() return value to `budget`.

/P

