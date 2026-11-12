Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479792;
	b=izoAIjRmkCcEqttswhmB8t861Kd5TosDWJRzwkaFJnaIvbi7cZQlVOi2bpvP5iJQSqGw
	 K+jaKh2fTdJt6b3TA+xA8GHplyPcLuioCTWPGkp7/U5HrDE6bzqOpSjx4KDQx1M+UnxSJ
	 It+F0jnRfsQnDYpM4mXit+x7WkQyhkXTfZXfomtrewI1L0VCN1FB5H83J3o4m6IZnzsf2
	 lxRSWu+9BuSVicJz4W4cuWtMdz0jgJ47ssyv3jzvsjV7pLxlax88oXhWs+vtB6TH9YLMC
	 cDiCUzczurxuhLG83cuzbUtsMWLGI4rRAAMH/Iz5cLbt2Vi2KBUjEw8R0yuMGvkmC3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479792;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AazEAsk7AgRZJ/1X0wf0AnTfGLKx3ePR+szUy82to1M=;
	b=mgZWHHlAqbz9mtN+WQZOcfs9lQolImKeVRBk76P3ImtcPuorQ/XQzh86T5oY87s6CxuO
	 abaA0p1EoOHRKkvvEA+LDhN3vB22lL5YsXANK3XMLkDpU5rDCZTf0JMomf/zNriX+YBWJ
	 eCeBA0UTn/gz+8By+UxmN41S8K3S6XyZsi7Dru9oK3C3WltarVm2VGWpTmoCTEux6w8bW
	 fOQqpljvrDpHYOd5TXR6/kedm6h9ZhMjAjq3RW2/yvpyJ/Gfhy3wsMA8w4eBP8PQqbwba
	 We54Wd55J1C8Ho9SQ9SZOaOl9RiqzIaWwW3mkJB+LyrGqIXojz7UKCPEMxaQmP7Iqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=JigvEjAJ;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B85606A887;
	Thu, 12 Nov 2026 10:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B85606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=JigvEjAJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794479791;
	bh=8R17N+nl0pxoL/AYQkf0ULWjSnupGqKL3Jsa9AysHI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=JigvEjAJLRaovI4O4d9Slq4P7kjtV8g6cn2D7p+8a3jfMrqt6f6jvNYrb2GtpMdJ9
	 w8GGjwqqmqSmEx2obPC48sCrciFdlEY4R+au73jjUGELIgyr1QIePQ1cy2WYEtrb5q
	 SOl4GAjssrXPgoB8EuDsucXYeg6R7oyXd5em0GxQ6iC4gYdW/WgIHXlhoqI8kq+Rsg
	 xjtqntnKOxqkF/y5zF2jN1cTRSTWPvW9QZs0FMkwkh72k+eCQOGADursHy1c/qAgs2
	 MIt+qxwMjGzoYASZdO2LKleBAY8rQEue+C/pQv/gaAZpOxcq/b0LLxmlo7thRP+K0C
	 qr89ahL00oQ3g==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 1360381A15; Thu, 12 Nov 2026 10:36:31 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: syzbot+9ef743bba3a17c756174@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	Johannes Berg <johannes@sipsolutions.net>,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [syzbot] INFO: task hung in rfkill_sync_work
Date: Thu, 12 Nov 2026 07:36:01 -0300
Message-ID: <20261112103601.1848657-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <000000000000788a6905f0c06160@google.com>
References: <000000000000788a6905f0c06160@google.com>
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

Hi,

This looks like the device_lock vs rfkill_global_mutex inversion
fixed by 1ab526d97a57 ("net: nfc: fix deadlock between
nfc_unregister_device and rfkill_fop_write"). That fix credited a
different syzbot report, so this one was never linked to it.

The report shows one task holding rfkill_global_mutex in
rfkill_fop_write and waiting for the NFC device lock in nfc_dev_down,
while another holds that device lock in nfc_unregister_device and
waits in rfkill_unregister. rfkill_sync_work is stuck behind them.

The C reproducer, 600 s per kernel, x86_64 under QEMU/KVM:

  1ab526d97a57^  hung task report at 60 s
  1ab526d97a57   no hang
  9d66f26fefac   no hang (mainline)

#syz fix: net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Thanks,
Magnus
