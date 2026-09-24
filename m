Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E522EEE73
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258992; cv=none; b=fBrqk84ikOkrkwoWjmbG0dx8TrXJjf4pVTrm111dhtGGwNdvyTk7fYUw6H1Sy5RRznm4t/W2JihupEK6CD8za1vz5LFDALPefZMJVppm4ruosSsojqlqs+tJPxK+SpSiTVZGMo7IhIsvphgV6R+ySEnI+SF8A2XPGxstpvy63jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258992; c=relaxed/simple;
	bh=r7QqwO78uyRU6/FoscwsLLxUZm3CfxtYbGITbYfAap8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjY8x6rjjjPuWBbwuYV72djxDOCG5ybnnRv31l7X78Bj0fvP5KvmP0IUg08WEmF1xVV6UyzVR2XxM1snOEzXGWyl7AEcAZLE4xo1JOHVa4g2SgQOeDY5G52EzL3tbGbJ7Qb3fCnrVU42C+nMqh/aIx2Qkib+4NaPHAkxwnNIkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Czfs3+4c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fqk8BZ3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Czfs3+4c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fqk8BZ3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790258988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUWGnQOpqm7Tz8B7F9u0qMEX8QZeYjwSFLQ35dQmxW0=;
	b=Czfs3+4co+bXM72koL273eJk19hWwdPgUMar6qc0xs7USxip/zWAVrUFvS54v4xKWsfpp5
	boBFQ+zgr2lPOUTipzVDUnykC5fivp2n9lVQSjTFaurPwalwD63c6xWBKRyog8kXhuBwJ2
	IuRSLH0iFtFzaS71Ide7Wm9qJGpdD+U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549--CUcnKE0Ns-aaQglG7Os8A-1; Thu, 24 Sep 2026 10:09:45 -0400
X-MC-Unique: -CUcnKE0Ns-aaQglG7Os8A-1
X-Mimecast-MFC-AGG-ID: -CUcnKE0Ns-aaQglG7Os8A_1790258984
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cf4cc2125so10046285e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790258984; x=1790863784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUWGnQOpqm7Tz8B7F9u0qMEX8QZeYjwSFLQ35dQmxW0=;
        b=Fqk8BZ3ALG1T/WXjPS0BfUL1iz4RWZri/sRpFI7ZeX9Xq8cQTGZ5SuGcPrI2QDGUYw
         XdxTvPV1gaYu4ODRI2+gLoRpnWYW46BKGhYzyR9ZN7dIx5gSrdlvedOqrlNs/mp1o8OI
         Ofs5p4GiP+Bf2QO5jVrJdB73EoPtBtaL7fBDbkyIuIMBW6YSgJDxDihbWQh813syBbyy
         ioqS+1TOKRpxryhiTJBK43fkSGqB7m2Xy6iObj0cVWq/QJYjUAe67KtvJ+lvk3zZ/hzr
         Lavs2GjVEVqlt7w0Vo6RQS7/2+xHHHOX4/CLf7clLrHLfoae1ipEpTt5YdIsYEegwDlH
         AMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258984; x=1790863784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUWGnQOpqm7Tz8B7F9u0qMEX8QZeYjwSFLQ35dQmxW0=;
        b=j0QCw9LS8CVBQbnpJQ1ZPkyiNW9xvISze0YpBrJsOyH9HgKw4gBKsCp44ApVkBaL5e
         hzIUA09P7CYXS9PNYUgadU6MtOYLTPjb68q0FW+1v7y6HG9hLojIdAknuVO5eFzbQPFG
         NhiaYyIyDyN9cuO16/Si+WNrTP4ThOEf1OWAkFXaVFA5P9nT0znUinbQMNjvv+Ejjif6
         OOVMM+Y5KzgB1e4HzqQZ0NCLePYRMEDq4u+4Q5K7KPPGf/uFo35h22VuoJ/2D9oIc1YX
         QhtQW+D+EInFJTMlLXPtP4uVKEzmnkeUtine2Mjd2KiLwjKAF/NAQPzFxSjvwJq4mr9X
         Q+nw==
