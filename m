Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC723C1A;
	Mon, 24 Aug 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530311; cv=none; b=akkS5gkHpSvuqqJnZZ6pcyYdTrS0+3xGTeEPBd/DCdITIBoI2UAKq0UMXD3PqUVGDR4+OvUQgS3nukUREMbkhI0uyM3kSKGiA0+50vrxX8OIrB4HXxWXbppPQvORWkfy8ZHT3sDmL19Hr6A4V6+I4E60RlZT2f4soCq6XS8Ud10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530311; c=relaxed/simple;
	bh=xYM2rZa70EDQbv8Eu3dnq6e1Jf+cig7NPl7DbUUTc8c=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eXzKwTiKQcrInBuAC/8+WG3FjgFExmaligA+Xxd5WhRXZocDqvmsE2YA1QzOUpwt+oYt2pPSSfwreKkzbb4Vi15OLGJ5T4xCw96Hw4iWuJPBXGtGG+j3WdXJ7w2LDiztRG1wXvSpwxNUWbpgKuV5ghbxdO1OUBduaQXH+MfEbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=IUGNUBbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJzrFPc3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="IUGNUBbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJzrFPc3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C86E8EC016D;
	Sun, 23 Aug 2026 20:11:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Aug 2026 20:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787530308;
	 x=1787616708; bh=xYM2rZa70EDQbv8Eu3dnq6e1Jf+cig7NPl7DbUUTc8c=; b=
	IUGNUBbTLiCpOkjSmeiMb21Fgw5aRpkqQYmKtWDDuq09XdBrAOpwesTe/dgcWa4Z
	GBuYD1DG86IdFBR0S5WhAn3RHRmw/5vWXGsYbn2BqqjvYTQrUtJwEATjfhNzFCHa
	AMduSWJ+UE3gN0CsIOA34F5eBh5UfxAWiAqgpLS4byBZ9Lfi5jvVntLI23WHbepR
	ldm61wnNO6oy1QIR98znQLsocupW5Oj30alO1T/zrHRnxJIdRSlfzCkbhFKSuCui
	rpHdX/ELVP731QbmLDOsJIgNoo1UlU/cb+PklMLO2ryzN83mUwqmd7YxjgGDM2sm
	aB/4gDHY5/p03Hk6alvKiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787530308; x=
	1787616708; bh=xYM2rZa70EDQbv8Eu3dnq6e1Jf+cig7NPl7DbUUTc8c=; b=K
	JzrFPc3wc+Dtw5vppOIDJDYx8IJR9AKMTgsN1Hjgk3oCEQk3UxjxCMiOc8U/T0jz
	tOT+4KaM1iXPewR9HhFO2qupjZfqiDGEHC4RA/t6cFujFlcXM5WBAniBoyXHOWzq
	BDwHSnpoapfhVR5/nI3972+HHG0qWiIKb6gWUrCVhN4tbevK6lEM/J62VmCdgluI
	AsF03emyA+RXuuou5PldIskBt7JWKhTdJugStB678AGcvu0ScxGm4Cc5FNcAEpx9
	8sVKu9ETWbepeA+8RNr0mFiwkDAawbvBUOrMiKuCJTXU77tdoDf+aCZhtcQsW6+U
	RCziEAf65QpIYOvFyDw/A==
X-ME-Sender: <xms:Q4yLalhnQkl9xNJTwBOW8BslM8-YsHPWAGce-Z0X6txQZoGSMm6a0w>
    <xme:Q4yLasnw8qEhY0GSytGjiaRr8AqEGU_W_nPlWEefKQCV5J1DUNjzHR7FDJXmGLCKd
    UugvcFAFpFHp-QjrKS5GRB8jZ93nAymDhoK60G5Ry3PMiBE_GRB3SUk>
