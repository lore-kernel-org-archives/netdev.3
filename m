Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44A52FE49
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085080; cv=pass; b=DvwYYbqxAKJadu+LvDu80+52Iou6mzEtJokFpJDHsF11yrmWt4Pn+peQEh2solR5bhkBbHQ3IgngxteUAbfSe2q0UbdNxw+llgFPYYEN4RKqV/v/AKyH0rDB9oEu3vPznYVHsw3mBp9kmUN9z3KBz1Ya1uMfYTm4j9mqAs0Nq8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085080; c=relaxed/simple;
	bh=S/kkWPHwSGy4P+S0JQpAAo0Yk1iGNL9+bI1LrpJmTpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0buMezmkoSvsIMngFxltJZXqe9PJ9kuJdlA4ypbm1wFyIzKLFG8ir6xs3tMDe9Qr8In3YcjPJPtdSXqS2mAR7wGyAAtoAeBpAXSOg6skp1FSj5wpKVi238pqkZzfd8SBNgvqX4bS5edmJ1uF3+Lntzbg2+5ZnrwsGUG+mCz6r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWd2UJGL; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWd2UJGL"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6767d92cde6so5757879d50.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792085070; cv=none;
        d=google.com; s=arc-20260327;
        b=pUqcsP1zloqg1kjH/txpuWkd9IRDohhhZaADI4h7OACRpPshIDF43Dd5iXG8aX1r2F
         dCzze+6pjMWbU9ha6EFuybynzDJxUpsIL+XrhlGtF8S9dDP3Ixh1KxTq8KNTL8Uv6mjf
         TkiUocAvfFuSF9qeZosMcx+T+XOJQjFzsdTCFNRi9vQwroBKA0Oc2vsM4uUJvx0wLjzP
         HIXcRydyYsPQyhvoEiil1B2b6RE2v1yBWxX6sfUiNSPT/eoUfdAD/WnRTbahw1wsBRFS
         8/AOkh0Hdc1alBpHpP4+aQVaeWr4xqvDkkbL0LGvZORMEgKP2/4yyuXgZKKUaVaw9FwT
         lVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJ7AwNTLGK0qJotpIP2/0w2WrkX374IVRj5Elec6DwE=;
        fh=UeLqLv43uIhCaDO3bWzBcIEQUYTX2d2npDil3qRTR7s=;
        b=UOmnD+SQ4vFLFMeOP2opuU8ulg8RkYksQZlCr1HhLqQQio0G27l5Stzv8cCD02Nq9W
         tBhkNwzYrbiUqkJncqZM44D7NP1jzGO1K7BXR/2vLpuEPuI3JZc2SCP+LjTLoupCnGUT
         WF07RoaVaRVCwu4lIuvxxZ2nxZthYEWM9Q2MfYZp4wM8C0y4MBeqsRQYSmTjTaNPnOfb
         eHgwmvZcN7bgqRXiWYu8lW6XSJOs5L8phlVKrOPrhGsdHA2mgikRJjxde4NQm3qamk23
         WIFHW0aA/y2KvQ+wrsKEsg1Qi34W9aRH1K6IylswqrVYdu5z5CFlLRHiB1aI4O6DZp+n
         C1qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085070; x=1792689870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJ7AwNTLGK0qJotpIP2/0w2WrkX374IVRj5Elec6DwE=;
        b=sWd2UJGLzuAKdvduDyvmW3+H0AzYhPojsFqtsaMa05JP0LqE3RRIz+I1eZf0+pj5yz
         pR5E6zguECT9aP0R+4+XtquuWSS9MIijhScbkDptfkurwaffvp6mrcmwJnodaTNs4A7t
         SyXbfYzTIBIHcQnWmvaH+jhYEFB1JRbNjWLs3zNQGf7KsLx1TZf5RJLnhsOciKKuHovp
         i1pKdkcanYnIaUI1KxT6zUTSkR5H9q0+Y4/KbIVHI/IUadLa0SmKAxoTzr4x2Gc/F4ks
         6yqHSZ5y0ovdYwol+F4Z//RLXgVy0otqDR8nOrkzwh7DssMfeWhZvBvyj4jt5sVx+Q4a
         wvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085070; x=1792689870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ7AwNTLGK0qJotpIP2/0w2WrkX374IVRj5Elec6DwE=;
        b=SwzdmPTlGP5SwkG0HoFiWQKP2beqo3heE0fV9i+B7oUhM+U9BXZ4rS6lqKwd12Cd32
         yByBReaqIx12ac1L/i+RQoOjVIV1LAD2pAOnp8WKaCpM4sUBia+v9XTQSsbBUiNKX8nN
         PlRaxlQn6y32AjXe2+nLng6Dliju6rqWdVbvqUt8Y9JZvz7sa+18mB9iMfn5k3LQyKki
         2ORIMRfKK1XWJpBIxdysWpcIn11Sd4p0h8IopXyhcIjQZcL69MreuxbC7XWW47qNXcdX
         bIYCpkdIShIR9YEerj6tFKzJi3Qt1OolMWfWmHrCvtu6cyoEMeBhkDz8NuverperD74F
         a7CA==
