Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223444;
	b=gdPyad4sVYBlAvbboQr0b9bahVidsYFf4k3aEb44Bx7WzJGsemRm1Khnc3AvW+fYpbPe
	 H1a9VIIz04bHblcyn/4toB65IZNS7aAsuLQNLnuwbCOKf8vOSqH0xQZBka2SIEERIHaAJ
	 07ANb0cKsCtrHlYxl8c0VqVAU+VHmH/fRU7U1W6hbwPFimuFJUDoLis9xLJoUIaCMxiC9
	 fwWkYtld8xuehEo+XIt1dKn/rgUJnDdKVdgOt9GOLR8XSimy3P2ns2Q+0w1A+UoCNM4SQ
	 sZXFEFj6TIa64OCQcAiAArBljICkmC7/asmEU2WoM2MqauFuRkDCu6pjbnl4PjIB6pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZqeYW4br0ttDJgg3XwsnzUv13cVg+FEhbEsEAlcoSXs=;
	b=VNO3ABSZw7ylvfBjYt9SbHCeBBIKp3JeO0zvA6ZMha7smOpilA5VIls1Fv8FGiUEU9kG
	 XKbEhwPwhccLrYErMq/47YeTAWgaMZwSbW9QsKoQV5W7uyHyZpjS1g/oJL08kXSa63Hcc
	 f3QzG3iWEdJjhQz2UZc+wOf9igdIFn6I+HgQYJyxRXHYIOeEvmxbe+S+ifdD4O1rdkv92
	 ak5fKRdqRDwGehRYEhycDFziFP9wMEp2QCKf0h6UsZ8+F4DaHh9JYSNw3LGkUhmYrU7/R
	 g05bOLrJAzMM7U+mC/eeIXXmLvdvmeMgfav2PRgPjnQYLQRWu/hMTgGqKWH5QBp3hVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9OdgUUf;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B35606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B35606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9OdgUUf
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e812e2b31bso8641545ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223444; x=1793828244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZqeYW4br0ttDJgg3XwsnzUv13cVg+FEhbEsEAlcoSXs=;
        b=E9OdgUUfLX1kV7LneuejEibeemG9j7pnHU1EANxvEYLLJNMjlfqTJnGyg13qrl5OnH
         e2XFbcrdqGPyQidTT+AK9ZvkhbcS4d8Xu+ybxusb5gdU+nG/I5qlRcMvAF1GKmdrqqga
         4ff/UT8Fkknntl+yFl/vv1v2BHMXipVUV7kgMSLZWDvY6iUVyZd1DLUSwwjDRTy3DXsz
         Ilt0LdelF0BojmgU9kyTkjRaB6G1bldxl+588FYNusXNvlTYhFd45nlAcC/evIKwncEz
         LAv/QcaB5ACXq/Ige2zKkiMO45Yey70UDd4KYocODOwu+hfFddiKG7xUsi7oexfr6sFp
         /D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223444; x=1793828244;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqeYW4br0ttDJgg3XwsnzUv13cVg+FEhbEsEAlcoSXs=;
        b=hjsKZ1kSOC0W64wcX0bFHRKPNKdM7euJ5lAqkSBdk6VbV+JPWxdjUxpBfF8dLKlKG3
         t8G0Zpvw0p/Li+rcajRjx+LKo8E/tovczIjRZFdb7OQ6NVr2WlGIzKhpPqdJrQl9oh4q
         8Ou/IVo7pB4hQXdaF8vjYw5cI1BETImjn/plSleC7/oLl4d6Jyv0SQ6OxdLSFKTgEwb5
         zzOId8PSN76Q6SgCbo/Xvsd00pyjrY2mQWfRrN2Gk6w9B1Ey/vAQnyPUqmwOkawXVgrF
         yMgVbbYkkGDuMPzt6P9OeRYLAiokxT7ZMydUKoJYKxSAa21SgWMUh90r6cqVtB4zk7k5
         TY0A==
