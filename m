Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0EA3CF96D;
	Fri, 17 Jul 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271623; cv=none; b=ezZFZgs9bvVytfCocQYz5pnIwx+HcEBdt0Nvq+unrfAdSAREa83IO5UtQasV5HJRlS1Q7yrssfD/GbGWb4M2stC7JhaZPm+ol1yJfkFlcUNk55bcR3TpWBRoslk14e37BAhwzVmQNRYvq/gIkYTTqEscvG1Ke6poe5QEmzJd2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271623; c=relaxed/simple;
	bh=3RRGhQoNRwYjoN4BRsdENqpKkYowMm834p/jCBWVw+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB3PmdBhjxdcvYjAEuTvk++DD5Qhs5zRSUmp0VEmz32QL9QYmHJ6qPcD8rPQdHGdGnyPvum8lTNJsr+t6m6Z/ukZW5NPP7MGUtNtbBPfSRNIjbGzO3PUdyNWQuuO4ybS0iIHIOKoVcPShZj07IzGFH7xEykhxX/WkdwSTnha3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=JBLoI68m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=edUlfFzg; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JBLoI68m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="edUlfFzg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 1B85A13002E3;
	Fri, 17 Jul 2026 03:00:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 03:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784271620; x=
	1784275220; bh=qntGnCl+gT6W1uiVWS/FnTVD+JK4eRGvEYcVVrmUZCA=; b=J
	BLoI68myrgucyxqyHvUUdXgtieHcXz6tu4wfoJJr2vUYTU1wcHa4IsfaSsWkYnMB
	qQ7IW6BVmmgV0twuWgVCzyUwcbpL854/sxUEGPSVHjNvl2WdCTjBcrn/vYXIO/7F
	7YzxYvFPUL/RVlGiieEOXwNNBYX4nEYiilUSREz5fxIAfnIedzJV4uOeml+IITYr
	SMYuuIxtpNufRh5OyI/Zqudrq7z1gW4Egq7yiWDzRXTAXTZl99XbOP3b/FUaJsh5
	2dVId5QOQQpROv1UBnrBZqxuu5kZnegorJGZiA4syg+Gd0vxBCWPoAkIk3aqGsdm
	ocyL38M6smBzxlKfXbZ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784271620; x=1784275220; bh=q
	ntGnCl+gT6W1uiVWS/FnTVD+JK4eRGvEYcVVrmUZCA=; b=edUlfFzg8xaRSO3ok
	qaeoF3EWpZWNEbeOtVZhOjjHx0w9iWdpfsrDKm0agPyytxd6SosiX7/kioapKxm1
	O+/9W7puo0J2hyZ4EAOuPyFWFfFqPZMPBotBgC1m5xF8Abvy4wmkkSA++FjDdL/u
	gWPLD4sfeN941iW8WoibpN5TVOuH8mx/hy/XLD2R/wWywghT9MTSGNo16EvjkbrQ
	CV0HGCsUqycnil098QP4vax2JwCGwgfVWaVv6fQZpXzsOR0IUYWIxwESeYN9Caio
	L19vdTlKteMmiTjq/f211NFQvUp4tRGAlN0fHipGX8+615qLalYh7hE51+e1JQ6R
	/FHVw==
X-ME-Sender: <xms:BNNZan7DxMjDq0XYrs2VqehlWq_P0WU7_3KVBgyH--2cz3tNZ8cTcw>
    <xme:BNNZajTv_BFl1eZsu4lLdNd1NV9h1QmtyVpgyX5k5bF6uscDhiaLtzmn3vx0-Icsi
    A313bE_skJyvn5sbXwUNRpr8Mw3h33RUqb5RbALFzx_WfaswfzI8Q>
X-ME-Received: <xmr:BNNZaquyegBDlwx0TIMWmHRr3v1xEVsWumJfZ_sfTT5TXW3E9yMg0Opp8sh59ObFYnDTePMWiLZnHcretCM>
X-ME-Proxy-Cause: dmFkZTEHWYijIVn5Hjmw1gGNs4YgontCXsF2NkmQQZU9ftMEh542K23DBiPfFKZ1WNd+jZ
    y2yluKGWQV5yyoYOo69k1CpzzNQKPcTniEC5PSYE2qnBokqhAOpAo1V3aURJV8OdOYq23r
    PArI03veB1OMjIaAJ/XHKxXS2Q0Sn2Bm5Cc+S5BchXxm8Ht+sv8f8F474Nlm7o9mS0TI+E
    ETLnOv/kO8+zlZUhl5+8mYNDBFsstvrHyTn9JsHO5glGo+E62uUi8cmkfsltXhwLeV+VYd
    4YeC6Biz74FTqzFaf3nkXE8lJmdInDvAnSWCB65oeY0T5VoiGlL5IAX0AbrH6vTIj1O0iR
    /j52j+0d7oi0juD1E2unAh2pJW4REKxwGJeovXyQF2RZZwcJDvdc0nWne7KR7fYLmc9nKi
    DS2NgAVTv4qwdC+u/+A1R5mk3i+0vTdjs7N/7w6BNjP9+I1X+fumeSlrUBzxVst7jrbe1e
    pAyRfre6lPCt2VZ36zyCbiuBBIAcYHHI3411vgQeAHDSsR9hSbCsueNWnEDKmasicXtr1P
    58LcrHgGItRLS3Ln8LpxH9S0NVqMrrvcVa/Ttwi8M6qy5Gy/DDVQMqKPR7PL5mZNgtqRDZ
    YMdWBiScyT+cbqau43e8mpPrYd6Lkm64diNqlhxVxGnk37lSyhBqnw5FlqZg
X-ME-Proxy: <xmx:BNNZal9U1dV78LlbLnUyEmvfNN3UqKb1A0C0Rf3idjaWNGGZgCS_Jg>
    <xmx:BNNZajxRIHiL5zFXH7qKiSqqlYqIAzolQLH0qK7weGHdA_Oe_lSsLw>
    <xmx:BNNZan_KuCdqf-yNdYecaj_qn4_Lye5L-yeBr366_1rZY_0Fme9tLw>
    <xmx:BNNZahM1njhAl-DW8ItLr9HgUx0i5ymQSoxuASNODF4IhhjNP8m_aQ>
    <xmx:BNNZajpzzrU09M2IdHDIOWE5syTrehpp-M2UDdwQs0p9xrrGhNgrK4zn>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 03:00:13 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: dwmac-rk: enable the reference clock for output mode
Date: Fri, 17 Jul 2026 19:00:11 +1200
Message-ID: <20260717070011.2629800-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a1e6cf0a-a243-4739-8563-be385add37b2@bootlin.com>
References: <a1e6cf0a-a243-4739-8563-be385add37b2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Maxime,

> So the statement "For RGMII, it must be input [...]" is now incorrect :
>  - it can be output for RGMII
>  - it will be 25Hz if set to output, from what I get from the commit log.
>
> Can you update it ?

Done in v2, added as patch 1:

  https://lore.kernel.org/all/20260717065933.2629501-1-gahing@gahingwoo.com/

It rewords clock_in_out so that for RGMII, "output" means the SoC drives
a 25 MHz reference out to a crystal-less PHY. The driver change is now
patch 2 of the same series.

Thanks,
Jiaxing
