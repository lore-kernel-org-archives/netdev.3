Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64827399001
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166035; cv=none; b=ffYzMYELdgvyl3+xcGMXIMvJoMO6lp7zPRv+aPCfOEherRaIVD8l2vlBh7yWaItxCHZeNdw1s0B+612Z7jJkl1cv0hklm6JtGULJrlt6wnCk0Og4a3f6OLsJpZcQnqt6ycp4i6I4lkQuIJ3z76TP3zedx7GXSd1BFbA7q2tqYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166035; c=relaxed/simple;
	bh=r1xueNEdriHwGLpNKX6pZV0hBnHxPWQp7+iPFAwMmi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfcuOE6cLnSnkjMiWQZIudkSe8d6pNkwpEL83NRymtvCbbENoJphA8Dpl7I5D1Iz1kSTNf4OHMyzjnmgkmfcmBN9eoupdB5x7X4isJJ6UZWoawcATik2zWjWRpUcP4/97p16jzEEYQme5tY94oiDLilQNuTesN0LMIQuMiKEoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBrVel8N; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBrVel8N"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so26736405ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166033; x=1785770833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FiseIjhWXpAg2kp14eHFJ/tqWX7K2DoK7xXRjIlIli8=;
        b=HBrVel8N1rOwQCkO0nruv4sq8VwtUPJO2JO1idIK7WJogGaMsqT+zb6GRfJc3BMNa7
         bTltE8n6Wo/osFNMPdZP67C0c6n/KsSMLAvLgsWjmQTxkfqbCkfDVqfjrorrOr34CXks
         GDm/OgC3QufRnwB0j4V36w+EzNB69B/nRcdd9AF/D6M5buvCz+xgqKNYMbqAp6FxTTCD
         QGF+aNU+alh2iIOhRM5KC+kQo8a7YUAQXjk0JKsFdfIwH9EVhQGCZw2XnLN7BDiWnxC+
         +ltTigj78qdZ7MqVsm2/utTKYgiRNsUNaXF3C2p7+wBt6jDssy2ILj2LaXsRbywyu1+Z
         bnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166033; x=1785770833;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiseIjhWXpAg2kp14eHFJ/tqWX7K2DoK7xXRjIlIli8=;
        b=CVMNhM9ikQu1k4X3TRc+iniDXVdwcr7MckFPCDLdf5QGw7TcYnMcgaMpi9RMFvlaIr
         kuQRsoEdmTqoSvHI/RBy8r4en6/+rqZR//enM4EryK2IBuZaON932nIH5magoKkMZO1t
         iDFEjVcwio8p+zHVnVfmXJwbzjUIMDR2OQ+d+YbjiN4TubVjeL5EGv/+f8TcEK6DbmEQ
         XGIQdfTPOmpiOYfNHYGQg634JExftan0J8L6xl+oyQtEpQOHrNJkAZ6bz8DIu8l/0O0x
         70NE9U91njNDGuYOIBZfICJjbCH7ghtCtTRnvaXugI6Eezp5YgOtdYctJcUIxY/UjFMF
         RR8g==
X-Forwarded-Encrypted: i=1; AHgh+RoN3u//V9xUdeKMhneLU0wu0hsnZcpoEEiKUFDjZCa3jABbwmw8ye7miziUcdbUZjwEUt2Bylc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycX+wmAOQSqA048nfWV21O8MTfDdhYsiJuBTGAoo7wDfFE6+qx
	DRhAJFbMdlApki4ZTL++opztH/X7gVnZpkvSDTVsJsN7rZw3Dn+6NxpL
X-Gm-Gg: AR+sD10iwEvdNkG5FmThr685s55tiZtQDrysQFfTS5TaOEJl9HnW/cxaN7nJiZ5JDtF
	Xeu9vp8bWZMS4Xg8JSV84E8tjN7Cecbr8aQyMl8qx+cwQCBJYZXggEj6jIXoPZdymtwaKIq5GbC
	fT5i99GjGXWicGYZeoF89R0x9G65RcLgx26C3u/TYlt7X//DDrK7eOfLulKiU1izUWxOkU3UZFV
	CRfB50RwH0CeDl6j4jNb+NlS2+qoJtjmRBOt0kyPRMX7E/WTParlNXzY0kCQT8DWyfi9MGV+qcw
	x+gvOdDLbAUtwtf8CrFs344gf0waV0U+jJk9rfuJMY6BEQ9iZaXVL4VibLTsOtPfixc7f5miQhX
	ORZgZW+/zqr63CdtJDRxHAyeTfOooY/rGob7YhtDSMmpSNCPIJhebbPovR9QAuYhXxS+fbwcqtL
	uWwmKm1Q==
X-Received: by 2002:a17:903:2ec4:b0:2cc:f4d4:299f with SMTP id d9443c01a7336-2cfde85fe0bmr85023955ad.27.1785166032740;
        Mon, 27 Jul 2026 08:27:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm37003525ad.31.2026.07.27.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:12 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:25:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 6/7] tls: convert getsockopt to sockopt_t
Message-ID: <amd4fzXUukTgGCid@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-6-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-getsockopt_phase4-v3-6-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, converting do_tls_getsockopt() and its per-option helpers to
> take a sockopt_t.
> 
> The thin tls_getsockopt() wrapper keeps its __user signature for now: it
> builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
> and writes the returned length back to optlen. The helpers use
> copy_to_iter() instead of copy_to_user(); the NULL optval check in the
> TLS_TX/TLS_RX path is preserved by testing the iterator user buffer.
> 
> No functional change.
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
