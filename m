Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C21D89EF
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787186377; cv=none; b=cAu9ldklISyFHsw379mLOaKwEHCyIcYCsJ+h51P4h/K8jLguQEFcEl1GOjsjiUxJtIpZF8jSZiag+a8eTnpkVtqxNkhefK20mWyrspsp4WYt/JlonUG6AaK2XY+7QEuQ5gvScoHnHyQJIcFQohsNe1Batq2l4pbdCqhkLCduUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787186377; c=relaxed/simple;
	bh=H5Ia8YwPPiXAVXSD1CGGYaOGUaWGy8snBHtg1hqufAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8n+R13hrSKd2FzJ1wf2xSplnb9vjUku1OVItvZ1qcmvwls6ZiBC/UDaLRNlfVdVEBEfMyZMxFBnfRx9IgvDz2dOkqubuDrZd8THqgWdMSgvvD3j2rmilWSqUhJkI/YfPVdx675W9biVyCPilM3M63KaVsfwC78+gDkol8u1gYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icoza+En; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icoza+En"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc61541f8cso4860105ad.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787186373; x=1787791173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ED8wIBXH7n68xgDf6ufHcXNAkg2WsBWchuI3Xh0PEg=;
        b=icoza+Enn+GTU/txk4PnBOIH7kjurbtfwbbYgsJr5aV8rLWoZXeXgf/kaXXHpcVbra
         V+tGCqBcr0RBvBmUidQbH7b9hyOmW9MC0AxfohMIEA7UKDkg/W75m51NIZcFfc5U9pdG
         JuDQh6tgY1g3FoTDiIdB1UeM6sDuX9BJKWeoh7I6Ws8LucHH08Wzt1ROPI4Y71Zgrmi7
         dN2BzmRKQoggIzSsgIkLvzGH8lKxf4NfvflWCsgeppwq9wdVIsHAZ+EQtBP02lilybbf
         1Nj1RO/Ozo+mdgKT7fVALE+2JsVpo1a9/FtgkdGWO1NQ+T8eAyFUgbpxfLh8Zb+5yrkM
         2GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787186373; x=1787791173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ED8wIBXH7n68xgDf6ufHcXNAkg2WsBWchuI3Xh0PEg=;
        b=Mv57aLeddPtJjz4MNpESSq+M7AismlP6qZSJ6m1kYNdo3pOEa5kGFzErEnloUEdGa3
         Igyqcb2NE2uG8bFR20GSA7K7j+3vE2v5ZMN+wmEwlH4hBsN791pkzCZIbNNQF7BrEmDE
         B2C7spmeeS1VXjL0BY6cUjPY1b/2vFTQ/4CWvfTowF3Zx94lkB3NE/JUKdBbjO9pT2pz
         9uALxw9uJu9Vc8mZ0LE1a2NJDy66r/oqTajUrxu3ZaVYXruT6xxPUNJNqVhyMYeMsQii
         WJgF2eXlcIRytPqJWcS2r6cbpeV8jiL3wLCI9OBLspcWw3+iZTszBjcN1D3lAQlWX22p
         rJpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtQOLOMWTv3/X+AHt9jXeKfsYX1CNrdcZ2czVPKMEy6YOj9f2kaK1tCT9RyHnBoNyNAPdQipM=@vger.kernel.org
X-Gm-Message-State: AFuF++kz8AvM4ho5+yQuqY4bnTQxzGF5DCTsrsBxW+WDfHlaUJqTyTgo
	E3LGypc1dXcUJUGrqq2sovNnzRwqYo7y0kZRDcBSHQgFl979s3AZSdYB
X-Gm-Gg: AR+sD130FaFabJUzgGrgJoCiiCA27aBzv4CDhxdDheTY7VRN5T4J4bXNngK8x+g/NAy
	3PZsLWu4MkLktHDcAJ7h3+kuWAHntDTsEJURNeegHXyLtAOfIaSelY2i9gEb/wWXieFEmzt7hcg
	2s+NDqNKlo9r6fPtZfhK3bO1dDfyWmHk89OaORCSkR6Hhcpy4rbVWlH1ICzTAm1bFrJCAbypnw4
	QXKDx4SLqJVD44amGuOYos+AsT0G0A0bxssZA8wt14mjAzYxJ/rkzcvw2teuXIKuuLChmghXdQj
	omgTjsEdVoeLqUXcsLHqVjo4wcC0vss0sMQFOkPf1ZNGh2k4VocsT36liNkBWuQ7U32gsWB4oqP
	xJXrwxDFI5MWOSv7cpOu4o6CDs/c9X2B8wpqd6ZAddbitjP3ONbjTykzOnGYa2+nf16IrYFrDzx
	+Cpx+1G1b5X6ZWMD0bWarZx8tTsNTHFxjljqjyylS6FGPgSYy1x0h3+mEwqzbTaPlY3rRkUk6iQ
	N+C+rGG5O99+VLUm24RJn4nsmWc8XXi2E1uGA//9ABBXR4TytN9DNlhyXaKHeOu/z4IEwKWAQCD
	VVZC3h0bu3ns7cvpdG2zrZNCPUoMebyj5wM+Sgj8tv86CQ==
X-Received: by 2002:a17:90b:1d51:b0:38f:cfe2:fd3a with SMTP id 98e67ed59e1d1-395a06b9c5emr3604606a91.15.1787186372956;
        Wed, 19 Aug 2026 17:39:32 -0700 (PDT)
Received: from localhost.localdomain (2403-4800-2450-5401--b311.sta.dodo.net.au. [2403:4800:2450:5401::b311])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm12191776eec.4.2026.08.19.17.39.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 17:39:32 -0700 (PDT)
From: James <aslan.jnn@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Date: Thu, 20 Aug 2026 10:38:53 +1000
Message-Id: <20260820003853.39357-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260819124307.7a9ec5e6@pumpkin>
References: <20260819124307.7a9ec5e6@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David, thank you for your feedback!

So on my test hardware (AMD Snowy Owl SoC), it is the former: FCS
validation is actually disabled, and packets with bad FCS are processed as
valid packets.

Concretely, with DCRCC=1 (the current behavior):

  - `xgbe_dev_read()` treats the packet as valid: the skb is passed up the
    stack normally (e.g. `tcpdump -Q in` will see the packets with
    bad FCS).
  - The RX CRC error counter is not incremented, so `ethtool -S` shows no
    error.
  - Since CST=1 (CRC stripping) is also set, the FCS bytes are stripped
    and are not visible in the captured frame from user-space, thus
    user space can't tell if the packet got bad FCS or not).

I verified this empirically: if the link partner sends two identical
packets, one with a valid FCS and one with a completely inverted FCS, both
arrive identically in `tcpdump -Q in` with no way to distinguish them, and
`ethtool -S` shows zero CRC errors.

With the patch applied (e.g. setting DCRCC=0), the bad-FCS packet is
dropped and RX CRC counter will get incremented.

Regards,
James

On Wed, Aug 19, 2026 at 12:43:07PM +0100, David Laight <david.laight.linux@gmail.com> wrote:
> What actually happens to packets with bad FCS?
> If FCS validation is actually disabled they'd get processed as valid packets.
> That would be a serious bug.
> OTOH the rx status could contain an 'fcs error' bit that causes the packet
> be discarded and the software counts an error.
> That would match the historic behaviour of many ethernet chips.
