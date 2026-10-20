Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479986;
	b=AErTnYorLbpO4xI9StwwzsMriMznmTU05LWZKUo55gY2YVUJLplOTLKGcuhwt7g8jw8/
	 gI9PhogrHoUO8uNb8Q6KKi6ni5JmHcqRSoOYCyPY5QnYZ8LF/mFT121KWunaEEICHX7kP
	 6QBp1WimIZM+fKSFwB91Iaj/utxbuhdfDQ2vESytzYdIwuACv0aSpJ05Y0Dv33xuqUtrn
	 dPBq04FjskH6MclegbQ27oEJa2N8rPWXmF6QtBQpDvYsn1npOd22GkL/jRnYxOe8Xc2na
	 IzG2/LajcWKi6CtukWTAfxPh0XyAT0lK2EJw9FgdA16ANk2C3VToLZDHiDdx8g1gbSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479986;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+fC64qxKryfWCHoM8JxIkgtFOp4BoT4UY3ujeFbKA6I=;
	b=RXfMuOa0BCbIUrRJwBGvBYBwp231ws+WjnaybYbtEU5/ppu57yEWusDv4K0q/qBh2qGV
	 P8AwyUluiLkrGb5Dop1q/G/gfm3O2T29Pbr96cM6IGhjhXjgX6ZbvrPFsZHw1Qf0yzfzx
	 KdG5mkaAWDVsmVVWuHBccBi+/q6FbuWsALPRKO47Pn3ZRfyYwhMd3QyRzwHpcmNaioqxy
	 b42FWuvxxq/Smqbdsm4qh9GDvsE5RuQqzp14m+qofiVI3LHN1l3FIev97J2II60nbdo5Y
	 2KQqYauPKKX9FC1MXYXN4eJBadX00kZ2ypQSxIPBPf/IL6j5SP9IuCBjYOTEEizILsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="MO09Ns/u";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NrUoc7vc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66755606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66755606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MO09Ns/u;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NrUoc7vc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792479984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fC64qxKryfWCHoM8JxIkgtFOp4BoT4UY3ujeFbKA6I=;
	b=MO09Ns/us+tcC9VNdJlNYbFhpXCg5v5xXM3poCfD0wDA7/kSyL6sRVgLiysrdKAh/ztM0k
	jyPZgWSXtaDCmScCdHqEyWcgAXtBmxvWnXc6UjQLHCN4DWzwpkELjUoSE1nHBAY00pPuqw
	L2V5RZQYm94eOYxOuNtVYgwc+hYgWTY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-1MCN4OgOPQ6EAIDHn8vYlw-1; Tue, 20 Oct 2026 03:06:20 -0400
X-MC-Unique: 1MCN4OgOPQ6EAIDHn8vYlw-1
X-Mimecast-MFC-AGG-ID: 1MCN4OgOPQ6EAIDHn8vYlw_1792479980
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso22127345e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792479979; x=1793084779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fC64qxKryfWCHoM8JxIkgtFOp4BoT4UY3ujeFbKA6I=;
        b=NrUoc7vc4ZVciEOT+CXTQczNty3cNKpQ+hfB/jsOQTHbX8VvoF/liRGe+WS1vy24UQ
         nsDEZzLD4o64Qz56Pya+VJ7HlZKRlSppU3mxc30rfC8GocOWOHUxkxLFSYavc97r7xO8
         aidDy/svvd9xv3FRPjxF6CDqt9yNTRJMtT/qqpX5RSxkgU2IAFakvTwB3Sy55iJqaSRv
         +lkBhjH4KauvgvkBH24+ZF+XWbLbl86BnsvRJVYSU/GLUskdB/z9CYRAVva62KmRjvnF
         ERFre4og1a3edq8m0znfOtRaabZPaUT3okJvBfJxW9LAKBneabYcUoeXR2ZY61JCG83N
         bJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479979; x=1793084779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fC64qxKryfWCHoM8JxIkgtFOp4BoT4UY3ujeFbKA6I=;
        b=xG0JHNGJnsJYkWmDdTjtmffuONlXOHDtDTxhMx8nUi7RXUMxNhDGwyc48NrzGf3RCA
         tKB9mgo0XHzWDgDOAFHPb6ZJY01P99wAcxxptbQl2p706t0atA7VFXBRyMhpJB0MUsz8
         jSA9h9CTc54/8b45Uwix9/4eDNuyAVWzDWmxtP2AQYza6dEF2T6yRTyvXS2SsQFOcsAh
         Fp4hK2DgnwNT6Zr27LSTUHxhYe/8uyALPrlgZbSsLzvGN+5toaLKR2elS9d+1nWTtEap
         mtHHSGVWvpRZa3ECfQyNyyArU75zjRwLgodaaZT5cYSqDZs3Xe29Y+S1ZhrPwTyuazH0
         UI4A==
