Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74A4DEC2C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775824; cv=pass; b=XTS+j1GKF6r+5tBZZNlOBRPK0VuHaSWlfW8sgDyEi/Wyq4hM89zdwFudeuJPWK9SexOkPYD+5HGSXhydMvWcNsHwRKll5clOYTLdxJVV8sncoAB0ullqDGLzg7nAYa/nf6wWuHWN5UrSX+2wEXmlquzU/eQdZH4sRtihn78X5w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775824; c=relaxed/simple;
	bh=cCtGCKJIdKETCLLrblWPIJiV47ko5Aowu8J0xSZcZvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbagyv1Tz+Lx6Lki67Aliy2v3COQzfHwh0AWbBS3mNYrf4picEXkHcrFSV6oxOlWSEEoBlTtloqQz8vRBUWQmF9yF4/KeBYyTJ2DbV/XkMo+GsAnRmTAAnN0ibSYnHBKFaXj1WBxKpTacxaBFDNgpBfHM444TUIw7VMclxbUpks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abwb83fs; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abwb83fs"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3ce4795aso1096992e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790775811; cv=none;
        d=google.com; s=arc-20260327;
        b=gmGda352zqAGxjTSqX/ehrG25FBMinxes4QxReEkgIIWmt6tVCDD+7DggZgnHSvSaS
         jdnzQ8rSePxnxlHtZaKmStD6vrUj4NkiacYlPYC3gQ/DubXW/JJjzNBwkxVPQ/+VvaqM
         vSvzc24/Zp/FmLE5MZ8IDRo26HM7vxkz76Ve7mAD692BK44U0Bc+uQL9Z7kyYcsg95Jf
         9oj3XTGlN98bK7OTDD/+eVOD7V3w1nJEtvWXVIpRc5rXBpr18yO0YpDLWEoONW12tidz
         1bxlHPK075qsn7W3DyqIM4B6pRU0/3MOLYm2spHRdI/CT/nXT8sd5Ps4g6JjqdzkZRyb
         XAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cCtGCKJIdKETCLLrblWPIJiV47ko5Aowu8J0xSZcZvA=;
        fh=XdXDDHcqzSrON29VQzFojdg3AheEy9ElQF4VjNDyXNo=;
        b=mFQDwrBQ42H8t9p5CfVDBvxxiLfgBPD6hK9A+3C4mQpD5dWTH90Wy+9+z67j+Y7OdC
         r0Y1eVgRrL6JwP5FijfkIVCsOt7hDBf/fQ3Kh9GLUn10Z/peZowbqeZvZM96/4RJCvel
         Fck8igMfff+9T9VEdSjVKMwER+xeVHGdv3fEWpI3hsK0NnoBEMDUTSuB0gkEvCwKQTTF
         tt0ew6orqu0hAIp9+Vc0eH5sk71K3IueIYHM+7wCKWDbyDm05vupKK6EDQY+oXeklbeq
         AxrJH5HLT3eGrcM6XQMcpQP6tvyq3gRG/gmLgr65Ezm2XGhDNtODeMDkKBrMk6+IUbz1
         FikA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775811; x=1791380611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cCtGCKJIdKETCLLrblWPIJiV47ko5Aowu8J0xSZcZvA=;
        b=Abwb83fsHbVpFom07AyBbpD8lFlxcGjmykARrOKp1fEkZ5oFgOMcOil6oA+XBjIA4u
         VpHxhpr99eY0XrjQ0fH6vQj2WGP4SaUUkQbPZkV6eL0+Eh2K7xGmReydj100JWDeaA2m
         Ejoy0YYjPwnLLA8Qva95dPsyhbZy/LE7x2OPGuRAf8bSsFJfjKIMEzixk/DfeL/Fv3RF
         4QI1Yh3RBlRp2YPpWQI0aph0AsUN5ZcrBCMzRRZkvqgau45sRl92pAOYYeW6f+yjnCHQ
         sWuLaMYhVV1MBs8lB3BGRT3u97pMMllnj4pmMtDtq19bRWSxI1U8dgz459H0yoRTlXuq
         Tpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775811; x=1791380611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCtGCKJIdKETCLLrblWPIJiV47ko5Aowu8J0xSZcZvA=;
        b=NetXhYgdkFdOOuq8DRj0moE1L3uhsEv5fDdit2goRlaOXpx3h68+AdrmDjShr6KSnc
         TxEbEhwZiAkKU/N2rV5YFX68TPwf4tBZU0cmr++WDKxiL0vURjpHI1EQDv04rtXv2Cm6
         Su8XWJPTt0uHc5JP0qQ/SGRSrNw9UIbEQPMqicdj0JB3qHSsvzB4co44W8y8UsFwhTDg
         Eg9gKgrH3pttzlDefxXjAw6LN6RyK4wn/sWKobaHldOGh7cAywOiEe8cMdJHExeP3Ufh
         OGj14yGfkVCc0yHJljBg2Bxnr+XHo5n9isV6vu8hHFyWVr25QNc549Ni4BcPGjU9hUGY
         e0Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzOlOxtpgRjAlAe4DlsG7DN8676AfqVACa7O1yXP5IjtkrDv/UtM8fMuqJhUyEKNUl+IOgmOy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5p+ZywtlpE4wOotqdkORPp5GWar046NkqvWv8esDLJoMrzolE
	utunMAtRlbZuuyfvOjtA/GgeAmG60XPqv7Vw7x0n3FCQb/CDZnD7bpIncG9iOLmVgMLx0SBQP1g
	lNPZ21J+yoNsU4GKZCREC9URdu7HhAqk=
