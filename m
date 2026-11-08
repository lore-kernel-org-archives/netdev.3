Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794118092;
	b=vZeLyjvSiCMJo0inYqkoVlWHA9bD61a7vUY0gOfgQSEgXQh+BdHm50pTwsUbvf9hEQwI
	 TCfWPCi4K7NoUDzh3SfU2fY/CjkRdXwM7gYyC6O7lfZh0Dyny9gBeIF3Ekaw8I1Rizs4S
	 wX5Var45t7xK36w9fxgwfa17kQ9I2OyqMeBmPyLZTsjaW5RKYZ1E7yBND6EQRx2FM272D
	 t2CE6xPSd7qq3p/3fmfUF4kIZRVeTYEPPCjCmyA9IIvzDeDgNhTpQWNkMwyfgrKNa0auE
	 nGu8RZ/jeq8WPlSJmPdLnYSKm4kJG5vvBs7ugCGZuGmNb6YhuSS2SZ6fbLjb98leljg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794118092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=h5oxcX+E/dx5EGmHppwh/qaFc5/IklfAboUOQh2Ctv8=;
	b=42fu8gWz6CT2Keg2R8Sz8Etv7f6X/sQKzeQmbcyrCy99w/k8lpmXK3j9F7yzmHzff0ke
	 y4XQU27zQ2tpu6CxKgMIflDYem+emFgB5N9UidnuODLDCcZdDSb4mXIn9lYNX3I9qW/F/
	 qYnUV8Hir4w5mbpnj7ouFzVKQM51hOzbbAx8z30zkpL4al3haT8pmITIV/CAzgvsAGtFe
	 lpA2Zt93CZvRhwFdSCUe4OKPIrvUJvpEAQp73Xg+EekWBnuhYh0A9O4WUGJ8gFzQzls+n
	 fuBGKt2nVTRkFpiKUntPbgMx3jDAcX8hFNMB52Ds5iB8AkyTO3Fgf2Zh3VpXaftVzYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vK5DnDmv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37B606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE37B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vK5DnDmv
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so154535b6e.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794118091; cv=none;
        d=google.com; s=arc-20260327;
        b=OQapFlXdagojInebvdDFSARb2IXcSTnBC8p6WqHzaYgFaLS0kKBILTal+Rkxgx/XdH
         YQDly6AjNgKNIuGCdo0nj07oF4WY/vuFzjRzM1dR+a/+eznePDVDSTWmCKUUoEDORjAI
         AnK5eKItRwwvQhu4eEsxzVdugefYLQfYy98jm1RIbVd88Dg6jJfJ11tv1QGHrZdoIPD8
         Gj9G1iIbdsKS48HHUZKVQbE9LXZtM5+sIUP2LC1P76eY5TmNi0LtwCigNcPLKyIDh0SG
         BTQiRK6VdupKd3oHTuq5ohWW2w+V6crULrFzh+YzCYq8Be1s13EehfEeqXvaWD8dbdOW
         U10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h5oxcX+E/dx5EGmHppwh/qaFc5/IklfAboUOQh2Ctv8=;
        fh=YGPmnbT5iHb84eZ/YeHcCo1+/rX48SlK194wGLbQIU0=;
        b=hfWSq/pvZptjxo8W9X4o+efddWn4LUTQTmU+Vd7p1QcwJx8nabYYV6gcM7VHZstWnn
         pr+jyNSO5LEVbEV1HdBfWePCxvMkL7PCs76j3NGdJx0kL37iPXWk0xCAOlrmgvx9Np7a
         lHfzrNbgbiwQYBh0xAyP7KUpWGMI0Tybayd9ZdFpRtE/4RdiHZKwGgLOr+Mp/MQUi27d
         /I1b4kn1LUWWHoZvdEOB9bYOkpUy4E3Z26kz212MhUEghePrLmJvoOjenaNjZ6d7n7NS
         zbNoeXgmtPDg8B/pxpN9t0QPQVyI0OcFPsKqV23/bY/int2sCW/kukUsaExBQRtCCQDK
         vugg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794118091; x=1794722891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h5oxcX+E/dx5EGmHppwh/qaFc5/IklfAboUOQh2Ctv8=;
        b=vK5DnDmvw/E23FNxx7ig97q9qw/XmUSyLzu9Ql9lsqcBxgh1nE/n0PKcjT/l/11Jc6
         NWb3hm8ltUU7VaxchOJvXHtx8Q94+THtG8kfxg3PURy3bvim+rIO0m9eOEf9JwEq+Q5f
         oaHGDHXkzdizDCcx/+5JBoJA2/L6e6N6jpNHALSL7Mt54d37fqMGaz/EboXTGe39LprV
         1gY+56w7i4BD4Ykvqlb7bD2QBBLoVNK1UX4N7qstg4uJY68hoNI46G3vNE8xgkFdTU1F
         TQ3bIbXRPTJtGCDrvSpm/kN1NE4C7GOodtSTQSJ4ov4wrM0lIwjWBn06C4bq9+lg+EWJ
         4IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794118091; x=1794722891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5oxcX+E/dx5EGmHppwh/qaFc5/IklfAboUOQh2Ctv8=;
        b=GLnMo0ZmI05AohMR9iexuzre0p2UcAgAhmHMlQa7bsL2UPAC+5RsKmOJbL+6HcwI3Z
         dY+ylVVKh+6ReX1r1DCeNfGXInEf/DWBiEe4KeXAvmtNAB9jDq/Q84Oylm0wKfODkCcJ
         dKio/UDGEMFCoQ8ffDdx0Wv6RlQc0ZvmvKbq98cAIE5EulwCVsABr9kdlnBeb51sag2G
         Y5nChF3wcM+oemoqRBWovGeKQsczrI6haoO/KdvxT258mpsLX3oympJW9hnlrU0aL3py
         I2pYu6SCHbAqyCzKNOr2EeAWna3IxWTQ5Jo8Ed6WVXsCS6RUdCk8YWygXQjsPnW3u53n
         zHtg==
