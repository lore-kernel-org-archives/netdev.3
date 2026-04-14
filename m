Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894F3002CF
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133555; cv=none; b=JPWlQQ3qWZa6jxCIN1Lh7QgOIZ2Bdcn39vSU1xkVerT5shorwjU5gzvGSHTlmvYGa+FjxfyZf/UOJHnNcqv/2GW5Yh8eg7BMHOdI64TnrspU2W7x1RPFJtB9YT7wz8VSejU+uQYEPflc3vKvc+fhGG5z3sq2m/Z2W70CZKdQZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133555; c=relaxed/simple;
	bh=Nb6dlnaBR62FVntg1awxTp6qB7CjfQosFt1n9R6w7ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFFKFjIz6me8FY1bc4SbRGvnezE+bpR6AZeU0RzWMABUryc60ho+ROp13YeWnnu1/0ivdJwCoC/lsKgHLHCKL9W6Q1zWWr4nnrQKalg7EG5imk87yLvrPGh6KODVxS19Xf1CpOo3e/51rMxRW/JVwJurBnr79FzS4dJg4qXufRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkwD/a/x; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkwD/a/x"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c080efc1eso3028773c88.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 19:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776133552; x=1776738352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2og3lPRuY7BF01eb05UDzYnpEPANiac+EmpKCBoV978=;
        b=dkwD/a/xnrwq14XlgToQadAMW0ifFjvcOfwaskJZqowDXevkM5O7y7LeB94AXuH4RR
         hjxH2tgPuS6lVFz7atNm3uFVdga7784fdPaKzoEuOEgDLisoMzSvfOKAZx1pYLrc6hkX
         r/5eS7xw7L8uGZvV/9JVq24my7rFBW0TofnUToQ5B19x/fwDR2tQCWZy59hZmMwoHMiT
         pxv/CwgZTV+T6zBtic4VVCCt0nNg0UzpiV8rchfCqDnqyk5BwBnxuSK084rWRQSGdTAG
         Z/j7UWIvz3qGG31lBfQIpoY/BKjyf6zZ95c+mlMiM1Qg4uOgKjDO1YJcUPp97qWL6dBL
         Mgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776133552; x=1776738352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2og3lPRuY7BF01eb05UDzYnpEPANiac+EmpKCBoV978=;
        b=DTBgUtXMzHK1Hji6OfHQBnuvaOOpe+GxOluXG5qF1rKbt4VQEDXLBizR6soJ5GsJOI
         WXmN0wru10lkujqWvhS/smS+jB6MifHVr6YWTw0gmxnE/QmtgeqCdd+7TPT/OQk+DclH
         j0UdM+XqqXAUrq3k20RBp5xVf04am8xXsOWhCrtTPDPje6E7OhpgIOwSleNb3TmIuznx
         cFYrssmKYgK5R4I9htIb8Dvh7YMLxkO0dU9eCToLyX6OtIYQ8CJQiSEbhD4AEQ+9IWS8
         A1SlE0q/l0LM2RALy4h3rdTFGWJCyq3qIFkADUUdIL6NIohM8UcSFpiQUBYWfyZm64CC
         2nAw==
X-Gm-Message-State: AOJu0YyRfDlo5Fj6RGKuUHHhk8PLqzwawjlaZ23KIrH0kosD5dGc2Gv7
	39hKyGw0YW8f2XoDGAzNX4G2SIMICPZY4IUMhyqPugircH7OeriXkSPz
X-Gm-Gg: AeBDietj5do3yZ3C6ElaKEv1gYOfrq3awb6YCIjLtSYLHJk5WwAQtfHCrzmR7F94d/c
	yy6c1Emh1XY4KfrVGODm9dqQ0dEY1EkEJQBufAz7LscyvynsJIoGu1SMkLMrNNIb7lIwwN6n5mk
	eIbZ1hlm6RY+Wcw9FUAIHb402sZmxoJlNyZchxzZFtCqY3gaziQ/44CgQK6r7xWuOiwKxMLh9tV
	bJ4P5Tgaoxzx7lD9pmnZTS5csKxMliLppb9My4Z3V1Ohz/Nd5wGgQ5g/D940yH3q86P7grRR62q
	IosSJ1c69EaYvG8WHzMKhq18quOU+xyq6KrlPI+nPlIdx6ajPDbO663XBh5pqJe0hmYE2pQvdiI
	vYnv+UnmMj3WxBDff05YAPJ/TOUWtuxFwekQjVJMPxXefyIVdpZxTOyY+aBQRHH04x6Hr59yDdU
	Ni5NLN1aHfaUKS3S+g8lz0BAYjUlyqQaS6oEzUOI4JBpVGlmIIdFDZDIS7/nOPp0HXvoLTmuINl
	EVuZ3naDYWQOT8=
X-Received: by 2002:a05:7022:4a2:b0:123:3c24:b15 with SMTP id a92af1059eb24-12c28c31ef4mr7944375c88.19.1776133552174;
        Mon, 13 Apr 2026 19:25:52 -0700 (PDT)
Received: from [172.27.134.97] (35.sub-174-249-144.myvzw.com. [174.249.144.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb031sm15979260c88.13.2026.04.13.19.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 19:25:51 -0700 (PDT)
Message-ID: <32dafe85-d6bf-4f64-a9f7-124d0bd677d5@gmail.com>
Date: Mon, 13 Apr 2026 19:25:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: shaper: Reject zero weight in shaper config
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ast@fiberby.net, chuck.lever@oracle.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, matttbe@kernel.org,
 pabeni@redhat.com
References: <20260410225123.2341672-1-mohsin.bashr@gmail.com>
 <20260413145039.43f7b162@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260413145039.43f7b162@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/13/26 2:50 PM, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 15:51:23 -0700 Mohsin Bashir wrote:
>> A zero weight is meaningless for DWRR scheduling and can cause
>> starvation of the affected node. Add a min-value constraint to
>> the weight attribute in the net_shaper netlink spec so that zero
>> is rejected at the netlink policy level.
>>
>> Found while prototyping a new driver, existing drivers are not
>> affected.
> 
> AI review points out that if the netlink attr is not present core will
> leave the DWRR weight as 0 in the struct. I guess we need to think this
> thru a little more carefully. What should the "default" weight be?
> What if user specifies weights only for subset of leaves?
> 
> This part of the uAPI seems under-defined.
> 
> Maybe a better adjustment would be to make core set the weight to 1
> automatically if the user has not defined it? Only when sending it to
> the driver tho, because we'd still want it to not be reported back to
> user space. Not sure how hairy it'd get code-wise.

Interesting!!
Let me look at the big picture here and re-spin.
