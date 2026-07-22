Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18402E737D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700463; cv=none; b=UKc10mzhvP0+SIiQgRdJAkPx3FWhJWsaJouChMnEGmJmRU9Nrq3D0GJZ+L4xaU4zoJDq8hdyhI98gL2HCAIJL0aKwYRrJvBwttxpzFtugH7ggIPlTXI0OZEz2XMXP86sef72sRm1Y9GNYWW37YvE2Pf8dZmRpfbuySyRAIvRLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700463; c=relaxed/simple;
	bh=EItOFMrzD5J0dUaznC9Hvz0SZ+f4YhpCUrgg2lIJKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk7pS492zRIlO8b/wzOO8JmoBz+GsUP/5fkaPLYXdws61jnTmy6logYsH0MoJVuVA3me+QthRs1mQm/JR3GVX1FGZ9bmoBB0YpWF207V512WcrjKuZosGVVHP7lPGFePrcFq9dG5jDCLnVC+/96L7q9cnmkun2LgXH6BD1lAx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeTW8BnX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/Wp+vW5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeTW8BnX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/Wp+vW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784700460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UATT60izd8r2IgiySOiquvvuPaRo1zLjW77cpIyRqiE=;
	b=QeTW8BnXemlsVYNXa/vg6wKL1Mf1mdI8zNaeIPJh9ixqcDJt8VjuhwXNS78eiNOS8NnTEz
	yNaxRZ6sIzUNJPA38y8Xt7RYmBzlLTYtJ7sqPAo25z/eJ/Ak7GR6eQnBjGxfOoT5Y7iBuk
	tTemGsSwvpKxnVcyTOFAGOIWTChAmXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-JbUbU8GmNG2k9VNOf1WZrA-1; Wed, 22 Jul 2026 02:07:39 -0400
X-MC-Unique: JbUbU8GmNG2k9VNOf1WZrA-1
X-Mimecast-MFC-AGG-ID: JbUbU8GmNG2k9VNOf1WZrA_1784700458
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492714d002cso59877555e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784700458; x=1785305258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UATT60izd8r2IgiySOiquvvuPaRo1zLjW77cpIyRqiE=;
        b=h/Wp+vW5PudxTWiZxuIoXlOF46duDDOL0Ukzv+PmMlrr/7LaW+Dl4X294Hjn8u+OP+
         vojr52ke9FpXPpmX4R2pVNaJkVcZL8PG9UAIovPn5Ao+1OWWfLQFGWP4wFxYcK6Vbt8u
         lzYzBBiH9SugOgskSgb6y+XLvGzaNE1VPPKntCmYDRwFcZ0u1S5EHmG0DBwaCb8PEVDN
         VDaYnxJehUq1XZlS+Jb+aZlIDVev4Snl0WuwiEE0fAzCYPJ+NUUUFXl3TdbNNz95/hRQ
         jZgueGBo8R3+WoeXE1RG3Ot7diKJjhuvdbEYN7t9/BIORwX98+WlMdNxzayolOqIAXwj
         XLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784700458; x=1785305258;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UATT60izd8r2IgiySOiquvvuPaRo1zLjW77cpIyRqiE=;
        b=lwcRgeB13wtNgHDbxU4ITbYnRVHKpv9uWzZsIf94emnaCkUfB6LE2WiyU6b+OSW9Dw
         jE4jGKGn16xL0n7igBGXykL134Uw/zgvVsKCfgER2tfIMfy2CrJX9ZfgwYGmJPalY8gN
         lAZNWNfO17N6MVXwOczM8tiG9+xz3lXcSW2i8EZmYsvBt376HT+UHRlAkLTWGuvhCnzt
         xe1lZExh8c90K5Zo6aUs8LLgawEKGWAZ2zg5R45FGdd6XkKh1l9qmWZvm14fmt3y2OtN
         CunxQcRMZHMDy5V5rpWQqqYyF3+j+eZ037SB0qbE8ehVZIMMbB8UXwXSlIvpnckZI713
         f98A==
X-Forwarded-Encrypted: i=1; AHgh+RoSPo/n3mkRgMaLzAA5CrQYxIZKA/7eoYmzArDlkLq7FwDYfbx17c/CZ+irs0T4zs6bfiCX3gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBxghsCKUgWfSGxV1ebDCyYKn9r97qrXjS6acXmfTXasssjsb
	Y44BEV6XOUyzOcPV3e8nRZuVWlSspyRcovUlZ4ZiRJNk23ooRiFUEzp1spvWT6nJXm0NhFNWR2j
	VR0AwdKsvFbWujFeg8bHud1UdOYxrscsjFdc6Sz9OO3EXW51h9cq4DWCFeA==
X-Gm-Gg: AR+sD11ZcpeNgIFXXYQKtznfKqFoM4GugdLkAveP80WMz7NC25U6yi/93EDUcomZGQw
	CNdWVrBSzBV7wH26IetnJk9zbQnc8Pa6GGKwyGv7aAYLTKVDFrdaFiu8qFKmn72zT10VH1ODoWj
	Uwe0qWQEMOB7yw/Wv1nQj/TNqJBqtvd23FxZ73Ot+ecKTLDgpcCzEgH95AjeBBoJbJ5cIuXP/G8
	O1VB/V01ndaOa6ZMMSouuBriGb+dHzHWRj5+98g/Melfl47hZ8X0XWVpdlDDiuZAlga+O3lK96L
	r0/8hTD6piHWJuyJ0PkUgDfal9cTZuouAEbG5IOHxGOfmwV0WuK52aiQLntw7TlzvNS9Gsx0C9w
	DXGQ0NChmrYTft19Tx8yIkQ==
X-Received: by 2002:a05:600c:6a0c:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-4954a40bd0fmr180569885e9.31.1784700457515;
        Tue, 21 Jul 2026 23:07:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6a0c:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-4954a40bd0fmr180569565e9.31.1784700456958;
        Tue, 21 Jul 2026 23:07:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm123740345e9.12.2026.07.21.23.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:07:36 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260722020611-mutt-send-email-mst@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
 <20260721105853-mutt-send-email-mst@kernel.org>
 <20260721100715.5b43412d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721100715.5b43412d@kernel.org>

On Tue, Jul 21, 2026 at 10:07:15AM -0700, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 10:59:52 -0400 Michael S. Tsirkin wrote:
> > > > I prefer applying it, but you maintainers must decide that.
> > > 
> > > Hi,
> > > just a gentle ping.
> > > Has there been any decision on this patch?
> > 
> > Hi netdev maintainers. Given there's a perf regression otherwise,
> > we should either take this or revert the original and reapply
> > in next.
> 
> Revert, please. We were AFK and are now working thru a backlog
> of 1k patches. The new IFF_* flag needs scrutiny we can't afford
> at present.

okay. Simon can you post it pls or should I? And once merged post
re-apply for next with the flag included?

Thanks!

-- 
MST

