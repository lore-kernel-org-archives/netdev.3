Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDB195811
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769297807; cv=pass; b=ed4AsuXzvuIBicDY+NbbTI/zTZS7qtd1+QjV/81QNEhChZ1gSJdgLKOkKbuk7ejNNZDdoNhTg407UM44fQIgDecGIkHNFDwIznYG+YJsDI1eyne38UQr/DSwqLXUaW1ziPZ4mcYqzbtESTLlWNF0KTnTkhYA3KoNcv2Q5HLACZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769297807; c=relaxed/simple;
	bh=ZaHznb2eN64DbWJ7gM939sh3G2lUK8wsCPW64wOURj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4Wkxew1B15r76JKzu5t6HWiQrrCucfSJh8ei/PyRc90g8FDkEEuzJ2AnuZmXLt4sK0Eni882fH5G/uf1g3smGpbtNLQm4/K8m7BOFj95xQgaHPIkVJOSTYwBP/t/tAsIwid5Wk/TZPRPJsBCFYefO0EoQHnMjF6fFGBeMTJBPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDqU9qOM; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDqU9qOM"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88888c41a13so44576316d6.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769297804; cv=none;
        d=google.com; s=arc-20240605;
        b=JgLFBZUZsX0OwEYn5duITOJvd1IDu+g6mDGVTePzC755fpIX8NpKYUwBZDDlzhl7Km
         JbnvPO0U3JrcK/6Qu6gmAMxdcQx8hQxv2PhosQwwPgOJcfw1XIEdDk/QaCXr4xxFkrUi
         kTGurpZMKELCMGJi6qOyZXjvrgkF0BlfjLwuopunJ1drWUYAWgNNl230emr6THXTWamq
         8y3Y3rbCNz68gXLrL23xFf34EnhOTSCUca5Aekvql8opa5OmfJBhpGPZtKliHa9p2anO
         kYMXHivjn6OKhb7gHwkv0awFHCcc21GY/2y3+cyMJBPBI221eEseTdO+L/rrjup8zrg6
         xQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZaHznb2eN64DbWJ7gM939sh3G2lUK8wsCPW64wOURj4=;
        fh=HIzmFZdwzjaTDnBU8n9wYn460kR9xOvm5I+eqoHT+VA=;
        b=IJvi2oK7aXFCUvZ+TkfH56kxBdxEMXnLuz3QVtMZ5he2+u3drcQ/qGBAL5V49XSZJx
         9fMXAgzPOsBnHfxTU/MsUSoL3BkVpQzPP50d+U6wQ0Lvd72nDrlbucGVgmSJ6vqeE8jg
         d8+EGz1MKlkgQJqRlZqLHexPQQvYIV8xdzrX+TJLvoCn4nzbnrqiDUstycIr59RMuAfG
         rye/O15NFlfaXiIgv9gfWH2bG1vddI7JPbhNWdRYWG5KwtvWEkSuffaVYOmx3ZeBnwxd
         LnZdEiArSA9UZUXyPvrrqqL95mOdu2fBNBSGnxjaiysESuBdqQS7uOlDF1EUcCP/KnL5
         8vWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769297804; x=1769902604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaHznb2eN64DbWJ7gM939sh3G2lUK8wsCPW64wOURj4=;
        b=BDqU9qOMlM3CmSl/swRB/GQfaxATaE54nzYNGfcc5mudpbtBzqol9FQkCfeIjIMBZl
         n+PRgxNPhMFXmF3zftHmCdTN49pySumbMwlr6KGFoNLDYgFxJzspeOn+5gvTWO0TJDdF
         zNzu/s9umns3hiGRhOVOfTV1pzGGBcG23G61rHtCOz7M9HhC/YZoiRsDngElmZC3+xx/
         tp/iMNtvLmYJNHEunyzlYJmPyY8lxIywQxvj4WEkMlsYmfJ6KTk3930UsrP2TDdqkrjV
         +t93WJdiD3/squxmuFWoMbcDwegSQdYvpS8qjTXr/xF5hRzy9zLGdl0CKL9UQ1so9TsH
         izDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769297804; x=1769902604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZaHznb2eN64DbWJ7gM939sh3G2lUK8wsCPW64wOURj4=;
        b=jZeEm8JcerXLop6vtQXccuBkAUDWOWkLmAc8SHXTCavTxWS43v1N0aE0SP/Q9ZD8Ny
         aeHgEW4iLlu2ecSdWQzAeeXtmrCDcMetEVv5gwRtCIsmq0b11LL9d59DzjvYxMsonVKo
         tznJ8+/eag38mTikneP0NBcuKdiK+AzIbZAXNhUV6Old7H0vqIz7OsekwDAmeeli/TZH
         aHd1iBlUOWGV+I/BayIjRZqnkA5OcizLlyeUcbjk5mDCwgTA+SYusT5WyBTfDF3V8y2p
         JHd/Ank/4Br40nZzzGA8xjadxAQnSSx6U4Fg72rQudqh78lNvea2U1y6/J2ZmoWrkJRG
         641w==