X-ME-Received: <xmr:Q4yLaovwLgdXC4287keSu9G77b7yb8sN5Pl7k1afkl_ZoYvMex5MBB47CTiMy75UUWwf1HdjN29f59CcEDP8taAl>
X-ME-Proxy-Cause: dmFkZTEIrVi0h25s26FzXoiFg+55CarHGyrXH6S7aPpX5PCgfNCgqi2xAqDNRaCT8Ybd3c
    AuagjGTwK6MGKbUmbBrVI+wziPk0RMVSedldtUXjkYFeY+bF5GuczfX3IlHod8IYEkPuVF
    jFdhY/SpGMYakXbN8PYvjw18CaHoFB1Jpp20vVUf94STiE8YGCPKVNeoCSPOD2Vh7qQurN
    H4NYbmBggvmbA0UQZTIzt1DQYVNfrQ4yEY/Lw8iIojIcI5N8YZuLmDKyMK8hE99KSqOFbE
    kVA8Br05ITkCPC/7MbeVWDNrM95kVctPzY78YN3RTRKrYuQ7fWsKlPstAJ5gzUJyg6SpJI
    BI00Y+d7+2FxsiFHqeAW++rDbUW9S+v5zFs2ah8HyDdtXpXC8MsowSN4U7KNjYFj/9jkf9
    12ISlQbn5CnPybC3l7qjYnPxwkdPWx+uyDHuyaOiXgDRdUStx5XquYTfNLUhLuD7tjcFDS
    c1QYKmXOBI7AoG2xscenB40ixVdrAK4vuWdmBHe3q8ymNePw9UgMKSW5Fftp/nUiITDJjU
    vjfc+CAaVIrysQmhUbs5wqqoC+huyjU2tgIAd6FLe92wEwDIl93tLlYT7lahKuqUU2O9mg
    rKimIPVL20e7WUJe06S8eevIIUDe9Te4kR7xgln4PQNO1Kw+QV2YhlzR5Deg
X-ME-Proxy: <xmx:Q4yLaqYCypLx2OF1TIVe_Xi-V2DfkV4xdB1Ayf9SouZshASy15RLDw>
    <xmx:Q4yLaoB07ORb2DrP3mjZBRpCZIAFNeJpXTtdmB3YhIP5-TWLQHwkmA>
    <xmx:Q4yLaq9Q-mB2BAXXinlBgNZNWfK56rd4wj3svHyB8NyNzytWmFkymg>
    <xmx:Q4yLasSQbBskjEI5sNfcF8w3aR8e4Emyomo0ICw_eaJMXYE6GUkuVA>
    <xmx:RIyLatDyh0O2DlXiTAyBuzTQtU9d-7Rks3_2V5XGUThj_45Q9ZpKqBNh>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 20:11:45 -0400 (EDT)
Date: Mon, 24 Aug 2026 09:11:42 +0900 (JST)
Message-Id: <20260824.091142.1032504488154121329.tomo@flapping.org>
To: springbreeze@stu.pku.edu.cn
Cc: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 fujita.tomonori@gmail.com, ojeda@kernel.org, boqun@kernel.org
Subject: Re: [PATCH] rust: net: phy: fix off-by-one bit positions in device
 status accessors
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <000d01dd3317$3d212670$b7637350$@stu.pku.edu.cn>
References: <AHMAhwDwKw6suFf01VEIOqo9.2.1787486213219.Hmail.2401213299@stu.pku.edu.cn>
	<f4e5000a-8468-4172-b454-ac97f9ce759e@lunn.ch>
	<000d01dd3317$3d212670$b7637350$@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 23:51:16 +0800
<springbreeze@stu.pku.edu.cn> wrote:

> The v2 will use the bindgen-generated accessors (link(), autoneg(),
> autoneg_complete()) instead of the hard-coded numbers, which also removes
> the TODO comment that marked them as a stopgap.

Sounds good.

Given that this patch is expected to be merged via netdev, you might
need to send with a proper subject:

Documentation/process/maintainer-netdev.rst


Thanks,
