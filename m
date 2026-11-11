Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439075;
	b=ifqW6jOtalHA4ZDquTq81ax1U4yK5ZrCpTKWSMJ69FYD1bfWwvKpdkKnfCFsZ/aBaGVU
	 yCaShJqi0GUeC/Fke0TvZHLKuXIg4+LkH20eXN5qCJYfsVeoysIjSBjzChQ6WgPd5c1RJ
	 GQKxZPLcgIG/eZko6fjr5KyJM+ec0/CUF76McM1eQp+YkZrvTVgzFgwAiwE99lhMljqk8
	 MhxQSok3S9zz0CAbQI4OU5zUhv4+58emb1oVR/2vKJuqOsO7dtOQDpShFK4xoY239fKdT
	 xCV/AsEnSLPNfetCkj1qGoqlRfHQsIs2YMisShVEIpwYIt4c1YgMRO2j0AqcRVbj2iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439075;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=TJD/l2dgN60lOdRp5Ktchuk3+SNhKEQ8u28wOrvBKgY=;
	b=CJrpRYg9r7LJPJQA5Rb9ZPFWjoSn8SvFMEFt8JKTPIu9fRLs2UUn0WElKhPn2HWMQSx/
	 Ufy51UvJXlWIbxnu7wYOv7gG4PjjxZeCGyt6BHiKfRbt6WlOHgK+29/Skx5gLdfipNLJH
	 Yc2pfsJWfr9dNpxC+53qFUo0pKNQq6SMwpdi3YMSMlg+GxSfRPC56VAW/rGB4FN8KxB+s
	 CaF05nKq0yhoIePg+S6ldALfFeZGyEzaoOe0A9wizbE05GSeAmzWj2AwASZfpKoNVcLAE
	 U0S7aHhOx3g1EzFYHkDZYNgs0xJGzUvLrmFqPf0jbAeNnNWdZbIkE5PlbVELIARHKLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384F606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0384F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1886559a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439074; x=1795043874;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TJD/l2dgN60lOdRp5Ktchuk3+SNhKEQ8u28wOrvBKgY=;
        b=rDukwyDO3/K21zwuKItiR3Ck2knr487yy2qwaNu96SbrIrsoiQ0p2Yw9p6+KhKuG/a
         jrRuggJf9kRLr+6wx8IdZKjGX1C+B/SWKqZzM+BC7bRCDDjPAoEfcC9pHPt8niWwnpNe
         PLOyNOaWb2vLD0P8fCkZM9sKDvO31S7dgqK0bL6lFUhkbzTnlYizNC77dy+dPmxgkxPO
         hnmTCnZxdgO9zgU8TjR03vb2eZCEhxUC7tfQcAKTMfDh8lueCZ0tYr6OLcknXFYAw/ne
         lr55JRT5tnZDG12Q8tr3xcP4zGdDfayvqCpd78iV5b8h4gyZwUEjbQkHH1Gct0su/iQ7
         E93w==
X-Forwarded-Encrypted: i=1; AL+hErFtRpydrB6e9J2VliLqq8Jca63tb+KGcH9LJ+c23fN2SbQU9wBr1wUkMFIU6rOAEeIUf7R2wM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+95Hc728KKuiwZEYddhi9T25QZgLiOOBUDTw32PAwm5Wn1bJIn
	YfX3MPY3pkgfcATyn7UWDcJW0VNAxb7x3+3o0Al++bt0iTcpWDmW/ajVjga0Hx35
