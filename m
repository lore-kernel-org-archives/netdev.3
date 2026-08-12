Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1F36492A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497051; cv=pass; b=pAoMYnxKlbT/22/NK22sGBBjyeuCtJM06GyOJJqNfg1F0flOJsoSeH1tZku87AU9QwtY4vKqj5Hzm9SdsDiv+xp6gmqEOplrOQrKF1cwAxCPTVtV8pFYFqPo+NGn7LLzqEgxTEmZB5vOFAkpfoZJRAshhdINgAP8mDv9NxnDQ2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497051; c=relaxed/simple;
	bh=5t3RlIc3kEj4RmoONu8QAh7Ng832/Cl8+ScHBGHKlaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USPlm3HcrUrY4mZrwPI/I/djB7iHq1EAj0Jt4O33BqkpETmmmgSH+URaU70OyOwggbadyEbHUjnf5mSjazklRnNuhTCIBTA41FiPNpBIUvxAhn3Gjhczj283AtZn0m4ysxU676jcZIVLQk2cmRJr5M3uR3NhO4CbaQ77pVlntiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6/hjLdK; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6/hjLdK"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ee6b2da98so5662417b3.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786497049; cv=none;
        d=google.com; s=arc-20260327;
        b=NhR7U4CnRQ1TDFyeRso3PEV+jjRtwrAMig9lTrkGJ6RFSVR252MduAiw32MyGNx42C
         kp7YWalZNytc9m/W+LX001jnAqmvEboYOb7i8/tasxQmw77+AJSA3iTC6NRkeoJwEjPK
         8P5s1giKZkIGuSHuFJ2aFC4dhfMoLOAPnBq+do7/mTTAWMqf9lmOtsfEIEerSL2Vo5e4
         eGUmrfKEyvi7eIkkSyZ53KxkbaQPzKDIq7SyPcVCRXh8OObZktYkSZr4eLheYxRDQrIp
         2g0NQdnbFOCoA85sxIeQsYTF0sO5rx5CS0eNXz9pwpPPSNHotSGAdmdeoxRLhmrrti0z
         tg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ePxAQ1gF6Cdxv8dE9tKiquqdBA8YHy7R3qxF5nLM8Bs=;
        fh=Wx7viPwQH2W9S1xXRhg6hVkh63lE1rYUIIToSQ4/b7A=;
        b=GVrCerPAJGGItmRjD2GatB5mDLrR8pIIYYDuAXycd77iAgMe8BRlP4w40lrZ8xrnQH
         zHQ98AQJrmBQARX/8Jajv2crFhcq6YTm2oYq4KQIrLadVMKtKPGnpSfmorxAfGcdRFF6
         OSV8/jIQNd5AEL/NOeMw7yfUbu/6Ink1pOJTVJwq2Q/3u9i7i/lgDI5pIl5s6eF2lWe+
         XsoTfEjhRDDIefryh8RknbQhoVL9jAAJjZyG6brXWkHD9YRVYrcsWCXBKjv5Y+I0uOYV
         xYPyQPTAyYTWyGPHNozfuM4UcJpb974pQ69iSJNPUZuATyAbZRvZAQDJhkqANgcLxoun
         5sSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497049; x=1787101849; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ePxAQ1gF6Cdxv8dE9tKiquqdBA8YHy7R3qxF5nLM8Bs=;
        b=i6/hjLdKjPNAtLaQlKA3lChB9ziBannBtT6yj4eo1dY/zPiVQoS6c6RZ4hm9YM0mKh
         tecoacNhbX3vThbS7s4SZJIl9NSSdxRG6QPDOslu69S0KKZIz2c72pVHP7C+rlBvoYIB
         t1f9el55QURcYsS3r7sL/X9YksPyrXcNrp9JEqQv7Rd0SLBLmzxdM9Eajk9gXtqIOdHm
         R0AXoiV/TZWjYLZf7x7VgRHhLJMYH8t8i315JAWwec40HY5c27ZqbH6gsRBkErEgLUim
         zRJSjlu4sv7vD3n9HcWN1UaRt1Zjm9EB6FbABURgs1tQRaFG6wcecP6CI2eNji++vmRo
         c6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497049; x=1787101849;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ePxAQ1gF6Cdxv8dE9tKiquqdBA8YHy7R3qxF5nLM8Bs=;
        b=Eb8EQo+MAI9aSM/I5+feA3xHlFVdk6691ZmB3RDccI5LxAmEqWVqlo9gP/7C8DZPCc
         BeN8MANmODkXOb7ZzAyZUD1bovj3io28PR9SGpuBxsLRACYWc9X3BCzLijnku/E3LXUY
         MMAc0wEbXLonHsFM6AyuQG96t7AjhM25WPuwV/HVeMF6kMgelDD5XKZ2ZcHWmhaFDfJe
         3KviIai1mMNcEnqewd+o13ABN2QkCBLhuTCtf3ogHA1G2JeiSyaUbt3G8GAds2sfXiJi
         ajnmC54Crxgr5WIJF8Gic1GI+ysQeMZMXdx6tivPBUFVWvL8StGb6ZhwqgxqgU6CFUQ/
         N0ig==
