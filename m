Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0349AA42
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634935; cv=none; b=IkpsgAhYS8t7Zrb5HEN3BScTGB39SGtkv4+qKvxLhWt0PBNszsUqdyORMKufUD159qRyJ919oUvdt9F5jty4mONJNbfShxsqHFAS9B1TAmPZxufLBTI2KvCN+Y6taliOiuNE/SCpnyvVFG22n1TDbB40fGhUogWEY3MO1xpch/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634935; c=relaxed/simple;
	bh=mOJQt2vsWvrLdsJ2aAlHSWLo42eJ2H0/jIjEjOIaHAE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FAfEL4Nn2TiYhb7BRQp1YHt66m98jrT08UpWsK1VsylFCLNkOWGu5yDlB4+hsPseCgARv4uOV5+Hmnu1TTQ+66AU0FCZQZeNtKeikcfHLjxfmD4pSiY8Bd0APmA0EEBqH/1tNuUfTZxfzFLgNglo7sa6njwvOFRZI5Bb0Rl3lwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4t42vmb; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4t42vmb"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so87704466b.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789634920; x=1790239720; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mOJQt2vsWvrLdsJ2aAlHSWLo42eJ2H0/jIjEjOIaHAE=;
        b=Z4t42vmb92hSSVClm8ybubh8P4qrx+xmGFBUExvsKVsFgomiSLtdosDxVHrRP1nMzG
         /+Mb/Ng6okHzVpJ93bmULRZBMRqLWziVE2eWt44+mwkqvyOsGgm3i0gqUg3hX65dLPNW
         M5WCIrqeEEXU3RZDZupJBz9ns9Shlxw6Ju0hjCH+Ne8AZJzKx/h5B5J9t/GJS18EnYdz
         NokKJ6MuExf5OagnCjBdKEZXMoCdI5Z83ulJao3dE7KbAzImOBPO+ykKBOJh3bP52SQp
         zGTYWxY5ltlQvIFyNjxFA2yAqhu9WGvEvEzwLkmxLr+voWXww/JcogY0T256VHk9E0Dm
         aYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634920; x=1790239720;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mOJQt2vsWvrLdsJ2aAlHSWLo42eJ2H0/jIjEjOIaHAE=;
        b=BxEc2l45cpel9KzNCmzEAqpa8FYZfchGqz/3fQvWdPRnGkxoWGeR0kG4RTc41Rcxzl
         BvPSm+TnOIZ0fWveShwByPHKWay6FlA2+FFwR27rGU7d4/x/D34LcDqCT+f89mUMTxtE
         Kdf9q7nULVXmrPrLcEiQTz055RkfXQ8BXp3k1XgReaxi6mg2JWfgbElnKpU6fCoaY1Lf
         LGDr1rCX0ItJGfrMHDYP+s5ur6l+BzuzarDRO1bUTLrSykyeNgs6kgVm9scr5K2YpqZj
         rkigNz7EYkCkR9fOFW93Xu2uJr3dyF5qCntV3lG0PrazpPk4SKLDOkwxYcIOyXaabc7V
         n9kQ==
X-Forwarded-Encrypted: i=1; AKwUvBylJbmetd3nbLZVGhK6gpfoqT8qkqwKzJxhLCRJJrHMzGgNf5K1Lxz1MSNpSODjGP5jfO+J1OU=@vger.kernel.org
X-Gm-Message-State: AFuF++nlzzBF5yvbZMtnEgmQlMuBZSRmet8K5sH2IaCz/hqEWM7e8jBx
	Yn62wwjglEFasB2z5tMOxV3/bygYQedjGS5Wt/LIC2E0Mju2PqKMAWGi
X-Gm-Gg: AYBFou0TR003Vnbzv8GO74gzF314OR9DS+qVFMhn8oczRLFb6hImpK/L1vg+XOvUaPm
	E+qqIJIQrQfH+NH9CIlyk8RAtw4tLPLpuPcDOOC9LVlAI2+V9UTTb63E1YkTlII/fNw0oC5RNDV
	YCmcQGjBcCxKUNHNMVY/SGlI2aMszNXyWg8QjlEgtDNpGq9iVpjkREeSy1TF63+cwdC5QRAsxc6
	o7K0KVn60GN5Z4Y32IUdPf8mWsgVGkQbaLnhN1ovt88z0hG2ChkSsMk2SWN7bdOMpY3+D6DxlCd
	DX/OU63w2cZV6jZKks/VXfIVmCWePIuKUe2FZ90LGI5Jpijy1DAcPuUh4tQujxTTT//bLHzvoSP
	l2cZWec43m8AEm+QLJ1WpBDUoHDbiWSVONwm9GCZ9E+ywvm6huuE7GeIg2CwWAsjrr0CBuDaLRH
	Kdb4VljwC9tMUpLIksZuHNv7neQ18PbRrwYnd7qcG0eFSbeY4U9yq8P3RD3G5G4QNaDEkDUb7FJ
	2GJyVQm
X-Received: by 2002:a17:907:1c91:b0:c25:2cbe:edeb with SMTP id a640c23a62f3a-c29e521b5bcmr397397166b.21.1789634919601;
        Thu, 17 Sep 2026 01:48:39 -0700 (PDT)
Received: from imac ([150.228.9.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de68fdbcsm245938866b.59.2026.09.17.01.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:48:38 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ayananta Paul <ayanantapaul@gmail.com>
Cc: kuba@kernel.org,  davem@davemloft.net,  edumazet@google.com,
  pabeni@redhat.com,  horms@kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: netlink: fix spelling in tcp_metrics.yaml
In-Reply-To: <20260729034147.6970-1-ayanantapaul@gmail.com>
Date: Wed, 29 Jul 2026 10:27:21 +0100
Message-ID: <m2cxw6i1s6.fsf@gmail.com>
References: <20260729034147.6970-1-ayanantapaul@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayananta Paul <ayanantapaul@gmail.com> writes:

> Correct the spelling of "reordering" which was incorrectly
> written as "reodering" on lines 113 and 115.
>
> Issues identified using `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`
>
> Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
