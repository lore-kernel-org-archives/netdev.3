Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232530;
	b=dASCAihV9DgGkKq+KajV0ENQua79MtNnff6+O2U+J0wx/MtJrlOVJ3J4Ky3BtINc3wXY
	 WqBU458nGfrYQ/m6+yCHV2vggErGU+l4UYXAIsW0RDcJCipRqBsjatXsm0VdhvUupxfx1
	 QLqotxiuE4HFBzBG6VUKrGaoSNxu5iLGqm4UBdOzzWtrBWF0MWCZp4JRwKpdEUVycm8zM
	 /QGTDL0w5S7qfAdWtnE8exR4f5Ams2b2HV4zfL0IOrfnc+ZGURsvv9FHKLLc4uVarwpzw
	 /8lQ4HVRYb0tPnWKS/xcbRvH9dTv2lAuQE5ZS0Pm6lGJsC2HXhhIbRIwriAF5KAf8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232530;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=jNo0Pg9G71zV33i6nKyHOlWmCvOH1jkkUoKVtsgrRpM=;
	b=gMPCyaNabOhAklfElyRst1O7lUhzh6EzqaHVXjkeyxBgUEvo3jXY6pLoFgJlbLRGPKEY
	 zXwEgjFH52S0lkktXMAUvWRIZR6Eo81/IhMwYC+TlLrhmCmi7M8CaHSj3jwlJF1bAdTtm
	 YaSAPWYnLiu5HaDmbVr1rixHj7fj70xlq/lkcLNlICJ+d75Iv/F/DwWzgPLR/R/8bJ7O1
	 4LYdqJqDN3l7UErQcTQ9fF39vlBMXkQQa6s7Sc7j/Xv+h+hDmFaOlBjyz6V8omkN5vmrE
	 67HBUN5FCyZpZxEZ0ffShpPCqLy/3MPPojOJqjLmTrUTIK0L9SHcRlgmlZ+xjCouXzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="DdRnU/Tm";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6104606A325;
	Mon,  9 Nov 2026 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6104606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=DdRnU/Tm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=jNo0Pg9G71zV33i6nKyHOlWmCvOH1jkkUoKVtsgrRpM=; b=DdRnU/TmCTwBvrW9zY245z9ICa
	AMV65o6TFBCJc9WHw7LNE8ncZwEcDzlJC9Fj9nN+HBV7sOlUZjTCIc1tbRJHkSAxUIVrc6G7av8Q1
	pyueLillmZudx2mkipRejBX48BOQrYwLFsc8bskItLZUerYzhfV+sRY4qft3t8lY5Vbt10DDyj5wj
	LHvfbgteRmRUyTP/YmZuvvbSHk3IqUhBecx98XWUI9l4sNJKpAmxi0REQ/raIYdeBZu3GCwtXek43
	KrCkqxtOBMJExP9oAmB/oLHEedL31DAA5eh75gYtgRzzGMYSuOg7B/5sM4o5H896fMLUWPnt6ixuM
	FkznNEYw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPqJ-00BfYs-3B;
	Mon, 09 Nov 2026 13:55:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 05:50:37 -0800
Subject: [PATCH RESEND v2 1/2] nfc: llcp: widen getsockopt value locals to
 u32
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-getsockopt_phase3-v2-1-d0f74c6e0f37@debian.org>
References: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
In-Reply-To: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=leitao@debian.org;
 h=from:subject:message-id; bh=OfphTqFg7Nmjij4FwHxglEG5+DxC+hUzIcm1uFWdXQo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8dDHuTPj9oq/fCgNaUMBWbMK0SJL2xX7qyNiH
 lSmVX/25vuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHQxwAKCRA1o5Of/Hh3
 bc56D/wN1n5X3Kq8/bIAYjqBQ/elKfGi4p24LqKf2P03I+eI5tKYFQuRjezxVVfwNr8m0yH3tvQ
 bskx4LSSQQ0SYyL7C/AGhVybThmoaSElXnC5yQ6Uozr4TIrF3c6ABcZk4QHda+rZiuV+Vmfnrvd
 j0A6gkgXTo5wHKPhP03SNhFk8qhMlDJXXA0Avn2vxubc8mwcl9+9Z+vGGtwfprMb48u5RPSqob2
 BLLsn43el+SPhGIC3ga/iazeIW+eFb++mxMAiPgmL8z1lba6BxmlQZVoCX0BD6MwOJHxQ6SPJOi
 ORc/qbQ29syh/nKfR2BOgGt7BJr7QrQvFT0P6zyZ/60OzUQPrpVhei8BEFQpczbRc+rJh06Q7Fl
 xbysuzIginKKGfVfTxbBrDLfIaiZDTETrijUkqnynUWA51TOL1OG1t2wXONDAcKtj4bbyzuZVtJ
 9vdyyDYZ6AumBt5ddZ5Fd3d+ptkxosfngQE60f5e7+W3PNKUTK/CmgPl1U/Jsiyxqc+TS6dyqXY
 s/HBAGrYVwQt7SITkrZaJU7rfRq2HfVaIFucjrmGCD0XErEGXVNrqS6rUfKp844mnf6PjNwWB9u
 YP0mEQKaX5ZG4j4ATR7a4sXVcbfD+qp5gMVgl+nTMfTIChR8KtukbJ+mJQijcoRy0SVn3jqNwFo
 OKN4DubPHngAASw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

nfc_llcp_getsockopt() returns each option as a u32 (written through a
(u32 __user *) cast), but the temporary variables are smaller than that,
and they are promoted at write side, example:

  u8 rw;
  put_user(rw, (u32 __user *) optval)

That is fine, but I want to widen the rw/miux/remote_miu locals from
u8/u16 to u32 so the following getsockopt_iter conversion can pass their
address to copy_to_iter(), which expects an object of the exact width.

No functional change.

PS: I am sending this as a separated patch to make sure this conversion
explicitly reviewable.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/llcp_sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 1e5ee4bcde684f..adb6e06229b4af 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -308,8 +308,7 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
 	int len, err = 0;
-	u16 miux, remote_miu;
-	u8 rw;
+	u32 miux, remote_miu, rw;
 
 	pr_debug("%p optname %d\n", sk, optname);
 

-- 
2.53.0-Meta

