Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274740;
	b=5dy0bkemJDM9iBdIyrasPRM8LsNwQkJpnpxPOXPpsinkfbCAa8b1PGt2On8DUKZ0yvHV
	 groWa09732yV1gCoKLjsGLhhTplkTE6IaUdxKHuZ/yrx9pL1lOlvQZv8zRrEGklE8ZILe
	 X9yJVVegpnI1ZkdXqG1WU+c+7K+nAUgI1GJmFY1GE7t9JqiZbYtsh4GoqL4RZ2p7zJbvo
	 oPVET4AP/cuiBnXYkBaQ1st8Rzxr6oBydnIoIlHf/frnI5zxt9M4+8+z81o8DBaeChugw
	 KH4z7HsxF4PXLisi4yJSAgHzDDw1yKYk4/y/eWUJEe6TI1zLa/iPoavRfvdSmhV3eaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274740;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hc905M9q4LEkI5HIdNGySZNyIziGO7ISCoqRtqFWyCE=;
	b=mMJuEvZ1olml86KV/hpRRMWPBPr/qMQrU6AKGpNELnJkhyou1RYKMPchPkjuZ+Ajivbc
	 eM3BuHR1nfK062/YFZj5aXVb19sZ3ZoHWgaRbu8qiZhaPlCikCfJjyIBE81DKeNdfZC/9
	 lYZlY9qBrzfem5lwOwbfc25b9KgHaAVVHLGnzgnEfO7n/GAlLq4KcbBK/45wQ9KpyA1PA
	 2MK9I9OM6cD1/OMC6gEoAmGQAUBALeGGttK3WRxBV5A79BRrvvJlqBWVwGV7YIwVVELdX
	 a9lZP8k7JoWU73p1i/Ovc3TyQU6x6tye95EUI+6srnVA5kkl1F7NJlh/hNoQ4DlUTSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VQ6HLXwt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nH9A4HUf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E00606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VQ6HLXwt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nH9A4HUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793274739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hc905M9q4LEkI5HIdNGySZNyIziGO7ISCoqRtqFWyCE=;
	b=VQ6HLXwtnNGWou0kG5Z2UF1UA8o9FFMias2ZOl/hEET5jU3x/E5+SEwNoeX1nka0jhyiWy
	dBbvqup6fIZrOkCsvgEZvEzHj+olIs88EghojLzV7WpG6mTduV5arW+wyDp/0s2G/YgL87
	soLbmW5EaKP2lSEu090xtR0lmyw+Jqk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Elvr8EJTNPKpBxFUKlqv2Q-1; Thu, 29 Oct 2026 07:52:17 -0400
X-MC-Unique: Elvr8EJTNPKpBxFUKlqv2Q-1
X-Mimecast-MFC-AGG-ID: Elvr8EJTNPKpBxFUKlqv2Q_1793274736
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48afcecb035so194744f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793274736; x=1793879536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hc905M9q4LEkI5HIdNGySZNyIziGO7ISCoqRtqFWyCE=;
        b=nH9A4HUfPNbHXYmr/mskVwAc2jYfk2GWFOZyvt+VdhPZcMomuWJxuR/BJU+LA/N7au
         0I6wXoIBY8vqenSBfNadJffASNTwtfawEgRvIXyolNXu3XZ4pKY3A8flWvhUllEI92t5
         KwxeDh0EKH2+3LvrJX1I9tCYzedkGyjm4zvCYmNXyWgTMtya6iPclP54fOh60lqSShb2
         rfEbHvlSvjpmtfJ4dCvVdWb1MV+oGqB9aEw75wQEC8wg67B7tnCuMnVrpnPHnuFMBMAJ
         d0yMmBW9lLh6P3D4KDP9aeqHiespHVxLnTikUlQaXUf2e6A7L08bClpJQ7eYOT9aN1wZ
         yF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274736; x=1793879536;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hc905M9q4LEkI5HIdNGySZNyIziGO7ISCoqRtqFWyCE=;
        b=Jqk/KbyiIhQM3Zh4N9vpXZb06nBUcwxc5W3GCYECtj07rR5bm0XgrWjYpGOZOZ3ggQ
         jKxIWVLk+wef1Dz0yL66GkrKInXfl74o4aqOpMCQwKgqyiJ49hDR2IHKMlfCSoHukEJr
         yQvu73stOTltHdtWNsjMQHUIjVCgSF7ZiQQJC9408d79pJOnTk2g4QI0B8NfkfLMM82z
         wvcaY5j9BZa5NaqvrO9JV/exI7U0PvbhZr7Z6GpYXikbCY4YCMRlumcKbpG5TXZlYP09
         //ZpuaOb7FVadOnb9NR07tl/pRZ949IJLzUWsQDaoyF4KmHCaYAtOW1U/Qzsh2k/W8S7
         WRLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWHaV8ytzi9JlBoVQFAFs+m5B7XSCxIH7vmUD6pfe8rEuV31NarbuLSBnKWJhCTDMd+lROFSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIO89D8Aqo0hS8BIVwjPQSh6oT9GYh3ooGkI9oswBSobLvWK+t
	+576EkS5TbOIicVg7A+e9bIFa7vW7qV3thCsMkp9B9S4uWCPSy5L8qlq5TTOpkosFk79wjvia0O
	XTCe4u68t9DzqxzOVh8NL7O5bfcfYP0vyrCp04yh6l4IGeovMma3Fq21Jxw==
