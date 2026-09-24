Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D94248DB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290068; cv=none; b=X0kJQFeukEx7Vpi35cO2WPiI/nmrs7JUWD0U8Hg4JeI1QAdi6ewQLfFzzmVtTaVP6+1Hu6q079iIobNUOkszCSTGyCyWu2v3HO3ZMt/IE+MHKvZpbzrzNbpGrxIZHOYIGjH9dvCiojsaiahqClxi5Prp/CRfE4EX/FgrTFskh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290068; c=relaxed/simple;
	bh=7SCEEkuBWLZ4T8qu3VgLTnKuBPOEuVnxK68IIqaxVZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr2igbFYHVU7Oa6J7wbvM/p0tC7MExlB0oBFOBtV/0Dw01gIN5LQqZKv2XJ2HymxQw0K6Fedch8p1Vami8+qJwhs+2Pb9uK7me/KUq16L2P4bVLwzCyvO3LKseZil/aqdIhH4mMyrSJRon0UZaokmE6G3pyO5+jfINP6M6tRtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FQSuiEs8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FQSuiEs8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93c486cebcbso678985a.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790290066; x=1790894866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9YuvIHbEaXAjwyRmrBnPzvZ0AzYrFC0d+yhFwM5Vvc=;
        b=FQSuiEs8yk20C3cgH+Uol14ljRLfcc7POmRtMmQZigymu8xU/aemuc/PLEretOlkpr
         pRJcISTV6fatfEXxbRj5EwUW2CSYIbR7U30nml9yd5Hmtyrt0gLSHctneWWoMVuTN7jt
         fkGk8QayFLortbs8rK2nrh5dD208Q/7VroKIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290066; x=1790894866;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9YuvIHbEaXAjwyRmrBnPzvZ0AzYrFC0d+yhFwM5Vvc=;
        b=nyCB3EnPaHWQwWmPSxrhPCoP/36JJUz8ymaovfgEB+CyloLD7wKAls3BDZ6KVb2Tpz
         Y13ZRsmO4TW2nX1j358NkMCSuBd7G34WarngU/Zd3F+TVLXvPdq3zV5bDARH5kMlqVkh
         vfQ+IcQYxc6tNSe7X2ySnzn6mtodQxk9R/uaYN9gxMM2TUJPcp5jaPmqjU6OOWsd1QAa
         YMZolI3wpLQifWtLUyr2OPUpnBGiF+N1FfRy3vBwLe6d16lMHdIJEvUlDRfXoncI2TkX
         97BhlMf9rZhaw3iSkSVumqczkiJ2PXWSIYHmVFAiW8CqgYI2ZPeLLGgGQ5Ahu165ARip
         qLpw==
X-Forwarded-Encrypted: i=1; AKwUvBzU6+OwMPbchfBHVvTjYFv0q6t36+AeO3LUHTxIa/fAFdMe0UQiCz5zYx5FNodQozUB2tDwFEo=@vger.kernel.org
X-Gm-Message-State: AFuF++kLiL0+zaKROeYTYXbVc3Olgx2hblhICnq3FobroqBDP7SSEkqy
	bdCBYRy4LRFxXZaA+3Qd0aV1jj5DZq8FaaV2NhwnJcZfh682l8GLA2wj7FTqk1+b9T8=
X-Gm-Gg: AYBFou2vUK04rMUksOx+grS/Tc7Fu+Hp4fni+cjdyngEX097E9bmParT+R3hQnQ1o7r
	Ju8F0covZfgxOy2tnHeT+ucmOWo/2fwsq4qfYeDgjAdiizWDm7mZL3HYeHO21d7bGj9I7ptCd46
	SuQTp26h0c+P5exwK2lEfJlKA0eR1YmUjRMXZ/aqa0WTbUH27eDIed8rzQsPAoaCcuaGhfL4Zfv
	cuy/cGN0+iiR9A+35nL2cK46pxAJClHCg3wkz59ozD4mpn1F6V4vVQov+oHGcSj0RP1oJnRC8Ex
	JmJszu5QIEo7662eUGtGuRfx2tId5eoxuon9An74G/E4MAaZKFOUC+V7QN3H7E5dFQgBGWHvLWS
	PE/P6O08cQZktKOv9uoOE8dW+bcXQ93z2SV7IRdD5ytOvZV1qmnenJ0BmisivqXX2lWHuskeZ+U
	DWlqnpyfqp8/JVoutLJRYuOUpHADo6ZMcwdgt8LC+/h2AqRqAovhcJu1vDaFfFMXtNUfL0j5LWE
	7Czx2O/QoznnHGyyd4vLl9eDDlEsPETK5U8Al18V81OWIHRox3GzA==
X-Received: by 2002:a05:620a:271d:b0:939:b783:1748 with SMTP id af79cd13be357-93c43be8e87mr134440885a.7.1790290066467;
        Thu, 24 Sep 2026 15:47:46 -0700 (PDT)
Received: from com-94485 ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dd2858sm3966786d6.21.2026.09.24.15.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:47:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:47:42 -0700
From: Jeff Jo <jeffjo@openai.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: check timestamp echo after an
 old ACK
Message-ID: <arWojplQqr0nRjcY@com-94485>
References: <20260921222609.50824-4-jeffjo@openai.com>
 <20260921222609.50824-6-jeffjo@openai.com>
 <CANn89iK00zXGA8sdpH9Y1CkFK3n=uKG9Bci3+=69fGV0UDQ80w@mail.gmail.com>
 <arIE_i8Ysz5nOI2W@com-94485>
 <CANn89i+nY499TfuGMvMq3P=Pxw6vBxe+uYH1zioK=bhU--GXYw@mail.gmail.com>
 <arK0UmX8qJy3O-rS@com-94485>
 <CADVnQym70oFVCvcsGsf1PRcKX4cPK5N60uW3Masf9nNV3c+yrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVnQym70oFVCvcsGsf1PRcKX4cPK5N60uW3Masf9nNV3c+yrA@mail.gmail.com>

> Jeff, if you could revise your tests, re-run both your tests and the
> existing packetdrill tests, ensure they pass, and then re-mail the
> patches to the list, I'd appreciate it.
> 
> Thanks,
> neal

I've resubmitted the patch with the proposed changes here
https://lore.kernel.org/netdev/20260924224456.55690-4-jeffjo@openai.com/T/#t.
Thanks for all your help!

Jeff
