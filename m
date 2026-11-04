Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800511;
	b=N8uVPhfomaZRPnNAB9fNpsxsbr0z5bN7r/lKO2vIR5wDWLJ6wg7s2UGO2VW8FXfc+wMz
	 pMp7WDdOdqK1PJJpAaEz22ssghqaPLIDq7hdJAu9+bbQv2yVqP7+jEaA2soLjIvhX9DT/
	 9Phw9XPcaRMwXcyrB6S1pjipV/tgCTwcaHF1LHHGgaWjMl+aKhKGUGLVVHDJPVDTXQ7QS
	 7qa6jmxLNw3ElEoN+2MuXKNtkyAHFI1nS0Sgtrt2CZ2NkDW/IzKUWy40aEbzcrq2C954l
	 Y1WJOdMyCpp8VE3pR4Lft1o+goEx3mT9Oy1Vzylkt8vthY3tWPWDnpXzr14EZOeCg2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800511;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
	b=DHFLNedkRgLRp0B4vfhkDWH1Qsf8DxNukV36P1qW4lUhyGRthMnw9DLbTDqvGaz+WUn8
	 xT9MGC13rAdyWzeZFd0AMc4uNQR2DB7IJr8bfLl62cpHGNoQYtKAcZnGZFhxtIGcojNQN
	 5Zoz747Gcs6XD31mobsHErIeAAZgoUokG4K8+RxRxbn/dgDzhIp1ljIRFdXJ8N0FmDKK1
	 By23vzuFzquETjj55FrwVpEmaRmVM0DLcs8T9P/GfM416XbkEzCKH9qzmwbZgIYEuuCa1
	 4Vyx944OGXOueIbNGd/ErZkLJkqnf8VFPxxhT3aJWxQmGUkn4TX+yvcZPTL1yGcQdZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D793606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D793606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so1068534a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800509; cv=none;
        d=google.com; s=arc-20260327;
        b=ObGj9dnLC2Z39xe3CY6os2qK/GzEWerdhZEqEIh/y3nt2Tu5I0VIhdKwyilS2Y2fut
         U92BRLFgc7wTdKdLulL+nwsFStWWS+AJ38pAkXkbhN2j9EQmpP3cnw0TVSGckBOYcZ+c
         c7LgoDloRCzIoIzdyf4v1N0NcElTeO7yjZcH7+UhrV3q0oURQzoDjhnfcBqMH6zTSyO2
         zqXt/g6OIQym7/cTA+wOH5zQA9iiVVoIuqDdZRMfN9CwkeIclAA34pT2EBAvhLiISPdg
         ASXuUXV6lM0q2b0am995Yw6Q3RRuDHi5b5xnix8kcnUGAWhE1p6C/0ytCPKZj3HfYLlf
         bjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
        fh=6xcr8MPMOfRhtmWf391bS+ua7NId2YVSSJB1zqCoGKc=;
        b=bJ/8KoE4ATYYBlVrKY7iIqvceL/WLjnsfAfWd4l/Q9bKasJatRK0xbkvgfeD3D6zAf
         qq9G+5+KxScfEG5aX86QCQeezpUCPCZmc7Qfma35DEqNA53mOYW03N1jSsDKfhKd2kEF
         aqk70hHUxhxkhUcaymbFEkZkftuXhBIVLuWuB4/7qwA1SWqQw6MnkItLrugttHA1IfrZ
         YvcQjg6q6xO2mKHjpO3POq+tyRLQhavrVkNkXPEfd7yIBLpSnb9Wwv4i0HtKMwXTP0oS
         cH88U3/cMCW6ryfW6QXDxhEUG1G9WYvC3ThLlaQ9862x5S911ezurqfgW1cW3TidUErK
         LUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800509; x=1794405309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=maDQ2WD6HiiRMLihh/6PlAJLLE5S+DKoSCvfTu9OXko=;
        b=tiXl/kxBjejCHryvfndOe3EeT5mtJtTkW5LuSoL/IdQIVq2Nig74SEuJsQrX43L0bL
         vnQrcSMI0tc63xcyrbne8PWBANT5UrTTQ+MdYaGwQzhzqNO3artQJiQ9g48cfsGfbWun
         kZe30hUsdNZyy93zpt8ZZHszXojHVHr/yHtkvh66frP5xO34li8QW9a70849QzCyg9O8
         2hJbsw3BlXKoHngK/Dw0cnN3LJXXU6f3uI1Jn/QNJANRYjQ0xlmDO25A+Y0u07RIhx4+
         Y8mUZZU3OMMLmP01fq/n7rkN/auXIXPq14bJBNrJdIuqOcE+F+sQZ9kI7j0I9frzUpEu
         DgJw==
