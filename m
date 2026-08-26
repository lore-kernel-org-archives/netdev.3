Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D4471274
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766586; cv=none; b=amA/TC9Sy417baqnm15n+CiOvhVdtaZIKk4WFeGixxgcpdHlzN+L7reImKSQdlepjdtp2bHZBiDX1K6wkeWilooXH6TPd+J7XO7vsw8tpDvZcEjjCZptAKWkyEE6p6FbbOvWvhxB+gMfattzvGBxPRp1cj1hzIIt9b3ZvNqGXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766586; c=relaxed/simple;
	bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmDf3P+ynspJDeREmU6xG+cfwk8zlIx0nNcdhnXGwqLq49GVg2FOVOWB1HfMykWCmkHDSiMnFP7Tt9sxSVCOlUkp2zgX9Zdb+UR9RJ6G4EfxORQhvAe0AaZ4AlHK00DVQ46tTFMALcx+zkLzkKnBvHPGs5ysObnSuIvPeQbTOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1H9l2hJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1H9l2hJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso960714a91.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787766574; x=1788371374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
        b=C1H9l2hJBtw4weAQ/oKw+cjQHWqeQsUlUAow8SQpk84X54abaaybOUQinHu7eqHUFJ
         mCUfB4yEfT3dZ6hqIp4k31CWDdFiz61mVLYUeGlKXHNEXD4bvRuCfcyDdZTbOCMwmKUg
         dhe152XPxRUB8dRlZ4JAQ4m7FheCqTxqpezXuYhl2y7I7kMtCsupOEqRIZAEpl35GLlH
         SslYZWnE0LdEYfOJCwpB6TWSUstJKZq9kDnFXaXVlsfvYi2xCaUkcSQ5Rj+MqUnNXFwg
         B4xk/0/sO3CSAtlyEiCYIuQpNMr3W9AH9LoPMxTFZBn5eAADeProfvRM6z3RmwtzoWR7
         5uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766574; x=1788371374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8o8c4IAe8U75qnpSJQagYzi56CmZ3s7yR+zEHSeQMv4=;
        b=J1u7VMlReDMOnTnByaAuekrBko+06eU+1zXJcR3C+g6UxxaosNuLcBRQL9Z/AFYztH
         z8nMTE3reRt54efokIALlOtS9vVHPsFZHZ9px7YW882KUC+BU6BQqbmyaT1NhR4j16oA
         MF+3/YeuwkexjLLY3BtjYbgs36N/DZ6Hp6KpgBjhKIHj+MK0jbj4whiQ+6J9F0Edex3f
         43xyO/1V6QIw0LzJIzS1bHEIqrmZsu8+Ef/kmq+egku4+cBRkSeTnYXWUSZt7I+mpy8o
         r4n4gNmGqo75zb2ZJMUTTvM4pqe6v2QhLlGzZ3ur5A4rpDvC057guPzQR2gu+c9F0U07
         JmPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEVc04dS0JridMtz9nUz010Gwi/opwYG12HYwIG5F0/LuYzpfMioK+2R7FwBzPl66fU/oizes=@vger.kernel.org
X-Gm-Message-State: AFuF++k2Df4Np5Ejs5TMtfV+ac0XGJ1jKZxA0v4Cs3fbfYRyLoepzLyx
	0WplJjhfDvtum3REeeMswCeH2qJk7oGpYq9oN2AtoYJw64X7lJKKW6SN
X-Gm-Gg: AR+sD10K5Q18huOOqq7HQueYAC1iiJpTIfx/Vc02gGhapsLcZse7yjNnTcyhokMpBL/
	qrwDCNC/FkyAoQjuLtujlnttONxf61Jkrjjf4bSjMFCfwciEVsdXVqKKR1iwtis/UM8hzr0DQmt
	6rWnoAR6R0KiPKURob5b5KEzW0fdMCRBtz1gVaxYcC7XKtMr/kjNQcWvz/dAHBm8udwqUtNtst6
	DbroUhGBTt2D+iR5Fiq1dLv7ECLmnGz1Ekw3EJTsjl3u48saQQXkwj+JZuQji2VRPU6VAjDi+3O
	ShjoEZ7RmpKweJNrkAXZWt3Gtgbdr5mWhhXbQWNHZr3eGgPusF8vVMYULtMEokqPAtr3GLHEixT
	zT/AdvrC98dLEMWMRBMPtikWolFN9pVC/hgkSP0T83Kgq4EoRThwipYlu3eBFgFRWAKkujAdrHZ
	7IV+6dEiGUMqeQulEW/w2VT/JUv6GCkq7CGNM8f5RVF5dV3CMohVV1sCfdHnN7Hciv/IeZpQOMN
	BTot5nWtK56rgJqN4jhUJg=
X-Received: by 2002:a17:90b:280a:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3966d1e226bmr18902135a91.4.1787766573836;
        Wed, 26 Aug 2026 10:49:33 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3966875e5c3sm5093511a91.7.2026.08.26.10.49.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:49:33 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v3] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Date: Wed, 26 Aug 2026 23:19:25 +0530
Message-ID: <20260826174925.3425-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
References: <20260826173019.2917-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I sincerely apologize for the noise and mailing list churn. You are completely
right—I made a mistake in rebasing against v2 rather than upstream master,
and I should have respected the mandatory 24-hour waiting window.

I will pause here, stop sending revisions, and ensure future submissions
strictly adhere to the 24-hour rule after thorough local validation.

Thank you for the correction, and apologies again for the inconvenience.

Best regards,
Khawar
