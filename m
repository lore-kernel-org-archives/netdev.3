Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C63101D8
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860995; cv=none; b=G33z9ZDa7QdoAFFMFXD9KUnihSLv+EYYJpsASOq3GOPjGT7KzwCua6MQj3K/G20bnhAPPDMEBVV6L5J+5dtnlKR7qIc33f1xDccbXQmKC4TQG2U3uTi89Yfb1t8C0I/65cXVYJs8yo/wG8cn7voI4HtaP+FvadNGLUfmUa1xd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860995; c=relaxed/simple;
	bh=z6wUJkcK3a3hmv5kqjzLvlF/m1n8D4xOw1dvhkAbUtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYpm1dR1Maz80sneb4C6VLD3uvPwosU02AKryM9ZT1FLTLDltAEHvFrvLVOC9/Kk87+ixTdHzHoVfcylTg8UFp9lje330sLxUrKWz6j4KTvFID5km3bOo5b6UsWLEJ674wvGyztQ0mcgNf6SQNfSp8nOLKIBZ3vPry44hVL2voY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=j0ChbRs0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="j0ChbRs0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51784eb2ba0so27692271cf.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780860993; x=1781465793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUmFtnwXcLgoMd8peK2Y4+0rrThIeVZcm4BZaIh1vuU=;
        b=j0ChbRs0MmgtWNNdxjn7tYKaMiRXOtQdkAqZ84VOup0Igzwk6aZyKTUWKcVlLrOj/A
         8de86UjdZY4aVIce5cMH0P43dO9haTk0DQ18rsfuUI2NM7NzeS1p0e3XfP8Q9PjmBa5+
         oCrurPpo5dlXveZJ9V7oySAqXtCe49oCvqu8L2mReEKWpiKnSv9e6fBOnBfBWy3V047p
         BSv8vpBpcPcibGoIxBArvQiOBOuT3qOralKuLlHwTsNZPcqpwv3V9U9PYBlf90hAV7z8
         +qprIGd3qlr8BXHRkkEoVpah5rsO+7AmR4SlHgP24s/2DMBQqV6GRSCmv4zx4VlTO9Jv
         TZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780860993; x=1781465793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUmFtnwXcLgoMd8peK2Y4+0rrThIeVZcm4BZaIh1vuU=;
        b=bksk6FaY86BgjX7W5m6KPU0Ta607TTJo292thxxTjJZVb9EGcNynYHxcWJdXX2JPum
         a+5b59puYzvNFJ9E4BgYQeeEtUJF0DGJpv1Byblufh1IrL0vts8qHmOy/0fJos0RAPvD
         Tjb3m4jtuVTpMOu/oFs1FjQZhHYknaQ4AvPJS59S5bI05JzW0Kk/VU+UcMCT3zXx0SwP
         4x2466CV48LgK6MIL/d8+soEzf4cHW6YZvwk252L3s4FQ5XMJUpoPV8hT+dCsgO7PU3r
         vkAJgtvZ1U+dhzzB5SXniysj7Zy4Fe8KGQXRMGWr5wX+wELJg2dIRKz9/hzdGPXvuxgl
         1bzA==
X-Forwarded-Encrypted: i=1; AFNElJ/wTcP+b0+9lS+y1ogzrI1KTJnRTQICR0TEIBG9S6mH0PIu0OsXgMu9D7uyxwNqjDFiNkz3b/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehF9CWUiL8Avc9bRTq6TGX/yXYpdHzwb+kWBzCFFZLKRVmS3w
	sy+WbmF3jAfFxZVpVDAyatKc0DCcJwa8ToUXpAKNpPEw1Qja/tQfCtN6b2eFWllsEN8=
X-Gm-Gg: Acq92OEN4KbrTGiENsu8eCNORp4IHu1xpUv9IB6HvHMscMecEJgN407og5gOIRD2bO8
	jmFixCcFE9MbIYVLjhgZL32gcN1GMuwwKUMf5vQ4So2ep+he8VTlNardXfZ++pweZvbDVDJA0yM
	uz6M9lvOsIXwAzQaOtODmgw406GDA9CSHdLHFDP+rhk0c/kaI+q0wkCplJtiiPXVvpTCHYXWbUu
	K9e7G73/imhtOAecIUW6Gsh3mqSvXVnMEky0nCOEUj+704ivTiWBMSEwpjN2VWq6MMIDaHMRCaU
	9a4v0JP3QUM29qxcKvNJkIqLNNgFefobcbxspIDkdWjVNoSrnf0nKRv6WwtYKs/B47AQyiVp35I
	0OwBNCL6vggZQT0aaz48Dz5va3868WhPdzWWQnfY3qnU1X7qhILrM1qVsahiZceyTteAtWrV4/u
	kxRrKTahvJPyzBOwC2jqkmDalZk7Sktv5vRuxtNA==
X-Received: by 2002:ac8:7f01:0:b0:517:82a1:351f with SMTP id d75a77b69052e-51795ad2ae6mr181641731cf.16.1780860992885;
        Sun, 07 Jun 2026 12:36:32 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51775c4d7absm129790711cf.11.2026.06.07.12.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 12:36:32 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net/sched: act_pedit: require matching IPv4 L4 protocol
Date: Sun,  7 Jun 2026 19:35:46 +0000
Message-ID: <20260607193621.1057618-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
header fields without confirming that the IPv4 protocol field matches
the selected transport header.

That lets a rule written for TCP or UDP modify unrelated payload bytes
in a packet carrying a different protocol.

Verify that the IPv4 header is long enough, that the protocol matches
the selected TCP or UDP header, and that the packet is not a non-initial
fragment before applying TCP or UDP extended header edits.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2
  - Add check of iph->frag_off & htons(IP_OFFSET)

 net/sched/act_pedit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bc20f08a2789..2730accbc56a 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -17,6 +17,7 @@
 #include <linux/ipv6.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
+#include <net/ip.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -341,6 +342,9 @@ static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int head
 
 		if (!iph)
 			goto out;
+		if (iph->ihl < 5 || iph->protocol != header_type ||
+		    (iph->frag_off & htons(IP_OFFSET)))
+			goto out;
 		*hoffset = noff + iph->ihl * 4;
 		ret = 0;
 		break;
-- 
2.43.0

