Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474159;
	b=xkDKHdTH3nal6MUcqIaJ8BZ/+vtZsi0CNd+fS7m4SupK0FjOzcB5+g3PNlV2lGDWbdvN
	 5G3X7HDttKQQox7nodV9NCI9Z21phLlnPv32oHtjDTrPp02b6Ml0a5ubD3kRh9ehMb6XJ
	 1rZRi0pUcocPuVPi4UOYJ96sBoQ00gLTLPbMsmWZa8gyddz4MrbEf0dtp4cav6yVo+2Jw
	 OtCXxFqq7OexJK0vPhq9F3G8KNz+f0LDq+XU2ikEoF7owVaksWYGjDayNZrVVzPNzEU2T
	 l5RrmYKBqCa8WcYIsLh6VeQKBqfx//LP/caqdGNMJKDaCPR7EpVAE+tVWCeP33TmjzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474159;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sQTROA+2ZM7HhctIX3ti/nZ/3akeIRzlGS88TA6PMJU=;
	b=gv5/i52WCVAlJsI6qMw8Ps6W0V7oHqqEBsY6KgB6zU/kCAyduwzEXUGsQ7yeqGA+Muu8
	 Tc2y5L2RL9YLCNTCIbne3QiF838y7owirl04umSAkxxKbXpkZacJnPzsVnljzvrvLs+Ue
	 72I8S+QvhcHXNCwdlRRoUyrpUkUKOYEY0igw7nErwsMJ78S0E1zhd5Xvrwa8RHDMseFEX
	 B+3q1K3Z9gasd0QTRsbZY6hzlztgGFOxTxGkQ2CPmpVmfCWU+GvWu32xiNrodml6kqGhp
	 RnI35Epsui12giG5HULp989udV8jIkHZayMDLzdP+DNqnLC/Mff+hPkVWVlqUasArEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=isBuGvu9;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4E606A335;
	Thu, 12 Nov 2026 09:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE4E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=isBuGvu9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794474152;
	bh=wsxfuSYTb4m26WLN6I++b1kztJk7XRmZPsgFbFQo/OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=isBuGvu9e9I43xxC5UdLS2Lhf+K/f44bWFDXYcogt925ZxnGaolkCvK/lu/RgHAzK
	 0DbXDhs52zZgSbY/o0TVj7MyMO4gb6zN0dslZc+d1gyZB0ey1jVBWKHFCjZk6RIzDC
	 kpwzfwn1tK9S2rbjOi64/G36UIE/G9UB5K3IkDwwCsXm1i/QWdCtJJOUk9fAhzoUGF
	 biNpGRlulV7e6IJjQrEBbFzKZQ7tQq5cUDUZWQJOZjVts2tUuDn/euZ5I/NOsmvEJD
	 +gqtolF/KGpsUDNs6Q1frvMXpa+m9ZhRmpuElB8GOQNYK+0w1ptOyjcwr4zSgYKb9w
	 y/so5aOT7RoOg==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 1218081A15; Thu, 12 Nov 2026 09:02:32 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	Johannes Berg <johannes@sipsolutions.net>,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [syzbot] INFO: task hung in nfc_rfkill_set_block
Date: Thu, 12 Nov 2026 06:02:17 -0300
Message-ID: <20261112090217.1462672-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <000000000000959f6b05ed853d12@google.com>
References: <000000000000959f6b05ed853d12@google.com>
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

I ran the C reproducer for 600 s per kernel, x86_64 under QEMU/KVM:

  1ab526d97a57^  hung task report at 91 s (rfkill_sync_work in
                 nfc_dev_down, nfc_unregister_device in
                 rfkill_unregister)
  1ab526d97a57   no hang
  9d66f26fefac   no hang (mainline)

#syz fix: net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write

Thanks,
Magnus
