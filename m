Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920694D6C2A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340788; cv=none; b=bOffd4YxpS3fud5NN5NFobS9TjJGzgfwm06ico/F+RuDRsHvO2fY4CAHcpkTa8Bb7284zjyAkBqWLoHW0Qsk1ep7YR/+Cu6GwbZi7kvED+dIA/zU+s5+d0CdrbsNKBhC24Ka+VYS2/PREha6GUEt6oeV0XKnxZ9eSxRxLU7rSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340788; c=relaxed/simple;
	bh=G4S1n3I+vN415jixgniNKq1lBfK4ap4+2xCFZJvljTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLCRhSa2i+Zpg4Z3nUb4iEg/TxmF8QRlSsMwqYBvE2+vvZbUD2QCGexTr2yeQ92qvyTFi4CnTwKwvQsrP42i5wIwq6kdr2qIkAWS/zm2xHQ02x6iRot0a3NP4dG13r3qaQx9QCxPdgqP8IvVlBANaHeURYvvwZCfuLR4ofWbaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3ipWvTP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3ipWvTP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a706146559so1097924a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792340786; x=1792945586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
        b=s3ipWvTPS7U8hkOE5XRzFbEkyhGh1zx0IZDL6mKYeUaw8yLilO/+a35SVpvc1gs6Qo
         RIWx8aAHYJYa3B29rWipZXYB1t3377vMWgqsF8yTITz4Pmbp+jNryGBWrMQdvpGlyFng
         1n3rWPhu/M3wDFS0LgyxrfAmhMQm8XpPIH4jCQKvCuGqO3JoaxNK09dP4wiKyk4ixRxX
         tak7IQ/0lT996uyqIP0CIPrs9kDkbgXkoUSjFx6tdRSvcgUaHxFmp5YxMy5AM0akA0+u
         3TwkQZukKd5AM0ZijSDub40bEaAFMpwsfhzmi8Xgjwq7VKXES1NyQrNxTKMuRxAuI9uQ
         QDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792340786; x=1792945586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
        b=f0hejK88Gs4o4KbHlqw1JtBxbx9GB0rUjwc94Zkhka7i6tsbMrTzAQgvNu9oH9kuxy
         vP/ACoLrQYg2UdE9guwHh0NPeri3b7l6udLqB94583QqmXcqw5v/o9qtvVgmB3NCl7L6
         A1CCapg5DENRoice7FqQkt1pJY/fOepQBlRMtEzFJ5muSsaLhnHSQEqhJBGiznfdUey+
         wGBirqWnJsoVnlKiFL9EF+fh5d2eBuHQNnn0Nm02Q00spHIHsJnOhCXGMNh7cOK3IcqE
         SHxldAH9tGd4jOeUCNe300ryI8kUdJBXKD9wgyTAyW3E0mZku59nkWrl95xJXSBGAkns
         nQPg==
X-Forwarded-Encrypted: i=1; AKwUvByXK5TzV8LHIq44bwsn3ANeMRS2V7bh2osKl0yUIdIXZfoTIRBlMIKc7PQymOw/f3ju2QrUVPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4j03UzbCKGTnC1rkNhShbwsh8k+tQgpP1Q/j5+B299KCwzlQe
	QgcXJnj6JnrrOyGTnHiZUnMFJ4mI9fWTkJwcyGbtJ+1bBWdyK37lpiRG
X-Gm-Gg: AYBFou13M7iCstAqomZ/y+1sHCe3jtx1Tn4CM71UGh0Dm1Nttqtj9wnrPOgrxr+rHwF
	e700Bz3u3UVt01yIngJu5OX2c2vuaP0svFrl0mmDqm8BQzj5m3hShSCJqB4g5WUsG27QyViphlp
	cCRn4k3+9veZ7WixHLTDXZ1xeuIOV+ns9uC7qpTkPODETdfhHSnTcCSNRrYEjFhKj8QCsyafHV/
	A5nBkHZz1j/IZqKZ8hQiyezro9otrEcldmoy2/52l9mnJs0DwFVJqCg/e3xAm596uK2St8lD24H
	bcl+AJJAIU4BV6aSwL+A+4kyexsax4CrZ4xPucCvISI6ScIDKp2ugsp4leIMKoXhter1HtUf4BI
	tXTDCz7mDCd1rJ1Hw1Llfc/VT4uH7ZkdjFEV9nN4aHiMvv9Zl18OX5leUEbNcHgGEGV4rmXO7n0
	+TCoZRLsQNHRgC3cUVeYaGtTGMHWKhcAzi9Wn0/ZqS1dT17tm1n7HO9WVuYC+FLLYDuH1BmxHE2
	OGlKfXXbvDq
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3acef19656fmr4952624a91.30.1792340785847;
        Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1981sm12210945a91.2.2026.10.18.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Oct 2026 09:26:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <49d1de69-ffce-490f-bbee-80513cfd0cba@roeck-us.net>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>

On Fri, Oct 02, 2026 at 10:31:01AM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Applied.

Thanks,
Guenter
