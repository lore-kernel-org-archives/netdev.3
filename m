Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63D2517AF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407618; cv=none; b=DGWD+ocrHRMG2bGNJ0j3R9kpTglJRRAWGfLIdieSyO/eL5qPbfgFmyp+MPsd255XoOdymwQQPZds8azA59zw89tQbodMmeF98tasBFG1OLaGxkZGPceDg3QUy58VX75jogobY5pd3ZjJ/2BF/MeWqZaUfZU9pfreNGfXOBAj8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407618; c=relaxed/simple;
	bh=34BReqskwWtR1yl6Msby2vfKC8qqP4piVGM5TbSXaSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QarVjqc4IqRETnDh+nCt/xfoBxnBGpxBH8WCj9Pj77gfZRjfqchpR1GsmcZOtPvQYa9mRx8lbRcRR8IH2YAwFjmWUIubS0b0rZEplh0xdBNWPMsuCEDrDVr6gQcxsTVhRvGMPxiN078joOCkhUB+kJKIoy3kmFziwXpyNLKzlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwLoT6T9; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwLoT6T9"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-380fbfae1a2so291554a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786407616; x=1787012416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fSMPhKYEtFnaF9wNw4Kn6E9+D2EN1oFL8uNonD9QGxY=;
        b=VwLoT6T9Lsldis+su9YEaBa2yhd7CqiQ3RmWvtV/dq3pPMuB2bz/de47BGT6Vojz5b
         nVuR+L7Sy//isWcMG0S6QC/MbcwZWgRr7n8++STGACcykW4WwambDBczh2EKGmTUfG8r
         7xgHeHJb071NCRGsglKUvoEFQtZSZiyekiMBWpPyZYPvMRRuRMgjj5sVosbXRk//nbTY
         V0r3WDmGQIFWSIBXsGk4oM9l3qNocTgD7a6i4JWFDYVahLHufc8VZAZ6kakGV6ikg46c
         AQfqO0u60sEkHwYBKVFhAADlgK1GjZGSuwLIBhZa6urzRnmdO2zpFwTbZPEa0VIfKR6V
         PZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407616; x=1787012416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSMPhKYEtFnaF9wNw4Kn6E9+D2EN1oFL8uNonD9QGxY=;
        b=FJZ1s1PUrpel3tkLQCdJYMvlU5DUC9CTjKYloeDKsIXn7e8qpEni5bFfqq3y+1Jj+b
         MTHS/5255s731LFG/3i/BndGViBJt9G6zA/4X7H6Ws+A4bC8BqUjV2GGfKBaROqDVClL
         5N5SCD4gc565CYrX0T4KOP9UwcKPM6KivuQxBhBoohZvkZoGDgKpBt5pKn69GeyUwgUQ
         NmEUUhbDoCZ8orEdPngA3FGApWtN8xr4aBR+BlXsw9zg5VKDp8bKA9mpV6fBwpJf1xMk
         IO6BLl5RzXrr5/f8rPZvfp9npe8naeC9w/RGk4gQVqrCaKzWcjMJ5fuNoILJXm8H/83B
         QRbw==
X-Gm-Message-State: AOJu0YzC1zHKPOeEaLCEXRbsnv+ilDQyplzshBMTSJ/3DUZApuH1Thz5
	ex0nGSuyu/pX87ILO1uI8xylE5r4+RF20ofwZmltEsgrEr9tyvGKAxc4
X-Gm-Gg: AR+sD12TllpLNtFtxMf4wi5ffIqIBa1oJITWchl5YXOjN5qNXvBAZA0Xjpx2lPCago0
	Rm3xB7Sp8cGvlZb5sO5w9Iffilw+2s42MwlrGg8eGLgLqDPc8BtIDPr6q48uHIBneNKarSmcn2J
	r+F8BokZAC9SyC9dMI6YaDPbVE0xeY9+hzA6viM0/zraP8pksQHMChWOvV+IDj8ZN7xDRIkZpBi
	VZMiO0NkxZSs6DZzFiIPkyu+7RXM4zis14jcNcgccYUNFTak0IOV9LrHTR57iIydybwoLe0jSbS
	6n1I6y8bf9zk4/H7NoRnxeZq6EvoeXsXW9RmS7ADiF5WvcLuOOz1RPQx0lwmgqviAfpWfeqIwkw
	gfM/Df4Z+6Ez/F1D3P888eZoKWEsrW8lFSxAZrcAemoUYKscGc+ZWPYlCyw9aQmep/dViXg8L5B
	EIyvIPjVqND9NA03n5n/49ylwR71ITQZPDhFhOJZ8YdninCEBpv3I0rg==
X-Received: by 2002:a05:6a00:23c5:b0:848:2a69:97be with SMTP id d2e1a72fcca58-84fa186ba38mr2158255b3a.10.1786407616142;
        Mon, 10 Aug 2026 17:20:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm4590857b3a.28.2026.08.10.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:20:15 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:20:10 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v2] net: devmem: return EMSGSIZE on type mismatch
Message-ID: <anpqpXH6e6r3nYON@devvm7509.cco0.facebook.com>
References: <20260810201213.2708375-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810201213.2708375-1-almasrymina@google.com>

On 08/10, Mina Almasry wrote:
> When a devmem payload mixes with a standard page payload, return
> -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> fall back to creating a new segment instead of failing the socket send.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(matches my original suggestion on
https://lore.kernel.org/netdev/ameLB_goNrMbscXO@devvm7509.cco0.facebook.com/)
