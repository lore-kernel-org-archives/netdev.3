Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689557C738;
	Wed, 23 Sep 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194534; cv=none; b=Q8h3wGE/x6yWc6qOHS4dUzWBERUv4za7M9ds0TMIE+qwh0kvH/gxz3JNsp6WwkJIhgOr9FaFnfrlHAZqfjne/SzFATIVdPHuB0z6rd02d98L6zJgiDuJ5I8AKI2jijcMd03mE9rekAsaoFRU/5bTSUC38y/IJJIaPzebDQr691k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194534; c=relaxed/simple;
	bh=t/HzhcMzscV9FJZ9xxyrj2bUX5vOHJ4hJ5usiwT+VpQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qT0SNFUGy1yqGb/YLByKWJ5MZVpgTQngE78J2DrnN+tFzF+sCNJ/GXm50AC/nCuN7Ft0wUDRKq3AeUdDotWHRUNNNOWqQewWxCoK0yzjfQ7cTViaFSAaxVYluSA6xx4sLy8lDfbyhQ44fp0GF9xUP3jF0xpoASDEp1iKqg7w4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.46.39) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 23 Sep
 2026 23:15:09 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 0/2] ch9200: stop ignoring the register write errors
Date: Wed, 23 Sep 2026 23:14:37 +0300
Message-ID: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

The successful register writes, done via the USB control requests, seem
vital for the normal functioning of the device, however the driver tends
to completely ignore the register write errors, even though it could well
propagate the errors from its bind() method.  Additionally, it masks any
USB errors returned by usb_control_msg(), pretending that the call was
successful. Let's stop doing all that and see how it goes... :-)

Sergey Shtylyov (2):
  ch9200: return error on failed register writes in ch9200_bind()
  ch9200: do return USB errors from control_write()

 drivers/net/usb/ch9200.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.55.0
