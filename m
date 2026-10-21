Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585777;
	b=GOhte5OORcK2hJ1yByBv/twMCNOn9Ly7yF2Gat5f9klZD6shN2qBH4slTzuuT8Pvx3D+
	 wChLSgQTHknRcnJNKfGFg5Ebavy6Y0//b5CVqjIhz7IHWKouIBHwOwE/COZiHqpBMoA/M
	 eQ9oBVvWlC+1I47cyoBHhmZBvFG+1khSUMvT1ZVhkWdbR0vcUaxS6SalvszPnrkhe0a5L
	 vzsmQbHCLF7eCujJOVlrS4Sj+mXV0ErZmrAJfRITSKmcsNSQRTIvo7fUTBOsiqYYwQUK/
	 4+v6l6pLwm+tT6M5/fwBxXTtZHbG4qpYjZWPVCRd3tNMZ8TuQrvGfz/KzlydtgSSAiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585777;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=ALL6UWpxChP2qKHJAg1/hi5H4UckoPojIx6atEGve9I=;
	b=JgLXHkEn0Nq1J1c9lrMCVUwmvH/y2dgoasFgFcHCfQXaiRNe7peIOEduJb0i3gvzxeq0
	 RsvNJMnKop+2usFYOAnzxPob6Gk6Sk9Qnoj2yUO0FNl6uFj0O/h4ULSkkuEz+lsIhMqhe
	 oLXJG7fVV4cIDTlgRs3asGiFV9PEKedkjg+NLu/L9u8wYrBGpctaUHr93fT6K02GYLZLu
	 SqWNSmtFeS4U+6jMw8iEGvaQQ2HXzdCpl56GjY2Y+j6yeUl2uaAFZTo7pZ3pTHX2L6kLt
	 WhS8zEl9BShHY+N5/A9vWwukvwVq1KovCz0DZpeDMeFM5mCTBtkDaJ4B84wv8oJnnDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="Q1/VoNY1";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF4606A319;
	Wed, 21 Oct 2026 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CF4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q1/VoNY1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=AL
	L6UWpxChP2qKHJAg1/hi5H4UckoPojIx6atEGve9I=; b=Q1/VoNY1IzJHQMHBzC
	+tvRmlXqZQxj1xzZoNsvv5Zf1R7l4tJGXi/6rIAs7E1fSjB5zh5hDT0Gl2JrD2xQ
	/qbgGWFQfdwkSmWbtxiWYo+KSALgq4WxkES+lbOVr22AhuiVQsJC6I4oO/fHs9As
	/mRsiSl+NxHjCDCbJgerGEaY8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3v7D+r9hqCVq1BQ--.8535S2;
	Wed, 21 Oct 2026 20:28:46 +0800 (CST)
From: Wei Tao <taowei@kylinos.cn>
To: kuba@kernel.org
Cc: netdev-bot+sinfo@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_fw: allow filter replace without re-specifying mask
Date: Wed, 21 Oct 2026 20:28:46 +0800
Message-Id: <20261021122846.358290-1-taowei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020135321.21517b1d@kernel.org>
References: <20261020135321.21517b1d@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7D+r9hqCVq1BQ--.8535S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW5XrWDJF47Zr1DtFWxCrg_yoW3KFcEka
	n5XaykWa1UXa1kXF1xKF4YvFZ7G342yFyUAryqqw13Za4DGrnxu3sakwnYvr1rCFWvqFW5
	tFn5Gw1rAwsxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0TvVtUUUUU==
Sender: cs_taowei@163.com
X-CM-SenderInfo: xfvb3tprzhxqqrwthudrp/xtbC4h77PWrYr-5DQQAA3b

Hi Jakub,

> You are expected to reply to these questions. If this is an LLM-based
> report please be more considerate of maintainer's time. If you actually
> use this feature please include the response to the question above in
> the commit message and repost. The repost should not carry a Fixes
> tag, it's not a real bug.

This was found during an LLM-assisted review of the classifier
->change() replace paths, then verified manually and reproduced in a
QEMU VM.  The hint came from the cls_route in-place replace fixes
(41e85e54e564 and b72e025ac556); auditing other classifiers showed that
cls_fw has the opposite problem: fnew->id is inherited correctly, but
fw_set_parms() treats a replace like a create and rejects it when
TCA_FW_MASK is omitted.

I will drop the Fixes tag and post the v2 once net-next reopens.

Thanks,
Wei Tao

