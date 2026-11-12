Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513651;
	b=tbIox+yIRufOYoF+cXs5JNr4OBdS/jF3TXLwBrUwL5J9KJPfzJ6MvC2IIftxskBJ6NOj
	 IoJuXcw6mnwGg1rUlKFdqtLWwfWVlNHkXwkRWgKwOnFIUYdhC99joVVP/MX0jrS76d8Nk
	 KHse61PaBgZtXb8OYijpvnzETkgdLGUWR24UKcyi/TLDron483Smxd8ZHo9QaeGpRQOBu
	 xl94bLPdd3f3E6KoXUaFHZiNxx/3TyMwFl1ZFrinIqFkKrf2EPIJOUC/jNGuJ/P/xOn+e
	 yr1nweTuNuGGexe3s+XL22hbcxtO4PTk4NNuDdWbeA9Wlv4IHqRa4vpxLTgQJvi4r8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NUnBz6lN/4GAK2x+OBJeXDMWlrMcWzY3n8Z7AClo84s=;
	b=GzXoMFkTJpl8ZNZIrpCgnp7f2hsoKhiNSiHJYeFCGTUZhA79CDP4MjJgcvaTAae5pQ1O
	 xGkq/eu9hpoHMNkRYwQqzwzhqIsSk5A/DRlULhvfO+KffLmpjmwO+dcMFuUk/10KFIAZ+
	 +rdIcexKsjZUbTxNTNDWEOEB/AQBTCBeEEkmRZWZuSPMzXuYq+UIO9Q3JxirOtrfcK413
	 9iTkP/cZx/XPV0v9kAXYJzs/U32Lki81FNZKTHySS/aDHg0+vjoc+tTcsjPHusnbKQmSP
	 +FO/7u42CpH9xaWyW0if+NjKuQGyNEnncUa34nVfsDQsiPB1WTonK0WiSJFsMdHyKeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JQ6EpXUz;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C1606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38C1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JQ6EpXUz
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-886e61fa30fso81628b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513650; x=1795118450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUnBz6lN/4GAK2x+OBJeXDMWlrMcWzY3n8Z7AClo84s=;
        b=JQ6EpXUzmV0Cjkh4BDzCkqo/lmIvLDbiMOtbtJg431NrW4pEm8qdDy4M6Mlzc88sBh
         BdXk5WMFm9E2yAuPFVM6WDz+yjI2mh8CGeRXdELSAcel5X3Du0rE9+bOT9xb3206usBN
         LI5HjOg8mqw8cvuLTp/hsKMjDZa74dNfnOKf/aRMDDNviPF38f0NER4+7uKq+TOaKc8S
         g3tk5m/3qNlysAslZl/yWOzxmRNSr44VP0Ai7jlxA5y+GeeMNV0Jvk06lasUANVlQ78F
         KUbrRITd0PrGwAP0igkUqesB3ptVJO5y7pqut4RrNUaAKNprDvwmH6hjVQBphKMvkTi5
         nP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513650; x=1795118450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUnBz6lN/4GAK2x+OBJeXDMWlrMcWzY3n8Z7AClo84s=;
        b=2L2TZx9y2ibzivhbFEYmJDZefcwt7PyTv4V7T5tpbTar/6jIJCk8OEhWviydvNqnqy
         eVyzlWvS7UoGsLRF7DVj+aihJMJYMU/wIlJ2K5BAGz6IMrtbc0a/w7dNLCARDenVnAqj
         pb+nkaVT37SODAHzDq6WppxPkjp0Cae5xev785EmJ7y4YhwfK+h6E7bhRVR4IPMUfKeT
         tfr7EO+KkY0hkyXwx1K54TmtWuBdOZKQ/hQxlIWdplT7ewgDwL9ubHPU8cqR5YodA0KS
         WEfVgaJspKdOFN/f3L/IZRMYHylNoKSUFiCq6KRt4L31FwMsK8aF7j9SUOIRlNRyMwP7
         seBQ==
X-Gm-Message-State: APuU4Z/MwSD3eqg5H/bgSBDjDKO7e/meT/lQO1z7oZtBvo1HUD+y9+R6
	KK6PqarjMKJxyQEg/78Wa4oqyq5OTtiGXR6PRTXHcLj7g04lvS7hXrPrXq/LONzHUVaW6O2KeZq
	cj12iYxk=
X-Gm-Gg: AYBFou3dlvAg2ZmwQvmIfmU202j/7dUP+lw5YfvIEtYP1+Iu5sDKPMTllIBUWW30BtE
	9PpCxKto+IX/hum+TbddH2KshWIh62bKp1PQiRmTAfhGuI4NTeHB1LWVGzICJbWPHuSx0peUIxW
	mqcDaXcnO7vJQjkr9AEwQkwemuuqf/Q+E4I0z2WiQ8HQtfIpU1Vo73n2yIn+Nd+2FWcq8F6MBxF
	x3pLgsOX0rgok+UCOjWQjcupQcs2kaH8KDgoNsAYDi58G+vlpdysnxnAZtKsYKU9jWQpNCUjkcc
	ZFXVyEflCSiDBg20kZWyo98A7GqLojewwp34+raqy4lFFo+t+OEvkDI7Z/bicLs/E54eXhE1211
	q+FVByksYmQ87jqr/BunHbny6SIYIA8UjY6ikiNqAzb5G5Ro9jf+KAno9tHpwoTsvY9c5LBSCHk
	WlIl80O5eOgVQw3F4/Di1eRvevarlGO5h1Wf5a2E5QQx+UDyv/GYnOLalGyiE+c6By4hS1bz8hm
	QjqtMXnNZJHAK0VAZbq3+GHD3OMbnbZN4JZsyA1b7ZTIgfE5LJaZPWO9t8o2zsBCgn9m3z2qCQE
	XkoeP4DCQRvoRva6qjXoLAevVkXRMu/F1b2S12/1wvoBaiUdI+qTZCRZaLtOAA6vUiL4Nkg=
X-Received: by 2002:a05:6a21:e0a2:b0:3d2:df:1854 with SMTP id adf61e73a8af0-3f7a4dbf1f9mr241688637.6.1794513650045;
        Thu, 12 Nov 2026 12:00:50 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 01/11] ss: fix double close on sock_diag send failure
Date: Thu, 12 Nov 2026 11:59:14 -0800
Message-ID: <20261112200046.2164391-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

If sendmsg() fails, tcpdiag_send() and sockdiag_send() close the
netlink socket, then inet_show_netlink() closes it again via
rtnl_close(). The second close clobbers errno with EBADF.

Leave closing the socket to the caller.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index cffee883..674ed8e8 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3931,10 +3931,8 @@ static int tcpdiag_send(int fd, int protocol, struct filter *f)
 		.msg_iovlen = iovlen,
 	};
 
-	if (sendmsg(fd, &msg, 0) < 0) {
-		close(fd);
+	if (sendmsg(fd, &msg, 0) < 0)
 		return -1;
-	}
 
 	return 0;
 }
@@ -4026,7 +4024,6 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
 
 	if (sendmsg(fd, &msg, 0) < 0) {
 		free(bpf_rta);
-		close(fd);
 		return -1;
 	}
 
-- 
2.53.0

