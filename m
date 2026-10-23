Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756527;
	b=j4m0jau/tQmN+ZLXc77pqGNoeVuWugdtIxXoKmA+RTwJX3Rdlay3PAcr/+K4+SI5bZGU
	 V/XCoS0fjzc5xllRlkZ9OIboIPQ+dOMXHd51fEbbM8xMxCgfAslFrGP04W+jH9RDWZtK4
	 C9kqggNZRh844sqVRmb54OPzt5QrqtRyB1ndm49MJinqyQ1udgwguRveWn1lTTijeMtiW
	 QBEaDvVmBXYpmfgTzCCel3BYT2eNTAE+PqHhiot/ExelKTMHpGzplLlW16mpUFgP/mAAi
	 VREcY8UOrWo1H6R4aUhmbzY9dFOcX5FpxKqRYaLuCq+qgZBDBhpGmb0HNfSd3kl5lXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
	b=u0rWGU8A/PCxMZpHjvz9o82BzMPux1NochiGpyYD9qRt9CuzIKSN/Lm+HF8pwC4Yddzs
	 cwzvr46rhw0Pd5+uqi/Q9e6xbQ++XI5UzvLPJQOM/WEhnsIDZDTso4i1eaDqdDcgq2ldd
	 agDKPhmfGxxbd0dMlCblu6uG5JfgTX2QlTB9vak211DhWhh659unQC3Go9YsuhBTcSuez
	 76uAtnyKuJ66wor7o05ndnxKASkBQ5Utu+uXasSEhUsy+ZMdRQBjHPelLsPAaiQzhBjWL
	 cMDhRxt2a8mBhHvS36JQDBTb89zJ1RA4NSeiSvxJmwvx2fHZovaeht0IsVNdmuc9KZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PFHvA544;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA5606A328
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFA5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PFHvA544
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afbd2c386so437001f8f.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1792756525; x=1793361325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
        b=PFHvA544qyvx7w23MQzVC74QWW/SRzZ620CxgtB5Lzfts/kmVLTK9LVu/PbiUqtpmQ
         fR6SuJXzgDBWYoMN7OqDs+CmxiTblqUxWpUQB7tSj1GlX7ylAnRSILjXSkLCdUmsFban
         /T4jZP5o9Tcbq+DZj4jdLX8JGj9YBQ+txlhoGdsx8nByhZNxj9hBy7jdrc5TIdVsaptn
         HQl1EynC6kjNPhBihCrE6XueQBipApHotswqnWp0psjcqm8nYlIak5g6Lp1QgA3vFRl0
         QcHle9PEatWJcP5XNeld+S5KWxy0om2BibO6CQY/aWvEDSShhmPCdGtAchjwYvNlHAvu
         Aucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756525; x=1793361325;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
        b=pX7lkcbdiSdn26ziuuiJCKgFIlNFobE0O6FUphca+C8gPYezSdzcgNNrN2A9/Gu0V7
         28PJI7SRCU6GHEvEaWfWaSLPS5tVYJL3z3in6hZEaLfBD9tYf/tq+BznoPpujTdW4EuB
         zR2HgY6Kav3ws16aYCWMyGT2CMdPofsFbBRVoFeqkWifdsffJNrv/Ed9AvV69njfuIs+
         Up8hOGBKt1GtxPQ8rq+db3/PIoUwlVRd2JroDMJaeeR+gatdiBq+9iOUw6iWXnxh5MEl
         eO0QtCf4cf9phmZf1+iKhuMlJA/huPO02/ITVeaBgdg0WF9k3uCUe6+WmaXrVTgAuOGh
         sVEA==
X-Forwarded-Encrypted: i=1; AKwUvBxEhp/RdloA+ntmihLzZksG4GPUYJJwVp2KWL6k5TcerZVyTE4XAApMnT8raC38uJPwIVpdb3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYK67ic+kv4Quz2OVUwlM07XexKa11qbhiigIkzxAlZ9uSVdtn61
	nC5iBwYZvr2LMXxgeXfQGz76r0DXsZ6wMX8sihzkiUJcHRyCgzbeuhxx666LgMn7uMY=
