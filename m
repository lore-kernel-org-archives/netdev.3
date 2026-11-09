Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212667;
	b=hhmg7uN/i8k4X4WlmQpOdRN9PYR8/E+Z5qPmylBjTa6K0lHoutuHcPs7Zi0REZu/wRSG
	 iOjf0SCPk0P+rBGcg3oiY/xx5wmhLp9m3b81ipHMzPxtiPs3DvMfd5Vo2eQrUjthRMUdb
	 G08OccQ7YUqlwGGUeHLptTs/tW7XxwKKKUFxWsUPJJiCkjjfiibOK+JYLVAW1L6tYvydP
	 lIUckehPA53ZOtbKxwvb4+Rcp/nxhPWEKjAayScXK6PXemEJbKdlLkcfY4ql/9u69Rhyw
	 j7c58unsWpd+C1uN/wOSF0L43Lqs8eE0+6n7cFhqlPF4yItdHdWg2Cg1fDS82QCq5rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
	b=JB1RHzD3pkDRSlFZ3fojYje8rT9UW6c1yYojpNu+lWJMhqwjOhWWokllC6MlRqLkLjyX
	 mCVaHbG/QtDb1vxUs+9VW2bSTAuI+70lf1T4/OfpD4Yc4O+D0oLAEh1SUq/vsp4MZpKXg
	 BBMyLQo/lgL3xwm0vuqcFqecciz0eOmK6/cBRNKsjjxeCLm2KoQgItkR80fvRhsDLlmlK
	 jJltxN3RrabmRMN6AI9Q7+uKR/Om63CIYKGzbF3FnympH3FOhB7s85q8FJfQHnNHidAjS
	 IDEGHjuRW9BahXrXSOvuOuWy7F8MPVq0q0Lp9u9slnVendfGX3EJcNIok/Ax7HfDwAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb7gnq7H;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F1606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010F1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jb7gnq7H
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso835951eec.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 00:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212666; x=1794817466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
        b=jb7gnq7Hqictrz3L/FLiEVrQ+NRlVrpet0Uz3+I7cxsNZo5UwtsZn0rk2VLcEv+rmQ
         enOG9HdHEtnqIwS7VOSazpVCB3kTEIHhsK4+F0MWqiBaw3B90xJ0M1AaHDx20CKhiS0o
         iV/OseRs9IMuLBWhLgfKe+fD8igMC+6uYV7ncvIjfpuviudWymzGh4C6XxSv1tm6QNbA
         +Unu0mf/Ws1sFiThhU7RApWc/2GQejxOkIe3EOWiWqVFymgDOQ+vBuJsTKx1FqJNzP9E
         FEux7mrRTiDKTPEkI0GRmh5ZjZXm0JcqvTrpQRK75yQ5Sve7hbO2OKLKAqh0f378Bniq
         nqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212666; x=1794817466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgRFFSuqTaLzsyNQiW1C7k3T12ue183QKOBEGRFvIJQ=;
        b=hU2GMA1WtLpjkl0loa1BO+R+o2ur+tsZ77JZM+5QolxnxP68ODJwwZXc6vh+JB+rz1
         Ee58VMpkgSOXkZgZ2BSDmirtT1UdjWMl1KmGSH1iG4m0Y+PNU51Ogbch6zLnUz2qzNOO
         hgBBslZpTSvBBxbgdNq10LWkSYPxHeMvOC3VVufSNYLelx96svFfC4vZmkT/pZ/zVMtP
         H/EejGUxlGVnkKN+MI6tDYUCM0FkohllginQqV+/rNWp8lPh5TRHAN8jG/S6j6a1JePj
         UlrGeSWuQ2G0Ip+bamGe9urx/H2JuoQaE2ZjwO8ktpHnFo1lKxqCdzznowXev45OW6sB
         UQfw==
X-Gm-Message-State: APuU4Z/AyIAskNk9+YH+FY+62eAuWCSve4ff+u2E5rX3UEc6aTHNxSAu
	W+8yG8K0tj026AocB6xvJoURwsEGVt0elbYZpa8k/6nTqjnL+gzfdv1NdoZfR0dj
