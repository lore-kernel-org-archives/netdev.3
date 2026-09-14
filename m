Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBB47AF5F;
	Mon, 14 Sep 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396794; cv=none; b=QDd6SXcVkPYC/x5Kf1hIqnOGkJduPzDCBnOArRqCxmDCw48K3WJIQs8pEVO/6Z1Vg82SbvpVWez4+yO6D1jgt0GlU7fq6emz5Xec9VT/8+G19ZY1TwdR75Idp+DQHLUS5jSgwhLYlp/oID4DOVcK5iXmTY0WoNzdwnUeibxAxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396794; c=relaxed/simple;
	bh=Tf/OcllJ2Yb63WJf1blzFMdyNwJao/wBuYAaItBcEfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTn7CltV2ncfkg74vMG0rCFAZiGuXBfyzMT/6Zwb3PZ7rrxQ/sab05wm82h1YnVMJ/UhmAczfkfsCZUjKfixAgqmzLohZ71BbIpTI38UYAZZKVWmbZ84JKii2v/bBoksbAPqEzJT71cLFostG2KiWQvi8iItlzxAhqLaMlZu4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eaFyewLk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eaFyewLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tf
	/OcllJ2Yb63WJf1blzFMdyNwJao/wBuYAaItBcEfg=; b=eaFyewLkH4TIDXFqvX
	5ksgDwOzYVORHyaVLJ0nbPS7QTIQM58s+fp30uLaV3i7ItBdgb5Vu8DV5/R7jXM0
	hVm13d+lB+c8kXP4qibPqVbrl9B5LrKn8+JVEcRJAhSjQgL41eYW2CatJKSuDGjy
	XHTKjrM1IvkoTHcWqWbYZ8EiM=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXBL3qBqhqmNCpAg--.22384S2;
	Mon, 14 Sep 2026 22:38:35 +0800 (CST)
From: peilinhe2020@163.com
To: he.peilin@zte.com.cn,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jiang.kun2@zte.com.cn,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vbridgers2013@gmail.com,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH net v6] net: stmmac: remove software VLAN tag stripping
Date: Mon, 14 Sep 2026 22:38:34 +0800
Message-ID: <20260914143834.5828-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7d72b99f-ca65-4ad4-954c-b3f9d07de523@bootlin.com>
References: <20260911141126.10592-1-peilinhe2020@163.com> <7d72b99f-ca65-4ad4-954c-b3f9d07de523@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXBL3qBqhqmNCpAg--.22384S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW7GrW8GFW5Gw15uF4Uurg_yoW3CwcEk3
	yDAr98W3y8AF1q9F10yF1YqFnYgay7X34fKrZ8Xw17try8JF4Fgan5WryI9F4fGayFvF9F
	yrnxtFW8t34jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_GYLtUUUUU==
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC8guAMmqoBuuG-gAA3c

From: Peilin He <he.peilin@zte.com.cn>

Hi Maxime,

Thanks for the review and for the detailed debugging.

> Eaxh patch should be an independent thread, not a reply to the previous
> one.

Ack. I'll send v7 as a new series instead of a reply to the previous one.

> So this patch breaks all the stmmac selftests on some dwmac1000, e.g. on
> dwmac-meson8b :
> ...
> Can you add the following patch to your series, as patch number 1 so
> that ethtool selftests still work during bisect ? I've tested it on
> the board who'se selftest failed with this patch and it works :)

Thanks for the analysis and for testing the fix. I'll add your selftests
fix as patch 1/2, keeping your authorship, followed by the software VLAN
stripping removal as patch 2/2.

I'll send the v7 series as a new thread shortly.

Thanks,
Peilin

