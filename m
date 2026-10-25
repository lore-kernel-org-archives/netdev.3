Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949736;
	b=2e0zF8AJf0e/qHai0d0MTeqis/1Yfe67LOHqddKtH8RBp7u0p7PK7+Yo4VBu6kTLUWed
	 cSS8ecnmrNQB8u0D4QaC8cR/g+5qlc1DKbR926sKMl7OsylxKcrBSt9ohHpaKFb/POLC6
	 Zqxj4ttgwO/9+j9Txy7LaUu83VQaOpLP8o2e/qxMVuXZGxC6Ivm9jZAlA6zLbEwHvGaSu
	 WH1g1vZpCeMQzqBpEwAd8laLSD02XuFhBOb41WTRrJ9ugV4H5HPdoBI7Wj88hNoM+fglH
	 QskmMkDOh4odjFDMZdaP1rGjELZDTgZEL6tSQbyBJ9xL/Jp+l9Dnu0IgpZKKx10Eu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949736;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=IljHuoY3NfLTPuir7QkeAIfGZmv2QDd46M9BpJxkdxg=;
	b=3+1MwHriB3n+xoWp4OQ0N5DsU5EsvA60nzgStT2xnhHXQY9wICM8nToUl1C1gmajRMoM
	 CiV395/ue0PrVo7+WYq1P4yZBCgY1uNbkip07UuwvTcp6M0DumTmEChVlaHqujgtHl+me
	 Ih3I37PbBHwCQvhDkdsnW9XxmxmApy81KYZdRVUbuFMlVuKk7w9fpO7pZ9obGfHvk8s26
	 su0MIUvrjmymlnrC3ndtDJtV9v+xIptE62IbwuWfT507UmkI1V8YNsoasHiP7slK3pxsz
	 cKGm+ZHJPDgbTOX7vYZeYLCcAITiaNCgogbfX9LuC7FEYzo4dUQ58/cKml3T+bLRmVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iWQugNDp;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F408606A31A;
	Sun, 25 Oct 2026 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F408606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iWQugNDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792949729; bh=IljHuoY3NfLTPuir7QkeAIfGZmv2QDd46M9BpJxkdxg=;
	h=From:To:Cc:Subject:Date;
	b=iWQugNDpeLI36Do3TOj31QjnUbo5sMo3+NycEJ8B7USkx7vRzYTGZa3wWTs09taAL
	 uRS5w57bt346oF9nzBulmoPz92Vo6h47ELwXUa754FZP9wP8RQMmBKb1DyKoKCclHQ
	 xDKUHl2XxNTuJjRbXr2cAnX2ddz2Vd0uqLz13Dlc=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8DB24473; Mon, 26 Oct 2026 01:35:27 +0800
X-QQ-mid: xmsmtpt1792949727tndycvwlf
Message-ID: <tencent_389453EACB37DA0886D3896959D4A4CF5006@qq.com>
X-QQ-XMAILINFO: ObW7A5NPm3QRvVX1A2FRWMO4JEZvffrbPSKXzP70tM7dhuCbGApa95EFrEn+b3
	 MEEMvFY6tGDka/+R1043kUwH7HmdwmQDzboGqquldWB7tsVU8XQX0ONL9I42hRCuTQCcenQUyTlH
	 ZM9qa802njyOaP+UeU+3JWUNpLnv/Ox1sEkQ+OQPo5G8HLGV0t+hnI/GhqQHAV+0xfX3UeXmju7J
	 +znWOZQhZVSUiUseL6w0hFdQcmRUboTop0BrEj6cUymcdliv3kMcvTr2Fyc1KXu6deOFtnNf2GNl
	 xxgrcfR7YeEKOMjtXzUlLn81A9Knzt+E0+YQ2reTVj4Y5E2w8JukVRuSk5mYLzfuHavHCHkcQcid
	 n9CdPlUjSeI2lyUjeoXdDejRmNG6TdSTv7t1zvwwHYIy65C6q814kNt6vo2du77f5J1JUzCu4uqn
	 Txwd7ojiG+6KYKYzGxUiP3YSlUSmPw45sDfibEI/2Y0VjX+vGBOnKy3i76oTndY/aKFEE91KGXob
	 dqUoMHjQ7eQrknn3e9neftWrRz5hsFIhwrhiolAfPm6RaCmSJEdSxw/3Dj0iVpgJ+++5KvutuGdw
	 vrnPuevLobuxy3VNEtLZje/FwMse9gGRwsgEFCOtQ0wJIwXG3Z787bb8YVxyIN/LN3/TpWaKDCIV
	 seNGPX3sy0t/kkmeFh69D0n3Y+JjWaErN81tN5dMdAUhU5qtRpB5sWnyBBSQKcZ+SfUvnFK6Wt4u
	 ueZEIsxBW7h+GfTTcm7N8KRVfjVEMPbICePjxYtPJNurNvlNd2udF317i5fnMmU31k5ssTIpFJOX
	 5Fx3xfJh5E/0p/rTjWkubR3bb4f3rvEDeMPPnbWqOydCkbx2I9wkn1LviyuIlcKx6TagxzU01xEU
	 ukskrOpCdntzpHWzbxVvC2fSquwwV2IWlGorwqaRuOU8sHTW7emoqdGvmaiYnYFmjAZSg7ZVmtLQ
	 4zrFTDeQraL5WVPYrdfS8hTiZlBCt7b3YRW683Mag0Y4buFOS+5aI7Efm3jUvuvCClS0cClg+L32
	 sagODIrNXPH1/Cu+TNbZjArHvCMH/KlBVU8Ri6dfIEYBIxShC9
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Guikun Yang <yangguikun19@qq.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: James Chapman <jchapman@katalix.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] l2tp: OOB read in l2tp_recv_common() for L2TPv2 sessions with
 8-byte peer cookie
