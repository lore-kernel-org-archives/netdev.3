Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416452FE2D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914061; cv=none; b=P7PGenj/mNW0bX6rBGkHaWiN9ks9eBpyXjILebpVq+AaE8rcsMPCxrw/QJUaqx/qZdwrVZIIBM8svPIVqSODceJfNUbiyvo0CuGrHqFlfa7+l39nGySPMov+JydYMqPfW749NXBUgGKoiNmXu3ibasOBvBaYq93zb6jZUelZx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914061; c=relaxed/simple;
	bh=dNt1+qDVTfl6ktB/h7JsBcW+Ebvqf1bzmkgjO/9Uzls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdb5t4Vlsbr8fvNq49ABlnU2pcfORm1qADGNwUgYYvRxUmp/94UACLa05zmR8p6kqptzXtffWlpqpDMy8OWlRkCLxnaZu0Fmy52U1bawIR3DkEXfXxrzhJRfpkZIAZGFK1D2024qE8suH+m9Wj2JKTgy384hD0Hlh4Ev/Rbs+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=efW1SWXX; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="efW1SWXX"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso1116887eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914058; x=1792518858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeLrBjGYw2bprIrCl7/DC/0yhw0Xu3oRywspw/ye3hU=;
        b=efW1SWXXR39SS29Ix5tiuVPMmzYRqMbhIlsflo/TqOxGUBrm+6aOxq7bAEscXZf8iP
         QFT7ALe1NccTR2WTGpXI9YOuvelkmOS77C3tMuqtvzi4JJun9rFIy5Rzw+qYJW5IAtDN
         DJZdkAWzfp3Yyc8idBNbp2hNpe4vNoffx+0D8GPwCnVpcSmRxEG0y6mg0PblE+IbKkeg
         j6S0/ZIgqeIPkIOp6epTkFbbaZjDqVL2WIc4KCqU9vBHBmtZCPDLIj0QgOT573VFQlDK
         qbmG7ycrN1Y0sKruF/yxrNxA3GBEDBxLAZdlJpBxHidrj3HDYCqgyJiItpIkw4N9nJBl
         vCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914058; x=1792518858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeLrBjGYw2bprIrCl7/DC/0yhw0Xu3oRywspw/ye3hU=;
        b=bsxoGNL7l3Ab2JaKPlqUhQiRLuanDAY11fDwB/jJus1DaF2hPKP0T30giDeroQAAra
         ABdwxNMmT6LS/yNLCYHeDyFFXUFq1XTypLWAVVWGT/SNd+H9aT4tQ17iS4BdjiKOkc6R
         aegsXodMzjQpOhhjKtT+DdjB5yBwuV4eQ/ClVTVyAUxTcii1F+ImHwkLaCevCOExnri6
         KaK7Yhi4I5U4kpVnGxYqsQ8BAq1tKuwZXY7MRyciQF05EuBCMLlqVErKFha+kvtKfMnt
         cZoYCyVLjSLp/uviiEaS8frfaEsuMzSJxPOiS8EIj0SfsmMSE5JM2n6N8vjy6YVvitD6
         ygwQ==
X-Gm-Message-State: AFq9FYL2FrXZSkqMysHpNnWip8sAlpKiHsE0dXI4pxBu7LEU+zwW8uy+
	4FfP56EDrbGdvyi50bQUCQnU2MxW/lZkrnrV8FJF9tDH6L17PKtw9DBwWZQ9fAYUS0g=
X-Gm-Gg: AYBFou3DX9thrnbqNwsCn8OKU9bjIEbrieRNf0plh/NR7VrtWUTOcgks8Un/zvGFAk3
	BhwTdSlftc3Evd4vI58IyJ64vrjoz2Q6L9HED4qBs/w9SVuD3xrreFcABUoKTOEreSn3bJuSWuE
	9RrjWq1c3UKTzyHRV3vZtzlYHrtQ8HfrRE5AD+14eC5QWQfiytJa82KnMjTKbHtfLtTR8dLCB0x
	Jq71tj12vSI2Kk0VTRN2ljM+P3WLR2/edXnKeAb5li1Vi/sVPTzrSrS9tekkmLZvHSm9Tv9P6fW
	plOwPW90EPxM9YCMXDLeMuGGO/x+BzxK5GSA31C5XKv4kM22afjR32JxMPkVPXCsX524QOIxj8d
	DLT4aWxVAhdh/IWZNLHhnicLBfjWvmOAm9ot4vfK024cDGA6jyKszvharWcHlW8C4UnUE+bfE4T
	D0gMvmUfPwkcEj2LCM+nYQUqsnAEoJROmGsQYi+69SdkQpSz0Sy3uCkIYTZXW/CjcN+CmCWnwfd
	hBoeniyCeHuGGSfx8IU86NNUdZsM7JQGHyDuAYczkaxBDMpbLNjjhTGOm+0w5xpA16GT1dShGw=
X-Received: by 2002:a05:7301:e0cb:b0:351:1e3f:812d with SMTP id 5a478bee46e88-3537e0caeb8mr16505272eec.36.1791914057700;
        Tue, 13 Oct 2026 10:54:17 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:17 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 2/5] amt: reject a gateway Query or Data from 0.0.0.0 before a relay is learned
Date: Tue, 13 Oct 2026 17:54:04 +0000
Message-ID: <20261013175407.947606-3-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway's amt_rcv() admits a Membership Query or Multicast Data message
when "saddr != remote_ip" is false.  remote_ip is 0 before discovery has
learned a relay (and is reset to 0 by amt_dev_open() and when discovery
gives up), so a packet whose source is 0.0.0.0 -- for example a
0.0.0.0 -> 255.255.255.255 broadcast delivered to the socket -- satisfies
0 != 0 and is accepted.  With the nonce freshly reset to 0, a spoofed
Query is then taken as genuine: it sets ready4/qi and the response MAC and
suppresses rediscovery until the discovery timeout, and a spoofed Data
message is injected the same way.

Reject both when no relay is learned: a 0 remote_ip must match nothing, so
guard the check with !remote_ip.  Discovery is unaffected -- Relay
Advertisements are validated against discovery_ip, not remote_ip.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 530650d..e9b1a45 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2860,7 +2860,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2871,7 +2871,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!remote_ip || saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