X-Gm-Gg: AYBFou16JG0BHuqZDzkzVPK1KOXLYuKIfzjdQ6Fnns41rXyY67FMYBhgC0Ix7ukYFG7
	Qv7iu5Zlrr6KGjX5CXh+my8ivrZ7CNgp3IHYQOkDxKsfuoAFURfaJ0S2ZX8we98cdoxHbq//OhK
	TN0dgxwza1lmRAhgNxQnRSnxwfphoep7kxRVkBuk8bUuAdrK+RyDkZ3KSQ3evS5xV7VniyY7XCz
	rGKd2quMMoOYBHlt4Y0tqF3hTOlB9CQvNc6HTBYxC9EE8RXWEA1s3owNJf4qjr1x6kGsRAPoIu/
	xivWliEXabMETQwmHCktY5m90Ux4mpYEL//pWy08qCp2sT9WT6LcRSeLb3F35JzZY4ZZH2WfFSm
	glUbe7Abxzp6XgIrXahQiEqEz3bHe5ESzQIT1LZOQTtZhppzuaFj4bR7p66ECqjZhUzJ8Z+MqIA
	uD5mni3N7QlbtPhZVu2AV4E6WD/mi98ls8QDAG0QwxgIbZUFKDyMXMGYbc98VuBRp1e414d8AWn
	RXXbMx14AhLWwWfob1dpUKwzRF48LYr166RINHROOvc0dZr4QtbxPGLVHhmxxMsNUBgbCyABc0W
	xeyFRowODyY1f39HwN2n2T7u/VCTPvrNtzWEXBz8XmmmJqbFXR2GY1ctoiiQDUi0dINpbTpYcrv
	UNXPUQtzuoeRBNqT5
X-Received: by 2002:a05:7022:5f0a:b0:144:fd7c:84fe with SMTP id a92af1059eb24-1b39fec31bamr5133858c88.35.1794212666093;
        Mon, 09 Nov 2026 00:24:26 -0800 (PST)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3731487edsm12521742c88.2.2026.11.09.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:24:25 -0800 (PST)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: netdev@vger.kernel.org
Cc: Jean-Paul Sergent <jpsergent@gmail.com>,
	stable@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net v3] net: dst_metadata: fix memcmp overread in skb_metadata_dst_cmp
Date: Mon,  9 Nov 2026 00:24:10 -0800
Message-ID: <20261109082410.206140-1-jpsergent@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Commit 3fcece12bc1b6 ("net: store port/representator id in
metadata_dst") dropped the options_len equality check when converting
skb_metadata_dst_cmp() to a type switch, so the memcmp length is taken
from skb a alone.  When skb b carries fewer options than a, the
comparison reads past b's allocation.

Hit in practice with Cilium geneve GRO aggregation, comparing an skb
carrying 12 bytes of tunnel options against one carrying none:

  memcmp: detected buffer overflow: 108 byte read of buffer size 96
  WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report
   __fortify_panic+0x9/0x10
   skb_metadata_dst_cmp+0x11b/0x120
   dev_gro_receive+0x303/0x620
   gro_cell_poll+0x67/0xa0

Restore the check: unequal options_len means different metadata and no
aggregation; the memcmp only runs when both sides carry the same
options length.

Fixes: 3fcece12bc1b6 ("net: store port/representator id in metadata_dst")
Cc: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Jean-Paul Sergent <jpsergent@gmail.com>
---
v3:
 - Restore options_len equality check as a one-liner; drop two-stage
   compare entirely (Ilya Maximets).
 - Update Fixes: tag to 3fcece12bc1b instead of 69050f8d6d07
   (Ilya Maximets, Sasha Levin).
 - Add author Signed-off-by, drop Reported-by (Ilya Maximets).
 - Drop redundant Closes: tag (Ilya Maximets).
 - Add maintainer Cc list via get_maintainer.pl (Ilya Maximets).
 - Remove superfluous in-code comments and trim commit log
   (Ilya Maximets).
v2: https://lore.kernel.org/netdev/20261003005449.2675.3@jpsergent.gmail.com/
 - Fix subject prefix to [PATCH net]; no code changes.
v1: https://lore.kernel.org/netdev/20261003005449.2675.2@jpsergent.gmail.com/
 include/net/dst_metadata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3163f0..02fffbb85099 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -116,6 +116,8 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
 		return memcmp(&a->u.port_info, &b->u.port_info,
 			      sizeof(a->u.port_info));
 	case METADATA_IP_TUNNEL:
+		if (a->u.tun_info.options_len != b->u.tun_info.options_len)
+			return 1;
 		return memcmp(&a->u.tun_info, &b->u.tun_info,
 			      sizeof(a->u.tun_info) +
 					 a->u.tun_info.options_len);
-- 
2.56.0