X-Forwarded-Encrypted: i=1; AKwUvByhEDBqzyy+cyvRRqTke4CYzBqiQFu9UpqRIqItSGMrLuqEsbVhAM4ZcKH7wvgi/PKrjDMuHJA=@vger.kernel.org
X-Gm-Message-State: AFuF++lgSQOpNUCa64JLuRIT7nypmaPqF1HF1oBt3zmrEilN3PSmG+kW
	7/oHCV8106ESY1szu20z14hNqF/zhO9/2fNKH462BdNZMiA7PYoQV/jg5FUTcW+ykb50bYiK1gw
	3ZuT5l5hRgZSaCVkNZYuHOKFMr0A4xSnURyiMONZALms43EgxljUxMV0x+A==
X-Gm-Gg: AYBFou1pUUuf12vTILJj/mFWbYemHdBzVPjG4PqtcP9oDocNcAmLHzCK9UueBzmeq27
	ou185z6CPbzWlsVnm187r+gCz6iSmViiHN3wNB8mVRhqDtsMZD0qK68nyTe8xWwPWOgResjdM1a
	/lCjEk3OtDoIcV0RiJOHl03NoDqvfYZZ8CIzjCDcXz3aTYMEIB3UwCRFGyVyqKx+obEkxs2tPTz
	KIWU4pBZA1n8ZOReK9dx3bE3fjCcs1GdG+CVfF3j7pGu9Ic2aHv63oioaK7JIpINSLzSCM/cQXM
	hTNf1fckLA+XtSOBN0A1cqBmGWoiL/QRVZm63hhE6EAJN9BxhJ5B4pZ7MdcZoHMcDAQNq2kFCLB
	TO90R+tS4aCpD2NbLyGMpY8hSKFcLQLP67+oMhI+dbV1eS3Tcy3EYV/WOmS6ep/5PvQaWrtltRg
	==
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr46533555e9.21.1790258983855;
        Thu, 24 Sep 2026 07:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr46533015e9.21.1790258983418;
        Thu, 24 Sep 2026 07:09:43 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm104687975e9.14.2026.09.24.07.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 07:09:42 -0700 (PDT)
Message-ID: <611ec0af-8e4c-495d-9300-6dc9b5d616a1@redhat.com>
Date: Thu, 24 Sep 2026 16:09:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
To: Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, keyong.sun@smartx.com, Ilya Maximets <i.maximets@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jason Wang <jasowangio@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260918084651.3022878-3-wang.zhan@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 10:46, Wang Zhan wrote:
> The bounded resegmentation added by the next patch splits an oversized TCP
> GSO skb into several GSO skbs which fit the device limits. That needs the
> GSO engine to group several MSS segments into one output skb, so let
> callers bound the number of MSS segments each output skb carries and pass
> the bound through the existing __skb_gso_segment() entry point. Ordinary
> callers use zero for no limit.
> 
> skb_segment() only groups several MSS into one output skb when the device
> advertises NETIF_F_GSO_PARTIAL, or when the skb has a frag_list which can
> be split into uniform pieces, and falls back to one segment per skb
> otherwise. A caller which passes a bound asks for that grouping
> regardless, so the frag_list check is skipped when max_segs is set. Every
> other caller keeps it, and the bounded path is only used for skbs which do
> not carry a frag_list.
> 
> The output stays a GSO skb: gso_size is the original MSS and gso_segs is
> the number of MSS it holds, so a downstream device can still perform
> ordinary TSO. Store the bound in the existing skb_gso_cb scratch context,
> alongside the call-local data_offset and mac_offset fields, so that the
> segmentation methods keep their signature. A zero max_segs value means
> that no bound is active; it is not a persistent skb flag. Clear the value
> when each output skb copies the input header so the temporary limit is not
> propagated to the next GSO call.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
I'm wondering if this patch is needed at all. Can't the special gso caller
set skb_shinfo(skb)->gso_size to ~64K and adjust the gso bits in the shared
info afterwards?

/P

