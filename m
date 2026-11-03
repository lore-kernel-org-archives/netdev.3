Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740433;
	b=TciKzqPO6yxMslSgxvpFszGIOSxrD17QHLssjvwHgJ+Eq1CPlw3UGHXDVhe7Rcw9RuI6
	 0plA87N6nZgzvXiVvaFx2SNa98ewGZ3DEUeyTDz7e1h7NciZnyL/CFYpFxSgUhk/UPtvt
	 R3j+Im+ENx67DxJEWv6QfwmW4S5aiVHRd66psJ/+wQXduclI2mczd1f8uqav0Wdntjd5K
	 AqR+gChdhQGIRBVGEe7a4SsArX72GLbYJDKvtsE2p2mAOwGd8LqCzGeUB1y93RlX3rWkl
	 0jXnHVKsSiJC2tC4gJssITKE3wHardJLNM3X2W1PyIuAK3OLSF5F85R+HRqfzgc/vuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=j+CzPDafxCj9fZ8Cq3DLaNwMhYmNWGXJCSroxfgm+X4=;
	b=vYMGi2Dyl9wBVoTsEj/d59ccJ6vc8KoirakC+P/GeZfcmHtDs4GVt/fsm19b96jUuT1b
	 XEMr9kkc6jYcU2Wn1RD8wVRn/UuyAmQ0zvEL/uwU48ArXT8kssDYvdAqk+8n1fnYAJz7m
	 uSMHjXUZI7Y+Ah1kR41xjlnR25bOnz8Goabxyp3aVYc3js1aSV2snGBHhAFNbYPu95xEq
	 lSxLvFBnBqLSBG2sAYc5KF4zUuHI3GbJmIrBcrIupwCG0mL58oC8DhpdS8LV6zlu9JyTd
	 LObXYYmqEojRvPJPmSZv0YIeiFeiQsBnc6Ws407078MQkVcIAGw0JBOTFWeYyQHsiUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTsWmL3Z;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2422E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTsWmL3Z
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so47069105e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793740431; x=1794345231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j+CzPDafxCj9fZ8Cq3DLaNwMhYmNWGXJCSroxfgm+X4=;
        b=wTsWmL3ZHIIOBiHw3gbuOC52/IfWm3h6XXc4PQN2CH78Q3UkowvPO5Kog2uQbB7sOq
         CWruA8GaUHCyPy1iczpY4gXbsgHDHpdoCxNHz2JbFS/1n4jzxteldQaZ3u71PlsoeQND
         PCewtlMU7XT+tlfbL30Nkv2LIUQ014c0DZu1qbyG/7zByfMapztddxKoCovFnxHAVKQZ
         LTGQ25H0i7zYbKYdIAZ+QcpMKqpBQFtRSQBL+T857cNAPal4c3mCcw9xJ8nEYGDwanyn
         Tc95G+8jQzNnXB/ikhBOB6ajViTdAczqTH1+v8m9ypBocwyuEbRVCGSegkUM43ZuEk/L
         W+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740431; x=1794345231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+CzPDafxCj9fZ8Cq3DLaNwMhYmNWGXJCSroxfgm+X4=;
        b=F6Qqnao/5xpadW+vFH5E5Se4SjslcG/VqFoROSSVcL3CMr/pIynt24kJ+iBPt5nx0z
         NBET2SFniRgWgCGMUBG68sC2s/OWbQLxyT6WG5geiqyfRg3nQExTUjYPLTvkkQpMDe3j
         OoIhMOcdEcgGT50F/Pkjb6qKaOnuM/Sk6LFQLN38QJOL30IRAjyvmv+wkCjNBgHyYwS0
         ZwdZBc7GvV2MjCTPvhyG1riaWUtRSkt4Q8fFQTLAGPSAdpfU5/M2od3nZkkglpDZqL8r
         b2yrXHqPRKAnzE0dEMqu5mo2SoCs4vw2q1JW3VrOCDIe9cNiyAF5uRxpkY4xjOPb9J66
         Nt8g==
X-Gm-Message-State: APuU4Z/9bkHwF+0RPo+06RpfuPS9Nx3m8oWOtcjcPmIPM8Fd+bahP/Sh
	eQ6ZlT5QwDBWULxO8f5m6PuZKi4t9+cepKUhEXv56F8ehhVbHTzz+RY=
X-Gm-Gg: AYBFou1aceYMgPrzSlreorY+S2zxJeIzLQvggAj8j+uUNlbCwQZ24ffOiFUPtKK4Vt4
	Be2Yix4/kweQ6LsnBfOsYawN44T6vNwZ3hrGj57aVx4XFEBUVJij+FM7xexac/sRUzsuTEqmdQ9
	ftCAR4bR4QemH9YoxuswoHL8UKyT2bKrtl1qIj5Nxfwg1wE5TrQdXbVLc5gHyDCHZ836HX+hT8u
	lQKgy50smaO8gg8hzr9/O0Sijy3ADwZjXUrrKfcrkoE6uOx6YoV4lvcILvjEw+frQ1Gb250qFjb
	KlwvH9+RHjbsP24jfNNAT+csR5nmsO9JVhy3DHdeGgqE/JA885rsgNsr1ouq9EiOktr3aB8rm2t
	Zir3dhfw4724aZcc29REujaMLqmtsinxWB3h9DdzFR3L3iG/JnBtFHgzOAzbz1forV/STJO0HO5
	ot8nJcb/wVxWiIS2ZS0LM0vjha73dRVNcJGAAULFxZp3rEPJy7jYy++GRxV5HS9V5cJL0rhi+0g
	J045Sc3or/r/lw4xiZdOyccpMPQBSn7D526J/o/JNRLHnsMou6gPEIoHPuPjIxO89Ww9bACGPtA
	fYh3AhCTt4YYfeH+//czO9rgGHyvYX9RFzae3PCXMIyUY1MGTZ+v4Rpq/61ErCSMFtSdrlxUBwE
	=
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4ac17d168b1mr364511255e9.11.1793740431324;
        Tue, 03 Nov 2026 13:13:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:9d9f:2700:6d31:a289:bf62:2372])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab3ea6a9sm125728205e9.15.2026.11.03.13.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 13:13:51 -0800 (PST)
Sender: Akshay Ubale <akshayubale.dev@gmail.com>
From: Akshay Ubale <akshay.ubale001@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	Matheos Worku <matheos.worku@sun.com>,
	linux-kernel@vger.kernel.org,
	Akshay Ubale <akshay.ubale001@gmail.com>
Subject: Re: [PATCH net] niu: bounds-check phy-type and model VPD strings
Date: Tue,  3 Nov 2026 22:13:48 +0100
Message-ID: <20261103211348.39521-1-akshay.ubale001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179253979539.3290.9924821446681218748@kernel.org>
References: <179253979539.3290.9924821446681218748@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Answers to the questions about this patch:

- Discovery: manual code inspection. While reviewing unchecked strcpy()
  calls in the kernel, I found that niu_get_of_props() copies the
  "phy-type" and "model" device-tree properties into fixed-size buffers
  without checking their length. No syzbot report, production report,
  or static analysis tool was involved.

- Triggered: not triggered. This is theoretical, found by code
  inspection. No symptoms were observed. Triggering needs a property
  longer than the destination buffer, which I have not seen reported.

- Hardware: not tested on real hardware. The change was verified with a
  SPARC64 cross-build (gcc 13.3, W=1, no warnings) and a standalone test
  harness for the length-check logic.

Thanks,
Akshay Ubale
