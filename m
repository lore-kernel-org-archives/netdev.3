Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728457;
	b=fbGPVaeDH7Ci7DGoD3MacWkTnj+AclBGio58PnNLjwb5IC/YMPH3Vq9BCsbFVgXPTqxQ
	 ykTWYzqPjmlkvkgt+iWg7w7G6ZW0+6haQ9vb8n3UHRV8fkVgqCjCnjji7imVJmiF2h/Y5
	 eefWkVKNPLhJzoprHAJMJT6h5QMrNZkLxYXk2UVPejzpPvHN3nnhk9iyIHe7CRmBTYuiy
	 Gb2B/4WKB5cgedYSWYgQRLFbs3MMmLsaWj0PWw9Rm0YSRZsHex5RL3soqdyGqMy0jm7fT
	 sulwKJkauOonMqThV7oEPkHDHBQvqQ0YO5nQAGMclxdS9cWxY+s236lymhJY+9cHkiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=85wjufSf+6sVt0aWaqOMowwqAb9EC24ZQGUWyBhLDRM=;
	b=MIfchrzFptSSSvMWTpNPfl6Jpr0LmPDPLFeLxZh4gKPcvEmqNEOWMk0NDRU7wa0pS06i
	 eqQqjzqLSe4P4uoJ6L+hp3pygnzxUm/CtaM7ufqFHYjPqoZ7sh8tWNVanNuR6dyR8nQWA
	 flkCX08U3AYGBjJyrUQ93t0UeJU2cdY2ws2vnhz5h1FV+DaZ2VSK+cLuLavm2nR0nMzaa
	 X26CHrIA6v/XEEJVx/GP/1ZhCRpTuUHIVOkmxnNl2WXBJDNDGLl/JT/tYSKHRrBJ7Q12U
	 iGYA0XXgDpA/weyO0sHbKq/su96PZMq0ZM/rtZMqwxtFSzKviq4TUSaTHQQ3vKnsTPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=EqvEIbDt;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4526606A33D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4526606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=EqvEIbDt
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a78ec32fadso10197175e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1793728455; x=1794333255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=85wjufSf+6sVt0aWaqOMowwqAb9EC24ZQGUWyBhLDRM=;
        b=EqvEIbDtoaLkmh0g0ZZRkF68+My/5IiSsJOZRHN58fGqhvIEXf3L0HfCEWkFhhvCY4
         mHNp9oZekCSqzVzUXrsMEh3mGAGMbKf63lESjAXLnI2PXZq2nSNqrc36Hohy1MQoUYI5
         R7c+3JHFf0iwwKu5Cv7DsonVoY21BJtXQlCBGIv0MOi+H6XFJlIPLvL00NgbkpmB1CS2
         LVeek2Rxu2rb832KPwICZS1nLParVhhUrTLeX7q+bOroHDJeUU8+7YBn7QzjV6soJbSK
         9bkddTzwd6yuenriuKsLkrZuEqd05giHXja8KKHZCUb7FPq/5CAUBKXHOpzVHPPDD+V7
         VQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728455; x=1794333255;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=85wjufSf+6sVt0aWaqOMowwqAb9EC24ZQGUWyBhLDRM=;
        b=ZZ1rjne7X4HT6skyfl2BTZ48i0rPfap7bSqDFXuWV/KbbukVJUHAG0Df3fFCFlISQ1
         Z9881NyXxwfwgeisTHpqVYWeU/01I+cKfwdYbyb+4WU8kzVF2z96QhwTBeRCFhjMLzcl
         uItpmgEV2VCeBupaMTz28sJBHyXSIZ3VuR1S+4ZM4ZpO/Ku7Qan1LDI3HhOieG/IFcFd
         HSSFLGupc75S6ntchyYhIa9KCKOhC9e2duhxLThpan2QdfGglhf/FIgPWnvOKc4N/nem
         DH+ocoJPE/C+mxaob9hX1HybUfYA9LKWkO0ixH41+SppyOfRSz8+MELq8+BKcrmvFbHB
         J43g==
X-Forwarded-Encrypted: i=1; AKwUvBz5C7yn7eaiZvemeqpwKFqJUfcmsD9CUthTL5gfXo3GqCjlUotvIV9SxFBZPTK6nCQuqWWuFYc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwuV3LM39VYEaYm5AGgTRAJk6HsEBs/AkmVeORj9GqfXdIrP6
	YZYY1FKiYFkw8YpUF7L1PVSz+u44M8nJYxafdakTUc1Dce29ohk41ZTHYflDMVgMN74=
X-Gm-Gg: AYBFou0Lf/+RsyQkwq2ZMdPaiJAU88Ruwklrj9KaZXmz87NrIZ6nxmRN9L2dp6gynr4
	T1h00OPm/EyctYNN7R+QJ9aiTkCMJjQseRKy7KmxXJWz2xfpQpDHfoZjuoeUMj0RB1dZ5g53iob
	nCvs6RXV0XUSZNfaJ104K9lfQzps+/w/TnZOvc3xRa6W1LbT837Kq31Q6gWg3/3Fh3jwKISvlQw
	1qHOtNZbsmxUTRvg0tW/8nmrLaiECL/Jyccvi4jZTAAwavZ9/1IcTHVlYDm39bpRHyovILFHBP2
	WS3PY9rRjDF8jg2TQSbUTwuf9PZ8I8yfJRJqleNry1DTW3rQ4P8+tURvuL3xM5v0XPxqXSQu751
	eChlG72MwCcH4YP+0oZMElLDw7JJnGBqZSZgNl1nz71GZIiXvX2gFqaw1O8XIVzBa+6gSMR/xlH
	+60VS5boJT/qiiU1LADIXBMQvp7igLjCyCbVx/U+W2KssoIkaMfBtwqnNuBAh3k2S7Ko4+sq1T5
	4Qd556XtBYx0zWSUe8bqcbiuXdUAQquRrR7iVLA3D9w0K4uzVjAMyCQBGCPQ5GFvoGXGmP9LnpP
	BlbD+WTbUefxMfisTX9uUKyoof0AlrOJgr2Xn4wMfV4P1g==
X-Received: by 2002:a05:600c:2604:b0:4a1:b027:99ef with SMTP id 5b1f17b1804b1-4ac16acfa8emr236694595e9.2.1793728455034;
        Tue, 03 Nov 2026 09:54:15 -0800 (PST)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9bd5d2fsm67727415e9.14.2026.11.03.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:54:14 -0800 (PST)
Message-ID: <a62aabdc-aa69-4ee1-bf91-606539c6637e@6wind.com>
Date: Tue, 3 Nov 2026 18:54:14 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v4 1/2] genetlink: Reject joining multicast groups no
 family owns
To: Anil Kaushik <anilkaushikwireless@gmail.com>, netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Florian Westphal <fw@strlen.de>,
 Mat Martineau <martineau@kernel.org>,
 XingWang Xiang <v3rdant.xiang@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 linux-kernel@vger.kernel.org
References: <179372164269.488856.17448970060747076034@kernel.org>
 <20261103161254.56922-1-anilkaushikwireless@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261103161254.56922-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/11/2026 à 17:12, Anil Kaushik a écrit :
> Yes, this is a behaviour change, and I missed it in the commit message.
> A bind() mask with an unowned ID now fails with -ENOENT and joins
> nothing. I don't know of a program that does this.
> 
> Ido, Nicolas, is this OK to keep, or should bind() skip unowned IDs?
> I can send a new version if needed.
It's ok for me, but if a regression occurs, a fix will be needed.
I let others speak.

Nicolas
