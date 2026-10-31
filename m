Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477909;
	b=RbqnUxXEi8gIZ2hZ6DcsA8GzXfazGC7gjUQYFzQbnqzcGq9oVgj3LgkmzO8+pA6IGrUD
	 7sV0AM1LsyH8FSDpJuib7awz0CWEJ3Or2yDcijA+aoFl1PH3My7Tv61heUpA2UXMWPPiT
	 w4dJpkHaSBtuMDZRjGjR7pI0kLaHWu2EpNlcxPlzNWzJMMZd+BChxG7F3rXJ8fHNYApOM
	 zNuEdnkKmN4rEh6Ys6kqSmxni4WJx9FQszu3wbR8g3JCwio+vXuNivhIjhIY4Q1p9Y3v6
	 XjOnDttH7IaBQdId2KwCv7/rRTcnb67r9SMuw0geU+rtOoPvsBc6pCfZGBwGaf3pHiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
	b=pGEBR9iypGtzUJOdxEVTRWjD+v67o4hcdnW8p21lJusT5gBxgR9SvfOPbIERh8yDJ0GS
	 5OQBQMeCj2Vq4AtnVAJGERi/AP4ZdoWSEuVtUYB8ohtliqeUzKSuinOK6DDo9v/pZLYds
	 w8BVYkDpQUpNh6HXhQ7g/+AtE5VyfoJG3yJJ97eGfxkdW0WhvttrjRJ++chC07qGle8zf
	 4lcxVIrk0kfiLDQ7AGDhYGAEKE3OtFmq8gixfB4DHj8HwGzU14w2NpNBaBSDWh6okxJyA
	 RT3aSu9Z1Ti3MBrGeAlW+SEOeTmAEbLw1GKWOJkLgIG4fbbwbA5k7+2jxbTIQMSqvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=osapbFvW;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A9606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 20:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8A9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=osapbFvW
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364042eecfso28705571cf.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793477908; x=1794082708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
        b=osapbFvW8/pvf2FVPzK08DCcACCLYKsFigFN7so/RZQjdQoK5OfyaOlsF5bx1oN4PU
         IFxqcEWhsB3faY93F9VdZPBAm1Gwi3rmt5qcWqz4zwb40wSqC1/pp3kxMu+eijtJ8oSW
         UQ8L6YRBLKC8TF1l/O7iIwNCzjJ8sA/VcEEag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477908; x=1794082708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJkNAOVOAvEBRO8m/lbd12U2Ey8CYDNo3KZV6fwQHpI=;
        b=z1kjMmfc/wq1eDSefdEy5K4t1whM7nKwpt4yw6iIM/9R/PstTFshhSeFLPMrgeXRts
         rqggDgnssDWAttsEzpmZPTK+yjJp2cjPoY44ss9/5OIgibt147FeuzQwrk1f8kCT7Ze1
         jsbMfuVFbFJtBvRcrKpuo0ll6lWAgr4iQ+TfaBV1dUpLDtfMpNhyOvL2yYRlOX+j28bs
         nLci9ikBU5H1UDfK9UG19PWGtaUXECebvWzOMwNlFGhWGRwDFoMyQr36T3fCLW07VfRQ
         tvwF7ywTqiaGpAEmKpxccqvSsSc9P/Cb8bILeYfBW+JCBWhGnRYfZRF3+7H6O8yPtn/d
         kcQA==
X-Gm-Message-State: AFq9FYKkDNGs5vyDE4ivFzYy3XBFDcvBrCSSwEpzdDsTiZad0R5HRIKr
	gsiOOlEuKxb/AWn3IcImqmoeZgHnqZVe8r/QWNnNPrZLIlnoXznSNU2eWOq1Ki0c0tzSaphACch
	A0Y4=
X-Gm-Gg: AYBFou2pIwLX9ijaRmkDK+dyrxnJnibG1x3SSPFvPgjJ0ZaJLseSO031ObJKBkafQuk
	mASa5r16NgG8VCuNmftcn0yac6cyO4BF0w8wTmW3izwpFQaSdoYbx7zgUo0xGAn1BupJH687Qs5
	A3zjz5ZLblPPYQdoQqa434IhQEhVFFobtuCpMGosHIMINOcOXhTMJRoobWpU8H5lEB9C0omFfsn
	o8TQKYStQobJdGDY+vmxg8besfGZsYB9ZqYJbPATapsHH3+rsWZsEFduJCYYX/BrwNGvo/haaNg
	4HPQze6OHLYeZIwhSNKakR1qkjgMo4ZbS5Uow1QoFFBqYPtlb5rpD5N3R6fN885I2acwLCkIGvY
	aoC0PJMKLrrpNe4YWqS70p8PKZUq4umAcsHGdnWaabF2FZjfch7RUghfKWBqkyCzINIQxmZo04q
	5qIDGTwt9hkRa89tNDgAaQHeOaewCMAGe0K5YzRsSBDBa40yW75bPx5n02sTd9COPcY7czkNWOg
	0bFXkZx1oZGMSE3EqRE4ZJKBivJS0CL0aXZuhEzm9NoUftRxEFps8YvTMdB/Onsx1++nRbibDZE
	3csmqmWyuyu9LT0VvGyCVCx3brk2YIU73HxJ00gsLJw3v41RydGCSiQbgDurRtRuvUe6/zPl/Lu
	XGFEBqs40gyGjhNI=
