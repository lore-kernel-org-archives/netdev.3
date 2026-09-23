Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAC4F85AA
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178552; cv=pass; b=rcJh+nC4+i4GJDF5/XzThA0IVQ03Bbz3OIVuUBclZJgy+LsSiYA28ZXR76ggj0gqxKYY9EPinIwAqUQ0BfpEaU4tZkSsDfJrrHSLSshAUjW0PlgV67luJN7gtxCsX3rvW4jSUWx6H2LFcW6980vkSX3pUhlIuc2gTLQroSFvzDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178552; c=relaxed/simple;
	bh=pFXiJCw5ZPUtyNnmgCVZip8L+x94Nf5NUm5RGAousLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noqvcxuUdHUEUKI/IpJINxyK4lFZ4aFOLSzbLMRYAknLp+VXFgu7eAU+xa+dgZe4GkY8HZsxpzDwusu/cqO6fJ2ou3MIVJu1VE1H0Zb3mg5lOXP/tZxEA1WN2YfyoCU1PhB43r0zbe1urMNBLPbN99uF18k9zxjtIvYnjK2xdWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEwHocP2; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEwHocP2"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664d340aso662818eec.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790178550; cv=none;
        d=google.com; s=arc-20260327;
        b=qps5UZgElknY6697abBvw5GCb4M+r8yt2yJR32J7CVGItRQgGEN5eGrXCyFKoYyufm
         uSW6gBNV520YAp/mCaKGVQXuwwWIITqDGn/rDGhCW/w3C8Y2cvZVWRJXrZlDNVEOJoXz
         VrSyNQ8rfp5kBvLuLrHH6zbSpqUaOKtcblI7jYknyW1cSAfyd6bcPo0BBaF/mrTc0Cwd
         7LoNueDWsX+eivfHrxsaThNhnCSO8pEtMyfTSruk5SgXgjc6ZDzx9ZSIR331dpa4pBKb
         n0M8vNub7mHn+uoxgOgpoTC9/flN3/ubdXYqHjbk3eWN6pAP92ByZZ5P/5jp1O0cfMwv
         YUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFXiJCw5ZPUtyNnmgCVZip8L+x94Nf5NUm5RGAousLM=;
        fh=ucGAInYxh9GvtRq+yBP6o3w3AgS+lnJXVb5w1fJI9Jg=;
        b=r81Xp/9OLjQKFU71h52SroDCQ/t6GNn7cbG1hg8c6mnWPzlbX+7GTcfTvPOLPjEPml
         JaeCpv2tZvq7L7XGDTRwHQgCZMhbBI+gsMPvzauN5ad7ZuCeCTOjQEIxn9Wq+AYv2Tnj
         blCocBa2/tssKGQ2D/HYeFNpqAadHn7mylQ6Ja7HK1MZGaOodAjtFR1QPSr0KufQTxTx
         xGPY6EO533FSmMnahIwcsPbm6oCDfrTnc6NSYwTGP7RZHv/RC8Bdq2jvlgTXFGYmCuJq
         Wz0jD5htW/6USqxWQdI+lK2mKM/0DR5o58e3XfNRD7hGhs0J8L24olTJqACzdFDtzi9j
         k4ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178550; x=1790783350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pFXiJCw5ZPUtyNnmgCVZip8L+x94Nf5NUm5RGAousLM=;
        b=pEwHocP2sIoHUtx8bZXvSw8K8SRMsos8nwjhxEuSuwHrPa6Eacc1Nzrnz+jp0jY1ho
         jLXHB/z/PyKwm/r7dm5MlbHEjKZ9MX7WNuqfNpk61slOquc9U0KxgbzmMNMby1m9qs1D
         i5wAGJaYGIg7fV3gMKwAIQcUcqHAA4OxjVZobMU6EHl3I2Ots43v/WyYFg4eGYm4SuhE
         SwEZgluuUi6ENim2vKsR+fEwDUqOc7rANUWENKrWHrxZfqAz1U2pALEmiyBurRocWqBe
         VL0zYqqgksXp3o6b8pjIkqtvqt3J6bg3QapzoOAq3E6ai/dwZLUfDOF87tv3HJ+Q+AIb
         wvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178550; x=1790783350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFXiJCw5ZPUtyNnmgCVZip8L+x94Nf5NUm5RGAousLM=;
        b=K3RwrNl7aI/08cnhrmxvFq07ZdM5yyhiCjpGfozS+XENB5il8QHZBv1Sma+iOVrNVm
         sovjPYJm35/SJiWkuJpwlczEgDl0gkU9rHHAH+BGlc7c6NC/SKPy/EJU8ZxlnE79PcRW
         G7rc36JutovWTOlYq0uylFfb7bWVlfK3OUfmoKSEfbVewf2wxX8Lgr0285m2FiDpUo6h
         mAVkScGMw6SowJP+vitkI7IY31N49EmIDOpaGdTsk1VF7D2cX1hK4nJ2bgOb5fR/SDVT
         oHys8lc5ZpMSGU4VXKfBxWVi2HSXisLKeJWxLEMGu2G8q21VdlGrdUl1+llE811WuoZL
         WhIw==
