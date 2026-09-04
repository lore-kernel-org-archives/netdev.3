Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50479368974
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530504; cv=none; b=TYTgLiprGa6EnC/I7jlY5jWATgjAjz7zi4uiBVwWpgzvwIjhY9RlXuBhp7jcohLTJ7LSXN+mRUwDYP3Hf0tJ8PirUkmWAaV/3m9KhqUgYOjejiXn/m3B6bDYAebXKQEAlZjEv/jj7SoASlV5HkewdODNLgglD30aKc2/U0Uv+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530504; c=relaxed/simple;
	bh=8eT9j/QsxfjMZj9AmxplXfzWvb+xtgl31GKpHCcgevc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=aTe7pLvzAqUv98kOd8ZzLb13q4qo6DtmTWhW/2LYK2eJzzGGJr8WJJzMxtAX5eYivUeeIfq2b/Npw8l8QRAX+96rN3LFDcDYzZaXLZ/7pEzRwpJtmYLHDOWiwYnYne7pHfCkwfZ+p9Mtm1yqJsY1HL5jxpKzfTCZCp2R4u/bgQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso2469145e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 07:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530501; x=1789135301;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :cc:content-language:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jbw7ceEZUyIQAmc0iaaUlL/69KhM246NnpX4rTfr564=;
        b=Um81P6+B4aIIoV1gXKKxQDUpOS+eTtZB1LQ89tYGMbK0E4xIM448fGaAf/Hbt0thWs
         J//05M+2/hYYuFcScq6P5ngIoM+oYnBpLHD0ZIBBs1J9CVFksiW7wPO6uOCxzVSAoC6M
         4LRc7warnOEUgZrR8o/JU03zjvin6r59PbGosrjBuxwVxx/DSoL3Ou55PHcG0cLFWqWM
         A5akmfCI/kQsqoZ3NWHXQ8awgh6BSqv6J0vCHdrJZOkT2GevhtaycATZ3o9u9vXQACdu
         mS9BX/JPjB3GbuEH7UudamNEqueOSPLwPdfCsqATDefYHNeDz+ijvcc2xPgZiNuelre7
         FWJA==
X-Forwarded-Encrypted: i=1; AKwUvBwiNAC0qOGgMBn1e8jt+/+ydFO30unFfeWOcMj/7c+N6hAUJKICOnq88FK+xPO7DMlBMz54+w8=@vger.kernel.org
X-Gm-Message-State: AFuF++kZMIiaULDmVO7qSxAv5Uw8ZhUvmU45Q490zMy0YelFYhs5C3Vt
	xg0LplXNbYpMsjSV7hFaow/B6kvg3NirjAlpWcw7UA0ZCh6QmrfvbJLMDbf4o54j
X-Gm-Gg: AYBFou3Ht54WQRfjbjKgMA1MisApcphSlQBhdnmsHoZImkRGIEccL0J4nfAhlbXQB4u
	JVR1eFi+fzJ+YuIYSnwqtbnzogEl1FKe5G4UBM5VcO1KS/VnkfCf7Lg4u/6rsEp6uuJvFSs+sIf
	ySrDKZEgVbT1BCQ4lhTXV/IFMRgYufBq3tzs3tAFvXLfd69Aam6jz8Jh8X5GPUMDd9eTmQhRyTX
	VKom0tdyhGMvh0/SgkhloWfsWQmPf01cazkYFhwhw8b+xtnnVwp5mSRSDBGM+aC1gNmAUk2+1vn
	iHuwMgkQUddAxZUEmbJRadg8+rlxkdY7zTJmZaan/r4jBLIraRBk798+QpZ9SACf7v5k2oz4xSq
	m1DH9rgyWyc6MODU2i5GTIMcrzYJRteVG6mWC2BUUoQreI+d3+gNnlSnP6MMHbYBpf9Hqz8/RQ4
	mmNLTO+ErV5ztYh1MEgSyeLAu8RvcGx7cNQQH9fIOg6bQeBE95U2OfgAk64RAIsVN15PKJrRCSY
	+W/nDBD1o3eAQ==
X-Received: by 2002:a05:600c:5492:b0:49c:fa21:e73d with SMTP id 5b1f17b1804b1-49cfa21e877mr41757395e9.19.1788530499692;
        Fri, 04 Sep 2026 07:01:39 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm6771695f8f.1.2026.09.04.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:01:39 -0700 (PDT)
Message-ID: <dc460046-82bc-4c20-870e-716dee54a6cb@ovn.org>
Date: Fri, 4 Sep 2026 16:01:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Containers to run Netdev CI tests locally
To: Matthieu Baerts <matttbe@kernel.org>, Netdev <netdev@vger.kernel.org>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
Content-Language: en-US
Cc: i.maximets@ovn.org
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 6:19 PM, Matthieu Baerts wrote:
> 
> A wiki page has been added to cover this and explain how to validate the
> different tests:
> 
>   https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
> 
> To help developers, containers are now built, packing all the required
> dependencies to run these tests in order to run the tests in an
> environment that would be as close as possible to the CI one. The goal
> is to have an environment that is easy to maintain -- no heavy
> optimisations to reduce the images size -- but also easy to use. In
> short, people (and non-humans) can continue to use the different tools
> as before, but add a prefix to the different commands to execute them
> from a container, e.g.
> 
>   alias run="${nipa}/docker/selftests/run.sh"
>   run vng --build
>   run make headers
>   (...)
The headers are not used unless the USERCFLAGS="-I$(pwd)/usr/include" is
passed into the actual make command for the selftests.  So, uAPI changes
will not be picked up.  Would be good to fix that in the wiki.

The $(pwd) part is a little tricky since it will be resolved outside of
the container.  I didn't try if that works.

Best regards, Ilya Maximets.
