Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518B282F0C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668063; cv=none; b=rBp+MnSiiyCyDHBbkg0CsijAmEQO4+4ccV0aCtn+zoBkWgl0QUHxuQ9zwm2WlLaZfymBbD2GZVhCn2yFNHi58DuQUmu1b0I6fQiP7oQctnQ/LY9x6wVaaQZaCfgWd/g2Mvi51gVPfwQq4gptEMlhj+RkpEYlvVp3w12BB71Eae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668063; c=relaxed/simple;
	bh=vbdqrXWY4CyJpnn9GW4KJe7+dQHcMsKTKPKoat2RSTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYsSqGm4LklZBAWJxvHxQW8w7cfwpt5nqxvyU7rKcM3g13eftc9Tu9sAoxVbi5yYZsfVecvRiT9pFEX7LO/VaalGfwmn+e8VcSpwXNRC4k8WhS3dmJg9AVRrYPs++KVpLMc7lRRtT6EmGgYB5YQCaGPnPOZIC/7sdCU1yTsZixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lt0lb+tU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j5zFf+G0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt0lb+tU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j5zFf+G0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790668061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uzilgvLBZH74b8AH6UXHYXnoUwzaK2w0lHwSmgwnMw=;
	b=Lt0lb+tUTcMcHiRyjW723Q4znseYlryjgK/kLBIoDo7sXPOY+blfpQeQq5V2QOdC6EpiMj
	YZKp+6uCPWWfIMvT0yyScrSTV9JqXL1ZLs5uoecLYldgzA2AQAp7NCerREU00Aaxm0K1WG
	VxFyMb99LIONdjjL0AECR7xvm21oq+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-7dpserK0M4i58HHKs1JjzQ-1; Tue, 29 Sep 2026 03:47:39 -0400
X-MC-Unique: 7dpserK0M4i58HHKs1JjzQ-1
X-Mimecast-MFC-AGG-ID: 7dpserK0M4i58HHKs1JjzQ_1790668058
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-488872aa05fso2842535f8f.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790668058; x=1791272858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uzilgvLBZH74b8AH6UXHYXnoUwzaK2w0lHwSmgwnMw=;
        b=j5zFf+G0+TuXX8PZbobuGmqdvoz6M0/pKY3LAQXFFqYG4v6u7KmmvjmPtl4uDwc4Qa
         xTsjhx2lD13MhyL67qGdcejrph5cAwlOk7/WantmBvxy6dDGJWCZ4QzV/pZNmX4yRNL+
         cUOnCDYBlaLu6rhUbWFjyqHzVvjSUNBym4L3o+/qfBjo6eoR4mtusNMe7SoQRilBNSk/
         kPpFzxrBafXwJrHwCT4npy2obJ9WDJ/LVPJlf5FROBfsMdxuxVjy1QTaMzBtMx7FTVKH
         PNoRYLZGp/yOae8d0lq1/hPkDSqGL/qsCFkeH5CwBMdX+jozkiXmTIozbpXOGOEr5whQ
         GpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668058; x=1791272858;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uzilgvLBZH74b8AH6UXHYXnoUwzaK2w0lHwSmgwnMw=;
        b=lgJO0SLd0Q0cUWVfvdEYJZtrmw+NtmCzDPHY6A/Lr49K/1yT2d8o0OC2qOqg5nDHSn
         hGxt2TMUuDDyG+Te55LDJJPuOlg+IGhoHBTN7m+2oyWv7wd0EinqsYi7N1JBmZ2K5VAz
         auNdNsjdansKk04L5NXGTmeKQmvvrS042QQIOK8+HnjPo8m1SfVa/0DHE6deZ/ry+iRR
         ngNSWuweL5pAb0rLO33jB8bAiGL5KRjkg0y4pPneEO/9lXTIyt5wSWWmImA9d0xfbj3y
         s0BRjln4LhF/6TuyYr+NIBib53HOAp3qUywOw3dcThpYBYQ6DVVKKbKcfJv8lHHUtoFZ
         E0Yw==
X-Forwarded-Encrypted: i=1; AKwUvBwCNKaATI5HDbBDrfks34qoGjxEGtDvvEdFOYUe4lwu4biNegQFpf/yKzGrfPLF0uTJ2gLYveY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIKc3LtxJ/YfMEGAUXRQIQAZrRSSd0nGJZJzSlX3sXJpMEeCr3
	bZspWme1TXwbZGuUkMoKn6gON8no0dAiVrmu2A02pw5ywZlr8sfMdqflh0ZjqQoq4qzpsng2UKG
	5WIOnCiKKRFoVx+iV5yiNG4j4VFL6dDEUbF/2GBsq8Q1pM1uSHdL2G+c07A==
X-Gm-Gg: AYBFou31ALYFIuuPtYHH4IALH/GV/EuS3wK0Q8xAWEmOsUoPGz0P3B0Ph5o+BjahKlC
	8grH+vDs6X5fPa5v5+m76+m727JM79pZOYB9Cog0LGYlX0t3mkFwRVm6NobbJbmzPmKUSSDU++j
	pG51o5qcXgQy1XYl+QFwMRcrTybrfWy4mYBp2GjwFjhgB9pLYgI9uBkqhX307VVaFujabtQXpjA
	qGBpD2qcq3sp3Rv/P6QWO3F2mwnKBiQT66pMIWfE/ueOy/G9x57GVt6Jk4YozYKhRbm6+5w4bjk
	zpXCd3xeio0az+FtDJi+8uiCLL3EwctL3+WUDpopeQTmxB/BF6CVofL4oYy4iTMMzQPhg/7OIkq
	zcDrv98Ejsc9/LpRavneaCof4d6ESB3J5j50EQGl4Nz7iDf68C60zo2NEMmKqQMYN/NA6uO/LDw
	==
X-Received: by 2002:a05:6000:25c8:b0:488:8384:c382 with SMTP id ffacd0b85a97d-4888384c4d4mr16985158f8f.49.1790668058356;
        Tue, 29 Sep 2026 00:47:38 -0700 (PDT)
X-Received: by 2002:a05:6000:25c8:b0:488:8384:c382 with SMTP id ffacd0b85a97d-4888384c4d4mr16985126f8f.49.1790668057948;
        Tue, 29 Sep 2026 00:47:37 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5056a16sm1841471f8f.18.2026.09.29.00.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:47:37 -0700 (PDT)
Message-ID: <9909b6be-5f32-4a96-b0a1-39afbf16fdeb@redhat.com>
Date: Tue, 29 Sep 2026 09:47:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] net: core: factor out the GSO device
 limit check
To: Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, keyong.sun@smartx.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org,
 Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>,
 David Laight <david.laight.linux@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-3-wang.zhan@smartx.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260928044102.1004310-3-wang.zhan@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 06:40, Wang Zhan wrote:
> @@ -3922,6 +3926,11 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
>   
>   	return harmonize_features(skb, features);
>   }
> +
> +netdev_features_t netif_skb_features(struct sk_buff *skb)
> +{
> +	return __netif_skb_features(skb, true);
> +}
>   EXPORT_SYMBOL(netif_skb_features);

Nit: I *think* that moving the above to an header file and exporting
__netif_skb_features() will generate better code, as the latter should
not be inlined (large functions with 2 callers in the same compilation
unit).

/P

