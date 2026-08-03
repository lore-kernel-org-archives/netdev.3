Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9C35C183
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762999; cv=none; b=mBiczIhVGwOL+QU06bP0xzQpOegnBNoycdyuPuuXN7ITRXOPV+BRt570dRuJpaEG1dZ3HX7q45DeM0rhmnu0klxlYiOy6xLc0dC3ZtRF4CER8iBTbGwcwkt/r/CX0Ff0/ickxtOxirCy3+g4nuCE3n3tEl7DfZzW0B1CDna2aX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762999; c=relaxed/simple;
	bh=8RXMK0OkGfAfbbNAGBMBP4nWRi16kTZnfvOhVNTkvck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7ppbCgBm3g5u+kzHx9QIPoB9ZF4ESCi1thdpQaC9BNe8w8R95cxAihvQMo1ar9gOetLxRth2GrbZWckIFUGcuqISIZ3f2iiWFR1lmsHFfxUURx3F1WmvuFk4JwOBPHgPlGy6QLJ6kzFd4zqU/KPP6QYPvW3eQJ4YMpIILuiy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBeWEoam; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JB0F70Q7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBeWEoam";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB0F70Q7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785762984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzdRbbpPFYy08EoNBkHrDc9rosP5rQCDCdEJJiDjoSA=;
	b=OBeWEoamrLVJ4KUbG/fKcRf3mlfWoIXJJhrAG4rH6rWnTqxIZ9QbjIb2j25BSpWnAo9kLd
	vvtnqAse3QilxC9dV1NHLjViiejrZCQz1yNIlQjgpMIQB2dx2ysmt1M/5bNsOiIg+aKUkf
	bJfUw17DSItKze6vitFn4p7aHccuazQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-CDwhF8QIPOGJ-HoR1r1RZQ-1; Mon, 03 Aug 2026 09:16:21 -0400
X-MC-Unique: CDwhF8QIPOGJ-HoR1r1RZQ-1
X-Mimecast-MFC-AGG-ID: CDwhF8QIPOGJ-HoR1r1RZQ_1785762980
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so22039815e9.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785762980; x=1786367780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzdRbbpPFYy08EoNBkHrDc9rosP5rQCDCdEJJiDjoSA=;
        b=JB0F70Q73draHfhS2MXkzxG5MBkAKO6GReCDmPNiFHAEI9jlX/x6oxVOeUB/YpArSm
         qIHNtrh0NyONRfisdda4umT0NM0m3YpHLa68f3FupX06KPi6VfEVhJlX354VGrhr2RdA
         W7iFcq9P0zrIYNbtAaqGWG+qlf0tXiRJdDO1bqjoxziNbI2JpDN5urGD9wjvJutg7MUJ
         sNn4C1ERSsCdB85NfDybPx1BxUqCjd2LVEexubwIQpQyPhKBTxIU2CIgXURQiZCMu1J9
         KggHSNUzbdzQgFWJZy4/bYVuH23BSorS6YjZls2xHsjVfe6cvXfqYaUhBw8eCglQ3UBL
         iaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785762980; x=1786367780;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzdRbbpPFYy08EoNBkHrDc9rosP5rQCDCdEJJiDjoSA=;
        b=Q+qd4NvW/nLtZOTAzrC0hT3IwiTMBwNm3i72dDT7fxQ+BUCtGOZq6O/mBmagg4u44p
         aC+ODn35bccXPDZf/HeSEHQaTdS8rPqPbLt2Ow/Jba3ScP5Mn4Vfx2B5hmDCN4CcRNz8
         sEEVQbvpgXKZ7Huj1Fvw7MIb0J6i9+rXs2RwbmM9LRfCaNOYR/nO/pt3KTzhvdVZyFTs
         sDnwCcvgJf/LXs6W+YaYRV9WcCJf5/Yu8chZ04ifYSll5eqx3DXR1/n7kzdV701H8Ua1
         tEHvv+QKMkEaoNJxFhYUILL1t6zrXy6pGEq+IB/OyQ28z29rIFISKXRSLvWhD1iqPkoG
         LdpQ==
X-Gm-Message-State: AOJu0YxTBkmoz8FgfTqV521fBjGfJn8got/jjnN5FEAlOLobs4giTpUj
	bhcnN7W1qKeUHq+2t+Zjk40c+IPvOrkAbsYYKrxZo+/d9ozs2bWvZcRx0whbtc8OVzBEqi16eFI
	17WFVmUWmPX2N/JOEiXuG1Q/a4xjtG7TTZk9ix0sg0mpnxcyE+5AUfWP/zA==
