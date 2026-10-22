Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660949;
	b=wY/XnR3WH6tJtqXtS4KNnYtSE8PPrktZzsabDWqQVMPA3+4DbfB5ORqMpKzXeEYaQ6dz
	 P5FgrmoPGqcNDoVhjMjYfbCKfPTipdXmYwI8ObltdWW8hLKtubDtkckVlsarbDfaYjiNv
	 9jlT4RbupS9fgSJDiGK3FUVmW60SyiGBuOQaMcGi8ZvaISbhLQ8HBayEMPp+N38mjHQ8e
	 tjyd6mtK5hadpz0xg4UashwrB+oo2SZTdz/RIcVrum1XeyPonX8p4PXvXwPPHRiq3xLmy
	 DScPNbayDdCdRTEqjFKbv13Yxf6P9gJDrf1Wto9mWK9FSH4DkjrWG5kcA41aLrqjDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0FK1E4HafU/gDAYLjqfdLFPs2u2/Ks6IJ2norac6D48=;
	b=Z9YmbcASbwZrb/Kf6DXmWveElpvDTU4mqSGXtaxV/QdGbGaxDTc0A6AmOruDqWvgg7iL
	 SPjYhHTLhLlnIc89BRk+iBVAX0S3h0J6vuNVqrgSkDKBkfZCHpCBcu2oSpH/26iNoIm1k
	 6UK8xJjR2AWUgjIbr70qlaRuiWnUGjxxgqn6VoeqG+1hEQM2CyVGrI62lgf1oQp8J3zKU
	 MQnexV20lA6e6NnSmnxualeMhUrwFw18464inHJsXwhvPzTw+ek93sDAFWq/tN19UvkxY
	 iDQFpArYv+wnmw3SYT0aclOfJE2vSLfdHOLDG9vsGU7s12kReK/qECmcNbcO5X85QRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=naMusfyD;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE7606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFEE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=naMusfyD
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f30660e69so101138785a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660947; x=1793265747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0FK1E4HafU/gDAYLjqfdLFPs2u2/Ks6IJ2norac6D48=;
        b=naMusfyDTxsNKa2YjsTrbzZz5uVWUPeL+KObvcgNgN49PF27GZ0vJ0uUw0/+Ssqwfs
         BocOAm23beY3zHsrnDOhOIlSKfH/vk7mHxWsoGuPxvPSqU1S8SvWvVXnUZ03x9rRIAmY
         ThIhlllFaF78HxOxEWl4ty9dGDlsmInwxh6s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660947; x=1793265747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0FK1E4HafU/gDAYLjqfdLFPs2u2/Ks6IJ2norac6D48=;
        b=Ud/ihJwnUjpOSigrj7wWBG+k08yWI4W1thon325RaXyhxtsuYKAFb0jV7c8pDVVZNq
         JdyoLMZYvmwnI4aCn5QQKhSdRgIOPya/u+pLYOTUa+dDx1jS8SUdKoGzUx7CZGvO0n6+
         06D5bEvq3G89WtnhWo4NHHszCsA95pu3cCEyxCk4S07iDOKE5ZAPIQdK3ivBQvCJ/+/x
         XVtoLTq+/jm8VqBupuG2fVXrC1V9ysgW63AoGQ9KhBKZ7O5j6zogrxDfMiYmmG+0ZJMO
         BglGAyTpk0ygGhxm1VWzFJhcsZFnULh69k41s9+FFNvJbkrPIyQLNFk42kgKPKE6gPIZ
         pW4Q==
X-Gm-Message-State: AFq9FYJISqyUNgq6WWflZZVgd1XLoMPZRU88u8NcoVrsxQbM1kCcaqwx
	QIcspRuAyw/dOaFj2TwJf5MPLH8GAlSIYBypy9LtC5/Ovi3YuiC7S/w878i2Jn/a78IFBqXW+Eo
	vjfk=
X-Gm-Gg: AYBFou0wHZY4Shfcvl99OCK0B9zFcF/1aXJZEIrZ88l6/NFch3sMqDhBCzhZ40mt2f3
	SPMpfSqVtaKlV4X9LENUcrFDV4j89rgBsc0EOqk+eVjhH5zseSykgYOUUSjy9ht9G9YXx28kvEU
	g7P64/XDO9T8Z4JhBpzNnMYWXZ5YDunoJI3/WYklutXIM5ivAvTVsyGXzd2PmKWWg/UaT01f9xB
	l3/NrT9Jbjqi6r8AR4w2EPpsPPsxkjF7TUviJfF+DRUEKK0HJH+D586ZjX8281481AlyYXT2mOz
	eE10QhheZOTGeq+gMI5DmowK/zso9uBDn3disuSLTNWe3UGzEskOBtzr/f/xgKeedtfrR78gkLv
	6KNRO2UghkDhs3ab44D9ZiHhlXWdRgXFfQMvqnhDCCBUJrBinA6ywmsyCjM1SAVnRYQmh52ti9I
	nGunLPBYVu02oQkchkaN/0zVjwbq4y7qR0aouf1St+m92uviAQToHFrD5MNVCzlQwkt7WPV8bhZ
	BkC/Z66whf5uheE5t3D6SzlNaB2R89Ijoy1TmlXYZfnrHl7hJcTyIDWf0o5wxYstnIZ1+e3TTjA
	ZyE0JbTHSrD38ina1LloUP+o3/2O7Mse/NUzzGXpbdEheh2A
X-Received: by 2002:a05:620a:2a0b:b0:93e:e394:78df with SMTP id af79cd13be357-93f57f62359mr848019985a.58.1792660947621;
        Thu, 22 Oct 2026 02:22:27 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Eric Garver <e@erig.me>,
	Yi Yang <yi.y.yang@intel.com>,
	Jiri Benc <jbenc@redhat.com>,
	dev@openvswitch.org
Subject: [PATCH net 0/5] net: reject short linear Ethernet headers from tc actions, tun and OVS
Date: Thu, 22 Oct 2026 05:22:17 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

A recent flurry of bug fixes for dealing with kernel crashes around
eth_type_trans() showed up on the list. The earliest attempt to fix
this came from Ren Wei <n05ec@lzu.edu.cn>. There are many others
(but i lost track of them). Ren Wei's latest attempt hit a roadblock
with a NACK from Eric[1] asking to fix at the "producers"

These producers can hand a packet to a shared consumer with less than a
full Ethernet header in the linear area.
This series identifies and fixes the following producers:

  1. act_vlan POP_ETH rejects a short linear Ethernet header at the tc
     action boundary.
  2. act_mpls POP does the same, standalone or chained after POP_ETH.
  3. tun keeps the no-offload copy hint safe (raising a short hint instead
     of rejecting a valid write) while guaranteeing a linear Ethernet
     header for the redirected consumer.
  4. OVS pop_mpls(ETH_P_TEB) pulls the inner Ethernet header before
     restoring MAC_PROTO_ETHERNET.
  5. OVS pop_nsh(TUN_P_ETHERNET) does the same for the NSH producer.

1: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Jamal Hadi Salim (5):
  net/sched: act_vlan: reject short linear Ethernet headers after POP_ETH
  net/sched: act_mpls: reject short linear Ethernet headers after pop
  net: tun: keep TUN short linear copy hints safe
  net: openvswitch: ensure a linear inner Ethernet header on TEB pop
  net: openvswitch: ensure a linear inner Ethernet header on NSH pop
