Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CB37EFE3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947809; cv=pass; b=fnFsWBuDXZm0bhjekzstpsfVQPSJixfHV8sRaZXLEBidCrh7QyB53r2UqjqA4yPxuyk+I7D2gu/8WCjoDW/ciRkae8U2YrEpwtl3RLqsapOva4J4hk9mByQJm+nKmHR+82orLCu/Givk/Wq5b3Gnx4fMCjC3zyIkQIUHwqWUqLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947809; c=relaxed/simple;
	bh=pxVDNjiYD7Knybt697mjc9xJEbl9EC+T+DebYLLnlEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glKwHj9cW1z74CRjyFq3o1NpZUoVT3vQv+zZYpUv2zQW8hd8LTfq9QFM7SlHcV14KrxPhmqaOJ6Mus9AxFIzFkVXQlo3YmCpgQoJhJ22dsIpMc8N3/H7WUWDzGqRPh9aQ7FQ9Ag5Xf+qksMYE3SOJsLW8yW8qUNz+w7HmiprS6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtOfgA2H; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtOfgA2H"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b4001af28so57530171cf.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947807; cv=none;
        d=google.com; s=arc-20240605;
        b=MSphPn85km8vSJD8lBwW27YHYkjs8WrcOj2bmWaE79MrIinkhDhgkBjcojBDbn8kx1
         es/SarlI316MfwWy30elviIu/aac9HEtBKovnGlPxyqgaZl45S99C6CickuycPhyzkck
         ez3DwO7sajtslYoM4dJ9kII/8xuOri95qlDwUjngwzEjv13kI2iUkyZheN8l3Eu9PMLZ
         Z1WUlGUcUPLZBTzyGDCuqqyb9CcXTX9mBO7VWwYmM146PcKNCl3xv6tM47rqKcCAAB8l
         f8vZewDw3kt5rhruYE1tf1yXTmec9CheTVJzHs6LlP1Fb/r1PdHK5xTPoqVO8I/LW81g
         gevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxVDNjiYD7Knybt697mjc9xJEbl9EC+T+DebYLLnlEQ=;
        fh=1yQHGQyVX9Iezq4sndlLSmYSH7SmXRmizWIM1d94NgI=;
        b=Q1NRA3V4SlwubIWtzX98c4CbWku/0HIEBOLYAt44z4BqkNxyWzWTcvZNjSW+hTQIC7
         k8y5UNG9KNxaruY8gYc1/CQPTpx96B5sfn+f2dVHd6iTW9amIBYQDxjRY3x3MRY6i03+
         SUR26pPXW/NG/7DdMKWGsbnovYwXxcEmjd1jMnvBQ/oo0R7tt0nVJFXuyd0oUjNEEPah
         Grbqybjn7mhNaUHU3rRI0iOQa0dnD538AQJR2s6J7FXzbxkeVKjI3+HypA7r44pKEnNk
         I5TmVLMrNY1zv+0f7fFl84SC5H4sshlkr/e8aLWTJ6kGGIoSKMqwjOM35UHzWPnBATin
         CoJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774947807; x=1775552607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxVDNjiYD7Knybt697mjc9xJEbl9EC+T+DebYLLnlEQ=;
        b=mtOfgA2HLMlPj1h9TevoxlCBEgFFioDcXosMecAbGQZbl+mhTbobmR/ceTXl0ORTo5
         zfIjUgEKY2oQ8IPXWO/vG/PZtcEA+E3mYVqkAnjl7g6WusJfXOEm60t6jnmrjorTdAJw
         IJqVwdjbyChwRC8oaO10GGgBwBNKg+R579jZwZ7CGB5rC2nYYjzncdT5jAGJNY5Ag3Zh
         0dvhJ+4kOuZ6BZYqSeC9gKXR67hGtj2PhQp7ayRibqnDsmgOnBUXcWVF3Q8pUAk4s+AC
         Dp35UI6mhrgI3b637IKOLyad3l5xq0EyTSl3OQcL6yDKaeX6ZtbIEkxlrBZX5LTGDlCn
         geNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947807; x=1775552607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxVDNjiYD7Knybt697mjc9xJEbl9EC+T+DebYLLnlEQ=;
        b=k/Y0DxRG0494++tjyjbu46cxsDy5FQ05IgfS34zjTlAOzSZIGrXl2x8XwFCzfqqCen
         SLGCvNRVT+BoPuRQ4ZkCr5y8vaTxvzbXdw3XiMZN9GVsyF59ei9Nxn2qtswvaX4+B/U0
         2toaMLZQKwEScbOF0WtAHnqSjwzOqE97IS4fIngMSFnjDiwis5CXVX6bbEgIRQvyqO1L
         9NqnMDP5ylAB79cpotbxcLCH7ZeIDVxEnFlSC38XvSBq8mZeToAooUfDsFjSSZT5m0Ss
         8m/FanOWUfusIvwlV6ORqsTSzxPyQGyTxhqEOGiVw1vAQTKNLlRFqFevT9ioMTv/mbs3
         gP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXg+J9fII+B+tkC5DXbjzM9Z6kK1VZr3ov1FfpZenfHxnfrTi5W6nLst0KLYRWVQHXNRhA+9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPyoosC4QRWjT50djvA+srWetUJ04ZQT/jAr/XqNpV63OSBLR
	CVZDXU7xepH7XcrYsSZzhvNOZgT82YnCvtuWFznVv/dp0IuWYOkviH0+vp675r7Zlv5Q2g/A7H3
	maIMCNG6ydcAMV7s++MxcaHMd1l9BrAwNUk9kqtX9
