Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441097;
	b=jAOSjn91YaMWdHmjrsPe4J9BWHVpoMYQ3JMH7P6eI9C9guFm68aGVvtH6n+i/RSTWmwF
	 4bpVBEFIx6kSYMSiPUiLpg8MGaJYhj55HCblCHQazA1YOqYBPoyfajC9FeaUgJTQH9gJY
	 fA3w9lATBsy9blSYKKK8zGdihs4kSA+DNiPV3F/H50roxVux103450Wrn1SXXLr/hP+sp
	 roulHs7VuFB8CYPojEmvO48mUqtiPtfaKPCUKwHYkoTL0KEILGKd7graI2jhOO9zm37X6
	 WhM0CBf1JO4YgyIEbulM+bhcbfgNoUpf552DkrEts1HoFMGtkmwHa1dUKT2Khgq5esw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=hPoMjE8AetyVHmCDrslXyl3snmW5/vEA4DnyWC83Ztc//+2LDXkw7RSRfkVXwA7N9PT7
	 XYXmWqXBzPHeDcnzkWZZBoj6mwLFAzUwueVTzl4FnxXdHNxpO3L6VD6skuHp7PlD6MdAQ
	 luuZbTjNyE7vHMjq6zsLNg1tN5VPZEq2nbhEnjKJONNNroV3YTfsQD/kfStSsuQ1zKydN
	 XsqKsd3MSr4xnHQHvX2eSwjEUbVohDIAv9qTX5/D70rK0jWD0GBTAUGdFfsKLvIeCoDCs
	 lP/MMYksuqwGLkwNcThT9dR3DoUOGpe+RDBP1ELLwCrCLpcYGY/+MQJInrKaP/DhiYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFl+UB35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24A606A331;
	Wed, 11 Nov 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFl+UB35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C8E1F00ACE;
	Wed, 11 Nov 2026 23:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441096;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oFl+UB35XlTkei2dg8HWPlfN9VCn1rCsmTeH3H5IzZrlXDiIpiE3v4m1lIAtF8/Rw
	 3bBHQ6syxx3BJpoLKRfkjTNirAkRd2ukxnqCC8Hb4Zy6THfbM7E2uyN9mGsN30XU0m
	 ie0UWfgRC4FaOTZg26Fa/ePbfiSPP9I6nXRPlD4g0mXaTH4Sv1t22MBW4GIopqkKMz
	 6wWWpxkjPXFx9261KPn+N53MS/qyqvoFAxelLGstkPooD1KMKwPuvMSedBPZR+/JPL
	 95EtJZWyNStqPbp3uaEbPGybCr3BG6SPbKSKZ4zIPMFu9x6ejfpZ7iVqqDRlNeZki9
	 Z5/I0dKHInjcw==
From: netdev-bot+sinfo@kernel.org
To: Igor Velkov <iav@iav.lv>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>,
 Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 Haoning Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
Date: Wed, 11 Nov 2026 23:51:34 +0000
Message-ID: <179444109487.2168702.10631162542543162252@kernel.org>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
