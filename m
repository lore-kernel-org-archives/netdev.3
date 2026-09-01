Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D5477E20
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258396; cv=none; b=GgMgMYYSuHUoslgRdOR9EPaq41tzKIya7kb207wppT3eSkiaEfC72I0WhQPy5rzX1aLq/jw1rlv8ovt4njxfTHzaosHtHdrUIdAkNBiFEkdaHipxGpacAp58Q4IxVNZd3ai4uKxGPH2POOMKv6aZ0UWUbWTDn/jubKjuJaOUPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258396; c=relaxed/simple;
	bh=qwXKfWyJLlUJucJmgktLqPP85Us4UXby9QDkdbHOuso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaGhqkqAhP8xANDumlr8oS+fQfN/EDWv01b1RCfmlRDubEMcMlYRkkCFD8DrdxwXqQVGS5lnoH+/h00oNjCfw/4aZUVx7yqqRb1X9rt565jXlMLc6fMGpAonVYGjfVdw6eRZisQPnU8ZpihJtR2+Hu0HZPliubukhO1p76YA654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMjT38c/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elcoo6jZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMjT38c/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elcoo6jZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788258394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hljqqtQHi/PIRJOIh6/7RUx97Fgfx8/DFdEiDoTdzuM=;
	b=BMjT38c/HRtEu3TwhcR9h1hdnMZYQojePl7dwQhKKSvS9PpbQxgsOH9XYbcj+/tPO9RAs2
	+S9YdhOFNm9loFE9WQknuqMX5zC+4J+Dm+klYLpEFl6eFdd5thbT1ahZlSmUfVQ6Xs+mMd
	vJ0wHIzg2m26giCrsFS5x5M/ZXSiq1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-iE1iiu1dP66MwCAiImTgDg-1; Tue, 01 Sept 2026 06:26:32 -0400
X-MC-Unique: iE1iiu1dP66MwCAiImTgDg-1
X-Mimecast-MFC-AGG-ID: iE1iiu1dP66MwCAiImTgDg_1788258392
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c213d5fb55aso463250466b.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788258391; x=1788863191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hljqqtQHi/PIRJOIh6/7RUx97Fgfx8/DFdEiDoTdzuM=;
        b=Elcoo6jZdi/3KCWTas2i18losiGxrCnQER2EZrv76x0wDU3zIsWEWmgX9jcVdm7bm+
         RZbGQybvCSK9gyR+Z/aD+A62ILBG9bPa/H+0wzA9FXIQV3QbxXsgCB5kzXVxQqwgno5h
         XPr7aZDBsL0GGwzzkpNiMYL55ez7plMpK5eUGXg9Uu90cK3LafmHwS/H5bTHNQBtenrG
         HFFWN7lkLv6GFtbOqCtXTCz3b+wHKs4EHOSdamXJVph8whqKh2dGmSJPFZNADbWgjIe9
         9lCRfsFznwAUw3DNs0kRsgwoE9Z5WbsBUWnS6j6QdRlFLPUYc1aBn1cAeL6mcdIgY/tP
         lgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258391; x=1788863191;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hljqqtQHi/PIRJOIh6/7RUx97Fgfx8/DFdEiDoTdzuM=;
        b=pe3NqMVui324AOJVoeM0Yb+Wj75Qf+ak5xQ0CQkD0Z/iuMVNqnRWmjsSGiTHdOExav
         0cdFTfy8RqR5zZXumWZQ35GRSa3ikCkHD8VC+MXrmUFVSqFvIemlabtsxQ0Q0XAl3WNC
         c3tVV/sjJgVy+7K9B+VrZ3ywmST5BO2UQaFH3HtAk/LT+l8HsB6/cGqumGcTPs22dg6b
         FUshiTN+SOw3dsCXVCKt7vKCFnX/agkGrlK8qhsbwk0l9xCLofoxjCBX8DLPWniIeSlE
         xAe3EJ97a3y7jNFny/r44viRVFAhGesF85lFwBCyddCBYgFTzlVXCT5OtaWRQGh9R+M0
         0UBA==
X-Forwarded-Encrypted: i=1; AHgh+Rpwo9dMgO7XQEHbxxuCrozcvLrCFxroQiI6uTx1H0iHWyEgotpAiqdJ/E6LKMmi6YIOV10hbWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kWBuXlb0PyUnqFEEvLI0f7OANEl8/26SfP44mxVM0+r1CrMRIn
	Zm2UT1MqnZphYNg5ffW4yVwjYoy3lfdu89WSCc1B5JmA49dDB/lWVMHDy+bm/0lpo9o/Po72aTm
	xy4whRUhsDLtQlhogt/bi/ApTuyOEHtKQcXW3auKW69wbVJfscutWfXNHTg==
X-Gm-Gg: AR+sD10oCnTxN4JexTVbLJV/MU64IFvRqmXEkOix+b/Gd/d9aP8TOPFhEpONSjY4GxD
	st7giem1xZEo2ettGP8Jd8gPef0nSIvDYcGUlYAWPVv5lAW3ICqxUqYt4SEXuuyeXlCaDmS/8UX
	zq3FWRHxIKAA3EGIbROEtI6osiuaaVxTRt+rKPAt3aeAFlVPiTTAQnokTagm/zfnvT2mPOZmRWC
	8yPiucrvBKI6eqZeNW+yda38Ru2RCr2ycVeZweTBVJc4htzErd/DkXtWPTFmpqkQP0GIIwl0r37
	N8395stXG5Ji3YTOBemD+qSOwSxFq1NUxJ0H121dUnIByAm0IQ5dpHX2vzsUnu4/2HspMQLIW6f
	kKW3rip+UodFmmgfVuYRSXb3GkenIlnPK7gUzg8ThfPVox5lTpuL+6rw0hizUrtTJwX21kiyRAg
	==
X-Received: by 2002:a17:907:5c3:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c255741620bmr2176837366b.20.1788258391582;
        Tue, 01 Sep 2026 03:26:31 -0700 (PDT)
X-Received: by 2002:a17:907:5c3:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c255741620bmr2176832366b.20.1788258390988;
        Tue, 01 Sep 2026 03:26:30 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee0b23esm542535066b.2.2026.09.01.03.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:26:30 -0700 (PDT)
Message-ID: <bddad244-f4a9-4e3b-ab6e-9ca8886f1eb6@redhat.com>
Date: Tue, 1 Sep 2026 12:26:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bonding: annotate lockless writes with
 WRITE_ONCE()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Jay Vosburgh <jv@jvosburgh.net>
References: <20260831081027.3209554-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831081027.3209554-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 10:10 AM, Eric Dumazet wrote:
> Several fields in bonding are read locklessly using READ_ONCE()
> (or ACCESS_ONCE() previously) but have corresponding writes that
> do not use WRITE_ONCE().
> 
> Add WRITE_ONCE() annotations to:
> - bond->send_peer_notif decrements in bond_peer_notify_may_events()
>   and reset in bond_close().
> - bond->slave_cnt increments and decrements in bond_enslave() and
>   __bond_release_one().
> - bond->recv_probe updates in bond_open(), bond_option_arp_interval_set()
>   and rlb_initialize().
> - slaves->count decrement in bond_skip_slave().
> 
> Fixes: 4d97480b1806 ("bonding: use local function pointer of bond->recv_probe in bond_handle_frame")
> Fixes: 9a72c2da690d ("bonding: fix div by zero while enslaving and transmitting")
> Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
> Fixes: 429208aab9db ("net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
Clashiko noted there is still a missing READ_ONCE annotation for
`usable_slaves->count` in bond_miimon_inspect(), but I think that is
better handled with a separate patch.

/P

