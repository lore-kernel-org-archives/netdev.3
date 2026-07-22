Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A805471270
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705740; cv=none; b=EsSQj7+gLFdsmPmQJpc7ZzKW6kAo2NgokqS6UEAlnmaRIPl0xgw2CnMJ2HBHUnXzQ8LVuYvsOqjxLN6IK+jjb6TkCJ/a9VRhSeI8BO2VuQM5hZtKk0zcxKAD29cRSbv9MnHGOI+6Ov+lfkyGP0kldZiZ/0SoNCnjkvss3vvU3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705740; c=relaxed/simple;
	bh=NzaLpCbVr+WpUWdGU1r/uprVlE+cNyid29E0Cpbjtb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI2u9/FlzP88ZWz5QOurjj5jeAvRZiuOG4vFE80QZoKk51kS9CjTiFmKUvp6ChBpd3zlpb7hvlCYMSf+APMDyalMeuuMVdkyBIzbL+0K4A1zwMdG5VVJcdl9bO9YmLZHpw4ndJQSrON6V1ac4vrgb/hdRGgzSVTe3XDpRFW58LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZmsPsDN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZmsPsDN"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8143daf89c7so83854007b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784705734; x=1785310534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MjAn08LMgZdcLrgugv1HWMEjLz40TQ45oEq4cOcP7cI=;
        b=aZmsPsDNAskn3ahL+L0BwXkDZRKqkWlm79C11d4WJ07/CdImoW6MWqgPkcTGL6QjHC
         oSJ5SucmgB2WpQHaXtGTTwoMa6F5YwwBS1Cu2hHWUTt4DK5FDNbq6B9N6ObtLm1dPRnS
         3eXgtM323CDNBUjHquaZsf8sTcvex3jnK6PXjmBWvik/JD4PPSDbP2K79+Mz15Bz2WDD
         rAzX7TzspfuFpj0+iD4jbNjcvJi3vadQc4s+urrGOYRQ1+qwrUrjmMXMb1mZZICvEC9v
         0f6KFX38AY0omXrQncfCS7jrG8s1UJk/mmUpdmS6NlmbTtC8S5bwl+i8buJHjGZD7vuF
         ypow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784705734; x=1785310534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MjAn08LMgZdcLrgugv1HWMEjLz40TQ45oEq4cOcP7cI=;
        b=D3DhTH/MlX6RYmXmR8rpA4mI1mMr2U8xF2owMRVBiFbCv/GiB6sZpKbtezHifR1vpJ
         FehzPqxHvU3pznRHhy+0jmQ6BKQJoXRf/Ixc3CzwWG7bOoKcZiBw+gvE18/x9SehH5Cl
         cnzxcPaVkg/EBupuRBGwthHv5A7ntYiGWE2fTDTNfklLQcHhg+jkV188Vh0Dbcd/r6zE
         M6IO+A7EZY8T5302JIeqnqSPJ9xgVslQ//Nr4CruJzuTglT/VrLSfUmAWes0lUhIl+9T
         o38BecNeqMQQHmqrlDPHziSCoHXwNn/WLOGa2b0td130cEGdF3Ckpfaf6zAxoUNMmTKk
         286g==
X-Forwarded-Encrypted: i=1; AHgh+RodgeRm/nEmMnwdBkgbHJKs9qgU/gXxydFb0KPp8ZhSSOt+TiYcgZVPXecisUwYwhwncWDGnGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeeFxsLpvWzd2OQ2an3O+t4IluHIksFPYiMJF/EbwHWGHVeRu
	/002Tg8I32SAM1vA58SJl2gxRMs28v6xjjNkNb4HRFCFH/cvKmuvh+J7
X-Gm-Gg: AR+sD104h4LB5aS9Gip49igpF33moxgWGA4ACHS4RmvlFui6OqTTViLuYydQGUzLeLw
	i999dCbRpdooDkRDuX0JLqRa5k1rVLydrlTbBwPfjGX7kFrMYsboUJJv2NSArBmjr+sITKn9QNN
	FSwU1loRPQo8OmI5Js+LaESIxuQDLb+NbJAlSo8y8MkRSROPeLCrRTA7EDNGtSWdUXSJwN/AvdP
	/zAtpZFMdMYKD16aYeCgxQSKLeFx5Na3hRLFHf4SaR6N6pr0uUxflyNm8UM1KIjM+O0u3HzrUpn
	Yyl6tdRaXa90WVWyU0xEwPjyaJkWC0LRrE6X5USTEjKviCyZHZszyqXGl64FU2IO/FJsLvcnyr0
	72ube5UlFI7z2/CTSGiMbQKt2HLN2OgKx/2cvYacu6bkMCWl2w3DqtAgJlBrHNfOlBAj32OTjyZ
	XWIWR6gd5wHs4bthaoNJbN
X-Received: by 2002:a05:690c:7408:b0:81e:a471:e893 with SMTP id 00721157ae682-81ef23f6d0fmr69358347b3.24.1784705734677;
        Wed, 22 Jul 2026 00:35:34 -0700 (PDT)
Received: from [141.223.124.60] ([141.223.124.60])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33bf2df0sm9706647b3.6.2026.07.22.00.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 00:35:33 -0700 (PDT)
Message-ID: <f9c6bf99-28df-498e-99d2-efd7d2b303c2@gmail.com>
Date: Wed, 22 Jul 2026 16:35:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] nfc: llcp: race between nfc_llcp_send_ui_frame() and
 llcp_sock_bind() dereferences NULL sock->dev
To: David Heidelberg <david@ixit.cz>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a89d0419-8bcf-40a2-b52d-3e5d911f11da@gmail.com>
 <93f2ff92-a7d6-4521-9273-2e84fa37337d@ixit.cz>
Content-Language: en-US
From: Junwoong Doh <jdoh.kernel@gmail.com>
In-Reply-To: <93f2ff92-a7d6-4521-9273-2e84fa37337d@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/26 23:24, David Heidelberg wrote:
> 
> Hello Junwoong,
> 
> thank you for the report. Would you be willing to try preparing a patch against
> the NFC for-next or for-linus tree to fix the issue?

Yes, I'd be happy to.
Since this is a bug that's already in mainline, I'll base the patch on for-linus.
I'll send it by the end of the week.

Thanks,
Junwoong
