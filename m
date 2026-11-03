Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714482;
	b=G4V9TRfYxpYQdzqIftnZDUS/vm9VuBydnEW6Uix8SkB2iDyRA8QJxEed+EwFsZfq8eYM
	 GIHN5eAOpBGwb92xBkZtc3x1ED+52zHyMABMSLr3EZakwPoJSjnd8/g7PTuTQDa1HobDv
	 mv1JfSxutRT5Pu9sCYAFhEKwZMAEQkU8sOh0A60mnop04kLeu0DAzKbBLOJ5DUWNwb3sF
	 cRMm9ysqPvf5nP68wYLPv4ISn+MmavsLT9YVB8vc9dw7WcSfqMkSb6cPrExjKxj/afUfI
	 II0tO9KRTScXgRdc71d/3B3xKWs4eASnPfSTcKmWPvOLlIJZejIlU0ncPMHNWPB+gbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EZsHlnUndDVe+vKUSGCoj7IkGFEvWSmKL3jbpdQBZvA=;
	b=Jv38bGmbA2LNvWi4exvNkz+jt9/+yLaAmqyhMrBzqw2qKc9LfPqvTXM/kUolPx4SNIYq
	 Uw3GjlUSOCq82SSsYaOOrKeDwbwswZ5HalVN/XDZ1rcU9nVfJB4zxmoa9/l2rRo8+q6h0
	 kjdW/U9MUf/KLv5b1GuWzjbh2nBtyQKU3pB1X0TVcpVwR/6bR4my9efMHabBmgQPHh0w7
	 vMF5QkKjRKxo34rqjRsmyKRE9+XKQiEmzc15rMlhkmxMpPz5wE5EXl6W3vxwwmyRSxo+c
	 PZ7MLy1WMWPDzQrULlPLm2T0cHif3LwGb8HRMXYi71JJ9NvEMLoCoGGkqkbLwhq3SUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFd6xJ2N;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A6606EEB2
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9A6606EEB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFd6xJ2N
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab41538192so3350233a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714481; x=1794319281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZsHlnUndDVe+vKUSGCoj7IkGFEvWSmKL3jbpdQBZvA=;
        b=CFd6xJ2NR5NhWmjfGK7vIJkFLy42NWFiWTDek1h0AKcALQcvfPM0A4EOdQEKqEnjqo
         5BHunepR9ulXEW0BkmvmyZSCfTrniLb2KGRRjc4qhZmMzL8DyIKbPYqdz1aYDD7qvRI/
         VVRLP0eLlRgV5DvluMeUecum10aEus6gS8SzC5OC5f5Qw73VL9/pny3ns2nxvw1H7vR1
         8KUZg5QlShHRnbKbTpcO4LTiBt+6WRYdTQHXlns9DeCtCmSExnKjj9dmhxbyHkREi8sY
         wYTO3HnVZQLVwVmBLjIi2XdgHWbzUqeVMU2xLfVypz/HbYLd7ctB2aVuX+8Ua0HnP1jr
         FOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714481; x=1794319281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZsHlnUndDVe+vKUSGCoj7IkGFEvWSmKL3jbpdQBZvA=;
        b=w80wrWeEvkVQ1xfz0W9RnyIRpJutFiVyt12QjK6YnGH6cUgnwq0EfPzsBZehAhPOHE
         A7iMtUsxoOBtKex8+iA5rOMryEu8Us66GhyOOOvCakSaWMEw7YGp5LeLor8yEirf+HSX
         M5AOSpr4nUV9eqxT2KTP8HnbtTSSN3l+mQ3DeOxmzNLX0t42Zd1XW6kYUnU9EzfwECrn
         RnDEipBSL64rUJbBS1ZzUVKh44xooQaduiXPTopPgmx9k+uAgdHMg8Kt1BEzA/S3hOhb
         v0+cbGln2u8QtePhIhdIdSpC0K4rYT2NMbSy+Pyxt5QcB0OFfIXoGvAzTX01zAiUb+jb
         VGgA==
X-Gm-Message-State: APuU4Z+PTqEGhIrBHb0jJ0Bhei/1uuqG946nvvglqYC7ruT6gU0ASZiL
	s7JDxs05pqwkgO6hUhdnPILxH5uxSvRdeGMaGrKo2hgc+2BFqCfs8GkRPcXvkw==
X-Gm-Gg: AYBFou2exUiTepad9jLlixI9aKmifz0ofTIZdzPY6VnFaqOXSbwgNkgVuKtejtojVgr
	NMeVD69Gdk7hc9XVmxL7W/E1rU7Ps2QPU18cho1l2fpgeDNOGsH+svBHIJVoy82bi5Elfh/dKrb
	j3aFCqQFk2zCyY20Hh8YUQZ4Pw/u+3KD5IbVFxn2CeUrkf27IALW7iEz1buMwGb2ON8lto4Vpaa
	+jyvWrxbvN/oqk/1dBWLrPJsJ0KDZxIUfC8R4MiDXdQuWg5nnLtkszaFW0jsVpvYodJLuiEWkgS
	R5o7eB27V0TfMUzvn93+rVX/ucdS4NhGZ1xEjI4+w23O22zcy8w73AH4RLVjA6q50evs3zHSGil
	ud9Y4dDzvQ7x/Mi8vizvzfg8oOPL2ZjNFWEKcjSMNnGrzIt2flEt5H1t9/Kvtx1VYN5AHgZEUt5
	2Dqo0n/Ll2h9t5I1zlhiVDCKvpnAI4OZdy+mHe9NcvEvRrZgJvEI8CRXz+nx+KBU5izmaQ2CvxP
	Qhp04drZWRjZVSDeQrDSvrFp19nKBBKfanDA2Jqud5AQKIHJrCmRECuqUFtQaY8iGCyawzjG6hQ
	m/gBBq6K2eGJRjLAiJcec1sacmlV5KfmcnqiePqZYR/OstCwr3dc943Osa+GfdAU2jTRNtlfpQ=
	=
X-Received: by 2002:a17:90a:d998:b0:3ae:a59d:4e2a with SMTP id 98e67ed59e1d1-3aea59d4efemr5555004a91.47.1793714481065;
        Tue, 03 Nov 2026 06:01:21 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm4722104a91.7.2026.11.03.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:20 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support
Date: Tue,  3 Nov 2026 22:01:04 +0800
Message-ID: <20261103140109.874443-1-mmyangfl@gmail.com>
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

Offload BR_FLOOD / BR_MCAST_FLOOD to the hardware for bridges when
feasible.

v3:
  - refactor port isolation and filter action for standalone ports
  - recompute flags when a port leaves bridge
  - honor BR_HAIRPIN
v2: https://lore.kernel.org/r/20261011030228.2761810-1-mmyangfl@gmail.com
  - fix build error
v1: https://lore.kernel.org/r/20261009005542.72860-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: motorcomm: Isolate all ports during chip setup
  net: dsa: motorcomm: Rely on port isolation for CPU port
  net: dsa: motorcomm: Add BR_FLOOD and BR_MCAST_FLOOD support

 drivers/net/dsa/motorcomm/chip.c | 233 +++++++++++++++++++++----------
 drivers/net/dsa/motorcomm/chip.h |   4 +
 2 files changed, 164 insertions(+), 73 deletions(-)

-- 
2.53.0

