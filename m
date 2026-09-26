Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270737B018
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406170; cv=pass; b=kcbcVC8zSdMabjZPGGJSq4yyVD1oSHb1NTVK1EWbrm3XNbg5/IjZHMhpeC1KfrzSeuqChHi1P1U1DJrImub6VMPtKaZfuoNTPsv/jcPYWaYg/ZYbmm0UYMM4Gpr/jhlSwzKICVxm29cGKf0wN8JyaNvELzX0eZEYDko3tnvKD1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406170; c=relaxed/simple;
	bh=krXieruHfDNk79o9gey9Pm0eZok9Dc2xnoHAn+WVBgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoiWr1TkpB5sRV1jHvSHCeGq1oVCgzA8rWIzQDnV6GlXYBYJqe6ISITzEvBHy+jvqcCN0IAKzMyu5oJnbHERuKCNRywQ5HORMxuQvYsRiPoPTE8r6bQvmGGHICpwC9ql6j2Lps96GcegAwgtyeQTMWQsdLbHe2qXdho99HLksAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwcY+1J/; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwcY+1J/"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6595b02ebso5016041fa.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790406167; cv=none;
        d=google.com; s=arc-20260327;
        b=cvsvAD0lP4GJD42LOIT8DYPaezdS0hxsZ9bLWmBg0TNKPHCcmmuhHViuNMdgrhOcvM
         V19RKjiF0nvZLnnfRoywe0Orj+7coESqISMMqjRlN7K4Kf5OqU7+UZDMgabV+HYPTcx2
         YSwBv8TmFLADQ/SI7Q3gZhU17Ktgxw2cv7CWm5DxKlNiM3KVZKUWdwcgjtRbwhXCAkpM
         ltqPxuph8H0h0JwGXQr8IhMZY8Ig0RGXWPt55YDVt9e/OoQ8Mcf8KUztDgOouMR4KFWq
         efHweuqAwea7iDGj+NSE4+rJ01WOgGrTulEU3xRlCwgBJ5UwvejVwQ13l6bGtAcx4V34
         233w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=krXieruHfDNk79o9gey9Pm0eZok9Dc2xnoHAn+WVBgk=;
        fh=ShDv8yPEm8/NMRbzt6mbD+n3zgojxT8iKTQ5gUMK0Uc=;
        b=eNwkxsSm4N2JRt8YeY2q/bxEpyfmiNF0JJXtYu7KyGIYSgU/itAAS5JMjvPn1M7hZx
         Hct+d5lcPZGtCVqw666PeyW94sKao+UUf7ccprznsT7DTr68EWXCgGd91tO930l4KZ5V
         +L93UXxG4B5Y+BMv/R0U3U0CQk+thpWzi23MfVfqAWzGhYhBohmBPzJBCsW+kXtrql5a
         VBtIZG1KYpRWJlymLOetnYYcJL63RHlU7lOkhKb/THsWqZPKn1QSAJipHITR/fn1Be66
         jkUJLrhU0JLWCKFmtgo6W9FY6om4c18wlqgiWYbohZOSELlqi/K6HaUrF1Ms+RwcVm7R
         yP4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406167; x=1791010967; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krXieruHfDNk79o9gey9Pm0eZok9Dc2xnoHAn+WVBgk=;
        b=bwcY+1J/5QUzoD9giyqfZGNKr5xwUSjxXwqxhkM0pDX8PSJ7nMNrdTGHY8LVCStX9G
         O2v5yFlbcqjNc02z6khHCHoDFJzMdD1R38kTTa+HHAaxHDs8gBgSb2buYys6moAktk/p
         gOV+m7tZPZgmdPVbtqYR9+15THj+8+6xf+ejmS3e7KUzHvJIT4cUChjAvh6e12GzdBqb
         Rjpww+SjjXAWB8lCvXmXj5v94i/yjO59Q/Fk0wCDpTp4DRe0xdW84ONmQjWnCwHkVqQM
         BRA8V9NgOrraP8o+7iAKaR0XFFU1D2nR4IXVfm6qVRhrKRtEYbhGuPI8ZnToXk36JikR
         Dv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406167; x=1791010967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=krXieruHfDNk79o9gey9Pm0eZok9Dc2xnoHAn+WVBgk=;
        b=nnHV+44trEQ/KuR/clt1VSukPT3BNTk3kCWvjT4epwV6hQQsObVQq/aUjGnLDhI9Xu
         HdJJ8rWp9AsiZ/KnC63OUSFIXbLeJTGrjzrktgoZ+xyWUf6WY5bNRoFBNgAEWdHz5OF0
         mHL86VFcjcJSQAQHedmGc5es2dN2+yJ2qT6KxoUGjLjoKycOUq1qKqElhtlP0cu99V5E
         QdnfoqHM9XsrLiYb9nyfKZcoOigFOcNzZDipyJckx9lJ1cRMScWqe+zuH/9RQgKu4k3D
         2670HNSD4sbyE1RE33ZZRkih+FBw6u9CD6siLi4HtIFZ9eB5ywGzVKPasZNmODzqT4sq
         yW5g==
