Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7E392C28;
	Sat,  3 Oct 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014965; cv=none; b=n4713LvUMN3Uoy1xA5l9HIBL3/nDmIcd4wEbVnGaDzmnBowWL+aMwcleCnv6LvQFQ/QIhurUVjSk4KxiRns0/NYtz3vFmrOwrZpHhdi/BimsaHqU0MpLWgZ7U3qOdUM+6kfcvSzOaX9YOko791gMMVztiDpkxphSyVocu5nDQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014965; c=relaxed/simple;
	bh=8x++qprszopeRwOaDKMCsHIWAF5BtQ9fEVvgpFM5zJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVf0yznOxZ/lL74qbxIPAnJ45T5KhQ+2HUqmcEOg2IGgNNlNk9xnr9azhBDmqo/RS9Fyc92urjzRUS/LQKLX8LNd/tX46NRlegjiF8fXnhxEihbH56JJbgm7a/51tXCjVkolpCXZr1Z7lH65klQCqP4GJAz/3POHtnOmpZx82gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=Uj/7FZ7G; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="Uj/7FZ7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Uj/7FZ7GrxWECPphpcg+CbgPJmvnYXfrVeN6N33mIK6O0DRPX7hmmxEoYfYueRXO6P7YsIglFjY/1
	 5FbA/0u6Z93a3++9R6YykUIN211KMAL2J60PauDeyPDPfiqeT7XGeawqMwVL9zqUjCAO7s73wpd91O
	 AwA0cgPLmodRdGes=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ac0b8253bf-98d45;
	Sat, 03 Oct 2026 16:09:13 +0800 (CST)
X-RM-TRANSID:2ee56ac0b8253bf-98d45
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.22.250.209])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ac0b817274-5dc75;
	Sat, 03 Oct 2026 16:09:13 +0800 (CST)
X-RM-TRANSID:2ee66ac0b817274-5dc75
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bareudp: Enable BIG TCP packets
Date: Fri,  2 Oct 2026 22:40:26 +0800
Message-ID: <20261002144026.454301-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <12e098d5-18b1-4b01-bd55-ccebf8a78bbc@app.fastmail.com>
References: <12e098d5-18b1-4b01-bd55-ccebf8a78bbc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 12:00:45 +0300, Alice Mikityanska wrote:
> Acked-by: Alice Mikityanska <alice.kernel@fastmail.im>
>
> Do you mind extending the big_tcp_tunnels.sh selftest to cover bareudp?

Thanks for the review. Sure, I will extend big_tcp_tunnels.sh to cover
bareudp and send it together with this patch in v2, with your Acked-by.

> Besides, enabling BIG TCP with fou would also be a one-liner, the
> basement was added in "udp: Support BIG TCP GSO packets where they
> can occur"

Thanks for the pointer. I will look into fou separately.

Thanks,
Haishuang


