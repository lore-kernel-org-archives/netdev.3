Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76264B1CE9
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637899; cv=none; b=FJvmU084IyTI6ed0z1wZluaHB1fywo6mMaG9W36Eyykul/4Ymqu8ZPAXArhkxytiwQydsqNs6Lk5REWZJmIPaxzkc+/IlXO01Xw82KGXnq/hrIomaUrqxsTBZhPvsah98uUFQL2GK3n+n6KFhqvpfclrw9HU4tYt/5/W2qhRAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637899; c=relaxed/simple;
	bh=9BoQp32VbL34HyAkXTK0D8OJoPnHLTKddV+GK399Tes=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=LJgqLajFJGDJ82+vE02xITNhvUT5fURW+kfaP1O4vI/DmtjOMmBiqnXJga/CIKjya2Zgi8DwsD25oA8jToKnWIxHFWut1WnlThXPQuoJuVNLtHP8+hZ9hbCFIH3tKLHe/4fLIubkPkTcx3A5rxEpWLwDbirJ4r95A52PR8UaryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lWc/V9YL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lWc/V9YL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8CBA11A0923;
	Thu, 17 Sep 2026 09:38:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 600165FAA3;
	Thu, 17 Sep 2026 09:38:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCA4E11C7B06C;
	Thu, 17 Sep 2026 11:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789637881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9BoQp32VbL34HyAkXTK0D8OJoPnHLTKddV+GK399Tes=;
	b=lWc/V9YL0jaLL0SCRUX02HUb+kIVcyWPnrvt7wjbMK/XJL1PB0OpTJItE7qzs6tLZR+pA5
	LPIEt9SlHpjGCZkUBgW5i2sz8idZY8aadPgrsfUtaZyxli3SuwExejGpNjY3RxfXgvvQZq
	LMZfoFowPEzfGwjXnjTtfmSWA/PxZL+w4EszJzgnUaOy+dTBdf/xJcSueXi5aqh4RFcsCL
	mjywjOzxFoj+Tygp7bI1GEj2LOhDu+tRD5EMfeJRIVWApxX5T/MPvBAjISVOKWEdSlNK+w
	TUb0DvpWqBfrbcm5g+2NoKVqHDqSqUhdCW34CVcuy7sByERfF+mbSpJlS4y+eQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 11:37:58 +0200
Message-Id: <DLHHOJDRLN10.1EE7MLXHW9A22@bootlin.com>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 1/4] net: macb: Rename MACB_CAPS_QBV to
 MACB_CAPS_TC
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-2-vineeth.karumanchi@amd.com>
In-Reply-To: <20260909142056.1433875-2-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Wed Sep 9, 2026 at 4:20 PM CEST, Vineeth Karumanchi wrote:
> The MACB_CAPS_QBV capability flag was originally introduced to
> gate TAPRIO/QBV support. However, GEM IP versions that support
> QBV also implement multiple TSN clauses.
>
> Replace this with a generic capability flag that can be reused
> by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
> better reflect its role as a general traffic-class offload capability.
>
> The supported TSN clauses are handled through macb_setup_tc().
>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

As you pointed out in the past we cannot runtime detect because DCFG1
changes its bitfield layout across IPs... That could be useful info in
the commit message.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

