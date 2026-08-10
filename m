Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BC3C3F54;
	Mon, 10 Aug 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368452; cv=none; b=JSKaIWWipcgb6fcv7qQ1lMphsV8pwLoL9xmTGKW6fxz7y9alIuZrLzEGCLyB7ZqEc9cZO/O6oRZ5iHrpsngK9ZB1JaptMxo9WSsdQ3ztKJD+wBiOtQpk16ZLhksITTuJqlU8eGU6sXpqmcsQxXaTXXyXZ+TfhaVBXSGASQe4zK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368452; c=relaxed/simple;
	bh=3EMYcCPj1uuZMTVnEkwWV94Ar5pjaVI/V5vmu1Fmqmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V55iLGA/f6fHHtF0vc1+TCq3KTN9KvOe4lKyOpeboRvv0Pojbn7HHbChacNT/7ABtlNIlViFsVrIt4KgqzfTJ60PqhXMh0g/jnerf1aYB+8KX2Q8u4SlrzdB89sOKtjR2MXB1n3ECK/T+scFZ1gW2LasKG2nOtIPGE/YLg+rWws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=m9OjMpZz; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="m9OjMpZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ua
	21BskQ+sV0UFZcesZq6cuhZwdX1IuWsh5Xp/acBQQ=; b=m9OjMpZz5faISAOXZt
	1yEh4W+Qge9ixsD59insbCgfpydDSgDmrVV+ZwX5GqxbbuHGyROqkwj9juW5txCA
	eBbGWNhq9bakdTS1EHwy2fAqqq63XniOGKnnOH/AxpMCa0qVLn3iG4l3eBqHi9Jw
	s33fCL5M0aQavbsw887DCyau0=
Received: from deepin (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgDnr1KP0XlqLlaVAw--.13070S2;
	Mon, 10 Aug 2026 21:26:41 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: Re: [PATCH net-next] tcp: use likely() for srtt check in tcp_rtt_estimator()
Date: Mon, 10 Aug 2026 21:25:15 +0800
Message-ID: <20260810132515.6576-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CANn89iK8KSx+EfuANe6JuP=K0DrgTAiToPDH5L0chOj+uO9NUA@mail.gmail.com>
References: <CANn89iK8KSx+EfuANe6JuP=K0DrgTAiToPDH5L0chOj+uO9NUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDnr1KP0XlqLlaVAw--.13070S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIRGRUmp50ZFQXAAA3s

On Mon, 10 Aug 2026 14:51:09 +0200, Eric Dumazet wrote:
> Many flows are short lived, unfortunately.
> 
> I would suggest not adding a likely() here, and let FDO/LTO decide
> here on a case by case.

Hi Eric,

Thank you for your review.

I didn't fully take into account the large number of short-lived flows 
in real-world networks. I agree with your assessment, so I will drop this patch.

Thanks,
Ziran Zhang

