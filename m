Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE54CEE71
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006111; cv=none; b=qgS7H5CnS3vPqvpiaS0WY7h7MIdYg4XXky338xc3eAcpQx64oPRrQxdjAYcpjFSOkl5TGloiEqpZGTNoMl8OjW4wyET/DPDgG2rVQmhVeXkbY62Vo31Q72eQe4GWfwnk7k4tmo/dJ9oxQxepdXtytRrfNG6uupBbZe8lz4iDFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006111; c=relaxed/simple;
	bh=bDsUNSkjs/FlyzkubQ2+eUfYnX4CeTJ1aPsc/gNisz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH+gSNm7A1jhcHD6jixmf/vuPddyyXbpoi4cVW8WO8xKSoBlI2kIafDSok0UemeTN8f8csKrQXxbhslhihFDNDuv1i5pU4OXhnkTrcSoFPtDl4rfVcdduIRhsu3NcpiX98XC/NcoGbP3oG0Cb0O0GL0Pvg2SNQCdkzsQ4pSPYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTRIRdgj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5Dbd/w8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTRIRdgj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5Dbd/w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790006108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTP2SwRBukIzP2qE0+hVPmAsi+ftB+ZRXy8fpuSvdAc=;
	b=PTRIRdgjYyn/llk2pe460xdjZ/n89Yq4uJiJiRj5HlWLJ4ApDy532kUgtePjnQqW0LqSRl
	Q+JqHulr9bTCQKnYCNanuNxT5bXlCY62cJabXQV65zPZm/SBHE55CGfp4YvOCci/125wdu
	fM4vD4ukI7gpgM0vLEpra/Rzobdp88o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-lC_efuyVMoWeujpnh21tWg-1; Mon, 21 Sep 2026 11:55:07 -0400
X-MC-Unique: lC_efuyVMoWeujpnh21tWg-1
X-Mimecast-MFC-AGG-ID: lC_efuyVMoWeujpnh21tWg_1790006106
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso154205e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790006106; x=1790610906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTP2SwRBukIzP2qE0+hVPmAsi+ftB+ZRXy8fpuSvdAc=;
        b=Y5Dbd/w8hhKV5Qb0peUumCFOOAIsuftbqDnPTRpkGmpn6700S5snKfEZtU8dfKCagZ
         6/yNuUSYD6QAvBAvrPXmSS0AuPdxRocJJv5XoBGRc/thxWYiA0L4d86wAdTuPM/sTp4d
         7+tUqZXsenDqV//lg+y4IO1rXVf2WRUUxktVVLjMKjGYKxE8PGM3glF+iVqtLjSrMXsO
         Z8i2xrKWjnm8GhYM38BnzHpP2GB8z/794OlZ0Q/mEG6A5t+UUVFuxVVnNFqfUOLevF+i
         kIZRwf9R7SOwPhs7yHaGC3h70F8KjKtyEPTyhhTnu3QJq02dYVKznsOsXr1b650tx0Rk
         J4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006106; x=1790610906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTP2SwRBukIzP2qE0+hVPmAsi+ftB+ZRXy8fpuSvdAc=;
        b=kIdcKAOo6MP8ItPpq0h3ZvUHWW9z9saDq718DOvfCqC+9lccJNJchbSOW5MxYddAWs
         t2dxk2TVQTg4c5fNylOvrqTCqcpI6sb50LP2Le09e/Kfp1DpqLAxqFu+bF08kEzx/XAX
         2uJxMMSPnG5zKoXc4cC8AP2Rqe0tYeKf5GhIFKWe1SlIlEu+sqx8p/kzg/ONODett5t9
         dyhllqIEXe/s+6MyCR49EUyWDx46qAHTQ2z5EUQTjVsxF0XjExD56q9nfi5aAxkjI5Lf
         iXk1aFJNvICSs9B4ibzqvTeh0hGtLV5+H2o+ZcgWOcoRD96AjaYzMpsJ1gq0vSS9bQwF
         v2gQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMwXqD7Su9mt+AwFHK5A47t0CIIFGGXj9R2rBgWUE9SZok5ON3JaNJm9X/KmMAzvtTiugyHhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lkVpQJvAC8PRijI0H3fSK0hXRuZc5r2IbN2zBB4gPdSGX46Pi6
	lov0TG/VWk0H1e0VF1V8IQHLh7nMLpABE0txnvTS2JkJtEFgdMf1vSRwQBqt+fU8IOuFRdCV9l5
	4apwarLdbSJXyGNxKQTPOJZsD+/qi6XFl1wWZ2hQfmGAESvzCG/ansMGIiw==
