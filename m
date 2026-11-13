Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585101;
	b=xeKeMRM5CHExe6ceWbZyPXvigBa9U7iNzFzeNznAqkqfc7S/lg+3Nuh/B4luk5wf36Oz
	 Cgo0BarMYOkVThhv7n0c+Huq8dPAs6AHDtJgnRoWdayi9wbpEdQDH9gEfFBXTc/8JyJ1w
	 tCQxBAQ7cQ3rKK6rFgCs0aj2AVWPI7gmR3f64Q84J97dkTYY0m0SAGQpNUvnwejUjkw5Z
	 rZ25rXHUk8QnlAH2J6GP34uvYQW9MahhRcNfoxNweii/d3QJN7PQ7xwqb+5S3BwAnFU6V
	 CMoo3WZh6HbtJ9ZwwjfM4eEXoeRLITqgdu0CbHI+5w8AVNe0tgtpyyHfdYAayBOt2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TMge1KZhkzflUPq37SUzuANAcbZI1Ky20Kr/K+1+RuY=;
	b=esfQ+kqSjwEKA3CNvRu7g3AdfxAgqSkozpY5CauZZ+QD4lN1fnf1eQoulKcequI5bqzA
	 hCPAEtNxt/QwcoQY87+ws07sBIK4CvGi38pisiCpzCmGaDHmoAFgJYA076M481rLsDwk/
	 jpRqXiLzp3wz2Ih6++oATgIW5QlfWoGIAickD8DpX4SXuQvsi1lHDoUZrIvTHVyId268M
	 n7S06FJCZlWdz/dIAjeLDjB40QpsC1dqOIclPIVUPbVOxsHimtls0vynyk99cGYe7wnBG
	 Uii6v9ry3HSVj9aztpHqA42YtnNMU7E+YQH3VhTcnayipgYLpOzbeL2G7/sBs20KNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IsIrkHVw;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328E606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F328E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IsIrkHVw
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso443872b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585100; x=1795189900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMge1KZhkzflUPq37SUzuANAcbZI1Ky20Kr/K+1+RuY=;
        b=IsIrkHVwk3sOwDFWukhADIcG7eZjy1O8dfHE+ZtEZWOAM1nYz7eqLAKD9V9C6YlKje
         L66+oJugaR95Srt4UDM95zSXuIC2gdrMNhNA52F5dV5t+s0u+U2j3VkBlgqp+5IRr8ZV
         1EEJ/9LglROgH7diGBiKmum/bOL2KB+Fvdlyz4A9KXYxyes981lnE/V7kcCCBI8M/XZj
         0r1LPLqTmW1u372Io0hSoePgn7mbNpQVyCHq/54DUE4zziOLWvdyHXUvAllIWw54+75b
         GvCHDAmpP/2IJzE4UCrX8QxkIoyArQWTcRSxEiLFPNOgFhpcRFp5ecOEeSorL1AdYpBp
         J6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585100; x=1795189900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMge1KZhkzflUPq37SUzuANAcbZI1Ky20Kr/K+1+RuY=;
        b=zds+QMEWoCdwcScXqnpgONEGKbhHUK1nmX8DgkpDdvL4HySXpDzNp2OlUpwoxhhOBm
         wsJmAPWhlqkcGCaK4YjHfo9DhiLjIESm/B25YWZPCXXj9VyBVsGplO6h7QjShmG3C3rx
         vMmX4DdHKFk+udAi5CuGuNkP8jlnWq4VEmZMEoMkKU8xSj7MHreHw+EJeGCuwG8DlHDw
         DuCAFtDXpW//FWOpDSHoBWUWXoG8WFeQGPjNjMW4IiKn3pYeDAF/EnZcS68b86rTKN9n
         sLkBig7FGBvh//xWd3l/+j0Fx+Dh2Rm5zawFw1LBTP0imUKylogw7JBRG5wVlV8eOvB6
         nDDQ==
