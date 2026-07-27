Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCC41D139
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167904; cv=none; b=R8mrI0aZl1l/Aa5G8oiac+3YkGJB7SwuF+6/yOPvkVKXrKLZdJvbdvo5auL13OSibhufnnmHWg3MFtjGq89xSMk6s1BkuiDoOA93fwb1whzSY0DZHrSW1+nLQ5Pbf8YgtZavgZfYsHVHqeqc0Ph8gd8gO2mS8zHfbCoEtXMt/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167904; c=relaxed/simple;
	bh=BX9bwe99deEPi9NdI6Iq20Xhh6lQl753kSnAChLiVCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJlJs1YGRcayCdenh4lDlS6EwpmwC4MQTcmcubFIi16oFQG2FLZTs61FgokdVJ3qaIWYpAx2XFrnL/FhxF0i5Xol6B6E1E05zeW6RFLom2j+PtZwJ1ivkQJjE9oqHZh9SZMjQCc+9lfoUzLRU8q8YT24hFqGjjDzwlVsqufOqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axx8WdBP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axx8WdBP"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2085207a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785167902; x=1785772702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX9bwe99deEPi9NdI6Iq20Xhh6lQl753kSnAChLiVCM=;
        b=axx8WdBPMQBNYO3ou4JJzC2dw3+ly2NtkJDHJPvBNjOPukdaBaMnXOiSmP9/g7ZkzA
         DJj/5WnSKRrHHZ6ijy73+XOIgo0XZKy8WjeIV8bLD9Q30FVGvE6YpZBPptD91Ar2GV3N
         yQ9PybahKK0HF7FzEN+ZPYftKr9ke4W8HcFbDXeG9bO7QqzKx+g+sil0z1GFphB5730T
         RgJPWV8HDL+K9d/H+5otXiMtG6u9weLkwZW6i6sNVi+Gfv6xZ+MmhCzhbggnaAVSGxIE
         f5cng3IE+mCYR5TyhsMLKPZxSAoH5TTi7Ap5LYO482aUoOvuWxU3Lo93UBtJ+WtJ5c2Q
         bzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167902; x=1785772702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BX9bwe99deEPi9NdI6Iq20Xhh6lQl753kSnAChLiVCM=;
        b=C2/Ht4IiovkT2x6Q2UNZjrVIPO7gQLAeqNyNJvWjElNJiWx7GCvCMYa03X98FtaXPO
         I1YvnWlx2gT/uJOnIF8njzvhgYhhZaAyoljTTD9se9rdwVIa8fx3E9MmeI6Zu5HOdsjT
         mJNATbYJlTfgqRfycvYw2zOZlT9w6O6B8lDnm812y/EU9nEaHh4PYR8fdJABa46bOtMx
         6T/JWNaO+yfrqXUE3JCyULzRpc+4QLaE+nXO6nc4lrhQgWRPkruCjNHOLD4mcDEOU1TN
         XA9g+EBJEQ6J10xU006ybNV57Wii0pZ9lKVnoKALjDIFhU/q+XtV1wu0T4DxEwMq/cjO
         13Fg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+CDUbE7ajMXCy/XC0eQLouuxMRHim3JS6OTV4BWm0K/sHJ9xh43QttK5LBd2mw3YuNkt5qsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoNWiudcFbz9zYw1HPKTAMvFVYxwKThmcJScIfI3L1c5BvEMC
	eXfslbwMg8Am607G2Bo2I6XVtxR9otLi4tzGgKcHSyCVrKRq9Qm9gqxm
X-Gm-Gg: AR+sD106ORN+7IX1IZ+FiSnHPQPSvku0XBvA4GdZcEPUeqEFDKEHxEQgCihDGgGlcU1
	kLZZlCYCEWB2BO6HcWJOEbl3UWWM3GiS5VS13YH746CGa4CGE0N3Kg/4rDFhrZWZorkE5kRtKWo
	MbQS4EFW8+83M9RcQqdWUUfasGPgP5vqX7rfsZe3VXQwzaEAOfrBheZExXZzO/a0zl7Dg42aws3
	nyghbiRnWFQO1xNHbKCk+Cm9w7EJ95ZNsU4bSRNKIr8iHFurObuGLs/NvXt2gvDPNVhDTmQbPca
	b3L+ty1yyds7B/D6nRs2E6+zaTrgg5TS7j2vsK3wu4jnwO5O9zDud6xYq9ot2nx95cAqNCq3fia
	e991lLHPdHFGfSKMX9AB+VwMU7R38Q768zrfpMfXHgHySy00ONU3pZdp6UB0FLSg27ecEIhWZ63
	/dwfx1RW7FZDnrjL1GUNw67F9rEfqFoGkRpaiBAaeGzx/pzTJ46la7fUptliG38KgAhS5UsY5RZ
	dc8wrpvenkLUvTBBYEfsp73PPtIo5oDe84iSm5pCnVc2/MdVqBQ4xPuHKWKLJbcSQ==
X-Received: by 2002:a05:6a20:a10a:b0:3c3:7ac4:dac7 with SMTP id adf61e73a8af0-3c6c7d8e60fmr199334637.45.1785167902516;
        Mon, 27 Jul 2026 08:58:22 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:8b84:a60e:2cad:e760])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm88978600c88.15.2026.07.27.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:58:22 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	hemendranaik@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	tahiliani@nitk.edu.in,
	vishy0777@gmail.com
Subject: Re: [PATCH net-next v3 1/2] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Mon, 27 Jul 2026 21:28:14 +0530
Message-Id: <20260727155814.6454-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720154635.627948f1@kernel.org>
References: <20260720154635.627948f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo, Jakub,

Thank you for reviewing the series and for your feedback.

We double-checked the formatting tweaks and confirmed they are not
required, so we'll drop them. Any unrelated corrections will be moved
to a separate commit. We'll also fix the commit message indentation.

We'll incorporate the suggested changes and submit a v4 of the kernel
series, along with the corresponding iproute2 changes, shortly.

Thanks,
Hemendra
