Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C44F4032
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846331; cv=none; b=nnBD7dFufKKi3/jw6dJAyGqpspnDcKfHHaUCHrRXAmqAbnz2sKTtSLAOVvA0g5jQ1tMmciE1HwxfC/KI10QjIwIElHW9m2DmYPiqUz6uiCKJKIU9k1eAPhM3EsLsOCLSbylL4ZPhQkHEssrOXHtUbRQlY1oqW5FxTgr0ZQz7Wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846331; c=relaxed/simple;
	bh=JBnMyusVHVvC2aoo0+BM3BndoISvY4x9bprjjSPUysQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUnZjaLRllHOjHOrX8FGk0ibN6WZjygk6Emf/IvsoxhB0T9xhjuHFLi8sMRpZazc4hJP3lQN3LGLUBRoQtO8M9UUF68ZJnJxsNG51kEE4sqMoo5VEYVOMwTRmbgviDhM9lX8jxmNk20Q0m00JWzkx2+QaW3oJIA56srM/VvtU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YryeaWqR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjfYmEk2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YryeaWqR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjfYmEk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790846328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taG+MN3du7wj7jcNpPA84ZR57hK9GIPZJrpMAEYpafc=;
	b=YryeaWqR/fuvScjvAWdFyyRvewR0QnbyF2Z90VxUiucJGl1y5hyTs3OIwww6Xp4rMdBBHY
	ZlxUxj3qO+if3IihaQ4/c7pWj+JGdMnqacdxj5HFnQ9X/OUd8fsAKwK/TrQkUts7ezzq62
	ap2gETvIR/1V8MOUEBRHQI3jzSbVk88=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VykUizTMOQCpwazQ5eEjng-1; Thu, 01 Oct 2026 05:18:47 -0400
X-MC-Unique: VykUizTMOQCpwazQ5eEjng-1
X-Mimecast-MFC-AGG-ID: VykUizTMOQCpwazQ5eEjng_1790846326
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6ae14ecef5fso1728635a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790846326; x=1791451126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=taG+MN3du7wj7jcNpPA84ZR57hK9GIPZJrpMAEYpafc=;
        b=UjfYmEk2a6QTOTB7eeagwCcSv2WVwUG7ol56IwlNM8q48a1FgCOOXFJiSOTzKeOJbM
         pWmjEwnpvLJsgZLAwfhgS48HmqUcecuInmYeA0kbJSooDjnqAsud1NBeuNPyNSnxpzF7
         uk0XYd32k/Dsk42bgQHCokOtHrJijE5aCkh7gVZ+cBtuEteVxlluYKpRGYSSlw9/H+Xc
         U1k2O2NP4jZOhjMzGg9cB5ft/31NKRXaPZhgZKzKeqLY//NIS5jIzqnpP4jMcvyAd4pS
         T3+voC+N+d5avaJx1Es5RHtZGlfK3c21Dya9GWe+FLB+/6vLCKcQHqigKujnTFkMNNOm
         UREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846326; x=1791451126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=taG+MN3du7wj7jcNpPA84ZR57hK9GIPZJrpMAEYpafc=;
        b=TKwzKCY1U74G2laeSvhTEpQHKlaqDUjTfhQZYWA+uRnf9BNfAimciyp4VnG00ZHLGK
         WKcfwpEHUZGqsIm8aFa7ZKStSXVZ7ubzf2wdjRyqykvfp0GzkTDPozjPlDplwBlVzFbH
         6fSIR2wfjhu+dXbsLPobXFeKZ6qJI9IqZlP7HHmQX9W4NFdEgwzE4u0jnYOdZ/tHnilp
         aFyxX3ivzLffMrIcVtjZX/iTBO3bbCu88TTdArw13WICeScvxqoyvZiMGnraaPlGuyGi
         3QgbdKRUjjgbkuEckDYvo1fZj9Pt7B8ISGpMQ8a378LeJp/nixQ7QN2UAJ3lHXjesgeX
         410g==