X-Gm-Message-State: APuU4Z/jlXKigzvtpIgD70svXCj+7qF07jyozplCu7fh62rqQlKR9YPC
	gJzVKJnzNdibm6Be+8uIXwyPPunR41fAYQ9Jhizagr5+JPQq02YRlK7lYCMARDayoxSiXRscYhI
	dp9l698/kR00AWnFhc9j1XHgVdJjc56ZLbjcY7RRMeA==
X-Gm-Gg: AYBFou1RB7MUT4NtSjBqkTL7Uqzh71NSu8WeM3prwTmUkZ9uO/9ws71qDR7IJ23tlIJ
	IPY1oTCQOlZRxT3E5+eAhYPe16+1TdUK6kr64rhR2phENNBcX2uc8XU6U2AG4+DTaRF/vhQF+ZP
	EihOq63pOeOChc5in+Cg+LhlZJhhtmkTyHVxDB/vnhKiiRH8gfNxzJYghNdsFdM0+QuRO7Z7uDK
	7Y1vkNiSf8/NU+ClQY+4Wfrvd0+W5nZ+NZTLJio0iGckiyk7wF6vTOc08zGZcSfCk589TOCsDjE
	Lw43t834mKUlUdIC2T1W618J1q9l3hKbGGv0geCZfcWUJFm4c69paOHAvYweWg7ub7WitcT8w8O
	Kbh0gEiDv3T0atj9pKAGs/DeNw6KfsBUjKoE=
X-Received: by 2002:a05:6402:1851:b0:6b3:f7f6:649e with SMTP id
 4fb4d7f45d1cf-6b4d438aba8mr8776244a12.7.1793800508173; Wed, 04 Nov 2026
 05:55:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020190319.884375-3-opensource@grische.xyz> <179279532326.3134.8925339564776340456@kernel.org>
In-Reply-To: <179279532326.3134.8925339564776340456@kernel.org>
From: opensource@grische.xyz
Date: Wed, 4 Nov 2026 14:54:41 +0100
X-Gm-Features: AclHuK-Y4PhN7UgN6Wg1KVGHuCHUflIixbfP_eRM3Iuwj9ty4dhSxmMFdf4CmYc
Message-ID: <CALsH2cy0Pn2DFAjqb5H2PR6o+_Vr=ig7bbL9-RA82sC99wf50Q@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net: stmmac: dwmac1000: don't discard frames with
 only a checksum error
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de, 
	stable@vger.kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aaro.koskinen@nokia.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Can this mask let giant frames through when Rx checksum offload is
> disabled?

Yes, in threshold Rx mode. The dangerous case was a giant frame that
spans two buffers, because stmmac_rx() parsed its last descriptor as a
new frame. The same happened without this series for any frame larger
than the Rx buffer.

Commit 834ec9530832 ("net: stmmac: drop split frames on AF_XDP
zero-copy RX") has since fixed that in net, and v2 will be based on it.

>
> Should bit 7 also count as a discard reason unless IPC (hw->rx_csum) is
> enabled?

Bit 7 alone does not identify a giant frame, because on cores with the
advanced timestamp feature it reports a timestamp instead.
With the current code enh_desc_get_rx_status() does not know which core
it runs on, and it has no access to hw->rx_csum.

A giant frame that fits one buffer therefore reaches the stack with a
verified FCS in threshold Rx mode only.

Dropping it would need a new parameter that tells the parser whether
the core has the timestamp feature.
