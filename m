Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DB369D6A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841474; cv=none; b=gWp8mR22afOLNi5mqhiFsVeQHRwZr794uRmHX5XXkoZJq+vzWHkb6VeQJDjEpdBV7MTgdCu12miXWf4311J9p1H0hNNloQAcl0PfghMrUWhu9p75sUrzRi5qc46zgE2yFyP9YhAgjtV1kBYNrOWAxCrjHhA7l0TUt2jXwKBa7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841474; c=relaxed/simple;
	bh=X2gG/qCo2vsIXoN2qCiKsHeGsk3Jh4HrzvxKOOj9d0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lm/ljQgmevnE8+b38CHfkuBc9K0Su7dyS/UoNQ3SserNY50a/LLuEoNb9u3VWnltDzowZy9GZVOlgsctg6kXw0rZuxP5s+gbl1lh8qUkbzKyATUfFmoPe5L/v3nneaz3zfh1Z9cnu0/l478s4GEiRHlJtFzwvyTyG3bRvpfk9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HmtJBSWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4f0ABQa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HmtJBSWQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4f0ABQa"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B05C67A008A;
	Thu,  1 Oct 2026 03:57:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 01 Oct 2026 03:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1790841469; x=1790927869; bh=ylcbgLynzz
	m1MnRSg+7Cg3TijKOQO5Z1xTUtRyXy3Iw=; b=HmtJBSWQlo5EAlpTYJI92AcfJF
	zlCJle2o4+nqnNdQkdigjN+gM5KGDvfRPaF6LiOwwI1whJdDK2jgCHniB0NC7wv0
	LHjQSUcu5YMRzQf5PCS0fWyL+R7iGs4KKanK/GzrYn3JUp/JrjhHkSqvnCvtxw4c
	GxTLQXSVZ2xOQo7gyKj5lC1bw3Md2Jd2KzCWnEjh3o8FHrYXHT5cB0g/gP7dklKV
	0x9kMo8W4G2urOO0kpNfYOHd+uEZPmT2QoRKfZi6/YmAKZ8PRzrc4hv4ZyhcmfEi
	/etwy92fa4JonLwPW8FDzRUmBO5RZj7ExhP0SITbfRf+FJsNSzS6WJn8aPtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790841469; x=1790927869; bh=ylcbgLynzzm1MnRSg+7Cg3TijKOQO5Z1xTU
	tRyXy3Iw=; b=A4f0ABQaBeiQJOdwI4wDFzWOddm8+2yWerPS/9cBOfxr0i5mHEd
	8UQ8IwKTXPh5/jCJ6scCIuuc5ZM74M0Ia/ZRLDizlKbkFykt1SWc2ZQ06Ll0qdmM
	/IcAMflunii85JK/k7jSM49ozeTEvFnxuW9O+R4Mb5uQUhe4ZGRCxwskTODlvm7b
	mtJsDtPVHLrc9ETzzIG0NDKrMai1c6nWnxY02W+7S8uyhWldMy06z7NGnbaZpR/R
	Z1kWbDUnjGi+BgHQEkE9zsfdK14uBBTcfmKsHThP8lYXTcj0A5Pq4aCry6ie60Rf
	Olq5Xu85hrBOwrNWT6TJTxk39BJ/ahES0GA==
X-ME-Sender: <xms:fRK-ahTc10aHQBqTgoagWEeFCkkp5MNsEGQjJx6iZKwPf44F5GTRYw>
    <xme:fRK-agxMpizaqQoE3FCiB8V43vkjSyt3Cql44BdaHTNMDbpH37KziXIbH9qvvYp1M
    Hu2mnpyuenyzlR0x7NuGqWpF1aTf6f3ga3VqL9ngyFm0u_a4AkBqYtb>
X-ME-Received: <xmr:fRK-akcfeiLaQ43CJ8TWhZ37asI-PNIZkc0nSlBz-UROvAbJtLRNgesY4te3>
X-ME-Proxy-Cause: dmFkZTGYEjTnhTvXwu+LRkUaW7NN/EPD1/IV/RknfJmQ9bvTb6josDnHHOYCl03h3AKeZq
    ohRaliqju56yB5XeZaFWh1hBYgeCsYolUXIDVhbUOn74mKX032yThxA8zZlnT3JFEaqHpS
    rgjK6AfSiGbikYdygUORAwZgSwpOOgDhAv/Vt3RxQbVFOH/oY0k/hNx18ulPw4OhU6l3BL
    QreKpbH+7FT84Awi7tDIHzlCxp27pN7vKoOHuZgGlLLpwIKOolC8brL2dvFhBnIpP1YQn1
    nONRQ9li5GOYcSHcuxAdonQP+V0ftjcSqSdhPEkCVhwe/c6Q+TWfmXFaMAVZ9NKjdrrHL3
    NBsYGLl1/wBdmUl9V4punTkek/qIlmKVZZwkJ/Ud1AAWlfnDG3GEZbRXosVNLtgokptvDv
    aNyIJmadHYAGSmx1Kp/c0CShRVmGuMlty485otHCFQ/pfsDNdpDSoSrbsjNKujSH6kjTnN
    a1kXTkPH0qV3qomBr4YVvf80DhydjPk4gLHc3kN1vuTzmqsirxbc7wpAMNuq/TE0OUkXn3
    nRWYctbitZ9+9/Rk7Ix5xdlYrjslhO8aY+V3sHiX0BFnvk80hseVMmsPXvhS1gZFv3lHeA
    Zt6gTK5XOl1wXdJMckbu5DVDkggNGS9ztu/q7OaEDpE9lPMPAHiVNWED0pHQ
X-ME-Proxy: <xmx:fRK-akJkZ_V7VAA7jv7S20UZ0zPP9mAR4YPUrpWb1WydmUk1lTKr7w>
    <xmx:fRK-atF5t_NM98mhz1Fjhvue0tXsqJwj68Md16QrcowCsow2CZKt8w>
    <xmx:fRK-amqP1MT21ksUVMv54cnGi06rB5LScTNj73P1A_PDfEig7x78Gw>
    <xmx:fRK-auT-psT4mOdYSzcR5vS4R2lVoOyzt086SSpVWpH4AL0puAldCg>
    <xmx:fRK-akqE0LyjUt6kaIBITVJGRvd5nX6pGDsOtkWfsIzNKESsAWYroRIo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:57:48 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 0/5] strparser: remove general mode
Date: Thu,  1 Oct 2026 09:57:24 +0200
Message-ID: <cover.1790702233.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "general mode" of strparser was introduced in 2017 by commit
bbb03029a899 ("strparser: Generalize strparser") and has never been
used. We can simplify the code a bit (remove a few indirections and
NULL checks) by dropping this.

Sabrina Dubroca (5):
  net: strparser: remove unused abort_parser/lock/unlock callbacks
  net: strparser: remove strp->sk NULL checks
  net: strparser: remove strp_process()
  net: strparser: removed the aborted bit and aborts counter
  docs: networking: strparser: remove general mode

 Documentation/networking/strparser.rst | 120 ++++++++-----------------
 include/net/strparser.h                |  11 ---
 net/kcm/kcmproc.c                      |   2 +-
 net/strparser/strparser.c              |  93 ++++---------------
 4 files changed, 53 insertions(+), 173 deletions(-)

-- 
2.55.0