X-Gm-Gg: AR+sD10ASpMBUE1HNscdGGRJ5S/yBYcgT6cbJ1hbbi5TFJQ/+6pUkpbVtFqJS+qvia2
	y07UxXnLW4t50ReDPHV8h8Pn/KlAoTSeN8WgbyYfewYJB2SCU+kO6ZSNhZaLusKq8tb7pKC32t3
	9nPDfyAUVcuJZQByxfKWCYOq+ytGfseJX/9pgejh/i86DZu/SXWCZ+F7CgNgJsbsmmGBmRTNGtA
	Tt2lF2IuQkEejgxiVR/4+rss6q8QuvT5Wbm236IJtzfTqVkKNhpjUp2wrFEloKV4QoJc5DSxOW6
	8Uc7M/mJOA2uV2F0HC9CWNSge5oEXZSGgAntDaXIvz0MX+ovWWjnCUROiWd/1Cg7+t2j8WaYw7t
	owbOiK6aGmaGRDYmQVXivN7qhihUDkZrYr5MqbkCHXwhMmSnj30vjnUyqqyk5/FEhf4CTV9l/23
	o=
X-Received: by 2002:a05:600c:3f0d:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4980c673891mr238817675e9.13.1785762979833;
        Mon, 03 Aug 2026 06:16:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4980c673891mr238816565e9.13.1785762979395;
        Mon, 03 Aug 2026 06:16:19 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm240193505e9.8.2026.08.03.06.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:16:18 -0700 (PDT)
Message-ID: <3e83bad9-833e-4946-b29f-cd006ecdc981@redhat.com>
Date: Mon, 3 Aug 2026 15:16:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] mptcp: let the retrans scheduler do its
 job
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
 <20260731-net-next-mptcp-oooq-pruning-v2-2-24838164fa21@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-2-24838164fa21@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:24 PM, Matthieu Baerts (NGI0) wrote:
> @@ -2851,14 +2849,88 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_data_frag *dfrag;
> +	bool need_retrans;
> +	u64 retrans_seq;
>  	int err, len;
>  
> -	mptcp_clean_una_wakeup(sk);
> -
> -	/* first check ssk: need to kick "stale" logic */
> -	err = mptcp_sched_get_retrans(msk);
> +	mptcp_data_lock(sk);
> +	__mptcp_clean_una_wakeup(sk);
> +	retrans_seq = msk->snd_una;
>  	dfrag = mptcp_rtx_head(sk);
> -	if (!dfrag) {
> +	need_retrans = !!dfrag;
> +	mptcp_data_unlock(sk);
> +	if (!dfrag)
> +		goto check_data_fin;

Clashiko notes that the above will not kick the stale logic anymore when
all send data has been acked, and there is pending, unsent data.

That is intentional and safe: if no data is in-flight, we don't need
stale subflows detection.

> +
> +	for (;;) {
> +		bool already_retrans;
> +		u64 sent_seq;
> +
> +		/* The default scheduler will kick "stale" logic, that in
> +		 * turn can process incoming acks and clean the RTX queue;
> +		 * ensure that the current dfrag will still be around
> +		 * afterwards.
> +		 */
> +		get_page(dfrag->page);
> +		err = mptcp_sched_get_retrans(msk);

Clashiko noted that the above can cause bad accounting for the stale
logic. This needs to be fixed.

> +		if (err) {
> +			put_page(dfrag->page);
> +			break;
> +		}
> +
> +		/* Incoming acks can have moved retrans sequence after
> +		 * the current dfrag, if so try to start again from RTX head.
> +		 */
> +		mptcp_data_lock(sk);
> +		already_retrans = !before64(msk->snd_una, dfrag->data_seq +
> +					    dfrag->already_sent);
> +		put_page(dfrag->page);
> +		if (already_retrans) {
> +			__mptcp_clean_una_wakeup(sk);
> +			retrans_seq = msk->snd_una;
> +			dfrag = mptcp_rtx_head(sk);
> +			need_retrans = !!dfrag;
> +		} else if (after64(msk->snd_una, retrans_seq)) {
> +			retrans_seq = msk->snd_una;
> +		}
> +		mptcp_data_unlock(sk);
> +
> +		/* `already_sent` can be 0 for `dfrag` belonging to the RTX
> +		 *  queue due to __mptcp_retransmit_pending_data().
> +		 */
> +		if (!dfrag || !dfrag->already_sent)
> +			break;
> +
> +		/* Can fail only in case of fallback. */
> +		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
> +		if (len < 0)
> +			goto clear_scheduled;
> +
> +		retrans_seq += len;
> +		msk->bytes_retrans += len;
> +		dfrag->already_sent = max_t(u16, dfrag->already_sent,
> +					    retrans_seq - dfrag->data_seq);
> +
> +		/* With csum enabled retransmission can send new data. */
> +		sent_seq = dfrag->already_sent + dfrag->data_seq;
> +		if (after64(sent_seq, msk->snd_nxt))
> +			WRITE_ONCE(msk->snd_nxt, sent_seq);
> +
> +		/* Attempt the next fragment only if the current one is
> +		 * completely retransmitted.
> +		 */
> +		if (before64(retrans_seq, dfrag->data_seq + dfrag->data_len))
> +			break;
> +
> +		dfrag = list_is_last(&dfrag->list, &msk->rtx_queue) ?
> +				NULL : list_next_entry(dfrag, list);
> +		if (!dfrag)
> +			break;
> +	}
> +
> +	/* Attempt data-fin retransmission only when the RTX queue is empty. */
> +	if (!need_retrans) {

Clashiko noted that an error path could reach here with an outdated
`need_retrans` value. It needs to be fixed.

/P