X-Gm-Gg: AYBFou1mwZjycBKPfbQUq8kf3AUBwFTMn92sDYioOA8rP3UkXKlE4qcDN7pcCRaHAt3
	p1jwkmlnzP1+LYV4rlmy34QFuysqqfUePyaK3jL8x8ukB9PjVHTw5jbw9KA8c6x+PRPoD/nYQGk
	FRlOMfF5c4NLut+0fJ6TXpb09fdUC/dgX+XWbIE47PRiAd1UllvWlyEhYBPGLdTttx+XyBj6NIL
	XpzyofB1+9imx3RsyPfSrON+1mBcEa0WJeeepuO7SqAhYT450RdWBCDJV3/seq4YvFunTWgogaw
	iIVmcbWOpiKB43fZx7UJWRiYHk7XL8n/Ed9h5R2XKWGlyOipf2f57BeK3dywK0g+G61QfLRfRHd
	A4YOn/URkeAYiNc9SGLUZgaX+1SBHow+MMbJL/mH5ogQVvYzm39uvbBn19woz/HeFJvRjvZTGPw
	==
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr1301875e9.5.1790006106227;
        Mon, 21 Sep 2026 08:55:06 -0700 (PDT)
X-Received: by 2002:a05:600c:34c6:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fd88607e7mr1301585e9.5.1790006105850;
        Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc481c73bsm6271415e9.1.2026.09.21.08.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 08:55:05 -0700 (PDT)
Message-ID: <890795c7-f9f9-4725-9c2b-bb345f627fc5@redhat.com>
Date: Mon, 21 Sep 2026 17:55:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
To: Matthieu Baerts <matttbe@kernel.org>, Yilin Zhang <yilinzhang@moonshot.ai>
Cc: Mat Martineau <martineau@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Kimi Security Team <bug-report@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <20260920061904.3575780-1-yilinzhang@moonshot.ai>
 <aa299737-002e-43b4-ad1e-881720798470@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aa299737-002e-43b4-ad1e-881720798470@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 11:43, Matthieu Baerts wrote:
> 20 Sept 2026 08:19:21 Yilin Zhang <yilinzhang@moonshot.ai>:
>> tcp_fastopen_create_child() hands the SYN packet itself to
>> subflow_syn_recv_sock(). For an MP_JOIN request this takes the
>> fatal fallback: the cloned child is destroyed and handed back with
>> drop_req flagged, but tcp_fastopen_create_child() does not check
>> the flag and queues it, so accept() can expose the freed child.
>>
>> MP_JOIN cannot use Fast Open: data on a subflow requires the
>> completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
>> TFO path passes a SYN skb here) and let tcp_conn_request() fall
>> back to the regular MP_JOIN handshake; also strip the Fast Open
>> cookie from MP_JOIN SYN/ACKs.
>>
>> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
>> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
>> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
>> ---
>> v3:
>> - refuse TFO for MP_JOIN in subflow_syn_recv_sock() and fall back to
>>    the regular handshake; the TCP-side hunks from v2 are dropped
>> - strip the TFO cookie from MP_JOIN SYN/ACKs
> 
> Thank you for the V3.
> 
> Please start a new thread when sending a new version.
> 
>> v2:
>> - https://lore.kernel.org/netdev/20260903094010.4066892-1-yilinzhang@moonshot.ai/
>> v1:
>> - https://lore.kernel.org/netdev/20260902121247.3248539-1-yilinzhang@moonshot.ai/
>>
>> net/mptcp/subflow.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index af81ad5..2b454d4 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *sk, struct request_sock *req,
>>      if (foc && foc->len > -1)
>>          ireq->tstamp_ok = 0;
>>
>> +   /* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
>> +   if (foc && mptcp_subflow_rsk(req)->mp_join)
>> +       foc->len = -1;
> 
> This should go above the previous block, not to disable TCP timestamps
> in this case.
I'm sorry for lagging behind on this thread.

I think this is not the correct approach.

AFAICS only pktdrill or similar can send MPJ TFO; there is no gain in
keeping such subflows open, and some potential risks. IMHO this too
similar to the disconnect()/ADDR_FORM scenarios to embark into the 'keep
the feature alive' path.

I suggest just resetting the TFO MPJ subflow and avoid other possible
follow-ups.

@Yilin, please wait for agreement on this point before sending a new
revision.

Thanks,

Paolo

