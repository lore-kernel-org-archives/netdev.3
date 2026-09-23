Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BB486402
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200660; cv=none; b=fXLhD8uQP0SnH3RXYSJI8QTl78aGeu4aRFupc0f4KMVxbagAldGuUQwl/lO11a4QUydFvZ3eIBr3sSk1RwNiKGMNlyH+vGrC6a3kTEzTD1S1rAg7XjL7jdKxRHoW2ExL2dwaHWCmS6SbmZp3uJGpH46QHYG9lo6ORb+JUD3rvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200660; c=relaxed/simple;
	bh=cUZjHs3mpi8GlrTHvp/qKdZUSHIr7HM7U4TmVNAjihM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1UBUMJ9NxaMudddXCCbuWm/2BbAgooQ93cTndt2F8XgvGCjbwPpUM9xaBU33hooqo1lSNlWg9fNNNbI1TN1kk/MgDpVQeS+7qrd9RsY+dqeqLMJsmn3zzyE7F2M/T85CZgGNXTb1dNArnXZWTtv2oaO1YvuNfL8o6sEgHtJNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzv7CSIo; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzv7CSIo"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso217670166b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200658; x=1790805458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cUZjHs3mpi8GlrTHvp/qKdZUSHIr7HM7U4TmVNAjihM=;
        b=Yzv7CSIoVvVf/wpoZucp64JGK4KIm0oDXKJ7FnC1em36Di5NPP9olBKksqfqmXUY1O
         obxU0jb6r01R2PRayUlY48Hj8jcbDmaqeJsHnFSHOkJwvTDhWY1xUQl81OzCvYLockHf
         B4AJSkRVCAbyi8Wpr/9Cgn9H5HLVO6tZE6KKFk/PQSArDwNP3Cgo1YTsbGkBpt2CnqTV
         mOZYLO2gmQSLruMOLj24FAqpkq4GtpdK0zoZEJrZsF9TcvPr/t4VrNt4L4jEtddntMH2
         8B5VYhIbm0G9fnZg3MPdeGaRgSuud9MFCVXruGkh2h2KIAc+5GhFRgjMhgl0n6V+pGLI
         BEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200658; x=1790805458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cUZjHs3mpi8GlrTHvp/qKdZUSHIr7HM7U4TmVNAjihM=;
        b=Dw9lllIfrvwL7mewsNkkYJ21+SYfJ1l+dcD7xgClc3dCspz+pERHE67zwsOXkxCRnI
         IRsB8J9ORlHc7FOOh13gl/JPcYwUvv5iroEkTIK+5VQZ5yUalPaKH3QYLhbhhLAaB/kv
         MKutcdcYoS7i5Gt0tUElCehmDzo7RzfxVUGkwFpn7N2sCWXMsnKd9Y+g61lHjGV1vJAm
         Ayq/UBszN+Mpu9AFbhkB/XxSh0yGAImrS5lpovS4E0zludvciO8li+wm+ijQIpzC1lxV
         SPdNyNlf7w7rmA+QkgUWnRRVftU6QI8LcScJICirX2KOzZeAHWLrDcXlEoxoNn08q3MS
         VmGg==
X-Gm-Message-State: AFuF++liHAyEQq7riWYJbQ61CiWj9A6h6B/sjhl9wm/GoTcdctjIYkNF
	SQnk9LuqERgG43NEoNoZ1dkrtmMYwlKBNzBuhXeiX57jnt6LGEJMmu4y0pjiaiQhDLID0g==
X-Gm-Gg: AYBFou3YdIgwo7T1ExmccY1g+yYv40lM0G6yZRe9qAXHJK/0d1wE6BubnITXvKwceBj
	jEbbLzNYpF/4MstH1F2kL6M+lX4uHKFUVSo2bJWnJ3LVmGrP0mJuqVxczNxjbXcdadMjAifExER
	rBNB+eyspWPFEbzn3lTbZrB2XqPUvpQepbCFAalkavInIcGT3b5iRikUvfbd/oqEIStzZltA68m
	6djuMhRQCXfCt6BawjP/RLMdeq7jaIzjA49BwQwvlvf8uev2s0chKwDTAbjblzPD1KXFN6UXvbC
	UXcSwsKQXd51InlrgkFMvJyU98vOfVZ1rbH6GupFUEv89PIk9y2PLLKsqYdQY7dRd6Mt/Pp4XVZ
	L7yU4rtKDie2YeLC/Nmj1dHWUQ7lw2VGuURZDIZtAgm3v5Cq9gH/KSrZsgrTKawkaiRW0j3dFAX
	qOy1Ihm0axZZM9xRoyr41SQj68uZnxS2isB84sEAfJoRHHm4izc3V6xIjIBB4QgWA8OZErNXkBa
	s09rcXZ+kQxKCWLpij3ZiMP3sYCS2nyU1vwVlTEaGrsWachqLWvZSmnq+rGGWxmWwV3z8UYrMOt
	31rj8UFNhhjL9axnmHbeCQ==
X-Received: by 2002:a17:907:86ab:b0:c29:3ea4:a219 with SMTP id a640c23a62f3a-c2ac254cca4mr33077466b.44.1790200657642;
        Wed, 23 Sep 2026 14:57:37 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6d7067sm198852566b.57.2026.09.23.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:57:37 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Ziyang Huang <hzyitc@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH net-next v2 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Wed, 23 Sep 2026 23:57:23 +0200
Message-ID: <20260923215723.2044-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <e78c661c-67c3-46df-acb2-d1fd925c4549@lunn.ch>
References: <20260922202653.1153-5-yongzhao.derek@gmail.com> <e78c661c-67c3-46df-acb2-d1fd925c4549@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

SmartSpeed is the Qualcomm PHY driver's downshift feature. Suppressing
it means clearing the enable and bypass-timer bits in register 0x14,
then resetting the PHY. Patch 4 marks QCA8337 internal CPU PHYs for this
treatment; patch 5 performs the register update before reset.

The v2 commit message claimed that waiting for the conduit PHY caused
the loss of Gigabit advertisement. I have not established that cause, so
v3 removes the claim.

Thanks,
Yongzhao Chen
