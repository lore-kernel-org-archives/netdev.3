Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318E3955D6
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773294; cv=none; b=GPB94aNxhsDAFXAYF8OlwhPTDZxogLcctCOEKoAXKEI+bLTuNYVuYyuDOk0CLENZb+SQux4RMcyu/3P31eSsw9VYDdudxcyG0v3SLW1Xfc3sRDP533rKSWa9AkrmmbrvyAd4/5VxOO6T3fYcdwGxwkddMAhGBVbNYLMZgAFw/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773294; c=relaxed/simple;
	bh=3OTy30U9zaA/EoJrB2LEVikw7T9erylLWW9kg7srSqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpsxXa/JSBewdClj5Tb+N39u/EscxeMegUsMUVyHu7hTbHZKsc7J1OGz+TCi0zdVxWvKrcwoapVm6p+fyZ53BmGTDQO3WIbjD4vw1S1QC/neoQd7Z21ccp6bVYjyGlez17cGgCfrfW41/VSXyTWL8EJ2pSORv5Tu5yTSTNDZ6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOqWgA/o; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOqWgA/o"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1773003eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 19:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773293; x=1792378093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=gOqWgA/o7HnfLsPx1JPq52guD/SalD/nNjTYb0LpVx3DgMdynBcXcJbPpJd/GIVVO2
         SxrxMvblhHHp/9YVfz7Mwlltf1jUFw1jmnkpjUfrCcXxyP/0b4MLxeHTQPE8tJpqD7nG
         aVwlEqB5IWoyor1vLEbP2GYPvshUmfKPy0txQeQqT61SmrvDHc6linP8DI0DZ8cQ6CSd
         xLk91JyQ4QioHAp8b0eqsDFHK6bc+opnTfkszaTjph0WMClf6SDTWq3UT01Psf+H564O
         D0sU6/vrnKjSKhx0hckhMjcbCkjUGOJSWJLdkY7m/wNFsP1CCQWaqLlzm/KhHA2suEiD
         3Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773293; x=1792378093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uV/uHpIyvSDg1rMqWOrJjW5nbbNl8aiS8yrcLtotir0=;
        b=XN+sO9cq/uPWeIieblLgEInWVKEgP4ZR6Ze6zZPQdpN/19qZEMlnr+A2a5gfZ9G3lE
         Wi5O+HlMsqJOhWQD0vq2E7Nh9Cswha4CjAv/pPCFSBj7MZbhBgHK2hVHSXlR7iZzS33g
         kuZ+zgPJ0zzj6NfQ5aUF71giMBj1ZimYomsXc2KMcDiHJklzNFwcVyVT27338AzXE1rR
         oW7PqFzugE17vK9uvF92vrghbqBfJdi9QMnJfizTCHTpp5vPLeeIOfBXMUDpXAyjpCi7
         B9lTFLHjGpno02sZFTWYYdXig4NtLa2kHkM5W9R5FrNll8VYYDYfk11ZHxm1LNR0KsuS
         6HcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNlh97KZc3xt17o6kxlQGCBi5ZprrT7Z1qLT4fdtbFYv7r75uDC9DRQiC4tFuTfSlcOgCbcz0=@vger.kernel.org
X-Gm-Message-State: AFq9FYISoIoekZs/5sLz321VcjKbfpYYyA0LPaeFCkl28grfFVr2/T2U
	vsBkD3trAItPO+bobYTbbRBZtL7E4xpqb6DSEDv1fj1MCxG7YpgPxym2
X-Gm-Gg: AYBFou2RHPVfCojNOrg3TX+rh+llb5nvQwOeWVFxNJFNSIP2Uu4z7KTtIOb6q2n8Xw0
	vCIqYvvoB9H2YOT3th0tpfTt+l975pcNwnv10p5gikd8mzOgJSaj8IXgZAfEXpHhKkMo8mUW8pE
	dHyq5AtVCDApSFRf8lLUQ1Iw0kDuBGY6pnhvk2EBGPpSSDp0PKrf4QKfpmxdNwE0yzd3V7DmnMV
	VnESxT9mC8tVa+w4dpgbwyUun05KzqzQ0C+RWALlkyIOd7YTIAwoFHmuyLxrvHUgvbudJqVUJLh
	DFpc89O4xKeh7T1hDrwwGGVC3vcYkHLFFBdhE5W7FR59g6cYUonPR5fvrc7GwMEqQajOg2zAij0
	FI3UC/zySDKZ8NEG9nT+s38Khq54boXH08nCo/Gz8ij2qYYg8Nx/afwCYfCYXmFeSWYmozdqPZC
	wocQlTujGCPDS2z9mruN0dfhOJgm5jPYq09wV/Zylw/Ddx2T3kcYArMDahlgShG0FYl6AOzJW5d
	eU5TJwN2SJ7h+KbHaVSxgo9wOxuSdNpXJ37+S9qMM59wfEWOweUvOUFlmNqABgNvD+WM+JRnJAL
	pcEHIpGk5nWs/192JBbftZy1W3qvoaguA3pnnUGkMHI=
X-Received: by 2002:a05:7300:7aa2:b0:351:a9b1:73c with SMTP id 5a478bee46e88-3537deccaffmr11904799eec.2.1791773292401;
        Sun, 11 Oct 2026 19:48:12 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm26075299eec.6.2026.10.11.19.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:48:12 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net-next v5 1/3] gtp: set a valid genl command in PDP context get and dump replies
Date: Mon, 12 Oct 2026 02:47:58 +0000
Message-Id: <20261012024800.400616-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012024800.400616-1-anilkaushikwireless@gmail.com>
References: <20261012024800.400616-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_genl_fill_info() stamps the reply with the command its callers pass
in. gtp_genl_get_pdp() and gtp_genl_dump_pdp() pass nlmsg_type, which in
a genl message is the dynamically assigned family id rather than a
GTP_CMD_* value, so replies to a PDP context get or dump carry a
meaningless command number.

libgtpnl ignores the command and is unaffected, but parsers that check
it (for example the ynl tooling) treat the reply as an unknown command
and discard it. Pass GTP_CMD_GETPDP, as gtp_tunnel_notify() already
passes a real command on the notification path. No uapi change.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 drivers/net/gtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4aff23bcfdd1..99836b773e5c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2279,7 +2279,7 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = gtp_genl_fill_info(skb2, NETLINK_CB(skb).portid, info->snd_seq,
-				 0, info->nlhdr->nlmsg_type, pctx);
+				 0, GTP_CMD_GETPDP, pctx);
 	if (err < 0)
 		goto err_unlock_free;
 
@@ -2326,7 +2326,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 					    NETLINK_CB(cb->skb).portid,
 					    cb->nlh->nlmsg_seq,
 					    NLM_F_MULTI,
-					    cb->nlh->nlmsg_type, pctx)) {
+					    GTP_CMD_GETPDP, pctx)) {
 					cb->args[0] = i;
 					cb->args[1] = j;
 					cb->args[2] = (unsigned long)gtp;
-- 
2.25.1

