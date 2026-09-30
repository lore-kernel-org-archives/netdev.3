Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2025334C3C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777381; cv=none; b=saJDo0d43OZJ/k4TfzVNQ8jiJq8nlaqIgNUG0lxCEAp7cOyewAdBnCnwfe7Nt971hYIJEqGoDh8cUXH8eORWBCOEH3026Bau89GPoICwwsq5grmri+tmXx8zaysgESEo+x1jJrPSMNl85Mtk1M+Mh5w+uDaoe08OLxvgFwPoaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777381; c=relaxed/simple;
	bh=BN8qNZrn5KUe47KrPph76MRZuWYXHDzUb9aSvc4F6Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L23eUfN+nineXrjqGb1RtpIOWPwkH3CVnarVUdcKVSD/ndvR5erzoIGAOsxq5YKQk3GAPwazSl1yY2ldmS0eV59uFwIR6zA0hY71efydrKs9uoEunTyrc/j4++HkTVAf/TqjxLsiuEtWekxaS0IYGWkB7FJKC7WA0wwASyLg3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BusD2SQM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BusD2SQM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843af75de5so636148f8f.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790777339; x=1791382139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tdG34iKbPg/dwz5nj8mIvaNch6v4ZkxNF8npErR5dgw=;
        b=BusD2SQMeNc9qIwPavPHiOm5OZWZJV90oDDI/3iC5w1Nd0OUfddlgAhdKoB/0O3aHL
         geVMedIw7bU58L8CMt54+jF7iW8pqbUcmTxvrXDrGMFBb16mEGtxG4teFELoOapcFfLp
         bMxVW2Mg8N/M+t2vcQybJEhlIqus9xRCQKJVr0bu9qgZPY0uc+5ZQ8jO2h4AWGVDUPE7
         8iBVT/CCxZ9Th8+YeiFUZJufc27/PvZR6oq51kmJl5f3ez0lnDor1UmOlPsh4hHW2Ly5
         IhZ127CjZqiUc5xhm8xHrN2nvS4bmyoy8RO+C0HNRBXuxim08CVrZ8nunlzddNnGbfxH
         jYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777339; x=1791382139;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tdG34iKbPg/dwz5nj8mIvaNch6v4ZkxNF8npErR5dgw=;
        b=fWRz8FdAwHGKRjMOSLmBoe5Ip8MMM8SZdtkv7qVcL2PaDuSZmJLo5ZLRVgGJ1dRo9n
         BbQ4GJXm+a0nN595+jJh+TlIAqoF6V5tn56wl5Ers2IklhmnLYZmXHOyVf+qBiMj9cmS
         RuC9U9GM/JSxN6qu0l/rBEwIe7NsUmL1PMO2Flq8NE0piWp9S+Beh7FB0EUQoWiOa9OO
         w/GnH4pnC4uaUjVQRmvdkoJKMHNbxXuBltpJ0JGnTQEt7JjBdzow+Of4dInJIDypz7e+
         i+gDXAjRxzA3Tu+TA7W/qdfbs1EFZF6LAS8x4MKOJy0jSa80gSYSFqEp6c2MVCf2fcJi
         higg==
X-Forwarded-Encrypted: i=1; AKwUvBxTwx9oql65i4uU4Bl/EFVrqZT11yog8qYWAneVfdVUQIK0ZeqFeB5I0gTPLDj2Eelm9Gs28WE=@vger.kernel.org
X-Gm-Message-State: AFuF++k+OFj8cVS/Sv0lXIu7tTJTAChPGUFvl8loQ02IB6381CMn7boi
	oFPwMpYtLnZVwTcdswCmRieZdJzJn7m9AfZDnHaBEH88C1CDplk7D2+bTyJ0wus1wMk=
X-Gm-Gg: AYBFou2EYv4bZf5bDwlD2biFhhsU5Mnmu5iFULd6S8/F4cQgBCh2k34RE9EZLAUqBR4
	qPaokAgWRHS+fFtQ+48KzcHVsLlQkE9y5DqdPzZX97jZucwGlVLOD6zq0sVhmbiRfYQEL4FwWn5
	nolIZjL+3GGxwZBUKE2WhbxBxuv9O+obrS21aOaIJBPfuJQfUnkEE88uuOY7wG3Q0Xh1k5IAb40
	G4xHxnSsV+KZ8DCkubJRr7U9A1M9F/17A4m+32pUQ0RqSdGLXHdKwk8uygWRp82/GW6wzf6FMUP
	pq1Af9+VXLuPXbekFhwShy1AlXwIFWU4vgWQjP3O1JnnNvmJ4TTMZ2o1iVukGDf2Ki3XZBSugFX
	Tg8pbSV8FK4Zr/gCRSGmXFc8Eed5YGLWq8ypCkDKfl8+mv8cq6/Uzic8ORC1LOK91+R32Px0xky
	itPd2tPJQ+vsiBIwk4SsFMPf4dsU4D6WFXXl5hC6jUyTApwb9KUTRxfMk00dARIH9I6E95rrUqj
	e4s1lurKO1CvFK7qnQ0iEQ5eLN+U0DMaGuZAcU6C1mpYQ2Ttvk=
X-Received: by 2002:a05:600c:628b:b0:49e:6683:d227 with SMTP id 5b1f17b1804b1-4a01ab4dde1mr25863645e9.0.1790777339323;
        Wed, 30 Sep 2026 07:08:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01e64c322sm2327035e9.4.2026.09.30.07.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 07:08:58 -0700 (PDT)
Message-ID: <7d8f1378-d5a6-4a87-82cd-98eb794f85f2@6wind.com>
Date: Wed, 30 Sep 2026 16:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v9 2/6] net: change netdev_hw_addr_list count
 through helpers
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-3-sigefriedhyy@gmail.com>
 <235a33c2-7138-4815-820d-793568757d95@6wind.com>
 <CA+7S2v+VaVYksOpuUKzo+DoWZ97M_XKvnMr8cCcgwTkrOxsvEw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CA+7S2v+VaVYksOpuUKzo+DoWZ97M_XKvnMr8cCcgwTkrOxsvEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/09/2026 à 15:43, Yuyang Huang a écrit :
>> If you respin a version, you can use netdev_hw_addr_list_count() in
>> __hw_addr_list_snapshot() also.
> 
> Thanks, will do if there is a v10.
Thanks. FYI, please don't top post:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n336
