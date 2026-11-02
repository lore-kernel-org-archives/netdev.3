Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638732;
	b=0eT241oRPNOAOWr6ryb7Z2uVBYZRNWgniRAR5AHQ2N+wYOuuv5l51XmIgqprTHVGSZ4B
	 jzGpNpm27qnC4izmQAj4908QSv1TF/itSpQ/OZq75laGt4QnxDf0rSOiiUIaYIdU9BFk9
	 eGYO14c2eAym1OcXKA2MB+sjAnmEo4UVvlpGkI/V+dMVzffcD8j2ad4yvgRPowedbBNFh
	 Vc5frWeFY5SwRpK1lzjQhB88dqPq2tFAOlMda/o4mYoKYNtNBCZK1v3p3H1gXajiDRaut
	 VZOfj3p2PWOa201z7LD97pFlvKzepGQgcSbSyme4FXx0UCuvARI/cO3hXxIv8VG6zzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=a1UEizqhRrALzFHTNmQJUTSrG4L5xUZaP4W7alKZj4s=;
	b=RpGEAhqnnXmpGV+EdK+P7rqaoLx0q66RNDg5pWt2xcyLsySWdGk99EqEt1gBkV8uVmnz
	 NO4JmhAgaVpKT7SwxWO2SmqnEFvutlzAai3NPL8fzSt5HhddYtKgMl7frLtE4+rs5JJgn
	 q70pFyYRVG+R1Vh99uO0+lYY5AuMoteifSykdziehlhkYHOlkAX+vlNH8Xcs/9VxjkH8w
	 65hfUx2T0br+EbMAE2ZYSwGaorQjErwLA3CxheOV+zEeIsqC/BxuIv2QnUaYlVXY5gy0D
	 24JsT7zeRL/8750z7hBVB5tey9u7IhZriOLPNGFyYhH6UNag1ifNARRNo3aOJvxuj8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxufiMKy;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22A606A5BE
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D22A606A5BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxufiMKy
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e96502e447so30031495ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638731; x=1794243531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1UEizqhRrALzFHTNmQJUTSrG4L5xUZaP4W7alKZj4s=;
        b=YxufiMKy+5T6HFI/woya2krFgptqtHLbGe3rwyLWiQZMTCIIxkoLbaDFYuinTxnDFQ
         jBNeRWpghfgUamRChITph1viv7GFidy9xg4+jtJoiBRdR8InNlMfCI05jOIRCkoqALPK
         GpA8ByvN7M6EL+H3AZZh2427QyqKSXxkbrSYxWIa2YHY8mR4wdniz25s+VrHilKMecZ5
         iN+88ridw0KG+e9+ILMExg7wzeDWazL5ZXxTMlsM1iO1815PwMqxV/JXNb9drO1a7Kqb
         GgJoT13jzZAsjaZuixpDgSYbCxuTuKN0hLBCDqQjivoCOgZsS7uIJh5fm89oD2UbzlHD
         fVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638731; x=1794243531;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1UEizqhRrALzFHTNmQJUTSrG4L5xUZaP4W7alKZj4s=;
        b=QPmIy600n49wpT3RrCeGUSWCINJ5dlRLQNlSRRMzaiVpci2IhRFninCDtwLP/WAd42
         qLitbK0DNepUipmKHCXFpE52QXBnUqzGf6ijjCzIHr98rnqpGegZH8nDqvSbQLYHOSXR
         awuX4BWff9HHCCiFmPLSbPqF1cHOP/bgP5ZikuF/dgzLX25WIH7CRSdEsdcVqA6UfzSP
         TcC42LyG75mpufkQ6XaTPfEqhInao9LuhDz+oIBnR3iU1vcK1YX+Cjqq1hLuDKf+Xr1o
         DiKpAu1TLrJmNjPdH2neO29sE+6kGXUU8/IdRI0LIt6KkNXg9Wz3ECWyT261RBQkU4Us
         rWIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxMBHOHHvENrbGqrUzodizbnJilYOgs0POllE5ShyuLNqCaxR8xlCR1L2VG4HiGPWpVpN9YYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/e4Rnj+31+qoF9yYxay8m3YdcY3DVD8qEzXzHbSSWiJHus7mZ
	pNc41FXh/Izeqb2uVS5KGWFlbK22dwKdm+aZo9tG8aSuDzK18QnwiOpL
