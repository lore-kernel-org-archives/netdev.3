Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8540928B
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845847; cv=none; b=RFtZojxKHHmYCmQVszo0aZpwqZlbr1dc2JUnd9K//S30UWeZV/L36wtfmlbq2Cgjl1lICpj7VAYAGCIEITmMRZnIE3SpNoZAjDedCTK4bMPHUHuZBJe46YzRf35DIcXsQ4ExaNhLbe239+cfdZRMcF5YzPlnkTV/d4HQ9oDM/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845847; c=relaxed/simple;
	bh=3hJCZFOF2Kt5aIHoa3y/x0G1EUnJcVAGGBJN7jikIMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovb2gSSwi9QOX0+wxmzwacuc9emWKhlN+n9ulKw4GBtFcCA3kqBq/YCoQCcXqIY++FvH6Z5o87XXDuR8a0qW5IB3+xjUgZRkWmkdBFkqkrExooFPEbiY9wLJPlbEV8i8po7wE3+kgktTWnHG16D/h/t4ICxWcMlu6QOFTgFEiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKZf+UvI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiGXL++6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKZf+UvI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiGXL++6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790845844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrHIwX2s5ymEdRKzwilJtkL/ddsHGrLKKobeBr1tlAE=;
	b=HKZf+UvIXKz9tnUZYKTigLjnSRKOoYMn8MPkc9zVtNo5JX/jleqeovL2qkSpk6qb6LnLKe
	Pq0TLiNGpwHslq+SQSUajKvsnQfZl+fL8rFjtoJtz43lpP4bjDYX0C8P+jchUS9+gdRZZC
	/fuTLXxOY3M+UWJETfXSHEzXaild9y0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-QP5Y1w7fOFqEGggsj2Rneg-1; Thu, 01 Oct 2026 05:10:43 -0400
X-MC-Unique: QP5Y1w7fOFqEGggsj2Rneg-1
X-Mimecast-MFC-AGG-ID: QP5Y1w7fOFqEGggsj2Rneg_1790845842
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a025178d0cso727525e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790845842; x=1791450642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrHIwX2s5ymEdRKzwilJtkL/ddsHGrLKKobeBr1tlAE=;
        b=eiGXL++65sIFtJYYNE4sI2fvMYas6ciWNdFBAa6xG4Ph79R4v7cMzq/f1W5olRxsB+
         vkJU2m013lNVwQXyRiX+YG4sbNFg3al0XiuXtdN28w5rAo5amcwwyR5+w8mZnEQyeyRC
         J8AXv5JJB3GCIz7KbsBofdjtFbhGxW1X/S7Kg+CCoqOPdhDN6QSWj6mh1toeWSVpD2gb
         dMwaieOJVUjW7PEgmr3DWNL2GAZHgR+esJFitdpWFJTdE4A8ShsXtZs/CPZ4Aq/MSz6h
         qZLqyB6OMQXb6N/CZ5JMn0y6jzvYmtrNsswLjf4JERYXY2gAOjXFxkj2Kf770iqtcH6A
         lI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790845842; x=1791450642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrHIwX2s5ymEdRKzwilJtkL/ddsHGrLKKobeBr1tlAE=;
        b=qEmgctwZguizlotiNnGyNiwtWG8NNzDpN4Xnyq58ithWg18H2Jav1NgImn3cC/Z/V0
         8i/lMj3g7eUN3kBBmZCjk1oD6wY/c19//vhAQWu4O2jAFWFGKN5ENFhEX1TqlcZkIULK
         mae3CKGxfLMpTGITtIbA+ruTvp7sHkdC2KwSpDDAjFXQMMGxOesCv1D2pMsq7bwi3dB0
         6c+de/yIJucXe7KEuSlqo+anxUm/2qDAwyGaZ/X2Ixf4EnkuPa9N64XdlFhnc0Mdr2X8
         V+ItNSuQlBY1PkJmUHXpgce9f62oiHgb5IOLyFHaNLHhdpJiK+CVbm3pjZGJjqOJVpSg
         H3NA==
X-Gm-Message-State: AFuF++luJa//UAqCKvuKgNHoZGSzZr5OGyK/NhGG0nQcT1Xx9yITKPCh
	wCcQcTE2pS6BIW8jS9Pt6zXT4lAQePQdtxT9k+XGo3dKImH/C+TBSf5hqVm1E7CksX4VdLemnXl
	3Y0XcgpP6cRbwJU2ghpwW9Rywy775NmP0XXi+zP0dWq8vW/39mWp2ofPE/A==
X-Gm-Gg: AYBFou1kkQf59cRlvZfuZe4ezCImSskxPqOWMYdKFxdw2xpLX27o3m1v1rPRyUBTTr/
	JU8UDON6Oa/aq1ttEefOiQDylrA82E7QFS7yluHd/lmVf0oV6z/WHp6VcFGpbyAh7HusTE+NE5w
	n240aWKOif5GKqUIzOmXDE4weofjCzVPsfhET6AP5BB4SlMme1xBwZI/d4mrYIXlwC+ImuUUpi9
	HmfG9gaqvFQNGEDln+Ag/kl5fMy7jfPCeHrg5QxGJYqEy1WVfQ9v1Z4WF5gyqLETm0pPolVs/r9
	831qlU+iPM/wivpgyH88jHyuAESCFpoX9ayS0++mKj0FW+k0OLwHvZHZxiWIVd9klG/3KA2kTP8
	ZA4iM0hZSWG2THhaAeBF5Xi8zymQpunN1Qpe1ZxooQtoOhHGN0pt4h/eTy3+5z2e+fX8j+lj+3A
	==
X-Received: by 2002:a05:600c:46cf:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a01f9e631bmr30046655e9.7.1790845842223;
        Thu, 01 Oct 2026 02:10:42 -0700 (PDT)
X-Received: by 2002:a05:600c:46cf:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a01f9e631bmr30046215e9.7.1790845841740;
        Thu, 01 Oct 2026 02:10:41 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ebe694sm24809015e9.10.2026.10.01.02.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 02:10:41 -0700 (PDT)
Message-ID: <3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com>
Date: Thu, 1 Oct 2026 11:10:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] tcp: annotate lockless access to
 sk->sk_err
To: quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 14:47, Quanye Yang via B4 Relay wrote:
> do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
> socket lock and clear sk_err with xchg().
> 
> Patch 1 covers TCP. Peek-only sites use READ_ONCE(). On the no-data
> recv and splice paths, call sock_error() once and only stop when it
> returns a non-zero error. tcp_bpf_sendmsg() folds two unmarked loads
> into one READ_ONCE() and uses that value as the returned errno.
> 
> Patch 2 does the same for MPTCP and annotates the remaining subflow
> error-report peeks.
Note that there are more possible follow-ups in tls and on the write side:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me

/P

