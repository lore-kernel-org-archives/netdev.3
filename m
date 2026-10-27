Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084493;
	b=wKWaoprAL+BneYwAB0I3+ksMUsS6OGqyhV08oscBR8I2uLbT0NeaZXzfcGffJL+bTP3R
	 0qTJa5RNIRhWvK7p85RXhnLHic81n4dj6/aMYPJLWMQxx9roCDougg2IH/xLn952zg798
	 Ge1nl72inidnxrdZxwDTj8+i4Q8fnkpRXQjnsY4unLUMDw27XTSo41c940U2bixRsY+pc
	 ccUOih88YdOzL3xOlFFR4mLcuwS/r+B78wiNJP0DSL/bj0ns9l8XQItu/WVYuUL/i8jP8
	 wCm5Eu1LJ9wmYBJUiJWfFQSamDRqxWXK9j1eOEveuUohi0z+P2vyOT71UaOiTybKrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084493;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FoWr44Vn/C7ivItg3DiiaJ3pvEZvJG83mHBFKxHkyjQ=;
	b=UiaH1dGa1iLbKRFezh1AmYqNjvPz61vdE8uERaacdZwygbdCj2jEEToupu15+9uQwp2l
	 sHeevRx1j7RDBETPdoAvNS/Et9feWqNFgFzNmJPSohv4AnMJLKkKdmV8sQsXintzm88Gu
	 BjS0n1eVyBJ50wg7cRPN8YoUUywBKhfj7ZyZoptIkc68pd+JdmwTZX4SxfFUFF2RJgTJA
	 Zn96o9gjidHZaPWs/Q9hnXiOKJCORLaqMKGQfKjI2EIjlNDbGe2V/l6Pfx6BdxL3M6pxa
	 nLyxhVYJTTGh9eiaWRuXoQr+OXqpfM1kmMm/V/ejmje1+tbTX3NB9JXk5+Pq0lz4vcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IH9quLla;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E111606A31E;
	Tue, 27 Oct 2026 07:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E111606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IH9quLla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IH9quLlaG7z1L1ZNcnqZ6KaKK2w+Ktyy/Y+v3zBL0NxOqTrQeG+vc5v6hmrs0cHPj56QbcuHKL2FY
	 9u8OvF6fkm5zx2BMxagS1wvqWNy3MQUbnCQ68/CsWgB2c0kIbFxtILNxv86W0rp7gCznxKSc2YUqfs
	 oMziEeWqNiH7kna0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae04c37d9f-21f94;
	Tue, 27 Oct 2026 15:01:17 +0800 (CST)
X-RM-TRANSID:2ee66ae04c37d9f-21f94
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae04c399bc-d0e12;
	Tue, 27 Oct 2026 15:01:16 +0800 (CST)
X-RM-TRANSID:2ee66ae04c399bc-d0e12
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Subject: Re: [PATCH] nfc: pn533: add timeout to USB frame send completion wait
Date: Tue, 27 Oct 2026 15:01:13 +0800
Message-ID: <20261027070113.1177-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com>
References: <20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com>
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

Thanks for the detailed review.  All three issues are legitimate, and
I'm respinning as v2.

[High] Confirmed against the code: pn533_wq_cmd() drops a queued
command on send failure without calling complete_cb, without clearing
cmd_pending and without rescheduling cmd_work, so a
pn533_send_cmd_sync() caller would indeed sleep forever and the queue
freezes.  v2 patch 1/2 now completes the failed command with the error
and reschedules cmd_work, so the queue drains with errors instead of
freezing.

[Medium] v2 patch 2/2 mirrors usb_start_wait_urb(): after
usb_kill_urb() it checks urb->status and proceeds normally if the
transfer completed between the timeout expiring and the kill, instead
of reporting a spurious -ETIMEDOUT.

Regarding a protocol-level ACK abort on timeout: pn533_usb_send_ack()
is a no-op on ACR122U, and after a genuine stall we cannot know how
much of the frame the device consumed, so I kept the timeout path
minimal.  The stale-response desync you describe remains possible
after a real timeout; a full device reset looks too invasive for this
fix, but I'm happy to revisit it if the maintainers prefer.

[Low] Fixes tag added with the commit you identified, and Cc: stable
on both patches.

pw-bot: cr


