Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487562;
	b=WroMTB5hEaLoX7HQ0vp9RJhCkyrLUfcxYgomZ7QlmJDHeUzDBkpwvFYMzlbjuXtmHcCx
	 RRs0wyMSXMqSOhV23oDd9U3JAtkPKQT7QX1bopobfCuHKWElrgB0kSKshKeQDfwnoi0Ir
	 Go+9xMGAzQD/Mi96TK1GoXdOe7RbUYf//zZJYPs1oFZD82BPJcZj/pBSO0OBcJK/O3zJH
	 1cky57YBYSUjb42zvJIITpVYWc9ONUOl2Vf7Nh0glrfrgwzivBegPMe0DL+tbw9XY4/rv
	 WTujEoyVbtq6uj6riUnnFqxby3e1JqjWRJn9TOXomQ4kyP+U/z9POVDY5v3+mLy1IkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487562;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Wi21SEvJ+JhjgzhMJN8xUXq49ACNscIoGBHK7YzAvJs=;
	b=WrFFcFpy6j2Zg1GpKeHE+fl5ySbVPru6MnsDVTkzdfg7BM5qCChZB/Lnsh5hETbLss3Z
	 iBtsiLMatYqT+ml8X/Oa5Ssx2tRAoYjkXI74JUIGX2DBqyw3gewow4yr/h/LJfXD8adHR
	 CgPjRZDBGjDuyUuY7Yz1aYL4anDGpHUB9Mt8/5XmtgI1of9Sk5/KiubbLiAhEroQpDby0
	 eGdw3c9ETliDhOpOyw2nj+kBliDfPWIPiKsiDXvJvLaebfZojzAO68oOIz4tBK1SMKnMR
	 nlR31cc59JzK0OJekzybs41ef1KAm0KGoDqUqx/TYV/CuckJ83+gT/6mPo3LPpUTVWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ly0lRfuu;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22671606A336
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22671606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ly0lRfuu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794487552; bh=Wi21SEvJ+JhjgzhMJN8xUXq49ACNscIoGBHK7YzAvJs=;
	h=From:To:Cc:Subject:Date;
	b=ly0lRfuuFRFdGeVDZkgC09lDxIqnEdMAqNc7UuvD72kFBrty1bBut9/AFssYWGAJS
	 yf6syxGDdq/w5b070aLoQgVh19rgd33S9HMOOgaP1LkukLrCoROIK4+CCPKfuecPMb
	 u5wQJt98i+9plTQzaqizzFYE7du5immang9lxsw4=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:e498:8f16:a485:ceef])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B70218AE; Thu, 12 Nov 2026 20:45:48 +0800
