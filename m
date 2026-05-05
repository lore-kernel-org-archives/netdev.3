Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D921ABD7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005931; cv=none; b=S7s6unAp3MwlXqdhJGoYto1+xzCmJEPj9OfoJZi/DVy+uiNB5iDbd3b/Rp/8aLA44h5MXr0vnSm8hQDQ4VFiECZm0fyURh/ALHV0KYAe1sVQaKHv7K4T+i6Rz69FUYFtQumY2Us9ls+s1RTlo5sViQm1rSxp3KSzkFuc3vC2ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005931; c=relaxed/simple;
	bh=2mN2bTg4eZp/i8wDZG+S0AH6q7oA5isJoLBaRWHZa/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JTxjlEhCpAhtG4l4aw/nFtuvrDvLHBnZ/wKC1e4Mj7xiXqbBXE2M637pUmgtDhHvt52uvf5cfHrIHElMb1Oy9D+lOXCZrZdb33VgO3EeLZyL0nkMiKrA7tfaXR5ORjVUAn2xz0yMCHaOUtucEjvYjPD6gQxO3VXHsjG8qTdk3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=KuEcWPi9; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="KuEcWPi9"
Received: by dvalin.narfation.org (Postfix) id 4FAEB212DF;
	Tue, 05 May 2026 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778005927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mltUUJ+OSRl3QoGEANutow0sZ3BcVDlcDH82qOKaIYQ=;
	b=KuEcWPi9KFrpEogCiLjmN9bH7pdHx0jp/K/7rAUZcPqseuAKlwejzQD+XyvxZAXi7q/cZW
	YRY/ly6eflGTWR7eDZY1IRNjjdCKiOth1uaUcpCGYVrGxiKWLqGItBt35YGz+vEiNtwkYY
	wbOuewHya9I5o7Re63hE/5OiIIZx8to=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 Ren Wei <n05ec@lzu.edu.cn>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com, 
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
 wangjiexun2025@gmail.com
In-Reply-To: <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
References: <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
Subject: Re: [PATCH net 1/1] batman-adv: stop caching unowned originator
 pointers in BAT IV
Message-Id: <177800587225.49931.6032285199258231121.b4-ty@b4>
Date: Tue, 05 May 2026 20:31:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=324; i=sven@narfation.org;
 h=from:subject:message-id; bh=UtJXbJ/pLCTorOy0ebCQ05ZckwTdS30cLePcNmLRwFA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/zDuf6c0/dq+B3Xbjbq4AjvYS281VgTsWvV93PXLbo
 5ebTzyM7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMJGoFw/8049a9/59Vt9w6
 fTzu+9XnSxesfdf6TV1I7U3MBMa/Zaf0GP57x+a1fQuJWLn+9bbcyTGVByJ3S5oHbGWLUzfVP2r
 7IoQVAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF


On Sun, 03 May 2026 12:28:58 +0800, Ren Wei wrote:
> batman-adv: stop caching unowned originator pointers in BAT IV

Applied, thanks!

[1/1] batman-adv: stop caching unowned originator pointers in BAT IV
      https://git.open-mesh.org/batadv/c/37760490adc1

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

