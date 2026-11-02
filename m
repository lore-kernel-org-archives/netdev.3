Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635107;
	b=tbMcrXJDDDYTranNOtYJlAj8m/Y7l6Z34gIll1BO+2/PE1QxW+T0xK0rOUvchAd3b+hf
	 BcvNbYkPEf2VdoiJ9ESogv4q6wOqDc+iKGo0MnPr+ZrrG9/jR6Hmmu8C1xPvw/nNWeyW9
	 3Xd2V3cCarNY87vVNAvQ30CBuPkMYV8FJBQmTY/FsbitI1MUBi6QPBxVZ8WudHYWd7L4y
	 06dPM/MKEzOBLvqVEjEyAv4rnTijvPA6a26+9jQ75+5EQzPCLRXi12DMxfCidm/oOQNdj
	 AKQy3qMHr22Vpsnhaot9aLpolKVrGmY2QTOhDmAnJogTLRe3onP1LHrzRisYNPtc7rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cBWZLJEjH2co87tE2DoLut1RHH5JuIQN5KXZ26QRuSk=;
	b=Pdo37dJLuYsHTSS3eRSJQ5b6qF/b4c4PAmFDrkxWxwh+j9gqoXVPXty0lEEvZVrMK1zq
	 GE1awH8IrZZ7ilfRIrfrJm3xS88a2OX007Yeck/e0MLmJGVf67XI/rdeO3ooem5OB+p4y
	 a6DjJ9I3aty9wggwnGdh9rQXjASdk8SX94KiPCaDlIbZQ+Rig1y2HtXA6RlxpusmDapS9
	 ol6l2odqK3zP4MdhE7LQWYzszxIbd1owFAi7CM0tpZ3kPqM9zwcamhQaVlnwZwmCeYg57
	 MRsQYFItyb1/LDptBqkKGHBe2MW9Pu0+s2vI+WLBZGum6hO5BUN9O40OTTg6rBtlAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HV8Ao7cr;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748EE606EE93
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748EE606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HV8Ao7cr
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1660331a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793635107; x=1794239907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBWZLJEjH2co87tE2DoLut1RHH5JuIQN5KXZ26QRuSk=;
        b=HV8Ao7crqWxEHHbRRXWt6HYL3Ox7AQpqu5PwnvFmItzJ3ItoF3mqbcnh8bZ59N96Mu
         tTgIS5Dsz2N0cOlgOznFx5vyHS25OlMb7Q8gI7aug62rsOSHU80F3l1PSgFA8HT0j+tZ
         1l4KdCyinXDVmVQEyodsvlTBqAcbQmCVaAmhfSJWqrE2g12puOxZhHAhHLzoafhwXzkc
         mGmcIOcB1lOZ0Hzd9cjh/mmGcKkVpJKXTxAOJPIhqQJmfoZksRW3XQiFWOueNLFfCwti
         g9sXir/Bh5igxcwHKPVolKLGb8XoP8ssWKdu2KS+EIPKZhS1FfsOs8SnKK/HBHCH7i3e
         1n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635107; x=1794239907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBWZLJEjH2co87tE2DoLut1RHH5JuIQN5KXZ26QRuSk=;
        b=Z+ERXhRwNFCmTKQ7gnghAO3h/XlkbnJlCTbGme6hrIeAdV5xZKM83lZh/usdqwQAW1
         HVtS/nxa1QNNEf9io76bDBOJtdyuqiko2rfZOtgEafgc5zWKi2bawAF6iHmHBrKfqNKt
         ql9ZkpiKNz61t5RKpt+1Kr3hkvIZSUaE49jfm94tAJIXKkD6wc/YBBm47gvfhFW8EMDA
         Je471AoDjWjPIn5hQgvlOso7P18JO2yztIBuoAa4wEN1ZVEOasoqxWRe5I/UTJ+vCSht
         v/iHtaQsU2vBe53ZPZyfREw04Ig8i/hrGqWpQvbQ8fx21r9Z3wzeIUdVU1EFbFueEg2J
         sVVg==
X-Gm-Message-State: APuU4Z/mcoblzzeb/VE8OBXjcLDP/KNiZYwoOipC2485s2q5AsXCOPjP
	e+2qIObzdQPmjJSKcgBgKEjTTIxM1AIXl6r3B51TEE6zy4Zx/ZRRMEQUkSZi6Q==
X-Gm-Gg: AYBFou04ZICNC92gWXceWjDU70Q/cOdAFPMSWod595a3WRiYxnaV7fyD78oHYKOutb+
	TkgJ2P2fCJDmLPHBstD7hq43K7mVRzJliHGSsG6MGW9kZdHzr0YgaCywJq/FO2VihTmHt4baEcO
	KZh54k9/4QVkxujwR+In6vo85Efx9qAVnwSm3XbYUn96ON3Z1FwGarRZbL3QSeea6tvTkJD2Pi6
	SlA+Agy73t5M0MaAn6eMqYXdzpmsC6+ohg9m4BoimnaYqcLGOKknUlSYJ/yxl8eydagbn5VfpxQ
	5cXHxfOQE0g1ysZ/zvy/mtmOZFijOmhLWDYC+3I/QEAJLsTHDwSTuT8zvhp57FPlDMpRgPZsPwo
	9bea7Mk+wCOpzH0x0WFENVH0Nq7AuZpAOo0gd6qWG7apv/3Hgue0BKfompfPg79HP4wNN6GCSym
	0r7TcBsylcGhx40Z7I9CFj4+63X2cNzw3kQbpYAasVFdZ7vbHUB2VHZ1mYVIGpLeAyuZdK4s/cX
	Ip5vE8me7I+yujMBdTrzQ43ZmiPigJ9WTlorCwbwNA9QoRm9bHyU1DSrv2NckDE7iSdJuB7ygMH
	l2yKOnE8v/5I4zeXmECRILJ0HZsru/cY30J4KjgYIW2wkD8Orf8Z
X-Received: by 2002:a17:90b:2e51:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3ae8983f049mr8614269a91.47.1793635106702;
        Mon, 02 Nov 2026 07:58:26 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm19183949a91.2.2026.11.02.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:58:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: dsa: motorcomm: More BR_* flags support
Date: Mon,  2 Nov 2026 23:56:32 +0800
Message-ID: <20261102155641.3682626-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add BR_FLOOD / BR_MCAST_FLOOD and BR_PORT_LOCKED / BR_PORT_MAB offload
support.

David Yang (6):
  net: dsa: motorcomm: Isolate all ports during chip setup
  net: dsa: motorcomm: Rely on port isolation for CPU port
  net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
  net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges
  net: dsa: tag_yt921x: handle FDB suspend copy tag code
  net: dsa: motorcomm: Add BR_PORT_LOCKED and BR_PORT_MAB support

 drivers/net/dsa/motorcomm/chip.c | 406 ++++++++++++++++++++++++-------
 drivers/net/dsa/motorcomm/chip.h |  13 +
 net/dsa/tag_yt921x.c             |   2 +
 3 files changed, 333 insertions(+), 88 deletions(-)

-- 
2.53.0

