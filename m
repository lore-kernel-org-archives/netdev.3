Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465956;
	b=5jG6ZyWz84qYKZ1hINIrbvBGgNChLJVCsCuGq9/WRV6sSEm8SN1HSMfSUJNVGnovODME
	 DUb/ts5eL0CcD2DbiUQIzspOWX/xmtuk2FFPz47eqnTd7n/4tpS9eUqs1SduXfVSrd6Zx
	 t15pdx+2M2rwzfws2IjKNbMBJNGEa0nkEBAm/c2i29cOQ/fmh2+Qnra2oBpdA+3dSC02M
	 LhHIUotayh8HqCKtoft0A5jLtu7HOkDL4S19cmeUyFdI3EgiykVPJ24CGlbkACgVWVNTi
	 PVWE5+MjapqpaM3nPsXUZumHlZAhSQcnJ8wk7BIhd8QRA42AYvdX39bytF4Cm/gG/NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465956;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Sqhd3FDWl4wvOvSokFvOzJ4CoizI/Sgzl06N+nN1mvQ=;
	b=tlf68AD3F6HCVdNQMBt8oyszWOFhBID3wSEwifJBk5YVaHZsJXocqHCtDUkSFhBGekU3
	 yJJxXUg6QTl1qTiAGYoVCqoiKf+SBkgv2LyzxneYjUsVWu4WwYiejeHXEjXvgl0BwVUtk
	 7aQXcDHtNwf3krCUMaYrPb97MRA2TJBPQv4byNpcaMOpFEScnEtCViGM9wvq+eGYbYENr
	 4Nt25Q7zF3Rjat4SuH0QIEkZ1iOojz48PFvO3chnTZbWo+r0oP7QRmjs7n4C2j3vZtfSf
	 FgMFz8tV4ukzAy4o3L1QShk7xRl3s+Us1f5lloNuAH9ds7DytjJ9kRLk2CT9eeaSU8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AnWQLGWg;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0A606A319;
	Tue, 20 Oct 2026 03:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC0A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AnWQLGWg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sq
	hd3FDWl4wvOvSokFvOzJ4CoizI/Sgzl06N+nN1mvQ=; b=AnWQLGWgJMsaFqyCTR
	LmZzFXeHMuttbZb5kQdZ4nY1gwMmCriMPCQdLC6XjlImthOjLnJdB9oXqlDJnOQh
	HeFaPqykktCJQgDOJbDmkaX8knjAtL3dpiAiNGT7Em4iU2vNOf06nt09M10z9YUe
	VRF6QnT0PEWTtnu9D2dUHekuo=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCH74T929ZqGrapAw--.47312S2;
	Tue, 20 Oct 2026 11:11:59 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: netdev-bot+sinfo@kernel.org
Cc: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v1] qlcnic: Protect loopback filter hashes
Date: Tue, 20 Oct 2026 11:11:57 +0800
Message-ID: <20261020031157.520515-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020024417.517941-1-18983559317@163.com>
References: <20261020024417.517941-1-18983559317@163.com>
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
X-CM-TRANSID:PygvCgCH74T929ZqGrapAw--.47312S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUODGYDUUUU
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+x+GamrW2--qfQAA3H

Due to a lack of specific hardware, this change has not been tested on
actual hardware. But in my opinion, this fix is necessary.