X-Gm-Message-State: APuU4Z9BjAP62m4PBtTK4QTb+N8LvjtWxbYidasMxj9Y60cpolIIMT8Y
	CbInAU79reUb11ijrshTtAaSvMFAwmbD904PnyvzE6P/iIVuMtcFP0q8JosrXGMEiN1NViBZbGC
	MRobb58UxItpj83z11RPIoIBahpLVf3c=
X-Gm-Gg: AYBFou1FTDphDqqWb2kdcbASLrbAjiI49O5uJx8p00yxms65Y5MeP/wpekwzxFoHSS+
	JIsvxboq0ERk5ARScjht2LMG+y/V7DxFWkpzIpxAZzs1Q2DqVtN3pD3byh7EqzsUrdnXCj8eXEF
	509Uacg+1FyzHFHItvGg/jd2ScS68HtBJpJgjv0yA5FbeyYuex2jgL9T1puqtA72Svm2AMejsFl
	kFQl3vG8D9xFDYXRnAT12tZSpdaI4lPNuGMpqgmzLzbG1EE1DeSDxuT0G5joPTLKHrbVYVfz0Le
	csIE3rKYUqBSujI5nBmVUZ/BVVjKAm5Y76ySycYpVQy/ZRvSof05QgdvPoxT7Dc8MQcJ1l6VmYv
	giySi6WgaDDoqv+FOtUVD9s2cfPfzgX+Auwf4twntGs9G71WvcU6mxM/H5fv2l0WVLDKqib8=
X-Received: by 2002:a05:6808:1302:b0:4fb:ac9b:b06a with SMTP id
 5614622812f47-568143e3ef4mr388887b6e.48.1794118090754; Sat, 07 Nov 2026
 22:08:10 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107015447.335056-1-mmyangfl@gmail.com> <91357461-8056-4b1d-a06e-6f1db5eeaaa4@lunn.ch>
In-Reply-To: <91357461-8056-4b1d-a06e-6f1db5eeaaa4@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Sun, 8 Nov 2026 14:07:34 +0800
X-Gm-Features: AclHuK-iIhfgJh2-Aw5nKIdYB9WRNWrXQisMuyKiYZUjofkpUZpqI58wFbD3YH4
Message-ID: <CAAXyoMOwtQB01SFo+o2UPZZtw3Dhkpq94h8N55ZEas81z6VWUA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 1:26=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     if (res) {
> > +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats fo=
r",
> > +                     port, res);
>
> Please don't break strings like that. The reason we allow lines with
> strings to be longer than 80 is because somebody is likely to grep the
> error message in the code to find out why it is being printed.
>
> grep -r "Failed to read stats for" is not going to match.
>
>     Andrew
>
> ---
> pw-bot: cr

Hmm that would be more than a pure code movement...
