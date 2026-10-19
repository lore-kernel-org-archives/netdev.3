Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13E48BD5E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401300; cv=none; b=CyvS2ixSn5DcgiUPEYDZkoc82AQ2fKpnyRpfr1y+iXe9cFY8CPV3vIxy+VTLTAYykttS32nWOS0Q8pqfs+GmgaD3XVrr/ypg9EMUWd9jxhfbt3S0k2BlkhbuVD6qn2N1K3Z54oC1gsG6zT12MdB/8IWE7acsvUs6NxBtLz3r0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401300; c=relaxed/simple;
	bh=p2RH2VcYKrBxMnwj8kxe27aZikBnTcxMb1JiDVHKw7o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dd3RnIROnwv4+ysXxR1jrInL6knGPjHlc8dUD9V77xFdO1QFSpKYGqGK+pso9ZM85vNFLrlLbrAaIHMog5XYiuiWqir42dynLIHFf+pZUseWWBWCW3QI7MuXS9gpGiB3DGsga2ZC8pb8QKI0pnkSXLivLqZ2ZpJv6ktYcUu4U1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuKhBbCg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tHrB3Dzo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuKhBbCg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tHrB3Dzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792401298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2RH2VcYKrBxMnwj8kxe27aZikBnTcxMb1JiDVHKw7o=;
	b=PuKhBbCgCC13gxgl/2f2G/EB8BV/ChwcGuikx7xz2b+mbSExxG3Pb/FX0aFWCoHBAt/n9i
	cj3GULQtkjSS+KYUhkwQTIc5vwoEa7ck5gOaJEXSq3moUtoe2uVfJhpHEKBm9k6Zqx/HZV
	cEK9gEHI7yZZqNb3Z40Gmzep7wcCKEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-1gjy6HkgND6UTsEqQ9kXmw-1; Mon, 19 Oct 2026 09:14:56 +0000
X-MC-Unique: 1gjy6HkgND6UTsEqQ9kXmw-1
X-Mimecast-MFC-AGG-ID: 1gjy6HkgND6UTsEqQ9kXmw_1792401295
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1bfd5516bso18980495e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792401295; x=1793006095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p2RH2VcYKrBxMnwj8kxe27aZikBnTcxMb1JiDVHKw7o=;
        b=tHrB3DzoIX0zEV+8hoCBxyitbnw0uQ90tjtPTOyA2VGd74QKVujz6BVn5dYQ+QzgcB
         4+pFjTYDcL9ymQzvMMpJSRy+N8NcU0TBDNhjtw/GUqlT1z/bxmCE1/d8e9cSUZt+v9Xi
         hjHcTCsepLgdbGNUi6K1YpYFkb4iOqkxmB1ABwnO0sSfDcCwp1FaT63U0HgD7Pd4pXjw
         MlhAM8OUr+GN3MZ61kQvyw93OV8sVXZgIWgO+GkfzcfQDkaSRZuPJqfPQzkxDvTBP/Yg
         /Q2Yya9YKZMZS/5VM4DI2kqX6HrQ1qUwMHR0NZ8Jxr8Y5vI5RiGcrY2APWAHmZoPDkxJ
         +YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401295; x=1793006095;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2RH2VcYKrBxMnwj8kxe27aZikBnTcxMb1JiDVHKw7o=;
        b=G8Yjq6SuT9hk57EzWsJS2Twv0eTkkaRL58sLIppRAlmR/bXNzj2Oz5oqkBe69h7kdd
         yEBT3BBaRb9tAC4IIvuNuEyyeju+RnLRWFn8ckZPLxLq8D9gZfZ/4KgjrA/1rinAH4RX
         ZyD5qZq+JvXEBqCRQcIK7aHcMCYI+EH4wDr86IbNt+77oGJKP25ht/ChM0vA4N+d+sqn
         zcMVirUPD63I79zn6R9qjLv2FYrNAJ022o3ThdV3x2QeVnDLuuJpqXJZecffEg9rYO2i
         cUv+n5W9tE6fnEPA0PFwrTS0AuyfFMKKvbat3SFbA4T6hXEQTVNb+e3JMXmb7KElhNgy
         tI3w==
X-Gm-Message-State: AFq9FYI7NwQZY/c0vqgOQaxWa4935RBD+bbToypveO0ey5wo3st3iHFa
	abw9lh0GMvoXy32zGir3w4q2JFWK2TKqE3qlkV+vfRpdXKIV0GF1t7wjLneUYHVqu/uUzAjZoYj
	zVHD/zp/3WxTcB1MxbhdojLkGNGhHia2pjsy+x47lwZMSXJONuL9dlHuShYYV8rWBRHilNXYLNz
	+6s/o1nQyTk0lBAmM3KQKtMN9Z5yFfR3YmaeUi1qY=
X-Gm-Gg: AYBFou3SY4B9HpNHlSWgvAKUz1OFmjYfAqaQOmJcjGQYLX4AzG7es+oilbLOAR5E1aq
	RYVtYU/h/pWsRZVsV4OW0ThpNv9aJRZDe7Y4TZYYNxJkrsTRc7jiFSabiQq72KbJtXdM1bEv25W
	6bNuaYbWmAPw5GZ4BGFinb2xYIvOBV1HxnQFQsT+DU9JEbGQ+yHEuYuHZxMun6KmACshmiNu8JC
	RgQx1OUNwrclFjNDC5WN4mKzfN6xKnMwAvt+NZn57geI2w3QSLn+06HhXxI3+GTRbURNToLJq9l
	cxc5rIBUZXaF5RlH5sPkE74RUxjdrsf290uw8cNhKyFkHpNFQQVOSWhsFL6yvQGYQgmpMg8opsK
	tVnDZT23I2Lg0U6+jRCjrtO8a+myCGzkRR/snOJxsJVp8M7u0U0CtXtl2o4u+NkbisRiJWFpY1A
	==
X-Received: by 2002:a05:600c:3547:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a1d7608dcemr143891875e9.16.1792401295152;
        Mon, 19 Oct 2026 02:14:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3547:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a1d7608dcemr143891375e9.16.1792401294536;
        Mon, 19 Oct 2026 02:14:54 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm23407259f8f.34.2026.10.19.02.14.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:14:54 -0700 (PDT)
Message-ID: <7a0446eb-8539-4300-ae0b-a3d66a692cbc@redhat.com>
Date: Mon, 19 Oct 2026 11:14:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: network dev <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] net-next is CLOSED
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged final v7.3 so net-next is closed. We will look thru
what's one the list, new net-next postings have to wait until the
end of the merge window. For this iteration Linus is planning a 3
weeks merge window duration, net-next will re-open on November 9th.

