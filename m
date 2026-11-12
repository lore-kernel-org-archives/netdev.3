Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471944;
	b=VXVB7JQ3BrsLwzA+RN6da5zb4X4DInzQtTTNYNtPzM+whAN/bHAwCPl3wCiKTBNWcrji
	 cgUbiU2+zgTJobsfVHHi6X8s+ZAeGJATM7yN0Pi6ZixPDaWcQRVEeAkRt6mthNMHecWDj
	 Z8YZ9bhRtFBE1TraFO8VH8SEgbq8fCNCkBJHFvb9AiRICkypa0M6Q8LLjPQarkdip93VG
	 1WYsZqEcS6a8WriPjLg+r87VprbS7GWklx4EqwBvxRVKnbDU9Pk6R6UDDC4yAfR3VnnuE
	 3v8H8a7sB62/3zEBoCsVDoFsHAM0L6g+IYSLAgLdW/uX7644LyJBWE8LCnhyqBDwa9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471944;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LPCy+z0w9PTU6iVc8q6WjsQJyzcLfP1PI31Guk/FlWc=;
	b=3qysHls9ADRKvMwBy2oZdlBPkBm6pDIcb91imHn2BeazwuAmJYOp6wEr6i4mwNlDgO2C
	 nJRaNF3MArSHtkJjsR7AqrRItzLfH6gzwVTulgJqcIfX5M/mDYTfygci6xYweqqdpwRbd
	 vVPs+7hkhQE6ZSrYwJBim5bKGyimz70JeIFNLP7tq8Rj90anUck90ex5fqrphv8W03c5n
	 subzpXz4tBHdQOY+YQhHTRRfL7t6XG5sfHCo9HsrgcGWjVPTPcEwgsYTt8bLFM1aVOVbj
	 AB3jUJEdKeN0F7w//ze1Bps3JmJCx/2Q1afA74za5xXlLW9tU9RzqrMh785O8ynC7xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=USIa0HPh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HpDVyfKa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863EA606A899
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 863EA606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=USIa0HPh;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HpDVyfKa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794471941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPCy+z0w9PTU6iVc8q6WjsQJyzcLfP1PI31Guk/FlWc=;
	b=USIa0HPho8coS8V+HCfdMElmSfJiRJfjsEFWC/6DQvn465K0BLOIl34F85Y+WBD21Kv4/f
	xEGciwGNTwTEXjINl2TCdZXUiLBFc5gpwHb3szwS6yI8l4nIvCaOwzuTu5PwDtbPKv485W
	QckC4WWNOFw7WOx2JiOeB5NqzqZ1N+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-nF2KOPVfMiiFXBQnLTeacg-1; Thu, 12 Nov 2026 03:25:38 -0500
X-MC-Unique: nF2KOPVfMiiFXBQnLTeacg-1
X-Mimecast-MFC-AGG-ID: nF2KOPVfMiiFXBQnLTeacg_1794471937
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so2997468f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794471937; x=1795076737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPCy+z0w9PTU6iVc8q6WjsQJyzcLfP1PI31Guk/FlWc=;
        b=HpDVyfKaQrovrXUj41MHfxK7V2DJvBLgMgy0AlNpVxuK9tKfAQ3L6pojjLnXyGAYuW
         IOPLHv0WMJOt6Q8j73Ow79pi26kDqC1v9hC6y51a9h4kmZ0bWTvmT4ZwmxWY8MyMe9HR
         cs/9i0ZVYh3dVF+CT119oqvFAdCdBR5Vf2mofZUfrMGTPtU7Eh9fKfPOMoYDhA6SWglC
         FGJfKJou4A9tP6rwbHKneCbTngGrO4WDR5Hq7yK97spLLoMfNLPvXlYQnesE2XbZV3ap
         RAzWWOO2ToRZtNPZkXKWW22go9Wt2x3p70FBPubogsrxGZweY751zHitjv+Dqe+aRwEV
         FCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471937; x=1795076737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPCy+z0w9PTU6iVc8q6WjsQJyzcLfP1PI31Guk/FlWc=;
        b=VltE/1NfGIHIH8o1k5OPHkPsAN9LAHtNQdZjct+xPjoYTcGp0at4YNjjFZM6jNDMli
         wrxmaAL7jRq3Et0+5ozp1lOr8hfiXLNvpbymeyRv5pr6KICYZ+ehh+Ii1yPjjq4V+lmH
         QpwDw9H9ICy/ZEZRjldE1iHhkWQNMBrYHVfy9sMGb9t0ZGaMlthkyVvZJMniOCeaKLPc
         gNQA8WfSzm+P5ioXqyesiZNscPStlEtfOnuhzsLufjDgsBFXXksqSYgZEgCC7ACOhG+X
         37bpdBY2/NVx/BT2oof0BLJuSBP1CXbR/C1ziKvEGTQaN0oVBydsIyzCIlqw6MN/i60T
         xUpQ==
