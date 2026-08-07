Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633D39BFF2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086477; cv=none; b=KXgsFgfeg36FuyUS5lK4E9YnFgRhBoOhD6xe/7FbrbZ8N8aoQ4Wf/LBz/F/BuF4N2SLl/ZqelY/HPAuYArc2HPKLiSpcB1uLGRDwXi7RHmo6v71Crt0fdO8Z494YwV6dF3+IAsLqGowHAifx/82OYZ7ga/pIOJ8bDYBqPINJ8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086477; c=relaxed/simple;
	bh=4JFfyud0ViTeW+K0tLZ1hg5DaeVAY0NyBjvL2WbsxTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlDzKoCfJI0UlAC5HKHVQB7yLXEk7np0YCWbgb0WxqDHsESZuyrp1WVy4KvzkAlfdezcWsazZUgS4ZGij4ZnhIfJf9lIRjGY0HB0AjIYe1Ejh2hhuP9pl0P6ENzGlZWc7KNb+FzCX8CDg2HFWKaKGEooeW4hvGxAasAXVYKOaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LfqITn2G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LfqITn2G"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so6545265e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1786086474; x=1786691274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QMsmR/uX9VDEyf5PzjWtsFu058wtvxYUxRMxUh1B8Co=;
        b=LfqITn2GauWayY8eGWRQ1SBomypMt8kUVJZcl5hvClzuvr7h9EK6QogvYTclUQm9+U
         xCttY/rzyvnjJCLp52QIRCqvaqxD2Igq2byD49nwroSMQ4nVy4oVGGBai5uCc8rrqtXi
         rTg0BvEiX676XMjoCogoCaXMV48am88sG4bLdHtkLyi9lLnJ4X3Nr/vEAAfxSmTwnuDM
         Eg7cuqYglCu8O5vyLzA4nDqiYyU83/5lSkwIfI/zrERG5hUrzcX62+XFHDToEztj5wP+
         GIe/IVogeGTcVn8h5E/ats1g2zy0INWL5JFvjPRCXy4j2q9+yGoXjL5ztUw7RRAFc9gV
         6DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786086474; x=1786691274;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QMsmR/uX9VDEyf5PzjWtsFu058wtvxYUxRMxUh1B8Co=;
        b=lI7v1SmMZyRa6ws3SwTz9/TOlKJ3kT0QC5czVLnI47ruszlFBM5wpoYJS98fmUWHsr
         pguyhN9f6oQPA0hKGam3b+MvWWq8iYz1mRDbePnTrC4azZkZq/UXVGT4TK/ryUH1E6fI
         8MbFeq9FJZk+56uSGd7hH/VX9mX0fOnx3HrV8188Vl1/+fhg/6p6jzHuhXU0JSGhkzv1
         ajRnRI5RsjeH8n6Y13qDjXBiJ/RdcOMQc7VjlBtcaNCvaqlBjMaCAclci4oiojiS8XnS
         QtRG9EtuqVGzFe1vFnyOLiDqTd/OLmNZ5zIRjPkpCDqG36jVCgs8ay6754IK3w04kZM1
         frgQ==
X-Gm-Message-State: AOJu0YwQhQ3PrrmHcrPxntzPlH/8EB+N7Z4ujFl93iVefcgJM+G+VlJs
	4cBVK6a0PPiKiBtjRXlMW1LTP154MMDdDFHTNF4ZCd6XMh84ZjL1fgPQfJ3NwM7QPJ3LlHd2mo6
	xkZgblz73C6S5DFT2XUxgijQcnHavgFJufFktQGJtp5FN3rYcXMY=
X-Gm-Gg: AR+sD10vsKXG3QysDIr1S+MNC/6wYSNOC0uExmWIyFeTka7cwm8V8y5QPGaGqFGcVTQ
	zVt4VHXlBium4GHMve2usp1sxJ9Z5mFDvHo9XRjK/dSC/QaiphTNLC5AOv0Xg+SZOkX6dgskU9z
	/9TAw60BSOKvrd6VagsXwc1P5C6rAecN0V43EQfuzrjlhuut8LoWStsYsZ4KzU3xP1+Y0IEzWJQ
	pUEiaKxCqxlknoH9mmN1i+fH6WoTsl7nSkNZXAFAFQhW58mbybdZpw8g5nrnHyY7hqNQ71TgJUI
	DOyrB4qkUMuGhglOW5oLNap8t1x+cegvV4LX2wHoxDpbHwecRzNyMA3Zg3mbAA99fzvH4JiFHjD
	2OJIcpiGJvDF8VcM6mkWYRnJQQCAwW2HvnI/CWO18tOZrclQtX/0+LSdFjhZcF6chkIWncrqhYF
	SRbOgBfpTxbQQMY/Uh/yS99gqitwsqZFIDbDPeKst6srWflH8xQvFLw0iOYS1sMNgpOlPo
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr258910355e9.6.1786086474389;
        Fri, 07 Aug 2026 00:07:54 -0700 (PDT)
Received: from [192.168.182.19] ([185.242.181.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995428f294sm121706305e9.15.2026.08.07.00.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 00:07:53 -0700 (PDT)
Message-ID: <9f20537c-a737-4bf0-b9b7-d2ce57c5fe11@openvpn.net>
Date: Fri, 7 Aug 2026 09:07:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/net: ovpn: fix socket leak in ovpn_socket()
 error paths
To: Qingshuang Fu <fffsqian@163.com>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20260807064816.53811-1-fffsqian@163.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <20260807064816.53811-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

On 07/08/2026 08:48, Qingshuang Fu wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 
> The ovpn_socket() function creates a socket but fails to close it on
> several error paths, leading to a file descriptor leak:
> 
> 1. When the address family is neither AF_INET nor AF_INET6, the socket
>     is leaked in the switch default case.
> 2. When setsockopt() for SO_REUSEADDR, SO_REUSEPORT, or SO_MARK fails,
>     the socket is leaked.
> 3. When setsockopt() for IPV6_V6ONLY fails, the socket is leaked.
> 
> The existing err_socket label already handles closing the socket for
> the bind() failure path. Fix all other error paths to use goto
> err_socket instead of returning directly, ensuring the socket is
> properly closed on every error path.
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")

We'd rather send changes like this to net-next, so no Fixes tag required.

> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>

This said, we already have a patch reworking this part of the selftest 
with, which is also addressing this issue:

https://patchwork.openvpn.net/project/ovpn/patch/20260512144358.419599-4-a@unstable.cc/

It is pending to be sent to net-next as soon as we're finished with the 
fixes in our pipe.

Thanks for your contribution in any case!


Regards,



-- 
Antonio Quartulli
OpenVPN Inc.

