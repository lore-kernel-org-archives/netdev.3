Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55B439F8F;
	Sun,  4 Oct 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121221; cv=none; b=LnL8EuVYib5iwtHKt2xnErW7rXGXbVU6tMwkGII+La22FWKwFq8ih9CUWi7/dM6hXl9H0rm3KIVDzQoR9sCGKtAhCPFjjWTQ2fFv0fuZzDc5gzO8Mmt0ufZg4d/QFJ49xT7E1+abT29uWoMnk4MAd+lp9/Brwf44SodaYdd2SSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121221; c=relaxed/simple;
	bh=NgPeSroR38S5Uj832S1g76Wduaubl9wRjHJZuorUhVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XJIN3yzdALrmWnM5CDBV6iVkrDkcqgeGOFib8NFX86FzUMxlMRdI3Q9EBwa+7/r6z5imrP5+k5Ryt+ubkWugnuIUg7WTpHRaGfZb5tW5184iRGTgLbISClgvAW44089arcfwOWxb5Igjr0tDQAGIPa7CceRd4DmveN91+H3cgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hAnUalwO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hAnUalwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+T5UbfHJ1+eFncc06zc8gHks0unWVa89pQcF558408M=;
	b=hAnUalwOsTo4mZlw4wlKMr/n3Q7ndRUErr6ZfA4U8q4rKRE5F1Y8BBnfkI41DG
	+wxxQnmz6LL5GCWAAOsrznkT62qdj8ZcLqRtWfbOiGl3yNkZA+kdfpmsE3UOPlkN
	Js3jE2qzTKAO/ozceFBfP444rmD271xedYqdsJGuouQEc=
Received: from u2.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3QxTbVsJqY4iWCQ--.63413S2;
	Sun, 04 Oct 2026 21:38:36 +0800 (CST)
From: taozj888@163.com
To: netdev@vger.kernel.org
Cc: taozijin <taozj888@163.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 0/1] brief description about the patch and its
Date: Sun,  4 Oct 2026 13:36:51 +0000
Message-Id: <20261004133653.559775-1-taozj888@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3QxTbVsJqY4iWCQ--.63413S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF43Wr1kZF4DWw4rJr4ruFg_yoW3WrbE9r
	95J34rG3yjgF1DXan5ArsrZry3JFWDtws8uF4Dtry3trySyrZ5uFyDJFy3ur40qay2yryD
	Zw1kZFyvywn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtg4SDUUUUU==
X-CM-SenderInfo: hwdr6yqyyyqiywtou0bp/xtbC3RwY32rCVtxIowAA3P

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

