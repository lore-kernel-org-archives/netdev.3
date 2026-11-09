Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266647;
	b=290rw8yQag4e1beCmllPjkpHPdj32cqGycf/65x/ZRdAJogPBCEKiSNcVyYYlR39oLSE
	 eohUelZBngDJuKZhaOx8RhM9yxpLkEdYmSpn2ViVGTtIreSSZX6Uoqt8rIlf18b47aesn
	 5U0zof1PXgqy2aQ5qkguDd/QlAIPiQmp/7xFs0oHBwBypkGzpVYAvNvZ1H2qi9XUNoNKC
	 SZ5leMxNu78uiK8+LNSIn33kKDqLA/FhskZ+0fvQ2WLZLLWyqySQQmfhY085q0rkxc/6A
	 +/Wbp2asX/6YnDmBG1Bm2xqqUqO590qtPYLaUzn+Ngk9Bpt+HIE9JCGOESYa7Hq2h0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266647;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FlQwZADxkgsZ+6yG6zdUGVD7DrFOdd+t7+o2GEVr9BY=;
	b=Pgb2lZxb/VRLMVUYVqUWcW6wMBOQzIRi3MiEhMao0e1PSBEmkM0D0o6SsWDg6fwsXjnA
	 XsgSXDLDpM4rqL8LhhY9KSxalcAC/zad+xahaAE7x03bikiOGAgZGVchntrvOsC/B/dMv
	 tdx4wj6BhkCiI+S7Y0pwYOfIqTKN5H+1Q8BM+qAV7jHuZt9A+c3zXuHSeXnGdOoqu44bJ
	 yWrQO3QCMtjKgOhfQ4Y6kPzqFRt2yH8XxMOcw/8FJnCWVBE2WjyzSTRTMwRgHw60F+2pT
	 0Gw8Pdvm2lCkZoKysHwrEpzMQT71+qsr3jKRyTTjjpT4MethSntiqiIyUiDS9aenHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rBi3Z3ty;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A3606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2A3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rBi3Z3ty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794266644; x=1794525844;
	bh=FlQwZADxkgsZ+6yG6zdUGVD7DrFOdd+t7+o2GEVr9BY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rBi3Z3tysxtpx0Uhs1bQ7RCzT418SATPMbuJbxG4YSQhaWaGPJh03scrYSDqzhuGi
	 ZKHEmCm1cdIAoeD1bEOrYv7pnnsM37YMnZv5g5Addpy6tAnMn8wTuxDKqD2o1KZq6i
	 19yI4GjhDKp9Hof4XxfvdmUjQkXRssWioTojdj0O1g2++wSOukc2O/tLwFSb3PPFK4
	 8YptSxqAme8oK7G32G7TieNo16q0oZ5W7U7f/yEsMlMRIqxa3DJGYE3s2tvcSE2s/M
	 UwRvT/H7+OJNuTeC/hZnT9e8r3CuuMoA3Jnh98RRiyu8z1IGvQ2s6Zgr7fSWj1Fu6j
	 2JULTv5XZII8A==
Date: Mon, 09 Nov 2026 23:24:02 +0000
To: netdev-bot+sashiko@kernel.org
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] wifi: mac80211: use frame link_id when adjusting link_sta on reorder release
Message-ID: <k5KBkmEPGxYqGJKtnstMm9tHt80YetkJrEn6ohegQq2IIk5PsVKeViQEAJsphTAhDNYEZBEkT-O8S418SGV_HxZY-Ayi-FtE7Ny30jaQcXU=@proton.me>
In-Reply-To: <179426409490.994134.13077118770469155374@kernel.org>
References: <Sq80dyNRnQWE5H_yZYIwxaQiwgvIrIlET6kND66_K0UpnKQZruHroWDq6hlYKDM0y9e2vXW2UBlBmnjw3bCLKk1Acrp7F49_jk883tbCqxk=@proton.me> <179426409490.994134.13077118770469155374@kernel.org>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: f7db0cdcea3a214dc08966c7fb757b7efc1679e2
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. The remote-crash trigger stated in my original repor=
t has not been established, so that claim should not be relied on. The prop=
osed change selects the released frame's own link ID, which the review cons=
iders sensible, but that does not establish the claimed remote-crash scenar=
io.

Noah