X-Gm-Gg: AYBFou1N0KFs7+YMbqoLZxeQQotTnay3qboPbar6KarnMj/iETk+5CgQgYnkoEY7ZCW
	stKAVcd2quBVOhCDeg/ztGrxDzqkurTjT+T7jPPTysa1FE723lsbLDJnLrqEEhPbuZyTXG+qWEl
	vlQoeyYJrNEFZ/IBeyz0OmoJpRxx2zW9dtyzsTvKoqqCWGlSPZOQt9/hsbpHoI/i/2tYcXkNlAA
	QVlbaXyXg7C7M4lwtBvnhVHOqSmnIa69Ef7zfNwVl6sIgZPwWE6hfZYYGmd8WQDvnK8eqPD9lCg
	Qcha1TwF2TDbkJPwg2B/7/cMkmKR66WcRfPZXdSWATK4AR3P3NuiTWPLiV5vnuXsPqUH08ILhd0
	5S/9OHnMqaOI1kBIXePmwHcLmS7diT3gi5MvnTAUpp6KlXPkQRh0j2NUS5b+RuKRKn4gzIvbOpy
	PZO6WGUGVyZb/W0pp7/PzIJ6q0PUC94uZepzDroSrSMRbubqVDYoX+tOrAtpC2PYfmqX8HvSHRy
	akXjhgc8r+BtW6RoqX61QPlOzdASKN2rgIi5PhBy7TaFPYWOkF0S3s8LNtq50Ej1wwjXh4RfJPI
	VdVHEYPB7mXbjU73TSRIzQ/wkdS/pT0=
X-Received: by 2002:a05:6000:2407:b0:48e:3fc:e393 with SMTP id ffacd0b85a97d-48e38546abdmr3350412f8f.6.1792756524809;
        Fri, 23 Oct 2026 04:55:24 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e380314aesm4238717f8f.28.2026.10.23.04.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 04:55:24 -0700 (PDT)
Message-ID: <dac940d7-ac2b-41ea-b362-9c95edb5bcb6@blackwall.org>
Date: Fri, 23 Oct 2026 14:55:23 +0300
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
Subject: Re: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
Content-Language: en-US, bg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261023104528.232427-1-jiayuan.chen@linux.dev>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261023104528.232427-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 13:45, Jiayuan Chen wrote:
> arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
> entries. In the loop parsing it in bond_check_params(), arp_ip_count is
> the number of accepted targets, while i is the index into
> arp_ip_target. Invalid and duplicate entries are skipped without
> bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
> past the end of arp_ip_target, e.g. 16 targets with one duplicate:
> 
>    BUG: KASAN: global-out-of-bounds in bond_check_params.constprop.0+0x1148/0x1440
>    Read of size 8 at addr ffffffff96e9ee00 by task swapper/0/1
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x91/0xf0
>     print_report+0xd1/0x630
>     kasan_report+0xf3/0x130
>     __asan_report_load8_noabort+0x14/0x30
>     bond_check_params.constprop.0+0x1148/0x1440
>     bonding_init+0x13/0xe0
>     do_one_initcall+0xe7/0x5b0
>     kernel_init_freeable+0xa91/0x1120
>     kernel_init+0x24/0x220
>     ret_from_fork+0x5b3/0x820
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
>    The buggy address belongs to the variable:
>     arp_ip_target+0x80/0xa0
> 
> Bound the loop with i instead. arp_ip_count never exceeds i, so it
> stays within BOND_MAX_ARP_TARGETS too.
> 
> Fixes: 5a5c5fd48e3b ("bonding: arp_ip_count and arp_targets can be wrong")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   drivers/net/bonding/bond_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 09aa45d71fab..7019e5d8fdc8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6273,7 +6273,7 @@ static int __init bond_check_params(struct bond_params *params)
>   	}
>   
>   	for (arp_ip_count = 0, i = 0;
> -	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
> +	     (i < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
>   		__be32 ip;
>   
>   		/* not a complete check, but good enough to catch mistakes */

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

