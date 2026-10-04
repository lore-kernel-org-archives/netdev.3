Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71A4399EA;
	Sun,  4 Oct 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121245; cv=none; b=KHOzey59vBklzyY7TzmUq7eCetDS9NiEQ1Y5lLZZKc8d/Lw8nQ9R8JNvLYiLmfwaU0QH0LoL4Dki/iNaG1vANQ1T2kammsR5I2xCTYWnMePsW3LXGXO/TGWudzl1R0aZZEMc6RuOhfM6GOSAnIDdc04VbEvEYyHC00owuoW1fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121245; c=relaxed/simple;
	bh=NgPeSroR38S5Uj832S1g76Wduaubl9wRjHJZuorUhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WRVYJD2RFW0Xyar/kdxx2kT0IzPGBB0Tp5mZ1thaOOY2BmMeB4jEJoEmNmYEZPnlkcJSMtr6tmGcMvxAQUfJ+2Ka1oAc3l0NpbM2rXMD/HyHmApGk5PxIVTE88ebkNrlYXgWfsaZb8msUou5uMGW57IBWrrsy/pu+64UUhNo2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IrejJ1yW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IrejJ1yW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+T5UbfHJ1+eFncc06zc8gHks0unWVa89pQcF558408M=;
	b=IrejJ1yWk2eHx4dwdFifNoCbyxnh9yxTTygdHyTOor7BOud8b3XCrttucD2iH1
	aMfntjP1t2xFmQGA35q6HW94jXw0cMusug7k2jLLB32kb7KXymItUaU2tOHj3Gn/
	Q5+u9sOSzqU+djvXPzykJ3MpmGYlrQ3e/3/MOTGW1q3ag=
Received: from u2.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX35ELV8Jq3nX5CA--.2906S2;
	Sun, 04 Oct 2026 21:39:24 +0800 (CST)
From: taozj888@163.com
To: theo.lebrun@bootlin.com
Cc: taozijin <taozj888@163.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/1] brief description about the patch and its
Date: Sun,  4 Oct 2026 13:39:14 +0000
Message-Id: <20261004133916.559956-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX35ELV8Jq3nX5CA--.2906S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF43Wr1kZF4DWw4rJr4ruFg_yoW3WrbE9r
	95J34rG3yjgF1DXan5ArsrZry3JFWDtws8uF4Dtry3trySyrZ5uFyDJFy3ur40qay2yryD
	Zw1kZFyvywn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtID2UUUUUU==
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3gwk62rCVwxSfQAA3B

From: taozijin <taozj888@163.com>


This patch is titled as:
  net: macb: rate limit netdev error info print in the data path

Changes since v1:

v3: 
- add this change log since v2 missing it
- drop the blank line between the assignment sentence and the commit
  info

v2:

- update the commit message with the reason why the unlimit prints would
  bother/delay booting process
- update the commit message with the Fix commit id provided which is
  suggested by Théo Lebrun<theo.lebrun@bootlin.com>
- update the commit message with what packet type would trigger the
  error printings more easily.

v1:

- initial commit


Best Regards,

Zijin Tao
 drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1