X-Forwarded-Encrypted: i=1; AKwUvBwhyUbibDvytHEP/xw4IlzEjjvaQdWqJk19b9AfALtAjmGRSiRLVUyv10YWEzL86qAuJjF6IUo=@vger.kernel.org
X-Gm-Message-State: AFuF++nsOvfSvX1KljtgXdfBRrg1olDpr6KSto7EBbDjNiFwAhCKMC2t
	H3ussrbPvK1+Ntk5GpsAnaQt5tt3nDhoEeHi+N8T/nBzXUJqCCcNoSbEv9EAI24oJzdoPm8o2sb
	oVqAXIeZjabRcxYEnuJoPPrqiY+lqMac=
X-Gm-Gg: AYBFou00Wl4nwcDbOuUPPszEE1jSnKBa9WkbqBy84oiCAdznZqNeiHtSsu8Hg0wvkZ8
	ShmuFQNotvt7R6Xrsn90fUIcrBzsGb/Gb7u1zaReNYvslHmtWq9tZNgtr0gDZBoqYNA6fX68Adi
	Q43+LnsaWuiASd8LAbY+Npm9Yc6C/Es9NU5CKttnTXC7yZwc0HGpUkaQDwGCcjTr3tkF1BI/Tnl
	Mwmid3BBLItZ5B/mXYgXJuBrcmCWOBqLSLvDW88A/33gUloFu5buYWVhmA8F65OWBLC9Rl24Iw1
	1G6j0D+/Vroz7edm6IC6rSxoXFEsORZZhO0QdgsZ7DueOkRxWrJ1AEOg9DgBukUNpClbmVf2WK4
	gpOvo1OYOpW3bV3IZ8jmEQVWVOb8ISTvkixD/ef5kZ3rqE4h/IWl0JEq/1ldnloc6jgh2lfk=
X-Received: by 2002:a05:693c:65d1:b0:33c:55c:9b61 with SMTP id
 5a478bee46e88-33e8c24a5b9mr2707317eec.11.1790178549658; Wed, 23 Sep 2026
 08:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-b4-fix-pcs-lynx-an-v3-1-dda3ac4e499c@gmail.com> <20260923150542.jo6inqtczwiignln@skbuf>
In-Reply-To: <20260923150542.jo6inqtczwiignln@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Wed, 23 Sep 2026 17:48:57 +0200
X-Gm-Features: AclHuK8ni2GY4xiKPs59pfjPF4T8nzT9BehaQWgqHpGgHfXg2qrLIPNRNW8UXTI
Message-ID: <CA+DkFDaau33xZRCLKTX+V2+1M9SiypTPLh6Je1SvB1xocdcprQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: pcs: enable autonegotiation for 10g-usxgmii
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 23, 2026 at 5:05=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
> There are 2 problems with the commit message. First the prefix should be
> "net: pcs: lynx:", and second, you say you enable autoneg for 10g-usxgmii
> (which doesn't exist) instead of saying you enable it for 10g-qxgmii and
> usxgmii (to correctly reflect the code). You should probably fix both.
>
> Anyway, with both addressed:
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks, I will send a v4 with fixed commit message.

Best regards
Patryk
