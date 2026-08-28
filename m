Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF3439909
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920670; cv=none; b=TzHf/6D8BPelFX/IvDV/4n15BQbOyt/pGPZOGRUj8svmgyvVtdAJmEzq6+J/EcyoJosfG18iP9ZGz2+UAMMd9Sg8/zt+83CI6oy+sRyP6mduI8PofGJBNjtI1IGOsVK9Mg8rJIHtlam8OcZEHgRfofZrP+FFnGKaixFvkJhCrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920670; c=relaxed/simple;
	bh=aecsmX2x4QGyjJ2aUdyYlUgsK74USnPlG1syju1rAyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVf77McVdoyJv3M6PhUMWO8HQSRtXRGEQp6XspJp4aCIl+uIGoolpVtxYihDYgWbS0dhDxyRaSdVisylx29fr28Z/LHIe9ACttRBDwdTkUTvyaf1oP/UtJNYWPpGvA7Hqrp07k7OorAJgnse83E5S2fWMYkxiEMquCLoZfp59dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QowVZeF9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QowVZeF9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7131885e9.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787920659; x=1788525459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Htljc1jy5vbyDxB2+F6ZhJTpienRDAzM/B8CyFyuNxI=;
        b=QowVZeF9ShxDC2mG9ONUFD1c0zFbd3V+RaFjccwT1ZiWuyc1zVzQcjnc+4gr2e+rnT
         X8uz15zzM4noh+kIXV4/dgdz6O/tdWbTs85SKrbkXbC87mMuRpIBzsrVS1z2VTysZ7bs
         XXGW8nFcM1aCTQwakqH7JSm+P6DCqOVYogTlyXfaGxTmTFR3ao4MgncBz06CismQwvrd
         78Owtq85evk/vSxXex/hg1WU7BNC1ppouWXRpgaMYaGWZdr+ZaYuouPWxpr52yCCGZV9
         wKuPDAJrXyW+t8INlxtfKlP1fIoP/dU0KbVkg+1cSNaaHEXdV3+9RmKk7cQogEXwVMoI
         +/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787920659; x=1788525459;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Htljc1jy5vbyDxB2+F6ZhJTpienRDAzM/B8CyFyuNxI=;
        b=HqOHBd/Ll4DjcW2LQp9F1a6ehiFeN5LHBsM1ptFBLs8+FfpIb4qyWVshPZ4ZuBwypa
         15ZoxlcY/DXUuiRei/aYshthY8+Y38MzmwrybdyMols0J0WSbWSlwXqQhiuczzI9taTY
         5csqCdyjA3QPZPidtU17kI2Hx/kEPEiBx7KwN3L3qmZFiR1duXBBsgIRYHDuXPhhUdGo
         faK4O7g7CH4QIhjLUpk1nlRctVc/FPCH3l0zSZcV8a3OzQxIblkfo2BhiA6CjSts+RvQ
         HkCZYkbCpPy2LPJKfEZityZaPWYHXfisT/cAnfGJ88LGWPf9UtKpzUY6JNQh+O9xlbnO
         mzpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMWQ/Wrdd1/CWY5w+uyUr3TeuCiOQQ5npe+E17GNvOoLwKnkXU3qXu0E2gekJbNBSIWw7XAXY=@vger.kernel.org
X-Gm-Message-State: AFuF++lMvI6qzKGnYd5ejTzliNA8v19U7Ds59DkcX131MQJ8sYSrAqIp
	rNfyOtHVppMRp6pn8txCMS/Ub4jHYe55D8NhalcU5GnpLiG5MDkRlvJvRDtUkQ==
X-Gm-Gg: AR+sD137imM5VZ1KZIaAQCUe/XW4p5ialwWUw0kaMM8UjrSzMUbSSHtfmme7t5Igbhg
	oe0VRRUabeStuODBsw1kVSnhSLBLoNeh57iZfFuAFHk8R0ki5n+MtEtHOPWO+yWL5jZPPbXAQy/
	4A3AACk++5DwpbEcJ5K9MFzNUv5penZuV1Xn2HWIqMwYX2S+TziqVGNKCVmdHhV4zuKCyONUlS6
	1Q7MKu5wCy+PNGizpsoC0mIF4Z9WVtNLKcDxvpIe6r4bqWZpG9xK00i/MMg5MchqaZlebISydSK
	/cTjlqBTuRHvwGaSJFXj3AvvQIoc/vRbAJwlT6dlTD889wARiszyFQ4ovwEFDYLbR3JW02Rvmf6
	26nCnx8IwyZG7Y7WuB7yKAI17ruFR2EhoyIgrl35wvV6GQaAFock8H6PqDRUvKZmLQeBdaNPCue
	y6WrI/Vvld5KwDvUG8N1vNKibnUsPVYbAWUrRQOP0S09rXsT7B2+/Xgz9B2XacXD1aC5YHDTV4e
	j4GrzMCydptU6+nF6Kn6OAa9W+wlUwwg0QTU4/BL2zPDpJZgNNTaybUBn5KNFywPdDCFk2cz+to
	UqX7wWsUUNeOZZs+2A==
X-Received: by 2002:a05:600c:3549:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-49b91c57464mr88153515e9.10.1787920659134;
        Fri, 28 Aug 2026 05:37:39 -0700 (PDT)
Received: from [10.218.30.141] (82-132-213-132.dab.02.net. [82.132.213.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c9cf95sm46448655e9.1.2026.08.28.05.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 05:37:37 -0700 (PDT)
Message-ID: <0db1151c-35a0-4597-b69c-091b60cb864c@gmail.com>
Date: Fri, 28 Aug 2026 13:37:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
To: Mina Almasry <almasrymina@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
 <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
 <75cf5a10-f7ae-4b4d-ae47-1556a30d76c9@gmail.com>
 <CAHS8izPB6xS5KOKOUORvJ99d-mF7F+9gZCFe5aoQPQpUeDhWBA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPB6xS5KOKOUORvJ99d-mF7F+9gZCFe5aoQPQpUeDhWBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/26 18:29, Mina Almasry wrote:
> On Wed, Aug 26, 2026 at 7:36 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 8/23/26 16:58, Mina Almasry wrote:
>>> On Sat, Aug 22, 2026 at 3:57 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> ...> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index b4237d0e994d6..1e34f50770446 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -1170,7 +1170,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
>>> msghdr *msg, size_t size)
>>>           }
>>>
>>>           if (!sockc_err && sockc.dmabuf_id &&
>>> -           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
>>> +           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY) ||
>>
>> This check before your diff fells off. From a quick look, via io_uring
>> you can have a sendmsg call with dmabuf_id that would happily pass this
>> check but never goes through net_devmem_get_binding() and
>> msg_zerocopy_realloc(). It's not much too problematic for now but feels
>> dangerous to rely on it in the current form. I think we want sth like
>> this in the end.
>>
>> if (sockc.dmabuf_id && !sockc_err) {
>>          if (!binding || zc != MSG_ZEROCOPY)
>>                  // fail;
>> }
>>
> 
> OK it sorta makes sense to me. I think we're making a mistake checking
> SOCK_ZEROCOPY/MSG_ZEROCOPY when instead all these are conveniently
> condensed into 'zc == MSG_ZEROCOPY' when everything lines up. The
> point of this line was roughly 'if the user is trying to send devmem
> but not MSG_ZEROCOPY'd, fail'.

Alright, good to know as I was assuming that. Let's do it like that
then, I'll send a patch.

-- 
Pavel Begunkov

