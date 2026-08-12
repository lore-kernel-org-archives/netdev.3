Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED963FDC18
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525819; cv=none; b=V3kJhKBy23S3jLshlmzoM55aINRiVmsriFDf9zxZgcoBxMm/oCBpDlv3XD7IOSIwn+5bp1Hrq8lTFzU4Dw5vwvgv66T6UUBm0FLYOfFsgSefz8fUlvp/XsYruv7nuVEE8FOBNeCggPnCjoRvkeQGIL9aDjakaCrSIXZpSyDaWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525819; c=relaxed/simple;
	bh=n44If2VGgkicSXz24CfwY0BK5nNHU0rFHpHcfylBKlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLSpFNYZlteHoVsHj9IUr5BCuTJ9WkOVvnrPOuHYfOtjtzNZrdp/5fbOPdzRG0rTH1+hxBqRyX7VVS8CWqLO4CNg82wLp7Tq/voh4xVyfcSNdi06SzJvAIx6exEWF80JluShPnjFTuyQBBAsp6htPI6MOLChQypReRWtrZExwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhVM/Su1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=es5RH944; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhVM/Su1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="es5RH944"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786525813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
	b=hhVM/Su1TnxNpjjifU9WKzdfBC8AJt/8jXQVZU1rVLwxe08UF/0XRCyKJ81sWHC3NMitSL
	T/dpkiAEva6jUGhs5xEaEKALgPlrek67G7Rwuk5mT2lAJWvH4hkZZmJ5Wv4jaJGaxHguRB
	mJh5HlxQJRVZKJG6pED+c9Hk/Z8MRls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-mOWSzTqePYOTVkFYvuzT-g-1; Wed, 12 Aug 2026 05:10:12 -0400
X-MC-Unique: mOWSzTqePYOTVkFYvuzT-g-1
X-Mimecast-MFC-AGG-ID: mOWSzTqePYOTVkFYvuzT-g_1786525811
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso3783405e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786525811; x=1787130611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
        b=es5RH944ybkfNHi0/id8EDtD/em5k2UFRQtRvuDw+zDaHhaDg2AXW5DfUhTnuvyz7Y
         P71zObRqHmY3QV0wjUK+EH28lRoN3Vv/6U0PFPD6sjMVAFRipHnjtBNtgoWu0y73Z1Wj
         /Oy00YgYxyXh6dd0cCX4FSdC7Hyf9FhdHgcPXm2JhqLBbA1X4dLDoo2oahQytr04XppC
         pQEq+W3RlzgJtvYhbtQRNVUkH0cSnr7N3Wx1qVYSlUuNnWk6glxJHtmdkAkvrG+hR1kI
         RAo9b2PQxV8Rku1T1XOlfVIEoDJGlQbYUlpIdPANhutbnieQcaIekPbN2ezMtXbLvlAD
         SPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786525811; x=1787130611;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ru/bYOZf21mSsFe8HqKCz16SSQHB5XbOO+335H7uls=;
        b=Gn9LIlwfpE70LvRZfpBVwQ0qainO6KRnRreALOb1uBH88Ef2SPBBsoD/l9iifEKSxk
         LJ873zqbZUq8OTF/I2EFm9gRQqylbY/axQ3NJU+Gc0ePRpg6ME3+LZjZQWANBSFSxe9H
         JpcV6LTSdaSM09S8UiD9kLuDttbYz+UYn6D3Pojv3xmfeeADP4ddoJp0lGzAoeLQ6nDv
         lOjQFY4lnS/Qm0EKjHJ8lW6zmH6/01rZUC80yt1amCERJUmPXQuB2EzPqtZQmWB6xGYQ
         H+lbYHL6IYDEBG1K1upuBuAdITw+mlXYzyAR88BPbcr7iiiazed4axEj+vUEe899LMW+
         oVmw==
