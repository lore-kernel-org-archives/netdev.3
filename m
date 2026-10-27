Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095805;
	b=jV3aTWKh/k1DuwPtoDuD+FnjAZACcuP02BWr7K1DoJisz8NlJzxMFb1qDrGhLzRSmwfT
	 pJ+w8CD2x/4Ps+rZG/buMDzvlhEKqxbPHMlAwquRKpvqkHkbeKMC8Is9P9OI5ELPc4xXy
	 FKxY+wekh5zqwz29VA33jGUXFUSLhqg5suFrbggsXvYqyD7OWa0hluB8ZzPIYBi5rmkmR
	 aU+rg4L1HEU2pllAPyNrSdMrwq9icq2C2PguYycjxTrrfe+c27gf1XOtKrpHkPw7D8cNj
	 cnBBxWMEYLnKTVomMaZTJmVxNAEZ+unLEqT0AWV7hVbsmsMloDzO12zE+ap9zPn0IhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095805;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rvy9Ai1hCfS0r8ocGtEq75b/BSHp9npywfwwfabmAz4=;
	b=sTQkp3LWibQJj6iC2/4vCaubu+6v4uFyaJR8Mxpe+NkD/xDR9Q5lS3pst6waLWn51J9y
	 BQuKeT68CDcyR0I5tnKckpAF2kGyqhqljPzwdyzfbQQKg8IXi9LsTt+KkF12T9XWr0QDO
	 /KYKA4gx1YQAqRTdQq46ScyGVL5Sq9JLJ65ju1MY3PdNBW1U6h2sVV++sxP4wuCkf+yek
	 tUDDmikMoiJMvqQLeMs1ua5OM7e77MnjAvzdVKy7iunrRxaqTX1NE2I0wMyGeBbhBDJIq
	 4OqRRlbd83cHn2OXDG90P3nNVWsydXujdv3zVORjnNWqLofnGqYsWzapomhMj3EktMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJ6uxpDE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="p4No/ypM";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539C606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5539C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJ6uxpDE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p4No/ypM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793095803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvy9Ai1hCfS0r8ocGtEq75b/BSHp9npywfwwfabmAz4=;
	b=LJ6uxpDEiTrygQQPML/Vcu91Ysu9WU96427S+4d/2ycjvfJvaGdvq2VqhFBJUla3+NAlS5
	IxZm4Ym1bCZadt1W+YMeA8Xj3hmPmn9s795FwlD/1WUZPvD0v+3/d2mxY54eUUJZdS8U2N
	kmqmOi+9BUADswW2c7dstWKhqDAYNrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-4SjFiLZIOt6UWTN6a-jJiw-1; Tue, 27 Oct 2026 06:10:01 -0400
X-MC-Unique: 4SjFiLZIOt6UWTN6a-jJiw-1
X-Mimecast-MFC-AGG-ID: 4SjFiLZIOt6UWTN6a-jJiw_1793095801
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso486252f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793095800; x=1793700600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rvy9Ai1hCfS0r8ocGtEq75b/BSHp9npywfwwfabmAz4=;
        b=p4No/ypMsc1RA9fhCcidffb+P0jjxAwCU8fRnfO66TvYSkZmpfJ8y1O/Vhb9dCqcpZ
         xUlMRrXnxebtFgPCirhsp3f8uefQ2hLTacITjTmp/D91jisBlUoeYNeo2LY55O5PGJpt
         udCzvs++chfGiVeO84JPLKcZDPsHI/zUuhLHSizF7x/fvy/O+GY+toQjQjvUxnm4Jk1c
         qPoAZKfCCY2ntQuQ1MzEtBxpT8pzVheWzA/o0FWnKVGTFStlrWFJ4Z9LyKgqnZUHA9KI
         kdrNdtH0SoEdmblqgxprzjSNR6HSpusozqw+O5BF4+vQ78OKLf08SrDJX9u32bObZieh
         3L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793095800; x=1793700600;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rvy9Ai1hCfS0r8ocGtEq75b/BSHp9npywfwwfabmAz4=;
        b=FEDnXnuEP+x1XE56NdsmwZQPIbkW/auWCKD+9EEc6uCRk9XbyOJjU5AzIeLKON9N/R
         UZC+y8Cjp39YeCcG3tX0BwHsHUFQOBtLng37/0E2WBYtGkvlD8OumgEPsSMEq7jahQU/
         lJ0MWaOTj6TP8VTCAxtWckdaxUpYjGp9WJpyj+Bx5ezpFbtNWo6t2EP1VrDpQdmQ7UFI
         GfVSWHqhDTrv9Mn5Zb1I+xWpIOykbTVjJNHQt3DxcdEc5WQnrQM/FRPM5E0harBtOTcx
         fc8S7YN0NGLQLwocM3PJJ6qLPupSZjYNQ690ur2Jf4+jQ8bQh7N0d0boHMISq/Kg0J3N
         1gKw==
