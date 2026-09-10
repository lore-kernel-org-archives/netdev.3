Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFE488D91
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044674; cv=none; b=M7s2DI+mjJDpdUTlHMF+B4dDbdJ9Nc25c9+1vHKwQ5NbzK3seZ6NSAtt7zyPFm56doSPLBLc6GmsTM13Ib567ikzmmwf4Uggvj5+USj2vkgWuPNqJUqIXGfK2jVEhXrCEamTJDoT7cfvBBKhPXRwoUwmyV7M4IfWPCJkQxKIe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044674; c=relaxed/simple;
	bh=7iO4SInSuPu9I8kPRhEc9LM0JEhEXlpzNeumaUVEJbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfzXnGJVInr70l34xjjVzB1qt3zLrz6lTV5npscvUmG3rpDMjflXH2Vwa1hvLdr+GoMYP8Hzeh1HzSN8ka/K48sN8Bqn7vPrHPlHxwQUx+HpT9+LMslfR8OvFBvMpRwh2cy3AlKnhYMsS8fkkoZQRYQUZrfHOoSWyqXtlJfmMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBhq6ocY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBhq6ocY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c29432715d2so212713366b.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789044671; x=1789649471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGMx7JRN9yDUR/JTKdfrormbkWFKzXlaMm6X/jGpPAU=;
        b=BBhq6ocYXdDJMkblZCkm8yFw3OZ71LbA9CtfNGbyTR2m8iu/2/zJ7+Ens1Fz6RVU8w
         gtta7KKHTag6Ivm0brhZRzby5wnGNWuyVuLJMHqPgAGZxIHsf9A7welw6YQn3Q+JNz2e
         P3JVdM6lNteJZ4BGIA9R/6f85PRbjmxu3vNZh6gA80uNp1n0oXZGqli/3PL8TwvOD+iD
         kvR1OyPQQCMriqkJlOi28h6cW4X1AmZzRBSQB5f9Gizejk7GWk+hBzKQREuguaVha7Oi
         9FXKVvtHzJ3H/BMbgGxA4A8QIGOrZ1UCb2ALEf+gYHIXr3p4S7IffJhkCRk1+4tih+Ex
         7Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789044671; x=1789649471;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGMx7JRN9yDUR/JTKdfrormbkWFKzXlaMm6X/jGpPAU=;
        b=XIhytxpkmWI9rqrz8BTN0U6iW6OTBdIj8viKc2PHDXgfKUfZ3N18T9F4chric76kfP
         qMJyyXFfTpaaMqn41CVD/aLc9mFKVEqfnYH3s7NzbyQkegA1S11F0oJ2XhWECe/7Sxe+
         7v6xULy50k47FDa8CtEl1AByj9wTQCIoQqfEtG2nFqQBMeq0OoqXKQE6CLEnYADRfpGB
         23yPvzpla3Jub9LZjKt1qc8e1XwqE0nTMGHnsjV5X0vsIMXDkr333Z8Ld5I3sJV2baEv
         1q+HajK7OhBaVqgXvx5NAYlEGiV4Gy2Uyv37/RHeb7KFuHf/xpUD7l59KPRrZ9bv/Fme
         lMjw==
X-Forwarded-Encrypted: i=1; AKwUvByi5Nbv/hQQo8togpB+wZud4hPBZsZDo1S1cMbJwsyNkmmcfR4C5c1MNKfVghS6s0Y2SmjkwOI=@vger.kernel.org
X-Gm-Message-State: AFuF++lKihK5xvFV8o//1Y/lipMdjI3M1k15tsgd749hTHVqGKd/L91U
	pkdATfzOkfUFP04kSqZWZ1FxFVax7v0+IAdX0YIgyxa0bjlE/xYKrVbQ
X-Gm-Gg: AYBFou3QUrSM80UBPLduBC8fCfSn5EByBXFavArO6haJyxLJIGXyZiXBGEU2vZaIWV/
	CUcEMaYTt45DnK3nG+2p+efs/fQpZpTt4AljFQ8vC9xRPqTD1mOaS/3v7Mm3Qrf7mIP+cHqq5v9
	GboqT0ar1BoY7J56iKOKiD8HGr1Ud/I+iFUVNWO0sCUBUcOjyzZkxTbGQmrkH5PpJRcojM5JSKd
	CdCYxhQYgy9fFMS0U1addvyddsX2I6uZlWjP4dW+b357f4hR/UDfpDjk4mp/0UtonfSzgk/uzFf
	xz4Q1qfdv8QupVcILBTtEmP1HPSQd4EHiQRgVooGQAlPrz/2qQ23+NgXm1Udnc/8/aZhX7qap9b
	hFphXekwhXx49VnTYe0+7hcorY1YAkUKcrAAXYjXpiNFX+iRBSK4TozpX68Z3VvKs1DYkjiA7+I
	2RwwghrvQizaORIHAXBCna4WMWPam2CkWIAWuN6518gRmrS5rE0oG0jIlU6pI7gu5tQ+1hyr1YB
	4df6QuTfh6yW1EtO6r0xVVjsw5yFW9EAL40awlUxrixdUS5Z03/JKiIJh7LxftE7li4ikto/1Su
	P+hN/hdZsv+YdiU4LIqJJS9HONgeZVvaZoIBlHoqTJ5k1ts+9A==
X-Received: by 2002:a17:906:c14a:b0:c21:8a0f:56dc with SMTP id a640c23a62f3a-c260c7af595mr1610837566b.4.1789044670984;
        Thu, 10 Sep 2026 05:51:10 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a98efsm925500666b.14.2026.09.10.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 05:51:09 -0700 (PDT)
Message-ID: <95d3d1ac-e365-429b-989e-5caf2f8c65ef@gmail.com>
Date: Thu, 10 Sep 2026 13:51:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] tcp: reject non zerocopy devmem tx
To: Mina Almasry <almasrymina@google.com>, netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
References: <fdc2478d8f21268d7078556409887d8e6ba0ad32.1788529053.git.asml.silence@gmail.com>
 <178896152268.219967.2387243409101048587@kernel.org>
 <CAHS8izMF+G38GorV01mxnvjMPGjPCDKJ1fFPiRNeK-thW0eB5w@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMF+G38GorV01mxnvjMPGjPCDKJ1fFPiRNeK-thW0eB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/26 16:57, Mina Almasry wrote:
> On Wed, Sep 9, 2026 at 6:45 AM <netdev-bot+sashiko@kernel.org> wrote:
...>> so attaching that uarg to a copied page frag in tcp_send_syn_data()
>> would leave the frag unaccounted too.
>>
>> Would it make sense to also reject dmabuf_id together with
>> MSG_FASTOPEN/DEFER_CONNECT and with repair-queue sends, or to teach
>> those paths about the binding?  The commit message mentions neither, so
>> it is hard to tell from the changelog whether these were considered,
>> which also matters for backporting given the two Fixes: tags.
>>
> 
> Yes, I think we'd need to exclude MSG_FASTOPEN and DEFER_CONNECT.
> Those are set by the userspace right? So it doesn't matter much if we
> don't support them with devmem. Not sure how to correctly exclude
> repair-queue sends.

I don't know any other user of socket repair apart from CRIU,
and devmem + CRIU is quite a narrow use case, I doubt they yet
do that, and IIRC they don't support restoring any of the
GPUs state for it to be useful. IOW, failing repair with devmem
payload sounds like an option.

> I guess it's pointing to more pre-existing issues :( But this patch on
> its own is fine.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks

> I can try to follow up on the other prexisting issues.

Great, then I'll leave it to you

-- 
Pavel Begunkov

