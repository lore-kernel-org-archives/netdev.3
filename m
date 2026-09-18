Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9549D5BA
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743389; cv=none; b=Bu4DLa3P9Oajfu3ZoFGCVK2pAFn+0OP+TlecQJQHdFh7f/nWCwK3sN05YqliQD/08Uyk6CJYjhbJxpbmFyS1VD7zSIkbDV/rwCOV53oo2XGXytS8whBjT+6phzw7irPX27BG6S2taZCuuSDAO/MvnBuxfid/oXcdK4rEMODKSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743389; c=relaxed/simple;
	bh=xXQ+G0nmzTXvBGPD4OVvKRYdnCRog/twzJcRXHhFlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2eUbC+kKUVzmsNc76D9PxmCMuqB23pQBQ5WSNNcrI7dHe7LBtg1ASPjIA0fOZlJGKNtoldGFPXTekWzIPllgWy43fsBuMS6HPntZ+DHiH4Gn50/aktFpxE7jkLFkdUyYmIMRjT0irP8i9vvJSxCfu6HIQxtmENqESqXZxMuQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcpjAu/7; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcpjAu/7"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cc4aa027fe4so243878a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789743387; x=1790348187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxbLAsQfwa8wDcu7Vj6u9ayoOx3Ss9z2eBNHxOiuDqA=;
        b=GcpjAu/7Jf9p80IXY58Tn+mT8xumcz1ds9ArgXbTWDwbKFuRWVAZCpDM5HPS4vWOZY
         0glfraXLgVBmcVB93bkUPrklEm12hOx7uizJr3p6995PB5hGDe7fGmuqGy+pdQX4ogtN
         5Re8QWS8ZwPD/3k2PoBUu+4IXcjFxBhqj8nWgdUGImie7y+jaWJOm3JSApcRcZK+hTHz
         +MYYXrSFSMSjl2eqhscFAFw1BI0Cy8pSPtFiUlMusxUpQ3Slfr+DWtNCmW1Jxn81yOTV
         +3aLyZrCzBCGjwE39ZQCHGm7+fBtAlJOrAZMwN7dskCKRLGRp6XgTfzW9nfRlA5iLQ1G
         Xeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743387; x=1790348187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxbLAsQfwa8wDcu7Vj6u9ayoOx3Ss9z2eBNHxOiuDqA=;
        b=uh0bPjfE8/yk3awBKioLea3F+1SxoY4BoqoJ6+8gmyPS7Ydk6j19FKH6gJrV4s4q2j
         UyjnMPvmFLCLxGIlT/USP2E/7wellr8BIeEfISFXarOdR3kc8dGpzYHzZlb9qXi6prEJ
         jiugV++KV1RRhoa8rclyRc7YZ+4MCz7Nzzrf6MNDbyxWi7B6C2rEan20hVTRd9rHTlHy
         TX92/E2+vQ2xBtdO2t/Nvs3dByTssKo5bS7u42DBfOalddOfxqHnukMnG2TosgNX5DJe
         x9tA8BtMdn3kWPJ3GAM6m6Cpd5P9Zpaim5bmS1vFbtNj6mV6P3Dlv3kJXuOFp9qtvvM0
         ykdQ==
X-Forwarded-Encrypted: i=1; AKwUvBzghr5DLZWeQhk7GqmcEWC+vdGAbl/jThxg3yYGyw4HwnjtX0+0uyZVWuVFzAUA+hXC20xw/Yw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2YmXE5dqzKHt5fiThSkTO+Ov6W3/Ony+RD6sIiNKh9iUC5jFF
	qpgTHJAg2g+WQLIHSHFiD3a7vR6XClOgRern57kZGwNG/YcaO0ABYn4MYsMHg6Ma
X-Gm-Gg: AYBFou3zbR9F+0/NrGDaTXUU+qjy/84GiH6mnC58XkDID7EKwCeIootTi3mEorQpmF5
	sK65sGJdhbdtTJJXQ4iIyxRnB+TBBwnM9GhImhGZyFYjd99djFAj9WI9yuPM6mMlGvjOxuRDn/o
	VgrVV2RbeukVUg0JHH1ebBLfzPryn2dR0MIdGeqCS9dXzoiHNA8Mua0qG+LgQwlV6+2wOG8oK51
	p04Jjw9cQI2rNAlLmKdjHtJJZpTr+bdLF6lUgEqvpZQy+076u4X0XWpdWdiZg3KvmYUpNeIgQLL
	P/c8B8JLs7FXkrS9tTElNQ6yht9MTGy5djWI7dVBod6fqI5PldJ1Esbwh2Oy7I02tQ2B6WE1KFg
	i5MB7i5KePj1KMXCTkxKh/T+6fxeeQeRHG8oAZSU79D5Ywhzq2fJZIHoH63zEXKIRp0p3MmF1vh
	hCj1VYgVbOLurEmsAqQtkBpoyozk5Rho4ONa77WeoKf+oGGiUaK4Wz8g1c9fMi3mE=
X-Received: by 2002:a05:6a00:4c8b:b0:874:705d:f63d with SMTP id d2e1a72fcca58-874de006fdcmr5442714b3a.31.1789743387280;
        Fri, 18 Sep 2026 07:56:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dc8fa41dsm1029391b3a.19.2026.09.18.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:56:24 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:56:19 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] net: netdev-genl: add missing uns-admin-perm flag to
 BIND_TX
Message-ID: <aq1Q6095yX0UmKKP@devvm7509.cco0.facebook.com>
References: <20260918114329.3659849-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918114329.3659849-1-ndaugoing@gmail.com>

On 09/18, Yuchao Zhang wrote:
> Hi Jakub, Donald, and netdev maintainers,
> 
> During static inspection of the netdev generic netlink family and devmem
> TCP operations, we noticed an inconsistency in permission checks between
> the BIND_RX and BIND_TX operations.

This is by design. Similar patch has been posted many times, please
search the list..

---
pw-bot: cr
