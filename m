Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5B19D065
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890572; cv=none; b=QYZ6btDRJzDWeTqx4lSO92Otv6O2OIpn2L2QhnZrScO7hGve1VVlin1qcHGaNoU7NcNmy6DCFY93DfqwH8BANx9IQUc6lSy9fGh+1uV1CKivLElc/vpNQyXqwVJG7TLtrlXX8iNm9XIvTsplXSFNi4shouGueb3o70iw1E4CMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890572; c=relaxed/simple;
	bh=3HKyt0/avKJqDKspF7mQQQiOHaDy0n6cMSqyJYCJytU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnKxK2KzQ56NG97GdNwMkZBmW1VpVNf6DPMJzueuIkkno9khuZYwPAiWmo9n9wzIg8PSbSey7sB5XkIY/+dbeTD765hPE3wsnVrs8Kapr+FCNVti3LwUoV2vEDWP8o16fz9EjLu1KD+fei+RJ74qrQG7KYrwYn2quTKoyXfXWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=D3WWyg41; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="D3WWyg41"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47db714766aso897296f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1785890569; x=1786495369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jcN1OU5C+vKnqL0nTVuYxbLwNyiFgLFC9+Hi0KzyTK8=;
        b=D3WWyg41r1OBCAA+g13+5z+kibfhPbUwRZQnF9o2vqxI83P8zSPP+QoI4X1WibbuCg
         efkewWindU1xIm0mYOebHLttJ1kynmlcETnAbvbvnVXYR43xTZ1ZBIYGbcDcKUsE//b0
         JdAy9/9o9yB0i+LNXyhRhCkd2a5MN/0hpXb0ovR65P58KiVIPSjcMAiJJwrZyncXN3P+
         lU43tkXZsOeYQ9v1j70TmkPo64VHfmaleOgPyerwMhubHc9PQfDv2gRve91v1fFNpY+P
         sy8w7UxeVniuKvyeMYwoo87m+dAQzScHvxU2hKgeMz8Fe5qVkcGdo/lXgYiqfxamnVdS
         LTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890569; x=1786495369;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jcN1OU5C+vKnqL0nTVuYxbLwNyiFgLFC9+Hi0KzyTK8=;
        b=fnrmass4RH6Sf2yCvIkpxZjwCcTv2KkWzjWr5RFDIq63n1cX1nI7U397pMTd5ZOA9X
         a6PUJ8VoUEQyD0zp7VuSgRXHDBr1GV7L7tdSQ0lKAMbydkbzUJCVEkKqMgK8htOALT54
         Ja82C2sL1aENTVOZyJMJ/JvwLITO30xEs/8Phz8wuJqz3y91Yi+aaF5BIkkAN73jkMfP
         v2nuKWiUlykpyJ9143n+hcqTrLTTcsfcW2x5QAHvWG/7B6W7rhKpllQ+F9Ud/pTGqJBU
         soKEsppLHOZ/n4L4sb2KMMrQpyTh5iwr9P3ZpQIX+nOu3GoUzYsjw1J2jc/Dv71kXMRg
         TR9Q==
X-Gm-Message-State: AOJu0YykoxrYTd8RKOAZGPAVBTBp4s49z5jLCHFhnhLrrg4wPip590Tm
	YIzugdEzXtqGuu/Zmz3tanULQManMToqy0p/4eYwZ0cstzZmy6+M+HjxOYHoKuO0APY9YTUhTrh
	xlRUOw8syRBKII8cxyX40NRALlzdMYT6MBRE4OrlXnVqxEsMIN6I=
X-Gm-Gg: AR+sD12CB2t/GmHE0ibo6rnEm9HnL6bJksN07rCh8Ec6GHDp1u4V+hQKkUQo0TdGa2c
	olWHx9GZnKHJh/p6FeCxLONTi+MWdiQYZ8OFtoUM0fg/ZQc0CA87gBB2c7cCCI/G+o9x3WR/beX
	wJZFTdP+H7EBq3ZL1xmI7b3rrk5vBc8DC6laAsLmDaasHg7Qs/BTdvXT4cZXFoDnoF7FW2YQnDp
	OFzxCE33PW+pHWa6qOZT7ASr7cdKK4/Oz6HR5BQzXiaM6OIy1yH0ZDfI4OipmpDbz4/WihxYbxm
	7p36Ykm1ystvpgxBGfJBpSx1tAXp0kHtt4OkNzwpK+P3A7goxGs3fwvrxB3KhWvHspFPGWSPCh6
	yNqIGoDT3lEoRegvVzs/7gWSEKx9vsYl+rkzCPuzCknTIE0QjEkib3rb4FY1K1jR8ScQIgAttya
	trhJUO0k9geWSs2C1sZpgUN3//TOSZwT9OzRgO7XoVMT3XqApUz1hvn+ecc+MBlVId0rE2ViaZw
	LvP0leHqmfyAiv86fbNnX6j1b0=
X-Received: by 2002:a05:6000:401f:b0:47f:e746:dcab with SMTP id ffacd0b85a97d-47fec519522mr4472326f8f.10.1785890569143;
        Tue, 04 Aug 2026 17:42:49 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9c62:a7f9:be29:e1f1? ([2001:67c:2fbc:1:9c62:a7f9:be29:e1f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5c0asm4008363f8f.13.2026.08.04.17.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 17:42:48 -0700 (PDT)
Message-ID: <9218ddb4-8d56-4223-bc6c-169870c5e6d0@openvpn.net>
Date: Wed, 5 Aug 2026 02:42:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/10] pull request: fixes for ovpn 2026-07-30
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Ralf Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260730094624.4102963-1-antonio@openvpn.net>
 <20260804173215.3434f385@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260804173215.3434f385@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/08/2026 02:32, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 11:46:11 +0200 Antonio Quartulli wrote:
>> There are still larger fixes in our queue, so please ignore any
>> "previous issue" Sashiko may report on these.
> 
> FWIW we're getting close to the final rc so please be judicious going
> forward and try to queue "never worked, not a security issue,
> doesn't crash" to net-next without fixes tag if such bugs come up.

Ok, will do! Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.

