Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159325742F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624372; cv=none; b=C0r9rxzjL/84SgJfzz3SdmJffWszgZzDa136ACGpC4h+JeA9cuRF14WUxXYP4jodKcy7tq/ul1uX5fkdJ00f91Qo3ej4UBpbqMZJPv95m2a5j97wln5HYIvxZ1Cd/6UcwhvMSNiTW7XU4BcZjHrUHVdXHxLeASv/immVU0hIh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624372; c=relaxed/simple;
	bh=k0f45oBFvTFVQ7DC9wNPB7+X1+zqtJC1vUVZ0bQIPco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZlS9u6QBStwnDMVuETngFbhAxf/9QAEBmPkJsjZIa2ZKE3RiJDmNdegJKcyL3j+Oxwnan6iIr5lrUi4y5J1Er0WsRvp2q8woJ1P8xkVoktBF4JFSmRVwg0sjfDgdHJf8FobrIZi34B/LrGlb3nJOLJBgjSeSc4o7/XcZHhSnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHP4cCHj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAgQxPVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHP4cCHj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAgQxPVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784624369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3gpPYDHGVj6XHuBG4h3W49mnL8L+Vd3EyCXTTEn/KM=;
	b=jHP4cCHj9MwRLZpgVK40ai7CUpAoKJ1MqUlmyS4d3vAkzhnqo16qywKgI1fqDOXVif3n6A
	k5ceto0baZiJc83QoQe0ZXJYWjl/x6v9piebkRVeuUL2BsffK/E7AT5/kZc6aqv0ZYH/tv
	mq9v7dtIDpML2LFRsvg4Z0zr3Sj7Fyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-xiunKhlmOoqeYIt-lea46g-1; Tue, 21 Jul 2026 04:59:27 -0400
X-MC-Unique: xiunKhlmOoqeYIt-lea46g-1
X-Mimecast-MFC-AGG-ID: xiunKhlmOoqeYIt-lea46g_1784624366
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954fd771baso15744305e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784624366; x=1785229166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3gpPYDHGVj6XHuBG4h3W49mnL8L+Vd3EyCXTTEn/KM=;
        b=JAgQxPVphPi0SPde7V3cKMRvK0/hjhVL8THVps549OrLUkhozeqH2qJUGIffq+1R1E
         h+epYYz7HkQuuGiI4/ywsIam/DfEp8BwHHhJ/Lb7PcLTSWcMVqHLFpIA1dQFo9tlZ5D/
         xAIX24xrpD92g/P+c0+o2jDijDRoKtaiJbsa+j/diQ6X7M20wsphi0Rt/vflhAYkSk+z
         3zIJm/mbNfP3l50xRhZTCxII/c0tystjRUeEknMSqkHkWlVBvGa7cOaWUmjuy+wFaBEg
         eiE3efZ64hDvR3bVGPsWEalyPF38BptV/7JwIqN2Jy2nDiXBfUaQHE5vT6MXkyGqyERZ
         Gu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624366; x=1785229166;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3gpPYDHGVj6XHuBG4h3W49mnL8L+Vd3EyCXTTEn/KM=;
        b=SxGdcqh16VBWwghRecgibinQ1BbRdb8SFgVwLQIe/SQRBYlZB2s2nTntEKJk89JlVd
         oYb9UL60hQCtNzeVvF9H6vlbguJEVnjQjfYvoL4nhDGaPkuvMVTiA0cP3KctMpXmG3ie
         esed7mxDHO6UHK5TcD0zZXnn5Qk0zfDaXv72Vg6wAwkS6U5EsuH7uyPb9bIEoK/+7kEF
         gX+GBCQyi4EZOSvrn46NEUGh1GPvllN6Sk8hjE3RR85GVuEoIDGWa19zt+VIK6VgHaxV
         2uq6BTJU4Mw9b2VBzLGvxM6ePwBSmKPwiYpE36O63sn/beeDPsX6l08eLUMPibl7uyVn
         9pxA==
