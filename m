Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442328;
	b=MecK09DWwiGDoSgyb9hKakVfVvgbjPYSOi5A9LGJmqAjae1dz1B+Vo/ejNpRBvEJNxFb
	 n05q7ZMeAfRucef0RtUcO/JA0ALhwuadCW1og5ZWXGIElXvO8/Xz+CGdKWpjsGO2aRuuo
	 +KoAoQ65P6WYJr7wByC2iEYHWdBz22ZZDfHmuOPTJ8LZUDtvAD/T/aFtp3OkHyVKdlS6d
	 EVa5g1uN8B6KVPCxvvGbX7/TCmA+j24X4EvNY+DGIIXtmbKV+HWFxJ9LqkTuwF81I+w8T
	 Gtix5WOWuLTee0dKdEP2keW4kOO2amcKCl6Rs6PoQj65wOeulWMQQ9BBD/4gEHp2yjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yUoTRz3nxRBRqRaox4qtscXvEZF/9nPDzOnorkN3TaQ=;
	b=blqbtpt7Rm5GpCtSTdQCkfTE9GQoIfuOrl5dmEfgCDDg8d3LZ70jOP7aGESmX1FGWc/p
	 i+8fhWFfG/gAWWSI+fjJmeJ/cGVG4t8fvp4HNmSp9timm8KtueHhpvStAL79OvyubZTzp
	 0uq8KIak9o7CaFAeIVxe9l+JQl1EYC14sPzMrpRUihfoW4N3ooF1xqvU8Juvanvcg+u8a
	 q/zLtrcXjNAmuVZlVCEdAAorkCoq5Q92RfIY31sTg1T8XJFhuvJvndaP/ZnJ5kL5+Ahbm
	 BKM49C0M/HYY/MkBKIjb2Jb7MqeWW5jk6ECqz6rQKoNFsxczvvCSBrsKbsnL99ouXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3NmBLp2;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF6606A31A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3NmBLp2
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so5777580eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442326; x=1793047126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yUoTRz3nxRBRqRaox4qtscXvEZF/9nPDzOnorkN3TaQ=;
        b=e3NmBLp2HgBjnh9PVnigaYBz717TccQM2BDKleXioQrXwNJbKHSO6hRd7jXA7HV49I
         9/JDhycINxPzzkS9zRdmPO0QyI2G6tSUdaRgWHqseXeu3GlQrkxhnkBqmm3XdWj8Polv
         u79HkMIhgyTxTMQ2udOdiNr/54z3ssn4ipHnaEedloGfIXsfdnRetdEGIMtx6rHCjhy1
         c/UMVYjCmbqogFIwq7Bv40fqjpHVJwlcArzpJZKxZmqgAerdhMpn4bJEW7wBouee8ofK
         o5hxDCynKi+Odm4+8AHtzlEejBqxgKU7K6qv9RToGI4MBDX+E+xAZ+0fGN1IKb4yeMxO
         bvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442326; x=1793047126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yUoTRz3nxRBRqRaox4qtscXvEZF/9nPDzOnorkN3TaQ=;
        b=BUfScxt5oog4Qg9hNZqyK/U1iei6mO7vho/zWHmmI+VuixRT+rxKR2LYbvXIfd/YHc
         /Dj0TRgUmZvaHE95UidknBin49KGK3C5rTNt/fvVo1iOAxxC5DXbVHv48Iad7aagyUt4
         2qVJSfVPZe9fhLKO1YHoJUt7yKCVzeJILcdB/18gLWn+D7uDoqpreagYWTL1Oj/gJIYk
         zIbtXTmm/4gLbPKmnS7ntFr/gQToutlZVtMPwnD1a7YB7Hn9Q3BLU59/Kwe2IPtyvYlV
         a3NJeij7Kydc5cxrfKgLGUZ5BDicDOybxo48iGmIgKY12upfU9bENfADrm/PXEQGxOFl
         dmMQ==
X-Gm-Message-State: AFq9FYImCGWIa6KplSzzW5WMJ6E+9u390A/lV0pm+wFiqIjLL2nKaq27
	6dJ3gW3CjCcCbhtW4hzU4FPaa0IaNUBZJbOyqOFeyWDyUOGuKlyJa6EoI17eWA==
X-Gm-Gg: AYBFou0bGucc8RO3Dw/7vq/MOnCNsD1DLXD/Gp7kgtBgZimEfuN28OWAft5pb9X+wYQ
	xgZKi2IIPL+NsTkp2xBKMAR6g2M/SLwl0M5/kmpiD/PiNxH6gwK+kVoRSgOE+02nZkLh5k8Yixb
	+3q9yif9lYkfH4nI+Nr7DBqIRttwPG8gL7LV//oWS56ktkgm7tRcyExVDJ8VuEYA0/pFukP2TQD
	w5REybZuvqVscZgirVI2LB9Y3Ag1uCkm6BCiUM0RHsgJ9HRsaXqL79rCTIBtkXubEIyaiJo5NlD
	s4EAI1KNv92o4ANuYIzG6URKlLmqSpFk6IxBg0WN9nBuW+hYrS1NRur/Eimr885nuuG8B9zsZuk
	i0zfTQDXYXM9h5OPrlz2jzUEu/taiHypYvRi/ug4/ZQZIlH74ygrY+G1n/w91Y6MsLt6tkGub4F
	JNxDk3UcBywJqL4YQhrydMOIPPKnTKb4GtxbNP8ixOIcOO+2gIYk97XtGkI38aFSEGDVJ3Hcqrl
	pgMI/FChJhyk7viI5l4U3APKpHBvM9ZgR3/Q03HANl9KNoVQYQmVvaQpJk1dDV1nT/ZhqsAY6BC
	u/It3AxL2Ty3HiKd
X-Received: by 2002:a05:701b:4346:b0:151:2e62:fe5b with SMTP id a92af1059eb24-18512b42d3cmr13155866c88.22.1792442326107;
        Mon, 19 Oct 2026 13:38:46 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:7440:7d9b:b57c:b3ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm35138806c88.4.2026.10.19.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:38:45 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2 v2 0/3] iplink: bond: fix partner LACP state decoding
Date: Mon, 19 Oct 2026 13:38:40 -0700
Message-ID: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
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

G'day,

Thanks Stephen for the feedback.

While porting iproute2 to Go, I noticed ip reads the u16
IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE as a u8. For normal
LACP state values, this makes the partner state print as 0 on
big-endian systems.

Patch 1 fixes the attribute read. Patch 2 fixes the absence check
used by the regression test in patch 3.

v2:
- .gitignore and make clean: use tests/ip/link/*.nl
- trim the test comment
- shorter commit messages

v1: https://lore.kernel.org/netdev/20261011032906.1398174-1-dave.seddon.ca@gmail.com/

Dave Seddon (3):
  iplink_bond_slave: read ad_partner_oper_port_state as u16
  testsuite: fix test_on_not on multi-line output
  testsuite: add bond slave LACP port state test

 .gitignore                                    |   2 +-
 ip/iplink_bond_slave.c                        |   2 +-
 testsuite/Makefile                            |   2 +-
 testsuite/lib/generic.sh                      |   5 +-
 .../ip/link/show_bond_slave_lacp_state.t      |  26 +++++
 testsuite/tools/generate_nlmsg.c              | 103 ++++++++++++++++--
 6 files changed, 126 insertions(+), 14 deletions(-)
 create mode 100755 testsuite/tests/ip/link/show_bond_slave_lacp_state.t

-- 
2.55.0

