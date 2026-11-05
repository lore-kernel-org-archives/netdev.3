Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870481;
	b=wLp1r9COLVS9Il4YKinrwnSNEVSI1uYBEGX8OVpC6LeDB6NNZnc9laqANruB1h6AE8g3
	 OZg9K8nEUNON3+M5c729AQnS05ezVGHh2qofiloDlfQ3bCg2FU8ac42DmmFJt3utmsyxq
	 hxkMpm8W1r6mVimUvNChJ7EXCODEfcOoklzejkgMoPfTaUfrxubzgtlhwd/cvfVgFQoUG
	 D+FEbWKoUEzVK20Tt6+2nK4OrOGsQeTz74ufwEEx5pKLsHlEwXLqtJtsAPND3YzLq9nQ4
	 gfH43e9s2jilTNutAAfeXbsaYOwRegpW6gzzTgBO0KYN0ZGs6wWdtNBE3MtqXZoSKuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870481;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=coFe23yWIjr3rWL1bT0oW9dpEwkMZ8FlItLtkhGEJxY=;
	b=g5QWJSvEey/B5m1QeCHLNVCrG+YiWbEOjHf/ORxRpy2zSM9lvzkJGaFLrepVMb8LQ1C6
	 huAE92Kh1eq64JlKUYA07yst46EiATGIGy+APa4Xl7W5kbYhRLIJ1mWZiPNP7IHkw6O3N
	 boBEdzTxxDnScuRyBkzjOyrhaEzPxMP+ZIr/EvxKw3Q7Y2SmIYmWUQJDoUEqJVIugi9Vq
	 gxq7I//pwGee4/9cUc4yCxZywEKV/yBY5fLrcmDHqrm9JMc6IK2rZFZPk+GMg3q8gaMgH
	 O4dADg+4RTkbp/oy+nwaMj8urtwEOuKrdzIJVR2lJGa0Vi+1xy4ABSt988yv/lAC/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hT8koiwh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zgt1TAG9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B2606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB4B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hT8koiwh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zgt1TAG9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793870479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coFe23yWIjr3rWL1bT0oW9dpEwkMZ8FlItLtkhGEJxY=;
	b=hT8koiwhdclTGRFjf0NSnIW7eC71ZjzQCvE8fw4lkBbIG9UfxAGtY4gDhSQ03mElgJxYbQ
	DKH0G183caQnVHJCUWIDQbo9cGQq4qyzD+EdAP8pkQWYWdudfdhgzUtysWOVkWRq21GP6Y
	0cbZZ6C2TdrQTrGwtMLdB9LdF2SNm5s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-JUu_YepnOS6GiXZ6hzqHKA-1; Thu, 05 Nov 2026 04:21:18 -0500
X-MC-Unique: JUu_YepnOS6GiXZ6hzqHKA-1
X-Mimecast-MFC-AGG-ID: JUu_YepnOS6GiXZ6hzqHKA_1793870477
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4918bc20249so306714f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793870477; x=1794475277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=coFe23yWIjr3rWL1bT0oW9dpEwkMZ8FlItLtkhGEJxY=;
        b=Zgt1TAG9YOfsnRZRQzHKoGDecqL7ZTki+5Gszt8Yypo4/ZGNAbLZe1nqc1HL4Yq/ov
         dJbFK/ipbkgZc42gdMN40JQ8cBH93hiAQGEMXwLyLh0c8597l/NI1CZSNRcmZeB8cAv+
         eq4BYLd8RtKE/MYCGKGMJCgq9LqEsyWH3h1Emd/cPESvicJDM8AJkKqTuqWCaF1Qb+qp
         nPArat/cz+Xb8DXv2FJZoE9x05rT9DxHZKVIkAIYFfGT42Qe1CjKpi1zZN6MoMNOfXlA
         /dZUx0ZR0+/PQ4FyIv1d4K5GnGg9i86dX34/sDS/mXP1yIzm3V0FNuMm4xlr4EcXSore
         zhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793870477; x=1794475277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coFe23yWIjr3rWL1bT0oW9dpEwkMZ8FlItLtkhGEJxY=;
        b=TFPH/AzCMjJPgkU31ZdcnF2EPBFdB0mu2PlpBfmi20WY/Tdj+1h4OQxdK3DR8/PdJx
         vHAnJLSTfiNc2aDd10f0o0romPT7a4IKaWDB23OW3ecojgT3lQgc6laxTJwo9NKXmJ9K
         YcsI+aymscJQ2c1zjqxECvhFwllR9JBW7wtlUVk2e+36KbKiGG3GHRtnlWAlofA+fh//
         9mbyp2BSqJDy7+DUVsGxQ2d2iyqjCZadJfyU/Q9zyV33DJgeFn4uztAbaqR5uIoReJga
         Ypy0HtieJIQh661ApxeFtVo6LRdqA/1MD7Oeuf+z5A9zxMziBN47v91ermgPoHhzYxQB
         9T4g==
