Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B3360EFC
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816553; cv=none; b=pG8v087eciP1Gwxar3bTA4OxK2SUfBDgsvixXoK/To+O2KRUR5zfHynbiY1/XUDaYp/yd8oHFSXREYpITEwq4Fm83IF0UkkkBSxKu+v9ea+G8YhVZX43bZY04sMUC6CEunNFTEc0pwLMJ9Bc4nxNMmxNHZwFBt3xjaO8vWV4PDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816553; c=relaxed/simple;
	bh=5lONB/RmW0Flfioz0g0QuoYagnCVyulcy4xNZsg1NNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVuhjIHmNruwlJ93i5xmGUNGruABXuGcG1XTYpRkrf8jITyeRtUEz/lZGH9Rj9xc2bWt+Vbot8u7yrqgwNnAvsx6WFOZ/alKgKzNBoRKJwrH5QgJVp5mc/Hu8eXeojJieWS05D4oiQzzNQ8SKyHYwm0I03QctMTfwOahQUJNyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpVgitOu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rlc6TLXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpVgitOu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rlc6TLXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787816551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3BPinrdVBOdDQQQt8BzGf7HdXKF75mHk//qttHKOl8=;
	b=QpVgitOuUvLV7z/YZ3c2Hznvg0hPDSmpJ4tw4BHzqRvF6XQ5PTafIhcWUdq3ZnxatAJJG2
	5Ne5qXY+fFi1+QWaFTzwTc4PcVtwbDcTIhOdAOjgkKY7nlwxU5uUiYeOcbuFy+Z8HYT15O
	p3Jcr/UFDP/KpSY15vXWlh1zKp2NXqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-13PPc4eEOy2FSz_SFzDK7w-1; Thu, 27 Aug 2026 03:42:29 -0400
X-MC-Unique: 13PPc4eEOy2FSz_SFzDK7w-1
X-Mimecast-MFC-AGG-ID: 13PPc4eEOy2FSz_SFzDK7w_1787816548
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso927649f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787816548; x=1788421348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3BPinrdVBOdDQQQt8BzGf7HdXKF75mHk//qttHKOl8=;
        b=Rlc6TLXNAKak7xDHnUahwcJ3r0rwq9kOgkjxLcyzgjiFf/UXJPvQBUFEy+4P+1Qyec
         1RuB6gkeKufSS3uNzlea/IEV0/d+GbviSi7rt7uBwqanx1WD9DfMeuH17TJGJ8RvT4GT
         Xr+GzdXVGm6/b21+tEQH37+/KzuEK9LEIckE3vM4/fJ6mcmcKeMjr9spa5mKUpMOYGIs
         AxaVeVzYAUmKLLFEKdwui4sN6EPsaut23djbyCBBd5jee8UHlaORTzzsan6WwBoCmNx4
         p8q1VgoPfiwZS812yXplzsdsxGakq7Dlz73oMgu52ID2JhEy9hDzh8ztc84RG3QNPDl+
         c3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787816548; x=1788421348;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3BPinrdVBOdDQQQt8BzGf7HdXKF75mHk//qttHKOl8=;
        b=Gr09t684Xw7/MGM2E+OB+TdshCb5mlGpBf8oX/dLiViBkzYDRvO7WnpFgJg1bukm4e
         RiMXyJI0FNnE169DB44L/ka03tDMO8u+G2xv2PJBi2RMSQRAVepWgpcK9Wawz4DV752r
         93nAmmuzP2kjqwq8ogzwyCtsfzsLSy8NOoeKygzwbSH5NDKZK6P+KZhSDTiNzZG6+w5D
         YJG5VJyOh0lq5y2rtQifO0UNkK48yRPpMRYLDBSPhSuZ5qTtHfjMxukozpTsGKcf7uBX
         mDVd003DrtsZwXSDSsn5wyHhr4O8PgqiClTqfDni1VK0vPW9sUexcx9ap8XIHB0G760j
         xCeg==
X-Gm-Message-State: AFuF++kzXW03e4K/TuwIkrhBrqzEO6IU9LU0tNgphXKD/N7N8pL2gQ3S
	iqxG8OV0kNPPtuQBUBAqLU9IzQq3CFOjHyiwN/JY7juhDhwBMzrnacalaz200mWG/L5kvKtWmV2
	YhRv9eIGMaMdKM2UrUTjLFjGMaDXCPsX98VGpnessBLQRt/F3GZJgHuqgAg==
