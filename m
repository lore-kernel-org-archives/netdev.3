Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598008;
	b=h7OU3+sSqsHu8dPTeEjwiav4z27wZePferObwV95GH36Xtb79ljnmbzbn/kUfYOP8Qcb
	 RRs6B9Mo+QkAl+2mqv4HjMfex4mYo/kflep1+AT5v0lfTN2hP4pDvM3yI0/RO3ICT1+HE
	 9hVNPvVf+XJt/VTdqZhWUj8HQMqvNFzeyneMk9FIlKxtLArhE/XzXn37Ra31hZvyo3iT1
	 IcwzFkiE8/XMcVQt1itxHEROQr41hnpno30WE6xpuiI9iHaoHsP7booUt3khfFRdQPJq6
	 +Um8cBGTv3DuIsCG/Ny02KwAOW8DvHs78ZqZwbLQ0cBuCfJry/IwHiQ6LIbC8DU26Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
	b=SUyJdnciD7F4TV0KNxCBXuH/ObPl5MXvjFyMxUdpOsd1+IAna7D6GpK89r4Y5Uig4/Kb
	 dOj0udgRtNrjijWWouT5lZb+M5opdikK70+2ZRJ78s5TYYS0vpCo/K+e5px/ogHkv25md
	 3i1AvoV2Qt72Ibg8Uux7qpiFpqnZFADAKd5OQ8qdzlzM9ukI6PmAlGIzFZ8slfAy6oLiF
	 803bCDzkDH/OQVAOxy3Oedvo9xW/Xs9qvVXC5zvNMZqqI7JPwgwqOsChtDof4Aj0wBjx7
	 P0NjT6JGBk3MC3gwkAkXshqU+8XTcJNIWQVYm+jQ0Oq0gGSDzzPPW3GHMKxR7dm9IzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Nmr0pfLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936E606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E936E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Nmr0pfLl
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e96502e447so19422385ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598007; cv=none;
        d=google.com; s=arc-20260327;
        b=frOGWFYsW66mN+fMB82meg1Wnb2UBvk7nLBo2wiTo80k3Ek2hhsU88Burd9OfcC68P
         a4XqKZIvHSrSjI4aWvLL/CDzqnnCRlTXFT07j3tJ17RB5B28MuRfmsPtMQC1y6PWiOxN
         hq4S32GuU3hLJx61/s5D85OyOWoznBydmXcfvJJDlMZvNPn8z1FH/k+5BepF5/LXdE/v
         5mWEcglHS7a/9xbnNKUPmqTppZn474hsHg5cMfZvui/QyPGT0/MSb8qa5nm1bxxdRaLv
         KfPBqywztDBwxKiQk9UjbYmspS9QwMqfV0+D9EmRwHihMSD7xrI42dBttTOqBal1Xz1F
         5bqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        fh=P34glnjE66MpBk/fF5uJtjwix49bwEM+gyOciSCIApo=;
        b=WL3g9PpkjYX9MA2Ulx26mm0YCfCpN7ziIhFlBQ4Yei52t0EkheG3sBguqh3k+kFmKt
         WRip8NKFUO6XoDXYGT4X4DYg2/Tcuc/z+LsgLXN1a7v2wHXXht3iQMaUnN7v/EO9qt3B
         NcKYxwsbbRUBu9ffXJHlD9QkMQPdIhKPJ5l9sGP7lherzJHzVTQlpxWaEHZSXPFxI78N
         zpb/7ael7is/HyUxRlplioybFeuFCsgrVtJbXrG2Ev4jetOhWTffB586UinBKfJV7pfu
         HqYZbfUK5hgtqtN5vC7HnL/N4EdZeDnDBFb8FxiIs5G1rAHbLOKnetAB4UPYvZQGtI9p
         zRhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794598007; x=1795202807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=Nmr0pfLlJ40O0dJ67qksgs+d9IhuS+a1YdupKLfLZLOx9Yd6Jzc4yMjF/dCnXK+4qD
         8b7YpJ/zyBjcvWbsM9y+zdcrEzsuPp8c7DNG5WugBpp6+ixKpf/dH2bGwXDG4b8Hy8yM
         WVbEMWRe71aE5MNO1zKxHaChPkaeRNbHI5NwKiNEvcV0SOTCWq3rICi3NrPwvqGsvmEM
         FW+ONk2U91vkXqRqq+JW2mFQwdtFQzUpX0T31sOtI8B+OfmxvtmMhwfop9dxCjR1/SIA
         AtjR3FFDJpbo483/x4burtlVpH/5Z8YVjlsMxSrEs8MYdt7iCdUHCFNNZKX5rvrT7Cb+
         CcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598007; x=1795202807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=UnrRZ1JhiEiHaD2Ce4MvtbHuZy94SW421V+mYWfZ0+Ba/mSxqe6OUkuFfDkEafO2W/
         EQyypBvZkisMwP3j6gGwP5xpV4uKLPqEZMcT5DweRLIUYIJctCQWkstGJfhrZ/0Z7G8M
         7Mo3qwNkjrFL09ahCyG8+/8iDpLmOE5V945wvvRM83owdbHH7XZhAGlNtZ92rNABWfV7
         CucUYHT+pMdwLfZYJQgI1D5aDmRuSpptdjAd2W0EJF49Ara5ADPJqBLAB1Uprw1zdSWx
         3ulpk8t6MDpzjr6eGNRW5pRNsYhJXUDSWTnf4IVvUaAw9Y2Yx/w5zYmQUgJLnB55ubvb
         SjQA==
