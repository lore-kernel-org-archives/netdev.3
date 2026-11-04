Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778605;
	b=hloQTprZkiVxYGHX8YAmlOg3k9GpgZ76alVCzZxS1ShwcEEJ777Tn2IiXy4Qq8V23pus
	 aeYj+mq8y0H0qsEA8fWob3H2Ay9EupB2PkYhSLnXKAQaBrJec8+/mc77IS/4nIxMFxDqA
	 GgEE82AIgE/G24HQyPdski4UQmbk5ZzVKs9AdTJG+dGk6WenQKWQFSUkk5atSyvfnlLVF
	 gBmCHXU4M4EOV/ADKu5Cq5aVppXlPZuFRF4lh1HKZe1zel3t8DLCOiVtxJnTCBaK1n/90
	 CFYV7CLauRcdszQa77UCWRd2RhSicvOvNDlDpOSyAeTSbhpKU6KxwUMlY1T+xOs9d0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778605;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
	b=fmQBhjcq1CZ/KR33WsFQKE7NGLDn0Dn1JhXT/5MiYctnSphQsptRA4/Nbpk5wLYvUlxq
	 xAAxVXFHLIIKhHLD47X0dR/4lTwtJFTPtlzYhMUeQYyKC0athS+FAZlJFoAD8ByzxRzNP
	 K8gzetx/K5b+dpIVkOlviUckMdW0Mm9qVjXvwbQl+6vK5bNbrNDY/S8t14MwgQKBl6Zm8
	 0cyLza78bQ+WEoWZky5VlbalbUiRD8+J4f2XaDYlIunhpzuvRpWCb1G8A8AG2ecX8LppA
	 1Z6e7G7JE1AFzeBub0d6NQmxNz3sFp9knlY7YcjrXEQdwafmgk28tmkQvbxBEJ8l9AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V8AJvMIm;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qKzi5Sxq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE44606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE44606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V8AJvMIm;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qKzi5Sxq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793778603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
	b=V8AJvMIm7Fjq5oMgFpfDH3WqAFea2WKeuzaUPl82I9jgYNUH34iKcuyKK2UOaad1UXtHxk
	jInwQ7VZ3MsHpQYkZTRw/2ZC3y54oQu6e7d/0qqMnjDwic1UsCHY1cpjqKXaK7yDwY841t
	B2yUOFlzR3nBZt7ey8ZPmLkjDieSfpw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-vv3PaSIcN4a1RphKYvibtQ-1; Wed, 04 Nov 2026 02:50:02 -0500
X-MC-Unique: vv3PaSIcN4a1RphKYvibtQ-1
X-Mimecast-MFC-AGG-ID: vv3PaSIcN4a1RphKYvibtQ_1793778602
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02b91f9so934959f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793778601; x=1794383401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
        b=qKzi5SxqIWqs9ZsKdOd+t1iNy79a30NRHNhmCIvIv6UVb6aOvgmEU8yDg46fhFE9rR
         hwdpiJouIrsDETUGVEIZwkClVlmIDqhH6GK8Mr9zGIxA8fXSc71wGr2KmM5tDaF9TAln
         ASjQjj4wLn77dy4jlwUZr2Zf1wIJ80Z36lVTxhJq2N+jYleRKgYW95GGybnBi7A5Qy4X
         r+S1o5tXSwb9kl00ljAE+McmBImOsYVPVxRVlc3TlMs7RMqXDe2EABszPr+ZrEnjOKaz
         bxnpqpOa6nSts5w/NKgkyOCrqN9ilJpkOaBmaVtVc0wfryf1pNAAPV9O59zxBFUpqz6H
         GB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778601; x=1794383401;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
        b=eQmcTuaQofkzy6qm87Vbokd4x1jbcdrQOTYfsxCcj4NpooLIuIreUl4iA1WqN+R0AW
         IsmyVUzsDzgLX4Y21cOlILmViiAhg/JAZqJUz0Bv1yx9XLoP1mGBjnskhmPDhRR3QVVx
         hBlPQoxkp6B4N/kMi25CDabESa/2eOeS3z/NhvPxlYEjwGfTGxoQHCK4NfrHHSk2J6jx
         VaL6pCA+YKeOg1IJJjir0uTLVvFdc8raCDnH+lMUB3xjN3gpDkSdO+M/QpC+wWgJhtGJ
         ZNRWRgnjhQ42U09+UT9d8UejIi4sjU8Zl4iaQJ9zgJ7xK9xIyOqPFzhl4fx93VrJ0XCc
         Qquw==