X-Forwarded-Encrypted: i=1; AKwUvByjT7H5bVDC74yzYGomdJ31fI1pNa2pc9v08ugaGWB8pZpvPOphI4mqtcX7d8lGHtHmkBoqm7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYListayRhB+okJtZqDNaxOEmAOvtJtQOLtoLWDLbLWQshHLSjiY
	0zB2QfeNNwQJJd77yxUj3kBikIqVjYn45KGdajjmQOJ/dAbqzX4u0XEebbz/QeF+76OkNKMbZOe
	UimqGG/pHAvfBBuWk2kzAF94K/A2bZPFtT2Yq8r2lBChY0pRPFoM3ALLlwv3awuqBnA==
X-Gm-Gg: AYBFou1I9APbmU+GCpiRepNbQTh7lF5Dx3Na+hATFHACDXMndiC7kdLbaN9KMuhS/g9
	79pPAf/m/FXwN4omSwo/7TFG/IGkFG0sg4bhuoYQueP8aQB6z8VyH8xrrv8DhsdSYlGfq0KcgFM
	Z10EoQ0HkkSuIZdFSU+letDAghLRWUUz3INSZZ+/Edyc3k8TYqfpaQIg/DuOh7LvMqrP2hHS3qp
	QCMBOCRG3Xp60dO9pqZ1MeZniDfk7bBaioWNU3bVIMoDX1hC7DaZEHq0OkQl4m/8fZ+1DQiXCZk
	F2tX/QX42g4ePCIVAhtH8kWlTgLzYRXhOdvVybs5vbNsbTL/5GiL7rtY4LbqEzQqh5UUmkJcxfg
	xQDXJrCOznP4qERHQrDpe0zUZLm4OvC697eebtL99pucfOnKEQmzBSkDOzvhImLm7WzOfxvWXQA
	==
X-Received: by 2002:a05:600c:3488:b0:4a1:dbb7:bb44 with SMTP id 5b1f17b1804b1-4a1dbb7bc9emr148627115e9.5.1792479979652;
        Tue, 20 Oct 2026 00:06:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3488:b0:4a1:dbb7:bb44 with SMTP id 5b1f17b1804b1-4a1dbb7bc9emr148626545e9.5.1792479979165;
        Tue, 20 Oct 2026 00:06:19 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f37f7fc3sm30997365e9.2.2026.10.20.00.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:06:17 -0700 (PDT)
Message-ID: <0d32d785-d16a-456d-98e5-8e952d09ab76@redhat.com>
Date: Tue, 20 Oct 2026 09:06:15 +0200
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
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is
 empty
To: Hangbin Liu <hangbin.liu@linux.dev>, luyun <luyun_611@163.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, maheshb@google.com,
 razor@blackwall.org, netdev@vger.kernel.org
References: <20261008024031.16224-1-luyun_611@163.com>
 <asoItm3JVXSC5GQ4@fedora> <463c6b0e-8b46-4c70-b9d8-56b42beaa7d0@163.com>
 <asyt2Gt4LzKWWnZS@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <asyt2Gt4LzKWWnZS@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 11:52, Hangbin Liu wrote:
> On Mon, Oct 12, 2026 at 03:20:09PM +0800, luyun wrote:
>> On cost: the fallback only runs when the array is empty, so the normal
>> transmit path is untouched. Inside the window it is a lockless RCU list
>> walk with no new state; the second pass and the broadcast branch are
>> there to keep the array path's hash mapping and broadcast_neighbor
>> semantics.
>>
>> I would also like Jay's feedback on the preferred direction. If a
>> control-path solution is preferred, I am open to working on separating
>> array preparation from port enablement, as long as it does not change
>> LACP convergence behavior.
> 
> +1
I guess we are not getting Jay's feedback anytime soon.

I think a control-plane solution is highly preferable, even if it's
going to be a more significant work. I have just skimmed over the code
and it feels like removing the rtnl lock requirement for
bond_update_slave_arr() is doable - i.e. moving ->all_slaves and
->usable_slaves under a new bond specific mutex).

Thanks,

Paolo

