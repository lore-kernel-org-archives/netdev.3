Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777483;
	b=lEAah2KH7Cza3k6tuYy9ghkByLkA+RqF7n2Ot4eV5OdTGSOGOM41BBx8hs6TqpU3Tffj
	 SVjGtpcpr60TjeJnEGPTUieVqv1Ch8yVfTvpOr9ZqJfNSO8nHPPdHsnaD5539Qd4lieD9
	 4KM606ok6KE4tUGLVbgYGaIhb377eqQkeltTD2FI7CgWNAm7N81m58Q1Ie5lGzAcD4IaN
	 DHcUUh7hIgdKOqDVnn65MKh0ROtexOapRrHJ0IkNlLPb6FNW+LYOKq274dmE+8jVaHUO3
	 R3a1vFrhSUWwXDu3dXQ5B+dkAfTj/q+RZLwEDm2vZb9vufJVknDWtC6oz26r6hsFaPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777483;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gf1SJ60wh6rt1cgDzJ1XsuN+6DsStx0G3H1EPBnHUrc=;
	b=k5BDCl4GnflyWJQ7FM525uNdPlKA5/DkKOaUD+rNyxnNmQQzQZpHLP4P/PWHoW+u5GWw
	 6/nzgwuKOTFQJfo0Z5DbpVPmQ7HaxJrv3Pxe0hpAH66RC8lynlNrb109fjS1GqUbtW5ot
	 muCAwOocwCkGvgUeyNnBzq2yiEV1LtbR9xjeMPX2T7T1B52q6C2PpEejXze7AhiLaChyA
	 mHvLas1gOABg9iq7iyQRAOMaJor8hTN4Stgq69JmAmGfzDRY73BS5kKxhFLf2gas1ngG0
	 C9Q9idAc+eob5p9jCpe58Fc2Nfd+3yhuTalvT9ely+Gxoswv6VJEX4fsM9i+gt1KEOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHveVmbM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qPyUMYEP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFA606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEBFA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bHveVmbM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qPyUMYEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793777481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf1SJ60wh6rt1cgDzJ1XsuN+6DsStx0G3H1EPBnHUrc=;
	b=bHveVmbMboFoyV/JO0zO4CZHk0sykT/qOL2/fszQ0zblTFn2wFfP1dTCXlbULjVWuiQ6lA
	hkIAVs4LrV6RSWBM7l4BxUVp6sN22wBPRZbykFsWabZRsqW5MC/L5EyhBomu7kdPVQkQ++
	he3m5V8F58tqHZzmi38LORtin1KHjfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-IBOb1S66PKSA0S6wmP-0dg-1; Wed, 04 Nov 2026 02:31:20 -0500
X-MC-Unique: IBOb1S66PKSA0S6wmP-0dg-1
X-Mimecast-MFC-AGG-ID: IBOb1S66PKSA0S6wmP-0dg_1793777479
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso5169755e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793777479; x=1794382279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf1SJ60wh6rt1cgDzJ1XsuN+6DsStx0G3H1EPBnHUrc=;
        b=qPyUMYEPu6QMDw+ynFBXj+Jukdd/b7kY/MwSzggCPBbpqxVgSSKgaPVvCXHszLHMco
         DlChHW+HSdOND+z92arp08ItIKAl5SBxI6sb508qvBIMVvrx5D+CCApcPJ6w2U8LroJm
         r4b2JM0Z5YGcJCNO5bJoyhZPF2SGZUAU5HamlEA3FNIx58qghw1wsKgWyPu6gXbmqnQN
         E+gOashfTRRTa6fbRRxM9NEUCG+fzcXqMLRRTDR5xfCivw/vR7Iab+z/LJZmmRbcob58
         7nPyMK1EcwD+cvreIfJGyM9HJYnIuzgjJgn3rUsVj/grOtz2KJY44lsvT26XeYlcUWSR
         WrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777479; x=1794382279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gf1SJ60wh6rt1cgDzJ1XsuN+6DsStx0G3H1EPBnHUrc=;
        b=kzuEnyNAeVU1VKQ3Y3urkdYSf1/jOF8OI8hfzNvoYbgyRQw9x1ydkblMQf8SWIm94B
         qg14hV4LnXsrQxjZliC6mRxscKdxNSkrBwhguC/1jHQVLHVACBUpyMk+Cr6ZBBgxJmjv
         7mtQLowXF7UAP6AWHRQeuiIwoU1PmIrJLuoQdTOpZe4EUEF0ZEMe2XdMYZknHHM4O6fT
         rcARFiTDSCuAqDerGHvX/GEhLuWgmGFupgj0UYLf1JJ8+Br8ZVFV2co4JzS3j+vIgVo8
         GlIm07wIzkpJvkOfNSC2HusALN5ROFpidy2iZ/piQzZ3Sna3nCDB1RX9ranvmrdb2giL
         HNww==