X-Forwarded-Encrypted: i=1; AJvYcCXUrQUTh1rVth5opbxyQMgqlUHv4p/lHdOcgP+Ah2bqY9JIgUaxttLBpWtMDoSMPyRWMnWYXm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dI00cdXei8hSf3nlYTVMYbEVG440OHvcp8pxp013nIbRKjXw
	M61xYCoioOOMagKF9sR0IPjGHxy6aPQM+jFtykOzhHIA84GaXw+UDjdg0MN22YQrZ8gbcMzcxCm
	63mOLc1/li+lHpOZU+Mp4g/6DKEP5Dvo=
X-Gm-Gg: AZuq6aKox88cLjq1guLlsBQjS/L2Zt1AfzLUkK8Q6gCdtyVORTSxsSnlmJOgW/LV/BX
	Fa5DjDsz2+Ah7RXSgIClL9aoVBOvtoG1cOcE+lc3mPmI00B2jrLf2cjVnzrQa6GpF3yMec5uhSf
	NUi8WcquADEJRP9/mila8BN9H8KfaiVTh/H/rt216RD2BUkHePy2JYLWRqYkmXnAA0Yih7e26hQ
	8gOk2YwMDJ3djVIUcTebOWJAVicCoYYxuz2DAGgsbNLvQPwop3tqMA0PLjyo/kDbekCouSDVAzw
	5sfP9b4j6g1coNdt9HHZYnFz3oJyQkp4mMBJOfzRpwZHskbGdA6Cj2ZrCD8rBbb5UatVaN7jyjP
	niw4GyrBW+0/y5Pg=
X-Received: by 2002:ad4:5c43:0:b0:894:48f6:3cc6 with SMTP id
 6a1803df08f44-894b07fcb94mr1744906d6.71.1769297804564; Sat, 24 Jan 2026
 15:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124102042.112101-1-enelsonmoore@gmail.com>
 <aXTHhI710LK1EsTG@smile.fi.intel.com> <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
 <e91dfc01-373d-4d3e-9dd4-9fb3be92f756@lunn.ch>
In-Reply-To: <e91dfc01-373d-4d3e-9dd4-9fb3be92f756@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 15:36:33 -0800
X-Gm-Features: AZwV_QgNvugEcJHinRroZKzzvHFL5kaADOzGROZA6gf-VsJzgt5_ETpYnZSqXbo
Message-ID: <CADkSEUhf5Dpy=yFNQBksEhKjwj-+n07ujADmVHFUv0go5pYbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: usb: remove unnecessary get_drvinfo code
 and driver versions
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Petko Manolov <petkan@nucleusys.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, UNGLinuxDriver@microchip.com, 
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Oliver Neukum <oneukum@suse.com>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Max Schulze <max.schulze@online.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 2:23=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> It would of caused less confusion if you had just sent a follow up
> patch for smsc[79]5xx on its own.
That's good to know. I'll do that in the future if possible when I
overlook something.

> We prefer lots of small patches, they are easier to find time to
> review. Combing patches is generally the wrong things to do.
This is also helpful to know; thanks. I had assumed the opposite was
preferred (if the combined patch was fairly small) to reduce the
amount of mailing list traffic.

Sincerely,
Ethan