X-Gm-Gg: AYBFou0PVRwA56UayAtzszhbelnbSNq+q/z90Qf6ptiuMXBOe06u+rK4O5jh9/lUKIH
	PPHL4uHFMmllEdhoxrTD0I2p/mnUpmapX2gR2GYsBf+BXvwVoXjD/u68BY0GeAhyD3YvBKaRi9a
	jQXDQ47IxCN98SWSrclaZqlHLfkMZiWKiwyoKANS9pjvrgQjtuFgNaP264ni6hjqp7LF1zR4AoN
	VhVEdAZLMRDmtgJIhGfyXCoImHf7LSyip431wXCdDKHtV3KgFJNRzGqasm6o/0FwulybN+u/k+G
	jpemsLb2+ReCRmhB+BshmVt7pGYkQwXQmkaPYcikc8cQbfF7sMe7kqfeI5Ybu2nXfzS/iORoL29
	yYMOsrccKoFt0/nWS/kJvxbSnAFkUW4VKeMDhKvKRbqVwBPwesmXLF27OwItgI6sVla8n9KF9SN
	6X/NQ4dOeLKh1+362YlTxpHPl0PQOxzPfa15Ct63nZofyf+gm3LLEgf4juWc3pyR3d/gsYHhxYh
	Wmczt4pn3BwoA5WM1bck/CAoDN7CemxflcebA7cBNLuqlqqXly1evwP3fQLgPBWT9Lng2WANm1f
	wGGWyS54G5rTdd9gBK1Ejy73XpYx7iRMHZzt2KuiiPcl+tJfgpy6AVrfwmP2jjp9o0lNrKDzzyw
	=
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id 98e67ed59e1d1-3ae8985d52dmr9637264a91.56.1793638731557;
        Mon, 02 Nov 2026 08:58:51 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::4:97ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85d24261sm8776807a91.0.2026.11.02.08.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:58:51 -0800 (PST)
Message-ID: <ea9e29df-6f3a-4f98-a08a-d7efbee2ce9a@gmail.com>
Date: Mon, 2 Nov 2026 08:58:49 -0800
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
Subject: Re: [PATCH net] selftests: drv-net: pause: Skip support tests without
 link autonegotiation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org
References: <20261030173516.1002250-1-mohsin.bashr@gmail.com>
 <701c6f7e-e715-4647-bddf-48a1485afbe2@bootlin.com>
 <7cd99851-5bc0-4db8-a44c-a664c3f824b1@gmail.com>
 <2efe9f61-5a04-473e-bb57-12d2779ad829@lunn.ch>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <2efe9f61-5a04-473e-bb57-12d2779ad829@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/26 1:12 PM, Andrew Lunn wrote:
>>> Or maybe a bit more clever, have a quick check to see if the device accepts
>>> an ethtool -s XXX command ? looks like fbnic will refuse all of'em as it
>>> doesn't have a .set_link_ksettings.
>>>
>>
>> Yes, checking whether the DUT accepts ethtool -s is one options. We could
>> reuse the existing autonegotiated and forced-link attempts, and report SKIP
>> if neither allows pause checks to run. Alternatively, we can add a remote
>> arg to require_link_autoneg(), default to True, and pass False for this test
>> so it checks only the DUT’s autonegotiation support.
> 
> There is a subset of pause configurations which don't require autoneg.
> 
> ethtool --pause eth42 autoneg off [rx on|off] [tx on|off]
> 
> These can be implemented by a device which does not support
> autoneg. These setting go straight to the MAC. They are never
> negotiated.
> 
> 	 Andrew

Hi Andrew,

Right. The autoneg setup and MAC pause checks need to be decoupled. Let 
me respin the fix.
