Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2A3E6DD0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999550; cv=none; b=BP42yR+v+HlRJywlEOAwn5FQjdcAVo7bd0CcNnnFZDJNC8LUtVIcs7ZqpJh1I1pF59Lo4SRSN/XHJjbTHZGkuN9FAHwikyxQtFMCjaVa3GxqszsAlHbKCZBqMOEs+IRjev3GqmsTBmP91crFJwn27yK0s7Mub5qdsQ86PAMeji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999550; c=relaxed/simple;
	bh=4cN4Y3/AR03nrzR0g229f0U1Uh+kR7Tztj24GB4mNpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxE2MoDWQOyWlJ0X3xP+eCLrKCNQYd9d+9LSKgJ/rjpa4ygtTNnQJozzIZafAkgiwSfsBHDbmUsgAOWlC5zgBaoGSyeMrBHfKhnvrzD1kCbDpDxfTlyGz3o8l336uds6lw3ExmEvAYdKkLdh3MNu5hcYJHfCR0Rqy0oXdXViJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUAgRNzo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+NCfj7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUAgRNzo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+NCfj7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780999547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCNN8gCJd1DNwT/XGDvIwg/vTF/4bSRJ3cERpaMok5w=;
	b=PUAgRNzoPSSu1Rmzv4oCJsoC2NBxEQcMemhcHPIMeE+EAdfkF2AKFvtFVr43Innxa724qC
	x+evZPCZ7sMG75BKy82hCw5i1AFhtT6sI9rEPI7huor2lPPiiACgyqF6zGk3UYvjFJ9Qph
	J96v0GJIDU8ccFWRHG2ap+YrsjAveFM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-XrDv3WfbNnKCKVjqnAZs4w-1; Tue, 09 Jun 2026 06:05:46 -0400
X-MC-Unique: XrDv3WfbNnKCKVjqnAZs4w-1
X-Mimecast-MFC-AGG-ID: XrDv3WfbNnKCKVjqnAZs4w_1780999545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso3208680f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780999545; x=1781604345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCNN8gCJd1DNwT/XGDvIwg/vTF/4bSRJ3cERpaMok5w=;
        b=c+NCfj7Z3RfKfooHcbEzxgk+Km6bkpLifVYu30DEAhYQ97SE4hs9sxMw7qaJ+dDwHW
         YmsB+5e7pcIZAR+ZEgB8pIRkgC8uvlZYLOPdCfCj/9kJAUGyt2tJBqR+k+sP5/2bUdPY
         0sKX9vFizQq8qyuMAQASzlRC5nRjEJp50JLVTslVmIJHofrvyIQ6ziWrmOBa86zb5L+X
         UwvvpasH+vfZpwueBa2HYyduCCZC3iztV1TJO2FcAVR+sCtNWqFJsAlGY/KF/M4xZFHg
         nV7HOrAevTtQyL9kBiWHDQ8kNPJ/8FRyDPlEtkBCu6UajRQYQvHzk3CSbu1O2Tx8tySN
         Igdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999545; x=1781604345;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCNN8gCJd1DNwT/XGDvIwg/vTF/4bSRJ3cERpaMok5w=;
        b=H7hCLt1h+7av2y0f5Z3rSmiN8GLoKLaH0WlcPwwOeCspVzvqTShnstZVeXs2F3jNAF
         lL1nl62BbIZYl2vx1l2x5+dcNYq1jO1Tb9ap1WYKHXcKIT7+91PH9HCzkI8m7afADoXs
         uiFpBLs3ECcKQhq1gC6oXhc/bIWz2yT+KANkek5h+2MCncsBmbkUYBCe8f8pr0rtfh+E
         zUYv91KSYf7fa65r/h+V56sTszrrznCDYmvnZf9Guw5NNqJtqQAc90jQuuMy6HwVPjCz
         K7HJ9K6TNKckxV8dLMr+ERiPmKMTgq0kNxvQi72CkSHHYjncGkQhDmuQ2s7OPFyJ63aZ
         ZwVQ==