X-Gm-Message-State: AFq9FYKluX2DMTQXmD7Sky9s+48hMtz09rUNsU2qqQalXKSoYJ8mMqL/
	7cWw9dRykg266hajfdtCiiRx56IcULOnR6mFIDgrOx/FRhIb6r9M1cJUE55abKBsRgmvlA47nQd
	iwS1SP868nn2wJ0kBU+MEVZRvDa8yK1VPCuXvqGUk2j3WA+QY/8l0q0nYBg==
X-Gm-Gg: AYBFou2iCG1m4qXWzJPQWN+kh/hHPgktuzSF5FozODlUsmrIyXHzrU3aPaQJliQoAEJ
	Oyd2J2FZVw7A7cyOi/udoaEqDmptvNsfEF2M8YgRDOurujaRHHqPRD4zsLPRmDF3wRPeX9thoR0
	R22a72QaQfXOcX0EbX+zsH8zcww5Lza+SkJECjOZ0zsj5ZgVFEb+6Gw8WXwRg638JUoip3yqYW0
	Ao89jvlfCuD44G9kYPjgx3knytDcIlsKs1UdL9vtCGbUk4RT3rlUmOxt3V4XVwQSOf+tCS8dSpb
	XqDcAx05feI0JgUTC+CCWfkdnyVe7UxEmNHBIprlvGDE9s+O5Kr/GO4+Tx8gIIvsZcSkH/KC3nQ
	IvqJNgLHZZRply5zN6QG3QBhvH/XxeUKeQicyKRldqktFn5huof9/hjK8y5+gvtQ+neN72QfF1g
	==
X-Received: by 2002:a05:6000:1a85:b0:48d:efcb:1fea with SMTP id ffacd0b85a97d-48e559bc0d3mr4973869f8f.0.1793095800548;
        Tue, 27 Oct 2026 03:10:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:48d:efcb:1fea with SMTP id ffacd0b85a97d-48e559bc0d3mr4973816f8f.0.1793095799953;
        Tue, 27 Oct 2026 03:09:59 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm21694638f8f.53.2026.10.27.03.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:09:59 -0700 (PDT)
Message-ID: <577d1599-56eb-44d9-8919-9b0390bf8fb4@redhat.com>
Date: Tue, 27 Oct 2026 11:09:57 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: txgbe: keep MAC enabled for SP devices
 that support NCSI
To: netdev-bot+sashiko@kernel.org, jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 linux@armlinux.org.uk, jacob.e.keller@intel.com, kees@kernel.org,
 zhaochenguang@kylinos.cn, maxime.chevallier@bootlin.com,
 aleksandr.loktionov@intel.com, u.kleine-koenig@baylibre.com,
 rmk+kernel@armlinux.org.uk, maciej.fijalkowski@intel.com, horms@kernel.org
References: <20261020060107.25636-3-jiawenwu@trustnetic.com>
 <179274624909.3134.8154533861591358950@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179274624909.3134.8154533861591358950@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 11:04, netdev-bot+sashiko@kernel.org wrote:
> - [High] The NCSI TX_DISABLE override only covers
>    txgbe_gpio_direction_out().
> - [Medium] net: txgbe: TX_DISABLE asserted on NCSI devices during
>    phylink_start()
Both the above looks relevant.

Also please note that you are requested to reply to the bots comments.

Thanks,

Paolo

