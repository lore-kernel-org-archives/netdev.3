Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF13264FF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456986; cv=none; b=QHRVE3WJukoqnlpM72iWwlhqXcXZDTh1B7aIO8GtKzmMtaul/AuQKZveWfXEZU95NsqnIVc+nlCpYw4Ft/86I3KhSa0Vmvc2e0v08K/xnmiZA104lRnFdrstbIBwBdgQSurDK2Otlg89305BOv10r0TTrAotPeHdq1a65UOjxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456986; c=relaxed/simple;
	bh=wmn5mNUYzQYC135V8FhOWImbD4cv2LA9D9Q4BUoKyFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh51klEwGhbMgO5boiKUlvrF46PxVwVZLqBL7FdAvK7rdGFm97iAGzSbFgdbBqG7FotJVQeunMvjG8XvgbL9umebOjv0WKxZY/QcLaSi06v8/vQwnSs/uf6ATvUqrGtqh4bmtUiUsHbMKzAVyvrR19MwHXF1h74XOv8tz6E9xOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so1119207f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456983; x=1787061783;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jT5Wpv6MRIZY+6fLcs8od38cfzLkLzArktPJVcuIWyo=;
        b=GX7KGnmHef6sAZWy3VncMeKeVF8SoOxhgArW8OhO4147GHIY+HUzskCU7VutGEPRj3
         6uR2aesFI0iznWecue74GhnIf9wS2u+EKFYgkLRB6Zb7HDr3ZFEyZWKnbZxl+zYx9EBe
         rgPP4pzlYl02y9G88Q5TwckiPehXfAlnoDUErbLOhB/Bk2n+PK5avQQcNKkShbhu79JI
         7Jxy/cL8P49QysjwvFOG8acXcWjZbabNFhIk5NouUiE+5WSI36K2761gDLqGbK1mYrY0
         rt2gUNrEqCPhD02cSzmpZdftIuCHA3icK87BWHwDF1O25uvL66D03VHUOM3l+rhwyl/K
         g+2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rromjd7+o6Ex7FXCaaEyymQljuB2S6+4UuKP47j0y2sqgaZq/KJX0x1UAKcNAjNjEL0+LJsnq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0a9UZGCQxgxsyesc4APqd1pIif7+BfFKwqx1rrGcdBQsMiCO3
	c9/44juYAH/hkZg6GWJ9LDbUr6bWd0Tevk+6RvFyKbd0p7eJ78MEIwe/
X-Gm-Gg: AR+sD12W9NQX5bc2mSZlJmbS8pjJ3d0UHl6m8X6lMPU12K5eOWEPDvFVxptwIYSwx1j
	oklPX3oYOHSBJKVwRJ6C7rwOvI878icopbvFDJDUkZDCXeGFnZ8zcMJevTVODFVHtTiYGx894hI
	gfRzHb2Jb5PwRO/0Ds4OCG/PzoX0tjFgpvuEdEs2EmOTnz+hZ4AMqgtFUD01cdzOvpygh419hx1
	+9P+mavIWMn2hzHt/3vIgRH1PwMRs29uURWGeKSKTJWMvQHNemLx0mdnN8V9N8tB2/Xr5b23tRT
	N8Xe/Olxdwcan3f8NlkKgZlOAczP1PLz+C1Fz+zTh8eiG20SqVLSH6AB2YzzVnThzbyuRRFOE5P
	K4RPryB6R6up9/1GelGAtUBRp0joNWVtiXa28lJguzTz/IhjeAFoLaLnzzfaUsr1rPNvzx1DRw4
	cmoODaRAVkF5ymvKN8Ef3d0u9f1X7ysl9pdS8VxFQkYJxsH5qltkGS4bd2hFryvYIdDra5qLRuW
	k+nAcDopEwx2ebBnQ==
X-Received: by 2002:a05:6000:1865:b0:47f:8ce7:8684 with SMTP id ffacd0b85a97d-4814ad75b07mr5116321f8f.6.1786456974360;
        Tue, 11 Aug 2026 07:02:54 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a7095a0sm4640335f8f.17.2026.08.11.07.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:02:53 -0700 (PDT)
Message-ID: <d7471dde-43f6-4c31-a380-8a3f91b26d59@ovn.org>
Date: Tue, 11 Aug 2026 16:02:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1786441097.git.xuyuqiabc@gmail.com>
 <3085b885bb348a9245c5c84364fea903d9942863.1786441097.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <3085b885bb348a9245c5c84364fea903d9942863.1786441097.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 11:55 AM, Yuqi Xu wrote:
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> An unprivileged user can trigger this bug from a user and network
> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
> netns is torn down.
> 
> Publish the CT limit pointer through RCU, remove it before teardown, and
> wait for readers before freeing its contents. Keep ovs_mutex around
> individual CT limit updates, and use the RCU read-side lock while GET
> traverses the RCU-protected limit lists.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
> Changes in v5:
> 
> - Remove unreachable command-path NULL handling because netlink sockets
>   keep their network namespaces alive while requests are processed.

Please, add a note to the commit message on why the NULL checks are not
necessary for the code invoked from netlink handlers.  Otherwise, LGTM.

Best regards, Ilya Maximets.