X-Forwarded-Encrypted: i=1; AHgh+RrqGiOxtcFmY+yVp5fUa0q0aDBGgKDfou/2yH1mnFemaVsVLoERpP6OF8R/Y1i1fV3jzgUwb/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5evhjVxe1oMEMhey0KcaCEjjHZjOZFEIhK3tmbxoc9yiiEuG2
	/3F9yPDlb/6Y1HCmgkx6e+lSNZWWZe7MqWRmgwzOgWGdkI4Gttd3kxh0V7LFS5bcevIWwbJu0L+
	iEV5bd4lqq2SiauahiOTDSAbe/nRMA9jdhwS47836xst4l4eRNP9wofAYog==
X-Gm-Gg: AR+sD13AQeLofjW5dY2ADKwvuBJajZxlLO7VgB6/7BqnED1HcuuC1dFVO4D7DQPuHm8
	TKRg3f0m8UwXbahKq9mbmp/l07+VdyHkV8RteMlmlgPx6PaaP+EhcgM749V5uGygsBkLq4GVCED
	AEifswjtfHXCtdUZoSCJFpbKbw0m0QNk78WFvsfCV2hpIf5tGshALDlFcGLIeHv1Cp1qazWs/RU
	Ty/qZ1/ayrgWl023iuxsmIsVT4wnEfvT+VIaTWFT6pwUI406JWAcGDtQ8qPjsQ6lmFCo9jsA2ya
	8iGh1kas2f090GFhApdrhMYwHUrN0kqK9DctmnVSUPoGKf92QxJlXaZ8dX6m+1zmfNrIMCetPGp
	XITjkIL9xdWr4PK5Xoyre/jFjR8wcHfsARnO5r7I5OA7vyfBuIXJI/f2jFglpSJGDbvX+swa4eE
	0=
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47111545e9.10.1786525810729;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4997c13420bmr47110615e9.10.1786525810309;
        Wed, 12 Aug 2026 02:10:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm42548405e9.2.2026.08.12.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:10:09 -0700 (PDT)
Message-ID: <d98287c8-0925-4e70-8cb7-c5703d8145fa@redhat.com>
Date: Wed, 12 Aug 2026 11:10:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp v2] mptcp: restore full join state in syncookie
 MP_JOIN reconstruction
To: Harshit Varu <harshitvaru666@gmail.com>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 security@kernel.org, stable@vger.kernel.org
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
 <20260811222325.90426-1-harshitvaru666@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260811222325.90426-1-harshitvaru666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 12:23 AM, Harshit Varu wrote:
> mptcp_token_join_cookie_init_state() rebuilds the request socket for a
> MP_JOIN 4th-ACK that was handled under SYN cookies, but it only restores
> remote_nonce, local_nonce, backup, join_id, token and msk from the saved
> cookie entry. local_id, request_bkup and thmac are never restored, even
> though the SYN path saves local_id and computes the other two.
> 
> subflow_ulp_clone() then reads those three fields and copies them into the
> joined subflow context (local_id, request_bkup, thmac). Because the
> request-sock slab is SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the
> values are stale bytes of previously freed request sockets, which an
> off-path peer can influence by sending concurrent MP_JOIN SYNs. A corrupted
> local_id breaks id-based path-manager bookkeeping, and a corrupted
> request_bkup misclassifies the subflow in the packet scheduler's
> backup/active selection.
> 
> Save and restore request_bkup and thmac as well, completing the state
> restore.
> 
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
> Cc: stable@vger.kernel.org
> Assisted-by: opencode:deepseek-v4-flash
> Signed-off-by: Harshit Varu <harshitvaru666@gmail.com>
> ---
>  net/mptcp/syncookies.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index 7f2252634..3c25ff627 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -27,7 +27,9 @@ struct join_entry {
>  	u8 join_id;
>  	u8 local_id;
>  	u8 backup;
> +	u8 request_bkup;
>  	u8 valid;
> +	u64 thmac;

Is thmac used for passive flows after
mptcp_token_join_cookie_init_state()? I think it's not. If so just init
to 0 in mptcp_token_join_cookie_init_state (with a comment) and remove
remove the new field from here.

Same for request_bkup, AFAICS both are used in syn_ack only.

The bottom line is that we don't want to increase `struct join_entry`
size without good reasons.

/P

