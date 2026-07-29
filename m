Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63313DDDD2
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311416; cv=none; b=kYdsdINDwXMKshE+kkw1LmFgDdQfKgCFjKxAlvO7Wz3k+8avL1HA2J7Tb7tNymyUpn73Mm+FLraXTnRiQ26Inu0M/z9t6mmuSwqtfm8ks8gX8SMcQFPSrwuVGpELxnFQhn25xfsa4njnrIk5FKU5aihoY+dHCLyXpJrkMwtWTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311416; c=relaxed/simple;
	bh=TgIIJxVOJ+2iOdFoDJUVRbmeJCaoACab0y8Ff0nGE+s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dWfC7xmimDxnWoT5p7r2OL1A8z3bGpQFfGtO3GCOnXh02vaYc759JyQKhPgZUKH69d2r3f/1ZQor1Qe19FDHUWnuPKsv/b5pT/c1/jonGMYdS6qnkVn1LsebRATpmzkX+3hffB79XWNpBXjuM6rZgomU+xA476pCYJJv0wws4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/8zobjM; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/8zobjM"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667b0ced2d3so858573d50.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311408; x=1785916208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GuHZNpbtVXBmsr06bXb3BPsCK2CmKLVW3k/vJm0mD68=;
        b=c/8zobjM0CWv0aS4QutMxGONx2km5P9ih5kkTXOiVqpVcNyVkKOKmT9C7/PrYjDl1/
         z9lCZO1Ywlo9jaVuIbOyzZuvwu/oPP/4Umt20Ey3TneMh5zQyXOnBsuV4SgI/M2FZIl3
         IRJxZ/ea819mAmNkjjqcNyPElyatp9frJFxWPhbhnEYasrK94fG415nAbyb1zUbj5cLr
         CsNzVmi0Dahi5tIOlcgVZCiJrXFtRT+fiEpZMl2ZFN2WBN4Kvoa8PSjxReytKtCptOUu
         cwq7km1VY/hH0n3T+hhPXYerY0XF+xXJjX6WzqsBZ3o+CakfU/C7h2SNh/6ER19/2Ojm
         R8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311408; x=1785916208;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuHZNpbtVXBmsr06bXb3BPsCK2CmKLVW3k/vJm0mD68=;
        b=ePZUWln3a9AEEmuzyqQ3kEqyKwTpqCA0QWUA79+5BYR6yJM0UXrFrJZkqHaNRA8P55
         FaXjd+to8tDRqUUWnWXP+iMDtl8SaiTrOtyE4wzp7HShorm4xEneWpA5v2k9MfUHX1Ae
         ueVIALCygh0F3Naz//m1DOO7FF4mTqKocip4GXCnXg8bCLHlEkBXDB9eYBsoE5HkBwXo
         Db6hdoi8MNYNyzhZVXwEdqVuslHyUYbLrja1wSJj1Taw5exI1vhiJSLDd/plf74Vxe7L
         39oBM+nk9fhzT5K+SwG8QdeRp3kYBHnoFa0r3xVDTSr+HXOi943JU6hSxiQI6E4E3Uuq
         slYw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0AjyTWZwdR1KRCZytJFeNW3fevZCnz3mjLwIcgR7RLMAvrPgJopPVk4EwQPx+jmNIueRuhIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx3p4XUMPfEG0rZ/a3aut5T2tI20wtudVlXX7hCICVV7k091H
	i/5PTuJFPIr7v60J2WUW4cM0yi7i3r7YK+9QPjw0ks0wf+oRO/03Ic83
X-Gm-Gg: AR+sD114qyNW5YWxwgJ1VB3XX/Wcn4VJOOmHPtvJrx6wGR0/En7zOznWyCUD2/amVHI
	kl09jev9X/9ssikzYkfjDbrjTRuXxLne4mLyGUzoegVfwQvM6mjDvgeBJ+AGvAsjwGdsNtx8Xyn
	YxExGNv5MGYEHET/U8CRg0pKl1o+SIEGrgmerDAbAFKjogKJ+r5AtxgpvZIVH2dwBa4sW3+Iuwc
	IwMk58MgeCsqrXtjpGL9+fGpO4xcIaKz+eGeb1jq9RjQpsi8Jy4c6pvclLK7U9yvgfPuBapMnHv
	8MD1Gah2U+/4WRTalu6v/mBHdTZ85oOPqTwBuAiVresCkt01Do4Dy0lu9wJNDG2mcjLKj6L+hGS
	f4sn5bAPQTxFKvyYyq/l2Gf97ODvbmlMdaYbkG0EJBLlYOMZUzdh3JMcqEvDCqcyVaP19RUxXJT
	Loo5pLJqRlbKRdFMr+tZIMtI0QY268CN7uZkBIdp2SvTCOCTtnmApBH6Fjzk7dn2drHCw7+5mrW
	tuqtgZj0B7Q7GOJ3DP3dFMykRQJkAGszoBu
X-Received: by 2002:a53:d38c:0:b0:668:1afc:e760 with SMTP id 956f58d0204a3-66905828675mr1661727d50.74.1785311407986;
        Wed, 29 Jul 2026 00:50:07 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6691218c643sm1369405d50.4.2026.07.29.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:50:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:50:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.846d137be17c@gmail.com>
In-Reply-To: <20260728160935.4128982-4-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
 <20260728160935.4128982-4-joe@dama.to>
Subject: Re: [PATCH net-next 3/5] selftests/net: psock_snd: unify on recvmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Don't maintain two RX paths in do_rx(). Unify on recvmsg() and pass aux
> data only when needed.
> 
> No functional change.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
