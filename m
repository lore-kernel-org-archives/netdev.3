Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF22353EEB;
	Tue, 29 Sep 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667457; cv=none; b=KPpqgkkQ6r4iVSqHGBAJTN0sRfDMIVp6dQyHmgxy+juUIpH2zh7QwLMyuqCWdfFZJpWt8QKw/zOG9S/4Y2DjAly7w96g1To10eVuI7VtKgD1P9F7sSEspaRWRWh/pIuQCvw0fUh0We3tExUChXY44g5EnzR4ShnTlu6C3zt2bos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667457; c=relaxed/simple;
	bh=gb7R/N7K8gCcMGFUWCwn+BiCBHM21fe0W7MgkwSXdwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqiQV0dzRsXYkQUi2UJaTZiJrYOAhe4rHD8TWroWl0J14lXUwps9qmsdFIoQc9o+mgK1i0ALTqh+0ZT2FyPuWH5VLtrdlYUPfOmyIjyvbIfA7KxaxIPyl8Z07FvSdiZTUoifMWOSOLsqT8wrKOPM04MVOU1Ad+KDI+ZCjn8qL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CtZzmzrO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CtZzmzrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8q
	16KiQcHbMAGIdFnDq/h8ps6GG0maK7Jsk5o0N8IW4=; b=CtZzmzrO2xnQDhbDVP
	/fIroVAT0CanIw++DH8t3o0rrcUTcwvRm7PF9M4y6jnLxi9v9ZlPk9WOR7MwwqIu
	6GCmBt3ypsAFFodJn4qMmHiyL5g5JPaPptMumtm6xU9whiXyB8L4MsvwRQX0MswO
	Edns6AyLpJz7KwhNzb0Lk9Q7M=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3lyyRartqogPaBQ--.50073S2;
	Tue, 29 Sep 2026 15:36:50 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Quchaosheng <quchaosheng000406@163.com>
Subject: Re: [PATCH v3 net] net/packet: guard the ll header push in packet_rcv_spkt()
Date: Tue, 29 Sep 2026 15:36:48 +0800
Message-ID: <20260929073648.2748099-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <willemdebruijn.kernel.2d23ff6855a34@gmail.com>
References: <willemdebruijn.kernel.2d23ff6855a34@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lyyRartqogPaBQ--.50073S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRKuWlUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xJIvWq7apJcOQAA3I

Agreed, this is not a fix for that change.  init_can_skb() is being fixed
separately -- zjamg's patch, now 05/22 in Marc's tree.

packet_rcv_spkt() is the only ll header restore that d549699048b4 left
without a dev_has_header() check, and SOCK_PACKET reaches it.  That is all
this patch is.

Nothing else queued for net.  I'll keep the 24 hours.

Thanks,
Quchaosheng