X-Gm-Gg: ATEYQzz6qmJ3cB84Xo7W4GL3AsCa5pfLctwizwblVSQOOpkHoO6R6PpPqoMKMBfnRNF
	G+hbOsV+42EHbAJ+39CnSYn1HFYDOmFQyrBQ6bw3LvUTOty5tkzY3rZZue+UOcEQwrv3Edncbgo
	rk38/EjC8sYOP7lizln0jM7pgl586ApR0ca5Iv+NQlNNQkwtByWNvwUtn7oTwCmaogNSeZtOc4b
	FMr0DzZ0qPnRcrI6BxQsg4bDUsK8CmfUF++Q/gN2Gi9mRtxDkVD/f3PFGTjKr9UHT/Y97pOS5P9
	LZxnNA==
X-Received: by 2002:a05:622a:392:b0:509:3c33:9d2a with SMTP id
 d75a77b69052e-50ba380bb3emr206273171cf.23.1774947806118; Tue, 31 Mar 2026
 02:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308070925.58939-1-nashuiliang@gmail.com> <CANn89iJYiyp4dwA+Ye=7ySgQZaPnL=XfoQ4S4eXM-gs3pP+keA@mail.gmail.com>
 <CACueBy4KyU8DjwtLM6pzjQNTbiy2M+ZhZdO7Ag=ssqWq00CJ7w@mail.gmail.com> <CACueBy5bNuKQ27F0FYTsKePq_92unuEAaMqgyGK_3ovSrO6rWA@mail.gmail.com>
In-Reply-To: <CACueBy5bNuKQ27F0FYTsKePq_92unuEAaMqgyGK_3ovSrO6rWA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 02:03:13 -0700
X-Gm-Features: AQROBzAtN2MWttsw8gYctBMQr5utwkd7RiFvAJJVxXwWJHaHEuQg11sKb7G2xoo
Message-ID: <CANn89iJfCjQCwOPo2D30dXLpVJbG+8ojTvG_7J3j6ags38efJw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: reduce RFS/ARFS flow updates by checking
 LLC affinity
To: chuang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:42=E2=80=AFAM chuang <nashuiliang@gmail.com> wro=
te:
>
> Hi,
>
> Any thoughts or suggestions on the patch "reduce RFS/ARFS flow updates
> by checking LLC affinity"? It=E2=80=99s been a while since the last updat=
e.

Please do not top-post on netdev@

Did I miss a V2 of your patch?

Include actual performance numbers in your submission to catch our
attention, or ask people using aRFS setups
to test your patch.
