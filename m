Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6381DC18F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164374; cv=none; b=Pc22pOvxeyysy8oM/UTGtwxx0Wo4UOl0XjnLlfiN0JrfRT68Y05TFiB4WOP3GzGpxBuhBiYGg8fIQCbpYlfZTYqtkNtjXI+xwdSTobxfBVdmCz3k3dxrLnfomb9msM4gBT4mEV/Lx/W8eLN8Nx4n5qO0iRrhet1yqBsOS3L704E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164374; c=relaxed/simple;
	bh=uUdC5PhnVum+cPuTw50g5vHqwpJqMr2MUJySaqdfmy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdDjeKcwOuwIuSwlu5XlvrACKs8ygVAy1i30uNTfiGHjEydX1WWWvhw+dCC3uzujAV3irCyFvITmaJKkMT++m7Pk4U3BmJmhDp2lMbGM3f2Y2UTzA7D417sKfzBtogt7WjNkxYXZMEsB6yJa9CWiCA0J5mUnOb9bjVq+wy7f1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=rYzbp1bG; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rYzbp1bG"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 7892B66A14
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:26:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c61f:0:640:7720:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 091CA60B0E;
	Thu, 17 Oct 2024 14:26:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wPLwlM6xFiE0-Ni7UdGwC;
	Thu, 17 Oct 2024 14:25:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729164359; bh=uUdC5PhnVum+cPuTw50g5vHqwpJqMr2MUJySaqdfmy8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=rYzbp1bGhjo54Pv/hlrSrRGvISg1jFRE+8/5/hi5KkhbH8ohBl0MST+aueBV0uMdC
	 hijyaint285skZEg5xmTdnz8R44Q7Yfg/0ID1g/ntChK3RnmXYPjKH2auTSdgYi+ez
	 3IOJYCCwHJmRUjBp3Aaeso5IGPuwbAWzUuhTToOk=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Pending taprio fixes
Date: Thu, 17 Oct 2024 14:25:03 +0300
Message-ID: <20241017112546.208758-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Just one more friendly reminder.

Dmitry

