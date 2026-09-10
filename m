Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E63F4DEE;
	Thu, 10 Sep 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033672; cv=none; b=XCjwCSLb2HIcCCxP2VK+9w3bg3oxBptBe+5RtEwSTcbG//JEfC+D2gb80Z+L5NS2cjR5/21MSsRqaDmW3CEdzfUEdOtIJU8wkYtotjgsq0x2LOYIuZNVVsUbfkjF6rzYn0wLeF23426DRBSncJFuAxAg4+uopfIUuQuYg8VlrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033672; c=relaxed/simple;
	bh=gHO8UgOuCl0eHKHC3kNoLJRIjt+ie5wybiDF47em32I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PboMcGrdR7pTtxmg3pMttAO2SI03TCTbRIF8Kxh4pVl4LMaJq0OeXYzmd0uARPSgQ7kL+fgc6MiExMX2iBoiMfby9ds8UtL3UJ3OkpME9x/H/HKFZBKg5nENF3tFId7SXtwWT63GiMOr33ArAZ99OzMzBFWQnhedb9q5w7d7XCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QwcNvRRn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QwcNvRRn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=gc5ghzgKomYEE6Ba3WNJUiyNyoGr7Ccm2qY8TWkb+1Y=; b=QwcNvRRnsRshy/K6lA+ZeDq8/z
	7pAiJyFd1yUwk0/OLXqsLy+PKD476FlWyDs+CM4hRWTEDJzxL3nb4rBAGwGGRC2/vSQt0phxXuqHd
	dQ2XmArTaXyDvadIkr/imPdpT/vBMX8mz9Qoh7Q8AgIccLMuauZsil/AA7jC/iFacMgLC6cjNfvSL
	ZDPHPYr6931eNbOjUWBZXkoy39sdWejGrzlUkHGmrxY5kvb8u5pI7elhCuddCteoujo6QXxeZriOB
	/9VJWGDMR+vnq00MyQ9ZGNdLnVN71tpsFTY/eluHgT6GWKa14g5bmCy4ZAq6i/9y0TqN5b0yZppYS
	3ZF5Ac5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4bNQ-000QMu-1a;
	Thu, 10 Sep 2026 09:47:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 10 Sep 2026 02:47:11 -0700
Subject: [PATCH net-next 1/2] net: add sockopt_expand_out()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
In-Reply-To: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=leitao@debian.org;
 h=from:subject:message-id; bh=gHO8UgOuCl0eHKHC3kNoLJRIjt+ie5wybiDF47em32I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqonymHx3A/7DdiwcdoUhiolrPSlH3oHyUbrcfv
 j3iEZVHNqeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqJ8pgAKCRA1o5Of/Hh3
 bRAgD/4/zxv5PKYKrKwzYS9NAGyF1K5kPc9Cvmh41Z+EjwlO/VOVqLq/1CmInTOXrM0+KgaVUYS
 x/oPvtQee8uMzDSpyN1ISyKJBoC/XoLQLKmD455R2HpJ/oXs5acbyf1BW3XFYEM/rFlXMWepzPC
 +DS9zWXSp7hxWfPUfMt26sP81e4xWOg1mzqGlwnhE5dUUU5M83w8aYWPompAquVdMEi53urRtlj
 eISE2zy4uA5or9p3cahF3Z6Ep0642mRdTVgNHhUePNvgVkcHCqRADW5kEJ5WEsbGcrEjtowHU+D
 G78AVcl0r4fyi/Qsl6QeZoaaN8uHM/A2YEuuC4oavrvPasE3WH3wkhLsF7ci4V65EQt0/VPxlph
 fjeMoiM35FVNdgq1Bg5XReh/TvF81zcoav6lwyqanWD5xER+rLKtK8XCf6kc4hKKM4++vTnMMvY
 WP3EaFf0K0TBssVQ/MYdrWVEAmp8+0Nscxid0hVTv4lU8iYd7U/TMnR2dSvVRthzvmcRpPy9kGi
 j4Mt/WnivOlw0ViGz9F8upk1+6xq31rc+5GS+m3y/CpFYW8Os/8RO2jeQ82FCx5zE7H0pA9deG/
 TXJ7kfX+ld4kZuQpUyBJ9q5vqnj6yS+ID+fXizHVhd656+GrbMzzBlbi8eb3h+nH7NfM6IJEPEB
 61YlEFRoV+NfKlg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add sockopt_expand_out() to grow opt->iter_out mid-air.

It is a no-op unless the proper size outruns optlen (i.e, some
not-well-behaved userspace program calling it).

In this case, only a user buffer can be longer than optlen says, so
a kernel-backed optval keeps the bounded iterator and the callback gets
-EINVAL if it asks to grow.

This whole quirk is added to:

  1) Avoid breaking userspace
  2) Making the quirk explict
     * Instead of protocol doing implict assumping like this.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 25 +++++++++++++++++++++++++
 net/socket.c        |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 470100ae710773..de0ed362b37794 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -70,6 +70,31 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
 	return 0;
 }
 
+/*
+ * Grow optval to @size, for the options whose reply is sized by a count the
+ * caller left in optval rather than by optlen. Those write past optlen today
+ * and userspace relies on it.
+ *
+ * Call it before writing through opt->iter_out: it re-anchors the iterator at
+ * the head of optval. Only a user buffer can be longer than the optlen the
+ * caller declared, so a kernel-backed optval is refused with -EINVAL.
+ */
+static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
+{
+	if (size <= iov_iter_count(&opt->iter_out))
+		return 0;
+
+	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
+		return -EINVAL;
+
+	iov_iter_ubuf(&opt->iter_out, ITER_DEST, opt->iter_out.ubuf, size);
+
+	return 0;
+}
+
+int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval, sockptr_t optlen,
+		       struct kvec *kvec);
+
 struct poll_table_struct;
 struct pipe_inode_info;
 struct inode;
diff --git a/net/socket.c b/net/socket.c
index c05d86e63abf7d..29a0f7f8e2cabe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2437,8 +2437,8 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
  * It is important to remember that both iov points to the same data, but,
  * .iter_in is read-only and .iter_out is write-only by the protocol callbacks
  */
-static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
-			      sockptr_t optlen, struct kvec *kvec)
+int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
+		       sockptr_t optlen, struct kvec *kvec)
 {
 	int koptlen;
 

-- 
2.53.0-Meta

