Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC23C1412
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149502; cv=none; b=SrGzzFl+x5JB91sRqdZcxtyQn/RfXYD3HXFbs+rWIcArtpGWyZrhUD1doQ4y4vwHiZQn3tTYQc+hG/OEtrmpUPNENoTjC3txhVQYY3KhnCuwC5BoarN257Ib18pSg3WB6FYJSe2MCKSJhirCKJrWNyGOkIDAdplDcBtJ7P2guUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149502; c=relaxed/simple;
	bh=uoYHIdvl6gpY+en99zZH8KcV9uPKCKr5AB+q3c4n1Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKyy5nojUo9dx0NDnzKoIclhrmSKqjCzL1EzqUjTlr3zj+DKZu0lPpgR5+qSe4/Ymy01i+AySsrRTbwWClYFPOr3GDqhcnpRKuKU5pCvhVjks9VKyzIckhZTVKn+Mt4wWa0bobBh5HNnfaq2NyyYlu+C0pqk4S2eK05Ke7fFUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoP2z2rF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoP2z2rF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso17192925e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785149499; x=1785754299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=js68EwMJJuet/h90DYuS4AfKV4zY59kcA6a3Sw92oFQ=;
        b=JoP2z2rFklEY6qNtbvEM9LQg/9a4BUO3KmmtncQHRJeNFMatkpl0E1F+YUO8wVXo63
         UpMcg5AlRYWS1h2Q0aoInDjw3yKHCxAIKNNLUfUushMxDdCHdgYW+WY2UGng5QmJLAA6
         EHJ/1eBIyOvCB5ziwbUieTCeL50SYLuyXMsC3HUeGj+07SGTqohN2f2lccXBRD4NqGfc
         uUDn3ePnhmDqtnVszHnrC0LlK4MmgDp1B7EKqr4ofd+y0nUFNyEsPLqJYWTxRzvdfdVr
         QIs29AwG1WWt8MCcRbANBGfH6NxBV6LrpmFSQV0PmLb9M3x5R+SbxN/cYBv199e9Cph6
         5P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785149499; x=1785754299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=js68EwMJJuet/h90DYuS4AfKV4zY59kcA6a3Sw92oFQ=;
        b=d+sVzxlkHnWTAa111gndN0RynYQ72d/U95yTXWMivtXjqERFFIqTlAChHlfp04wd6r
         t2tOym+4MaODY2ehNwwcjYLpp4Qb75d6X3Ig8RREIdwRkWKr73BthptGI9DrdxwgXy8Z
         JGk5qoh9fAydsD2Fz8vqJ8QvY9LnSvgDhRcldm5kS4zwVZDT6nJ9NdRuLu2vDX3GOkxV
         OWZ1N6EOiuD4y0Bp128v3u/TGMVdC55dA9KH2nRhUBac6RQUfIfpHvhl/VmxUfsUIcFn
         uJzqpfSDpoZ1Ms+x6iI66/1r+uABG3uCrpUeJTQniubMHfNhSVw8RUhSaUH1jsTI1pbm
         b0qQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbSn0EnpJ7jMqIfjrn/p1UphxaftquS9Di+rEZsWWNHKSGwKUQn4aEzdq2/3x6TgosypmGWTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJVq4DBj/RaU+2WnL73lKHoGWdQYlEciPlh/tvw08lKWG7X9h
	36E9FaXOtDVW5aHSk0sUF3m8zpMFuG3CtgJJzXC6SiQFvKw55gU65qOt
X-Gm-Gg: AR+sD13xK0P4ITlU8h5VymRCcrnZDpldSFC4xDSmc3nsbrP7oxjjlfDFp15X1LRVENH
	G4mCN710ikAZoFNoyrgvhtRq3FYUelvpCTk+gbZl8tOCPguVPuZlrSfgrCoczYGT6UKOXbkOlFJ
	Jq5Q7Z5ACBhm5gPBTr4pb2Uoxubxiu53/8ELZk2SfTZfwh5aZCCcryPsEFBBhTb65bTHvFcUYbL
	nJ7clXKRlGs382h5AfqBGXcq19v5jwJM0Km1I/Bnz4ng0jIR90KOBMse60uGtVOWF7j3Dx6/yoZ
	T8ScR4DYoPzd/YF1hpVpJ0x36KIQZQCAjkhVUOvvo/RzaW03g9u2OeSfZpmt3A5sP8ssVFhyIH6
	CjF1tHrR+b7Jy+bhpLpsfy9iCD8bnfIEYGDR5NOCmM4FHuPDdyaAw+COqRTivaNOZY1z4uuukff
	2Cng1+LC3Hd4p4d1scLo+EN/274uWmKMFmqz1kTScN5qVNPwdGEsB0zkCwFM7V65Mo51+Cq5VSi
	XoemoDsBNDRekksF0b8HTvcamEv44tcU3hGzQ==
X-Received: by 2002:a05:600c:a0c:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-496b56fa38fmr101687835e9.9.1785149499170;
        Mon, 27 Jul 2026 03:51:39 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4f63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f30126sm213770875e9.13.2026.07.27.03.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 03:51:38 -0700 (PDT)
Message-ID: <954583a4-e3b2-4a01-8ec0-bdb913faee69@gmail.com>
Date: Mon, 27 Jul 2026 11:51:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <amEE7qImKgy4sWKf@devvm29614.prn0.facebook.com>
 <5c3c34de-7b34-4122-a792-e91b48858f2f@gmail.com>
 <amO4DN0oAzkt9n18@devvm29614.prn0.facebook.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <amO4DN0oAzkt9n18@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/26 20:07, Bobby Eshleman wrote:
> On Wed, Jul 22, 2026 at 07:58:27PM +0100, Pavel Begunkov wrote:
>> On 7/22/26 18:59, Bobby Eshleman wrote:
>>> On Wed, Jul 22, 2026 at 11:58:46AM +0100, Pavel Begunkov wrote:
>>>> We should either have net_iov or page backed frags in a single skb,
>>>> otherwise it blows up down the stack. Don't allow mixing in
>>>> zerocopy_fill_skb_from_devmem().
>>>>
>>>> Fixes: bd61848900bff ("net: devmem: Implement TX path")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>>    net/core/datagram.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>>>> index c285c6465923..35febc1c25fa 100644
>>>> --- a/net/core/datagram.c
>>>> +++ b/net/core/datagram.c
>>>> @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>>>>    	size_t virt_addr, size, off;
>>>>    	struct net_iov *niov;
>>>> +	if (i && skb_frags_readable(skb))
>>>> +		return -EEXIST;
>>>
>>> Are we trying to hit the -EEXIST handler in tcp_sendmsg_locked() so that
>>> we start a new skb? If so, I think we might need to plumb this -EEXIST
>>> case through skb_zerocopy_iter_stream() too?
>>
>> Easier to EFAULT. It'd more consistent, and I don't care how tcp takes
>> it specifically.
>>
>> -- 
>> Pavel Begunkov
>>
> 
> One socket is allowed to queue non-devmem followed by devmem, and EFAULT
> will break this case. I think EEXIST is right, just needs to propagate
> up.
Regardless of whether it's a good thing or not, mixing is already
rejected, see zerocopy_fill_skb_from_iter(). Not 100% consistent
though for the user as it's timing dependent.

-- 
Pavel Begunkov

