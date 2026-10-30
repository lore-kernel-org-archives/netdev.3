Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380098;
	b=fGtlbndW3lO0Y7f5bPcMQNjvGJUfhZsaIRPP5FNlldX85O+Zo1JSR2nNjjlO24WvTs+q
	 3ag4KbPg3tKVo58q1UPH4IFMBccI25jzsSXms6/XQMfDU2HmvePsfPdt7fy9KlY31lZ9o
	 eHlwcTGDuo2H/SqYTV6jJACD7WfRBTzTiDO73iJZoqEo1jMi3kTf48Nbw5XgdI4WWNbD+
	 lYYIbqEQvk5jvNJ4JiJGWWQHIzPKRXSpepwfMgqS9qw/8esdo17QXmA6OYK9kVl/OlhHj
	 fZx3HbTctxHeBLAQmpDhz1jJAaGadTnTZIs0kzli26aJCassfB9oPOHVQNUXY3rzF4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UJQFo6lBsRxUZVqaTAfTugCYtH9lDVXLbR2YaM1dQaQ=;
	b=XjXWByTs99gF5fJaGtiUwtotNIDdU/+PQzGCcyeILadYtwSUux+ML6sP/XIOt7pTzFBX
	 k42ln+TDRrYAh+K/8PJxkbx1an1gg3jy1uRRy+4iqtyfJ0aBfedo8skDsMOscMhvnkNZj
	 CCiwjy8l3nWxfilHTl5ITbxzRAV3hmikItKw8a+poFeCrrqpD6Q3MLWBtYS8O6trTNd/k
	 D7vnwTPzhr372Ztmk7UzbYDBN9v42+xt/iRwfy/0XGfgVbwLpRxr9I/CFvF62qFNZbCHG
	 960n6glCLZ6h0GLJMO9pZRrqxRgxyIjq9kxSnwxZpB4nHgJFV9ewUnA2Xxb2Edsn6Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtFuYrJH;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEA606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9DEA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtFuYrJH
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-99061e2171cso244248241.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380097; x=1793984897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UJQFo6lBsRxUZVqaTAfTugCYtH9lDVXLbR2YaM1dQaQ=;
        b=PtFuYrJHVVjxsD3+QnaSsedFWNS4nLWLqgvQv9apD0CYg5eNqRuNk6eZI0jdSZ6Q8/
         SBwnmkPqnWIk//ri5tKsgwcIul7GOTra7xsgHbKxGtHZZ1hxyVA38OX9DMfgbypyckWj
         2g68t60m9Mg4vbUOrIyMhhks2iiLLoNgOaadCYN/QGP6Q7p5jK0Mf2mxgu2eyD/S3SjR
         pcF/3efkDIquTT4hk1qE/3q9Hts+Gic2hBNKmagf47naDwa5XKie4fsfnogh80rCo71W
         6lcflru1iV7jjyM/TKK/ITzoZTgmQUugv/sRQYeidVrpm6ger3hXQYcP3e1Wmp2emTZh
         DDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380097; x=1793984897;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UJQFo6lBsRxUZVqaTAfTugCYtH9lDVXLbR2YaM1dQaQ=;
        b=lBc0+TqDnMrOBQw7KzuoAv5lOTFhrBYYi4JuzYVEltx3a5pHvh5xErShB7d/5M1KRj
         jelmfIXSoqgKOoGZe5bBRdsR80TEge0WA2wAmXs3RT8FoyEIzH3vMU/nyRMFkaiEVBCO
         bgWgG7A/hg4pJEXs9BUD/GwUfb5xDE1ZFlwFbZnIU/1FS8Bp2CmiJVI7VK4Xbi04cutF
         FSSkjOnKMWOyBNjZWavDuWRrOVkJEz37xKQ3K4eJax3Hy4wFj2oo2p94PtJN6c4Jt3cm
         Y2MW139HNv5+K9kQDmGqfv/VZANrfCl+i+QgEYwKCRN9LcHFpet9vlUo/MRgii7YqMY+
         akzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9E0ilw7Ao20wpreBYg2QcI0CD2rejokfmm1SXY3mh0lSpY2DDzbgLF31vUe5qOPtcX3gSivE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOsm+Esz5Pq7iRK6nItOo8LjLzkqWwYJ9wqlyAVmAHQ0d7jGvU
	rkG2xeXvTtkNHX2Hv6QNP53iaX1JnF9zNz+2wj/2mcpD51Hc6J6+dlVl
X-Gm-Gg: AYBFou2R2IUykv5LcKEVkYl6jppTR5Gia+G36ymG2VLyaBM8ifVxfJKJqZ+4ZR/ROd7
	p9ieBKeaApDRm9yKDwooPCOOCuS7ZWirHflKOIXa+m/JoZ9abnGHWfcG1JpOK6dZx+4KjXX67Hz
	VSf9N3th3BnbaRJa0S1/8EX2J7rHne15dSEgH8pKV6gutS2UH59O/K42QWrVDKq2DHuEl+TY9v+
	cJIzimZLhEyj1ChXVwM4nvbLDqGznUSfspTumWE9pNK3CxUA42tnoloCI1+D0I9moag+DzQ13wz
	zzk7FSRUogFB4pNYSsnG02l5EyfynZy9UuxmdKmJQHHbQz8PGp+C/VRCfb7pxTbUCR3dCqFhpTj
	XJUaIP+VAGwA3Dv9FOp2GQ91PWBKQ7c+OwR3dJdebpTFDqje2c5YLMLXQ+LPgC4SiKZH8ruYlwB
	ncDsEQI+3soWFboG5ERj+pYn8sKyyuXsjoVbWWbeZUb+UnhLC3YzshP9p6nRXdHlPD7+yal07px
	0EvCNcnYv75lGTts/+5+zmxATcXRnP9hNvcnOyHqGP+QAgIW1y+2uq+PCN7Ee/Lq2KrT7DakLBR
	kCp1/LoQBB2OABWcM+DtyT9Ar7FENY8a5gYUrqg61dFRbyteqUJrvXFFm1v36MTinf/3GCkURtP
	DMFHHCjbQl3Z3ycqasAyzxvmp3B7x5AX4YzuGaFdbY98VAvf1CHcaOsgYGPGqXnGk4cko
X-Received: by 2002:a05:6102:50a5:b0:7cc:25bc:3b20 with SMTP id ada2fe7eead31-7d072bb35d2mr1407630137.7.1793380096890;
        Fri, 30 Oct 2026 10:08:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee3a066esm3190273241.5.2026.10.30.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:08:16 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:08:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ea2182d344a4@gmail.com>
In-Reply-To: <CAASqGyYfFwZizof-O+Bn3_H85sEFytVr9GapOVQsW9miVa+Zsg@mail.gmail.com>
References: <20261030100504.23498-1-ahmadag1001@gmail.com>
 <willemdebruijn.kernel.2e53c121ad9ea@gmail.com>
 <CAASqGyYfFwZizof-O+Bn3_H85sEFytVr9GapOVQsW9miVa+Zsg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/packet: account user-triggered allocations to
 memcg
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

Ahmad AG wrote:
> Thanks. I will send a v3 to net-next, without the Fixes and stable
> tags, keeping the allocations that scale with user input (ring
> buffers, fanout array, membership entries) and leaving the small
> fixed-size per-socket ones such as the rollover state alone. I will
> add __GFP_NOWARN to the vmalloc fallback.

Just be careful that net-next is closed.

It makes sense to send this to net, just probably not stable
material.
