Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333825;
	b=epVI/kj9uujZcJQIqKRFsvoiDUyhHqszVxpHFNPycCMXdolyx/SC0qni1eUiHrsUNsjI
	 iGImtXX8nNe0wcrEITbb3bEyCu98Zy09RMqrS/ZDvrGu8nvtCs9isaM9PE8hWhqKcmnoc
	 azwWmI8XxTGu4IYjRm7fhcTa1vyp97Pf1eqDG1ignAJfJ9yZIyr5v9lahjqoRMOXhZ6SF
	 WmZ/rP4uCSQGamQQ8lQ/GioN+pDYzlo+I6h5OZUgzg9M7adJsvZlBLP90OfAnzg2nKGp/
	 gRv98LxMQ101bP/y6C5fdmDyKKMWurQVwpJQDwQRJwaCXPnESGhvZ5d0kU/Fui2C+TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lzQJ9a5l1BTcj++f5PsFJW71LnXsNyCRLPczNlEpe/8=;
	b=3wBW0Q0p0S6dmhFb8YNwLMMVn7C9S0SiGy0XcpDOGuyKT2YmXxMc/kgBsKmvppoxi1Wi
	 3Fz/0iiVM+1gVieeHqDDDflAvz6sboCG3dVsB6v6I4XxcVKv52aD/BLpAyIi87WVEndha
	 sVDVpdKGUASlo8J4z1ctAGU8b5lpATp2HxBxkm8tutRPt9kU7DbB7kIDTl+mC8CwiEIQp
	 /QNl+3OSmlH+8fzyJ2GnUiDmz/A7g08dD17CVztN1jcyOrK3kbrAyy5xn37F+e/YIxA2V
	 JwEv9+AJiry9pFhVf9Plg7gKgZCPu6qjnxyb7CI5js0GBbZqk/oE9hUGuc3LYRyB8Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=ZZwI4IJ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2D60A2603
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D2D60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20261015.g header.b=ZZwI4IJ4
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3fd91337baso402136966b.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333823; cv=none;
        d=google.com; s=arc-20260327;
        b=O++4H2dVx5BrBZJIH0oXvHjhdJ5rpLbQ6nT0H9J90u6rhKSUn16JpOnOY20EGLhQb1
         zmaWa1cc6olKFGeBH5PdbOZ6+UbcjlwUgde7whNw8nPcNi1yaNX0bzOB/9bJOurr0BqO
         w1q1iSqYli8ntA3ZxZPQpymNNExHQnKdHfg9YRiQVSo4FuPwC7A2Ff7YHMWCP7SH2Igu
         RH3aXu7lehgk5TZEYzFXf1Ibbm7d8gOE5e3/buHflKuwQbFm+6QI7K61A3mEOmhO2gts
         pBGurDGscRdMNJ9/6jwfozv7AK5mtoJPbWz6nFgLhSSLrm58jgpzR+j7LE8/4p0I4PAi
         RNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lzQJ9a5l1BTcj++f5PsFJW71LnXsNyCRLPczNlEpe/8=;
        fh=OaDPX8GTRHxxT9DjwMHl4uk768Kgpmqi+xL+Z069/b4=;
        b=qkHijC6vzvzR8jXWLtuBETOqFocioo/w5g3TstMdgkC75a6vj08Pv8znSNVq4FAgrc
         nqInrJWLNj2WWbbksN3jjAmVifhwd5L0IOyWfK+WNSnm7sy7TVBC+8sU8np1czBGA1Pp
         ey/yqX5JzFGlP+ppvFSFBNpvpPLaj3l0ZRdB8U8WtI36Lx/aMZcDkNsFdvYirdl22o8U
         2q3UwZN7jeEG1++pYRrdVMZM+/Ek52ejcY2Fxo1G942isgtz3c3gA6Ou5+DjeaRU81Bt
         iUqyobGsUrmRLVyrHbN9qSQ4siKD2zmPwkfp4rnN+Eocb+x9/UBUKrpmV8Fx1kVU/x6U
         6+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zx2c4.com; s=20261015.g; t=1794333823; x=1794938623; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzQJ9a5l1BTcj++f5PsFJW71LnXsNyCRLPczNlEpe/8=;
        b=ZZwI4IJ4aWISIef8lRAv4poXLLKPrWVwkiSlfKdjw5uD/OJZPi3I4FfAXubc1YYgEM
         dG9fkB5ccMhfA4JUCMy2eTh9GuC7Tx8LJ1E1hSOA9RbdAouOvwK5RYoO9IS5x2DQQMDG
         0FqW3ro9FawL6Aff9EKxS7ba2Bya25ZKhy7AOUmbgY1+jtEVGAC3HzhvQ1EBpUxvNTjy
         j5yEmy3iFmLDPVFrUmj7iEU227OLSTYFTeYU5zk4H8m6bor/08jDLO78AkEBenZgkMSc
         tkJf75SNJ2esk6+aHMIfzTz95Fl36/N3emySc2sfrt0HiQnByO/CbOrEjYJDM+XTZEhP
         8GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333823; x=1794938623;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lzQJ9a5l1BTcj++f5PsFJW71LnXsNyCRLPczNlEpe/8=;
        b=in7EacO7ZE7wL8PRgA47YCXDSFgSuJ6R9a6vI9DwLSbbkdNCyPKPyeORTUByi1LO3c
         xLUeUW42wtAnVnmI1bOPMISeG8Clyyws3hNPe1ANTNh/YZ7OAZnYvsDHfWTwus0uQjaR
         Oyfabl5WmOpGJ16p3enLvxX5vyJ3edCM+3GUAgQ//CzfhZbnlZC2ecUTZVvo+7ckHgpV
         rDhXjg0B7QlgIYJ7hecApOq+ZqbHajimVY6QY6JhTpr9qOel4kZFJP//tRUdsnfGboUN
         VdUPIGe9PNx55DC69PyaLyoeziSsp+HSr2sWs/rVNp4ISKy6KEwi9d29669zdrnW78R3
         2RmQ==
