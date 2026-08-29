Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C3346FAE
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999021; cv=none; b=qHWn7cVxnVhPYeJ3amiPlaEv0oXyjl9NLF9BqXfGLR6YyCh9WLB9pLuxHLXl0BwtCyWeI3bg/bEt/TJdomvLmBVtufAObRS4BwixI11dADtxaR8qPr1UZqrA/d+bzRkbBS2kruqF9gSLfGTlvqVo/7Pel9LbPKaFzGF4Ym/i688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999021; c=relaxed/simple;
	bh=sDC0HmFo76Iy3rvXEpuC5VSYCGQLKOYblHtCiH1t8bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ5BuwIWagC5mqpOnxpM8XRFXyjuHGDPT0Bo+T0j5C/SA+F8C9bOg8y+GHigy92FSEQyO57WW5a6u7BD0/LnJMSHf8r4GBfbfXg3kr7sF1pzaGQ0dRkezV6VfSv+qamUtVUKd8k/xvmy9vMmNJlvE3N8D+rL0R6JP2+LnGNNyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DGYkApae; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DGYkApae"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d712281f8bso21655785ad.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787999020; x=1788603820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TipxU31zFnpolw1J+4rCh41D6Ze6WOhL1E995FT0jys=;
        b=DGYkApaemnhfluKbmke6+1HuxzwhztJXrtRCsL+rKuviTU2SsTQNuNaQyRu5aM1b36
         bSSLcuv7k/A2/VUARPMg8f/i/G79KZh/YK6pJlbd/rd2QlGTMCiuJmn8793Wm7tpjsP+
         Wfz337hoIQ0Sui8s1xNYn9+gqMYPS/2KAqI7ZS/eoBlQ3sYiOBMA8JugqFl0FFvs+NC+
         pnAh0vbLZKK8PfHVQmYnynltSo5BLqWr+PC0x6ZfhagS0zbT80QI4POuwDncQYd9QWsN
         s0AEe6HkdC71S/Ej583yCjw5AArVTiZbMP+g4i9h0Eq2ePtjo4z/2/4iGZvomk1ZDD9a
         y1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787999020; x=1788603820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TipxU31zFnpolw1J+4rCh41D6Ze6WOhL1E995FT0jys=;
        b=lqrZDNs++AP96diVHJ2n9iGuZdx7STkKP4QHv3MvuKXvL34S+CiIQCRxso03utEdSx
         TNptC7eIEisQs7C8kwp1tbsP4KZlOJlqlZeKPXH6JU4SsnRL16OmI9NqwC7lgeR1ML63
         QYbZSD/tl/RrFeb8+XgKGzyzmJN3eGwQkoGvA9DLSwWcH4kOPWKCEBeKbwpicpFYKkC5
         iqPBcRD3hp3O3itoyT3iiP5sfxBXaBPj69dfrtdbh6D1e4BAtduWYFOmBkQ5xAfsWWcH
         ogB00MRmjs9nTzxxGc+bkhaujlQwvJ8+EReZJK2hPyc+vXBmp0MvoGgxXcMxV3n8XUeu
         umcw==
X-Gm-Message-State: AFuF++liTD3ai+b8Ke5kr6XxIGzxrXgaxALWcitjdoQDphITf+RmQOeL
	mD7MuNJ2rnubjTQXDjcs4ZV+//mOb3/XvMpUFRWpj60a1FB4EsJ6Cx78pBG1iSwLvb5wz1Ce87+
	rbHmIeRwB
X-Gm-Gg: AYBFou0hiysQPAo72MtH0UrSkugado60DPaLJItuzWQAPw7MqlQ7/ZdCLn0VhUji59Z
	1MSsgrqcCb3UsiiQ4t81uFKzpHwghx+ul+3w4NsSIDvvvWprB5CBes3cFaLG6dgGmXeOzMJ51ET
	475F1bO+XUGZnz9ZnrRcwd0WZKTFpt9Mk0JL+GojOZPMOKzpcu57YirhXHPMNZQUFA5Fl5pD0s8
	+h1A8C1NXckFdkmlAcZP8HAhRBLwcuCObuSvw24k5fQvII3mb1z6ilr0M84xam4CxGDCSlKaxYN
	pWFC3pnbqOSTvq+kgl+y8Gebrc9/7O+ReUO31O47586goAGeRS7cqiFIuacUwE5bw0fPNmnqScy
	VJOLJ0+TwDdjtJcNxSZITAJYDDtoMLXfbcz/ZtUewWbfFN/szuuGg47PwwxCRgOmN0Gwq3OS4Up
	gVsE4cYUhmnP7kWS8iGOPD/CbFOpl4ULlslhZcM+qBkYnDnEejl356rGhMQcPDeU1zGwld
X-Received: by 2002:a17:902:e549:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d74df5f87cmr202927005ad.14.1787999019553;
        Sat, 29 Aug 2026 03:23:39 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm13858193eec.15.2026.08.29.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 03:23:39 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	phil@philpotter.co.uk,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] net: tun: reject addr_len changes with active lists
Date: Sat, 29 Aug 2026 18:23:23 +0800
Message-ID: <07d1a274b5144fe2ad8e30a6d3d25a5b8ea88fa7.1787998545.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787998545.git.zhilinz@nebusec.ai>
References: <cover.1787998545.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TUNSETLINK can change a TAP device's address length while packet
memberships are active. The address lists are keyed by the current
address length, so changing it makes subsequent membership cleanup
lookups fail and strands netdev_hw_addr entries until unregister.

Reject link-type changes that alter addr_len while either the unicast or
multicast address list is non-empty. This prevents address entries from
becoming unreachable through the normal deletion path.

Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 drivers/net/tun.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68aa..e5b7729a967de 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3341,6 +3341,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 			netif_info(tun, drv, tun->dev,
 				   "Linktype set failed because interface is up\n");
 			ret = -EBUSY;
+		} else if (tun_get_addr_len(arg) != tun->dev->addr_len &&
+			   (!netdev_uc_empty(tun->dev) ||
+			    !netdev_mc_empty(tun->dev))) {
+			ret = -EBUSY;
 		} else {
 			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
 						       tun->dev);
-- 
2.43.0