X-Gm-Gg: AR+sD12yDXLQDZ2O9s6dkZLKkeckYHHLta80hDs0xoB0/7h1mV8xHVd2K4qwfyN+tNp
	S2RzxN0WSW2MGyOHFwCH9c5vj/hA10X/HPy2tC2hiuOXKiqWNPUKQQ6KyK/Af6TcuD26qxI9fRf
	cbi7ZPu+mBdyRBy4OW6HsSBwhNUChmirvvuFV61U1JGaWceWeiHJFS1FxIqm7yJQ+V8JvXnikh2
	w2SsP/istMN47+PXcWSQdJva0RDIBeJ+nCiJjUbhQRrgSSRS+nxxByloiGZFAs2ySIsbPFSS8OS
	sFsGN9NQJwfR6DXqy2HC7tT2WSpCxGBjGTUdM38Yz4hEht4N4GroqN0a4pMQHRv79ek7+kKbRsl
	GvyiAHBhVKxWtDGFnQu7kzj7e1c23bAhxOM7IYe+W+B5GbkFwIY/VgvOdj/2dufdlPKIdybU=
X-Received: by 2002:a05:6000:4552:b0:482:ddb3:d4de with SMTP id ffacd0b85a97d-482e26adcd5mr11304872f8f.13.1787816548194;
        Thu, 27 Aug 2026 00:42:28 -0700 (PDT)
X-Received: by 2002:a05:6000:4552:b0:482:ddb3:d4de with SMTP id ffacd0b85a97d-482e26adcd5mr11304786f8f.13.1787816547677;
        Thu, 27 Aug 2026 00:42:27 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28e8fb5sm6871464f8f.29.2026.08.27.00.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:42:25 -0700 (PDT)
Message-ID: <73331a07-46a3-4349-98b1-b388bcd783d0@redhat.com>
Date: Thu, 27 Aug 2026 09:42:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
To: Florian Westphal <fw@strlen.de>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 kernel-team@cloudflare.com
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
 <ao9UV9S7rUkyQ8jv@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ao9UV9S7rUkyQ8jv@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 11:02 PM, Florian Westphal wrote:
> Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> Replace the dynamic skb extension allocator (->chunks + per-object offset[]
>> array) with fixed per-id slots with offsets computed at compile time.
> 
> Why is that better than
> 
> struct skb_ext {
> 	refcount_t refcnt;
> 	struct secpath s;
> 	struct nf_bridge_info b;
> 	...
> 
> ?

I *think* the layout above would possibly be better (with compiler's
guard around each struct definition).

> Yes, initially this was krealloc()'d area.  But the other assumption
> was that most skbs will carry no extension at all, or, in some configs
> one maybe two (IPsec gateway for instance).
> 
> Thats why the first added extension is also at the beginning of the
> memory blob (that needs to be accessed anyway), regardless of the ID.
> 
> I don't insist on keeping offsets[], if you feel like microbenchmarking
> different use-cases to see if it makes a difference to have a fixed
> memory layout feel free to explore that.

Both options for different skb ext layouts save a few bytes from the
final `struct skb_ext` size. This is IMHO quite relevant as the total
size is approaching the memory partition size (IIRC it's almost 256
bytes), and the bpf ext could make skb_ext require the next one (512).

That in turn should impact performances quite noticeably (IIRC we
observed measurable regression for bulk transfers due to similar changes
in the past), as the number of slabs required to support the same number
of in-flight packets will double, putting more pressure on the memory
allocator and possibly hitting the slab slow-path.

Still WRT optimizing skb_ext size, I think that it should be feasible to
optimize the layout proposed by Florian by taking in account that some
exts are 'mutually exclusive' i.e. on top of my head mptcp and bridge
should never be attached to the same skb, and I *guess* can_skb_ext is
mutually exclusive with most of the others.

The layout could be adapted to such constraints, and there could be
run-time checks (under DEBUG_NET) to verify such constrains at skb_add
time leveraging `present_extensions` and a static matrix describing the
mutual exclusive status for all extensions.

/P

