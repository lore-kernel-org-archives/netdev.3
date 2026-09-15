Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65293B3880
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479418; cv=none; b=kLbRMgucS87l5b1YuXMWSeSQWImKiUQNTkUMHlsvN2CteEqkPzHAR3TIaRXsI2dfkzc5/4jKALuzQ208UJtLg9RrXNNAOWv0CQZ26W+evtKXUGYp0KDEAZEBMjn/Z23rw4NLyTlHbK1XKgYGnu+gKfIvkGj6tgXuu7tBmPJYs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479418; c=relaxed/simple;
	bh=BnBs6v+SnWmcSFsMdor+R9mxm4jTxF4rgmv5gJ31rBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lco5llnTeePQkhgn9l/dH85M7GKusDNqmX2vCGw2z3iuXQ+BVU5VkweIEmiow6AhlZ0uyXuJaEhp/jNFL9pdA6uZfmXoaSNCVzSFOV97cVCgN4DhbF0o9CR/h7c54yJPvOwrziwf4nFpj1kdHWZaKIEnQRZJQEdkUvLEWRY7EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqJ64hh4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+uKnfpa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqJ64hh4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+uKnfpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789479414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7NY/1C4E5sXjTjMfgvwiOAvJ9n5lroYv/zvI5y40+U=;
	b=WqJ64hh4iRS0hIilV+KOIhu/EQpa2b4IPK5SdqB58Ce4sYB3yPApD+28zaF0jGVSpVD/8l
	Kz1VTYDXBtWGBKRFF6oab731Fh4/wBzAf1tg/36Sx3iVp/s7q/CmZUtDdaDF/7wZWb/dTX
	VluIjXwOefJbO3VWNp0s7Wq0ruYH63g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-4hG2sLu9OKKe1OS-neSp_A-1; Tue, 15 Sep 2026 09:36:53 -0400
X-MC-Unique: 4hG2sLu9OKKe1OS-neSp_A-1
X-Mimecast-MFC-AGG-ID: 4hG2sLu9OKKe1OS-neSp_A_1789479412
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a082c014aso241983185a.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789479412; x=1790084212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7NY/1C4E5sXjTjMfgvwiOAvJ9n5lroYv/zvI5y40+U=;
        b=T+uKnfpamV0GORVexlx+aXwrZuB3YVRRDy1eDNScl6/Lj/3D5aQsY3LkfSo0iBp5Dh
         mMfZTlwn8KYOOWjfTkv6jvWUMgjdNIsBypgiKl83YslxlBg6nAN1XXgjmEl2XTbgBRAv
         RcnyoYBFIkBD5wBSq+YsZOKEPmKdMwxg7k2Yv28nlDSNSFAtT4nXM9QLOQ41+srSJmap
         QHwdAKVbGbWfdImm9alyNtDJJKcOCyROvcWeWvcSb1pMaqKEbOBjIrfHHKCOYnYAmlw9
         vXZgGXPlS0WKhQS5W3e1UBNYmWjvyrUXGVLBlcmQt5vWxFCnCqHiDTgHs3dcFAi5HZHO
         u0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789479412; x=1790084212;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7NY/1C4E5sXjTjMfgvwiOAvJ9n5lroYv/zvI5y40+U=;
        b=PMip6Vb3GiSZjAPrv5JcXRaOwf4HDzckuswqV1hnVDd9AdWPv1vgP0nS8H3igWct37
         8a7zLxeqUgh9ihidyDHDCiqN0UVxvKenGLiLEd0nBYe8221AIupplggjN7DekGfQP2MT
         EIse1g7oJ2HH82ykRf8/LgxdM/N7zE4h4M5AO8VNu+KwpvBTvLkFEYUs1dzzMmZmZoTn
         fetuwopSpGVLqxHthn76Dyg48jEXa5I+TRdo4QnRa9NC1NZhJNln8uhFTdQAbngsuhif
         oYpni0GEj0mdZxvyH742r6NY2dz/mEpGsUU3so1Ze5EWnXXHxecfkoR24ea38Jg8VEn7
         7PAA==
X-Forwarded-Encrypted: i=1; AKwUvBzRVkXbn4XwOIi/ormu0tkDgTomXWzAFPec+MEpvjVLkLdRnXPJI/TZgEwCCcy6dqXSLxOlWao=@vger.kernel.org
X-Gm-Message-State: AFuF++nN9aUjPSTUdd2Uv5yGQ4VIrrlU0UbuRgm8rZHDMMuac4p2/+DI
	FNUyMOFNYRyMrJxo2L/QhbAofmULhfdeE/9bypMfCCmaw8QOP6pCb741jqu6KyQvykuI9dka3Bt
	0a0h7Rz116MUG84aDwScGMQRNkfdqdR1JW2VBGAETwpHw9xWBPEJG29t+EbmqUQEPLw==
X-Gm-Gg: AYBFou16z1ZQSFmMMLj9BWiyrUALfsJ961YzyRWnS3O/xjgh5Nwo6ovZ/Kc9DaLPA0+
	2NGCKeaiFFgwl/OuDNVpK0yfaTsLXlBMP03kqqWVqhW5yTgBdY7d7j0jnB4JUwWTskgXkQrYBSs
	MhV6f2xOBe6aFOGmUQIiFpUodn1frjDpkCZXmtPm7TlyjqpAavmykiCJcF0+f9BIhmGlF9K3ZHv
	us9OR+N5/G/yZDnihNvKgLcQmo9Xaw01u4V1SExmbv7HfMyAKZ17B3I5GEvZWDJgdu/oqYM+8jR
	EB4MBMoqp6s1ybupfpGTXFFCUWV9QZTPPZwK7mKEiM+d48rXjaN7FOHZ3HoKODETavEYRz3GuCg
	npHpD183fN64TMtI44e/llbxvCn0+a/TAcgyjZHcIKCqQSpa9uykRJvf2e/Rpk4/PHTU3dAb+EQ
	==
X-Received: by 2002:a05:620a:414c:b0:939:72cb:baed with SMTP id af79cd13be357-93a34728f09mr497058885a.36.1789479412041;
        Tue, 15 Sep 2026 06:36:52 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:939:72cb:baed with SMTP id af79cd13be357-93a34728f09mr497053485a.36.1789479411468;
        Tue, 15 Sep 2026 06:36:51 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f18628sm1258848285a.13.2026.09.15.06.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 06:36:50 -0700 (PDT)
Message-ID: <229fb007-8f00-455f-ab92-4d15d6b90d0f@redhat.com>
Date: Tue, 15 Sep 2026 15:36:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v10 01/14] rxrpc: Fix lack of short-send handling in
 rxrpc_kernel_send_data()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Laight <david.laight.linux@gmail.com>,
 stable@vger.kernel.org
References: <20260914151340.3227501-1-dhowells@redhat.com>
 <20260914151340.3227501-2-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260914151340.3227501-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 5:13 PM, David Howells wrote:
> @@ -816,15 +814,29 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
>  	ASSERTCMP(msg->msg_name, ==, NULL);
>  	ASSERTCMP(msg->msg_control, ==, NULL);
>  
> -	mutex_lock(&call->user_mutex);
> +	for (;;) {
> +		mutex_lock(&call->user_mutex);

FTR coccinelle can't digest the lock inside the loop:

https://netdev-ctrl.bots.linux.dev/build/cocci/results/823484/stderr

but AFAICS the report is a false positive, and I can't think of an easy
way to avoid it.

/P

