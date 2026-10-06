Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695F2D839C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248106; cv=pass; b=Scpqn495Se9cfQXnRH+n0Jt9Skt0k/uUT6J6ApJFLSaEoHdQHD/7rY8Lqi0boI2bXP/mdUrvkn/k1qZhSp+p7NMXB/edP8XzXcDUEruc/ON3OBnJLcK4BBhzAsVIHgmkm8fE1JR5HKSyDKrnWuQGbJGZ3040H6TvVcQfe7G+jpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248106; c=relaxed/simple;
	bh=WlUUULkXecDA3FrqNMgGGTCq58pBRHG2vpFkFbVh+ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtN7HQ/4SPM00YDvwEpWq58gJaQxnKg0VdoeuUiHOxjzgoHmPzD2zGlExLkfPvnCvOlUevPgkRfPk1zV6M+7SWmef/QHtSjZMnlde+mVxJZOU7la9JgCw/eBE6nQnjTfGDFIcD4s/N0B1r8YfGqIQBkaG6HRjbmSQHNnes1HqHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW/qOGkn; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW/qOGkn"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so29809851fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 17:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791248103; cv=none;
        d=google.com; s=arc-20260327;
        b=JpDCcNEIxJeesCycfkW/BT6dgTK7RO1EZ0i+CUQqrCOmgisJ8rlXbu/1wF+CTW9LR3
         vdOWfDvbAWV3lyFKRwJ9TXyEYJmmjanSlZwyKWRe9U6yU64clmfLeFM2rX3Epi6JlVAA
         7dyjdgA7cbnRBfUVLDywzKQpsimdjrSC8NatrdsbVBahXCiXAsbnk+Ncciq7i4JbdgTV
         HrEZxCgw3WHgfvak9b21QTHy5z7QrWPcenLLUm4GrkXMJz3qIbGDgqUJxZhu89yxSaAm
         XQ0JVFeUYVOultlsfTVfeNUw4nOBLtxVLcO9LYFOWQVvnVknl1MMDeEBwh/Mib5kVLQy
         WYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        fh=26wXwwW4RQ3ZnnrVcdaWH3glg6bt2PfBm55fEQD/hX0=;
        b=Co5aEAha5j1Fa/Vq28qowOdMJ1lv8FW7WtNtPY3uJDRNawK3ToCPPl3ri2ptfG7+Fe
         B1kej5XT60Mv03TAvJaatD4H3t9CC8EUTbTAOd6JoIG/vSjhOVjLjP7JScBVvrwO6MXN
         yIG8yYCRTNcJg7OBk0bxA+j/TFcRTnxdtzkpidNogdAfZdTZLm7Sm7ZnlJpDoPgqLIma
         XZ36puHD+b8bQxHLPT4olCBCEMtqvQZP3VxtmQbh64odIm49IjdUUG+8IAMU13OBWpsV
         NPpJPeMhmGrjAqJmkG6TIei+iiS56KFlCd2KHfZ86+X2w6vy+dkkLNK7ufsiODL0tdNM
         2Jlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791248103; x=1791852903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        b=bW/qOGkn8Oq3ecnO3iORBbazJd2D788Dq6dJ3XWYfSdzJ6LwitRqTlwk46xelWflAV
         gbFGss68KaNVq7/giUy8G1imnN6qjgFYeGlGP4GkDjeI8mHeQmcGyZgO4DR8xgQBojFd
         BKAducA6nlvACC39vidsPLdmEkBBidl4l2tNV/l5BL7wKH5f6DmhVfHjAJLGGC/tuXxf
         XPSg+NTKeoCQzyOfEj2Mr8SDCLinsVL+iKUdl+/XWcioaKkJhM5Lz5jlM0d6+rFN5Eup
         dsFU9EjsHCawKIEUoxk67BFgonn5q5/8iVgi+JTenRCQhQu2rV7HNn+TLaxFHZFC3alU
         N2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791248103; x=1791852903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pcCvTZJFLUHdSKFVu50rhTAVsHuaYlG7ZNshew9spyg=;
        b=D2IdoEpLm9XISRMDJGl4R6vvI9VILPK+w29ZV0huhOgGH5P4rl1LsB8AiovX8VX/DD
         6nQxf0/xe51zYk9SQ6NRhmuinpMHmH9Xl2LGBx6UvMxynHbZ7zrkDTAKjgIAQuBeFGzR
         lXGd/rUw/NMhvX14yaLta4zpThp63wzY1AwZ3njE/2jbmtT8BJaezHmcjosw/Hh+npIz
         kxo0Yr7VJTa/EGKBqaqKzdVVu4LrAhJAIn5eRknv3Hh5tCetFMl34xQJAQTL9Pv+lcdh
         0hCP8RWjYcwr/HcnNpp+7jL/SwVVDFJdhDi7LY0jp3s+CBc8J1BX1HhjY5phhAbQTHhq
         fMXA==
