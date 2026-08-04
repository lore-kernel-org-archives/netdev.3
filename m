Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0048986F
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823859; cv=none; b=cpREsAPzgbMnH6Q1eTtoNmZETws75KRGxGOPLdMd2AKm9ATxR8NSgGaGvPceUNX5UXr6BkqDRt5WXMx+Kq8NbMYDyym25Rha1OCYmGnLrsCt3/GWkVAaiPxJseji4Be36IwIdWBg6rPUseSZj9uALv5iS/2Kfm2pjjqxKLbRSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823859; c=relaxed/simple;
	bh=6L1PVLST7v1nkRF+r8Iv2XGopCR5emnQnssaQ73pjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iosKEQ0LIsWUZk5etChFINPALQvRoTs5HX+WArkL7DM7TQpFTOLqDoCis1WtHol/W+I9rS+KMpSq1B8GH4DMHRUhSuBP6EtTcXJvJPsNmw+TTdPdHu+34bAu2IpN95/mW+Uzz0p0YW7G7heYAqK4sCjuoooybVUpzOGAme2GxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VLfa1xOg; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="VLfa1xOg"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902f92b8504so24236586d6.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823857; x=1786428657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuDYSjJQEMSMyuu+bbvopLn43BBsmPMFs7o1wHmptzs=;
        b=VLfa1xOgk01S0I2L6YD4aRtKIaQinZJQojLMS+83TLQgeFf4npsXh9E93ApIT1LL5/
         hawKrs8rZBJJwKbQsQR8Nnha6DM89JW1ZWX/Uoq0jRO2sVwiT/Pog1WwGuYlV19Sttzp
         XR64xo1TYSz8hSq969/dRX7Z/nrxePk3psYqiIo9eqPvhE7edxq/tVWtKCq6BoRbYVOV
         tvuf+H2uTkJDsf8612X+N6vE9erSzQZ89iWpSelr1UqSlXjiKwNPCVTT2E0bw7YQT/Or
         RBBQwHsAnwF/kMUCpfzfj4zG5aTj8scSOR3dEGkbmr3qIpuoAkGIQxDhhVqusX8BC10J
         0EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823857; x=1786428657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuDYSjJQEMSMyuu+bbvopLn43BBsmPMFs7o1wHmptzs=;
        b=mkxk9H12UcmJFIDlH+Ve58L45fVhtTiN7TA8TsTTZSUm2yi8gfFeyXJuQD8FlyRwQr
         UAzX8VkpX4nRyHvnLx2FPBqOtvYV0OC6S3La83HmklCtr8k5o9OtsyKAa92BzfWnVzFQ
         4zuPTyFZ+R3eot3k7Y94MPeTF3Jv4MQ+Ub2sbrZujoa4tVaSoyjlZ8rqLAwZ/Riw4Bhz
         WKPzUNHeO8gpC3GzGuj7+5Zt4Ewf1DUWEZpvYacdCyh4iiIp6VRrmK+WgJgcyBChevcF
         PgoQzTq+mPcE2bEVqZv5oR3DSgsWnvtINjyw3DiYVkE0cGWriDc7BfGTbnhX9wnMkSn/
         DLVg==
X-Forwarded-Encrypted: i=1; AHgh+RrQs06Nq0q8k8Dz6N5EoPY8P2zEOE7aGXC8DBnS+MkSkgABqJGe3J4APYPPi0drP4Gpeo/2E5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iwfTbJpApeLpqq7Sd5soV1Evg0a2LrfI4TUQqLc1srbuJRkV
	T9jazGJhunnh1E7i28dUc5GTN8xukClDqNyCRHtb6VK8vjuCz9O9P2gqizFOJmu54JuHufrAJ/z
	eIwml
X-Gm-Gg: AR+sD12D87dSOSIjsmSyDEisCimcOy2ZjdcXSHCMtHM9JnqbkyHFeUo1azcqCDvrv7m
	MdCfXQL/U/oQyaf/cIJlxprMa/49jcUDXrlRZN3t60gV2xcUzJvp0YxOE4mcS2TH/+xfyJ+EOUR
	enDVB0jzaZIPHo9ceQpsJ+aiU6VJdbY1xcmFXQcMroTthGn6Q4kh9EpmYiASOO2GmecPIrdk+6S
	vDYqkAmcflFZGiex1X8u/f4zaAeR6gS7yY8gKTimVk6EThVobmixRZ87geDM9Rvms+hdezo4NlD
	pRsK2s6Tn+9L09AzAWym0ZaMZ2on6caC6c6YCA5radgijXTHNeMpo+hRQXA7Ah81NZt+0cX4SbT
	gPh9SXJ1gB1pI94QR2JP9MC/dgvWc8F02oGmrrqNvQxPG+G3/QMLWpCi4zPL4pZzf41kPp1udfQ
	2ZHGINWnNWz2QW2gFU8GCbF7x0vGO/5MGmLPfHJbDf+VrIKhbF3Na3LXER0QRMMAFegQ==
X-Received: by 2002:a05:6214:2f02:b0:8ea:184f:c15a with SMTP id 6a1803df08f44-90849600a6emr294349336d6.17.1785823856908;
        Mon, 03 Aug 2026 23:10:56 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908435eab41sm92617856d6.34.2026.08.03.23.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:10:56 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	phil@nwl.cc,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH nf v2] ipvs: clear IPv4 options after rebasing tunnel ICMP errors
Date: Tue,  4 Aug 2026 06:10:55 +0000
Message-ID: <20260804061055.711402-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

ip_vs_in_icmp() rebases an skb from the outer ICMP packet to the
quoted original request before passing it to icmp_send(). However,
IPCB(skb)->opt still describes the outer IPv4 header.

A timestamp option in the outer header can therefore leave an offset
that points into the quoted transport header after the rebase.
__ip_options_echo() treats a byte at that stale location as the option
length and copies it into the fixed-size option storage on the
__icmp_send() stack, causing a stack out-of-bounds write.

Clear the stale option metadata after resetting the network header.
Keep the remaining control block fields, including the ingress
interface used by the ICMP response path.

Fixes: f2edb9f7706d ("ipvs: implement passive PMTUD for IPIP packets")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the nf tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/netdev/20260731140822.567128-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN stack-out-of-bounds write in __ip_options_echo() and can share
if needed.

 net/netfilter/ipvs/ip_vs_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index bafab9345..fe06c380c 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1951,6 +1951,7 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 		if (pskb_pull(skb, offset2) == NULL)
 			goto ignore_tunnel;
 		skb_reset_network_header(skb);
+		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 		/* Ensure the IP header is present in headroom */
 		if (!pskb_may_pull(skb, hlen_orig))
 			goto ignore_tunnel;
-- 
2.53.0