X-Gm-Message-State: APuU4Z8gw1mCRKlQiEH0tfTK2TqSlwy9Rj1F8qdWKEeSA6QuxQNF0KUa
	uojtM+WMZ5yJW04+Sg/p+tEFTDXz4fF1npvtgffsMGuvXlSRR6Zn9PNHVie3Zh17fZFCEMdghy2
	puDwGMFk8ymFg41ZGZuYTPsxxxBw9xiYVjHyGvn6y7hxVDQ2FdHJDmVSpcQ==
X-Gm-Gg: AYBFou0UuIUwh1mIK6lpHWndCXVcLD7l4yyysxGPS5m9MOAwPTl4ba7W5ZAAsnNOGOy
	WoWtQfEjudLp5jtq76f3kRYtLkx7+fY/M+wfNJz2thBmspZsMTy2x3M8MhOMZRMTKF+eqk9tQOx
	5DFL5kDpJjKghB03nid6k04Wkog17Qqa8v63MuL6Cvxkz1ZXAbqRu5Dutm0qCd1FRCjHmFeNIKS
	7riwg8MZWhfjnqPie51XbIo/kVOovcF6YDSVAu+TsiHwgkG/Y2qoCsgLHko23K4ncgULaJsPcj9
	6ZtbFRPsOqnJfZo5mV/Kd160iEpxHOli7lMpMtI8PW2gqehqgW4Cw22fqZUbNdTCu46CsXvQTwD
	kFn867LFfCMp7S/2Y6WGN/TytW9hATSBwmYUgcBX31KnBfo/Qb18B1wsSM+fMHxWKiJM8a3caRx
	I0ntFpd3wOq0gQ4BsuauDL6r9zc38nJ5HPhfUGgpBEH80=
X-Received: by 2002:a05:600c:198c:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4ac15584c05mr425346825e9.2.1793870477372;
        Thu, 05 Nov 2026 01:21:17 -0800 (PST)
X-Received: by 2002:a05:600c:198c:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4ac15584c05mr425346215e9.2.1793870476675;
        Thu, 05 Nov 2026 01:21:16 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99b33sm8317482f8f.23.2026.11.05.01.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:21:16 -0800 (PST)
Message-ID: <5abaf2a2-73b5-4400-a585-0955556a01a5@redhat.com>
Date: Thu, 5 Nov 2026 10:21:15 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] bonding: give a slave that starts UP a full
 arp_missed_max window
To: Ramses de Norre <ramses@well-founded.dev>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Bohac <jbohac@suse.cz>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <hangbin.liu@linux.dev>
References: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
 <20261030-bonding-last-rx-v5-2-0b9b653f2f94@well-founded.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030-bonding-last-rx-v5-2-0b9b653f2f94@well-founded.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:51, Ramses de Norre wrote:
> The ARP monitor marks an UP slave DOWN once jiffies passes
> last_rx + arp_missed_max * arp_interval + arp_interval/2. bond_enslave()
> seeds last_rx one arp_interval (plus a tick) in the past, which brings
> the down deadline of a slave that starts UP forward by one interval
> compared to what arp_missed_max promises.
> 
> Active-backup mode hides this with a grace period after enslavement in
> bond_ab_arp_inspect(). Load-balance mode has no grace period after
> enslavement. With arp_missed_max=1 the deadline is half an interval
> after enslavement, and the first monitor run checks the slave before it
> sends the first probe. If that run lands in the second half of the
> interval, a healthy slave is reported "interface is now down" and comes
> back UP on the next run.
> 
> Seed a slave that starts UP with last_link_up instead, so it gets a full
> arp_missed_max window for its first reply. bond_arp_rcv() and
> bond_na_rcv() only trust ARPs seen on backup slaves once the active
> slave's last_rx is after its last_link_up. A seed equal to last_link_up
> keeps that check false until a real reply arrives, as it is today.
> 
> This only covers a slave enslaved while the ARP monitor is running.
> When the monitor starts later, from bond_open() or when arp_interval is
> set at runtime, the seed is still as old as the time since enslavement,
> as it was before this patch.
> 
> Fixes: 5944b5abd864 ("Bonding: add arp_missed_max option")
> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
> ---
>   drivers/net/bonding/bond_main.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 2f5638f4d3a78..84eafb607c370 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2158,9 +2158,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   		new_slave->last_rx = jiffies -
>   			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
>   	} else {
> +		/* Give a slave that starts UP a full arp_missed_max window.
> +		 * Not seeding it later than last_link_up keeps bond_arp_rcv()
> +		 * from trusting ARPs on backup slaves before the active one
> +		 * got a reply.
> +		 */
>   		new_slave->last_link_up = jiffies;
> -		new_slave->last_rx = jiffies -
> -			(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +		new_slave->last_rx = new_slave->last_link_up;
>   	}
>   	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
>   		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
> 

@Jay, @Hangbin: can you please have a look here?

Thanks!

Paolo

