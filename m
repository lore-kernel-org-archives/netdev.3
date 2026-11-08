Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134418;
	b=ZPaywBPd/g4gWC9tzkBbZLnmFHxv8wOnOFil0mRrIlaEBcukcnLFWxLVOpMXCUKBUToT
	 r5Iq6gkqvYSjd38afUG+aFMQVjk/8l6zQN5X346/UzZc2WRUSM75VDPggVZMbIySUdkS0
	 cLNbvEnXdio/UXpsm1F5+WvaUGmhZN+tW+h5JotaXxZnTpmsxv4GMboy21ItXQMLpE61O
	 tDMNRcS4sh5ern0mwKRwL7gRkBkfavH5YWiKA6gxTq6dHyvZ23na8PkI6jBd6u+a7fkqA
	 JFmUGWjxDtTEYJLrBCyouEa1ICi9+YIwabi2bKQAe+uEeenkQzaQ2/p/foqgDuZDQHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134418;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=KCWFTyxsO2oXRIWR/uErpcygqVWYIb4tVbxQuCZPJVY=;
	b=D5WK0kVaXtpoaIJftGnvV75IpwsqnZ9FmarCk0ZwX/320uc15fc21Zq2dZY/2OHzqLOq
	 VvSWaQT5FB5wWluCfj/n46zvR0bVNYKsztiOKwb9TBEkNOOcSkDTkFcKPDhTVZukIk4w/
	 TQ4FS45Q2pUcWj/jT6Gt4PomsFZkF4VyJT1cFIf6bZT2+h7H7WbLLAA33DXevcYfrmpze
	 5ZMqJal8X4Pv5mUDyokWjmXUO2YP+BrudSrLwpSl0YJcUi94P4rIRKSVuKspzeBVpDo2A
	 BbpH+9KZwzPpvhzbL4VVM9zGilhTBc7m/CWnefy32mUmxhiKMUIudEll+ibWHrulaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F58606A320;
	Sun,  8 Nov 2026 10:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F58606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABX8reHUfBqA6eZAA--.38380S2;
	Sun, 08 Nov 2026 18:40:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Elder <elder@ieee.org>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 elder@kernel.org,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 vulab@iscas.ac.cn
Subject: Re: [PATCH] net: ipa: Fix runtime PM reference leak in ipa_remove()
Date: Sun, 08 Nov 2026 10:25:00 +0000
Message-ID: <20261108102500.3182111-1-vulab@iscas.ac.cn>
In-Reply-To: <7509f005-709d-46d5-8554-b9d2fd0cd218@ieee.org>
References: <20260917115115.2149796-1-vulab@iscas.ac.cn>
 <7509f005-709d-46d5-8554-b9d2fd0cd218@ieee.org>
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
X-CM-TRANSID:zQCowABX8reHUfBqA6eZAA--.38380S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1DJFy8Jr1DZF4UZw1xAFb_yoW8Jw1fpF
	Z3Kan8KrnxKrn2yws7Aa1IqaySvrZYyr45GFykGa40yw15XFy7trWYgF1j9a13Cr4rXrZr
	tr4Y93Z3J3ykJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU8nNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggFA2rv4zKpNAADsC

Hi Alex,

Sorry for the very late reply, and for the noise.

You are right that this is already fixed, and I should have caught it
before posting.  6b9eaa61ff2df ("net: ipa: balance runtime PM reference on
remove error") makes the same change, and it has been in mainline since
v7.3-rc1.  I rechecked ipa_remove() in the current tree, and that error
path now releases the reference:

			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
				ERR_PTR(ret));
			pm_runtime_put_noidle(dev);
			return;

so the usage count is balanced there and there is nothing left to fix.
The patch needs no v2; please disregard it.  The patchwork entry already
shows as not applicable.

You asked how I found the problem.  The candidate came from our static
analysis tooling, which flagged the missing put on that error path.  I
then used DeepSeek and GPT-6.1 Sol to audit the finding and to help write
the change, and I reviewed the result myself before sending it.

What I got wrong is that the diff was prepared from an old snapshot
(v7.1-rc4 based) and I did not check the current tree before posting, so
I missed that the fix had already landed.  That is on me, and I am sorry
for the review time it cost you.

I am going through the outstanding feedback on my patches by hand now,
thread by thread, and will answer each one.

Thanks,
Wentao

