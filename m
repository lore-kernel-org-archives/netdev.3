Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49153B05A2
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343922; cv=none; b=PomFLYjvMrEkJpbNREHnHuTIDzUCmF0xvyI+d/96zg64gWdzP/3H/2aNFjIdIUjn5SaooHA/2ckLgfJ5Q9+LENER5/TN3NCoVPThUMoyijXBzIdZiNcIPGSIjhmuu+karcoDuyjjrmkz7MMWeQA6OEIuALZoXdbjIxY+HqoUkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343922; c=relaxed/simple;
	bh=0ZcKYC6CqCOE778Klu3EdkP+RTdCnMbliRZDv81Ibc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izjKz0NrEfvb9qktHvp7O6KT+wnMrPKxQxyhHovb/y8c8LGEzvJIszLEt/7FPSFCbJoZ+hu1UYVo/XpCwWbNS1h1rZfzS2Lj7ciTwa+JJCsGLLXO3m+GNA5FbBLyEJ21uXIQtKMNIJqKQYcTfMrUkS7QGlNsBVKmS3XEfQ5gRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvLiY0mn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvLiY0mn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84861fc51f5so892872b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785343921; x=1785948721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynliW8RV51DVn6/Hi9bIDwJycFbIH0QxQmXIx2aXoNg=;
        b=FvLiY0mnd3rhri34fK4F8q8lUhjLUjswYm4I7+fdRsFtCVGjWDnyCH1hL494EltLSd
         1Si8cn4tEA5jMs+MVXgsYaPeOBQQlKqe+lcrpTRBDQjng+yrPAyb2Z2WkptmwD417he/
         910iuLVp2zBed+g0F0NPP0x1/51zqRkhqSARKNDhP7MDe8XKg41CBm3fRhVQFt79vwzP
         VGf8b6+KyxLJteym+ZXaElqkqtw2CBuYTORt3xfr46Qx0QOR5elQF8jjEywRdQ/2UhAf
         ckvRAuAH5h4OGppM9onIJD+jwD11pBIrBVNxjsMJdmUyl1YzYlVYndxFNbQ79hMNmbT6
         F4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343921; x=1785948721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynliW8RV51DVn6/Hi9bIDwJycFbIH0QxQmXIx2aXoNg=;
        b=rRb7l/V6MOZS0N5I5hV6BWKSniOAq5N07YThToyXxKSwqQ+Z9hglLzNPUH1XYJS8mz
         +TidGWzqlplu643kuvOyPjFS8U1N8x11BtGj/o9Fi7ECsoxbwUtLOtOxlCn87evkwky/
         ipU4r6ruu5vRDHEK9K0Z8T1R5eATBNtGRd4zzpLq6/w7K7oozP0dkFIg0EK68a7C4G8+
         DPeF+swUp86BJ546euf7rcFpGjZLyfOZJdXXYHM+qJAFvTlmRuK3GZCcsndsdz0gwHye
         pU5FdLGHMuDlRvR1Bzjq5uNIVGOcuHE5coQO8boXGpKym9mQUl9Xw7fIKBIfjI0CII4n
         fWEg==
X-Forwarded-Encrypted: i=1; AHgh+Rom7ixvteXoIcz0nNlyP3jh5mPmPdWix0HnI55Lqqwy26YnZm854LF4S3tys2G6Qz42y/EZYfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nymARkqwUtnkBmzY5dHay74GlNfAIm8PuNL0kG5lBqk4VD+W
	cKG1DZ6IVkX1XOVJf82UWjqN82miPyN++5e1vZhQwwTJrZlP/Bj27yqscrNy1sl/
X-Gm-Gg: AR+sD13xl7ur1BjHRj5BPTwusVcFtgbxW9kmMolggBciTjnz4xSxPcQfOEoPgC6g8Vs
	neVbYNtOtRC4jrMl6XaEJKIUPtC43RNKKwF/9jsLAPjNfSqhEakP0wCuD/gnnGFaR3GaP7UqaN+
	1DHIidRchQNdm3DBhF5dPi2el0F86h3Zkac4RxldHS57Mssp7+60U5f4TLItUQJrlx+BzkFclZg
	2dLASlkDlRrcRwMP708DQeNHQcGQ4tQD1GOCDqEj64c3YawI1UX0/JD2m1d5A84UDOQxUQoCVf9
	TfjO+kcHmdzqdI8dRu6Mmxtq5Gq56waerJkb3pUiQnjzz7l9jJS8wwRKCgrG603HqxSf3LJ1uAc
	Uw5eJtN145MxPP67CLQmWcQgo8+eO8zMi3Sut6WpYJY5S7tPAdJOZtdPe94LbfpIh5Bnlu+oUK7
	UO2Y+TSeD9PIIFzsENsPX1xQ7vLm2fMjoqbtUJlwVPbtGtTn+j5Aiud4VlP11QZ3Z6sPA7tqUTM
	qT4JuwzO1zMWGFv/c7JtRh0RfG1IazmH7eReYqz
X-Received: by 2002:a05:6a00:a86:b0:848:31fb:43d9 with SMTP id d2e1a72fcca58-84e9332e820mr7983253b3a.45.1785343920946;
        Wed, 29 Jul 2026 09:52:00 -0700 (PDT)
Received: from ?IPV6:2406:3003:2007:2131:923:11ce:1cdb:19d4? ([2406:3003:2007:2131:923:11ce:1cdb:19d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm1697570b3a.8.2026.07.29.09.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:52:00 -0700 (PDT)
Message-ID: <148e56ec-dc26-4be2-a7af-eb547b517a68@gmail.com>
Date: Thu, 30 Jul 2026 00:51:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
 <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
 <amn5vWcyY0f5ErEM@sgarzare-redhat>
 <e7ff506a-850d-4d7c-8346-c6fef9ad8553@rbox.co>
 <amoACichDryCaVsG@sgarzare-redhat>
 <bf3a61f0-cd82-4796-a3ce-d6de8c8dd7ae@rbox.co>
Content-Language: en-US
From: Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <bf3a61f0-cd82-4796-a3ce-d6de8c8dd7ae@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2026 11:49 PM, Michal Luczaj wrote:
> On 7/29/26 15:29, Stefano Garzarella wrote:
>>
>> This is a good point!
>>
>> So we still need to remove `sk_err` check in vsock_accept(), or set
>> `sk->sk_err = 0` in vsock_listen() to have a complete fix, right?
> 
> Yup, that's my understanding as well.
> 
> That said, I'm not against flushing sk_err on a failed blocking connect()
> (this patch) as a follow up, if you guys agree that makes vsock behave like
> other socket families.

IMO, we should remove the sk_err check in vsock_accept() and invoke 
sock_error() in vsock_connnect()

Thanks,
Phi
