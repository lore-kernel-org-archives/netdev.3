Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977332;
	b=mw1mlzACbAT/J65MKr8y9pWi+DhCASYw3STPkdDeuldA2ZQ5khFrlhfxJQ2IZ3gbWSg0
	 +wH4D5ABhAP7jmrPRy9mdgJLGJRRAJ7t+xP/xSFMfER8LHpWwWukL2YQpwFGQX+JSZycm
	 ohxjIBKZB3vE6eg1pZEaaPOs6n5QlVvTvoX6OT8lDNh6i3YVBki5ao/A2w/mO8Wr02uZw
	 scz5jlI9JoqAvKPDR678MiFg0elHSttEvFzS/U0RfPM44Gw0fnIPtLJooceoW159vQ8HH
	 TYIQApjyarlzPrNU1/mfqXQdkTwSCGvubRvzQAcfF56YOdCdCGV9BQ1R/ClNnSh2+wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dOu/2NWQh9vClv6nK56jM5d5kc+2f+lGVJwuPSF4THs=;
	b=ONZ7Z3EucEHgkRU8ZP3mAPez79BbGNYLW3J+rvejTTl694TH2jqsAQJetjj33DYlcpcj
	 Up/+pqhWlxREovMdc+OT6xfQQTbrwri4srGp+aCNxXmmGO8I1XpOnuQcq7/TaQCnuZrku
	 owPLY05ockmSQGukecxyc0VcHJYB3IKfPc3JgAQS+JDHlIsaS5d3s0jqF2H/BaJ+eiQDz
	 XAm4/i60O7qhednluJDtUFn4VPmFAEllDmKY8e73MwbQ60DuiYyDBtlcy2ZZ7ZP//1zv1
	 OM/vfzq6EN4IUqjk2YbPQ6HeqWedbwPLeMapKF19nBoKvVCSwzqNhDySnqt8AaCz/Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x59N2/0/";
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DCF606A333
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DCF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x59N2/0/
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso209267a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793977330; x=1794582130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dOu/2NWQh9vClv6nK56jM5d5kc+2f+lGVJwuPSF4THs=;
        b=x59N2/0/oMt+6dPDxQNirfQ2nUsucWp2h6vVVnsSJJ83aTWE2kQxfOqOYNxiZ1m+04
         JxIRUw5yr+NYW7WhN/+NCYkRjsxPOvbvXQEwMcKot7TJ+6jjfSHqNhPJZe1KNtb9TSzq
         2CJ/0hJYXu70QlRjxwGh5D/+/zuJzT/kKtjnMih0Ttbu4B4Oj72ic816XCA2m1sj+Irz
         4MwkKw3p+Fjzu8Kfz6nxbCq9mUUxgz6zHbFxCzfJsDHF5usz/judR0U3C7rA3Rg4itzN
         CzmHWgNtKr/GKDMQtl1HPfEeE1hstK3uxxagu2c2IwmfIGO8c6WIuGO2xQU6+hhSdJgc
         d/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977330; x=1794582130;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOu/2NWQh9vClv6nK56jM5d5kc+2f+lGVJwuPSF4THs=;
        b=dn4ReoGd0dxFB4D6qga8o/HpOM94MFpw+Mfkzo0BlPR/HMrsCW2YVr6UlTIrWY2p3m
         aJS/1qvE5ySzSJML4NFYDTcj4e2nyhnrGj10hT3v9s3oyLoD9iRmWrRFKuSNnuZo2Biw
         UPtr5KdHAIe6JjaquBpVB1fi5AVBLhhK4TEeIJ+tg9k5n3dq5j/qC8xuAiCGkKXUcrsf
         wMv3EsYdsgJLNvi0uxRmSnSZCEm1av9fxmTTDal/7oC6SU/xhPaiw/lYcLgJp0PcT+GO
         OR44KLX0ktGmQomvSs63xo60s68hcwQVIbxkoJtlFnh7EFFTfXSEjgpQEXj14Kz4LVmD
         6Vpw==