X-Forwarded-Encrypted: i=1; AHgh+RrFwTqLMlb7ZQmWCq160pB7q+C0xh8E1GmfsIB/2cS7pMUlz7i+2ff7tq9z0WuQ4wEYs6+oW64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gG7Qs/MVtbHjtKWJxJjDGaBd1eZT7mERDdLhcgIRBulXIVur
	nwjzKryzJSObBrjbbPKvZlPPg3bbqDXpOPGffww2bS3a5HSU4zt3rJZpbBBwWf1jut9hksEuR52
	fa+d10AeaPbmBM1HonKm/670becm4uutHIhr4px8joIiewPlNBmeoWoF+DA==
X-Gm-Gg: AfdE7cnC8bMwQSda09lWQGdCMrjcJQUJB2mDzIQ2zBgs5EJBQmILHNi4kuO/OX42NBu
	KsxE9VbOxTTvi7Au59Rn0RuZSUlabljt8AXuCvVAnHH/QSaKxN2tpZNNKK3/QMT4cfQmIGmh3rO
	wjTO/bsyxH8LU2//ONMOSfs36fS5fUBfkZl7Us75U+K5YjWCd1HWm8RCsQMeO90eWA0f7n52nd9
	90QIlV4tpVKO8d50Azdhv0+FsVwRAdLxbKOJ75zId8WdSjc+nH1XoOVsgcHvt8uJ1j2rRV5XLrx
	2ZClbZCEiS5HJwLGlRyWMfpcdvXtcSoQiTaSkIcPGoBXlkXw0pkELMh2KbL401KhAOsPWZu8hUD
	9QxK/05Ztsn9yxUPQbVvMsTTY5oDUFhWY89EI9FxKUz4FwjANLnNBbItw5KukUdTumCryQimDGL
	DBfg==
X-Received: by 2002:a05:600c:b8a:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-4954a33dc55mr185849405e9.16.1784624366486;
        Tue, 21 Jul 2026 01:59:26 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-4954a33dc55mr185849115e9.16.1784624365992;
        Tue, 21 Jul 2026 01:59:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565373200sm51129795e9.5.2026.07.21.01.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:59:25 -0700 (PDT)
Message-ID: <0db18429-58f5-46de-8cb4-0a934ff4d650@redhat.com>
Date: Tue, 21 Jul 2026 10:59:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hsr: fix memory leak on slave unregistration by
 removing synced VLANs
To: Jakub Kicinski <kuba@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+456957213f32970c0762@syzkaller.appspotmail.com
References: <20260707082327.3238690-1-edumazet@google.com>
 <178406192459.16306.5204629050926533917.b4-review@b4>
 <20260720181259.4e5f976f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260720181259.4e5f976f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 3:12 AM, Jakub Kicinski wrote:
> On Tue, 14 Jul 2026 22:45:24 +0200 Fernando Fernandez Mancera wrote:
>>> When an HSR master device is brought UP, it auto-adds VLAN 0 via
>>> vlan_vid0_add(), which propagates VID 0 to its slave devices.
>>>
>>> If a slave device is later unregistered while HSR is active (e.g., during
>>> netns cleanup or interface destruction), hsr_del_port() is called to
>>> detach the slave port from the HSR master. However, hsr_del_port() currently
>>> does not delete the VLAN IDs that were synced to the slave device by HSR.
>>>
>>> As a result, the slave device retains a refcount on VID 0 (and any other
>>> synced VLANs). When the slave device is destroyed, its vlan_info /
>>> vlan_vid_info structure remains allocated, leading to a memory leak.
>>>
>>> Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
>>> hsr_del_port() before unlinking the slave device, matching the cleanup
>>> behavior in bonding and team drivers.
>>>
>>> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
>>> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>
>> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> Just to confirm - is the sashiko review a false positive?
> https://sashiko.dev/#/patchset/20260707082327.3238690-1-edumazet%40google.com

I'm sorry, meanwhile PW archived the patch; a repost is needed.

Thanks,

Paolo

