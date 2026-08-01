Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F2305695
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785602145; cv=none; b=FunfsM2bXWRLF8JS0zMhEafzI52vZ4eEghLG8jKPspT0LZh82v1Gk1MMNEN6bWsrY6GDKbjK1hUJ5JewvKml2FsFF1guFzKh+ITGwIi15dy1kWfp3D64erkJmenupfntRR2FBVdsNkjnRWxx/IDmCpMfGXyKH+i8w+wQ1XkB7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785602145; c=relaxed/simple;
	bh=6IuylotFFwWBAMQj2NqdFiyeiD6OdWolIXT2oYsLmN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnQ12fcyX4wC+2/Cta9ARfKd0hQlH2xy9g6I83Fvrz+VfSCknrKGTtdWLpF0OfkhVuMFrjs8pQI7RUgxq9ZnEBDVXf0EfiA9AoeNRO+ha0LmPRkSa/V3854u/B1w9w5MaZz43ami62TtVcani+ENHsZS+oIGuH0pzkQQhBbXBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=djQgz3OF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="djQgz3OF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbb85186d43so953305a12.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785602144; x=1786206944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udc5omUAynrLhsYpEj8XTZjU4w2fwTsJzsp1YQPMNQs=;
        b=djQgz3OFgVyKmNCvPI9qUU2AkCoHTaznD48D4FGxlLEhpNJXO5lsokId/Ir9MIt3rT
         ic2KQzjIXyo9fYo6SE52czST0uTkyOnjQFjMHTkNT/2PJGTjKf6vJctw2BzX3qMg0QaR
         usLJTQYT5TRYrWvZdZs0nBhVjytMu1stNezQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785602144; x=1786206944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udc5omUAynrLhsYpEj8XTZjU4w2fwTsJzsp1YQPMNQs=;
        b=J59VniibXrjAU3Z7i3+Wt0H/yw1wY4JrzCNes6X6I3/tyx0qBiITL99nMQbl3nOzT9
         O2JB5L4aC8PvC/66m3IjMciCF/2VnMUKeGCBYJQX4G4uxjzrhql55Seqd3rDkiOsSQCW
         9o5Y7+Dz5nzRKm9avdWyFs16bC00cxj5dKGcC062k87Alcg3PN3PALD39iOQT85OjoKH
         qLV0h4P3hG+fYtsT3VvbfDhNzoKQ5YRZLk8acY8dMi8R2ehT4n0QL1fzkrRmMvSXPvfL
         aXe8I4lYd7tLLV6+IiwTelNKyK9WnQ/ikYiDUZkvtINiFhJ656kfRzuA9MMhujBnUCN6
         lV6w==
X-Forwarded-Encrypted: i=1; AHgh+RrELTLUn3kM+aqS7an/yFizmZ3+8JP3kC73lqDDliAZnUg32B3+XC+GQ0YXbF91ZjamDMMvGjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuO+TIxEUJ6p0ypcfgPgPh7DLSv6YY2vc+EQUZ4JTOFbHG/BnQ
	Zsk/tkHVOGqCdWk7aame9tDMlW49wCeqSgmfSip/745i8Gn8vTyGiO5NGqEoX7UIug==
X-Gm-Gg: AR+sD11PwnHUTja240e7l4s5cZM1wSnI/q8cnaDS/e8/NYPa1v6jzIKXRaQvifbu33F
	8Lret6qmzRxDhdBl6KIUwAKMdtKZR51Nlz1WcZPRkm1XHrJiiKzK9QW5lD/0zt7iVP/MIF9AE4i
	1kQ8yf9XYqy+N71a8CB16BDfCymzKqCEZxN+GkEaU1yyk369Amaq7xwBlT9NkSKJqda0jEvtcEu
	P+gPtX5ePxNEENZXv6QtsIjwFdwE0WbpURvSLd3XNct3Jz9SPWDyzn9DugVFknVFpoEYQwAC1Cz
	FyBcqJXxJFebBWcqVOIXwZa4zWsdipYu5zyWYnHru87+S89LtVCFms5ze7bOHnVyLPdp/QBVkPU
	hPCorCeyMTxXOkFe3+XvMqG+JvXFzeTUzOEFaSAzY6AgP4vm7UeVDsYlsfsb6xRYPBvFVBCccyD
	6Cjcfd2xs02bex0Y9I7sb9wBCuRSfnU/rtj+qPaGxxz86QDzi6xDC7042/A9q/Hi0bCtWdhg==
X-Received: by 2002:a05:6a20:734c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3c92a5a8071mr4103827637.12.1785602143791;
        Sat, 01 Aug 2026 09:35:43 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab143a7csm13089048c88.4.2026.08.01.09.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:35:43 -0700 (PDT)
Message-ID: <8afa5643-12bd-4261-a148-7032d2ac87b5@mojatatu.com>
Date: Sat, 1 Aug 2026 13:35:39 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests/tc-testing: add qdisc hierarchy
 depth tests
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 vega@nebusec.ai, milkory@outlook.com
References: <cover.1785434373.git.milkory@outlook.com>
 <5cc2d26a7c8e553759cdd29a3116f843fabc25ba.1785434373.git.milkory@outlook.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <5cc2d26a7c8e553759cdd29a3116f843fabc25ba.1785434373.git.milkory@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 10:42, Ren Wei wrote:
> From: Zijie Huang <milkory@outlook.com>
> 
> Add tdc coverage for the qdisc hierarchy depth limit.
> 
> The tests verify that the deepest allowed hierarchy can still be created
> and that adding another child qdisc below it is rejected.
> 
> Signed-off-by: Zijie Huang <milkory@outlook.com>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