X-Forwarded-Encrypted: i=1; AKwUvBy7wcO5l/MpY3D1y1L/A6G7vS5bNr4u4Z9aCRGqAcUKDG1fjqtq5KOIAQ6m4/FsNy+P6U33cnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYZjxA8PkJ3SeEMOst9ku+eI3XA0kH46Hi+9mdvpQk7DcAQuP9
	OfLKvVwgP8FtqYcNBKZmkjq6/2bzgj8iX5VPQx66C+iyrGIUMIjlmBxpMNW2gGw0bJpqR36zd80
	WSAN1zgonhprGB5iXvFaav8QJ6T9GZ8A=
X-Gm-Gg: AYBFou2GBIWcj4XEWaAaOjNjshMJl37Q9GqHw4LGBS5awDSbgixLZAPLspEtptAtG5d
	G/gcqBgk5+1m0fAHMcAuGBBihL6+FUSR/ufr8ZYtGbeTvGcUiml34tgdJaSaVsqkoft/uvJOr3Q
	+H2AlpDjL5mQRFUIMHdt35GEjGjwOaLziGOhblaMN8VOuPVEV67qgpiDDMwVAoHAAgG0nGkCSOQ
	M6PlZsyJL0t5IfZEzYIhJxOUKsFfvXNQ5Z92hQ+Z1ZfZMoafnliBuMhl1OWYBAZQOaPoqyhQyxS
	KVa5GX0HkfJHWFuf/MWmR/raYPvp/PJOtF0dTKHjoBePFF/oDV3/8hYEpSXBYMhlZ7UICG/AX0E
	tmBQnw2bED6g=
X-Received: by 2002:a2e:a9a9:0:b0:39c:8124:93b3 with SMTP id
 38308e7fff4ca-3a64c7419a0mr11104021fa.9.1790406166593; Sat, 26 Sep 2026
 00:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924011554.3494-1-sigefriedhyy@gmail.com> <20260924011554.3494-3-sigefriedhyy@gmail.com>
 <6541b309-4e1f-462b-a867-57b67bba1b94@6wind.com>
In-Reply-To: <6541b309-4e1f-462b-a867-57b67bba1b94@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 26 Sep 2026 16:02:36 +0900
X-Gm-Features: AclHuK8GvYlXAIGomaFcHDshMtPeFRf47FxfSP2FpiyAnegN159jNnhl7hdQoVQ
Message-ID: <CA+7S2vL-6m4RACthX==UVhVw7N4xRc73EbwMJHLXTY+=Px=z_A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: add a generation counter for dev->mc changes
To: nicolas.dichtel@6wind.com
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> There are several lists owned by a device (dev->dev_addrs, dev->uc, dev->mc,
> dev->rx_mode_addr_cache), the name 'owner' does not reflect that it is set only
> when the list is dev->mc.
> I wonder if the name should be changed or if __hw_addr_init() should be updated
> to always set owner when the list is owned by a device.
> list->count and dev_mc_genid evolves together. Perhaps some helpers would be
> less error-prone for future patches?
>
> __hw_addr_count_inc()
> __hw_addr_count_dec()
> __hw_addr_count_reset()

Thanks for the suggestion, will update based on the suggestion in patchset v8.

Thanks,

Yuyang
