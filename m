Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C5490C0B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353005; cv=none; b=O/ZrYCieilVsaWp6sWenSpbteMvewGcQ084LjulyL1Q7ojpRY9qvasO44ySENzgGTFDJPMN/dgnh5IOpL/82+5q0+WeIHDwTqWILGQXwfUT5z62wkeNBrAhT0XI9zt6HuKDi7NzZl5j8P+uKS5fhY0cK0uJvVswZEziyjfXvIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353005; c=relaxed/simple;
	bh=ZJITWgkUYiW1v7E9D6GmTVjfH9KmNTQjqvmyZGZkDiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaoaEh2rwU6wWqYUoviZr4xybhQ+DClEo37hyBmhlgBjQIucQrWt6QYwL7QibYhd46VKJwDgJ/lMGOzPGOfZVKcQUxObEQ33guXkIAMn0/dk2JozUjjjtf7Sii5LK5LVE7m/djD+cHGE6mVHekR6pks56jSvibIZc8H4Zi40soM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXPC4GWq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXPC4GWq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2533d83e3bso137754766b.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788353002; x=1788957802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJITWgkUYiW1v7E9D6GmTVjfH9KmNTQjqvmyZGZkDiY=;
        b=eXPC4GWqz/Kw1fZxDHdlSg8T0asqPGvuvYJHA5MO0oAza/KDgQfOrtaqWt5qNONpD6
         u2z7Q0qjTkwod2SAooxzY4hoavod6HZYHgQAAgoHfWnc6pCyQ386062uiaVgbUJqbniL
         m+Gp7o8MLz88lOXRVmP+tyllwhpxuLdiBnHR8gt0EYKUaq6NuLOHYKooIGMYFW3f3s5J
         7NFxhhvC/fc+C4dWeTVzxX2t+9Vrae82eWQ5M1wBdu3wL4RoJYo9yAB3iRlbKDH1C90p
         IaWmQYE8RkXk9LNa0mzntkEoBdVBHc//zx90Y9dPTfXwdrF42N4AVnRTqC4B1a4E/r6y
         vI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353002; x=1788957802;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJITWgkUYiW1v7E9D6GmTVjfH9KmNTQjqvmyZGZkDiY=;
        b=S59S4R9Tj8CUiM90ZwXogcbwGC2AKKb+uWFYtykjWOKUe9gQsyrH5zlTJk0WNxEMWI
         AkDdFneo1X972411gg+1mUpuDNZ0qXT4NKYMzOfufN+w5odlwnpePO72evlh/dJTJ4Nm
         TDB1WsYfw/fCeWt7O4so2SZs3n2F2wrJ09lLgxQut1KhmENZ8ZDM+xGt0M9LGQM0++eT
         iaA+J7DM5s0ccA8g/yngwXSuvEHcJMQAwZ12YVwRluQ/qgpJq+7PbaEydhiCxZKJhJN8
         L/9T7Q5IPPo2ZtxNwXesRiWPrp5tHTn7XCMmg2WsKqmV6/luQArxCO9wt9UmeNcOUGT6
         HU4A==
X-Forwarded-Encrypted: i=1; AKwUvBxk7GXcq8kdOm2+2Xiq8QGKYi2EKmsMwFxbP3+KZPngQoQEB5xtYn2ln8OkzPxgAxcSps2K6tU=@vger.kernel.org
X-Gm-Message-State: AFuF++kZvhI0Td22Hm7E9HBQpS8eomdu2TAbluv658fkNPp3oBP11XcI
	TUo93p9K57e/+9OFOs0foTQKVJYD4YaeCnBqf9L4mCSXMz3dYp0esFHM
X-Gm-Gg: AYBFou1tYkazkSzS80pqWS2YRmxz9NCp0O8LeNcSz5I/46AyCMGdpUphWYguXLJgGIj
	CvTa6TKhM1JIoOibUYTw/t6Ul9mBS7tKlqtomgC5XfHL47hye6y/qwE9wypcth1iTiIuaszJuCP
	ldjfe+FfXzYsYf3YsaRI0581ZuHpMDPQnsQEwp2tZqs4meIfa+o84SUBzcsbAeOUi8dROi4BY8s
	IPwBt74aqMhhRsPaUSp3S1wWxYOvKt9G3ety9bUMgMo80vuL2RG7NLpFOA7Ttn3mAhZBeh66VqU
	5oSeyGIXPG/0UyDD5ZKq1mfcwVB84Ojr+DCrL5wgo1iBoauIeKIA0wBz7Qs3zSE//SXDoHYd68f
	9tpdIloMCnNx5fYfDETGVhh1d/v96AddSSywHwD2NNfIB4773CDifbQvGv9FApv7nAD5gKXI8qS
	hMEWuwRSi1tm2rhmDbqAxdZfrEJCwJ91oJ7rzK6jZyKRXZR7vcsaJw26fUIhOlUvJY0HSvVJPRu
	f4+af9dkp2ZKJgQLw==
X-Received: by 2002:a17:907:d21:b0:c12:b2db:873d with SMTP id a640c23a62f3a-c25d526e682mr232505566b.5.1788353001758;
        Wed, 02 Sep 2026 05:43:21 -0700 (PDT)
Received: from [192.168.1.124] (78-3-72-185.adsl.net.t-com.hr. [78.3.72.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc5cc3sm127621666b.7.2026.09.02.05.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:43:21 -0700 (PDT)
Message-ID: <5636553c-4c2d-4fcf-916d-0f334ddaf401@gmail.com>
Date: Wed, 2 Sep 2026 14:43:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: wwan: qcom_bam_dmux: account network packets
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831181006.1382372-1-sinyavin@gmail.com>
 <CAFEp6-1Ne2SmyGGLBMMtiXtXXmzEySX0ZgzijNn4-QtN+KFhmw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Sinyavin <sinyavin@gmail.com>
In-Reply-To: <CAFEp6-1Ne2SmyGGLBMMtiXtXXmzEySX0ZgzijNn4-QtN+KFhmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

01.09.2026 10:08, Loic Poulain wrote:
> Looks good to me. Since you're touching the statistics accounting, it
> would also make sense to update the drop statistics, for example by
> incrementing the TX drop counter in the xmit drop path.

Fair enough! I'm adding the drop counter increment in v3. Thanks for the
review!

Best regards,
Dmitry