X-Gm-Message-State: APuU4Z/qImzuna0U+OSMj8jWyN4OdPjkvdFAHbxNueAxCY1jLBphCYSV
	+8F37xeI0XIO3/wtKa+oBQl/OXXXLFjBmgUR4kFxQiUmJ4uHZ7mRyhS6rvO56+DAGvrkeHf2szv
	jtGehhgoTF3z0qQJIJWKzkDQxfI2wrIjipZUDTDl33yvl/M9um3zYhaXPEw==
X-Gm-Gg: AYBFou2Acf/KdXGzTN0jrO5UkDJeEjpqb2bBnmsD6oqIvU61SiQyVNum4h6fSrcgpH4
	3My4bnNjRj/oXjfKQLTUGAr9zdNN7HOvuUk2CVc8Vm0dH/Mj3gXu+AU+fn6Znss+tz8xV65ZrhH
	341/eicDjwi+HCNdsdKYWH3Ql+LXKL6RYQGriQrshIkLow5uj0I/2mEvPTYwvoZyZ8uPhwHLbay
	luDEXiXFoQ2u3DalMK2+lzR6C0qyysqWkq5zoETnwXn5BhNHpCRr/R+NBgPShKbdeny8PkMcFD0
	N4oz/t9jORZuiAj2cJpvxLPfBg0uqUQjFVujRPv8k0Joqu1e1QlNW5C0TLD5xa1nRUvda2n9MMd
	3zgWLaKu4l6QwKx3QfO0718RQr8wbBBUpGgh8lU3BEeuoJzv9BIqO4z+YWh6ucQSuTJTFHyGU+q
	4sRr95XCaABuvGUn24Clg8ng6yM1C33p3ruNwCtlzUD2E=
X-Received: by 2002:a5d:584e:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-48e6e2e2369mr36435246f8f.22.1793778600112;
        Tue, 03 Nov 2026 23:50:00 -0800 (PST)
X-Received: by 2002:a5d:584e:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-48e6e2e2369mr36435196f8f.22.1793778599451;
        Tue, 03 Nov 2026 23:49:59 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm2308479f8f.47.2026.11.03.23.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:49:58 -0800 (PST)
Message-ID: <9490ec30-10db-42cc-8071-2e8cd5dc5a3b@redhat.com>
Date: Wed, 4 Nov 2026 08:49:57 +0100
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
Subject: Re: [PATCH] net: ethernet: ti: cpts: drop the refclk mux node
 reference
From: Paolo Abeni <pabeni@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261103102858.1340800-1-vulab@iscas.ac.cn>
 <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Content-Language: en-US
In-Reply-To: <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/26 12:23, Paolo Abeni wrote:
> On 11/3/26 11:28, Wentao Liang wrote:
>> cpts_of_mux_clk_setup() obtains refclk_np with of_get_child_by_name()
>> and only drops that reference on the error path.  of_clk_add_hw_provider()
>> takes its own reference through of_node_get(), which
>> of_clk_del_provider() releases later, so the reference taken by
>> of_get_child_by_name() is leaked when the mux clock is registered
>> successfully.
>>
>> Drop the caller's reference once the provider has been registered and
>> its devm cleanup action is in place.
>>
>> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
>> Cc: stable@vger.kernel.org
>> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> Please have a look at:
> 
> https://elixir.bootlin.com/linux/v7.3/source/Documentation/process/maintainer-netdev.rst#L386
> 
> also please note that such limit refers to related patches within the same
> series. It's highly discouraged to have more than an handful of unrelated
> patches in-flight.
> 
> TL;DT: please stops sending new patches. Likely a very limited number of the
> one you already submitted will be processed; you will have to wait a significant
> amount of time for any new contribution.
> 
> It's not the first time you have been asked to comply with sanity limits.
> Please respect them, I really would not like to be forced to blacklist @iscas.ac.cn.
I see you ignored even the above message. I'll proceed removing
from PW all the patches you posted after my previous message.

I don't assure that the left-over will be processed.

Please do not post any other patch for 2m.

/P

