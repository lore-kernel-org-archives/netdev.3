Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646033;
	b=tSHuimzo1WjIygDeYVJKtv4xqgiVvkAzL9WGmMDZtFgQMbSm5WIbV5Z9fJ51w6Vgtn60
	 K/AeL95kRopQZDB6UAhGdekkn3jefifnzJNo1pHPvky/3egx6gOA5nNZUiBgfvvjhRG49
	 l/2G/dr3JBSJVYzaRNbCr5BDTWZC3xqnanoRqV0IQbKFk+9AomgR9cVAiYF3EEdGLWZVE
	 YvDn7zedKkjr6YoNUHySOhcg3OY7L0t6XD+6IK3yvPcD1pe2fsRPir5uDcoN0O+z7o1AM
	 A+AvFLrRoBao9ZiotErESJWPwIWxzwWQQVrmvGoNW9WVwCdyHIO7SWlKx8BpZuHdCfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tkR7rmZynmAHJXMcLex4vEvkupieVYXgHEkCQJIaK6Q=;
	b=jRaEE5DtQMUkyqV65hY1DQbPQ/SzZZpukospgKDlFi+hvnAOMVJJhNE1IlePnztmOlcq
	 McN06gHIineBxztdnZbxnnh56JEwuDdNoK2FdM+Wako+b9wdboIjuo7YYxCoaWqtlj0Lp
	 isDW3gZwQwSfjply/PtEFSMDDQeVh1/LgxcSGulX0COWeaswK22dH+c0XT842OW/TmzJS
	 ASSEYOuXLPx9/O6323G5HNsNHsTTzZz2akkfVCSaVIm9Iu0LcGRE9SZfDplACahE7VXcE
	 aLdO9V/oZLTyJUhMMYBGLH11CQ1/eA0uOsPyGbrfy69sivvtCDJ8M+FwTnN2LJDPJhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDO7JoLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E971606A332
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E971606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qDO7JoLt
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c418e215671so438836566b.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646009; cv=none;
        d=google.com; s=arc-20260327;
        b=UHJuNStKdJLwpvJdSBCXnqVPyJPh+X6yoYdazTA7eGTPO43bM/GFmj/QOGKjoEmEUa
         IpZVwc4xU8b3Qv6Tm6NA9YfdC5uCiknxx6JLv0kUoGiUx8I1YtoYN+LojQKVMZyLP2tF
         Vqggy2ftoKiC51sCgdup9KVf8N27Bf3T/BRTvocKijD3xsKAJ7RA7Q7xlRtaZzmc4yo1
         bcLnMy+lwqdBmiXx9/MCUxET+wSHUQSL2xjz352v6rnUnAl0+XbIsx6IFvJ/HODSS5Fz
         DLqCrNvgdABGYDraXG4UEJmTyntHEmarl4Tu003Jpn5nL7mduOcT+G5Qh0BT4QgEb9ts
         u+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tkR7rmZynmAHJXMcLex4vEvkupieVYXgHEkCQJIaK6Q=;
        fh=Nax1aqFcSN4mva/H6Ag3efp4opAwV8vKuVxp9+rG+KY=;
        b=dSZqewo5rqnaxX7eU7OveaDT6hpoHzfbae5Dw6xw8CWYrozjPQfXCogn/3hp4B7alh
         ge5EfbGDypMfzIk/ZVNjw/VPaXcufhK/F5hQnDR3osqGR7+UDemYyyD45rqdaTFn9dmm
         DgZ0fEPzDCB1sQAaWPLmjZuK5FmGakDyLtSzq4mSyf6hJ+x5lr/rUXUm6B4Q0a1YUq+w
         EWhsj12BPoKblg/h5j95tgrGCunri6CSuW4Xftfbb8bjzBPvbLW11b7AjNSNqA/6RDag
         KwVKdppGZdon4fwZqotoILpu71hTkl+2dD21Pyr1rQy+p/wuuEr1Ruz0a8fF9Hc1UBQ7
         o8pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646009; x=1794250809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tkR7rmZynmAHJXMcLex4vEvkupieVYXgHEkCQJIaK6Q=;
        b=qDO7JoLtcv7y/LIJQ5Si0iiTJTJ3Wg7UFZrVkKDDsgbXT7sDcUGcM/255v4T2uFQNQ
         DH4ATgBdhIO6uy1UBTaCxLyQhAoJBYgYbtMzG94/mnMensfZBG8e6SKsSKlUAZdnGrhO
         i6FUmA0qwRk5gwa7RUkGX6CTjz4fdrU+TgyiuKah2jTTAX2DKIlq10Frig4wtg/BJbe5
         B1sqqUM1Uw5N2YafSVrK4G30xVyaacxtIdxpoRm2qo2Dv6UDFho/32tA0FcqRjfJcwZJ
         lt08Zf3oaDSj9ee7ugJJMFDrVEuVvEWO/sF9MkFSgpuqiBNcHBAHlTbVbqTyFlkVvZAg
         /WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646009; x=1794250809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkR7rmZynmAHJXMcLex4vEvkupieVYXgHEkCQJIaK6Q=;
        b=gLVr7Xab+4CboAizT/rrCc5Ng4waAK5uMvJJCq4ipwl/78xNHJfgvLadHDOBJIBFdH
         rn43JIJENTL8HVwpqf1qVW8xVVdsC1TWWooRPAnC2gS6+hzUvICTQMKL+KzEY04jvoGy
         hfJZOYKLhM3WZtTQk7BYb10blzWubeQpFuOTZh6+ueJAEpSfHZbiEsE7/1an9fhasogB
         TLPJmnun3v/RQgX0A7I1I7J7wzVVvfxQ/siViAmeE0VToOknt11tzxQP2sXHByYgxPF0
         +X3odgcn8coQ39UJSMkeThrmyKtQHFtzYTLaqd/rM4xfZ8BKGs16lJ1FpVBQjt6DuyI6
         cIPg==
