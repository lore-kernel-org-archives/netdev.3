Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145453;
	b=X/qnZpD5IlcBZxICAJDw8PY8kQBl0Bjpyrp6RmdZCyykZqlrRn0DftisL/48HjA5THnP
	 5MCCNanjBN94YUpT78c8CWzBz6A1LISRrkzio4f6a3O0EPAZ7jH0fO/JbnDlQeldkfM0C
	 eg+ZUlx7heeCJucn6wER3QlYRbh3k6ZNpCqw7u7B86RkJTQXLwXh99DCq2A+3WDbu7E77
	 mxF9HL8KFYUtBy/aOGEcrA99RHDmgM6AtsQVHR6OiGddfKUPz/V6eOMJ/pynO4dC+E5UY
	 Shk7FwkTg/yMy8m6YF1oAEL1rXd0Wbih4zb0Kmx5zRMk0qL6D1CcAokd03LjUxzEXpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=/slH5zszpOl1ltCk3nRrYIZgnTGPPYf7qmqiT7WcwHw=;
	b=iS4JdfcXqj2fIm0ePGEj2P40o6T39Nt9SXGU+PZzIgKePzMYlQw+3kibC+RcIibgQrdb
	 +FcyvJI01eG5vTFQvQerM/G9Mb9kgllL9NNJU2+fdYdE7JPEbQb2xuEKVrrshvpcrP+av
	 Ghht7hljbzySMekcNj5M/sIktXmwO0Wi6dnuM/79ujd8Ufrv3d64j/T3C8+gzJu/tuqVW
	 8QuqayqCKzMKbRGtg7SIBUQ7mBEQf9VDXQD0D08TfOb0Blrx0jLqXahssYlBEvJaBqpnS
	 qXoh1kioiAA/1mC810K/rZ/C9qSrYi3+R4QNyduvorL3x0PaPyQLdoyUwh94cKMvCsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORRSqMQq;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6B606A334
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 13:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD6B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORRSqMQq
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e09aa5264so45600f8f.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794145451; x=1794750251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/slH5zszpOl1ltCk3nRrYIZgnTGPPYf7qmqiT7WcwHw=;
        b=ORRSqMQqNfgqCsQYnbdE7d8rVcmkC8gNQ1IFFXS8fzBkUBPy0QS7Dmh85LN9MtxljM
         ALCMDhlA045XNENSNHLt3rdEGCsJ6HcrKHUtSmh5nIPf7XzVQTdF2pg1C4hE70/+r0te
         GLANXbP7Rb2gQzC3Mqx73OQJwH7vYKQo56wFoop6RsG5JcAKniSnUlbwj4LW3/3DqsJt
         2AqLKyekxR6t4zq5sfq9ZBdtFjfXdiZqOCs/KU+L3Ss/i/z80CLRlqVubSqCTmqtyfVL
         A5vliMEFBnV/4yxotplFqXjMZStbzAqwJDo/r3IY9FQUgjpzlIBA2zG7vZX2n/yUbYq2
         Wf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145451; x=1794750251;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/slH5zszpOl1ltCk3nRrYIZgnTGPPYf7qmqiT7WcwHw=;
        b=gLMzOnCdxZWiNAdGDAqOpjPUHNrQ5yGOpn3I9YYluv8lhnF7I1SLyymdXCOrd5D91o
         a1hLiJeP9DZAhT80PshKGFkvf7OGDbSpYyJty6LMKkRY+Br9WJaJ0VSWQaWeLfXZ98Qv
         VBy6V8i28EEiofpdUHQyWCClj/vnsoNop/Gk8/nlP9mNrpATxonS17n6zXlnj8t4QNsH
         Pe+Jakh7YqW5kKVQlVG0kRfNUPjuP/mMvzVVmnZA3xWH+y24gbNd7rGqZRCD1lVci62V
         IZiffd4EhW6NarhFeIpm7srGakD49gO8lMjVzYq3o/I+vZyWHIWSLoAYFNFGVZjZOck6
         36KQ==
X-Gm-Message-State: APuU4Z86z/GoF6ZSujtFcv8wpxr1NGyBpor+1dgufgC0tkQ7XkTJS0FF
	DzqSiS1PDd56XkAGBGZ8jswvpfYG+3JutnFV4mpaa5vMZMjjVV98cZJX
X-Gm-Gg: AYBFou2NAfH/AHFrhBYE6vryTMNfDq0Rtdthzw0jdpMEMlm6e146XMYBGOkRMFGYcF2
	uZCqdsPb+2ghxQlJCc6JaHfvY5NSRdhQrgB+/iDquB+A9o8mHEtmw4F8e/rxfjU6b5VCgFgu9VK
	2DkueYC7szxtgNE37VcYAh7xS43KyJlqGWwsTXvEVcA3UNhvnTD6gVAKdVBcKMjOW6l76vtV29w
	xU1tOXD1O76utpbBdd6r5hcQ4ls0bJhuu+YUIT/fevLuZXvBgL+G2blQOPw3MRRosiKG2UT5BUV
	cz2ToFNGdqYbkTsyrZRJz80w4VHTW0HniKF7RdZrgmD/eQtk4R0NEj1qN7FHNCUo9JnyJD8s30K
	fcJwLubuERhhdiDXptiZuIO26EAbUMXLtEFZHjsa8QDnSHIpCXW3o313NCUyuAhyQpR/mXS8Get
	wfwU9dP0TNLx8JZWUWyEhQYnDiKMImEHYYXJeDUQqo/sX9h++aHo2v53i89SdQ7hCPeUrTdDS1y
	ycCIIgCl1ythorT4wjMn+mHKImn+xyTdRVXCP9uP4VLm4ntAqM5OlOzc7kAgin2WkDyzrgPXmV1
	QB5wcvXdWZy5NaiqHjuBA8m86ZOhaGprwQgBhgtYbxDY5q+c9BLWNF5kUQ7UtkBHjHSAOrCWeXM
	UbnMcv6tJ8z4oTKIaMToz15dEvVdXiqAojHoy4/6q/J3RvMtSncK7+tcVDqWN98OlzQ==
X-Received: by 2002:a05:6000:98b:b0:48d:f3a4:a6aa with SMTP id ffacd0b85a97d-49583b08d97mr2802498f8f.35.1794145451153;
        Sun, 08 Nov 2026 05:44:11 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596509892sm4331729f8f.15.2026.11.08.05.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 05:44:10 -0800 (PST)
Message-ID: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
Date: Sun, 8 Nov 2026 14:44:10 +0100
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
Content-Language: en-US
To: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] sysfs: facilitate creating an empty directory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We have use cases where an empty sysfs directory is created.
This requires an attribute list consisting of only the sentinal entry.
It takes only to modify one check to enable creating an empty directory
with a NULL attribute list. Use the new feature in net sysfs.

Proposal: Apply through netdev tree, w/ ACK from sysfs core.

Heiner Kallweit (2):
  sysfs: facilitate creating an empty directory
  net sysfs: simplify creating empty wireless directory

 fs/sysfs/group.c     | 7 ++++---
 net/core/net-sysfs.c | 5 -----
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.56.0

