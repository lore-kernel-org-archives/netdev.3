Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573672;
	b=1FPxKebbb+OU2d/AO/uEuMyjrrXhIoQR59C3/8WtnfSB4Kbo4qoTMPGqR9c8uRPuJYJd
	 EOuqzI5HKmtQS9YvokZigFMxJzYOnUPrxH7AeSsehvNBMF+gibbA4TrxvE/gjF3qdnuQx
	 ztzHXy/gT7Dio5eSMqxNv4e1CjjaC2JET1lDixNVYS0hi1RhUhfDV3RCMhkZ4G2f2rYIs
	 MF7pCVmQFfO/jnBK7QuOhAMfFe17Ex7Gkd5YJ3LsiEZbdu4Nb7UgFagerf6vLTGu/lG/w
	 FBtSYDmkfnJQxnPecrLFU71sc1EFqprO4/ituyyc5g4LxzCmefFGNlOASnXKCqG7McQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573672;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=3MfQo4XefotqxxW1RYIcEbLAl8Nv6YMq/9qlNQRwcoc=;
	b=f65fOAFLu6HEP6uJJjUxrumti81tcaIyekLYHYkE+JOb5taO5m49/CICLKHIE9FOrywV
	 Fi5nYirL9dme6s4M56r9lXwtKRRmGqP0QHpt3CR53t73wB0+VHmdNOyPB/iSn3Dgomz6Z
	 V9hsKJyPzyJ4vgxLSukDtq9spC63IR8+Suks86BvE/1JAAUeELXL7hVmCmyQISD9yckZ4
	 fA2r+tNOSmHmVdxDoUOOz4LcnyPDVyXO/iHT30ZEQzGQXf5JR+vF2Ttyj56e7lRJJpHND
	 hVYaxcbSEgSjxlZFnN8Ak1PhyDu0AqUMgO+se14FVG85FxvPm7GgoURidd4DUcu0aNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OwAh43LA;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCA606A31B;
	Wed, 21 Oct 2026 09:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFCA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OwAh43LA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3M
	fQo4XefotqxxW1RYIcEbLAl8Nv6YMq/9qlNQRwcoc=; b=OwAh43LAh9swc15TGD
	43odoXgyv6UfhHKE/zU02ww/zShYUNEQwrnjyBf3PkKd9h1v1fgNrfFgUPRbe43B
	NcNQLJJxo7aQS4laXrHhIIPpTuzT2TN/Cj640CmZTN8Jm5NRqigY5RXuJBzsfg8q
	GnJSin8mp6IcF2og7Q5gns1HU=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3X3G6gNhqgiS1BQ--.19129S2;
	Wed, 21 Oct 2026 17:07:10 +0800 (CST)
From: Wanquan Zhong <zwq2226404116@163.com>
To: mani@kernel.org
Cc: krishna.chundru@oss.qualcomm.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	wanquan.zhong@fibocom.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v3 1/1] bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support
Date: Wed, 21 Oct 2026 17:07:05 +0800
Message-ID: <20261021090705.28106-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5j3wmfvr22upwu7wxraletiic4frdfkpusbko5xbegfgk3xdc7@e7oayedqofnz>
References: <5j3wmfvr22upwu7wxraletiic4frdfkpusbko5xbegfgk3xdc7@e7oayedqofnz>
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
X-CM-TRANSID:_____wD3X3G6gNhqgiS1BQ--.19129S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7Zr47tFy3XryxGry8Xwb_yoW3Crg_ur
	Z5AFW5Jw48JF48A3y3Gr1FkrZ3JF4ak34UXryjqF1fXFy2qFy5Xrs5u39aq3W8uFWxAw1v
	9r90qFWUK3sF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_CD7PUUUUU==
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC8x8gd2rYgL-MZAAA3e

On Thu, Jul 09, 2026 at 08:03:50AM +0200, Manivannan Sadhasivam wrote:
> Inaccessible means, config space reads should show '0xff' for all
> registers, not '0x7f'.

Sorry for the late reply. You are right: 0x7f is not a disconnected
device. My wording was incorrect.

> You really need to find out the cause of this issue. 'no_m3' flag
> indicates that M3 state is not supported by the device. Is that
> really the case here? Or the PCIe port or the device itself doesn't
> support D3Hot properly?

M3 is supported by the device, so no_m3 is the wrong flag. That change
was already dropped in v4 and will not return in v6.

The runtime resume SYS ERROR on some HP/Lenovo platforms looks like a
PCIe/platform issue. I will follow that up separately from the
device-ID series.

Thanks,
Wanquan Zhong

