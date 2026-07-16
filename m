Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E635E1D1
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195181; cv=none; b=aeTHai5avVWSVzXTBwoshECPHJbeofImwP252wUVIAVqVBAeyE6TxP0iQ/NCyLd8n8V0ceoCV4VU0L8mFTGbxuq7Wkk63AXejctcb8dNYnis3Se9mZSMqsjblNs1LONxRdUtvRwuFExAo59/ZXyMsuna5Di0oNmWaVw8ZLdQtLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195181; c=relaxed/simple;
	bh=xVT23QRkqhJ4KVE6Xjupxflg0Om9cDeSJhRc8LkXLOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwLI/kcCncrZ6/3ulSEjoxBJNcnmzzwNzWtkLSD8NxY7Nb/l5Be7xj0veLS1mYejb7/IELkGQUS8wDS0v0C3QgugTAr/8NIDpyyfOGkG4HlFdSaUvQt8VEe9uFQMDM+qosmzh649G5ME2bj5TYTU3jmTPDdv27M/H2T24zb06lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=L6cViECS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="L6cViECS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so1067457a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1784195177; x=1784799977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KTxkaZPHUXOJmJBzLSBM+27rd0POVSJE0Fpas4J7vAQ=;
        b=L6cViECSmyGEaWsbZQNXFOQ3cErfZtQGeow/R/n5cKPpg6Ggp6dz9gkPKzLq9dZiU1
         Lpw5YilP4ASXTUnZglymBmI6OLQkfYK6lRWxoug2TO4sLJFHyj8gyDJCGqdulFbK5EQa
         M/T16pl7M2jyS5hr4doIMPuPam4Xmv2CiF3QHbOtIU5ZZuLs0/eMCXNHfLWdaVgP6+Qe
         xFzHj7fubuy5wr6/+x4kWnAUBQnQYpW6eiNktifwTkMnIXyIxcUF7GHa1oiE76CtfOlg
         9pVEFduOFocY81D3UidfVH8MlGuK7b+tmkbX+CAW5106k38ZXhGq8eY8aXUcVJnj9vtE
         jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784195177; x=1784799977;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTxkaZPHUXOJmJBzLSBM+27rd0POVSJE0Fpas4J7vAQ=;
        b=f/T2wT2pdJV4CT0tFGp7/jy/xwb6170TLljEtC7Le/D5NyMZXPJxi5IM+kOeeHZ+JV
         t4J5bBzCXBiDP20b2pHQEc0QAJuaF0dzm+Vm4fyiwX42hBIrYkmHQFLh5B0I+QqWPUxA
         shIO+jfmpSvXpqsX4iIJ1f9NWj9Pz8zFy6jdeMy9ap4geOCsjrm5eUqT9PFTxaNS1tWw
         4Q27YNl4jCWK6tWZM4C8Kmj041mS6e/1u0K5Ydl8cRnLhgYUGEo2VFT/CS38niCyqfAm
         QcDuFlGntZ0Mde+W54uGqDMRnPcPf2YaNbjeCbdOGHoksrk85F3gUkj8uhYX3ZEZU05V
         xXsg==
X-Forwarded-Encrypted: i=1; AHgh+RrI7nK/IyKBiRIhrvSqCGf+LavoqQ9rmYDH0Cv120KL+dLeRaAOUC6AWDxeBe1SyEI376dCfQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ujaDIJJoBe4w3BuYzBsECY2rX4MNBPyG/e6yyxMfXXf5I7c4
	B0LziL3aBtxE3bgaydwj4n6DofFW+ofdtLYQcH3Xp4A1Fxznyn6rDsyZXVNWU0A0cUg=
X-Gm-Gg: AfdE7clmEm6GapuRnSQuc5laZPJJXrjGAXd3RPLdphSaQvfmkAntsJlLlseqK8gKFTL
	PEww8rUc3O+acnjG4DqHnwRXX7JCRtE67GvFUcWg1PibcwqGP14FmEoXBpPuqw7tczcVBTcWMjf
	cmHxo2f0chhhM1BS89TUGsSwxJKjQJ1/+w/O0zzIugmHLWr5ZtdF/BvvTK/aPl7OfdMzx51v1Wc
	NcY72l61n1+zHoVqKZfW6P2TaYjakw1KZYbnNICCrBU9qlLI0F6CVQAPvo15U8kU6tyLC9TtOPF
	cs9lILt6+kFso4+2N6+EB/PN+5CJEfI9eZJQdLe7EVRjRbSAFlroL6VIL7XDuVtEcnDRDd04kc4
	+j7qxnCKZPpSqV3cuq6PKPohWcnzu+ZqjmORPtK1vOVb9nizwmPHM4eepn8WwMSwfXlh1z91qgU
	voCIbnAuBskLJ2gwjuAb2q88I56RoFr+RplAtdarUTwBhzOIAgRygZPCM=
X-Received: by 2002:a17:907:3e21:b0:c16:1290:11a7 with SMTP id a640c23a62f3a-c161e923432mr637290166b.1.1784195177041;
        Thu, 16 Jul 2026 02:46:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871262casm175544166b.6.2026.07.16.02.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:46:16 -0700 (PDT)
Message-ID: <b517ef0e-d499-47e2-aac6-1950c5946e55@6wind.com>
Date: Thu, 16 Jul 2026 11:46:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/2] selftests: seg6: add test for post-encap SID
 route lookup
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Justin Iurman <justin.iurman@6wind.com>,
 Anthony Doeraene <anthony.doeraene@uclouvain.be>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels@cisco.com>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260711162907.6521-1-andrea.mayer@uniroma2.it>
 <20260711162907.6521-3-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260711162907.6521-3-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 11/07/2026 à 18:29, Andrea Mayer a écrit :
> Add a selftest for the SEG6_IPTUNNEL_TABLE attribute, which selects the FIB
> table for the post-encap SID route lookup. This looks up the route for the
> first SID, the outer destination of the encapsulated packet.
> 
> Two routers provide L3 VPN services over an IPv6 underlay. Each router uses
> a separate VRF per tenant, with default blackhole routes (IPv4 and IPv6)
> that drop unmatched traffic. Tenant traffic is encapsulated, then
> decapsulated with an End.DT46.
> The encap routes are installed in the tenant VRF, but the routes that match
> the first SIDs live in a separate underlay table (500). The "lookup 500"
> attribute points the lookup there rather than to the VRF.
> 
> The test covers both the input path, where forwarded host traffic triggers
> encapsulation, and the output path, where a router originates traffic from
> its own loopback inside a VRF.
> With the "lookup" attribute, traffic reaches its destination on both paths.
> Without it, on the input path the lookup stays in the VRF and hits the
> blackhole, and on the output path it falls through to the main table, which
> has no matching route.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
