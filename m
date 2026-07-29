Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DC435531
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362236; cv=none; b=eGUZBV375uV2E8z1VxO3qmj8CdME/cNFe9l9J8Uv1FiZtKaZt68YY1qH0oo1dQl3b4EA7pqX7eYDYsc5IQFLw6hUw1vYpyy8N3Y3AkNfTeM/0BaJJBGAEb6eUoa+coF8zq4Kb+NUjaZlxdlCTjYzQyPRzVpf+TrK07bWX8xrXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362236; c=relaxed/simple;
	bh=2EJIGHQzKM60DKYivpoEuF0KnswW5rvsCxap3aUWp3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+9YWxduab6TMaAHtOqd8j32MxmQ8DL68D6wTjRX71GiyLZuJIGb6p4ky014nthmY+I+wGW7fkmisbzq6uVM/c4FlDfyd7odNuOVTFsU9OUy9Pu26MPVGwtWRC4xR07fxEIZa7N7Cp4giUglMPIw78Fe0kLb1k3R+kZSCNTHaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYssBZVJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYssBZVJ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ec49608332so787234a34.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785362228; x=1785967028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EJIGHQzKM60DKYivpoEuF0KnswW5rvsCxap3aUWp3w=;
        b=NYssBZVJF2oRY41LuiBDMadJMaZyHGHyit+JgmjqkU+qDI74C7LcBvc9q/q51AsZEs
         I5y1Ql7ymSEfYSUCN79KFK+RjZoPAmhdJ3H94Dofw6NwHpEBpyBZuPlrMY1/ok9P8S6J
         HIXYp+/cfhynhu+yU2WFrjQ3kY+9ym9TDIdgrJe1K3G1DJ+MHGdkodvekj4vNobUfQx9
         gtdwEdwU3/qxzDZl/f7ojTwVstdoze7oSKChFIiThGjPygKELlPDl3stEpHYgKYvKxKH
         /6jWUf4J/JuaPKaIkbkE6NgXuV+TwYb7wKKJuZOZplqA7L+GHBy/V4A5xyGzNP9U+PjO
         WLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785362228; x=1785967028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EJIGHQzKM60DKYivpoEuF0KnswW5rvsCxap3aUWp3w=;
        b=mYcBLQ8AdsUaYA/lhMKm4xwIQ7an+fgazzn7TSm6IoPdzX8vVKOtJN0/c8H4Lrk9Sf
         V2Dd6Vpe7bwLrwYZSVk8LTQYOuucNa59B9r4J39WVaZvRMOMYCL40uvSZ5Qz6FwiDaZs
         22cn2LywdrVTCnTyorJZYk8jUEAknG5ZqxrxuhD5NcL/upQ1HKE59YIaZPYI3yuNm/A7
         5I9PWzbsS+hvoU1KMQVBZYsOrbcRyI2RYtKk9m5i9ntiWYTQS5nEJ5VoU6hQme/ir42G
         U238bI0+kN7MQsNxXr6YrZR93on5rHIkkbj04bEAUF+PLb1DQbsf1MzwSNVdHFeNGHQz
         s0Ew==
X-Forwarded-Encrypted: i=1; AHgh+RrAPaA0s3Hn8fvR7R5JSE8cjf/sdOur9mUiSwoaOQcFPzDhFU2oDscMxJrPCu2q6cnDTAP7T1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzp7lCZiyNFWJl6eZrkwF9pQ4X3/yd5tSZNihktX0mzeZ9Kr1s
	Ap1TDfcbLXD3Stpcs9q5TTdx7lz15IkBNQIQepdE0xSO7c/g5tpem4Fs
X-Gm-Gg: AR+sD12Alvt5CnkLRT5q1W61AWxel4v/q5yVRSEQuSuVDZLE8mrs0JVUoJjVcdE9XRU
	mToJb9n1STPeULEUdKkRAiPwA9G/JsYIrWW78O7oTMEW5eoZgGsqPrbZ8rYwoaKyC/42vppaew9
	3Ox3bUTFEww92kGpE8q5Q+9kuyo1c4m+mGwbr/K0pRi9+uNNA5Wy29tk3QgwBK5EnsMsKDcYuVa
	R+g8RqMkbxFDhjX5nlbYQvIGPOciJVCpPI5Ze+5NUtywDftS5Is/nLjccTeBWM5Q78WjdU2hNWe
	hWCnjX+403vz7UH0Js/W4veaeulgnrL5O69+0OvGU6F3P5xKTRsDlhZpazqYVobLr+Lbf+qpIz2
	7F9RleJyc/MXCJefy7xjqhAqV5ib1n2sQvLPa/vKrigt8yz6d6mKCSZAgcLoLOc8YiT7mWWErqs
	OS5vw3GwCwVocZrFHI4weVUUtZuuh3ipnsUOzlAeLa/Uw1AHh7sFCFYniwwg==
X-Received: by 2002:a05:6830:498e:b0:7e9:ef39:1caf with SMTP id 46e09a7af769-7f02824f5bbmr345092a34.16.1785362227926;
        Wed, 29 Jul 2026 14:57:07 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d5f3aebsm3305301a34.9.2026.07.29.14.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:57:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:57:06 -0700
From: Will Chen <will.chen.tty@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix memory leak in bnxt_queue_mem_alloc error
 cases
Message-ID: <amp3MipaTDQQtBY8@devvm14195.vll0.facebook.com>
References: <20260728191146.1744825-1-will.chen.tty@gmail.com>
 <CACKFLi=OL=FBZ+L9fQH9cXqMrDtgnqqsTX+OjHqp0ssuDU+mXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLi=OL=FBZ+L9fQH9cXqMrDtgnqqsTX+OjHqp0ssuDU+mXQ@mail.gmail.com>

Thanks for the feedback, will apply these changes in upcoming v2.
