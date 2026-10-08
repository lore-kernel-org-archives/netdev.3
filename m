Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9F3B7760
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465374; cv=none; b=AgmqQDY5zRRilOTCG/0O20Sxgs6tOX8q5BiSKyZlKgo4gha3xtmNw4PnYKtSueLVOsFZjM8GDbFWZJL88o2OGhBonLeo0phVEMBUKwqBqVtPfzZV3HyxPH6E+cSYyceX2dVf5pC/7JcUCjhfheG7tWHvQRkHMoIIsnY6SA8Jfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465374; c=relaxed/simple;
	bh=HVsdYcrVLHwgm2tiuQB0eYQnmVjqYmrBVemtB3z+PLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mo69g/RsEzBYOG3G7qs+kEfa+AYKIWLNe5y0XiWfbBdVMqnAROTlo9qCpz56sJsS6MiBJNm+RENgwEwI42Ros5IAy/+BXcUmfi4zNzZ/c3hq0/UiziDyd/+CfpUWWVI2Q62CX+SBVo8lvS4TodCBFsWZbzX4v2FlVONoMUPK3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6e4ThNj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6e4ThNj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c399641so29830685e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791465371; x=1792070171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPbwtLRW4N85gv2W9SRzwrK8xu8sUVynb6/UPNoN4L0=;
        b=c6e4ThNjnlV5w49A0OkbmTx0yBzydXTov4/VeqiJ34pUWoLx+gfqo7s1Lb4Dytoe1Q
         N3D5uVzdPw85UAdJsEFxisiUnCUxUFDryDkoNTuOAZB6iYH6lH8fz4cEbeGb+2FAKV5n
         91A+dEhVrWZh297COSJg6tf9WVgDjO6uUVTtmiX/5jYB9v0sx5Y5rnXJjWB3C75+qFYs
         RNxiPebO53AAa7CCXt72qV+MJijX8aiDZprIMyqd+rKa1xKXuS6LmWCgnEAkW/E8Fzbh
         r7uIpoDkpu7UiWktQxoOQ1+Oc+1kWXCeiyEKVdqh8u6naC48CgXuLdaNA9CROnXX8i7W
         tYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465371; x=1792070171;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPbwtLRW4N85gv2W9SRzwrK8xu8sUVynb6/UPNoN4L0=;
        b=Aux52FEl8dfAOPic/fUF2c4rR2X83kmCgRGj6saZoTSbf4PAlQWrlVRhiLp3MOOzfB
         4D+DP3hhaJE5dNC6Jiw56dRaCaGfv46RJP6msMAIaMfRryirCg4ZLdZDYJKKO5Wh7xFd
         zjEbGccMGT1CyTjsQJNTCQktlOb8rzW64E3SSaP1JKPcLocOGBIP/YND6L1M2sNkaygr
         YGJm5rWsTW0ZT6QZbkhxNIDuMNdbS1KPje/FhBbHCN+ZCNOCREb5cREcIlO6KyYliGxO
         068LunOb3myDsHxQxs4AASlxRoHwRfJlkV6xNL50iF+73elNB4t03C2HNqkTnkcUu3T0
         bROg==
X-Forwarded-Encrypted: i=1; AKwUvBwQReimvmCRLpPILRzeDIHMj1sqCSN/bMq9QHJGu2MZR7NfQ6npCgGmUpuEhGMLgyhfrUDmfD0=@vger.kernel.org
X-Gm-Message-State: AFuF++nDwaz/o3iXu2h7BM3WljWvSX7/bzC0Bbh9dszs+cLiVHm2qdNX
	7rZKhn6T7uDF6cxr77Z1ZGd0lGVuoLUX8BSjT5UydvG3OF+eVSsEISyY
X-Gm-Gg: AYBFou3N9c0avzZQ1h6DIDcFbIM4HgzJIiLXV2Qi0w5ZIXN7gdWnBrZ4JubEkHTIk0I
	ZGs8iHXWvxVQhbVmhNmxd/NVDEt+T80ynlWRWuYY1mHZKMVWnDZU2UH9SRl4X0KqlAo+PZNoA8h
	K0T+IMvsiIo428mWYUi+V7skK4mcj6QBvmOi0gwcc3O56CzApAsCgfUOzeMvRUMR/8nkRTliymD
	A60ZvotXBtjw6oKNnlXyx7CtV1Yn/59eo5xup75o0UziqMxyCROPc+VRP2EaXdFaa4iwyNczwSD
	mRrJsrcd2pY3Yfy7kYtQeXBFW10Qu8bjBO/h4O0cMBdqEFlB45ZcSCNQcGDwQd7FTWQduBCWCRv
	rPmAlOkTplNFsSWco+Q8vY4YzgKHiu0iG9zMDwLyecfbBZdkHQL75yCxv7Vz4govdo+X4OiTASb
	tUsN25lh2IyMmT/g0XZfx4kInCkxMcx1+f9M4kAHes0zRLJwMrfpg/n//lnzqPAxh3CaImh7Pb2
	K9J3TygOHjwnZy822AkX8decmcFDXRuMz/T32iGpZAv6FB8vEPI6zkfR/lURccKVzrTqJ6Wd4kI
	GSNlGKFbN8T5lo49DqJScGoS1L3RdgXqmaoKKmBZeJIBSpQc
X-Received: by 2002:a05:600c:c16d:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a18067f68cmr96298625e9.34.1791465370753;
        Thu, 08 Oct 2026 06:16:10 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f493761sm221691685e9.2.2026.10.08.06.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:16:09 -0700 (PDT)
Message-ID: <6fbab5ad-e95b-4a19-a59e-4a1ec9a4f225@gmail.com>
Date: Thu, 8 Oct 2026 14:16:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
From: Pavel Begunkov <asml.silence@gmail.com>
To: Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20261008033952.1399670-1-almasrymina@google.com>
 <36d9e570-15d8-4a2d-aafb-3ee6e5681205@gmail.com>
Content-Language: en-US
In-Reply-To: <36d9e570-15d8-4a2d-aafb-3ee6e5681205@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 14:03, Pavel Begunkov wrote:
> On 10/8/26 04:39, Mina Almasry wrote:
>> validate_xmit_unreadable_skb() only inspects shinfo->frags[0] and
>> assumes all fragments in an unreadable skb belong to that same devmem
>> binding. However, tcp_sendmsg_locked() only checks that readability
>> matches the presence of a binding (skb_frags_readable(skb) != !binding),
>> allowing consecutive sendmsg() calls with different dmabuf bindings to
>> collapse into the same skb and bypass per-device and unbind checks in
>> validate_xmit_unreadable_skb().
>>
>> Add net_devmem_skb_binding() to query the binding associated with an
>> skb, reuse it in validate_xmit_unreadable_skb(), and check in
>> zerocopy_fill_skb_from_devmem() that existing fragments match the target
>> binding.
> 
> Looks good
> 
> Pavel Begunkov <asml.silence@gmail.com>

Oops, should be reviewed-by

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

