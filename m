Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481616;
	b=F50fCI2FZEom3jKwQEHPvY9CTQifJ9SWKB5h0L7olSQpIUGj1Aqe81LclSd2ZqdyQYUR
	 Q/fbADmAYALBp/xLx5P9o9IC2SYEFREGVfEWXFtJjRFHzyZtQUd4ZiN0bUsRsC+aNoguE
	 ZpyRy+R2CvbO0/8So6qR4mVq8pwX7irNBiNN0jJnIvCFjSZKiNBW0z/y3jnp9rrX0LUTL
	 v5BrLAcZX7p+d17RB4uWsBejph2+eZi96IxBkARhiK8oXUUKNQDFOlebD8/6FgEzWz0h/
	 HfGNeNs9X7kizyzwJpAN0RJ2IAQ0KXzdJlYkQ9Pm73Bd7/Q5EmGzDph6wZR7ZTJ8F/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481616;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jkl+rtsdURDObBSi0vgDZpi3RyOFjXWoPZgIXkAsj7A=;
	b=lpmllnRVXMXKBqVmXIeWpZab3rFP5FsyaNEht1e2PurL0Spl5XuahavOx5Pjb27G1x+N
	 NoZQQ+Q1Z4BJX5US365joUGbo3bfaQ8bzDnQZ2g1Ffv4iFoxXeaILdgg/2BuumiAOabdL
	 Og/cnpFee5JZ5fwBzduC54H/g+/v68eR5d6p39L7R7TYkHTMMc2ZEseATn7aVXa0jQ5eQ
	 bHNA+XVYo4VVWw1/XMic48xAtLSnmRGZDp2BZH6Y+0puwZYNRwxackME226O0/3/EXhVf
	 hFFF8VQq73dU0S/b5RAfUV7EVQDHwfj1eT1StjqkF6tFv9oL+3JdnmaiigCndn4yHYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H351vfbH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ayze4ztQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8D606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H351vfbH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ayze4ztQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794481614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jkl+rtsdURDObBSi0vgDZpi3RyOFjXWoPZgIXkAsj7A=;
	b=H351vfbHcf/LoZ7ZTeAcI/iLTs2uCB3mjPrgiJJSCcxRWMgJRm8FeATyH+FAJZvwk7FRe0
	vle1R7Og1ZaLcI28E5m6JGAMs8HlVrlBeX12uaD062uE7idYfvNSgR0kWOPSa2u6rzrf2+
	BKvUBmUjCnkDQ5IvUQjP321iZ9tEL/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577--zU7C2FiP1OKYhZdd3qr4Q-1; Thu, 12 Nov 2026 06:06:53 -0500
X-MC-Unique: -zU7C2FiP1OKYhZdd3qr4Q-1
X-Mimecast-MFC-AGG-ID: -zU7C2FiP1OKYhZdd3qr4Q_1794481612
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso31106285e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794481612; x=1795086412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jkl+rtsdURDObBSi0vgDZpi3RyOFjXWoPZgIXkAsj7A=;
        b=ayze4ztQA+QisQAQKoIp6BxYy7yIeln1fLI1Bxpnh+14J9eHN+fzPPKxMJrtg1zsfh
         LF9QLyJtCzy0jSp0Bx9nhJP5AINvC/bxkSevQ7zEFwFAzk0JU2SQUpbiCjAFOcpPo8J5
         LsuxCUCn3aQS58Sz1VWwqPUeLY5o/vllCD9rfP7hoBvmD9aHrTsLGTSTJ0jrECS3t/nF
         ZUQMqpdUQKQCsrMdEDuTT0yszTjwJTdtGSVPUYWbVSerqfEmqRUE6Kfxzs1VJCX5WvXh
         X//6V1As9hw4xvDLk7A3eUJJadr+xd6Rxt0ZFKNEh5GrCR8E9UvJTbyQbo+UIGMfLIMW
         ShGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481612; x=1795086412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jkl+rtsdURDObBSi0vgDZpi3RyOFjXWoPZgIXkAsj7A=;
        b=GFCSKvdxjZ7gCXhyGokdoNStYVPDRWlx2jpKOxtYzkzANGTFYqdYweiLtynStfzGow
         KCQhpOkykxkOCKJyUEKoDqrje+URlxGOuM7fk9SXeq22/EzNbbDTn+Cbu2jiOVaMQEFW
         P0NEiRRG4GZakB4X1/NDJ+jOtbtB14OP0KcBVACNR/UIeiQoAw2oGWInMdUxQreImjjQ
         METcZ+afwbsM0qyC+fY4OSiy6gBtOmKcMdxndg3K3+OJ4QMTyoQeC7zUj+iZXYaudEGZ
         cjqzMPlodSVWcWxzZq3pWxVgdh8JFxdAmi72/PEcRVydS0LrPXxUT+JyF3fcBFUOPM6c
         xNtw==
