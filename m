Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804863AFD1F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643003; cv=none; b=VJnGi9w/UDoeHuoDcx1aTXUNMVf86hirdcmR7204GPHlg4R+lyy1Rk16VEKoP42IJoOWQ2vWm/eTLvhJRmsVvpaLr9cXWQQ7tO47m8oMn1bCLnBITxkxs+eID3H6RsYqR07wg/4tj0ppJG3YUvJHK3Vqag73sr/UHnUkw/ETUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643003; c=relaxed/simple;
	bh=DKEME0Ur0oxvw24+YrseXOXTE5INJvcX9R04D8gPV9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhAeAls00zYcy51kBp2nq1K6qn81kwifM2dh3AMaR7ZmCUYmfWtAWEEPkZu5443m5Agk760x/8dE97fOKrfT85qIdj3oVqEh/feGaeAUqH3/yOVlLd78Zk5iXEfhNbvVqKk57goAm/N0aSUpVXndxgNzkf5DubO2/vjuNS3/GvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gehnvOZ4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBbZOcxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gehnvOZ4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBbZOcxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786643000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ltp83lDQGxXs0k3gDMM4riDzDEKI2gvO/dw8tndTQwo=;
	b=gehnvOZ4kVhfTStbYxeNdQ8y81T4ojsl7BVdrr8WxkX4lySt8kdxxlEQlJikUEsnLHXrdF
	X45Xt2TGS/x0FG37KryDIOXivG15pDACKh3jyk4IQq3eHO6vOvOHDk8J7fgaWXr9Mk1F9q
	qyW91vghBim8QDzjW3p6wxlTCNNA2UU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-c_hjRJlmP7ugFDpnt6TTSQ-1; Thu, 13 Aug 2026 13:43:18 -0400
X-MC-Unique: c_hjRJlmP7ugFDpnt6TTSQ-1
X-Mimecast-MFC-AGG-ID: c_hjRJlmP7ugFDpnt6TTSQ_1786642998
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so898525e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786642997; x=1787247797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ltp83lDQGxXs0k3gDMM4riDzDEKI2gvO/dw8tndTQwo=;
        b=fBbZOcxGpwEs2PActMStb0qkwBerWfuChpIXofLXpo8IEWHpl46zLCxPxqXBxFQte4
         xfUry1YzR10hULY+WxhpZ/1B+87zNwG0GIpsgohO920TadNY8KLifELCwW5KlTeCKXwU
         va6uh1K9fFJ8mRYiS6183+Gg9AljCcbgdBFftKor5w30nmyrsBkMGS48pcjMEQYiEH7w
         QcraFAxl9boHOTyR7fZsU76PBeMayiUE6ah1o77Tlxzd7V2JrvLoJqs6+QW6as/gLaKW
         hJf+I3nWHrXaWuqACQe6+kq9L2VriEgObFPHlyJtmb9+w3JZSUn0WXQpaZ2e22K1gVBs
         L+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642997; x=1787247797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ltp83lDQGxXs0k3gDMM4riDzDEKI2gvO/dw8tndTQwo=;
        b=T+4XV0GxOzLLHGDLBMTOyQ7ZiUlYEVQLBGiPrGqDqjVeSxhaj/yWO1bqvxnqsYkwT/
         X6F39TauNooHqlIvO1JgGTgUNS3LCn4QsMQrk0D9fLQGe0ic/Y+RtswyjvT8gEQcCrvS
         la7lhmhl1k3YeeIWVVFzUHiPqq/SADXjEv0eMAXJQ9rS6/6jSPH5OAABFlmzAP2YCwiW
         Ngrdmhsg6F3JAJ/OMCnwGbcd+fN+ZK/ZdT9daAcILoCE8HFrksDdtxzR6TonVeYnL+r0
         XWco9hYSSfRy/HanlwrgVKvhirn9ReL4IrIqG2MgAtXIECFgWvEHYRL2rGP+XFOQs1FM
         Yrgg==
X-Forwarded-Encrypted: i=1; AHgh+Roc2cv1qZnrKSJUPMyomATSLhAED8ccpuW/kKZUnazQdmCYRPr4V+2LR9/wCoQ+U8Un1CZfm7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8d/jvIkn5zbrPOUrcp8MMOV5wkFyeh+q8YLOAWkn7rzt2vup
	uEty8fzchbvrVaYHE73e4Y5eugd5mdZ8S1ueIFRSBKIQ2sayQPAI5FUQY+fEr5lrwmPSzaAq7v8
	hL+WCFROFmomaR06G5dvwVakCLgrX9Zyms3eyrbDh77zWFdt8NTNxvlOHWw==
X-Gm-Gg: AR+sD10bpbuF3/59yv/o1TMDpFLtQJaB2X2X+AvkRbX5vcL7UkwHNuJMgh2UcLRtTOC
	o5Qh2imTctITDBkcMNuaHhXqJdqerS8ZpV57QZhg3Uq0XR8zHtnRkAZswgrU1OxDuWPrnmYAEdm
	aZJpflDBRT2v0X9bAzmdR6pm+3iHkG67xri8NW9cvi/TIhNWhMu2u2jxrVEOijaiJYabwfyBRi/
	3T84oiA2jHhYVbk1WTpY2zWsVfy2KKQZCekkfZYjhs+Pl6Fuu4ZbdBZT3fVPZAEUGRMHoh3wA35
	9biElGc2pKEiVnhqyCykOOMsr/Pqoiq7IcHv8eSH/gPA5i9vltHxXuzKiwnLRcsiRO+1E5Hgrum
	c5gau2xGL4uw6S91b22z4kP+D4yGBqqR1AjnaFrRPwCTH/qaHElNB/MRQBRiYl5++wt9ewkbmfm
	s=
X-Received: by 2002:a05:600c:8714:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-49987935852mr2760795e9.2.1786642997578;
        Thu, 13 Aug 2026 10:43:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-49987935852mr2760255e9.2.1786642997230;
        Thu, 13 Aug 2026 10:43:17 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005b0sm926256f8f.8.2026.08.13.10.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:43:16 -0700 (PDT)
Message-ID: <41ae2a16-4437-4ad4-8daa-1f9cb9893c81@redhat.com>
Date: Thu, 13 Aug 2026 19:43:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v7.2-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
References: <20260813152104.256382-1-pabeni@redhat.com>
 <e5a958af-4144-46ab-915a-84fd2075d383@redhat.com>
 <CAHk-=whhignRFf-8CJ4PTw74dX6rr9N+X-j37rcM6oUB-ZcZ1g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHk-=whhignRFf-8CJ4PTw74dX6rr9N+X-j37rcM6oUB-ZcZ1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 6:42 PM, Linus Torvalds wrote:
> On Thu, 13 Aug 2026 at 08:32, Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> A revert for the blamed commit available here:
> 
> I took the pull and then applied the revert directly - I assume that
> was your expectation.
Thanks, I think that was the better option.

Paolo