X-Forwarded-Encrypted: i=1; AKwUvBx3RLUASWU60EWNsYsApxJVbkOi/PP1M8cok+jUeEVg0CstdYzCm2+2zJvrh5WZZ1Tx+sbDqK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oanaEmhUuDX5JY5P5oiZ5Nt66nSqx7tvXKnU8AqlK4zTyamF4
	YHb21STePL9rva1Sc6lvbTCne4VMF7J0X4rw7qeXRf/vSaw256YcU7wlZhRqhS6Oj1QhdRuMo41
	wTHqUfeQexQBdfj4lHzL4DGMgh2Al5ZM=
X-Gm-Gg: AYBFou2wj1MNsEH9yAiNn7hjETfkH4FAZQYSqTHhEdCqmvWs4+hKWLjApTjY38x0C3b
	e0TYI4buL9/XfFfzqMXMI4Z3xkIguYiptPuzSUdbbtBf5znxpIdS0kXanKA+9FqML2LRt3gc9DW
	C4y+9CSglXx9JJeqhbAG7JTw7wSmN8ryIAgfHAv4W+x2HKk6O0MpdyIOh3aK9gDiPD65t5WP48+
	VNjZOKaEi20uRuP4tR5CWWcsZU+irCqz1fD+VZZjDAuqcvfGg/bokJrzdMXSTE7gEHZvY2+Qme0
	UDyml1UWyP6/fITtnqf38dxGt1f3ir640WwqNgFlycb9/yIchSZEJAWTBgd9PnPA4a1gy3P3kDM
	rsMjq7cgYagu4CiSbOyqkRWFBDokekeitST3z40quobdgC1K3ByJe+CbcXd/FTIOjcvgpAnLgy1
	FR+a421EYBlWzdzolBPDEw5dnGKTf7gNaxFzJXZuo0o1YlhrxL1E7NjSPdef8PzaCwJ2yCIINh2
	31Iu4/c1ki8R3tr
X-Received: by 2002:a17:906:ef0b:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c4ca7a878bamr957458866b.23.1793646008406; Mon, 02 Nov 2026
 11:00:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102023919.1472495-1-dave.seddon.ca@gmail.com> <77e3fd9d-f2fa-479f-bfb7-c129a4461023@lunn.ch>
In-Reply-To: <77e3fd9d-f2fa-479f-bfb7-c129a4461023@lunn.ch>
From: dave seddon <dave.seddon.ca@gmail.com>
Date: Mon, 2 Nov 2026 10:59:56 -0800
X-Gm-Features: AclHuK_0BSbkwenxG-6qHdpiLmN1rPEku-cq5lLKMLOBkbjFnGuWtQ3Ge0ApljQ
Message-ID: <CANypexTpKEp=xSgY2G2CD6VLEDn=pOx4_KuGPHB5uJoFxEAiAw@mail.gmail.com>
Subject: Re: [PATCH ethtool] netlink: require a value for hds-thresh and the
 TDR parameters
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org, 
	Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thanks Andrew. v2 splits it into two patches:

https://lore.kernel.org/netdev/20261102185122.1357927-1-dave.seddon.ca@gmai=
l.com/

Dave

On Mon, Nov 2, 2026 at 5:36=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Nov 01, 2026 at 06:39:19PM -0800, Dave Seddon wrote:
> > hds-thresh (-G) and first, last, step and pair (--cable-test-tdr) take
> > a value, but their parser entries leave min_argc at 0. Given as the
> > last word on the line, the value handler reads the NULL that ends argv
> > and the error message prints it:
> >
> >   # ethtool -G eth0 hds-thresh
> >   ethtool (-G): invalid value '(null)' for parameter 'hds-thresh'
> >   # ethtool --cable-test-tdr eth0 first 1 last
> >   ethtool (--cable-test-tdr): invalid value '(null)' for parameter 'las=
t'
> >
> > Set min_argc to 1, as every other value-taking parameter does, so the
> > parser reports the missing value itself:
> >
> >   # ethtool -G eth0 hds-thresh
> >   ethtool (-G): no value for parameter 'hds-thresh'
> >
> > Only the message changes: the exit status was already 1 and no request
> > was sent.
> >
> > Fixes: 66e5dcf295c0 ("ethtool: Add support for configuring hds-thresh")
> > Fixes: 9561db9b76f4 ("Add cable test TDR support")
>
> It would be better to have two patches, rather than one patch with two
> Fixes.
>
> The changes themselves look O.K.
>
>     Andrew



--=20
Regards,
Dave Seddon
+1 415 857 5102