X-Forwarded-Encrypted: i=1; AKwUvBxYikkybIvPUT9XbDY+ZQ8zpw0H8PnqlEev6PMnjaWXB+Ja3HOFoc1K3STdomWkTHelWnzlLhg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHSzubxe1tZ9+gLtqL1ooTFalvCBrvG7rxlUUYQmVtrAT+XhvS
	4BrnZLZA4BBP3WZSh/5XnuZXBd4w3s4QOK4XwWK6+nXzdPPL2KMg6Nm96RRt6f704QfpwIGTO4I
	qYtgYYKS26vkLx1qql5LuvnNa+8F2T0eTDAO61SvOcWB9dxxXqOrcFfurNQ==
X-Gm-Gg: AYBFou2OETk0FjNl+CZDmbSJiprxFi47ke7GXWMVy10+ukw3cMsImRNH6qnIHQMdeKd
	fNRYVx4duZQZFopipuxcdyo9qhGdPZIFkA9CT/i218yo8YbL7ThJu035vWpdwTBmfGoyuvs6hwf
	DNZYCsc3XCvVXL4NwoqESC7hZ378h1MwAhJdPnswmioOd49NoL1IdtBb9IB3mMab1rP9dSrljKK
	RJe3Zx+mTUL60FmQ53SXHFxvxkITBDUkD/+1arYuWP8xe1m+/Fv4zdGMOkRMXpbCNw3ilzJh3BZ
	aJ/f/hQJ/ojANXEdRd0Llnd8gjnUvttrNBD1mxJ3IhO2KW+p5oBVRwj9qS9r34HSrHnUvoQXDwJ
	whUq/hU+8hEMs1l36G74eYaaxmpcLAx0Nlz0J6B2hpeOb75otLu1qguFyjTVbtzCg5y5U0oI/Nw
	==
X-Received: by 2002:a05:6402:20d3:10b0:6ae:19c2:bae8 with SMTP id 4fb4d7f45d1cf-6ae19c2c1e8mr2528471a12.26.1790846326291;
        Thu, 01 Oct 2026 02:18:46 -0700 (PDT)
X-Received: by 2002:a05:6402:20d3:10b0:6ae:19c2:bae8 with SMTP id 4fb4d7f45d1cf-6ae19c2c1e8mr2528460a12.26.1790846325893;
        Thu, 01 Oct 2026 02:18:45 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae5ca64e84sm721879a12.21.2026.10.01.02.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 02:18:45 -0700 (PDT)
Message-ID: <804cd85f-21d0-4fd9-9e53-cdcbfed27e9f@redhat.com>
Date: Thu, 1 Oct 2026 11:18:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] rxrpc: RACK-TLP fixes
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260925191520.2206700-1-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260925191520.2206700-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 21:15, David Howells wrote:
> Here are some fixes for AF_RXRPC's RACK-TLP implementation.  It's split
> into two patches: the first just fixes the RFC number in comments but has
> no actual code changes; the second does the actual fixing, including:
> 
>   - Making the in/exiting fast/RTO recovery flags available to RACK-TLP code
>     after the Reorder timer expires.
> 
>   - Arming the RTO timer if no other timer is running and there is unacked
>     data.
> 
>   - Initialising the TLP state in the correct place.
> 
>   - Not resetting the xmit timestamp when marking a packet lost.
> 
>   - Correctly checking the flight size.
> 
>   - Correctly tracking the number of packets in the Tx window that have been
>     re-sent and thus correctly estimating the flight size.
I'm not sure if the sashiko feedback is worth addressing, or could be a
follow-up. Also Linus is pushing back quite a bit on fixes this late in the
cycle; we are trying to defer things to 'next', where appropriate.

I think patch 1/2 will not pass Linus' filter, and possibly even patch 2/2

WDYT about targeting net-next here?

If sashiko is deferrable, no need to repost.

/P

