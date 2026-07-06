Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111725B0A2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353937; cv=none; b=JvMQ8N+dKzUlyGhvL1BJemk4SZGsqdCXzhC0JZfPwS7/D6DB5+k6RMj/KwAHYWOon0AD7/vLBFi9lqG5d2lIakbJd/BYPUpZHrSzxRx4xYiR0606R9KInzw1yYSXiz9LFONkIqYFQn/tz4MPcjeOLlTuEk8dvkQX+oNrpHy42To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353937; c=relaxed/simple;
	bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNfu+FAT3P0shYqizgNTh/T3XR3PfwIMrszXMg+bTQ5zlFJELUp8kiIYfkmnlmsTzs4iBYwuaaDjW7okOHSgMh+6mzF8GWEzTh7bUEYEdL1An2uHyzYGBekNBoB+A0zvWcWPj9csV8yGOOzzIninhxuQYmy9jwyO6OHDPX2zeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuxSjCnJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuxSjCnJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1290747a91.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783353935; x=1783958735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
        b=iuxSjCnJM6LBXRrOwGJ4Oo0T0hQIp3E/E7fCXqi3taSxdyzARmaOLRUkuXQnHNaSQf
         cSnDcSapbeV/hSyQ6wUOFMg0oiWGVSckhoz3g/Kh8IEOgeL8LBvSA7OpE0P7SunIaukd
         kpvsqkVV9J7X7eAddLFXUsq33eGIQqtOC7B9yxdgroYpWjd1kA8RdlshuUMxdLUV8TeU
         AWeOj0nD3BcrgKWbNEi6VC47sOa040ZRh7raYkVbZbkwTqtU3/z38P5b8qYmay4dJCXL
         9rlfeZpcAOehe+2ygh7+waK+LigLmbpCmxlj7wX1KdU3ORLkBDSWUtKrN1HI9fHuIa/3
         5yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353935; x=1783958735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgoFvMjglLHKQwHj5R44Ro/GGHkMjOkh2y8zkzFj6tE=;
        b=GQdiwx2DeggeY5wUcgZpYSn7yS29cUI3rVPOxF52oaNp35LgXauMQ0FkQMxpckZGwx
         b4d9TZF/DdyyyW7ETxM77cJ00QL2LNdTgfwtB7gdn/+pxa6pmTcdD3ReOB90hnZ2lswK
         dVqkxwSmyOdD5fPt0yj+FU9OGA8z+4JCCut4ycggsGFFAxHFF3H0s7EBDMxsN492Eykf
         l82yK+UhR5/EcS/oN2IRX74BSMF6E9as4n4FxP1A8NyDNISJKsNL0MG8nHUQh7MxhwmC
         hcH+xT/AQZHKamvei1rSqitKGfCoxYSWoS+YpW3HNHsj4ptmFHsUdU9nBKtkwvrW9GRc
         Yaow==
X-Gm-Message-State: AOJu0Yy30hzqHrKI22geOGBqzIqSLlmXlpjGGiJqum+3co1t0ApuMrI3
	fQTZVKeL+eMF/ZYlhf0/W1oXy7dG/vVQUoq+A2qyzqDM0qTEIVD7ZXHy2I3bfCHq+/NZ5Q==
X-Gm-Gg: AfdE7ckXU6eJHm8OfBjCEz5rRBl1zD6vRlWH1C7VZv9/AOu5qxIxVD9uvxQThZZZHRu
	e0tLVimWfK6QAqXQznTYj4hegJnIglzx57+jK3xWZWS/slao/3EB3yOMRXTy6U0C+AVvCfxLGbO
	/GDFx5pg/YgjbzDXW9e0gxE41EzNzlMi7yAMhdUSExek37AQ7bxghGAhhILzWbhFaNDfz+sqqp9
	rGXvwrEaD1g+mnwz9Qh2qZUK6VuhTSoVh3UXB25qlLf8B92YMw1XVID0uZsCx5lLRA2AZWdF8Hh
	fqkwMKB8v3VK9FNHwN6osXSAXQywq+QUhplBux9/QMCo8jwrEau7V0eWZPJ1HFvcl0fBqvacDqW
	tqadFB4VI84vkBfomsiz5z/X7v/tOIZP1EAgIIA9xo7cypQv4HDWGVD2TzvkjkWNKLqstM+sr5t
	gbUxCDCe96ePccF5mAX1UFLwY=
X-Received: by 2002:a17:90b:3d87:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38757a838aemr1134432a91.27.1783353933738;
        Mon, 06 Jul 2026 09:05:33 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:1840:f07b:ed1c:fca2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813c4dsm51596676eec.7.2026.07.06.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:05:33 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: netdev@vger.kernel.org,
	lorenzo@kernel.org
Cc: aniket.negi@airoha.com
Subject: Re: [PATCH net v4] net: airoha: fix MIB stats collection to be lossless
Date: Mon,  6 Jul 2026 21:35:27 +0530
Message-ID: <20260706160528.38665-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706154730.36949-1-aniket.negi03@gmail.com>
References: <20260706154730.36949-1-aniket.negi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

I noticed I forgot to include the link to V3 in the v4 changelog.
V3 can be found at:
https://lore.kernel.org/20260702171814.11165-1-aniket.negi03@gmail.com/

Sorry for the oversight.

Regards,
Aniket
