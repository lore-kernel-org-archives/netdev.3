Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853457;
	b=ktj9Gn7rojDuWQ+CNalH45vrGcVueJW+O3CmeFh4l/ZBUO3ItapuUagwXhAorYR9r0Zk
	 kwXl53BnLhWYY3pOWKlO7JT0t5MIUFeFCRPCRLbO83JRB+5GZRbxN6L5SnU/HNV8HgAao
	 QAJK8tANtVuUhbqK36QcQBLX2kpGNaqRVXV/RFxSTYfqPdU7zL1bTalNICICXPzLJo41d
	 IZ4VrzjcvSKFEUWt93I6rJIg2Xa6Ls/Z4jRejs2kakV+2IYOJPaPi0t0jdimH179ivonp
	 QFZQz8Z5P+dT1uIrhlfduYyXIMXtfhTbHU1tKE3S4LxU0icqHf7kC6zyTuWHIUyDijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oZvBLqDPBaLg4LIS9YhIcduNjIcvPJJjPCa0HY4MKLE=;
	b=4ijnVc07FySRf7FgvSm5kEDmA5kZiYAAXy7ed+wENsgWd2hkjqnG77SG9Qj/fYuE3PDY
	 lGioMZOVr0ntOHvIhqMDliy1tbCa3hXeKmqsEhPZH35Uk1m8xPSoXZCSg7NJUxXwx234Q
	 3Ho1aOu0sK7YIgDY/UNlL+IZYMoyd236DQV78ZWoJfspQhA0zOfhe3K67eZb2X4PRgGx8
	 qmd/I6QZBm86WAdkYhybWmmUnMMqVaLxBLILHnS5izQG37cafJ7lGm2YGBLDii6E+LECG
	 JsH4Pd40XTzc0AD6cT79OI58YUQfIaIIR6EE0Eb84fC23YyjRP0dDewTukkutCVQLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EiE5Zway;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D7606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EiE5Zway
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so9793755e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792853455; x=1793458255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZvBLqDPBaLg4LIS9YhIcduNjIcvPJJjPCa0HY4MKLE=;
        b=EiE5Zwayw2W22SXHx42W0RXZlGb6r7sjWOv/o+rsquZsbY8aCDqwo/fR4qozhHng4s
         emyFdZzmiMpLbf3tKvnHxNEimKUlxMKwoWkAtneaZlWk/HlxPaN8iSfvEcobvL8M2ASE
         E4QDl00GMUNaQjJsF9GHuhTFiBnvF0jvDG4xLuLE7F5tumcwOkrniRB7xQzZixvh/m4+
         MrfYdGetNJ/M7fNtqDjV3ILzx7ILvnuuTqIAaCv4IFRvrbGefvuYHSzuEGx9/9XMqM1A
         P6nOHw8FmRNyOb6sKh8Nyr1TJ+xX75umDDw6+/EiT7uv1z1Ie4yyH+tO9GtxrwbzwwE4
         C5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792853455; x=1793458255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oZvBLqDPBaLg4LIS9YhIcduNjIcvPJJjPCa0HY4MKLE=;
        b=hjL/qhLJglSG79kkVN++W8/yo8It63njugBzc7Fd/FBDfmC1kctZDUDrKgEW4RpHQX
         bfOmH6HKCeOZmoeeeN76oCUi63sgOZqitE3ToNb6mhmzEzA4Wn9Bi401gRGdzBabS3dv
         0w2g05zrSilfWjW/+C+/nAyIMcxoGNsvlqODPtLg02ta7pCMjCI1LaJjn7DH85wBymRD
         aNc5r9hb8eU2ihKj3LWkHne2Ri+kKehrD982YmL2YXGNUQrTYab0mDQcnCm2bInxkHWM
         hEfL3depQ/ChKwgLisD9ojBZhX3nt6b3trxo3AKIOZ71dsv7RiI4yZt1neg9oPfAraRK
         ESOA==
