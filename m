Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637769;
	b=uS+lAem8/TCBexoDosqVRpsci8Lxx7J4JsRNTLcgI89DJzPvEJ3ETccf8dcs4G+i063t
	 xhyfmcmcS7cWqdp7B3vWRlpW26Yfm1jTjlRRfcAw3KUd1pxkQXhNZVVPrUa3hyXptGBFN
	 7XejcnJnkee8e0FhwZBSwIpyto2XbPMGugYg+hHeBSFPKGJj86wQPj9ftjgYd45V4NW1B
	 o+CN7AWzH3x4Tnj8zspQ3AQrbQ6XNUgAbBXoONGwC1KVRf7SNsD+vKqWxikybxNMWRUHC
	 o/2xx9J6mRsN1koMbx+POuJC3jYY2Fu69vDLIzufTq2Smxh8hiEPh5u7ACrn5HSkT8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637769;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=G+L/X+01awRD9Zn2yY6uBHk6IdsLy18VMtH+UzQPMt8=;
	b=erIHwea8FzywElguWYZu8bP1n5iZYtktJ/G6y+naa+LEAkEx2HvpUAHCEmDijMXo2yD0
	 rpuIWUYDGJk1PiPQuicQR+LNkdpSJgSrxFTs6tSK0yuXcL/qTQJ3+jaJghaOEzsmoXnjp
	 FFgrBPWng6cMpGkiqr3qjrH919shbjTre+QfqyXaQxlC0t5/ztTz/xdomdWmKU9zdbPUZ
	 gW5PIU8CudP/Pq0hL7Va+YrkQIkxU5lR08mmXfpl+B1RLE6pTuD9dMwZvCMMg/AXDVV6t
	 0u14LnyEGpRV6q6RLFG1sI3RAYooNQFDqD8N0l1xtsJul40OdH8PvIw14Fcqyp3qFFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D2606CEC1;
	Mon,  2 Nov 2026 16:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01D2606CEC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=G+L/X+01awRD9Zn2yY6uBHk6IdsLy18VMt
	H+UzQPMt8=; b=FvP3G3nM/YWyb0CUQXAe97VL/z9A23ipl1JBs6K5+zZN5CeHCF
	PtmlTckYMOhzONXNQMgsW8Cks+BBZs0KyikuQnH4QYIcUA7hmJuugmv8mtpVCxt5
	FGaE3naehzaYJrM8H0isweH23zus7NLMRwOdjbWYXmN+qlOmdIfQXRFP0=
Received: from [169.254.33.71] (unknown [223.160.172.231])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDmKwFwvehqzpoaAQ--.55852S2;
	Tue, 03 Nov 2026 00:42:27 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the network
 device is running
Date: Mon, 02 Nov 2026 16:42:25 -0000
Message-ID: <179363774572.24580.9072793556383429188@stu.xidian.edu.cn>
In-Reply-To: <auiu2voApMN42KV4@pengutronix.de>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
 <auiu2voApMN42KV4@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:BLQMCkDmKwFwvehqzpoaAQ--.55852S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fGrWDZF43ZryrAF18Krg_yoW8XF1Upa
	y3KFsrGF4kJry2v34xZw47ua48Wrs3Jay3ur15G3yrZws09Fy7ZrW8KrWUZFnrCrsavF4f
	tw13uay0934kC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxiiSUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rop1UQnwAAsx

Oleksij,

Thanks for the testing, and for both tags.

One thing to sort out first: they arrived on the v1 posting, and the patch
changed shape in v2, which I posted separately on 2026-10-31:

  https://lore.kernel.org/netdev/20261031165213.2738-1-25031212351@stu.xidian=
.edu.cn/

v2 drops the explicit phylink_stop() and moves unregister_netdev() ahead of
the phylink teardown instead, so that closing the netdev goes through the
normal lan78xx_stop() path. That removes the netif_running() test; and the
three cases you reproduced -- never opened, after ifdown, and ifup/ifdown
during removal -- are all cases where the interface is not running at that
point, so v2 does not call phylink_stop() there either, same as v1.

The path that does differ is a removal with the interface up: v1 stopped
phylink directly from lan78xx_disconnect(), v2 gets it from lan78xx_stop()
via unregister_netdev(). Your "interface open, sending, link up, link down,
link flapping" runs cover that path in its v1 form only. If you want to
re-run them against v2 before the tags stand on it, that would be welcome;
otherwise I will take your Tested-by and Reviewed-by as applying to v2 as
posted -- tell me which you prefer.

It is also the approach 312c816c6bc3 took for the NAPI teardown, so the
shape is not new to this driver.

Thanks for checking the pre-phylink kernels too -- that is the direct
confirmation of the Fixes: tag Andrew asked about, so I think that question
is settled.

Thanks,
YuanZhe