X-Gm-Message-State: AOJu0YxjY5Nu7pjGKPdqLu0CWzM/BEYewZ2BE5HxbmPFjBkPYOHafqtt
	O0z1VACIT1C+FLcnGo0g+m7qaN7aOvpNcs/S1gIR2mAnYAVd2XeYvQtMaOX4l4MfbXDazNacvSY
	tHRJpvRY4JWgsra4L2JbQXAU9mSyRyFb9KEaflSwooOPRV1QcPoQWRc3KMw==
X-Gm-Gg: Acq92OHRL1KRlim9L8hFTZk0DxuZdoNPoitPNEEc8RKN2kO/Ue/+0a9RkXLpIaznexI
	JHcUR4XJ0ohMrOUukRRjnoIVb++q3HkS5i71zVQGeq+W1HIN56L+R3wJYZfwlQLzEt0Do+ZchnB
	OMptiYbwulghVROVgFexo/1Tfvh6oP8il2IwA8puY0ft6h4I0X4liZdUVe9dzcuFD7r3Dfwg01Z
	U24hpr5HoowoGgvXRYJZ918gbYaXlCXuE0TlMVOWmlCuJE75/Sre9qREOXDEgAQHYZRQiRZuWjw
	a20R0VYw2pPLS8WYZNsnJLOUSWis8CKmrs1n8TKP23hg1KOvmAYC/jhPNB/dsLhc1bW6b/JIrI8
	39sMltTDK4nMkNabQ2xEDZZPoFmaWSwJoMWhaez6/SQKvW7CocP7ihppdEpUzKQPPVw==
X-Received: by 2002:a05:6000:12c9:b0:45e:73eb:1ff7 with SMTP id ffacd0b85a97d-460302dccd4mr21430708f8f.3.1780999545038;
        Tue, 09 Jun 2026 03:05:45 -0700 (PDT)
X-Received: by 2002:a05:6000:12c9:b0:45e:73eb:1ff7 with SMTP id ffacd0b85a97d-460302dccd4mr21430656f8f.3.1780999544507;
        Tue, 09 Jun 2026 03:05:44 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm61226960f8f.2.2026.06.09.03.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:05:44 -0700 (PDT)
Message-ID: <455e779c-9d13-4f9d-9cf7-3b639e665743@redhat.com>
Date: Tue, 9 Jun 2026 12:05:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
To: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Howard <lukeh@padl.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Cedric Jehasse <cedric.jehasse@gmail.com>
References: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
 <20260604-net-next-mv88e6xxx-cbs-v6-2-b68c01142d1e@luminex.be>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604-net-next-mv88e6xxx-cbs-v6-2-b68c01142d1e@luminex.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 3:44 PM, Cedric Jehasse via B4 Relay wrote:
> @@ -5679,6 +5686,27 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
>  	.tcam_ops = &mv88e6393_tcam_ops,
>  };
>  
> +static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
> +	.rate_unit = 32,
> +	.rate_mask = GENMASK(14, 0),
> +	.hilimit_mask = GENMASK(14, 0),
> +	.queue_mask = GENMASK(3, 0),
> +};
> +
> +static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
> +	.rate_unit = 64,
> +	.rate_mask = GENMASK(15, 0),
> +	.hilimit_mask = GENMASK(14, 0),
> +	.queue_mask = GENMASK(3, 0),
> +};
> +
> +static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
> +	.rate_unit = 64,
> +	.rate_mask = GENMASK(15, 0),
> +	.hilimit_mask = GENMASK(13, 0),
> +	.queue_mask = GENMASK(7, 0),
> +};

Sashiko mentions that the above masks are not consistent with the switch
datasheet.

I'm quite surprised the LLM could check such fine grain detail, could
you please double check if the comment makes sense:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e%40luminex.be

?

Thanks,

Paolo

