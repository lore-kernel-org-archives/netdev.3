Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489374;
	b=Sp0Z45GYrxd67VKSA3D5gqUYy169h28hw/DsZZpUA2tMK9m65lP+4oDjh5SNXl7Wwsfs
	 +KSpWVjt+WE4qqgkStq4hkuHDif45rD2zpK5vgKsaRHylvaLbdcq3Q7hN5H2+MSq8o4E4
	 ix6zhqHLEIeqZNmGvQEpDodx4xLrfcTs3hOXpLoFNfjLbEzmVcuuXqtJ68ERy/T9TnJJQ
	 O6+cwjSbc7HWH3gjdurUx4iKBHM7QPSKhZIwmadnFoZnQWxqAFdJBWoUIIkKEkpV7Nrs6
	 PP0Vfm4Z+8gdtWK+c8zi65fhOOrdrFXv4TMhHyrB8IVd8a8aTM6V+Vd+/+rJJw01AEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=hCbUxcv8PbA0/Bkjdt1CJFKQOySycR2dRl+EKmj6s9GDfHDp5or4KNgsdrj7eyH5d+Za
	 zQIc4COZZF62r5fTcAdL4dI3GyUZ3PB3/6XrE4n2aooMpGIFL+4OxILUuOK/s0so7nGns
	 BRH8j8ecIM5VDh8jYWC+9u24moTvq1T5FkCXpn0oNHTcsDgx5bL770zu2Rq7Y1UidQxOY
	 HyJ/hkfS2fuybmyZJFrPe0NZHq9q4qURF8ls4H8gFPIY3ZVpbQsAjF/bg1dSez9biCh9I
	 PamU2wcIqoQZDxfQLyHsOrUbH2cJiJyQANsBd1sLeGYdYxi+BeN9tADLmepeAUYIFvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osdfFHGv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133C606A88C;
	Thu, 12 Nov 2026 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osdfFHGv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836401F00A05;
	Thu, 12 Nov 2026 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489373;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osdfFHGvdGVzpolaHtqWua9j4Lps+/X9kP1WfyxxUV6yqWb/is9L09mQptcR0LR7e
	 byDfPXEwbQ4EToiojG9mv8EQmEb7UiHWgmLhnhGjJWqeqNsEUkGnDJ7P6uN2n7ZPKe
	 guuv/n5TpvTozUM8RCy4tS1P9OsVZnE45bFHKN9KE440uM8BY3ynY22vtkvjQvh2g7
	 3B27ovIFretMJf4SiftxW142kle+qgbgDqFE9LazkSHHQru9VTMXsSjG7aPf1jtEGE
	 jY7Lg8bDo7ld9ZENhiBtWW3kArCKYOqAGH/akXqcyrIRt3RkxO3ofVCEFvZiw/wrio
	 R1Oh7F/x92nHA==
From: netdev-bot+sinfo@kernel.org
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
 Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] tun: disallow setting ARPHRD_MCTP link type via TUNSETLINK
Date: Thu, 12 Nov 2026 13:16:13 +0000
Message-ID: <179448937301.2168702.18016211527226138253@kernel.org>
In-Reply-To: <20261112131056.234801-1-skalpesh942@gmail.com>
References: <20261112131056.234801-1-skalpesh942@gmail.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