X-Forwarded-Encrypted: i=1; AL+hErGK4QPOWAH1WkCh1Bun6YPD7n8+u1ov1q31A8Wb8yGXxDeFtJ0DbTl1NaBbRtBLO4fkcQtNH4s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8OqJ/QH9OC2oDmigXcufIYdL9pToFEnxd8os6fwmQSApiwBkX
	jN/NtHT5BNGJUs/1F0uAg2qcxaOWdt0Ey6zcIo4IdmHGXnaLupQzWjBGENEaobNqrdPsCkaHp1x
	y8NaOP6PZALQD2OOQjkU9rpT1+QJDPbkpHxG+EbDohxU=
X-Gm-Gg: AYBFou0vDi2x25cBd2M64ea4muykMGzraYUyNBRiD6VCFLFjJbPg1URAYAfEjUidyXc
	TvteKkzaL4eC0wlQUUs9/x/F+ECyhmX/TX76eA4cgOeSMcLIodTeRabfYC62j2cQwjhB+T4HNGA
	WB5h+PqPzZcaEr7V2A+0ZYSEH3wzFJoFPT9Z7rpwXk68JGcWbmXCndN4tQlj5h6tbfus04PO147
	MI3UWtl/2vlQPsw3IYTeQ0dppIjuYY6AVOEd+qbReARlfgRDu0n5U1SBOTjtWjIYtAWmvNNUELg
	eWpdMuPiQAKLA74NiudW9HVPDnOuC2BfWrZW4FeswSxZEtRX/o7nl23YtJIsmZsA3YBDkV2NuTA
	SAiiLGr29TIcIRmFlHbgKow8c8k9OFNX+ODhneXXg8a/A58gsYZEbwPSF8bfEoQLd/U3HSqDGlK
	QuKavnCyPj9RBiLXzblSCKRlUOY88nnUE00HdMdLISfCYeMX8T4Hf9Yhin4FnKe4vUM7QGUgQEW
	zxRO9o36suBe+sqLJ/D+t8TXQ==
X-Received: by 2002:a17:907:c0a:b0:c42:3a77:80e5 with SMTP id
 a640c23a62f3a-c5049583e86mr302817566b.29.1794333822814; Tue, 10 Nov 2026
 10:03:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <116cec552f58748d434d4825c6c74f39266b265f.camel@infradead.org>
 <avNCdbpjxM752XSw@zx2c4.com> <89b5e08e2a48c33be4cf2d495266d04a2dcf406e.camel@infradead.org>
 <CAHmME9pWbftSmnJgLawNmWxNHMEqC5evxWPW8TruYkBD18Q8nQ@mail.gmail.com>
In-Reply-To: <CAHmME9pWbftSmnJgLawNmWxNHMEqC5evxWPW8TruYkBD18Q8nQ@mail.gmail.com>
From: "Jason A. Donenfeld" <jason@zx2c4.com>
Date: Tue, 10 Nov 2026 19:03:31 +0100
X-Gm-Features: AclHuK_PdK0XHi04omXe90eJidcgcAUUNUP4KnWXn-FWg3xkjBKoqqaRiccjqWc
Message-ID: <CAHmME9ow3N6soH+WwW+MZsDG9VeKW5WK4dYA6k29Cxi7UQtkYg@mail.gmail.com>
Subject: Re: [PATCH] wireguard: socket: fix sticky source address on p2p
To: David Woodhouse <dwmw2@infradead.org>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S.Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Antonio Quartulli <antonio@openvpn.net>, Ralf Lici <ralf@mandelbit.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

https://git.zx2c4.com/wireguard-linux/commit/?id=6d02c757940afc798e0eb294108262c3e55b1c5d