X-Forwarded-Encrypted: i=1; AL+hErEMOHVRpEvAVumqmz7mKHhnETV0AsPJFOxgmJk9QUIlTAMHHrLktjH+SkxbIBFnrPnMWxyMt3Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CGugfAdwLOBozpxOMNZOliO8A5loUiDKiE6l7y2xOM1dSv8BY
	qwOy7oNGHKbeFk7IAlUfS1uSrFsB0Bab1y9r9pw9Kr70ohuuZVnbFBvmSITNX8/cl9w9G6SInEB
	qRxLJeQ5se2aqC5zwvZzleemqrCIWj5bvgkF4YbdiMgJpvd0NPidmDt/DgQ==
X-Gm-Gg: AYBFou2NmCKkuULueFTTfks949syAzyYxcSEViUB08t8tDw5D+wRcZUAcILxR0a/mn5
	7pNBgnl37U7l2LzWOqR33ZC0Ix16o4weQu9baD7pXLKyDX2SK69OJkLfWR6OaXwrmZPV8FDIJdU
	c2KG3++LQrQ10E81xqbbkdGZiihtqNZGMuFDJraxC8cfN1ViGpCLh9Uw02uMX+5/ivtOg/D2dQh
	adH5rYKDWxftqoX/yFhMvfksDfWzLcvABZ41E0j7NWidxV81emi660Q00iHuMIeVgYLj08BDVeB
	sq1yhj54ecpdrNa0A1cOmveJ5FXyR7eIxUipGxfjWPN7zSQ+Mjugm6Nir4huup5izPJdAXz1KSa
	3C0yIV6uzn4BLDijtwDS7hqxM91/hFW+ls9cjS24y8INnIhO9bTyoTrAOq+E+XQvlxDNFZS/fL8
	9NEXUlD2WUnFzFQqWaZdjb95QfhvUmptJgStFNoT6XuH8y
X-Received: by 2002:a05:6000:2310:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-499c69ca8b1mr8604168f8f.14.1794471936667;
        Thu, 12 Nov 2026 00:25:36 -0800 (PST)
X-Received: by 2002:a05:6000:2310:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-499c69ca8b1mr8604117f8f.14.1794471936155;
        Thu, 12 Nov 2026 00:25:36 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49884b99869sm14313091f8f.4.2026.11.12.00.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 00:25:35 -0800 (PST)
Message-ID: <1b764043-2efd-4e65-adb9-a47c0136446b@redhat.com>
Date: Thu, 12 Nov 2026 09:25:34 +0100
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
Subject: Re: [PATCH net-next v4 0/5] net: devmem: size TX net_iovs from the
 dmabuf layout
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, leitao@debian.org,
 dtatulea@nvidia.com, asml.silence@gmail.com, bobbyeshleman@meta.com,
 daniel@iogearbox.net, razor@blackwall.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261111224740.2744522-1-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261111224740.2744522-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A few (late) questions/comments to check I'm not missing relevant
points,

On 11/11/26 23:47, Stanislav Fomichev wrote:
> TX bindings use PAGE_SIZE net_iovs, so a frag covers at most a page.
> A 64KB skb needs 16 frags, and MAX_SKB_FRAGS caps devmem skbs at about
> 68KB, which makes BIG TCP ineffective for devmem TX.

... with default .config. You could set MAX_SKB_FRAGS to 45 and reach
~180K...
> This series picks the TX net_iov size from the dmabuf sg table instead:
> the largest power of 2, up to 2MB, which aligns every DMA segment. With
> a 2MB hugepage-backed udmabuf a BIG TCP skb takes a few frags. There's
> no UAPI change since TX addresses are dmabuf offsets.

... still this option should be more effective because the limit would be
higher and the skb would use less cachelines for the shared_info,

I'm wondering if making a comparison vs MAX_SKB_FRAGS==45 would be
complex and if you could do that, too.

> This doesn't make skbs larger. TCP still sizes them with size_goal.
> Only the frags get larger, and a single frag can now cover the whole
> skb.
> 
> An skb stays under 64KB unless BIG TCP is enabled. With BIG TCP,
> MSG_ZEROCOPY from huge pages can already create frags of 64KB or
> more. So drivers already have to handle them:
> - mlx5 has a 31-bit length per data segment
> - gve splits frags into 16KB descriptors
> - fbnic doesn't enable BIG TCP
> - bnxt has a 16-bit BD length. It is broken for such page frags today
>    and will be fixed separately.
> 
> Tested on two mlx5 400Gb/s hosts with kperf (udmabuf, 32KB RX
> net_iovs, 2MB hugepage-backed TX buffer), series backported to a 7.1
> kernel on the sender only. 1 flow, MTU 4200, receiver tcp_rmem capped
> at 16MB so it doesn't drop, median of 5 x 60s runs:
> 
>                                before    after
>    frags per skb (sender)       16-17      1-2
>    throughput (Gb/s)            208.6    211.2
>    sender sendmsg CPU (sys)     40.8%    19.5%   (-52%)
> 
> The receiver's CPU is the bottleneck, so the gain is CPU, not
> throughput. More of the transmit runs from the ACK path, so the
> sender's softirq grows (52% -> 59%), but sys + sirq still drops by 16%.

is the receiver using GRO H/W offload/big TCP? Which are the gro_max_size/
gso_max_size limits? In the `after` scenario, is the 2nd frag used for the
headers?

Thanks,

Paolo

