Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950035AC03
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502019; cv=none; b=lCykxkVTr8jSzMpAPtLLiL9f9jcFYIblgfwgqOQMyXuuNdUrc9xeofVN4eUb4yoiW/epivnYXGm2tdk7ay3bWXKtu8A0kPxmzERZUfnpCqkm/Xx9kSJ/vkdk2gxeflFvYSCZhxz4iJdGGL4bsQL3M1khMIpXNvteiM9w26UvX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502019; c=relaxed/simple;
	bh=uVHA3MxowH6wVae4z71QtAz1vyhRdboIPrZLDAJ4r58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flyF9llC80Gy3FV+afswd8DhShPpeDMden60YoRS53fPjn7h5pI4b5nMzIKxy8qa7bO7ob/JRXF9fnOQgewHDe8fezM6KVbJp/lBiPHB6ngrt5ee56vsvI5K2TRBJf5XEfrWqoAr8YMkPi1aqnOVeuSBXSlWaDbGaeeY0FKTyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NStZKT6i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NStZKT6i"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so5870505e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788502015; x=1789106815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wyUxE2TBml8FNoZA0yLvtlhvWKAzzFnIf+bKtrZuQQ=;
        b=NStZKT6islY212FSUsIHkpkH0J2EemWQ9CsN3X5NyTu9krNxeaRm3nD9JuZe4KaUow
         1mafRCjSnB97YBbbptoodzBvFTwy9XL73Nor4kJx3pHChrerEXLJPrtO+3j5++vfvemG
         Z595dG7DgwRpsleZMZB+QbyHsqh9nmMPVd0MANwX4wPNGoDTjsu7TJoIjw9betXD3hCu
         iDL1IlHNmjJT5Cu8nn4PKJEHvQczlqZSsuSYMMbZX7P1SW1+j97ZY0+qHjoL80pk+RAi
         EDGwI63UmC2vj6Kk9cdQ5kAsXpXXnLGQ/R9+VgtUIUeXUlxwngXwKVwItCTbaOCB76LL
         nPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502015; x=1789106815;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wyUxE2TBml8FNoZA0yLvtlhvWKAzzFnIf+bKtrZuQQ=;
        b=KwzHFuICy4n+SahMimIoGFYOCNL18LU/H/iKBAsXOoLgzJGrXq6xccTQk62bqV+xPp
         80s3OCly4VUHSZzwnJ6IFqlf26RG6gx51T/xtIX0E5zQEbBzUD9mGYeLGRTLQYDcAX4I
         bWZeekJUPbr9aC+MIE1sFaKA2NptEAdgZHDIxQMF8DzBXbh8a0XlHnv2FMpk45qaeKjj
         zNXvEJnPB5f0zgMCk7n74oIvtLqCGdp2arncnvtmI/fMy83XIGN53JHtI0iatm4na4V2
         vt8sikbkbvQuKqcAoyUUDvZkKOBKwE8B1dZRO+asV8dnfA7gA97x1guTUJN5xUinCOFh
         zUYw==
X-Forwarded-Encrypted: i=1; AKwUvBw6j1+x2yVdq0t0c6d3wGKwTz+rqPp8iRhxW4gF5we40XcbTGwqBcQpO5dMfX+WszhbN1/ghGk=@vger.kernel.org
X-Gm-Message-State: AFuF++mSJ2Mj5c1I0etH8qLWHr9ZrD09sXUzQ6HSlPV2Ltl9i7PuIHBw
	EgIzK9hW34DWoAuFZp7+c8G0DPbb9WiSn75PzjLFdWQIfcIPhrGcc7CZKNoU8bbaeY8=
X-Gm-Gg: AYBFou1S53tXivDh3eNh2s/1xjSVl8BYdbWzvcWCBBeV9uS8ww0oqawRd2B3XbJtYEJ
	EbUkwJ9jwOCwpkIwn/mxhOkYv9uOn9O5GjkYROzZIL4OTss412vbBnWRoeCcijZRYqtiFlvbkRM
	349GlNcIWj3wIFbipLesaL69eEqq81LqeGgk42arM0cl6O5T/VZ27wtlEjc4dcvzPSvR4KKDdPT
	L7+8ypiN/upaH9ncSANmpERCzNp5chnbSz+NbppLiXyZL5u19jbD6rZNGHTxU1XptcfTA+/RZip
	yRuImkejXOPczkY+9BQWW6evgyy/vus3PgJyfY0bp+iWmrrKRQADz8hPkcRJXNlbAD7M07GcjzJ
	ixMl3HHwZT9tEilXgT8ZY2nPn5bqG2t4y041DWwrcZYPo7dKXuIV2HlLojWpsNBELcbc4q221B7
	Uz3Y3XAH05QAsa46BItnJYn9JV7SCp81Dgz0hY48KhKznz848sMedreIGXvmXNCcgN8lknM90q+
	GOIz0dHNlWAoreePSGwiXd5Of4Bqw==
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49cf8267a36mr37870635e9.12.1788502015295;
        Thu, 03 Sep 2026 23:06:55 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce47b9817sm161309645e9.1.2026.09.03.23.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 23:06:54 -0700 (PDT)
Message-ID: <7a3f1c73-ff68-4369-a81c-bc66db003bde@blackwall.org>
Date: Fri, 4 Sep 2026 09:06:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] bonding: use skb_cow_head() in bond_do_alb_xmit()
 and rlb_arp_xmit()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Hangbin Liu <liuhangbin@kylinos.cn>, Jay Vosburgh <jv@jvosburgh.net>
References: <20260903143940.1180513-1-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260903143940.1180513-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 17:39, Eric Dumazet wrote:
> In bond_do_alb_xmit() and rlb_arp_xmit(), make sure to unclone
> skb head via skb_cow_head() before modifying the source MAC address
> (Ethernet header and ARP payload) to avoid silent corruption if
> the skb is shared or cloned. Avoid caching the header pointers
> across skb_cow_head().
> 
> In rlb_arp_xmit(), only modify arp->mac_src if it differs from
> tx_slave->dev->dev_addr to avoid an unnecessary copy and head
> reallocation.
> 
> Also, we should not assume mac header is set in output path.
> 
> Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
> and remove now redundant skb_reset_mac_header() calls.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
> v2: Use ether_addr_equal_64bits() per Sashiko AI agent feedback
> v1: https://lore.kernel.org/netdev/20260902125809.2910366-1-edumazet@google.com/
> 
>   drivers/net/bonding/bond_alb.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

