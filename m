Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B993368291
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254997; cv=none; b=P3H0LXfYiEfYBO47cc8wFYPwT2DIx8H6DxjmSm3i54/wIH3dKWf+dpb9msy+6rt0DAa26FxttlRsVdmDk4UyeG1mGEmVIhKkJhjiY30yBTgFdm3EhiPRwh0TD92dxAsNMrj+Sxnpe7Jo7CYul8F29qEgxeCtmTWX7Khqz4olH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254997; c=relaxed/simple;
	bh=VEtKYItgvF6GpuwE9OlSTJxtu0/qIWoEYNaHdcweSj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKJGT0Q2Sdpj8AXqnPosbGScn/zBGZVE639p1/+Fvq/PRKnzf3jX0YEo2P0QrDCyJ5sRy9iEyg40Y+wwUZ+N5A2MtAjx/eyVE1dzIlHCn/+LYa69K/0EXTYFKYB5GT+okItkV/mbFUKVXGMmlL1eJsVUEJD5ilGnVI7Y1NNFSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=exmQZhYL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="exmQZhYL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso5696841a91.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785254995; x=1785859795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKlkS10WHow2oZrmc6sXzbA1EKchkKNr9Oo/Gx0jkgY=;
        b=exmQZhYLEswmqDMMmoiLhDwZXpTOM1V/y/W5EbqXHIVCO2zq1Fou/QkLJSdm2D1B0i
         Ugo4o4PUdMQ5yhaanFzhgLmIegFV95DWaWNPNPTmfJ3pmvZN2bM+7m0/4j25vyc+tQXP
         94I6dPTacvNA9OKpHQp5DulUdHlBFhBvmaWuBH7HEZjsEb4oHZmdbZ5GNHB9Ub5rquJL
         0tAzIYRwjYMOW0ssRgFNbJkEiMK5/06pCV8wFGtdRE4h/fFU9Dz07JWCQgtXqbOSXm66
         8fs+p9PkiTV3Ddr8kMwF3R2FCjQsG34VS8P/aSWI0dgudq5zftF0jFtt4sFe9jicfTcr
         s9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254995; x=1785859795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKlkS10WHow2oZrmc6sXzbA1EKchkKNr9Oo/Gx0jkgY=;
        b=XkcW+FttSt+Fy85tOsnxhRPBgIXz6D/+7pKPGJjHZWo/ZpzP+beel71eZxRL7CkQVU
         WE0uVa5rnJIoIm1e1Li7J63skz+1OgpXy9UiH1iMIsSTZkINe2PzqZ7ETiwVw9yFglOP
         h6c/tF9rjraHM2AXssJUar4Yga5W1AOA8SQX4Jd2ojfINWibB4OUxev+Gf95Wp9uKT/y
         oPWBE30SY/MeQkyaaL+ekbNdQYsGPH1/gftzu3DoC4LIvkXi6Agk+oDCaj50EEWQAv4p
         IlayxVpYpMeNvbCXv5L1J3EtDO/L/QWaDzvkXi/CShPuB3V4/OdgS7mpP13kqu6tDNvp
         Tr1g==
X-Gm-Message-State: AOJu0YxyDmXaB9EOSiLsKymkGCrXDTgVh7k7hLZv07+yGlLtcuI+TFQE
	kthOLHPkEOmkHLdWxZQrzg4nVs0pvx2PnmYI7DCH6Ux+i2JEBr0gg3UV5VZOSWNoDuj4mULf9c8
	uPs0bZiY3C0XU
X-Gm-Gg: AR+sD11Rt0fOAU3S8EWV1whaXbdaNqpUfTk60SQtATB5iF4i6/bpbqKMvrgzmqnkOSO
	fMkjh3IbsxEpz8R1ogWDrOz7U4nTPVk8NsJaJd0lmqwQDT4GPzdZlZ3ZOTasu4w+4kuel17+zhM
	1gAfvwz2YdzmieF4P3Zit/1SPG79fa1EHcRQaW9MomZ/s1BhKwXOpU5Kr9zAhqBp8SFEtS2pVEh
	FnmwgPteOYKBkhnVHbsONgc+OmcM6iKLVIa8Siewz63oearL0gcLpC6dweXLwO3ptkz2Uz5VfpW
	7R/Q3IIhlGR1creBI7ivkesrJmQtTxzszyZIRwNrst5PWVh/mvH8sKNfTq2E4xizNHbsgaIh3rU
	v4/SgPemW0MnncnypXzSuYbtVkLuJ5F1RlrA+zFyaCfSAlQRpx0u9xYEga5bhpw2MWjeS+I7Uyf
	8J0kJZWVde+u6F7Zu9se4/Lp1iHWhqMx99L7mKZNyO
X-Received: by 2002:a17:90b:1d43:b0:381:20b:a9ee with SMTP id 98e67ed59e1d1-38f6a40f374mr3165066a91.14.1785254994697;
        Tue, 28 Jul 2026 09:09:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6d730072sm635826a91.2.2026.07.28.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:09:54 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] Add PACKET_IGNORE_OUTGOING selftest for packet sockets
Date: Tue, 28 Jul 2026 09:09:25 -0700
Message-ID: <20260728160935.4128982-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Following up on my previous series [1] and further extending the selftests
for packet sockets to test PACKET_IGNORE_OUTGOING.

I re-ran the tests and the existing and new tests all pass.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20260720122714.759175-1-joe@dama.to/
Joe Damato (5):
  selftests/net: psock: Generalize psock bind
  selftests/net: psock: Generalize stats check
  selftests/net: psock_snd: unify on recvmsg()
  selftests/net: psock_snd: Verify sll_pkttype
  selftests/net: test PACKET_IGNORE_OUTGOING

 tools/testing/selftests/net/psock_snd.c  | 147 ++++++++++++++++++-----
 tools/testing/selftests/net/psock_snd.sh |   5 +
 2 files changed, 124 insertions(+), 28 deletions(-)


base-commit: b515dc54795ef370be3cb396e7c12ad91686b6d1
-- 
2.53.0-Meta