X-Forwarded-Encrypted: i=1; AL+hErG9i+XbbS0KLM3pO+VzJhXh9sbU5xQgMxoX449dmjeGega2i/MRdARn+aaHdhxVbUZu6MDS1l0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OpOGh29Yuo4SRccFiqKu2C04WATDQPGrtI3T8tzhT4f8r38Wp
	wY2K9LjmVLmiqtZUpi7AGTjg0982olCMgn610zLp6bqnXQs8NzVELk6ZQp4q+0ovadfdnxX5EMl
	2cR79IbVA8dz4cxnlgRUaPO9H69qvRPVq3yym/Xmg
X-Gm-Gg: AYBFou2D+/AuOtGV+cHK1I4FHxVALYWr3sZpdiq008KMRPN14/7N3yaD0mJVVsDJ+V7
	smp/Q8a8+Sf6R6hgrDBGuVWpRDaGLtU2PEkH68B2GSWEfUIeiA3sZuAe67NI8G4ZiZ9/Y6dBQnx
	fO7tPx/2y9q2MofbMd+jMNifxA+miK3hhvjTycexvBB14TbgJDQF/M8YvSoNGA633woD1yCZBk1
	WP1afEk9NHC6VXu1kMNUSwp1KV0K82TBT0aaINeiIia0HAKAhtlKQz6/z9Xl1uRtTiYxipvoupS
	mnbajyXk+1tpPsOO01PVFRaq6VxKt6bn9/V3Mme186ssOZWsFml/v8+LTRdH8L+ypfTR/qFvagJ
	9S9SLoNowb2Wq7Hz1eypr2lOyvJ6SCAY2aiOwJ83h/lEYzXHzoVgrgdDV+AMdOSqjWGn05xqGqr
	mE9hzEc/9DVrhE8g==
X-Received: by 2002:a17:903:22c1:b0:2ea:192a:13b8 with SMTP id
 d9443c01a7336-2ee0daa3657mr34970525ad.20.1794598002581; Fri, 13 Nov 2026
 11:26:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
In-Reply-To: <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Nov 2026 14:26:30 -0500
X-Gm-Features: AclHuK8_VELfOWb6QxDH9msFQuAihFI-MTzoli1CQDJEubxRePim00n173V_ijE
Message-ID: <CAHC9VhSzdLiJyRfv2+rScvX=6ObQavHvs_UbNKFDabJNzwC0Ew@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:17=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/6/2026 1:40 PM, Jann Horn wrote:
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Sorry for the delay. I have tested the Smack part, and see no issues.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

--=20
paul-moore.com
