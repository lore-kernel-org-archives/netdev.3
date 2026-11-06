Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954917;
	b=piipVJossyNFLwQCyVjEbnGmXLaUP5/jvxqPfSUmGzG4hwUC8VRYyH1JinOzt33M9buQ
	 l2JguNTypkx8HD3WY4v58x4bO+pdCUy4STK/FXVfn4Wl0DPW/4nrRrV+0G6tI8e8OtZVy
	 TqwGCldTwvGYLVRsA8CA5ddtT+r7MG0+0O9rPsy0jAb0odMDYW5OmpGgwoaztoqh1Sxf4
	 LsbLZoW2qMZClX82uJcIMU3T7fxZesOTD/ZxTGpeLq+PdDfGmNICT4huysNZ5Twv3NaSP
	 ED3OlHwAMxQwzAdWkYkW/2JWQ3rZH6HlB4A9/AE0jaHkT+bIqgd7BUYu0heTv54d3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954917;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aLGbaNHkUtTFgo7SYRpl/SmqYN5mxNTgYqz9elwLiSs=;
	b=5toBmh+Pa/CAasSzkYkht1l1ylYXZZJpwb8WOxbw7skvIJj4ZZ9/5K4xOjoYQQUUSB8y
	 KfWiFxDRx4PTJQ6QaOAeTOauQIuz7lJZ4WrTJAhkSyQ+iJbpifvOwA15UthqShCXzSKhu
	 k7EAsvOjXu5SPIIINLQ8eSWIFLXvBMbIgjQOLf9hP7mjOSx1WWrRw3Jnwd9lmQjj2D2Gl
	 gZXsskO+iHMGJO7yvBGEOUfI4bClaBPUkVikMtFZvELu0H1jNZLlhbFbY5W2OAo34MUPS
	 K6Ac2h3tWHx1aw+qz/MbW+hix9wsuNvCsyu+NXEtuLBWQMROxkygn2HVrxHELMYve9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vI5dTAj8;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A61606A326;
	Fri,  6 Nov 2026 08:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vI5dTAj8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vI5dTAj8R82FBpRFNkHeQJa6G84cpzhxW9VxxFmyJ0vsOuKf4DSCt48w0aNvX58aT85HiZum09Ldp
	 wltVWY165X64oVCJ/q1TbmNVkQPCkWucuEJQIF++kZwn2tmChLUk02ZjrTyw2gEE4wVAPRF5+Bv93v
	 sfHPBzr0Nv6a5Amw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aed946166a-8b881;
	Fri, 06 Nov 2026 16:48:33 +0800 (CST)
X-RM-TRANSID:2ee16aed946166a-8b881
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [192.168.229.154] (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86aed945f73f-19923;
	Fri, 06 Nov 2026 16:48:33 +0800 (CST)
X-RM-TRANSID:2ee86aed945f73f-19923
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, linux-kernel@vger.kernel.org,
 yana06070@163.com
Subject: [PATCH net-next] net: dsa: hellcreek: fix device_node leak in
 hellcreek_led_setup()
Date: Fri, 06 Nov 2026 16:48:32 +0800
Message-ID: <1793954912000.3200.3087525628285919529@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hellcreek_led_setup() walks the two LED child nodes of the "leds" node
with of_get_next_available_child(). The helper drops the reference on
the child passed to it and takes one on the child it returns. After
the second call the caller holds a reference on the second LED node.

That reference is never dropped. The out: label only releases the
"leds" node itself. Boards with both LED child nodes leak one
device_node reference per probe, on the registration failures as well
as on the success path.

Drop it at the out: label, before the parent node. The early exits,
where the walk stopped before the second child, pass NULL, which
of_node_put() ignores.

Found during a code review of the OF node handling in DSA drivers.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
  drivers/net/dsa/hirschmann/hellcreek_ptp.c | 1 +
  1 file changed, 1 insertion(+)
diff --git a/drivers/net/dsa/hirschmann/hellcreek_ptp.c b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
index cb23bea9c21b..ed27731d4f4e 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_ptp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
@@ -392,6 +392,7 @@ static int hellcreek_led_setup(struct hellcreek *hellcreek)
 	ret = 0;
 
 out:
+	of_node_put(led);
 	of_node_put(leds);
 
 	return ret;


