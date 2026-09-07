Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDF40EB80
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764766; cv=pass; b=DWk6uWqOsIt+DTJOkRa6mI/DPGUGViLFKcnYA55AGG5/uf/QlUfrOFId8SwijuqsHD5bxpEfm6tFRakiC0lNGKBXMiHn0jmoF6bTaxOYfJVRP1OrXml8VNLZn0cxz1H91gHFhgpKERD7rqtop6y9gcxdDJGpoWyNbr2kEt7NiXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764766; c=relaxed/simple;
	bh=J/iKiNhcMgi580dPsKQsRdnOhMrWs8rCz30Zn7cW2ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdFmQELa46ObKddIZBj9FRqg9iddVXRl4gU9/aJALx+ZlRZsqLiFDlPzwDDVtXO9KiVE0xMg7cBKOdCdd3m3r7rl6p7nMc4aEfss5H/v5YrzQkM7iCcE74KeRJgYGSf8tZcj6d9GRzNtYEXSmOjpWLN5kew0Hubzcj9rWXEAtR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjsM4RUW; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjsM4RUW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90cc107c451so19965626d6.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764764; cv=none;
        d=google.com; s=arc-20260327;
        b=ROHdCztFM+XHkpdQpI0wzg0cT3QEmpJurrjyNdhmlWzg7rOZ3K8scO7gHz8KXsehJN
         meOdftXGaGHgE96pXN+WScdGQYdSi2jrbX77YYTkQp0ZRZkjkGOPpsFiFNwcHuut7+uc
         AVQy5wkwXFx7QntaRMuxEBKK5c+tEGWlxZkDPnVPrU3m7dXhYqLozoDxfbqF47SMn+rf
         0ChQmiDTsaQ6ENHafrvQ5JhyqHPGfCBb0X9fZVxkPYoI6OLE2IGpMm+Q1PFMyksu8utm
         VjiYjduiQasynloTcmMC0rWS+DiQPmoCDWVHe5buDxsTWKJsbQpDqRbvD7H/8BF4iVtc
         D0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        fh=wa9bt9K+wuBDNwY7UxXIElpST0Ywvzu8uVJrnmfhbpw=;
        b=gVvlWfZaMe679pAiD9P/AdWaJT6x4StXR7VCeBZz7ERYvya5SJ2hHj5EhcKGzzH7xL
         HXHyyuGMHCfkcAZXErrIVPBQIqRB9SVFXy6hQsKFkYk3EmK6Zcg2BloCKeE5rOo2ZvhS
         AmAmffkLeDqa4KM9gLaQcLMIWuH1CjnIaghVxxxGM66gMCAUSPc1MZy7cGKllsjc+OIg
         jF55n7YV58oWv9Xtnt+lsHHMSUsxLV7LbQIP7x1d8yYK73NU6SoHdUUOPcqGA8OeW4Ae
         lVzxAOwGqJ7VEDOb5dRd4/YSzxIdkJflERE4SHTOeQFCOcx1/mQYNZ/dROhIaARqFikl
         UiXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788764764; x=1789369564; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=qjsM4RUWobGJVYNVrJdBC+xv9h0Gj/EyzWmx8HLNwAfKy9xTEKUyn9Bdx6O961QFok
         GhR09b+UkVLUfHYKJcVykEAvbRYLP7SrCfFwjSU8eZ4oQ7b5gyLLM/PuVA3RCueovqr2
         ywD8lU6XpHcCoUy33Ew+uaqcIbxOG7m6/eEuWR6hRGUoX/Cgdcv///sSGgLd8QNXmRyE
         AOtzcqGdjKT9JIonnJ8AcRFOVXgunlUl7iV/nDTk8sSNB5Vr/UzQIW+ENU2i3XkwwbTi
         iYxeI4OnPd1ZXSDsQXNmeeGE6Cv1NgtdEhnuyKtPqKRbkEy66aRjqqv5GhvK+FYcB+rq
         n6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764764; x=1789369564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=eWyfLM4lE9VqO7DL1/BuMZFt0WbfVsMM3JaHgNXyLKFwzagmhRqot53+j9yPmCx1KP
         lsJfx2/T0nPoU8Ln248OyV+CWLPcmbVEDnQwghko6cXQCAiCTNoL9blTrlJToSEEcKJC
         w4WgHjRnzcdYskbxKvGrACyO6muTV3Tf11DWxhE8GBRgTZjMJiS5K4UzksGX9sTJSMGb
         slKFFD3sEM6wzhbQwqkB4STzfJlqXObOGnnrbNFfuxauMG5O6RJdRUH6faUJ3R/pCqcb
         mlEM2UJino7jTqqKkNn4VEAKqpI6yf57r/597eYbAfRC9dFOEWMtA0Dh/3beQ5yQoqDy
         oHNA==
X-Forwarded-Encrypted: i=1; AKwUvBwF7oMQvcZsypiT1/F4AXOwnNkxtlBWeX5/2Dc4yAxixokRRL79cB/PXXBLC3lmqwwuOfmryYo=@vger.kernel.org
X-Gm-Message-State: AFuF++nv308/AgtRgsXTHOBdXDK2hvnGIJPZk0vYDJXGXE9UDfl1uaLN
	zd1bJPFEkvNqKNuOMFcA1QTDfosILUuwU9Ziebm0Z93WYhTObU7SizzVQ33hXyu12PKw0HaUH1P
	2V+dSMNuUzC67/3b1QcEN7+LUNFbxMrTMLFN8/xzf
X-Gm-Gg: AYBFou09/QinCfkd6Pavs/zUtiiw5WRspOtNZyeMW7Vw7XJGEF20VdRveOb+MKASNq7
	KhH2HnMwsZcZrZQh88gnyJfaLTU7tS1uFDtD40RyaP5dIQKJ43Q3Wb+OmLN4ZVofOSY03wXeDUA
	iRdu5ykxxiYMr1uacRpmcFZxmOqoktUlFcmL9JN/UPFT9J5kEEe8U/Cg7t7IQZ7aRgskve8wOyo
	TLhLktH88/D2WCRlZAO3wFcK9/B4v7upLmPdBum3GUVjhKQsJRYaEV/VZoW1fzNnjQZ9jKXJj2m
	FMxB8aa7gj3F9vA+faJN5E5Vs1ezE6one5VfP7wzkCIsY2R7awrqE9OWyceQ3ttdywY1Qxv/B4r
	Fosox99SZsNmCRh645/nylKJDnfHA0NR4vb8frgy29uHyjFrqxPL9wbJEyw==
X-Received: by 2002:a05:620a:649c:b0:937:1b8d:e3da with SMTP id
 af79cd13be357-9398053955bmr2321525285a.42.1788764762921; Mon, 07 Sep 2026
 00:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
In-Reply-To: <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:05:51 +0200
X-Gm-Features: AcwNN1WeOqUEs6cInW9RchAY2pakJxhz5cPcUgFjFoO3v5x7dYx5vG4SQCc85dA
Message-ID: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

> - bind cursor UAF / dangling tb2: valid
> - unconditional sock_hold() on unpublished TIME_WAIT: valid
> - clearing s_num on cursor mismatch: valid
> - lockless cursor-membership checks: valid as a concern
> - commit message overstating bind/ehash fill-under-lock: valid
> - missing note that MPTCP needs the follow-up patch: valid as a
>   backport note
> - endless re-scan of the same bucket head: not valid as a
>   guaranteed livelock; duplicate output after a rejected cursor
>   is valid

I just saw your patch today. This is absolutely insane.

Please limit the complexity of a filter to something reasonable.
Absolutely no sane user is using a very complex filter.

Same for UDP.
