Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31539DBFC
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448404; cv=none; b=QhMKHtejFT3j19R9SSuU6+Jg4vMg4gRDmPX5r5w06W4DZW7yhqe0Vqe9QDCkuhUQPAiyvtS2Dk498AhZCqj4PrrGrD9Jzpr6lIRY4nIwbBieN6P6NERh9XeRAVlhyWeRYYuxor0sqpRdFU1dbZb1bjHZ9WD5OwkCnpjZa4ZjB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448404; c=relaxed/simple;
	bh=lpr1JjX+P9ddvRnDAtgdZ8YhdQhIEvfPlpdAaYpJZN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV3ZMu1LcYYrXXkduIzMlYI1AuEhwtsAMutC6NnE1KywgtI9h2dnOUF5kmt9bym3MrZBZRDjVg8VMUsSU+6OPw4cI/Jz/X4Q5bWuqswetOEGAEO2lhQobR6HihdWrjF3Tdljlu1hWoipKI1UDKKTDDCN66A0X6xih8ugJe5Kiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tay4dpoI; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tay4dpoI"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e9f7491ffso5163317b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448402; x=1786053202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpr1JjX+P9ddvRnDAtgdZ8YhdQhIEvfPlpdAaYpJZN8=;
        b=Tay4dpoIth7iPYRssDwp8r8dbWyAgRqSvqjoXSAkLd6IUsRtLf823EjvjvwzTERHwk
         SU+oS11o7NKVR279FhQSmynX+LPIxvb8zumI9K4YemIgDSYOTu/8qhg0zZRbh27j0D1O
         VuYCbOZ+CN36zZ5TE1yMGd2e0gq8m+Zy67eTTlzfPaJierEsOHFPekkmMKcVNbXDyour
         XNDiNo+gAt7dfmvv7BxlrSxkOB12GuiCE8H2Ky0mX+55W+o/FgPv2ca80IKRRm6VtHY+
         1zLbFelUWLYW/KnHwHQykj4omJOqGkqCai2qX6Q58j01cD+9kX+Ggr18Xqm3DmIKXC2X
         jK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448402; x=1786053202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpr1JjX+P9ddvRnDAtgdZ8YhdQhIEvfPlpdAaYpJZN8=;
        b=CuNmE1Gn1NXIetc6w8QqWhN1AFeSUg+Fu8MK/l0BFZcSSuSGx6vVZHBsLM8S0yDwJ/
         ImdVp+YkrnKI+5dS0IoCSJWuhdJR2G8CnU11d+eIHVvJ6lmnPi3o/enj9HQHl8drBuVA
         iRlAXwtUsGJrOv2rKX/XKjKDaC6XamBYpdSSU410nJOpLsBVH3ikzadjwUfLvaX7fLSq
         TU9rXF+Ll6XYxNzBe7dnhJNhi2MaU+9u46d7O2gpsFkpdXncaMWDLTdTi58xA9KwIY5h
         V02Dfa80ohz5k37ymcI51BvvwAEPktsqRHjJQnlJsld1Hl/La0AYfs+GIK2cWDjsD/Da
         elQg==
X-Forwarded-Encrypted: i=1; AHgh+Rrz4rwP/K/VU2J5oz2jl/XT+oSE88uVHCdNm5gdSKbyPYVzxSgVoJcdK7oRNOxUYkfGvtLpXBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OeVeVDTWc+B55AHzuVHbO3RlzNtLAp7fU2OROQ9prVBbiipA
	bFgdVUBTI6c8rseq4z//0ID/LSNAPT4Uh5yGoKvWTIHN0/PfJ67lDt4W
X-Gm-Gg: AR+sD10cYlu17UD0eCayWeO4tcKnzhuZjue4yuzUTzsfkdwiwdd8fczz8dNmyo35GdM
	YeOb5dkS9XX0/UZyvSDpuFGTAcn/iH3QTR1rFscVUYALOSMpjfNgy242mGTdaFyANtjSuQ33jKj
	WYoW8dkbv0al5MGX0KUFi1wbfvcYg7PlQb4AlLnruWxSNH+IWIKFfFLpY2HTiLhnGqb1sq/2G8M
	XYM7yQmI+Da5U19y97BVfUHBV2W9aIhOPIANmRzUkY4byD9SZBqMSRqPOTar+2Ucq+3A5MJ8Y1W
	Petbzu0rzoB/BwuMbSpwyZ24QQLv0UlcW7suIVSRh/un+Fk5YEHiy+ZTNwBIVlIRZSQCAsANYV3
	Vmj3Zv+VZrrVN/8mxOTnYMTydCBIOqq6l1PRb7mup9UmqWiJXsWKaMZgw5TFnqRpVayxep/GlSP
	IbA8Ll9u02pCHt01IspBwj6+pQJxIciB4HQqo2J9+llZ5CUW2jEfFpEAGbtLsoTSmekeNfwnNkM
	Jvng2lvmUrYkbhHz36hzQ4mYrjg7pDD3VMYIyS+1XdasPydwMuBh2RIBVI=
X-Received: by 2002:a05:690c:6d10:b0:81f:3dab:372f with SMTP id 00721157ae682-81fb88c616fmr31428597b3.12.1785448401868;
        Thu, 30 Jul 2026 14:53:21 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain (76-204-101-112.lightspeed.tukrga.sbcglobal.net. [76.204.101.112])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8a8dc3asm17635417b3.25.2026.07.30.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:53:21 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: i.maximets@ovn.org
Cc: AutonomousCodeSecurity@microsoft.com,
	aconole@redhat.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net v4] net/openvswitch: check Ethernet header length in key_extract()
Date: Thu, 30 Jul 2026 17:53:25 -0400
Message-ID: <20260730215325.117542-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <403ae4a4-5df3-4744-89e4-12e46fd56f25@ovn.org>
References: <403ae4a4-5df3-4744-89e4-12e46fd56f25@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the reviews, Eelco and Ilya. Sorry for the delayed response;
I was tied up with other work over the past few days.

I'll send v5 shortly.
