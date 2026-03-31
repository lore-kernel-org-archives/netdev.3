Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB83FB042
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991308; cv=none; b=TWcRVM/n3DWNfoigGYH/VnKWBGbl8j/NU8MvoYaOfFJyLRGp3DMifjfOaVUbu03Rd9dB8y3KQgaAnANOv/UTnrWU/I6ZUwlZLuijTS/n5/UCTVXbjFAsM1HCqmFa7chef+O0ktF72XbnK9Y8xM11+x3tGtpFU8ii64kRJozLA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991308; c=relaxed/simple;
	bh=HP+l1uTCqRajs2Vn3305m2For/K7wm1ErxgzeVG6UEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdr7dugvY9uwHBWU9ThLhwqH/cpFaz/0y4eZn+tBZWknRIzPr9zm0zAqxvTSvEZFOUgsR3+GO15DEjnYDjkr7wQmgcVyBBnYFvbsNJYWBq7gwzdCeDJEznQ+zXG3VZ+tSVo2ZjBF0PLMZyq6zRT4TK9s6gIRGOAFeUC3NIrY184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERxk3kOP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERxk3kOP"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d9d929e27aso5049442a34.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774991304; x=1775596104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP+l1uTCqRajs2Vn3305m2For/K7wm1ErxgzeVG6UEk=;
        b=ERxk3kOPtb0pgZNrGP3Mp+B+8cIgtEwM0R7DimHTXkGvI8/GCwf0SXF4hk2vRoY6dI
         P8+xwvOWzbzQI9WBbiAkdGT3wxIXtqySaas9WG/n09PvDGSwoq6/SwdWeAXtz2ozTOdH
         Cr4MMmvzi7YjeB++O8azhH9waDMngD3Dhycm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991304; x=1775596104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HP+l1uTCqRajs2Vn3305m2For/K7wm1ErxgzeVG6UEk=;
        b=Ydb/5Ndkptef/9d9fov2O4WTeQIyfeIAtbgTXSe/0cTI4HQj89kyml64xJwGPN687f
         3YqV0n4F0Bn20JWzBLXbBkBk+d5xTnn/dvRVS3bTqmt2yuMXTIDzLf0hQ+55zk9pkb6n
         NQDQMN2AFpy2iY4+n5Ori3N1n0BrVJMU1yDdkzQxlaflqjyfNVUG01haHxpGB2NKs6oR
         63ByDNn0EjZnyripk9sOph4wW6y7zxCl4ELkH63HDBpFaChopoKeYIN2kMbKuor275md
         BUD7ALsDhX1Kek1aax9HambDBBcPRNxZ41wGy1QiqovGWj38Fpw6D7XTTMNnlmyVXKcI
         zATQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMK4EKYU5uja96+3qyEpwzsB6WDUS56iSix4CLn3pG4q38wKBrHO0WzZIhET67QJnjl8v6cFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQb2RxiOCRbxQ3D3/6wVaKP5oLd4vqhKk8BTkj1hwhAqddKOld
	TXMYkwEvdd2QJGtU7T6rG0YvTNIrFc5v901G/OJKbxBct4Y1llHEqBuYqf2v4NLItw4=
X-Gm-Gg: ATEYQzx7qYsTZ8WBHjXskPu0iD/NTbaBLoAdBalhD+CwcW6+vnBiV9eUWPO0IdKH3A1
	KXjQPO/PV5VJh7ymwnlIYLYpqtvnSgVCZSKD3j1cSlzNxyJWrTiqU8K1i21IzcvHdP1lcq+mlCR
	QQluv378Y0TxYB267G7GLToj9jUT0AJ5lx7ZQcHDjdbiq7aLIVbY4ZUOwq8vMMGL1PZVJn3Sz7q
	IzA/k0+R7nSw/UM0CINheNrswpaJNTEzF1t1CxHUy7JvaUfeqchQ9TWBO0jK+pLJdjL7kRwXd19
	lXdqNd1Y4a0kZObsWIUjN7zQrwY8FQfbK5iB6oDX2q5/EjkCtfdxAQAF+4Wiow6+bldqJKWF8MR
	dHDwfYX788Ngal/75gYxUpS8VueWg+Qz6nxv5CTBXiETWTVmv2QHT32YD8deCgwxnQ0s2oJ6yUW
	j1HL20PdQU7n+Vrsfb9juoFnlx5CotBSW6su8=
X-Received: by 2002:a05:6830:82bd:b0:7d9:7201:1acf with SMTP id 46e09a7af769-7db991d3f6emr827760a34.5.1774991304319;
        Tue, 31 Mar 2026 14:08:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm9005534a34.2.2026.03.31.14.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 14:08:23 -0700 (PDT)
Message-ID: <caa4ab7f-81cf-4a0b-a8a0-1c12641cfe2c@linuxfoundation.org>
Date: Tue, 31 Mar 2026 15:08:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: octeontx2:Fix typo in documentation
To: ShravyaPanchagiri <shravy112@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312162715.35408-1-shravy112@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312162715.35408-1-shravy112@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 10:27, ShravyaPanchagiri wrote:
> Correct a spelling mistake.
> ---
> v3:
> - Moved spelling fix details from the subject line to the changelog.
> - Simplified the commit message.
> v2:
> - Fixed the subject prefix formatting (added space after "docs:").
> - Moved the long description into the commit body.

A few things to fix in the patch:
- Signed-off-by is missing
- version to version change information should be placed under ---
below the Signed-ff-by
- Check submitting patches documentation for details on how to
submit patches.

thanks,
-- Shuah
