Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478501;
	b=baVS32j2tB3bk/a0NYkyxZbTujQ8xwDFs1vJWJLVRTU1Kk3HYSuDw8sYvEyGQDT+bTFm
	 aZG88hZazhp6hX4vZUgwcAJ+wK+lFEfPYl7yqVGAJARiGOR5en8VIk+D20capJGf8qq82
	 ceRnVhKZc43+wbxMgDupDXV7OOkylEC+bErrQaluGrcQD6s0nJWLYmrkPusgX9drVrEw3
	 F0lXZKz9al1SalCC7B63/bGscGkzX9j+eyBR1a0Z2BxLZKx1qj2/573L5LNPl2lm9Mhz6
	 h7y/vMF+K3A0CzVoUjpB7mx6Ter+nWE5t728pVAE/hzi6soyscLt7KzuQFNWL/zNMwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
	b=wwqSUTIO8NEZtJqaTD/OKlbw84XvK+pmyvmApKZGDxpJFgZSDyKnpo7J3nasxn0VX61r
	 BjwY3luAhvwFEQVwnHN6YcPojXowp3m48XkgGNz8vMXxrOWvPGLBxjfOz/WQfvO8T8mzD
	 oKq6nwfVLVznTBATafbPTXo1do2zGFpcroCJfHbNN7EMrLmVvWkioft9O5jT8FVnx8dDR
	 IUsi7TsRgKkSBRCxMZeO3N8sBjN3d4MrQkaL2pCz/jbOOa2kwzRuGbwF5b4Vd9YlVASoI
	 zCtQ7LNMBlVqlZfYaHWLJwzClfrF26PXvHLy6e42Q2zPtl3S8nHzYsVeseeFfRlNlzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgcoAzY;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA87606A8A5
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA87606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSgcoAzY
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6393165e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478499; x=1795083299; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
        b=TSgcoAzYSBGKg8YleqBq0oSirYkeMKTSHAk1fuGI/Ma6xKCokSaxTddLnZLIf3yuXx
         MfbwAaoioEP2GFhBmnxpxlLvy2093taK53Rc/Ndf0mkW2go13gq19PpZ/mKNDzTXGxvf
         5f4W15IQdBuZC7xcEYGhjGFVUnI8W4pmq7CqHcuhDrfuDbYZCX9FxZsDzj3f7/1uF6kN
         0MVvnQ/Sisk0L+854rFAY8WF7iV+6F6LhC+BYrwynW95cItJOPimtlpJK5r1PrDxDzVd
         iPwJWJFozgVKMIHJhBHlmqYl8WATj1y72ZfvRJzgcZwzkZ15q4x8yqCBje+rNX39FKqB
         sj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478499; x=1795083299;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihVUDcggHZh6D0xYhZJc42bMgYps+7jjufAK/stHqbo=;
        b=aZPl1OnXAsVVwlvGOY0GeV/YAs5gXrlnNqQajSW24T3ugQAwzwUKVovEZ0sTqaEk+d
         AD+TGtcxBHJtrk2W7G9oUohOJegx+tdaxxdq0+jHS7vorKwOoq4GpeTT6BRCgF5skV6f
         YLLWx0K3JI1izH8yeHEaqY0Ft/4ImmpoUJbJI0N+RIY9P28CLZN0sSSad/osaRhhDR2e
         DLPzcRiW24eEWNi36Gty60aZmvKisAYS/x678fwX+sSV2jdVFRtG2fqfCjO42iHfjI0y
         SJFoE3SKgVfgx5W1sTeF1D0ZVrOayXZT0VfwuuGrhtMy47ChVUIhb477aGLDMqq/x3H4
         kD3g==
X-Forwarded-Encrypted: i=1; AL+hErEAuE4tSC3WUIGwThhkWzb1KA2M6gAeoZ2X07jfT7G8XACUpUFCKDN534ytL/ZY4cr9FUgO6HE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Dz1eoMEPPn+bSd5uODztXAindvfp+Ii3vkxFmiTc5lXcsCbd6
	i1MFTuPML7SpRKPbXf1JJOf19LSME0zJVMmVdKiiUJn+cISHzXAkT5/x
X-Gm-Gg: AYBFou3E8G7+OajZmzlP588knqNrFGGdJcs8QqqISAkaNVebzkj3TObP+rMBLjek0Uu
	0LUzuKzhU0tmBfr7yQhU0YUWYxbkXKhU4IQLK8KhZx3/qVdwabQ6bdqV1PeJMftp8ncqxDd2x07
	LylqVj8ujwbdZpxzU2msg1WXikHntdU3IXLi7cUnUD8p0NffbaWq7UWrjArIddQstgyQTuQx8Pn
	QASqvadZw2OyAPvY5CDsiAb6PB3KoeIDMDQDlkJXiOOq/5hWW1RoCj2ZfxjlXCbU7Up1HRZsqpG
	Fvu12p4LDXHo6shZFrZJ/P+0j+ElfTl21L6AmqKxpAeb6r/usxaBXvPPIEcME1KFZ7RP6OJ7NCa
	GayknYwvajnCisZyg0zILTDBhKa4ZMGVUSCBG/SYSgxc7OJ37yj/Rg54jkC64T+58Gq2HL5bQ8S
	RUIcNTfkUb4QLy/Nyhw98wixv8pfwdLxlHlS1DJXC2J4885ZFn5YFziEXfqakAFokT6dnDItlAi
	Tku/otFBim49quoZIAbYDgTcP9DFA8dw9myN5fPKWeHhDFZZZVBQrzfuns6dytedACcrQWkFd3c
	a89dan10YAQDo+uGGCMGJKaZM5TYJmo9xT8TK6txw6JPLjpiXdv/Wl2ikj3WdwMYVu6lp8jj
X-Received: by 2002:a05:600c:154a:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4bb4e27a9afmr42890975e9.7.1794478499301;
        Thu, 12 Nov 2026 02:14:59 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm66747305e9.10.2026.11.12.02.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:14:59 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec v2 1/7] xfrm: esp6: use the current sequence number
 for the IV
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20261108142652.1330952-2-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:14:48 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <530C7AD4-2591-49A9-9707-D504EEB48542@gmail.com>
References: <20261108142652.1330952-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261108142652.1330952-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Sun, 8 Nov 2026 14:26:46 +0000, Jeremy Jean wrote:
> When a GSO packet is split in software for IPv6 ESP,
> validate_xmit_xfrm() calls esp6_xmit() for each segment.

I tested v1 of this patch and posted the results in the v1 thread:
=
https://lore.kernel.org/netdev/20260930144523.435271-3-Jeremy.Jean@oss.cyb=
er.gouv.fr/T/

The code of this patch is the same in v2, so the results hold.

Tested-by: Usman Malik <usmanmalik@engineer.com>

