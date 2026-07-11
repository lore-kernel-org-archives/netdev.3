Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F125B0B8
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755548; cv=none; b=fVA/vm3ogb8FTq1oxkIL6AqtDOG7S+akmL/ehfefroQasdJkO2vvfDGHvxd0fz+jR/AtwJN42ArRDJ9TpeHfJSTIz7dU7j6jihS6aYIzZlE1njvV2mlf22yek6C1SXDnWHromscsD5rJns7ZFRN6BU9Me6lgbVS0hPh0fggtpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755548; c=relaxed/simple;
	bh=be+u06AdYrQNudktwkV4S6TmLYRJkKzVLJTnqQZnM5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyqDA/vLyFUlDj+6BsweYVqkinCLj6bMDFQUN5GbEYO4xs0CJfGZsPoxhpSY8E8WBbgGWdb/5Yt0iI8+eT2nfNw0SArV7RUL1qsaOqcyyh56mGXacubkwjSopM1Piwwum+PiiBylFXxCkT5EFqUZtFNUzApJOdGm1koDa/nTNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=YfED+KZN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="YfED+KZN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f75f7172so6967265e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783755545; x=1784360345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be+u06AdYrQNudktwkV4S6TmLYRJkKzVLJTnqQZnM5s=;
        b=YfED+KZNcRhgGwEpC1SpVy0KkDbVaRM4tSTfLLduFpqDpW+2dtSSLF+/cBvJIzV4Fy
         6ed7haX/CEa/3vNIyJ0pQ63Hmt5tWl8TW6nKN8SKnq+I7SqMD04TwrQstyVlHOLFeebK
         iMwmi+uii0Mhg/KqmTYV5fLVZZOwxwHcHuCajYvMkbvuPyzdoRqMZGufkNO2WczrlnGT
         X2mJStqn5XjHvxM3vM9DNjZXI3t7jagM4PTDv007x3Mw5XfzKUGbNQwWG8MN+YNPySj5
         smubc3wpgGgEWKL7+JgWhbB2at5tQT0nrIYkAYTSfKOVm8J1PS7omZFnPaW+IX1/Ezr9
         2eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783755545; x=1784360345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=be+u06AdYrQNudktwkV4S6TmLYRJkKzVLJTnqQZnM5s=;
        b=bfAWrWEvw6T8CLCkkmVAe9fAPYZ13TbdZLKRJ2NG/0JGq97Gs6SZF+x5LixdpLV5AZ
         JugCI0pB/SjtT0LSemX02kws6q69Q+iuu3vwttn3Z7jSOTbIMy6S/bCUATq/4JfAxSNm
         d60j/3KP+YBcKtnWFZbnHhQ1H7Z9G4atmUTd+tSXjQZSgfwh0oAulWEHg7ToqLZKL9LD
         hYPWc2t6RCTg7arYPAacbxKwwAPPZbk7iX95H/f/0kFCUr5xO28zDiirt0sXYOy4iOOG
         j22EyUrE9eugOhp2j2eE6Z7oahV8/xTv+MXaL1T+UoPPLeEkj2xNL9+tMJAh845ALChH
         bQsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDGfdSqryKeTqOapDZZeseQES60eHEvm1BhW6/OgFJ2oxXDbPxALg0nI8EMpycNL8NAM6k+nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cZz1bjh7R8IdY5sH25UeVvu1xlg4pXeUn53x94F0UH4/EFox
	RNF6Mh6AoEwdM9wu/ftQCVznwi6XryIrZCKpc2ygmVS2xArRi2ptSMZC+QLVQA4WhHEF
X-Gm-Gg: AfdE7clUcyDsINN0R3JMrwcy6qB2rD/GR+UN4MRujk6sNwMYm82QIRAr2xZ/J9cP+Dn
	T4K8uXXDAnBlJpJTbiaMrj9+iqLzYIKpB8d4vjBFqLsCps2EFoZnrhOMMRPA58kMGc7EUl0sTVd
	o8hv4L1LTlDG+QjbnGj+3MrsPxPl4ouWBbE/3zUlWwSUv1NK4sJRQdhS529d4pOFFKJBBPzTy7r
	Dzq5x9e/ezVGYuyz5PwpvZc4vSx7ylGAs3+2rOqwz/XO1t2j2noz5HCBfkkBWCD0cNUHaBEKqfg
	bI2VT1Vy9owonCUz8bXLis97CkUDLj5eR9+rJK6nEIJmNpgZerlCJBM6B/j2UXtqGlNKBONgVoe
	xEUc8vCSeUIhqecjl3Fiqqd5EsxuIEiqBkWlDXa/LVAMROeG+EeTHLZaMVOVFXsjSRPnTMyw2FN
	WKkPwBOE8vcLxpgQMB/KTznQYXmGv0xnwCyQ4/b20eEecmtIX5Ef2yIAmw3K8tQYHsThIx5ppKO
	7ML4gkAiYb6IgvzifMjqH2Dka16prcz7WE=
X-Received: by 2002:a05:600c:4e90:b0:493:9b02:484c with SMTP id 5b1f17b1804b1-493f8826b9emr15373425e9.29.1783755545138;
        Sat, 11 Jul 2026 00:39:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm61374217f8f.31.2026.07.11.00.39.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:39:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: guard against short PDUs in nfc_llcp_rx_skb()
Date: Sat, 11 Jul 2026 09:39:03 +0200
Message-ID: <20260711073903.73366-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711073012.71066-1-doruk@0sec.ai>
References: <20260711073012.71066-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Sorry, two copies of this went out by mistake. Please take the earlier
"reject PDUs shorter than the LLCP header" and disregard the
near-identical "guard against short PDUs in nfc_llcp_rx_skb()" that
followed. Same one-line fix.

Doruk