X-Forwarded-Encrypted: i=1; AKwUvBxohg25cBx32pApDAgpW4y9Qo4ZPS0OntzVVg3Wrok0hXOkcxb6mTqStZF0XuF4LIjj0BQJfLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwzU3qE+rWA7ONqu63xp4MogDDjxwqimDxuiSeIHhs0Aqlm2Cj
	twkcBkcqUQJ6vPxccnYTf+vT2FDOMopKoKqvcMlAuO8vOLzSU4C16LxD
X-Gm-Gg: AYBFou0yhW7yuL+Rpw904IEyikAbZ78/c/9vCQ5fhS/5nFrrvb/VrbYGW5zz2TYXEVI
	HOH4t3O8oTUq/0gvjg/3PAsBHf2lJY1rdwHzr10uZDIORXCwqwYG5hOC8wlSMsn6fp9vP+4GDS1
	oY4qMjE1ytSybKZskzvUnGZH2z1Vb583Ox5QLBeuTXSyM7tMbaT3+9J/LmY+YwVoW24hwPyBw2b
	u0b+2uqOb0yg6uY+QxTxarzBVToPpPP2d/9UrvK8AmCxqLloZMJfMEJixxJBH43v3GFv4Qt7Pp7
	/ceHJQ7Zubi9baFVbtH6Y9EaUhUtLTzKOG4pGu9byvcNS4u0mY8pJ2OYTxRv3OO26SdfyGRypni
	psvesLL50M5yCNQaih9EVrEjkObE0pWiWALPOpmovMJLH91Ag3qXbMoS8zvuxASwbssnRkCw3pX
	Wa7Y17CLOPW/6R24G1Wgl3P3IZisBiGcbQqVE91GDMTVncxeDpjMhVCuxuwKcR3tmCOuvbja71S
	kpEvRbC293CW123ncUJVlP9ka306rFcTH/h43UxUa+amMjDfGTdzXhlLhmI2NJpJjsZFWL9J0G5
	rbs7rXkicm5KcypNMigZHBV3FsefwAy/42uFLGAEDMKjHnJMPV9AdcPRiHeByOu4vhXJyENhc9b
	Gb97rjr731jtYAgWvEBh5iD0D9PtsqA==
X-Received: by 2002:a05:600c:83c7:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4a35ac39cedmr33349865e9.3.1792853455477;
        Sat, 24 Oct 2026 07:50:55 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm4424438f8f.3.2026.10.24.07.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 07:50:53 -0700 (PDT)
Message-ID: <b3c2571d-9b20-4f6e-96b6-f3c066af30e2@gmail.com>
Date: Sat, 24 Oct 2026 15:50:51 +0100
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
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
To: Mina Almasry <almasrymina@google.com>
Cc: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org,
 edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kaiyuanz@google.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org
References: <20261019174522.55644-1-kaifengw@google.com>
 <4d5e00b9-5081-4530-ade5-41570e4a5b2f@gmail.com>
 <CAHS8izN72w--+5pxxzg44eCOdaeYcJUpXSeJUoqEdZRRq7xPXg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izN72w--+5pxxzg44eCOdaeYcJUpXSeJUoqEdZRRq7xPXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/26 18:15, Mina Almasry wrote:
> On Wed, Oct 21, 2026 at 8:17 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 87ef6d5cbfeb..2792923f0748 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -1169,14 +1169,18 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>                        zc = MSG_SPLICE_PAGES;
>>>        }
>>>
>>> -     if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
>>> -             err = -EINVAL;
>>> +     if (sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
>>
>> I wonder why it does sockc_err checks like that for devmem, e.g. instead of
>> failing earlier. Maybe Mina remembers?
> 
> IIRC, Paolo caught an issue where we were subtely changing behavior.
> Like if someone passes in a bad sockc flags, it's usually ignored, but
> if we process the sockc_err before we need it for devmem we change
> behavior for existing users that were passing bad sockc but not using
> devmem.

Got the idea, thanks. Sounds like this chunk can potentially change
it in the same way, though I'd need to look up that thread with
Paolo to be sure.

-- 
Pavel Begunkov

