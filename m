Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098346;
	b=Sc44c15hVDfpfXzGvzPzgA6oYVYsUMae9pup3BM3bvlXjiuAMejIBmMWAaBnUEAIlBoD
	 zv1aWxq0rDl4R/3eRb8QOm2C/Qp4Ro2aF2NnfEFs4CFRjudSePrF2HOqZRbN8UXpq0uKU
	 apRpI9YWeyxXTv2teBV6DC/bMK0VjFPVq29RiiqZLLcD63fwWPrYtjQVw0F7pIxG9B+U/
	 P9SqQpjUzay26dg7ln0GjCGJfjjKNBy3dT7mCS7g8wv3ZW8v3ya+ilpIU1YszIkUMuV6b
	 o3wLmSsJI7TX0DmXVVMk26xdbl3y2px29djGoL2neLxA+AKMD7tO0z7GeLwZu3/ZBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098346;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7e6/6Av5OLcomxyHINzFSQmyaqcc/j04uE9LRdGFggA=;
	b=tDpi3iwgfyT+WJQxRzsea+YTRGAg6UFPWf5vGCYFLaGIpFpiMgwteFdyl89nXzDz4PTg
	 lO3er2a9pDzpANfhyxXLYRDDnQ3+bF5jg2inYr3thLYNmpCvU/MJ7INEUSLkIiPdsqvzX
	 sBTljNOp+VZq51Ka92dqxn+ReAIv4PrLVl3ZFgze5ZH7fX40n4ZSvw1yCJyeLG8Cacp94
	 9N5LNqz0IkrnmlsobwJhxMOCZIutWmd/oLXjFiOZBFiq2riIq+UJGzzZsc6dH69ngtkUi
	 BtNqXefGWvQq4GJ45U8iT7EiQPMUqhHwOqIcUk1e1YkX9uj7kB5YvNhbrnxHgG0+nJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FhQAJgVP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="iWbDY2y/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1F606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FhQAJgVP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iWbDY2y/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793098344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7e6/6Av5OLcomxyHINzFSQmyaqcc/j04uE9LRdGFggA=;
	b=FhQAJgVPbDZRi9hKi9Mg9x4NS/Xa48PpXSzH0+ft/wMGElnnwqD3H/FrmWQtvNtez4i9pi
	IczjHywwm2KqEUIWLufYLA8IHP6rJWvb0jS63UGBMgsSRKrPaX+1rZViYlAWhqBFADecro
	Dyc1XBtXahd3oFrZxiCvVZEh0qjpTh4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-FWVYXndEPNan_goviQ3ZBw-1; Tue, 27 Oct 2026 06:52:21 -0400
X-MC-Unique: FWVYXndEPNan_goviQ3ZBw-1
X-Mimecast-MFC-AGG-ID: FWVYXndEPNan_goviQ3ZBw_1793098340
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a20a40d3e9so25594415e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793098340; x=1793703140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7e6/6Av5OLcomxyHINzFSQmyaqcc/j04uE9LRdGFggA=;
        b=iWbDY2y/lrb5r0tToqGWeyNb/q+N/ImUi5W8GnhH52xqS30Axa4jTFHjyPlODT7nAq
         7giiWi6h1IWphtixZYGO+Y5KNCT73L5ZMUsee3CcDCFvLKFsmOPPONxGs3OGh/kvJvEm
         SBi6dArDMGPx+JQjnkhqarombPZ4esV3ckYQ1kleXj83RCwIn1BzLT60KAW+jkrnXIC+
         8xtc3YRuTfLfa4I8fVzVgWmI6QugM+B/rOuISFus1KRQNj47+jv3ILzLW0pyfwgui+gT
         ICIDjldEPoKw4BREmFcdZPeIqKdFcRP0FXWXidm+p5Rfq6x7XuvAWiRSNgYZltRJcjqJ
         xQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098340; x=1793703140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7e6/6Av5OLcomxyHINzFSQmyaqcc/j04uE9LRdGFggA=;
        b=wMVJoLNsJZGa4XUsISEkvbnlcPLL/OiIAJKQzM+7y5NSF6Ik230zfEBWTLqDCsd5zO
         1paNcCvgkt7+F9v2U1SCnxPR9rjl5IZrwLPm9PYFZCFnw1Qnv0rwCPHEm52ApqKn8djL
         fYoDlrTm4+wGh+fTOLPYPoKlwYvhqpLFThSYkrRCNfcw79V3LcTVsyyyYRBH7R7mGZrb
         fo7lSdHbEza44NhmR2JjeBOj4u5yafq7GDfXPiAHo8F41znLewS5MlhxxNHHRJ3WEDLS
         aP4fQmHTIDALiGCE3AAf4gKBZMtX8DL/XdFyqkx3dXZcYMxKEsrXkHOyIDUQnrwG0qok
         iLNg==
