Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573671;
	b=s+MFqRCxRVL3Kb4OLfqnF0yJaeqpivfSiwv6K4qkDRJEyRdT5g6wRWt4wG5jJUjEtz8z
	 Bpp1hu9IF2KyVLVKtz1+AjwY1bMCbklV/ma6x6xu96HOpmohYsaHP8b1EWvrcIVao37y1
	 fdmr0ibGRnKKFr1GyWQ4549zO/Gb/wqrAadgxVHPBCNQq/nHirSbL4r58Hzy9VWqbFZvG
	 ZFnAz8gfLLk7WwD8LNko2499G8Q3RFsEYXjqQR1lczmwdGxSbn+dBh3s8kJAuGu6sitt4
	 66IvCcNV2lAPLk70YxrXtIE0Dmiz7l+yMCkUimDPOpod0cbttwQud0UJHjaLc5yF65w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573671;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=92DTiUUK71Q2LhIuCW5C/IPiDJObqZvJg6w+xoJeZg0=;
	b=wn/ohSDiKYMV3AwuyLyHxMKL7phTQBoiUY4Evtxl9WoK4JD74jci+tmarBCRhwuOaKVx
	 4pVq9DjFSmiMvofckPelmpHls5FoAV82ga7fV3dhbnvLuymIrUODSi/JUPV4Q2PvTd53F
	 qMsbRWX1BnrbHCeqJv+esx2rAGwUniJE2MxZUim7+lEmUkzav25D9BN8Bh9LBr0FHAIc+
	 1W7LCiellGxhmZAebqxnHiDAsl5dUlaj6dijXjz37G2IKJOjEkwCx6PyMjNbWcdc+6vdf
	 Tgb6MDFyM5/LlwGCEtL8vha3pMY2GAIkCSSVlXNuRK4jFEcTkqMTrHa7Qlra/NI8r5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Wi7ENg9k;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4416606A31A;
	Wed, 21 Oct 2026 09:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4416606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Wi7ENg9k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=92
	DTiUUK71Q2LhIuCW5C/IPiDJObqZvJg6w+xoJeZg0=; b=Wi7ENg9k9LJM6XDpUP
	F17zrGQfPluyE0Ot15pI5BtfMYoFi7JhjoEyoPZMaploq2z5QQIemjygn9RPPyjF
	NpKIdG+pSB4m+F65hZgLm0G+U4OR8/+BIZ0q+bEKtQuvF/OM0qEGmv7KFjOt/rLl
	CZNLwBcazQIa2f2L6CbeuCRqk=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHaYjAgNhq_ue0BA--.13927S2;
	Wed, 21 Oct 2026 17:07:16 +0800 (CST)
From: Wanquan Zhong <zwq2226404116@163.com>
To: krishna.chundru@oss.qualcomm.com
Cc: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	wanquan.zhong@fibocom.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v4 1/1] bus: mhi: pci_generic: fix Rolling Wireless RW151 MBIM channel ring size
Date: Wed, 21 Oct 2026 17:07:10 +0800
Message-ID: <20261021090710.28118-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c53fe666-7cca-4d25-8ee0-a787e5d1bbce@oss.qualcomm.com>
References: <c53fe666-7cca-4d25-8ee0-a787e5d1bbce@oss.qualcomm.com>
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
X-CM-TRANSID:PygvCgDHaYjAgNhq_ue0BA--.13927S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjfO7UUUUU
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0QQieWrYgMTXPgAA3R

On Fri, Jul 03, 2026 at 10:00:07AM +0530, Krishna Chaitanya Chundru wrote:
> can you include what is the side affect if we don't have this change,
> like what is functional issue, low throughput etc.

Sorry for the late reply.

It is a functional mismatch, not a throughput tweak. RW151 firmware
configures the MBIM channel with 32 ring elements; v1/v2 used 4. The
device can then post more transfers than the host ring can hold, so
MBIM control TREs are dropped or never completed.

v6 will include ring size 32 in the initial RW151 config, matching the
firmware and RW135R-GL.

Thanks,
Wanquan Zhong