X-Forwarded-Encrypted: i=1; AHgh+Rp1qvYOotAit4ezs9XK3NWmDFp7B+G/1+ZLL25jbRVJFc/kil6aiWKrmb8an2WHLS+jTXXsAcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvNx6wrhwUCLg5XkxQO+294UK10HWCT/zmXdCYQoENfqkwp3W
	9B5sLKjyuiY1x3C7UOeftWPX80k7N0SwR5ptExMsjUs6bBbZRhiFekC1oFjeRfXhaMgKnz2Y+r3
	Kugn94/KuSixVWzadPbq6TyarKtQPx88=
X-Gm-Gg: AR+sD12sV5HSAaIPf5MekEubIswiMhWAFPTPwniRUu2Mn7VAHk1ldAwM+Cxgjf249Z8
	Q3/QO/d+2siGOU5+Gx36RQbmKeRhvZX3lBwh9If8jfUHqGcBvjhO9cnnnAKB/TJdsAAJN83ODec
	sLBwn0PBOPOTGlfImdwYHKQ0WwSrH200FQbYNv09B8AAq6rknltliw7M4SEpzZZUtqCBgMbAjOM
	gCAxmvMBdBnnk26rwruBWJJdWNCYOFVDdPeiRwjZ7iaXafNaPIfMEizfNLD8LE5vG6v36LUuewc
	DaO96ZTML8nyNCjNrdeahLGzeOc9i+8gMjg54GGyCDfR8Q==
X-Received: by 2002:a05:690c:6e8a:b0:82d:aaf8:b263 with SMTP id
 00721157ae682-83105644946mr10914937b3.10.1786497048925; Tue, 11 Aug 2026
 18:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANE+tVpU7gL3ZJ9ro4oNKsqdN01mDMBpUou0ABakiO2WrT5gSw@mail.gmail.com>
 <antTASZYV9q81Ucc@chamomile>
In-Reply-To: <antTASZYV9q81Ucc@chamomile>
From: Wei Fang <void0red@gmail.com>
Date: Wed, 12 Aug 2026 09:10:38 +0800
X-Gm-Features: AUfX_mzNPWt8-9A5YfiRwXeRO2G3IDeBrCjSbnyHuFx6225wNASGATbNgDPNNeo
Message-ID: <CANE+tVq_U0dM7hXE3Vn5VVFR5iFD_JoSfQv0ZVn28RuepUy0cw@mail.gmail.com>
Subject: Re: [nf_tables] rbtree interval set: in one batch, re-adding element
 E0 makes deleting an unrelated interval E1 fail with -ENOENT
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	k.chen@smail.nju.edu.cn
Content-Type: text/plain; charset="UTF-8"

Hi,

Understood - thank you for the explanation.  I accept the
ordering point: the reproducer's delete message sent the END
element before the START element of its interval, which does not
follow the element ordering this interface relies on.

Thanks again for your time.

Best regards,