X-Gm-Message-State: AFq9FYJWT0ibPuCUHSML3xRSv5XftZhGWiz0+Amyf160uky1u76OkbtG
	BPVGoVWW7evUiTxUk0YZuSdJ0UjQb/7v1rXocKQqrPrimLRzs10sIlas
X-Gm-Gg: AYBFou3j76XQ/7qh++ELbevzNTSH3tzBgAr2T853kaubJcmfdtaZCCYvY50Rn647Zi2
	VvcH+a4pm6NZ0y5XOvohcgVjasgcUR0FZRiWXAL/D0PrPTj0NEyi3c9vlZUDhtYQcHuW2aOJ/Os
	BE/fSSJDqBBTlNs3+/4R4O5ztGmFWyLqRmSFcqqoDGpfhYJQKjsk+EFv8gGQmcQmFx4zZeqt+08
	iD32RxMhUVxLn5vB2FhcHnxuF1qJK0g1wmGSvlwAT8/wW42ZLRl0bsfo3FKFRkYJOEeGVkN6WsJ
	ZTn3jBEcYW3DITy2ohKS/+aOxJFiY4tzXRrrwPUhr2ZIdLt6kXbTMZGQJPBb2OPdEL8mdbUnNvr
	M4QRD7DivFsKhFFCpoxL8OcIflrgwGvRsbsbnRzd701lRAjVT6dFchCgMb/FLUOca1EmDN7HgmZ
	zLcs5c/UiCs6ZGA8WdLPlABAn+iY4C0HHEIkFRwnkv7fj6FXhkQjD1/apVxz5Anb/R3MQ8sehoz
	Jl+T+EGlRBB6q75m1cJHzzmw5eK3l3vmGF6T/Q15GFfNK9vT1APkV/zCU8OYk9K59SLFg+/sTeF
	gUTT3GoQ+OAah8eZI8FTUtQ1BSbkNXwNjsWkgnIjYTSyo8OJoJY+R/lS5Zqy7gyXxHpH6kY9+i+
	NlgQ4MBZh7y94jGY3QG8hPdgrVhCSGBQwYJLFh1g5k9GLrg==
X-Received: by 2002:a17:90b:1805:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3ae57fa94bcmr2473720a91.24.1793223443866;
        Wed, 28 Oct 2026 14:37:23 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e89f7d8sm1077980a91.17.2026.10.28.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:22 -0700 (PDT)
Subject: [net PATCH 11/13] fbnic: Suspend phylink after taking the datapath
 down in ndo_stop
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:37:21 -0700
Message-ID: 
 <179322344127.40667.2505190570032252359.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_stop function calls the phylink_suspend function before the
fbnic_down function. With no BMC present that stops phylink, and the
fbnic_phylink_mac_link_down function disables the MAC and holds its Tx
and Rx clocks and FIFOs in reset. Only then does the fbnic_down function
stop the queues and wait for the Tx path to go idle, so anything still in
flight has to drain into a MAC that is no longer passing traffic, and the
fbnic_wait_all_queues_idle function can be left to time out and force a
flush. With a BMC present phylink leaves the link up but turns the carrier
off, which the phylink_suspend function notes assumes all packets have
already been sent.

It is also the reverse of how the interface comes up: the __fbnic_open
function resumes phylink last, and the fbnic_up function then enables the
queues and installs the host Rx filters.

Call the fbnic_down function first. The Tx path then drains with the link
still up, and Rx is still stopped first, as the fbnic_clear_rx_mode and
fbnic_clear_rules functions remove the host as a destination for its MAC
addresses in the RPC before the queues are disabled. The MAC IRQ is still
freed before phylink is suspended, so no link interrupt runs while the
link is taken down. The PM suspend path goes through ndo_stop and picks
up the same order.

Fixes: 6ede14a2c636 ("fbnic: Move phylink resume out of service_task and into open/close")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index a40566029a86..36ef17dec0f4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -86,11 +86,11 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	fbnic_down(fbn);
+
 	fbnic_mac_free_irq(fbn->fbd);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
-	fbnic_down(fbn);
-
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 