Date: Mon, 26 Oct 2026 01:35:25 +0800
X-OQ-MSGID: <20261026013500.41820-l2tp-yangguikun19@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Guillaume,

l2tp_recv_common() (net/l2tp/l2tp_core.c) reads L2TPv2 optional header
fields beyond the linear area guaranteed by the caller, for sessions
configured with an 8-byte peer cookie.

The UDP entry path only guarantees the first L2TP_HDR_SIZE_MAX (14)
bytes:

	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX))
		goto pass;

	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);

Inside l2tp_recv_common(), for a L2TPv2 session with peer_cookie_len =
8, the cookie check consumes bytes [6, 14):

	if (session->peer_cookie_len > 0) {
		if (memcmp(ptr, &session->peer_cookie[0],
			   session->peer_cookie_len)) { ... discard }
		ptr += session->peer_cookie_len;    /* ptr = optr + 14 */
	}

Then the sequence-number branch for L2TPv2 reads at ptr:

	if (hdrflags & L2TP_HDRFLAG_S) {
		L2TP_SKB_CB(skb)->ns = ntohs(*(__be16 *)ptr);   /* [14, 16) OOB */
		ptr += 2;
		ptr += 2;
	}

With a minimal 14-byte L2TPv2 packet (6-byte fixed header + 8-byte
cookie, no payload, L2TP_HDRFLAG_S set), skb->len is exactly 14 after
__skb_pull(udphdr), so the read at [14, 16) is past the end of the
linear area — a 2-byte slab-out-of-bounds read (KASAN catchable).  The
subsequent `ptr += 2 + offset` handling for L2TP_HDRFLAG_O can read
even further out ([18, 20) with the same setup).

Trigger conditions:
  - an L2TPv2 session with peer_cookie_len == 8 (admin-configured),
  - a UDP packet whose L2TP payload is exactly 14 bytes, with
    L2TP_HDRFLAG_S set and the correct cookie.

The peer address is not verified on the UDP path (l2tp_v2_session_get()
matches only on tunnel_id/session_id), so any host that knows the
cookie — i.e. a peer of the tunnel, or anyone when no cookie is
configured (in which case the OOB read does not trigger, since the
pointer stays at 6 and the seq read lands at [6, 10)) — can send such a
packet.

This is the L2TPv2 counterpart of the L2TPv3 optional-fields OOB fixed
in 2019 by commit 4522a70db7aa ("l2tp: fix reading optional fields of
L2TPv3"), which added l2tp_v3_ensure_opt_in_linear().  The commit
message of that fix explicitly noted that fixing L2TPv2 as well would
require refactoring l2tp_recv_common() and was deferred:

	To fix both L2TPv3 and L2TPv2, we'd better refactor
	l2tp_recv_common. It's complicated to do so.

L2TPv2 has remained unprotected since.  The in-function
pskb_may_pull(skb, offset) at the end of l2tp_recv_common() runs only
after all the header reads have already happened, so it cannot help.

A minimal fix for the v2 path could ensure the header is fully linear
before parsing — e.g. in l2tp_udp_encap_recv(), after determining
version == L2TP_HDR_VER_2 and before calling l2tp_recv_common():

	if (session->tunnel->version == L2TP_HDR_VER_2 &&
	    !pskb_may_pull(skb, 6 + session->peer_cookie_len +
			      (hdrflags & L2TP_HDRFLAG_S ? 4 : 0)))
		goto invalid;

(or a full refactor pulling the cookie/seq handling into a
l2tp_v2_ensure_opt_in_linear() helper mirroring the v3 one).

Checked against 7.3.0-rc7 and linux-next (2026-10-24): neither carries a
fix; l2tp_v3_ensure_opt_in_linear() is still v3-only.  I found no
report of this specific OOB on lore/marc.

Best,
Guikun Yang