X-Gm-Message-State: APuU4Z8YVDRe8O26GlY+Mp+OdfKDpqvPgfJlL2zF6fwcdZDy9lV+VSNK
	NO0sTxk6Ogg12RqD8ebEoYIyYZokeOqgrzQeN1koiTrPuN6TZHAHx3G0
X-Gm-Gg: AYBFou1QIycJtOl6jiz6Jl0Xx5RIDUREoLKtyKT8VhlPRMwuqL5D4jPGMdt0sLceTM1
	4IkjQLb3DL5/ZpGQlGe7jhCY8K+gHpzfI3efm9bX/YuTmk9CiSLSP2rr+IFd44FA4FXY0v6eGmw
	VUmAP8vkl+g4RxRavswqGFUluwVrdu0bxdZWBygbjHjTWK6QGTlv7oLhdhUjw1Vaow/c9mHT4Xd
	1WzuAzl3PqmnBbm7ZGAAaHyf0dEfovCGeHzWYPM9GwRmlkBPbnDMbhg4wdcN8B21fITqJAw3kzj
	BS1aVTSqgSXspXmskzlxtZG/JRKD/VGzOeCwsfEwTDKnQpZNScijDk4xwk7R9NHgvONWyj0TIep
	Y+qFXptT/8Hf9j59GMN+aXog8cWIQP+Bf4AV6Y3l1kLy/8eZCRSwLZfLvNv63mrMfZ1FeRbQb0X
	YgDz9MrTi0hB9jz5JiHark0TVarKrqxybT0/owsc5ErAzcI4I8n0UxNFGFmJS8Q/7blyI3GAxAu
	+BksaVp+jmLSD4B2sf4dWBwH1bxpza4sOnxK0cmx7IJXbMRSspqSA1NfypEE6XxRGpLIngO8zxl
	49nBO6skNPZj5IE7lUtmPMlGwVnn5QWX/6vM4S8t9mL89GygHSK/tL8FjSw2f0X3XdEhxwflDvf
	AtnZSlbSJJ1jXX0loR523fx9Xn2rtqssFQX/tkTAw73uEjtMM7aZ1j58kqmArMqyBSmrHNRI3KF
	BKaTiTHLZ/i16CXzpRgO4O6A==
X-Received: by 2002:a17:907:60d0:b0:c40:19dc:a248 with SMTP id a640c23a62f3a-c4d34a63f06mr254682266b.15.1793977329694;
        Fri, 06 Nov 2026 07:02:09 -0800 (PST)
Received: from desktop.home.arpa (2a02-1810-1e16-ac80-898e-1938-27eb-b890.ip6.access.telenet.be. [2a02:1810:1e16:ac80:898e:1938:27eb:b890])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3567142fsm86109766b.34.2026.11.06.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:09 -0800 (PST)
From: Stijn Cleynhens <stijncleynhens@gmail.com>
To: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: netdev@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
Date: Fri,  6 Nov 2026 16:01:24 +0100
Message-ID: <20261106150124.3630781-1-stijncleynhens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <autLlP81HFeMyICc@analog.com>
References: <autLlP81HFeMyICc@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 04, 2026 at 04:22:58PM +0100, Alvin Šipraga wrote:
> Yes, all this makes sense. I actually remember doing basically the same
> thing back when I was working on this, but it seems not to have survived
> the final work by Luiz. It would be good to get his input on why.

Luiz, do you remember a reason the IVL setup of VID 0 was dropped? I
could not find one, and the switch only matches the driver's VID 0
entries with it.

> So I'm not sure I like this function being added to the vlan.c
> library. Semantically it makes more sense to me for the main.c driver to
> actually call rtl8365mb_vlan4k_port_add() for each port, so as to
> explicitly say: "all ports are, one way or another, members of this
> neutral VLAN". Then you would get IVL automatically.

I kept it out of rtl8365mb_vlan_4k_port_add() on purpose: making every
port a member of VID 0 also sets the member mask, which the ingress
filter of a VLAN-aware port then checks. I only wanted to change the
learning mode, not which frames a filtering port accepts.

> Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

Thanks!

Stijn
