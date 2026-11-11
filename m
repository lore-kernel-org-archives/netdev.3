Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402065;
	b=DnH1dwVOknbDzwN0FONDz/7kzvlBzoQnPbeNB/wsNcW8toBEYy+gU8bVabKb9jUdGEJ6
	 KbiEYnle/j3PWTba51fBRYhyDTCGmEDAx0sf4pXohCpjz7aCf8bUVu365kZjwLr1csRRx
	 jfjQFZjCiGvENl/YL3HYU3p+TKN2FUO9YLnhPw8ofxs7/BPtRV1J9kpICXJ6fTtjihwRE
	 hC0lwT77CNO2OE9SvGUX5FeK+T9pywQ/zjVgstnItsqqBiPxSEPaSlBuHNwX/k9vZTiqi
	 rkoAg70nuN61rrX0Ep6rTrnejICEvHfo9uAhG6mj1mbZ7AQLnuwJIVDMq+VOBYc+8dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=Lp+d1lKDWD+EoNjioGtSqfmg6GTgnHSV5Zf4uTiTucawQQ4OHWj7qWKdLR3sLntRSsOm
	 EZbvIL5ffHzUhxYgKRJb3hnpmhjt67+P3Ex757ir76+mqYCKu8VXztwkKs56rZH8UiG17
	 XH77PS9QNNEatajjVnwNosW5sKJBIizAy1wPovMIZWaJWJTdQhMJ98dXCirvtIJL1TXmu
	 CcxcL6ZFaqwLWZowR2/1ro7d9PvsFVMt5YRWb6O/jLVHR2oG3oKUP7+gA0g8ybexRsMP3
	 sZ5h24eKcAyLoDJGFUqVajFaqa/YUYspbZBXyDLWS7NcDOtcEEI1S1i7mIXBxbXMRDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Exb/Q5gH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE1606A337;
	Wed, 11 Nov 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Exb/Q5gH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062221F00A05;
	Wed, 11 Nov 2026 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402064;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Exb/Q5gHHQ2fZNBit+FT2B3qCdwOneS4R1yFRjwOIWpef3PQAM8QWKQqveb2kWGqq
	 7p7MIt9OeeOTcAZxfNtjyvPU3Od/+eF6xcyZcwl+F6I9iOEcQZYhmLX2FympS6ai4E
	 jxtAzexpWzQa7dLnRxVqM47htv+LnK5qZmCcszpRn/14etypRj9lAGKdPszx17B9xe
	 uGseU21xj2NrnaJbLvg/wN8b8118GXx34U57xGvkBVVWj3SMQdvynBvaix/vH55Cj9
	 pAmy8u108LzHEQzC8i/Ekv0F77d1HliJFTmgLHE/aEkKH/I9iwKTCYcBAWEHxaDNMy
	 ZmW11CoUC7Big==
From: netdev-bot+sinfo@kernel.org
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH v4 net 0/4] net: hns3: fix multiple bugs in reset/error paths
Date: Wed, 11 Nov 2026 13:01:03 +0000
Message-ID: <179440206352.2168702.1328392786936670574@kernel.org>
In-Reply-To: <20261111125810.3359030-1-shaojijie@huawei.com>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