X-Gm-Gg: AYBFou2/mkMkSR58unmfPoyry9tSVgrL7rx50bRRHS1RML2W+uUkx4O3q2eHbNXOh5R
	XDjsmQOTVmBt+9Jj2Z7ypbZ/RMAMjQGs9GqrpNgapYHTI9+sJSAb+er2llKvk6xorIpG5tqILf9
	PoWDhIjYk+3z1w7AEXu1W/bVygx4rr1JEpPn54C+KOU6sthT54V4QmnE+Pfcudo/5YKkkqAZ3rZ
	ybhk1icxjmG6ez/x7apEAp4HpGxB9dk7Hc+SeIGa6mPstNnt6ULhupGiA2gIzqe3353utB+5SZR
	RwbiLqTCX0B/YGmgIJviUb+TzzQG7EvnC5Ee1fwEysA8jn42CgXd9f/pJDx8hzXxrFcATefzVS7
	zfPKbHvpeipVUGzMlTFTIjqSV2Kuv6BsUKPNsJ279HeI2mReMFr3Sz2CNHYcZn2WQ4vHnqp78L1
	dCJN6e0EcNFPDiW4M7dRZeNT1c6DtJ4Kshulw1CWhvhMvcKYwPCYTgS1byJV8hqY9rcZzVSnUuC
	OhnjIORkdlnXxyS3wgcEj3rK4hY2KlftFRe/pgjNQX/eVqXdUWY1liN+auaGl6aIbHs8FZFKj0W
	vYMe2IBN1gu0EetJ6hV5qPlPACckpRUEEMsbLfAi3U4c/nv0QNLwruwniUTzMzbKA1gLb1yJb/r
	dnGlQ96l9uz8QMHkxLqLdTSaV/1LJXcnc1d9WIyhrmkXA
X-Received: by 2002:a17:90b:58cd:b0:3b0:ce1c:e754 with SMTP id 98e67ed59e1d1-3b182f2382bmr4087639a91.62.1794439074156;
        Wed, 11 Nov 2026 15:17:54 -0800 (PST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com. [74.125.82.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181bc799csm2897083a91.0.2026.11.11.15.17.53
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 15:17:53 -0800 (PST)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so7176799eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:17:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGCxHTBid69TkeLUBn7sRdLCDMuePUSMEdRi4AT+OB1+TWPy7mVyB7AunVYVHKmWfmZFgYqh7Q=@vger.kernel.org
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id
 5a478bee46e88-376861801e9mr5815346eec.20.1794439072759; Wed, 11 Nov 2026
 15:17:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-b53-bpdu-mirror-v1-1-f9f32e9d25db@telaak.dev>
 <CAOiHx=kTUBtFVgFhNqGhP135CdUmK8imCE_+pdk7qsdZKMqByQ@mail.gmail.com>
 <52c38c53-7806-48c7-a0a4-9e1aa40cc55e@broadcom.com> <CAOiHx==VFEgLf5Zs+VGYdhdsznSwTz-8Hp_aAF6UuGnKT-4=fA@mail.gmail.com>
In-Reply-To: <CAOiHx==VFEgLf5Zs+VGYdhdsznSwTz-8Hp_aAF6UuGnKT-4=fA@mail.gmail.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 11 Nov 2026 18:17:41 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ5eHpzoYdZZud7sjhjYhCEko2qp9hpLFHRr1Wcdb8ps4A@mail.gmail.com>
X-Gm-Features: AclHuK-EGy-sXJ-AuLMUcM56eR3CiFTSuahQBNsyhRLIPXPLjQHiN1ydrRXpFso
Message-ID: <CAPY4CJ5eHpzoYdZZud7sjhjYhCEko2qp9hpLFHRr1Wcdb8ps4A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: b53: mirror BPDUs to CPU port 5 when
 port 8 is not a CPU port
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > We could also try to use the CFP to perform a full redirection to port 8.
>
> CFP isn't supported in all bcm531x5 chip variants. E.g BCM53115M and
> BCM53125 do, wile BCM53115S and BCM53125S don't. And likely the
> presumably lower cost S variants will be found most (at least the
> board I use for testing has one).
>
> So we could at most use it as an alternative path where supported to
> free up mirroring. Checking if we have CFP can be done via the Bonding
> Pad Status Register.

The CFP redirect would be a nice fit where it exists, since it leaves
the mirror free for tc. This board has a BCM53125M, so I can try it
there. For v2 I'd start with the mirrors, since they work on both
variants, and add the CFP path for the M parts as a follow-up if you
think it's worth it.

Joseph
