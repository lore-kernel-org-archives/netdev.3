Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EED34DCE0
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274247; cv=none; b=QETlvIoy5XLv+ZRlHFuCF51fzU3g5h8pKwqesQQwABlzOHBKMTN3Fg55kY86ZIal5yHWFFt+J2g85h/fDHIWF3h8HaZFexCMbB952rekaLduSt0xhplLFL3Vysd6N4ivA8YlwX2NE+oJ3Y2h2+9UPQUOB/XrcY5JktPyn0xDWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274247; c=relaxed/simple;
	bh=fGeZOnmmGwuz5zFzxO9EO1GTsffOF/l3CdqV29Nh/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puWPjfFT9mw3SExv1720+CEsEHXl+dL922Tib2vNH2wVt2KZ+crhWlWuFf2RhIxTP8lzvKMb0FSTgjApE3aU5eLxyPv6/N/4a4jsYpoG8SgtNsDIAfYqzRmvQzStPBNtOc3dMBk1Ld4O2iGwGrbtzE2lBRpdhcSWBgaRFv1U2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=iTz1C/Wp; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="iTz1C/Wp"
Received: by dvalin.narfation.org (Postfix) id 027501FD5A;
	Mon, 27 Apr 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777274237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sD5b+k6/URUavnovOXdTKO2GszejptHQbyYMDz+Yyg=;
	b=iTz1C/Wpme1tB03wTfKST6w1JN1WbvCvcIu3mkLVG/dPwQkeARhepI6vdn9zjLALxo9Uld
	yIAEC682MUyFt5rCBU4mgRKtqgm1w0gngEtUTE+AtT665a5tsM8n38eCuSo9zpYtNXAQji
	vVbI575VKik1sDalNNo4UdGx5cPbtZs=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Ren Wei <n05ec@lzu.edu.cn>
Cc: Sven Eckelmann <sven@narfation.org>,
	marek.lindner@mailbox.org,
	antonio@mandelbit.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	tr0jan@lzu.edu.cn,
	wangjiexun2025@gmail.com
Subject: Re: [PATCH net v2 1/2] batman-adv: reject new tp_meter sessions during teardown
Date: Mon, 27 Apr 2026 09:16:44 +0200
Message-ID: <177727301354.13864.1397859878214766047.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
References: <20260427064338.1526762-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Apr 2026 14:43:33 +0800, Ren Wei wrote:
> Prevent tp_meter from starting new sender or receiver sessions after
> mesh_state has left BATADV_MESH_ACTIVE.

Applied, thanks!

[1/2] batman-adv: reject new tp_meter sessions during teardown
      commit: https://git.open-mesh.org/linux-merge.git/commit/?h=base/net&id=f68c93519b3e59a8039bdab9f930681a8e64f97e
[2/2] batman-adv: stop tp_meter sessions during mesh teardown
      commit: https://git.open-mesh.org/linux-merge.git/commit/?h=base/net&id=bff1888c2c5d7453c40940fdbe3215746817f7d9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