X-Gm-Gg: AYBFou2A6XVXen3iplvnuyccmPMcvtubyYUAC25Jsq3nUDILPnfmtxYtZ9mUsYQqxDf
	bwOkdJtvXhxU9+sl6D1hz3Q/4kdkLlkJ6G6Qvi8u0KnKoYHFfoj6mX9pPRP+WYqMwMBPQ48N0Lo
	31llYK41fLllp+K+UejhArStG9MxlL8vIpeEYmrfH3UvOdX8rxZ0qPRpbMxb8h5h+TtLBqgtu8T
	/PBw6cvW8Zbszt9mDtpTwqKXBuW8bmJN31PolfoHm3z6dZ9z0MtzATyJWQDXl7w3IhK+eX8HBJi
	cQEmQJ+6hOKCWTnm6zl2tNjamyqBdqZuAof0H51NqJ5SeHUeWFb8bAEoenfktoOO7PkmAeLdDbL
	4hqVpTtzoNwq6qR7iTeNEFbkzwjfcjySAXXyWPrvebfU1zLwTqHbmUpJTVDu7jFqMk7PWEdyMQd
	/qk5w1fEY7oOzttP0n9XWyffMZ9VhxVEDNdysT67Y/bag/64E=
X-Received: by 2002:a5d:540c:0:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e64ba60d3mr4693973f8f.23.1793274736356;
        Thu, 29 Oct 2026 04:52:16 -0700 (PDT)
X-Received: by 2002:a5d:540c:0:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e64ba60d3mr4693928f8f.23.1793274735834;
        Thu, 29 Oct 2026 04:52:15 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm32615874f8f.56.2026.10.29.04.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:52:15 -0700 (PDT)
Message-ID: <bb202893-9fd5-4dad-ad69-9f86dfd91cc3@redhat.com>
Date: Thu, 29 Oct 2026 12:52:13 +0100
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
Subject: Re: [PATCH v2] net/sched: sch_cake: skip redundant cake_mq rate
 updates
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/26 05:32, Shubhang Kaushik (Ampere) wrote:
> cake_mq periodically counts active child qdiscs in cake_dequeue() and
> derives an effective per-child shaper rate. cake_dequeue() currently
> reconfigures every tin after each scan, even when that effective rate
> is unchanged.
> 
> The dequeue-time call chain is:
> 
>    cake_dequeue()
>      -> cake_configure_rates(..., true)
>        -> cake_config_*()
>          -> cake_set_rate()
> 
> With rate_adjust=true, cake_set_rate() only refreshes rate-derived
> state. Tin 0 records the unscaled rate argument in every supported
> CAKE tin mode, so its installed rate identifies whether this call chain
> would change any state.
> 
> Skip the reconfiguration when the effective rate is already installed,
> while continuing to update the activity-sampling timestamp and
> active-queue statistic.
> 
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-instances of cake_mq")
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
IMHO this is borderline material for 'net'. Was any regression visible on
top of 1bddd758bac2, e.g. in term of CPU usage?

/P

