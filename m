Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F123E49EB
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973342; cv=none; b=nZ7zziFswcLA2TELiEKGVuaN04igZuxa8go0By+jqbLZIct5XjKpib+2q3JoDIQ5PEecRWdG+n7Lmolslnc6yyNz4TBZtmoBf9xut5Gmt2zuMXt+PhhlTk61YCTNnWnbZfV0vp4Eif2qpdzve+6jRnVfmDYYEmzI+F1WIAzf5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973342; c=relaxed/simple;
	bh=sIj1ezOBqpeeSAMqVw7HYdm1cxc9CSBD5YyTXljllaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz/xePTVQ5fV4zQNC9HbrsHSyLOn65lSbM1/SsSXJk7tIc7sgJ5YUnpTbGYU31VHL0cJQs0zu3Iqx4gdL+MBZOLxL/1JGyk//ToHG1l+8USRGxOXmWA/QUbP72iMgZNN3ARUiywShXY+/rE+hdDhG4YYiVOugIaRkSHgetpeJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl53dz4t; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl53dz4t"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e227422e3so40885466b.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790973336; x=1791578136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIj1ezOBqpeeSAMqVw7HYdm1cxc9CSBD5YyTXljllaQ=;
        b=cl53dz4tNptD+9Wr73P9EY4rRMOunUmiyTLAdAj1jgAs2km/eYeKI6GoB79AzDSFjW
         /KAH/Ninya/7trsAJrYApMSlSdZszCgxs2hVHN+qfqp0jzTSVw7CX/6iu7lkO6XFiCFh
         CLvBuSg4sDXjkzITcb1WRlF7YUdlFJd5/UGywJhbtzzOzgkxlXd8Z55xmO4N/aaKP1w+
         kEoQ37FpCYV+HcqFB924T4zSE8R1CeEipbs0NLaKSS+CnObtOCVVDf3gADQhBojXyNcu
         5eWGo5wRZlYlqFeMi/alKPrYelB4YdTN+BCgqiRbuHtCcP7d9Lh2jKQPsPeeR1B0BDgY
         UJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790973336; x=1791578136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIj1ezOBqpeeSAMqVw7HYdm1cxc9CSBD5YyTXljllaQ=;
        b=Nabcaj89sGLG85kzCuAwUrrmmCubaaL9JDNqJqsnb1wuhOw5Wh7YxuSZFxO7bPF27O
         IkM2fForsBXhMNTn83DdA6XsYhnJcd4F6iLUnA6VP53SMGyzE0qvoqh/i3PoH569x6kZ
         GbRlxMnZa/jqGh10+vQuKccOYhYJ60DHoYA7A98m6AvqviiKxKZsvsZKr2uRN0T29ZSF
         LmBYr6Gli7LIEiTcq3YvZ5X+W6WoSCxezm0Xe6n4kuHAq/GkLH6itUpA40PPy+JoPGHc
         tX/t9yy+vAukOumAg8xxs4TpMNZeK4ZotU6agO2Zgw5NBNNIRiO7PrhQAC6e0LNb9PKp
         5+tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhYRAaqNzMx3wKmPljvlkVUY/bsVZBHqRRa2apwhWW8BYTIr+Ux4OjrYTOcYeLDWH5DOO8cEs=@vger.kernel.org
X-Gm-Message-State: AFuF++kNMn0OXcveur7RLjqmW1BXKJI8xmg+I0qq9cN4hRlG0yVmYj3K
	HWwGdntwdph79YONHrbi0t9Q6POVvZInviWYbpAP2PZ1A1PlmGkVM29o
X-Gm-Gg: AYBFou0fAQBjw6ruGSvFRJTDyibuMlSjUf44zpE/b+yyVZhLGope/Z8wubcjAkzBmhu
	08PZolucCScLxl9Ld/fL1UBa/uad6EdQ7QGd/juJvCd4DTxEYRF7AWb/6RCxzGz671hG58q4SMf
	CiZMoVE4ff36O5C1qwqLH4e3bRw5xFPmDVdf5Ny8eCwIZI1bjAHb1AqOkIilK7CH4REQpMJUay2
	yBiw3cFNog5vfMNtgxiYpIPAl7xsSgBIEQmlilI6hVPu5Ql23EeVdAUEXE/SV0eIuPHinJaM3EX
	QcHSfnSMLITL2UK6tRQ2gNMXADwXa+/rw7+6MHQ1GBetmCxWsnfoW8yxOR2VlF5a5Pu3t/Y55gs
	fMV8UTJQifmE3Mv0aDuHJhaC80FZd7EIDmbbfotaY/9q2P+SsEmg0tTmEOoPejQu2jG1wVG2uHa
	GdJ1KsnIHC5nOKUjErYXjjvae3oxJ2KNfRVJ/WR+BnE5Q10T6i/yMhF5xYPHyGFBjJ0xSmFDvMH
	9V1dKMAVD7KJgEjumfb3CRcWJG/zdT/qHqdM+EcJWUXXQOeXFQ4xf7l76M+0OeIKaLHfjbLoCwX
	dxetBDazgbbRziSeFuH1DA+0tvIo2JRq8w==
X-Received: by 2002:a17:907:6d0f:b0:c2e:4196:b167 with SMTP id a640c23a62f3a-c2e4af2bd94mr289331866b.18.1790973335924;
        Fri, 02 Oct 2026 13:35:35 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-206.cust.bredband2.com. [83.233.130.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4da9dfc2sm127854166b.5.2026.10.02.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:35:35 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link status
Date: Fri,  2 Oct 2026 22:35:22 +0200
Message-ID: <20261002203522.1219-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <7eed302b-d455-447f-9ce9-f15468b9792b@lunn.ch>
References: <20260928220749.857-1-yongzhao.derek@gmail.com> <01a62e77-6c4e-4665-ba46-26d12b1c77b4@lunn.ch> <20260930212348.1919-1-yongzhao.derek@gmail.com> <2ea832eb-33f4-4bf3-bdba-5d983038d012@lunn.ch> <20261001181634.1508-1-yongzhao.derek@gmail.com> <7eed302b-d455-447f-9ce9-f15468b9792b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

> The traffic failure was however because of the error with setting the
> DACs?

No, sorry, my last mail was not clear about this. The failure was on
a QCA8337 user port connected to a NAS, not on the IPQ5018 CPU link
from the DAC investigation. With the same OpenWrt 6.18.52 diagnostic
image and unchanged DAC settings, switching only that user PHY's
read_status changed the MAC speed from an incorrect 1000 Mb/s to the
actual 100 Mb/s and restored ping in both directions.

> Reporting the correct downshift has nothing to do with that, as far as
> i understand. Correctly reporting downshift i would put to net-next.

If net-next is still your preference with that in mind, I will send
v2 there.

Thanks,
Yongzhao Chen