X-Forwarded-Encrypted: i=1; AKwUvByn4/3AlowtUBDtvRkxewL1+nrprManbgDCWNEpwEKudViEmAfkudX3LCtZRDbFmgJ4E0efXmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXyDuu0u5Rq74ohRcRll64fY/bKdWgclVIOUAf3kvxjULk5Zo4
	ZDQQL1FU3A6rzDbQTmnBUKpQHaEdc57hhwiAlSx1PoLvvzwOAtr04qVY+JjFy5ecJz2Ij/HGlDw
	4pp5wcwia7F/+k1t5Y5zCGn3QWI1dcLQ=
X-Gm-Gg: AYBFou1mRFE+KGCyr7eK8m2WIKI0zPMZ/n4/9HPQRWelG18Ve0WrK9YWR36mYj1nvVH
	CJmg8x11ncTJvZfzDl/biqBiLuitXBKqzo8pei2nNR8cZEjOYK8MVL7yVpw0SOKQuWqjiHTb/zW
	FQj2YVGBoGCy+29VYCuVtbRqw+NKaJg1mUaLwMAgOKFlTXz4ie7RyfL8URVHmQyijRpblhWjWqQ
	bXgciC56Iu7PRfPzws7Gk+/7vZR8wZ3yJL1I/MYbXlJRsHxANjy8A2QlbGSVeiJSf2qA3jXr+D2
	+W9rmQyBeYgnIUraCj1x6yP3DtpNhUNuVMWakoOnJ/wJUR/hsHmBUHBxS9dbQ//lLrATpTEcos8
	8CJM6RY+V+RCPk81VgCpMMmY=
X-Received: by 2002:a05:651c:a10e:10b0:3a6:48ab:7973 with SMTP id
 38308e7fff4ca-3a974f7c448mr16424921fa.26.1791248102355; Mon, 05 Oct 2026
 17:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-4-sigefriedhyy@gmail.com> <20261005164905.3d5b6749@kernel.org>
In-Reply-To: <20261005164905.3d5b6749@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 6 Oct 2026 09:54:52 +0900
X-Gm-Features: AclHuK_fRzWbaSoo1jAzXFCqAnGNXFcKoa-i0NxMDceG-eS6OpMe7FREJUP2sdo
Message-ID: <CA+7S2vL2n+XTZHoSyitmQy59tAnKjJvErvZw-PdKaMx4-Deq6w@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] net: add a generation counter for dev->mc changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > + dev->rx_mode_addr_cache.owner = dev;
>
> There's no need to set this?

No, only dev->mc is looked at. It was set for all the lists of a device
after Nicolas's comment on v7:

```
  There are several lists owned by a device (dev->dev_addrs, dev->uc,
  dev->mc, dev->rx_mode_addr_cache), the name 'owner' does not reflect
  that it is set only when the list is dev->mc.
  I wonder if the name should be changed or if __hw_addr_init() should
  be updated to always set owner when the list is owned by a device.
```

v10 takes the other option: the field becomes mc_dev, set for dev->mc
only.
