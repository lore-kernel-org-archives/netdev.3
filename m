Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278337;
	b=HHQV936YDavAz5l5pfR3RgD9r4qKbUPY9N5YJoCsQJkZ8wrQH/7BM5SFtIlqMkExxZ47
	 1XpX0OUixNkIFics7sGeC6NJAJvkxpPl9xQw/swf8KEoy0dD6N4r9lPod0ckupn9CG2HX
	 A0f0/WfuB5xuuAaan8o6I5vn/08nMCezb2EwllSRdi3U7Ne1XxKNKh8XaW7LGh1ZibKIQ
	 YcO5oHaAQgyGV4y1R6fAVFfQSUgNfOCri1RfBXodQzvby/pwWMJGSZcCFQIWgyNNSAHHB
	 WFRR/YMXHaNnO+G7/XdgjWl8YqbHuaN0nIL/dcmEn8hGauH4Csl7o3DTSWH/l7FV9EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278337;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bDtILV99THZP4Ptw4aE3mDtOcJSMnQXEODVTmpcW9Nk=;
	b=MLaI/eb11WZNtb1Fecc28MjJGLxsHZb1xJbTyOOpU09EHV6BbRIANNDp+w4O5PuT9Q4U
	 CvzjHJzYE4WL9C/df9MROpm0zCcNj5Ymp4Q/5Jov9/M0BVdlQkZmZHowmvGeO8RqdEf0u
	 f4j7RwCl7jWfB26jJlEZBr/7pbdrv0hKpz9li+zMb4me69IkxTii+R8rlz8Q1T1NSO7h7
	 6gTGWPZZeH98ynX1BUDnO8z+10sHqQ6KAEovza9a52uVS0p8jN9GfMmIhwclEmAomB6Sa
	 4sy0Em13hoZE8hMnmr+t7227xoxhVmMpUFlOyegYuW/sKPNT4NSGTarmwf0CbRCHZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jORdYAtT;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AE60A2610;
	Tue, 10 Nov 2026 02:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1AE60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jORdYAtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jORdYAtT+f+bd+o7EXeeJbohiIM42LB52YWbvvzRv9+q0NveaINzb0ODH2Puei5G/zi3vtLcgqlwx
	 rlU0i97e/esfIY+S2RZ4D0V9X9lQBBE4D9PM1q0SaFGRYWAnbwWBWbW0YvuR6SfKd5j+fYqLnTPqzL
	 ZN0Dfa95aR2gDE7A=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af283b05e1-96172;
	Tue, 10 Nov 2026 10:38:47 +0800 (CST)
X-RM-TRANSID:2ee66af283b05e1-96172
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af283b5717-a33b1;
	Tue, 10 Nov 2026 10:38:46 +0800 (CST)
X-RM-TRANSID:2ee86af283b5717-a33b1
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Simon Horman <horms@kernel.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Haokexin <haokexin@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth-sr1: Fix device_node refcount leak in prueth_probe()
Date: Tue, 10 Nov 2026 10:38:44 +0800
Message-ID: <20261110103500.3142-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261109170036.GT18859@horms.kernel.org>
References: <20261109170036.GT18859@horms.kernel.org>
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

Hi Simon,

Thanks for the feedback.

The SR1.0 driver shares the same port scan loop and the same checks
that follow it, so the same analysis applies: the
eth0_node == eth1_node comparison is dead code for the same reason,
the uninitialised reg value is used when of_property_read_u32()
fails, and the loop can leak references both on duplicate reg
values and on out-of-range ones.

I will fold this fix into the same v2 series as the icssg-prueth
fix, as you suggested, and the port scan loop clean-up will cover
both drivers too.

Best regards,
Xiangwu Lai