X-Forwarded-Encrypted: i=1; AKwUvByDfLatx7XeclWHjmHpSOrLQgZODW5JiCc59Cz19FrehPXdBD75Fz9V8KaZ+FAAs1fhaFi0Nng=@vger.kernel.org
X-Gm-Message-State: APuU4Z91mEosEHVxij3t7yF3ML80ZBulz4ILBV9D2Ld/nlA+rKQNZb8W
	b5/iGqKMkckttXUSfTPY5aSHzCAjCOAarESRlem8NWZX9UKAC56ov8vSJQ2uzkq3lVbu2EEl3mE
	QbT81gziXmJthJZaEeGp5JzPXnd0ygVz4QWF9HOJbzz6Nsio0JlLUFwyWpA==
X-Gm-Gg: AYBFou0aUlftFbseX+qgsrxnRCf7nlPISvgxL7lA6jcYP0DQbPvNVL4nEaKlsxlWAWr
	2mcgzQeJ6ar8t+5pR5t/DGuUMiOiKkMqFgnGkhc2tioPFZ8hz/ejqi7bT53ecGiKAWCY160ducL
	YKqb48K4ks9MuDv4um8coWy6vZiJPp5kHWKFUb133yoSMcfqVn3N90f6hS+kFT2WaMiTWERD+oL
	xLBmLVfLSgKr+WMNmGPlF1nc3nU5rMc/zo2n5vRtxoecFzDadB2XcNp7tojVc4cgsrJFTv8fDso
	1WnGi8dcxBe0qhxzEot8M0NpqE5wbhHRdoooEK9OkHx65ywT5Nndt7zWVDDxgHCC2uSCNy9COtT
	XKSHjtpkusak40GcnyRPcLOHzSn4kXIeyCHU9T6LAHSVEONuX7lhDDNKDq4WYIMMCbJAsocSD88
	XUHE78G5DToMLksokFDciJnfI6jlcgwjdJl40is/xzZss=
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr342501385e9.13.1793777479243;
        Tue, 03 Nov 2026 23:31:19 -0800 (PST)
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr342500785e9.13.1793777478812;
        Tue, 03 Nov 2026 23:31:18 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4532916f2sm29117235e9.5.2026.11.03.23.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:31:18 -0800 (PST)
Message-ID: <a323799f-a817-4022-96dd-e6f376fb4d03@redhat.com>
Date: Wed, 4 Nov 2026 08:31:17 +0100
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
Subject: Re: [PATCH net-next 1/2] netlink: add an optional per-netns ROUTE
 multicast index
To: patrick <work_patrick@qq.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261104033526.2917590-1-work_patrick@qq.com>
 <tencent_1E208C03035DF063166FD46C1DA1978F6306@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_1E208C03035DF063166FD46C1DA1978F6306@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 04:35, patrick wrote:
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index fe43e8595..0cda347ed 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -280,6 +280,33 @@ checksums.
>   These messages are now emitted at KERN_DEBUG and can generally be enabled
>   and controlled by the dynamic_debug facility.
>   
> +netlink_route_mc_index
> +---------------------

The above breaks kdoc

/P

