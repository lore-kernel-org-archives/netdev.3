Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363084;
	b=0HqeCkIvENJKZDLtM5id539ltCCx0SMDocjRGTFujAMfA2hpJpPRAX29wNdK9hEqlhuO
	 VjpPYfuxxCqkv5vXuiULafaqE5K2kQ3iqwc01nkiaRIPopstb19Vn1nwRCPnz/OQ4YCF0
	 DQO+fxfNvC4yJz1Qqiwcqmmx6JZIn2NlJvA9OHV/S5CfiBpq1RvEBU+C1FSiH+2Wl5+M0
	 bT2/0fp27a6IpY9lkQmlwJv1TeijHqXtEzxsbxDZZHymciuYxCHr9Ja78iyGvulJBbZ5M
	 ErE2/cE6MSCtI2S7imZIxoS0iEKUkYvpuOETGWKJWxuu6du9p2Odr9cDvCarhmc7KaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
	b=YoTpiOXwq4touGCJ6dPy2dZ7C8r7IjgcmKS6Gf9NeaJ4d0Sld9Vm93MkEjSPROMWV/1G
	 VJOYk5E6GNRnYax5XLzGPJsma26drZRTmFzvi/j7mhocDbchUBZkSjkMwwMysi83lszhh
	 STq9vMImfqWjmnIhV4Mpm5F6uUA5Bdx1vfEKNxtxXsMGV29OsP2aNXdy2NSThVz1R96iN
	 //GUx0guzO13pk/Ozxr3ni6Hh/H3ld1JAKpyTNntflC+11TSNgSM3iAuumXFr66xXlR5Y
	 tMsp3bCFZwkWVP1csZdPQCr93bf/kbTLw8/HQRZ+PssQgenAG6ZkfLK+MISOAW+lutw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C9606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961C9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so340821a12.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363083; x=1793967883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=kDl7HVvKhavC8dBhxopELEbRq96LLaI6slGnuyyzzpW6HiVfGW+5iNPWoH9zW/heUE
         w8JVowdf9BDkIaRkb7XkvY6hKwgR0yzPfsDWcGZ/TEK3ir2aGz2DFMTmEl5ZhJjIRj65
         IaYA3vc9JbhxAqMO4AE7rw37++O1oUWN3Nmqcedd8UaAiPLTaFv3cdQA9uxOBqo02BDu
         ss3CrAEcE9GJBCtpgMGVvQtPYxRYHv/K46Bxi/obXBWgOIplzdfvA+5nCQS18C+R5zJo
         1LWEf+wYAQtEBy64hU04DLZ9zd58muabV/fqQF+M8lsvlA7BwXW74bgmo1u6xwlDDvrO
         Yo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363083; x=1793967883;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=LIvGF3R+aHbzqbgbR8r2YoRVTK6NNbskiF4Mem9lVtwCxzXvDf6Ia71p9WTs5CkCQg
         VH378jbBT3QoCctVUJq04adoviQhqJHVYRaxMG9YrRsh3GK7gooLdKIMc0JXYTLLroXL
         R0yek/uxuoSuCdSAB7qTu1PsjqPw4vBEQFJdxwy4e1c1dEEVoaFUVWwmWBgKqLr66DAw
         PR+6JMlSC7gDvvCTDjMDzD7vDgqSGoVRSFyUcsM6Hef4PK4erD8VxAX2fvET8J8OlMIX
         vkdgfajzuJ5uCgGmogmKfsDPZwhThclnyHoM533T82U4GO6InUOZwhfdUxH2JC2a4eJ5
         oyYw==
X-Forwarded-Encrypted: i=1; AKwUvBzkw72WVSxCLrK4LsG6Au+zRKnVm3dMEUzBa/Idm0EIwOB6bRhfSvkaS70CG4HXB8QfMrNXheM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLc7sL9cY3BHIScKWUgEEUDsFrEKpaVsUXJd10i+seGwjR3RAe0
	DlcPJN1amMdD42S/Khk8moVcwbZfrzzDYKlf/S0LOIgF4KblzMZuWWHG
X-Gm-Gg: AYBFou3y0NZCon1KoRZuFJ3JtTtNu0X6Kf990GWKt4qb9c6+YpPNe1VPpLgpV0drDw2
	PRt0fHYmHxovi9dAn7ospvOQ1gBM5CSUwyDJTomy8ggsfYz0xdBJO7tOJmiMfAX2H1n8nVPAkTS
	qCS8jGyaWu+QmwMUO7RqlVR6odwVURQ7iheeUZbQsmIBSpShX4FhaEcql+KlXqqDeieSP68He5J
	ihbAEieIZLctxN4mkQnQOi+mqjN2IBSrMBcTTOvKdBLbZHid0wX3FknzYM+XxU2MuK9mRAhPfY0
	Rf3uuVjyAiyDWoFBuslcDOaMV0rETxfyovWq2RRJtAiZgyuW6zZmWkwu9GO8nsVFmG4ssa9Nv5Y
	b7ggvy0MgDg1scogDQ89tGG5VQsLFaioH1Gy2Sb48uT3CVV/7loKjeLK6mkV46BludjzP+HwtHw
	bRo/V+RGffQZUN8CwrRSx7R0MUrbzOti9oWL5U8J7ZABURGfYidrHEw9fROrNivPC6quMuuJcj0
	iGlU+s6HBAQmEQiTDMsncZyrJ4wfVZuT2Dg7S66BBjxs5Yp0L8iRZNoJ7y8NMzD7OKNoXVD2sw+
	iOgZZ4er1hxOAFtWaOdeU1h3wRH+UxaxpZQ/nOW5fhAMcj/BcqX7Mt98mg==
X-Received: by 2002:a05:6a00:2d85:b0:873:f7a4:433f with SMTP id d2e1a72fcca58-8a9bea6ad35mr1985118b3a.26.1793363082777;
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ef56b38dsm687929b3a.31.2026.10.30.05.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	netdev@vger.kernel.org,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 20:24:34 +0800
Message-Id: <20261030122434.91530-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com> <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review, the suggestions, and the Reviewed-by on 2/2.

> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?

Sorry, I'll reply inline from now on.

> I don't think v5 is necessary. And as Jason said you received 3 review/ack
> tags and none of them got included in v4.

You're right. v4 went out before Jason's tag arrived, and I missed the
other two tags from v3. Since you don't think v5 is necessary, I won't
send one; if there is another revision, I'll carry all the tags.

I learned a lot from this patch and from the review feedback. I'll be more
careful with future patches and wait longer for reviewers' feedback before
sending the next version.
