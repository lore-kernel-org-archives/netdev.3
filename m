Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480602;
	b=EP/gSKj2esPXJhlDXNIvI32GayAt6I/KWhfC7GMuhnMkz8j74D/FNPIQmacIMQYFpMeO
	 /j5zNlnTd1AKDj5L0lB+xh44pSMMm0r6s6wMJXw2dIaLb9DYpzQRll6FTiySADiFwBjJd
	 bkcdvesfMFnHdRHQKTHsRNSAxM+IxcvYrwN961ZU4B1en0H1aiGmsMSndlArL3OyoXlz4
	 MvfR1lTE3iU8ZNHAn7SmZeoeamTR6HrE8o5M20yfcX4r/QBN54No9LWOBtW7gWe4LvH5z
	 gS0H1JvZSEciZWscvenEntBkIv5DIc/T8UnorGiaEK4C4JaT851yW1zeP2BWx+NbxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
	b=FDZ1zVUC5BgRcuUGEWzf2cwRvdFWnLSydTdgxATXwtwxcWEL20MpQC+0uXvlYB8Gzi6b
	 v0Xn3ZwxZ/Gmtoo/ellxsJwIwIfcCEv509TAeCiYzVBrDdDPhjJTtClQUQN3hXL58jV2m
	 5SHpGj+TXFKePrKlCyIy3owF10bquYmjMntnEhJT7k7bg12w1evjNt0lRC8lBI+/llNbr
	 6wmaQ5wRBpiNsMYa9Q3txhXXAmASuFBFrYN5RBGmfR3FEfybofFUgMeFRGzLOWJrPpz0+
	 5kfa+UtYAkJey5Yf1IzIzjYi9DEPUNvnDPyokcL+zgBHs5CSN2joDEwEUyy6yOOxJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvX+fDOL;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71173606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71173606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvX+fDOL
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5295556eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792480601; x=1793085401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
        b=nvX+fDOLVa8EIMURVKrdikuXBiDAj7FaY2/kaDslST+SgmSmMyJZ/OKks8Wm6q0e2K
         n2UCBxa2OBIpkW9eD+sPxrkOsTYBsEZwjCpko3fGQy9HwjvUXhQI4H+QvMDwX38Z+1FE
         63oKwQqCeR3ssCuntXa7ZwS0nZX6ExPIzim3T+iX8ehbg8gCZleSMCoPNcySejxweVeM
         hF6gmRvSLMvJr2rE7UcyuKRdkXc9Jmbo7J/f0hpm/Mctd6J8uXomXjBPiRA8nWtBWeUB
         j6vuAcrexOmKfs+ODomSPrf90w57xSnsEdgn2hHPpw7Vk+NUnpL7Yof6c2Utx4B5xwqH
         xs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480601; x=1793085401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
        b=iRjl0Nfg60OVRFNmh1Wlu6UdL/FM2EKuexqgU3yTTsZQXNE/I1iWmxO6i44co+/DJB
         B61/a+3c4yEEZ2TuEdaNFuIZAw318/HOdVoayuwuSNVck0HO2cro3iuk5sOZj15q5vkD
         ia439eDpn5LRt+yxnFqbqEc6gZ65pJUgIofcCiRLfoLFdNjk5FJcqD5a1C1GJ3GVQqq/
         d8QIqsRWmaKwLMTiaJfwX5aE8uw0ZhwtDhLfpdA+ORFOOSwy+xeKbH3+RIw9ZI983ymJ
         vrRvXQnIkpDLVkj19YdwQA4rhdQzhCSFuHBTzGLDDHcpStANrOGPR8YS9GKhXyOf9Sb6
         hocg==
X-Forwarded-Encrypted: i=1; AKwUvBxFn7IIrNnPhspXsln7sfMEvWygMbm55A/Udkzd0TtlcSWyphesSEfFE3B+K+iUWuA5Y1tQNCE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzpV1cc8vUD2MpDb7NKaG4Inl2LO85Cob4qgMr47JDUSGbCETG
	2ky9RiSZOpoURM5MxWT97lv7aINuimnJWaJ9VXo6Tf8qM9cKZPi35elF
X-Gm-Gg: AYBFou3fnMEvc4DnikJ7nuE6X0dYw3POHXZhlBB3a47VhvxdPBOgUp7NqIzsbQ0N5RA
	l8zpPu7E7//wznAyjpilsIMxolhEQJq0vVt1YXOzES8LqVkSh7ecyeb+y3xEW5ZSQBhqJZ7aOQ4
	0bRX4NE8nSoeVLUEQTx720fVFssJrAVuiW1OK/iRBuR7RsaEIghRIot1KH4wRJMlVuGCxsj7ZYK
	2xCy2HnZ0KlqxTJh+i9pkcEC2eaySdcin9Kg0RKhdIzVZovaobHKDaSsbblTtEj6b4Qbv3u2Kkk
	d9YODuvXseje1cHm856ivUgTfwOgoNAZP/lMeonKzACfW6xRlUlo9ot+DC+BKwbH9qgOSn9v3zl
	JUuZhlNq0ucNyZlb1Lsm2j9KNHS5tUnSoOnYxr+18+xURBi3ABG9tcySAGGVIVWtVS4NLAgXZOf
	J301FgatuoeNk9X4CkPy/YnhC96BXSm6XaRb0HxqDMq/AfUWqMXsB9JIXtfra2/STOX60JRqyMf
	Q3Ak+3D/jbSv8HgjM2O1vY=
X-Received: by 2002:a05:693c:26c7:b0:35c:ef18:6a78 with SMTP id 5a478bee46e88-3619e925f33mr14707122eec.2.1792480601447;
        Tue, 20 Oct 2026 00:16:41 -0700 (PDT)
Received: from CHANDRUS-NITRO.localdomain ([106.200.8.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm38434543eec.19.2026.10.20.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:16:41 -0700 (PDT)
From: Chandru Gopi <chandru.gopi.dev@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: maoyixie.tju@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chandru Gopi <chandru.gopi.dev@gmail.com>
Subject: Re: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in the caller's netns
Date: Tue, 20 Oct 2026 07:20:44 +0000
Message-ID: <20261020072044.4971-1-chandru.gopi.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020065125.896530-1-maoyixie.tju@gmail.com>
References: <20261020065125.896530-1-maoyixie.tju@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on v7.3-rc7 (58161ead29e5) with the one-line change from this
patch applied, in x86_64 QEMU with two mac802154_hwsim radios. phy1 is
moved into a new netns and NL802154_CMD_GET_WPAN_PHY dumps are
requested from inside it. This covers the first two rows of your table:

                                         before       with change
  ifindex of own wpan1                   ENODEV       1 phy
  ifindex of init_net wpan0              empty dump   ENODEV

The unfiltered dump and the init_net baseline are unchanged. No
warnings were printed during the netns move. I did not test the
non-wpan ifindex case or the unprivileged user cases.

Tested-by: Chandru Gopi <chandru.gopi.dev@gmail.com>