X-Gm-Gg: AYBFou0Q1m8OsJm86XWMM/nu4Yyw3Z2dHLCe078dQk4MjZhh1rMRzqHb3bcD3abOzY5
	WGYRpKlXTPJrIgQfuM1mTD4ljf6FoN2X6zdECkeQ7MetvvgZU6axy3BOdWmMunOFiepzOt84nJE
	jEfEGL1m+s9b9zkFUXTKH1XmtFPZ2ELPCEukDL/FUGwBqozYu4SvHsmL0vwkUi5KLMWvGkeNZ7Z
	RcK9EBRhC2PGnprXmieayrulCesNz+f/k/pm9eoFIgaTAKy72PT9PVIUDqbQ7newamgN/PykOqg
	9JVBdDxTRUfSTmidSw1esgUUrkOPb/zStHJvrP5JZ33T/8QGjFO0Ul04xGRawln65FUQ7An8Hab
	ZRuyYQd4SJYx90yXfeqO5dB7mZDRRpPloxBbgZ5IErQff
X-Received: by 2002:a05:6512:3ca2:b0:5b8:f83b:30bf with SMTP id
 2adb3069b0e04-5ba405f9b82mr609416e87.65.1790775810584; Wed, 30 Sep 2026
 06:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-3-sigefriedhyy@gmail.com> <235a33c2-7138-4815-820d-793568757d95@6wind.com>
In-Reply-To: <235a33c2-7138-4815-820d-793568757d95@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 30 Sep 2026 22:43:26 +0900
X-Gm-Features: AclHuK-5JDzwUkEH5VWEa1bCvpw7pms_UcYcspNYWPTwaPuJPPDlw6Pn3dQKWJk
Message-ID: <CA+7S2v+VaVYksOpuUKzo+DoWZ97M_XKvnMr8cCcgwTkrOxsvEw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/6] net: change netdev_hw_addr_list count
 through helpers
To: nicolas.dichtel@6wind.com
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> If you respin a version, you can use netdev_hw_addr_list_count() in
> __hw_addr_list_snapshot() also.

Thanks, will do if there is a v10.

On Wed, Sep 30, 2026 at 10:03=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 30/09/2026 =C3=A0 13:28, Yuyang Huang a =C3=A9crit :
> > The count of a netdev_hw_addr_list is changed in several places of
> > dev_addr_lists.c and a few drivers read it directly. The next patch
> > needs to account every change of the count of dev->mc.
> >
> > Add __hw_addr_count_add(), __hw_addr_count_inc(), __hw_addr_count_dec()
> > and __hw_addr_count_reset(), use them for every change of the count
> > and rename the field to _count so that a direct write stands out.
> > Readers keep using netdev_hw_addr_list_count() and the netdev_uc_count(=
)
> > and netdev_mc_count() helpers, the few that read the field directly
> > are converted. No functional change.
> >
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>
> If you respin a version, you can use netdev_hw_addr_list_count() in
> __hw_addr_list_snapshot() also.
>
> Thanks,
> Nicolas