X-Gm-Message-State: AFq9FYJT/2iNIs3GyByw1tfYQ3izgNI5XxSPzWSnzVq+S3t0dW4EjNlQ
	c+UqiuDu/ZmaIpD0ZlQ9Kx2S/CDdO2+bNVciHG9tDNX2FGpO/t3SY0WQV/+Ggq6Oz6fpzHAZI4U
	FG8/f8itiVuO6c9m2mE+87UqUGr7POUMmoTMVEZRymw==
X-Gm-Gg: AYBFou0S90MwD4aeRuXSuc5sLRP5Y/spt63oxZTjnvVEGoyAmPksGt7wqdKIMsx97qG
	4McEogkJlt55CYzNjXU1z8lXv/AoGYMJkqr1eOAlx4+wMq7SJ0kZh1zAkfHlJ7aSFHznBr7Aeje
	dQo+2M6RGv5f0aJ4GNik35CcYkgLKfY1aA10ahlwcgZ5fQlobHwkg6rti15r7W06MaUxw0USSPM
	cNWQl0evFwQiEs0gAxT3emOr8BZl78lGsD1b4Wt7i9A9Wz3VjQ8kN0+et8TD0oQE+HEfp/G7lBF
	RsfOvSI/KFpLNhVocalfEGXRnMdV8x313s8SIlKpGnVQjU0ieV/ZVgqJsFZ8mIM02DiGCsv3flc
	49DJDzSaBtjFrP74PpaI=
X-Received: by 2002:a05:690e:1689:b0:672:f272:f629 with SMTP id
 956f58d0204a3-6793630d90emr8360068d50.104.1792085069711; Thu, 15 Oct 2026
 10:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055103.949540-1-gongtao0607@gmail.com> <10d0c5a6-98d0-45d5-a196-aa839b452172@redhat.com>
In-Reply-To: <10d0c5a6-98d0-45d5-a196-aa839b452172@redhat.com>
From: Tao Gong <gongtao0607@gmail.com>
Date: Thu, 15 Oct 2026 10:24:19 -0700
X-Gm-Features: AclHuK8ES2Kd8skfs6udor0Fpl5ne5f6cGaytsMa82tMXcwNkOjHwfvDn2lGZGA
Message-ID: <CACmSHQse_McSbBfEiyvCCePp97Azb7a5c7q5rr3AdXncrcSfUg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: dsa: mt7530: fix trapped frame forwarding
 and egress tagging
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "Chester A . Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I overlooked the existing fix, commit 4cb3cd670b2a ("net: dsa:
mt7530: untag VLAN-aware bridge PVID"). I saw the issue on real
hardware (AN7581) running a 6.18 stable kernel, which doesn't have
that commit. After picking it up, the issue is gone and neither patch
is needed. Please drop this series.

On Tue, Sep 29, 2026 at 2:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/23/26 07:51, Tao Gong wrote:
> > This series resolves two issues in the MT7530 DSA switch driver prevent=
ing
> > trapped link-local control frames (such as STP BPDUs) from reaching the=
 CPU
> > host when bridge VLAN filtering is enabled:
> >
> > 1. Commit 3ac85bcfd404 ("net: dsa: mt7530: preserve VLAN tags on trappe=
d
> >     link-local frames") set MT7530_VLAN_EG_DISABLED to preserve VLAN ta=
gs,
> >     but in hardware this disables the per-packet override and causes
> >     trapped frames to follow the CPU port's active VLAN table (VAWD2) r=
ule.
> >     When bridge VLAN filtering is active, the CPU port is in stack mode=
,
> >     causing incoming untagged BPDUs (01:80:C2:00:00:00) to be egressed =
with
> >     a VLAN tag, which userspace STP daemons (such as ustpd) and the ker=
nel
> >     bridge drop. MT7530_VLAN_EG_CONSISTENT correctly preserves wire sta=
te
> >     (untagged frames stay untagged, tagged frames stay tagged).
> >
> > 2. On Airoha EN7581 and AN7583 switch IP, setting MT7531_CFC (0x04)
> >     CPU_PMAP alone is insufficient; the switch MAC forwarding control
> >     (MT753X_MFC, 0x10) must also have CPU_EN and CPU_PORT configured fo=
r
> >     trapped frames to exit to the CPU conduit.
> It's unclear to me if you are observing the issue with real H/W or if the
> patches comes from LLMs or static analysis. Please clarify such info
> in the next iteration.
>
> Also clashiko feedback looks relevant, please have a look. You should
> address LLM's feedback proactively.
>
> /P
>


--=20
~Tao
