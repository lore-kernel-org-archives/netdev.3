Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EAB49620;
	Sat, 18 Jul 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399381; cv=none; b=d6FWhfIjdYX1Ch1HGWHCRCOgs6S6/L4EodYZftpKpjdBcv4RfrF+4Abdnr+LLpkEIAS7A7Bxm3sGg3LXbCw3s08nmusycZrQUBP1ToOIl5+s+/Z0+2uUvot808CmqcQIvuSgu2AHvP+elOfYd48kdf3Y6K/o5Wk/SaXJ1hlnGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399381; c=relaxed/simple;
	bh=i3V8YuiC7jRnDBxxkRaEI92d9XJhPemZnJwzDFzMNtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaBa1aCi3v3elDWO3lsR1tat1QPUd/SXDVlWcjxgZ0l8WDISjkuHCXfipqNchXIwLvJxtj/5zzBvTxJS2h+srCJbQ3eW3vz9oAyTlCFlEt78y+Bn0ug1byawNbrvGDG8J1gxRaZgc9sg9gKyaVcwUnSkkyLuJmCR3SthiUWx+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKZJcLi0; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=Obsidian.Systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKZJcLi0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 96FE91300159;
	Sat, 18 Jul 2026 14:29:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 18 Jul 2026 14:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784399378; x=1784406578; bh=eVSwRwV4gq1CimDkGmyP58qreiXT5DdHizx
	S+SUtZ4o=; b=rKZJcLi02mHo5uj09hiem/fh94u7c94WMd7O7F0QSe9BK76rsia
	ejB4c7Poc6D9mwucdTxQKmzAbEthNol5a8IxuI0C12Fuou6ARX9dgGgLPXHPtS2b
	mqxiMZHW4h0xRbulPcnm7SFWpw+SE4p1Qz9GZRDhrkxfUMN0G6JQfzO3TS02pVDf
	tLKSGxQvVn98sqA3Yu5GIHQkoQhm10bJdnAZmNpKqkf1A/hmSfwDmiz3AQAaFigP
	k9XHhrygVC723nZIygganDBIOoZptLZWUSEN5zy7wpEmsiGu8IsZAbukiSMWp9QS
	ggS18lnzKt9IbGPw+sqE6Hn5gsNdIWaYppw==
X-ME-Sender: <xms:EcZbajkBPwwHyef5uuxuA6g-NyBqMopvQh9NQhrRwb0DUJq-nKHaXg>
    <xme:EcZbatVa5sU5ktNtLDcS7wnd4SssaXDRfGJ4Nu5IwUS7EoSJRHUCNYPPLoM0G6Whp
    m4xiAYc-pHv8BS_ZFkOmBXenFI7uUkTVURU38MPHCJ6iG5QLmV4rac>
X-ME-Received: <xmr:EcZbanoV9kP_yg7C_v5EN0umDQrzZlCRQXw-HaFMcChgT73MqMhyhm9VbDUYdegQ4sTwh5isExCBnb58i3tO77GY1-mPZjL-othsFg>
X-ME-Proxy-Cause: dmFkZTEZhAfVaGPqA/ovo6p7apg+j8/VnMl4PRCJg1ZP9sKrGuNeiw7QYlzbZKq73h8b+6
    lYGybdXTY+p1GLB4wJaUf+Zx3fEp5Flod+pFPwPoTOlpyHpO4N++1ecSqZJExmVA4QZr8u
    j/SwtfTfKzc7Dg21dm+XqTcoUXXCLNUZANx0vvezrrPtDSNH2ewJcerffn+R8QvuRKnXA2
    EmuhirTrfdiFwjZUUk1mKhopBOeGn4iUfPMVx1dzWeKRs5gKgmjL9RFNm3wXY6b0gOAHl5
    7Rf0Xed3k4nIrSSxoq9zbMdG/ERD2qfC1fpCdcAsZMLbNNvs3QOqL+90YF207os5PvEEYO
    b6+CKrHCjMGEuMXbOA0hq9ceyTvRTDR6qa1N75XcTXvF0sCw2jDOcYOwF8QlbCbbOPEaO+
    Q+R53ydYJNYSNfZZw9vNRK9NIH3GUnmdwxMb8pSIMNWi27m44tGCX4ib8NP8MA7vBjvRcq
    0lDv6lMBwVQmADvpE9d2rgXEWOBb2RBsj3SVRjj5p20rzxqOz8rxFJhsyB8jHaIXJmJSE8
    mFYkZe5nI5eJUDj4ACFS88b45awSt7ONII5wfM/4Zv6lycEVbXDiDvKZ9UNOzSrPUIiAiJ
    a/MBrretTy9RWAOpUR0r0bSG07ly9/wGaSdMFnpIWrOcgLpe+iy7tJYOQMqQ
X-ME-Proxy: <xmx:EcZbauUMNa25NlJwOe198GY4fMQ2hYjXx0BunM4x1l21lJNeIVKucw>
    <xmx:EcZbaoEeNlx45mZSK2cXzMsMAAdVTcPCS9aN0TNtX1nuuHYDTZCPMg>
    <xmx:EcZbalDWJH3PsI4dade6qjJqQUfsxbkM-XzdMpCuTpw7L7c2pUBJQA>
    <xmx:EcZbaqxtchp8zdhtBCkVIkrAPVRd5Oboo9RUnTLArNW2OykvendPSw>
    <xmx:EsZbashH8yI9fANx9UsenquqgiQs-fQBeZw_udemaMn84Yojxhnfoa5A>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 14:29:36 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Ericson <mail@johnericson.me>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Cong Wang <cwang@multikernel.io>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] af_unix: fix listen() succeeding on sockets in the wrong state
Date: Sat, 18 Jul 2026 14:29:01 -0400
Message-ID: <20260718182903.2295560-1-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Ericson <mail@johnericson.me>

Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
reaped sk->sk_peer_pid") inserted a prepare_peercred() call between err
= -EINVAL and the socket-state check in unix_listen(). Since
prepare_peercred() leaves err at 0 on success, listen() on an AF_UNIX
socket that is not in TCP_CLOSE or TCP_LISTEN state (e.g. one that is
already connected) now silently returns success without doing anything,
instead of failing with EINVAL as it did before.

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Assisted-by: Claude:claude-fable-5
Signed-off-by: John Ericson <mail@johnericson.me>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..10ed9421e43a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -823,6 +823,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (err)
 		goto out;
 	unix_state_lock(sk);
+	err = -EINVAL;
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
 		goto out_unlock;
 	if (backlog > sk->sk_max_ack_backlog)
-- 
2.54.0

