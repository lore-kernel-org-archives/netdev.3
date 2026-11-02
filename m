Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633385;
	b=PrtX9zUhjGNpp7VkClZCgHnC63iHkgpaI2QOeiaKnTvauXzwkKnXrFjXw4239Eye4b1d
	 QLu9dpXB4NGBp9lSXR0TI+ABPjuCP39NI2VCJCBVUp84OUn2q2vzoJ+PVPsqd4bs/t02g
	 KDb9DEz8RbFYMofpnQxak+VYfOZSKqwRdvuPx2H8tZa+OF79tQbVfQ2Db9jU9AIM8pmis
	 MRw4EVWX/9WDKa1Z8i8JPpep6agYMlQ9UGgH7ogzgESG0v5UKySO/rUAA93Vga0sqG8+A
	 +kAuTEUyLc7qM8N7CaRaGlWZReyaxuUpSb9tAKGb7KvlJnNtbr6J3HT97NyFzbF5QHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633385;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
	b=3c9jgiEf+0YemPBA0losEm0rvtbwDNiWY+ORCmbuRUsH+A/mPj9RkUaaq4ZD2qyjoPz+
	 +lfIwULkX8eeXWu5523sT+WUMYQacZne4Anq8eYEFuqPBY/yjSChH4YaaYwVYn8rB2fS4
	 CZfePjXvH0TiF83MPg7DAT44Z0Vl0G5jgljsDnuoa6eZDV1I3T2mw7S8Xzrcjj9j/9QYL
	 MoqTmGdrS44dcOAsinduCq6r/yVujagMCu5BVul3+RoVpfjbVWSAvdmnz1/04ZKvbJrZi
	 3DlQkyPfLkiJdXHntWL57jWQsVduxHTDAvU5jWzXh/j7c5dclqY6nzRiEeCbbgbdyhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvXQHGIB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FIHV37GA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273696086951
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273696086951
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvXQHGIB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FIHV37GA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793633384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
	b=cvXQHGIBaOY0vkQQL+xRf0PdTa43xJoAqkHe5yvohAycfi0JDDbt+Y2JwdmQGbkXAkhAiV
	5qXM6FLS4aZoSg6M9M/RYo25GT8VY+6NUpL5cODiVTQg9ZY4NBbH8YTwm/AAtJjn9XWFtF
	dMjpfvyFFQofXumPVcVneGThZ9JkMuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-6sEYJZs9OcWoX0pZHoyVWw-1; Mon, 02 Nov 2026 10:29:42 -0500
X-MC-Unique: 6sEYJZs9OcWoX0pZHoyVWw-1
X-Mimecast-MFC-AGG-ID: 6sEYJZs9OcWoX0pZHoyVWw_1793633382
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2836029f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793633382; x=1794238182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
        b=FIHV37GAlFA0eFUGkx/hE9mqRhtFe7tg044Aomyq1ZcGPEXedP4WDRWG6pxQjuO9HF
         31HU+ZGGCc8bsSSTDjnsYpBzQqI89M7mjuPpHRQCuS8RUgqEQQ1dEDuxUZwSmC0ZisU2
         xEAux7BJAe38fBZ3rq7JQ0KYoadNzVSL71xEikX8xGFNqEvC2/m+Awit2au3WrzaP3BB
         Y5JF/Oj+t5HRU+pw+eWJYQa+Z/Fk5xegmmjf50WoF84sKA/kSff5Gzql46+BAO4j1fOL
         4lLp8Djbv/SskHig07Dkx9Cp7yU0nyQELrRRcHh68Mpv+IJuniXap9VmWe04pWd88Rjs
         CQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633382; x=1794238182;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ttXRStBxZjXNHjuvGXMWk9I1gtHZhhcUuBKOaR2A9w=;
        b=U6R8ut9mFRMTJJNpPl4SV6EOafCKX6PqU+ktq0gtXssYHQ5SuiTHyysZ5uP20kjkZS
         g9inNr36cJPVKDf3pcJwKXNbJqXIa8yODcUYe6YJzutjlyqOqIQKHAG6OXvnlOQUeoju
         S6mfBVs6haV0MgCuX2YlItX/4dU4VbwfqFr1yLjFKOSxM9tfcqUgctVvmTua9G6tuC9Q
         Pyy/TzBISD8V614sFJDenlm0Y7CnXGmrQpx4uEWZtTDuoO5DclVQEYg4NWxeJXzyDaod
         6liLED+CSz8JdxP1mvgYBcYStj2HKB5VlTgkBKiR0Yo4/7A0RqY8Nd/YRzV1kyuDYQ6C
         d81A==
X-Gm-Message-State: AFq9FYJ4Ltn3x9a2BAoF1Wv/YQ4/S4GImWn+qd6W8Mxl1ZA3JL9jaCT5
	0bN7enyd39pUhCXDTckpY3bAeoTr2oHlBMguOpCT3T5l/BNbJOKhQTQU53hkNfxl4WVMlsTQyzR
	EgNxBIfH3tJMGZAGb30D7r+lFh9kNYmmGnrW/qVZZSWjw8eecmrPMBIiSfw==
X-Gm-Gg: AYBFou3N5fDMzPsic0DYE8jpU5pyE0RmiulSEHeUtEJ1SR+flo4/I/1R/eYy2VOS86P
	H+FbiHQUc8++eu9no7xhLz5dQX6zuS87NEupZQ/t5BnPsXMFoDCBxXSFgFiC7W0vBqFDNP/Xydq
	rb94ZZsxfJYBh1tmxK908L0z8vIHm9W8GTQuxlfvYVb5XhYM+3f4alaBcTMp+tqotaxkHPog80w
	oTiy6sGOxs0FIwn8o9FzOqwgNV9P0ZbU4909ZmhjxC6MHvw6KmB6zWH7AmPgaJF3Lm1QIwFoJex
	9Wv8VCf3dSHq4DgnnqXB5uOyfD0QlTWA8iFNnVqEdRpOvpn/mp+F9G0lCwbVW9tNeBCCg3CmX9I
	AmQUvWYw2/TrtKZPdXNfnkcSROuKJBD6IfEXeCGLDPQJSYkLlZC8dNNim7zS2ZPjB6Yxqs9WmVa
	KReA3bg0I7HrkKfPB8dNwSD71yyldFUtYnA2pYunqDGPo=
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4ac185bd243mr241030165e9.17.1793633381440;
        Mon, 02 Nov 2026 07:29:41 -0800 (PST)
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4ac185bd243mr241029635e9.17.1793633381011;
        Mon, 02 Nov 2026 07:29:41 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm352011105e9.4.2026.11.02.07.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 07:29:40 -0800 (PST)
Message-ID: <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
Date: Mon, 2 Nov 2026 16:29:38 +0100
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
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Mina Almasry <almasrymina@google.com>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, sdf@fomichev.me, kaiyuanz@google.com,
 kuba@kernel.org, bobbyeshleman@meta.com, asml.silence@gmail.com,
 dw@davidwei.uk, ap420073@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org,
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 00:16, Mina Almasry wrote:
> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] The dma_dev use-after-free this patch says it fixes can still
>>    happen for RX bindings made on a virtual device that leases queues,…
>>
> 
> I know about the issues with leased devices. That needs a bit of a
> rework, which I have done locally, and would like to send out as a
> follow up fix.
Will such follow-up rework the code touched by  current patch/series?
how much? I'm under the impression that at least the fix for the issue
reported here would be quite overlapping.

/P

