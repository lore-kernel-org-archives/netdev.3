Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278036;
	b=fAwR8sMzC6y67CXVxtPL8X0PSwr9bYsiDrQxrjdN/qPX8m/m3rukaqxOyDP0qlqqbEz5
	 t3soeiMZdL19DW2CT+fu3MNikxCimatSe419ASfvDRtTCmPwQcE70qUSN687nbANmdtin
	 pPycVAU0YSIciXpaxzovqTtPxv/25GSMW89dxbJzWtwt1DmZAIK4GT20wbr4WLjxEhRwR
	 IMnmRkX4LDzQ81gZ/KSO16VQCcmOAdyORbQ7OyJNPCEW0yboOtBRUhYFv/QglLUjTxXjp
	 hDOs5/EtAjl92LYSmHa/kv0tcodFXIFj3l+qqP2zWsueFL3G0AWw2gX3Ct8VEErjFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
	b=mvYzCuA8RE1+Pt6IcjJ5+kd5t6Yw8C2IXveYO44F4ohGUBBaaYahigqQ4hoaUJcQma5L
	 ZfMwCGq8HS6olmgLbJoOFCnqTJU2jyw2wCHQq/EERhvKML6M4ovIdoR3uZeWmQYXwi77Z
	 MCYgyG8pqbtgZA82ZFoWta6g9uIC3unsASxUnjtAIKGDuXefPpxEmT9NS7SMRRUEvyF9J
	 yVs7XjwHQ6rT1aZIihut0vGjiNI4bIOjPS+/atZKrsmD/fdndibUd30roQEdk0IRW/jy3
	 orkSUps7e4aO9U/w/oW9ZY1Wa7Upa3tYOBQQaPW/v5mm6O4Zv7OtPx9Yahv/xIXA+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G1obDVAS;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FA606A334
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 928FA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G1obDVAS
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so525168137.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278035; x=1794882835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
        b=G1obDVASqefxB6poYdjSmxCFHjae9eYxJSNGGnlEYlbaEUEJivW7JDtmuGERQcgQmN
         jLQt9g2DSx1yyia37PP/ykKwYVfjHoNMpAsBsWcx1xnqRLrrH9i6dHgRXVgwLRphQ3mg
         Y6aMvkPKSa0PJn/FT/cPJaxDossiDDXv6D6d/28oQy6ndp/q9nQBiOQYer/iTR21B9JE
         Xr+gk/exekmfyJoJTVs6SVqVjtObZYwFB8IzkdhjCRTYi9wYeI0qdVL1DDvdM8XQyPki
         oglumqrNc6J2a2pRN8Z7kaLNm6XEJZwSAv7/NPRMsrQ1PX8GwtTNfs5q91PjawEY7Mxj
         2T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278035; x=1794882835;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onDRaLguTUW2a83jMl1YZiAlaHNlpOxn5ahgZIssCS4=;
        b=cLtl0gJu10xcuFk1SJ1ACWuoV/49IKxDHc9jbNFQln5dovbNjTbDy5fiUp8My5BsN3
         OTqPZDC9itHoCKdeYKdvZHguZqEfITZhDCuImLkZV+dLX00A4cjobOihhIfmEhof8MVm
         PG7OF9CsFkt2Emkc5DJWslQpazMyuVNRfmsoyGFc3MiMs88yGCVDwKeUECg4Iq0wbmIn
         nIPY/6ZJSmWbe2QbDVDdZRVw0BUM2gk91qN5/3XIWtccbK8mFV43WT9MYO+oBkJOxgIb
         1Tj8wrWen+3TSPCHjjW2ADlOd0u9Q0h7UIfLuTynW52I1R8SYLbfEIJVMAC5MchjXtHX
         CCxg==
X-Forwarded-Encrypted: i=1; AL+hErGFUE9gHUjQGZmu/raAPNlGUoEXppz+RIqARfgG9edLsTAPsIRH2TKeU5oprTjX5a0A4xDMwZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G1h8Hi6I2LOGXB7Cwdys9VZVjkP4EUKWGjAzgQ94Dds/J/ytJ
	kB8QUfjpQlLVTAPd2N7efUcpDp0VLMz//yZMcUkfUr5GeZXkwMlBBoMm
X-Gm-Gg: AYBFou3K36OEytA44O9OzTSPmzTl6TtHaX4GHmscr1s8GqtbFnrcwV+ML/yBuY7TTO8
	bUCQ1WHwIZoRZh8UgpKycuNmDYeFZeEj059p+iBBp9nuG2TcP77A8VMURk4260q9yFMVWDDuK0r
	5ntJa0oPx/1p4Xo5Dc5l+OZpRy0jFqFs8p1DjGwWxCg7OLhxBdXZo5kIrT+woR/wPgZvGBFq4te
	fcS/ODOdx5sK30WMhI79nRWLgt3CbBwFEmuFFtT8wwk8mPxYca0GrSxrMM76y4ENwqPnDG3MID9
	DYnCzIofFWs4wNj9lRwNz0hEr3l5MxS3LAN3Zx8CvjsyT5MmatpXa1HFnIWazbiwRFzeT1jS3f1
	cA496M6Kjj+HT5R8giIz3W4zwUIcjU+Qai6AwWKqkGbsUwHZQt0Y05700tusZDlFzrHKo+dpAnz
	ba3v0y1XM74UsE5sgxDD4wV9JZQDhPCIhMBpyBLWkUqz3GY4rhyNmyWH2mxdqunPjVYx7Sv75ps
	XmKErkFjUNk8u+381ijQPXkfkL4dMU9mXM9eL8eTNRKfABvPoKB1t8/fnlreij4Wgignk36GBgu
	uyZ3zfN3wAERW1a8xWKPqQ7bEeL/I49kM+X+9NTkRXuRvu+bDWcukENQ8yPu0RvyI61E21n759n
	Ypeg8TY6+8GbNzvnbiwvpsM8QAcM0MkGCj/S6vdGnB3Dakwwfq+kqIkoFWSh0z5Ra2xFPONs=
X-Received: by 2002:a05:6102:2912:b0:7d2:7c63:5a0a with SMTP id ada2fe7eead31-7d301bcae2cmr373574137.23.1794278035436;
        Mon, 09 Nov 2026 18:33:55 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm877564137.6.2026.11.09.18.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:33:54 -0800 (PST)
Date: Mon, 09 Nov 2026 21:33:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 tpluszz77@gmail.com
Message-ID: <willemdebruijn.kernel.136b3b685931d@gmail.com>
In-Reply-To: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v3 1/2] ipv6: fix cached route reuse for control
 messages
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> A connected IPv6 UDP or ping socket can reuse its cached route when an
> SO_MARK cmsg requests another mark. A packet can then bypass a prohibit
> rule instead of failing with EACCES.
> 
> ip6_sk_dst_lookup_flow() reads the cache even when connected is false.
> UDP clears connected after parsing IP or socket control messages. Ping
> always passes false.
> 
> Only read the cache when connected is true. Ordinary connected UDP
> sends keep using the cache. Ping sends do a fresh lookup.
> 
> Found during code review of IPv6 UDP route caching. On UML, the same
> connected-socket selftest fails four IPv6 cases before the fix and
> passes all 54 with it.
> 
> Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1e0038bcc3ef8@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
