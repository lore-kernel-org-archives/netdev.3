Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F2371D01
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483371; cv=none; b=GPkZkr3Z+CDtX9wRDg72RmUasIsmLFZQOqUbiRY98VVUW8SHaz/tDkbRqy7xfwQMznO2A5FAhZREFT3xR+7PlzBd5TnO2btee4CX08A5jppwO/13++bn6lJ4R4gsZd9TCRYscLR/gdIGGj392V+689fqUpBslcDYIMiXzM/WGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483371; c=relaxed/simple;
	bh=jaBPw11WtBpAsW2lmPiE+rjzVucIjiP5mn3f2jaHqG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z40Lj7hoQTir31jQA8u8AHQz4DM3X7AFS0x7ISXjRzmplXCXWLKy14uICGEDQJ71QWVNaCx6RmNkZSV+6AHDp9gutRJaWSkFcu9Vnxs+N3TJBYw/XhkvuwD2KMJkcmLNwLzeCkrF46mkTSvZ8yZrW86q5B3ge3CV5ytw7DEvJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khhMamu1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khhMamu1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9d05so383194f8f.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785483366; x=1786088166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Rvnc4OeOnPEfVntwCGgYK4aj0ASFa6o50BvZ74uNJc=;
        b=khhMamu1MCDW4p7JdgjldDdKs4PLlwTQ8wc9H1NRiPKxUE3MapZoySbSiP4ly3TWf3
         zIV4iDPw09YbCetGl6R6hsQsNrN1dX6Yn3ItHZknaNeLOG1c/rpP6jorinWa9398KC1+
         2E58u7UszltuFM8H89hsaPlj4BgX6BCwpzQPecfR68R3V7d/Mhe+mX+FmlZAQoFF7lBL
         r2o6NUX8peM0A+pkv2EcddzbiAbEbfyuMoKw/xPJ5qXOqhpkSdr42tVcYxybb7LuG882
         0Lin38nrNHcDbAogpLAVR0PsNGR5lihM0wm0IxpTRJEP4nMvvpfzWUqKJiN3zzlzoLdZ
         sSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785483366; x=1786088166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Rvnc4OeOnPEfVntwCGgYK4aj0ASFa6o50BvZ74uNJc=;
        b=she2sf6zJIFkeg+yM++XRI9Ts130ToPcdAYj5VDp/9Mt3P0F35EEHbYJ3LQut7e25y
         X/ZnrlOtGa2RXQVgJ4akoiCSZdOHXOf7mA8WploZCLKMmcmeaXE1wzUygFUkUz3LHwTR
         zmdJTeQwZTli9KETkPDStCE7+CSMjjqJ8/pCgdTTD5n7OH9zrYyAkegBlcwrBjIMbg/z
         srPZg24MZARMWo30V7HGGt5IKkISEwYNS9eSikxXVmdIgVkU+EvOxtuYvaBaBgO0TKxc
         JNcHxQ9C4jjGbYlxbYA3DQNXzA3M6p7JMPJWPlaETGuK3sGfcZIULhtQf7U9sIH+m/vB
         +Wrw==
X-Forwarded-Encrypted: i=1; AHgh+RpndYVxglOeV0futRBF6R2FYt6oUMgvmqL2eDjZJoH5U89+msa/MviLPIgRf/X6P0ShY8MOSrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OyLvcY2xdyf3WSU1ICG8lnihT3XQ9CFkTim9cUL1DJGPB/zS
	f/LwUmPO48P1OG5JjFJCBsMlaGyIcbm81gKnPVULNIkQDbG+RNdRz1CS
X-Gm-Gg: AR+sD12zxbjM/i3Pst8cWT+MThgP6JHAZCd1uuf+gAHMEiSGCxHFm8ta/9M6AZy4gKk
	uwgGoBqXb2ibdilXUOlCONbe5XxQdlwX7l5XgJTzESVXr+wfDl/KrW/6ULqLm/8mwSil2rHRj8x
	ZosPeQUyn5gnEobAhdPD4RzlvIC5w+KUt9AFNNlIEXI04cYIUUqUq2A5TrdWiz9ncve4XU4biER
	rkf5vfaspCVUta4attY+mlWb0nXQ6s6WDf+I0RYiHlZWTweYXMQmTwBDCyobkUJmJZhTEO6smZQ
	fjBU3ZM9J4pJqTUIkQlTJuAznY8cfLZxaIB1lSXL3lhWUa2LlnpG7TDlLTM6QLDhvkr5hCTa0QF
	ohzx9+QzGHDGFtEL48I8X//9esAdWsI7LtqmJFfEh8MIa2lAjLdnEhFaeqVWStIPwQWJvtqgiVt
	IdyeDtSfAlQrCsJEhnxb2veZebYFJ10HCb3sv4LlARwNoujewHsEUIAa+ssJKPnXMwmpUMut1DH
	jq8zIfmLnHR/y0Psm9JE5W1R15Y2kXUICUkisJRcA==
X-Received: by 2002:a05:6000:4a0a:b0:47f:cb39:10c4 with SMTP id ffacd0b85a97d-47fd2abac8emr2630603f8f.12.1785483366028;
        Fri, 31 Jul 2026 00:36:06 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm1751576f8f.20.2026.07.31.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 00:36:05 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
To: kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dev.taqnialabs@gmail.com,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2] net: stmmac: enable MAC rx/tx after DMA start
Date: Fri, 31 Jul 2026 07:35:48 +0000
Message-ID: <20260731073548.1145-1-dev.taqnialabs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730160715.5ba5e272@kernel.org>
References: <20260730160715.5ba5e272@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 16:07:15 -0700 Jakub Kicinski wrote:
> Looking at the patch - isn't it a bit awkward to handle Rx and Tx
> together? We want to keep Rx blocked to prevent incoming frames,
> but Tx should be allowed so that Tx can egress?

netif_tx_start_all_queues() runs after stmmac_mac_set() in both
__stmmac_open() and stmmac_xdp_open(), so no frame can be queued
in the window between DMA start and MAC enable. So I expect this
reorder to be fine and see no issue of coupling them together.

> Grepping around I'm not seeing any flushing of Tx. Aren't there
> issues with this driver if we stop the interface while it was
> paused by link partner?

I haven't run into these issues myself, but as Qingfang noted in
this thread the proper release sequence per the programming guide
needs more steps:

  stop TX DMA -> wait TPS (TX DMA stop confirmation) ->
  wait TX drain -> disable MAC RX/TX -> drain RX FIFO ->
  stop RX DMA -> wait RPS

This is a pre-existing gap in the driver, currently it just clears
the SR/ST bits for each channel and returns. Implementing the
proper sequence would need readl_poll_timeout on TPS/RPS status
bits per channel (up to 16 TX + 16 RX in my case), plus handling
timeouts if the status never updates in teardown.

The startup reorder is tested and verified to fix the RX hang I
have seen. Would it make sense to take this on its own (only the
startup reorder, with the teardown changes removed from v2) and
address the teardown at a later point as I see multiple open points
on what would be the right implementation to have there.

Thanks,
Abid