X-Received: by 2002:ac8:5d8d:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-542b7ef72bbmr102820061cf.67.1793477907796;
        Sat, 31 Oct 2026 13:18:27 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23441sm49148926d6.4.2026.10.31.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:18:26 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/3 repost2] net/sched: act_ife: require a full Ethernet header on egress
Date: Sat, 31 Oct 2026 16:18:19 -0400
Message-Id: <SER-NSBD.v1.r2.20261031160050-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
References: <SER-NSBD.v1.r2.20261031160050@mojatatu.com>
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

This is a followup of commit 5b483f7791b0 ("net/sched: act_ife: Only
operate on Ethernet frames") as reported by Sashiko.

The finding was raised by both Sashiko providers (nipa and gemini)
while reviewing the parent patchset. shaos <shawnq1@163.com>
independently reported the same undersized-egress path with a
reproducer, which was reproduced and verified in our test environment.

The issue:
On egress tcf_ife_is_eth_skb() only checks the device type; it does not
check that the skb carries a full Ethernet header. For an Ethernet or
loopback device it returns true even when the skb has no Ethernet
header. tcf_ife_encode() then calls ife_encode(), which copies ETH_HLEN
bytes from skb->data. A short skb therefore reads past its linear data
and the copied bytes, including stale kernel memory, are emitted in the
outer Ethernet header.

The parent commit fixed the reported ingress mac_len case but left the
egress path without a length check.

A total-length test is not sufficient: a non-GSO TUN skb can have a
large total length while only a single byte sits in the linear area, so
ife_encode() still reads past the linear header. Require instead that
the Ethernet header the encoder copies is present in the linear part of
the skb.

The Fix:
On egress require pskb_may_pull(skb, ETH_HLEN) before encoding, which
ensures the Ethernet header is present in the linear data ife_encode()
copies from; the ingress mac_len check is unchanged. A short egress skb
is now dropped instead of being encoded.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_INGRESS=y,
CONFIG_TUN=y, CONFIG_NET_ACT_MIRRED=y. In two user and network
namespaces (a victim and an attacker), open a TUN device in IFF_TUN mode
and attach clsact to it and to lo. Redirect ingress traffic from the TUN
device to lo egress with mirred, and install an ife encode action on lo
egress:

  tc qdisc add dev <tun> clsact
  tc qdisc add dev lo clsact
  tc filter add dev <tun> ingress matchall action mirred egress \
      redirect dev lo
  tc filter add dev lo egress matchall action ife encode use mark 1 \
      action ok

Send a TUN packet shorter than ETH_HLEN (a one-byte payload is enough)
and receive the emitted frame on the other side. Without the fix the
outer Ethernet header contains bytes copied past the short packet; with
the fix the short skb is dropped. The attacker needs CAP_NET_ADMIN in
its user namespace; no init-net privilege is required.

The same path is reachable when the total length is large but the
Ethernet header is not linear: write a non-GSO virtio header with
hdr_len=1 followed by an 8192-byte packet so that only one byte stays
linear. Without the fix the copied header reads past the linear data;
with the fix the header is pulled into the linear area before the copy.

Fixes: ef6980b6becb ("introduce IFE action")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Reported-by: shaos <shawnq1@163.com>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

repost1 -> repost2: rebased onto the current net tip.  The repost1
posting was recalled because 3/3 no longer applied; this patch is
unchanged.  act_ife.c gained 498c631f9c6d ("act_ife: do not consume the
inner header on egress") since repost1, but it touches tcf_ife_decode(),
not the encoder, so only the hunk offset moved.
---
 net/sched/act_ife.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 6b23a3965121..5a527da00566 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
  * is an Ethernet header because the skb could've been redirected with mirred
  * from a non-Ethernet device.
  */
-static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
 {
 	if (skb->dev->type != ARPHRD_ETHER &&
 	    skb->dev->type != ARPHRD_LOOPBACK)
 		return false;
 
-	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+	if (skb_at_tc_ingress(skb))
+		return skb->mac_len == ETH_HLEN;
+
+	return pskb_may_pull(skb, ETH_HLEN);
 }
 
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
-- 
2.43.0