X-Forwarded-Encrypted: i=1; AL+hErEmYtbhSvo0NAkd2yUx37J/5shwOCb97VqAmeNG9deudqhn4qcnNbx+G/dB1ySO11uhCsp1Hyo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/drKOqMVxlxnqZ0gjiEjAeIOwwCSZiSifulbowLqTtRyc7B+7O
	3rzjdAhdJJaVbZfAGsE2f9OQGnopp15GtGhcuNGiU0MEZY3KzIXvfK/ylHymO9UUNFBWz+/+Ry/
	wkrIoS4UXvMd+XjhRCyey9bRKDBLPsyzlbJmXm+VeyF82RvfN01Yh6ogWXg==
X-Gm-Gg: AYBFou0xBdsQD8oSDqZc0FA1vHe+HqrlSC87CGeZ2QwWREhbpGqEaoHBhZE/imZHdok
	IxAnR9P0aYamClKr7WHr0SF4I7u7yZYuqR5eJJ1CoJFCUYcUq07GuofhGaHqrGplWhGb8mNWQqq
	cwiIrERSNU5iuqbib19N/IMgj7Agj/8GbC0EnD1zk85a/2VVEYZeKHj57MZciPCosRm29a1n1pR
	et5tM24WyerSwbGKlgxOOslT2+FhgVMyBBpdTqT/bwwTykThn5Y23ozhnEWl5lb6T3q7hrx/dhC
	Y9T7xA+sg3VbCkftevhPHIfHFAIGZNrQOvlna7pMB2/SDQjE8VqQJzJSApuHuJnbEmuxTytbkJ5
	++C0O6i2lNi+IUi5mpgwCZK9GkfyZHQI6Vb2CBhOvweWoQaoHyJ2GWjwTvAQoi1oPnJKIy8vFwV
	PNcXlwYOg5z5DUfSYjjNyfnMWkAS/5s49rUkWfVreNIG0h
X-Received: by 2002:a05:600d:c:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4ba093be23emr82662495e9.29.1794481611716;
        Thu, 12 Nov 2026 03:06:51 -0800 (PST)
X-Received: by 2002:a05:600d:c:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4ba093be23emr82662225e9.29.1794481611257;
        Thu, 12 Nov 2026 03:06:51 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm70550895e9.10.2026.11.12.03.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 03:06:50 -0800 (PST)
Message-ID: <a8cbf073-c242-446e-85e7-6cf9158e0b9d@redhat.com>
Date: Thu, 12 Nov 2026 12:06:49 +0100
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
Subject: Re: [PATCH net] net: ag71xx: let both QCA9550 MACs use MII, RGMII and
 SGMII
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>
References: <20261106221607.16215-1-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106221607.16215-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 23:16, Rosen Penev wrote:
> The GE0_SGMII bit of the QCA955x ETH_CFG register selects which GMAC
> gets the SerDes (QCA9558 datasheet, 10.8.1): when it is clear, GMAC0
> connects as RGMII/MII and GMAC1 as SGMII, and when it is set, the other
> way around. The driver only allows the second layout, with SGMII on
> GMAC0 and RGMII/MII on GMAC1, but boards like the TP-Link Archer C7
> use the first one, with GMAC0 on RGMII.
> 
> Allow MII, RGMII and SGMII on both MACs.
> 
> Tested on Archer C7 v2. RGMII on port 0 of the switch works.
> 
> Fixes: 0767ec042897 ("net: ag71xx: extend link validation to support other SoCs")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
IMHO this is not net material.

Applying to net-next.

/P

