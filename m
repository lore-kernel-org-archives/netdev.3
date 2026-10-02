Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAD50E587
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971801; cv=none; b=E/eInfYjL4SYOaQ1PNk5xmEdajz5/5ebZkZ/T9Q5nlEc94LqxZW6t2FYAqcpyvaMYcPeuaAZ9FWwUc7/HjBl1QAlwsw1Hq1lZQ24vjK5pbWtrXMwdTQtdMgpXUtZ4dRJL7CFgEVZcNg4uMkdBYt1hvk48AzVRw2ACs0ZxioPddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971801; c=relaxed/simple;
	bh=2ZoneoGqU2qJkQJrPepOGNSoLBxn+BW6f35Nep/3Z9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzoIA8rQDIY6poJUk6IEp2Sc5aci7VQfTCrpDLnLxzA9mYNraEw910qaw9drYxaoMMRxVE1ltNg10SnUGlTOxzoaQaHkbZVqp+TpxIH6+h6Hn8oPozBQZB55V+tmQzQeomkv5FKCYD7HJd/KjSArdIrdRxebR5cWyZyv3qvCPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HV0sR57l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HV0sR57l"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso307171f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790971798; x=1791576598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+Kr/lLJxct0J1aKY/42Si+6OLzpHQvzuru0OHbvg74=;
        b=HV0sR57l6kuL6JKWS5jRlXdpaB8w6UEQwXeyON138WjHMZmlIANJxdVWX7To7eBkG0
         Py6PgyrgK/ojTInAnpykkLtgnwGyCXWJPOrVV57FS2V1j9nudUMPCdcPxCUM686jGN6W
         2kpIxOMIhPQxtlPn/Aho79igdx/2lADZqaTXCU68wdicnGaw2FuMXMMFU9vuF2dvk/9E
         NPhe945QTX+/CRPJmDGSMFlck+3EY4YMhUQ40ZiY69HR5Ymr1hbjqCBZ941e1IHO07zX
         RIpA6fvHfNAvzRZxwH6LvSdwpIq0bjZaosKvXsP/7eGNv7BX4R4wDI9/S+VCiSy+h8WK
         kgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971798; x=1791576598;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+Kr/lLJxct0J1aKY/42Si+6OLzpHQvzuru0OHbvg74=;
        b=f6l5NIJjzVnznzikX6kxPzoMr6EqI4J0HDL1B4luJkSTApzTrid7GXLGdaHOl0Ryy2
         nd8W4QvCZl1sqlOntirdsLP7h7U6xb6SRXP/2iz+kZ407XZLmsdD/r7DNX9D75Z/ZL3M
         7f5YG0xRDYql9PUXxcW1XaD+cd/Ma87mVkDSFtV2Khb+NvOB0Ynb6IwFT4ILI5GalDs8
         9Fk+VPuZ4lRmjXIJIdKIbWEFETcj/8HvRgVt+7DrwujpRbZ2oNTTR+VwYWPPKj+t7ij3
         nIpIJEMfJPPTL7EqZvyXf6haBTJcgtkvrivMvks68xT/tS1tCfmdQws378kZvu5YY2Qz
         pZUw==
X-Gm-Message-State: AFq9FYL1A3pU8j/A7hdMJPBOOeSxGXMC7DPXQ6KVPirXhNz41VPxPhmd
	7z97loTdAircFZxG3CLu5qJrS6yZg6HecCXqzjfiBkHd/Ih3Z1181pUZ+pxGz+QqjfQ=
X-Gm-Gg: AYBFou14Nd6DyTNF+mnrxcRbGO4qqLMPgVHbRlmjwNRF3M+TvxHHZpa4p6hUPJO/g/p
	rDqh6gP7ukgvleuD2snNBag1Os9JnY4i4tr+qpacPcmMd++d+2k0jXW6qPiX7XRy4NhU6IIi4JB
	0tJBOoUGnJnN38DdY9oI1asTkpxTQeCwNU5zVlyzxX/IEFHumtqyNh0NO5AVf8V1S1gEV7HkodK
	2iqPNs1GD6Px/uoPxbnzBjOiZUmYJQtibOKEEr5HFBCaj3pnee/uH7XhzMoIktsDBciZiB5mKv+
	N3n8dWkx1DLMpA/pmlZZ9F/qnMcmb8FVQJiU6Lt9SxmMiW7w9yjqp2ZZ9p6usM9u8vXAIdxw4AR
	ehbjX+WZKHOu7N4wnxEIHtlmCo+vd59DvxnvneIaSfNpGtjZGt/H8eP138XS5a1B2AekWWavMhN
	xPoH4+zHiD0eZXETa6U7Qtsi8r1SLYU7zZIW+SdP9pbPYvONSm/vReaknChGgJN/N0zCqnovObJ
	P1EcMxj6QY3g2Lb8dayjYFw2iQu
X-Received: by 2002:a05:6000:2384:b0:487:197a:5c1f with SMTP id ffacd0b85a97d-48c4800e2c2mr584926f8f.49.1790971797562;
        Fri, 02 Oct 2026 13:09:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253ae9sm6905080f8f.2.2026.10.02.13.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 13:09:57 -0700 (PDT)
Message-ID: <b41da7fb-0ef6-46c0-a174-cd7a7c4448ca@blackwall.org>
Date: Fri, 2 Oct 2026 23:09:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net: bridge: introduce a bridge
 destination type
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-2-razor@blackwall.org>
 <20261002124531.49e3eaa3@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261002124531.49e3eaa3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/2026 22:45, Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 10:14:00 +0300 Nikolay Aleksandrov wrote:
>> Add an opaque destination type and helpers for representing bridge port
>> destinations. Using a separate structure makes raw pointer assignments and
>> comparisons fail at build time while marking its value member __private
>> makes sparse warn about accesses that bypass the helpers.
> 
> First time I'm seeing the __private thing. FTR feels quite foreign to C.
> __bitwise works very nicely for the same thing 🤷️

I don't mind switching to __bitwise, no preference here. I saw __private initially
in the console code. It seems to be more restrictive (__bitwise allows direct member
copies and comparisons, __private warns about those), but if __bitwise is preferred
I can send a follow-up.

Cheers,
  Nik


