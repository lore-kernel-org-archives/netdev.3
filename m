Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483536167F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714516; cv=none; b=Vmr+oSIRGPbtujD0Vb/DzjIXHOMV03WWYjJb1KihMvmOFrYSZEjb49sYsczqgtSt6f5CXqzqpnMfPm24eeyUZpuwYJggwe3Rw1WC0825roojcLLDxjgOQc5nWaewbv4ymIku/0yWTJxCIF/calxWZnm5rEXWYWJNMgK8g7NVlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714516; c=relaxed/simple;
	bh=o8dhmQZK6NUEp7bIlN+A8R8OEGXpbaUT6LyILEBVyOI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qn7hK3sGPP07tQ3bIIibTJ82D8Y9k3jORDbsEgBtMY2Yy6byO/Vc/3YXaMe9J1bTddlh+jDnJBiz+bogq2LwQz00LnZYPfue/n6sb/4MR6TUOSW17ZG1PA97RZV/zuXIHUrtU8jBfpokDfFqKLzwtbzAWDCZIswa2QUcLoTbdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEv6t4aQ; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEv6t4aQ"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66e63c2c9e1so3526568d50.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788714514; x=1789319314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=waPq+1f8MAQW2drA+fK4ok8lWk2s9MiqHdPG9dnO1bU=;
        b=ZEv6t4aQcic+gy/hKOjAcSQTANeUesFAGoQ+uFLcxv/XSccm3lUeqw6OOGFqgwWIo8
         ePfOTbmS1kKN7mAcxdrZJGPLFs7xeeWhPW2wJd/MJgG9MBWFZeiC44nvnN/zU+7dCJtA
         VZZjCk56VEPEc35c1gq9pYB+uGRfM/kuVGyKpasfWlm/vCswwUwTTNfmRw/mx4FFJS0o
         C0cpvXyntZxGXhturuUdWQTW7c9ZQkBfGGvmdnlvf3NwqBAlkzibXWigrucfbF425q5i
         bM4p1D7GvO7UiJ8+vhx+097VQzY+5zSuPBTqX1wCD5ld05Ru7zSntkhhDVswFd8b0elp
         d+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788714514; x=1789319314;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waPq+1f8MAQW2drA+fK4ok8lWk2s9MiqHdPG9dnO1bU=;
        b=KU4h6nQY951X2p67E/aVukW5sd6VkruOlDxAQBIh1Y+2DivZ7ggUm8QUAQdFkmSjdp
         jQgtMGctIIPPP39d+ltIWMCRcUTpCbTEV3M78KvE4YZ70prtGbyABStcI+UZ5zkwnHyd
         v43SaIKTi+9odzCVrjUIAerq8ofROnoLjQyKL8xSp/7oVRi2HUuYZiy0uqhzShp2IjRT
         A39uqH3e27YeyzUYGOAz6nNNubsSCl6X8GJ9NNDG7YYU27Lo7M15daHsjBlmsPKIze29
         uEOHOjyjuWV40hn5h/1JugBrXKco8UFt4hYqaqaAtKbJCdAMyhWHnDDzZVt0G6thfcvY
         m9cA==
X-Gm-Message-State: AFuF++m5ZOXXVx33mYbe2DcF131yLdL13nY1i8OtGdNu0lTLv32ltqkJ
	HhXBVYtzqIDZE70wQURUz45ptKOgbcb8gaZZrtHF1M/YhtMlZEr90poL
X-Gm-Gg: AYBFou0X54E9Ak9W20h+70cXZg2h6+VSitcNYw0xiYV9NwZ8ALs9ZSfTSfqvtSG9qMd
	AkKOxzFlABWgGwEprGBA7XTC4seLdrmWg202WeHJIpDwIeOBTDQcpkWm4ZE6pbEi2hCbY+sqODV
	FBqEaR/UouBTtZM9dcnRElljlmftk88/tw1v+PiwGJVgip4d9NPnvff7iyKFw+GybK+VSVvGFAL
	guI2Csu+NdgewX4AEBEOIoXBg8hpyMBCBVmJrfLOFlKVY/6fm15CsV6LBsb97VMelVQBGM9FH5W
	/xcrca6JgD/AaS6QYu68jqy2idECzDecgG2r1RCLmyNVoVgqWRAu91yKR190uGff9cm1q909ooF
	8F5CPDb7rioI4G6TjAUpP0QLvFFY3MxHv11wWmfsXMJ97q7jiQjCyybKHZqwXLaRRUCJH6m8gFs
	Qo25ahstm7PNL6byzFLyUiEBXkvbF9N8AIr3DKg5zyUnOHtmHxd9Ww3KV62kQtHXuJAgtReMR/J
	XWYnR6vQSUFt+F7fdCPXyN9A67McbS1zB9RHPKM6Q==
X-Received: by 2002:a05:690e:258f:b0:66f:c1bc:405e with SMTP id 956f58d0204a3-66fc1bc44d6mr1456669d50.38.1788714514524;
        Sun, 06 Sep 2026 10:08:34 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316347sm58780277b3.15.2026.09.06.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:08:33 -0700 (PDT)
Date: Sun, 06 Sep 2026 13:08:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.160e8de2976b3@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-1-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
 <20260903-psp-prep-v1-1-d47e9c4c375d@gmail.com>
Subject: Re: [PATCH net-next 1/4] psp: refactor psp_dev_tx_key_del()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> No functional changes.
> 
> Lift the list deletion and tx spi validation code into
> callers. Deferred key deletion code paths will need similar checks
> that a tx key needs removal from the underlying device, but will
> diverge when it comes to list handling and when to call
> psp_dev_ops::tx_key_del().
> 
> Also, move the predicate for tx key deletion into a helper for
> readability and reuse in later patches.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
