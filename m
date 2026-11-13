Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566169;
	b=bSELdThuF2uw/tqC9i393jbkG0H36t5vpGKRKMU7rv43s5iXkgkpY3GFM2sGZIW5rdF1
	 nQBZ+VE/yMvhQ9pFH8CcDVoE/vNNE3gt+HLJJKrwBygQYw3nvwNE2Boj6K6aermrRkLeA
	 HTvoAph/crG04Ug1ZaPaXN5aQDrjDKpNdx4fGoFyBnAfJbwHiCmWR3S/HRd3+sM1Yl3On
	 TMjd7Wid7HIeUxzDmE7nEmaThG0dF8E7h0qPn8L/+rFqhaT8Rs7DuWND5JgEL7qkREQ0+
	 zpAYbMjRrfcKqYAp3kvMFQzB2wl9AEW5oBQrg3JA34Td1gWPKNmtor6uoLxJz3x33dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566169;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OcFZyRCHxUEqKuCrnuLVw2WXrhaiDJIvI4rfzQ4KjKc=;
	b=NawfCkIiiNPer41pBHvPbI67DyjYqYwPl6IVrWJbrqi9hm0YDdJVgvv1JQj1ZCBxEZxK
	 lgr9CUkhZCXxbP90stjv7ad5QqA23itOMB8I2JDHHEq0rRYnJny0hi5ecgdQ5BAJJ8HTd
	 GXK2EUu7Mgn7KlQ8sSGQtqWJ+igwgbF/CMRrdNfiuIdHc0/20MuLvqchOisxkBi9EkyhV
	 IQNAo14cmFWASTM8TSrgtdxRDBefZeB+jDPc3iLEzYkbjWlpV/1Mwg8iMvuv9TkLD1SyS
	 T+1OlVMx6ADlERH0lLybb0EudWf+9/pasFUC0y/6AQKXy0Y/qNpnPPPM8f137zykR3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HJwlG4E6;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E35606A31C;
	Fri, 13 Nov 2026 10:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HJwlG4E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HJwlG4E6ji6KSkhh4JKiIOCaRWGBtJcpqhwqKAcv4PCJsaehOFwpxuooyjSoTdO7UxxCOvAm+nDfj
	 GoYugtdxOYXXa++ONB7dz5pzQ36/+cBF5E51GLr1rskfbFUrPMaht1GyEhS3o7N3eczj7I0PUG0qYN
	 Eos+Vwk5qBP6mILc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af6e814b41-8bb8c;
	Fri, 13 Nov 2026 18:36:04 +0800 (CST)
X-RM-TRANSID:2ee46af6e814b41-8bb8c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af6e812fdf-22a01;
	Fri, 13 Nov 2026 18:36:04 +0800 (CST)
X-RM-TRANSID:2ee26af6e812fdf-22a01
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	jan.kiszka@siemens.com,
	diogo.ivo@siemens.com,
	haokexin@gmail.com,
	horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/4] net: ti: icssg: Fix device_node handling in prueth_probe()
Date: Fri, 13 Nov 2026 18:36:01 +0800
Message-ID: <20261113175000.3150-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261112093706.55e00f17@kernel.org>
References: <20261112093706.55e00f17@kernel.org>
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

On Thu, 12 Nov 2026 09:37:06 -0800, Jakub Kicinski wrote:
> If only you read the message the bot sent you would would know that
> you're supposed to add this to the cover letter when respinning.

You are right, my apologies. The bot's message clearly says that if
the series needs another revision, the information should be included
in the commit messages then. Since I was respinning this series
anyway, that was the time to fold it into the cover letter and the
commit messages, instead of replying with links to the v1 threads and
leaving reviewers to chase the information across postings.

Thank you for applying the series, and for the fixups in the applied
commits. The added note "untested fix to unlikely driver error path"
matches reality: the series was not tested on real hardware, and the
affected error paths are only reachable with a malformed device tree.
Thanks also for correcting the Signed-off-by name.

I will include this information in the commit messages directly in
future fix series.

Best regards,
Xiangwu Lai


