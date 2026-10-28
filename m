Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146329;
	b=eJ8q+beOPa9RNxFPnAH8tGzEgxTSoJ5YY1xUzRsRFtJkioLhCLMxpX83HlXfqdubQon1
	 gOvUDVPQh25a6hULTwNMT1cBWg+EQyFsbl5ezPY43JyTrKkDW0mq/9SfsfihBJGW63P/p
	 yRs8w04kMuioaQ4gD1SEO7pf6pS1O/whGJp2dV3wiOHqeiInL7j253Tchnp9DPNrLfTXk
	 BVEfxY+s5bioOcJpY9jGYwI9F8nHC6yMzgz7P9sUAv0jKdX0Sw8SkUwZDTu2zfIQk4M9m
	 T9q+tmuqv4wJGvpFAPW76UKGsUEG74UNpy8znhbuBqEoS8WuXqCPP4KOvoks9EyMniA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=X7/TY3AgukGfoieSJDQxLpG5Fggby8BROw4KBBUkUhI=;
	b=leooeYyotzJ2BeFXRFiO2JLJ/3KovbSn9PQTbTl4rjGtt3Y7KHFj3L6MXR7aPJ5iUz86
	 xJetj1ryM3ObWjKgSece/JDqdD4YNXlbL0suvrAeMwCNwraHSLs0H2X8aEz23ejP4GMHk
	 ZW7AGM7860Ex3ekhEhgu4QuJHVlWVZG3iIR26833enBmpJasfDRSIqswKnItWH1Iob+kQ
	 QrqkKL9OfkeuY62vrR08Q5DyC8HNgDDFusAf9S98QrDrpZpY1z2ZRjML3LhiQxUe2sRTF
	 1u7gJHnoks84vQYdOSg7JglxRF87wGVpuIyoivK3nCD36I7fr4arvoSPsRqEqWeCfzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3vjEIj4;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CF606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9CF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3vjEIj4
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so606785eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146328; x=1793751128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7/TY3AgukGfoieSJDQxLpG5Fggby8BROw4KBBUkUhI=;
        b=J3vjEIj4VNTW9zJPu6xP8J//CiufUtoWOvE2tqsVUE6wmkKpeo6OPGbfMBQ21xIXYk
         a0o+zY8whCEOuDIWAzWsRfxM8Tzo8JJI0YEUk6AEbpSz0VV+hASUzkQDRDXUtmEzSPeF
         j4/0GVA4WpsUTwbOOKzHZnXWqFh64GOC/7zDm06IikH3H+3C9Gd0KalrW9eJC+W3ttnu
         iE2ZbLVM06+utlh41bE8CSU5VZBcvmMrkgdxm2BAxXyLw91M+IImGl6dnRmWDgxRbuJ8
         ZD+TJ55TaEQK7i7ibP7XRHac/XCKmce9WMcN6evVVir63HsDDzT40kgjVGYxcQj1jWu6
         KGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146328; x=1793751128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7/TY3AgukGfoieSJDQxLpG5Fggby8BROw4KBBUkUhI=;
        b=BNg3aIGJtC3m3y9Pi3YmI0g5hZ5qiaTDxl3CQjIWT1dMBhJDTpgqZqPBzuStAzlFSQ
         QCH6sIHlm1d9y+BxTnM4m8NP5Apior0B9xm+e9iumj+8F0YjXeWyenwiRwiRPpdYeNCx
         Rp1xYUov/fUHPd5exEGCHdLNh+jdd7ocsquq+wRVq4uLyADzE6eZWi2Xitc5kbPGZY8T
         wyZjuMKOw1nhtAyk+xtbll0YkQqyvbh45Kxsz4Xqm6oNIRbLpc+dxP2hE/cadKn2HBMm
         g8FR4zxJKMk+rNjrve9Tt8zQZ9uGim/6ehjLwu3ycTF2mwHTR/gQXcJ7UYlrEc+Ni+NE
         2K5Q==
X-Gm-Message-State: AFq9FYLPkamapNQs1EJRIUOLk3y6iTf0fq/SNBPwmVMpmWk7NvkZb4fJ
	29z1lJ5bp587rMr+qYeyH3jUjF9MLOn6ObAY+6Wd9y1dkUBl3/RfKgvu
X-Gm-Gg: AYBFou1ionOfHPcwgUcEtVndS8bGzmq1W+TcIEpNqFPg0prdTBg4XMDbKHmGIWc0VVf
	5n3nObM4C0tZ5oON2tDGFTcepq5Aq6SQ6/FcW4Vc4VAwAgDi/8w40NOjjmmeWqmob+ElIzSUBwJ
	bPAR5qpntG8Ra53EHXmWYn6kPuV4pg2XGqBPAG8X+5oNDOsjUW5szRYE+m6RQkHHGSEz/IW1Doo
	7wAGiT9Fj8S1X9DvGr/y0Ei2SJVM8CU5ITEezrRHIccbscyr+u+fo7dJRY4u1qWXSpoL4axJV9H
	taetziuLBr23wLLeYi5yPJW4THaT43wYbptbdZawk5i1fUxkgte0Awa2IC9Tu3NVLDzE8r1oXhm
	zBdl2zmSPh0M4xrl3nF9RXcp5qCgifP7Sc9smpEn4VBr/cwFQ3J1t4jPOuHIcqm9p/EduZ/iAQu
	cElWFcUy4jNvHjpaEYC6qtp0eVszuy3GL+267zTGlkzj+/ZIL1Jvk8BGz8PjiPM20dpvep++yKO
	OOZN9LI9bc09hhpAr49t2NuLpnOsjbfWCVF0IObMX8XHrcprzdXn6Hf2wuAgJkZkLGoKoRnwsTK
	AsvLmLurcbATkcBsecEOd6UxUH6R+bxSuQ==
X-Received: by 2002:a05:693c:87d0:20b0:35d:eb9c:fce with SMTP id 5a478bee46e88-36a2009314fmr1308536eec.25.1793146328218;
        Tue, 27 Oct 2026 17:12:08 -0700 (PDT)
Received: from [192.168.2.21] (wsip-184-189-202-35.oc.oc.cox.net. [184.189.202.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da3e1sm461059eec.8.2026.10.27.17.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 17:12:06 -0700 (PDT)
Message-ID: <49ae504c-b22e-435f-b727-91db5ca7c0b5@gmail.com>
Date: Tue, 27 Oct 2026 17:12:03 -0700
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
Subject: Re: [PATCH net 00/11] net: au1000: Bug fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jijie Shao <shaojijie@huawei.com>,
 Simon Horman <horms@kernel.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 David Yang <mmyangfl@gmail.com>, Herbert Valerio Riedel <hvr@gnu.org>,
 Jeff Garzik <jeff@garzik.org>, Danny Kukawka <danny.kukawka@bisect.de>,
 Mugunthan V N <mugunthanvnm@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Manuel Lauss <manuel.lauss@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
 <20261027162136.301932d4@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261027162136.301932d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/27/2026 4:21 PM, Jakub Kicinski wrote:
> On Tue, 27 Oct 2026 15:31:29 -0700 Florian Fainelli wrote:
>> This patch series contains bug fixes that were found during code
>> inspection and also during fixing the open/close/open issue that was met
>> on the MTX-1 platform.
> 
> Are you trying to bypass the 15 patch limit by using 2 email addrs? 🤔️

That would be clever, would not it, not at all. There's what happens at 
work and then in my "spare" time. Things should slow down once patches 
get accepted.
-- 
Florian