X-Gm-Message-State: APuU4Z8mdn26HvwwM+3HLIt1HAD1D+N68pVHlQy5Mw8egzRGxrX6CCuf
	20iOCkFYpDnkmEzrn+08CE5K8CGkjoGsFefcydj9EjvJ5MKcFTXnSoLTq8wgEnEDh0I=
X-Gm-Gg: AYBFou0d1HvRrgH6zF465b5KG4vZHv0SDYdwGgJhM8VCj2lRcuLUA/mWmyVeylgSw6o
	BF/yottUZErlDYAqZgMvua+iRXsCc2Zdgox3WIwx6d0lQkT6Nw1Mj/qTSxuyxQzGfxBYYsyd2Tc
	UnSmgfRo/Dmja+9EIwBXYs3d8jyxAIEsy6X6lKYZkZWQu0gSEfxFJsHkr/ouCGXUxH9SsZetWhu
	LahVGPTOJfR6m39j0rd5BAvivJOf+tOrhEyZ8qgTnHp/4TcKWtnsVciXXn2hOHjpHe132Vk8Jq7
	bMoq+zykiPQ5Eb4yjFws3tzXzbhKM/lr6s5gN35BiEFPNolojs6lT16S9OX8tHQsG0wRMSReM6I
	hL33UnHcVuSmKmVCpyXUDc9Mcmwv+zzOQeBmWENiZARktB9EQJ0TMUxVbg1lPeoEiEqk/9BTcVT
	AorF/HVfyVVZbVoErSYj2d+v+egazUgHQfsXA08cOGbRc6ACEllkI6W9gR27CEbYp1iZrmh2V3p
	Uzj14YVOB5wewsSqlaSsJ/MbEfrqq7z4jgdGdUovGkt+VeFdhBY8h+M6ddsG70bC0vyXYCESYJy
	MjRgWUHS9lK2xFIm9nZN66T2MP7ggnmdOdzVkIDLvzE/Ix+wI8gzKQLYCFxD5kCKy/pX2o+OVDc
	yw9s=
X-Received: by 2002:a05:6a20:4324:b0:3e0:c955:cd5a with SMTP id adf61e73a8af0-3f7a9ef620cmr2898908637.68.1794585100018;
        Fri, 13 Nov 2026 07:51:40 -0800 (PST)
Received: from localhost.localdomain ([219.95.157.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160a17esm1634075a12.3.2026.11.13.07.51.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 07:51:39 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	mschiffer@universe-factory.net,
	nicolas.dichtel@6wind.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 0/2] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Fri, 13 Nov 2026 23:51:31 +0800
Message-ID: <20261113155133.75090-1-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When a learning VXLAN device snoops a known MAC from another VTEP, it
rewrites the remote's IP address in place but keeps the remote's
dst_cache and remote_ifindex. Traffic to the moved MAC can then use the
route cached for the previous remote and be blackholed. Patch 1 updates
the remote the way vxlan_fdb_replace() does. Patch 2 adds a selftest
for both cases.

The selftest fails both cases on net without patch 1 (8 of 8 runs with
1, 2 and 4 CPUs) and passes them with it (16 of 16 runs).

v4:
- add the selftest (Nicolas Dichtel)

v3: https://lore.kernel.org/netdev/20261111180001.2475-1-ilskdw@gmail.com/
- use my real name in From: and Signed-off-by:

v2: https://lore.kernel.org/netdev/20261110153020.9635-1-ilskdw@gmail.com/
- also update remote_ifindex and clear offloaded, as vxlan_fdb_replace() does
- add the IPv6 link-local case to the changelog and a second Fixes tag

v1: https://lore.kernel.org/netdev/20261106144406.66035-1-ilskdw@gmail.com/

Zhefu Peng (2):
  vxlan: reset the remote's dst cache when snooping moves a MAC
  selftests: net: add a test for vxlan snooping moving a MAC

 drivers/net/vxlan/vxlan_core.c                |   3 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/test_vxlan_snoop_move.sh    | 161 ++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_snoop_move.sh

-- 
2.54.0

