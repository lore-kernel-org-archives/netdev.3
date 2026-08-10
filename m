Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E598348C7D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343511; cv=none; b=Z/pMrx9KHuVF99fbjg7f5u8t6fXBeLCSy9GD3ieVJYYOx1clSlOdl5bxdRLPMR4XR7XtmibT1oLaQHe0Zv5GL23kPPlMOfNxho6lLBm+nTyHNXuCjxC20s2+fNSpJdxrIL+M6XP2OslSt60/irgbuTsN45ko4zCK9cTCaTvtz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343511; c=relaxed/simple;
	bh=sy+ikOIF7jlqcRtDfJFORY8Yy6sZXFR0XbWp9D3uWKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+YGthaNnlEYuX2oAHlU//e3/x1b4+6iXmlcb0/AnHsB8OeSAwHWGAa+nUXX1CtMwV/tSJ1xfK5GLDdJNIx7s1YQoSD4zIhhGO+ynF5ryJDai8rw4MR+tnMjhLK5brgaLPcDqc/gZXBqKw8PU+bli19BxZgF6IVQyGgMEmz271A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mTkM8Bmk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mTkM8Bmk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so1300853f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 23:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786343507; x=1786948307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Svz2rEyXrYuBIjG8VHu1ZYcyOMdHhrrxXeEbTj9Kros=;
        b=mTkM8BmkokNkaKx5suNy9RKmifV5mbpJvh+Wk0zXPtFHx8p3RRv6VB2Q3iyyWWoZ7q
         zj2m2iDGw0tvnzX3mHIIjjIKft3FUnLmYUkJyQG1nwcZt3mxSsvRYE5Thlzvlup71bCv
         5I+jOecKQ0jKExk3k3kgqUjaeP60KqZtcjFzAG+muB7nmRTooGImy2E0f0ptGlS2ptA+
         rhBwwfCu3U9AdgNCI7P+wLFYpyXTVOuiw42ruyuXoMI5N863a/h6kYy5p11aab71JEDC
         exHW0dN9t7LrwGSGkcBRnjemlIQS9kef/wPmdPsv478PNJ/QVnpscivIEkpNMyH3sJar
         qByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786343507; x=1786948307;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Svz2rEyXrYuBIjG8VHu1ZYcyOMdHhrrxXeEbTj9Kros=;
        b=UjvCQ/jbilz68hFyLv4LqvXnyX/T1oq0+x4RMfru5alzHDTSfogvSEz6VVjKAVqY4A
         6hduSUFvjjGq1rd9K87TfgH6geKXqwHHAG4ZqpAFHU+aB3/cWIqSI+uyGnuf5tl18CNq
         wAYyoYM7nEg2tE1QWpq1u4YfTzvp1XV/4n/BGbUWv7mu7vEe1v9wHH7Iv7fiWNCHlSZM
         yMvxqvmAzlJ9PtDdISYnew+oyjgPqU+fsBluCJ1XwXlf+yHs+IwG11bJ/l5ph0jKrfB3
         BMrpJE/iXJJIWAn85g+r7hbnc105TO6LFFeYVRv2D/1oY8NWa660kOd/WvQkV409xhPl
         NHzg==
X-Gm-Message-State: AOJu0YxEul4sMwmxbpJLkwFaeuLxO/D5k8E7YpAHYhMaf+vun8BdeZ0y
	6lvTN24cpsrPJiNRi86OWihF2Bj26p5aZawzneln1r5a5ucFBcCUfCl0fdsfW26pe+U=
X-Gm-Gg: AR+sD10Sgl/jqK2+84/g0SZb7JA/B6qMjDziRXgllB6WzXgWE8OmfQ2+wMAf9oEzeyx
	Te2pIgZ21f75GbAfn9fGUQM9tcobd5PL9Fox7A4/eheAaZKRzwmXCewN6Ql1Ygni2QUdC2Tz6fi
	/cAzIY0BSQNxdG5XEEn4GRcqVyKeIZtEMfBNlJRKPmder2uekeGqxNhIyddCDjWbW/eSM58XMQi
	4Ya7G0ODTEdnjI/P65RI4Pn9RY4efzShKArCthifXsykpzkz3WR1uho/11676ZeFJYODP7rZwS3
	ZJWvqIQP09Mme8vIvi6Z6mv5h82dwYv8PvrbrdK+uHt6e5zXB9q19tTWAgPDrya+i0oV4OmeuuC
	cnOOs2Dja0AaCQdqraabw6XJ6romWaGdkda15xJ0MrcVnSzDmAPSoh/xRTM/kvgQG5qFvqQwpAM
	KuWOrJSWwlM8wnfEWBmTe+KtWmrJc1fHSD9asNG5BNRJOemXOOQ6OGo8RLZ8cH9eswj9dFciTkr
	XpyhIGGerbmggZuddI=
X-Received: by 2002:adf:f184:0:b0:47f:8fc8:af01 with SMTP id ffacd0b85a97d-47fec63302bmr47818413f8f.27.1786343506867;
        Sun, 09 Aug 2026 23:31:46 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8f33sm36497853f8f.27.2026.08.09.23.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 23:31:46 -0700 (PDT)
Message-ID: <6381a88c-d7a7-4fba-ab7f-650eba504291@blackwall.org>
Date: Mon, 10 Aug 2026 09:31:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netdev: check for nla_put_u32() failures
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 bobbyeshleman@gmail.com, joe@dama.to, sdf@fomichev.me, dw@davidwei.uk
References: <20260809000609.327659-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260809000609.327659-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/08/2026 03:06, Jakub Kicinski wrote:
> Make sure we check if nla_put_u32(id) was successful after creating
> objects. This is theoretical today, the skbs are large enough to
> always fit the ID.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - don't handle, just WARN
> v1: https://lore.kernel.org/20260609190804.1137085-2-kuba@kernel.org
> 
> CC: daniel@iogearbox.net
> CC: bobbyeshleman@gmail.com
> CC: joe@dama.to
> CC: razor@blackwall.org
> CC: sdf@fomichev.me
> CC: dw@davidwei.uk
> ---
>   net/core/netdev-genl.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index c0a86f3ae33b..fa9edfdb32c2 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1119,7 +1119,9 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>   			goto err_unbind;
>   	}
>   
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	/* rsp was allocated large enough */
> +	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id));
> +
>   	genlmsg_end(rsp, hdr);
>   
>   	err = genlmsg_reply(rsp, info);
> @@ -1253,7 +1255,9 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto err_unlock_bind_dev;
>   	}
>   
> -	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	/* rsp was allocated large enough */
> +	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id));
> +
>   	genlmsg_end(rsp, hdr);
>   
>   	if (bind_dev != netdev)
> @@ -1420,7 +1424,9 @@ int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	netdev_rx_queue_lease(rxq, rxq_lease);
>   
> -	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	/* rsp was allocated large enough */
> +	WARN_ON_ONCE(nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id));
> +
>   	genlmsg_end(rsp, hdr);
>   
>   	netdev_unlock(dev_lease);

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