X-Forwarded-Encrypted: i=1; AKwUvBz9YgoahM7ALVuVzhx3Gf2hQ+J2kiaTwPIdAreBVi2dx/eWdFFV8Ep2yCncDU+cjVDmZwVDzFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3/fzI1FFhlzpli8Pk0wCBlUuEu8mAmo7u77JkovMg9HTk28mS
	dJ35+QlIIry0PfgH4sKF1LAQ6BoSLoBOlchWD5bqbhGxKUgM9Vqanxls7/eiNnJ0j5O/QhBt7lq
	qKQXf88Yr37QYF1xfXbTP7KwPIS3+Ox19Sg9NhC2xaOTACYlRH3APBqWqQA==
X-Gm-Gg: AYBFou2jNCE3Lex7E+RLXANDTDF0ozTil0bCBKiqiBZ9IayeFPvOuNn+GqGYlkrl9GB
	3LRiheWUoIv4CStUb2JHEnnH+MXQDC3xKQglIf9moH/k5IBDFD7Yydsn491yXkE8E6/KuXlJBZQ
	1UUQZK9W+decnxaEwH918PpH7lZ6XIh0nxyW2kON8UUOoRBGktGTUiOOCu8xHvQeP7UfL4+YCxK
	7CmdVLEhVe2ggRG7zU6Qu4HRuufHg/ACYc4V6hjJYEGS0i7ek/i4x8C25kxQr/h5CP3/PyWFPV9
	MJgLRFwwpGLtoYGIh5vvyZbbiP0VxGJXVKIstlcdt1B8rVDRMv5SD/LWVFPzvWj6BalgSPPnvjD
	k4mW7LfhWHNXE2V7v8TQpc6/pK5rCwdKHIegKRWYhHtEG0klCX+0vIhJfNU0ZJ6WTp+U6DIwhhQ
	==
X-Received: by 2002:a05:600c:620f:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a35acb9faamr167202155e9.34.1793098340270;
        Tue, 27 Oct 2026 03:52:20 -0700 (PDT)
X-Received: by 2002:a05:600c:620f:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a35acb9faamr167201725e9.34.1793098339907;
        Tue, 27 Oct 2026 03:52:19 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0cc374sm271915855e9.9.2026.10.27.03.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:52:19 -0700 (PDT)
Message-ID: <02c9ba7e-469a-4a2a-9bed-9a1d9a8be352@redhat.com>
Date: Tue, 27 Oct 2026 11:52:17 +0100
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
Subject: Re: [PATCH net v3 1/1] seg6: validate state in netfilter
 continuations
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org,
 andrea.mayer@uniroma2.it
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 horms@kernel.org, contact@proelbtn.com, pablo@netfilter.org,
 vega@nebusec.ai, sashiko-bot@kernel.org, petalzu987@gmail.com,
 liuhangbin@kylinos.cn
References: <cover.1792660496.git.petalzu987@gmail.com>
 <6edcb09db8ec3dda9e26ab5c5be45769907011d5.1792660496.git.petalzu987@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6edcb09db8ec3dda9e26ab5c5be45769907011d5.1792660496.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/26 09:23, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Netfilter hooks can replace or drop skb_dst() before an SRv6 continuation
> resumes. The continuation callbacks then assume that the current dst still
> contains the expected lwtstate, which can lead to invalid state access.
> 
> Validate the current dst and lwtstate in each NF_HOOK() okfn wrapper.
> Drop the skb when the state is missing or has the wrong type. Keep the
> direct core calls unchanged when nf_hooks_lwtunnel is off.
> 
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260720204430.1886091-1-xmei5@asu.edu
> Assisted-by: LLM
Minor nir: the above tag should not be added anymore.

> @@ -624,10 +648,10 @@ static int seg6_input_nf(struct sk_buff *skb)
>   	switch (skb->protocol) {
>   	case htons(ETH_P_IP):
>   		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, NULL,
> -			       skb, NULL, dev, seg6_input_core);
> +				       skb, NULL, dev, seg6_input_core_nf);
>   	case htons(ETH_P_IPV6):
>   		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, NULL,
> -			       skb, NULL, dev, seg6_input_core);
> +				       skb, NULL, dev, seg6_input_core_nf);

Please do not include unneeded whitespaces-only changes. There is a similar
chunk below.

Other than that the patch LGTM, but when resubmitting please do not include
the unneeded cover letter.

Thanks,

Paolo