X-QQ-mid: xmsmtpt1794487548tz8cyzhk3
Message-ID: <tencent_AFD2C75757FA5BD9D0C583FD1FB1C2133206@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Jue+F2vLrGacVfcXOqtB1g6WWP+1bbke1KO03qiKd+AUbrQgF3Lg
	 T7IYYBLukakDs7u4OsY8YksW7Z4kHHKanUuL3gYGHz/Q8DlZ7sPZnZd3Dys78PIfBBGi8dHhEL66
	 +hQLVBAgMtrUWe2DQc9I4MyoclTwz+JEfp/EQGLmvy73zkdGNioqimRisAMyvtQ33D8WSSMVXZJ3
	 qDoWZq1eE8+9HcU875rfUPuJsLgsI33SvjeTIrwqr8FeHgOLfGxhYaWUCE/aqrr44onWuJcAutc2
	 Su8uyrGQr8DmTH4sQS3/7TfATfRNRrAPEn9eNcoK21SasIQRyVvutHKQoSLgWRaz1P6EB3sUQpWs
	 kOP1yKgONTQcD2qGT2r0CGkItTuAWU64hTA8baYB+L+XS/A+8UTBczL7Rr8RAiLL5QA01/lyCvfR
	 Ho3Y0mordK+D5mowmQJqfoY+CD5qsFFDVqQvQc5dMGAvS7FzHwNMiuFM/3uRO1kDdGvGSqbsqZ3G
	 u6mnlUok2e+paxzCy35LVovxf4auvIcPIPDl/x9dXRplMPpAhrRzstJFtaaXzwW+4lceZcUESbHd
	 rJD8S1A+3+c81J+amtL/mMs5EMTd+xVe8skv8MzDSHmN1fd7N1sXOub/CqRlOWocGmRfOCtkKsuf
	 hKMCcm57pk+hUW7+XT19nMJOP2hOmOwhlml2LKVx/WwgAHxncAxrAbzjL+CrCe6/bfDjjpMBvHDl
	 X4S5hnFBgapZZCAD2MPHhJ3C4tXQwxl7oD0EtPAJ9k6AtwzDNxKZjG9TfJaUNs7LYrI6KnJxgd7f
	 tzq1Njx3B6skV19dDdSAxlM7W4bofRgHeMYh/Kqzz2LcuLiXfNLFqoz6kzRpDeku/tNjAZ7LuSyr
	 rROOqwXtkpDZaQJf49oRQ6M1+J33bF/TaQG+TzlEbjVECPqEQi4LGzt6fDWl9+t53KmE8ubC8ZW9
	 2u1gb1ip+o/TtYaqGQ3fAgwieBteIqVtWXF8LCoo3Qt6xg7NpslXMUSjhK2BjSRH5yxPzk1aM+FP
	 g9oBquqW3S65P+1AyrZzeiTl2L5Lc8TLTU7i95LNEO5EkJNYV4IZko88KyouS1eQTx6SVD7rzWvy
	 s8aTvc
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	Hang Nan <2122295973@qq.com>
Subject: [PATCH net 0/2] net: restore acquire ordering for two remaining lockless lookups
Date: Thu, 12 Nov 2026 20:45:45 +0800
X-OQ-MSGID: <20261112124547.193812-1-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
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

Hello,

commit 5b5d8f351dd9 ("net: restore refcount ordering for lockless socket access")
restored the acquire ordering that refcount_inc_not_zero() lost in the
2019 refcount_t consolidation fb041bb7c0a9, for the IPv4/IPv6
established lookups, inet_twsk_purge() and bpf_sk_assign().

The requirement is not the reference itself, but the second validation
that follows it: when a lookup takes a reference and then re-reads state
that the teardown path mutates, that re-read must not be reordered before
the acquisition, otherwise the lookup can hand back an object whose state
has already been cleared.

Two sites of that exact shape are left in net/.  Both are one-line
changes and neither alters behaviour on strongly ordered CPUs:

  net/mptcp/token.c        mptcp_token_get_sock() re-reads msk->token
                           after taking the reference, while
                           mptcp_token_destroy() clears it with
                           WRITE_ONCE(msk->token, 0).  The lookup is
                           driven by an inbound MP_JOIN SYN, so it is
                           remotely reachable on a listener with MPTCP
                           enabled.  mptcp_token_iter_next() has the same
                           shape.
  net/core/sock_reuseport.c  reuseport_migrate_sock() hands a listener to
                           tcp_filter()/tcp_check_req(), which read its
                           fields immediately.

Both are converted to refcount_inc_not_zero_acquire().

For completeness: the other 90 refcount_inc_not_zero() sites in net/ are
either protected by an RCU section across the uses, or take the
reference only to pin the object alive and do not re-validate any field
afterwards (l2tp, nf_conntrack, cls_flower, tipc crypto...).  The two
conntrack lookups that do re-validate already call
smp_acquire__after_ctrl_dep() explicitly.

This is an ordering fix, not a fix for an observed crash: I do not have a
syzbot report for either site, and on x86-64 the reordering is not
observable.  Reviewers should treat it as making the existing
re-validation meaningful on weakly ordered CPUs, in line with the
accepted change above.

Hang Nan (2):
  net: mptcp: take token lookup references with acquire ordering
  net: core: take the reuseport migration reference with acquire ordering

 net/core/sock_reuseport.c | 3 ++-
 net/mptcp/token.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.53.0

