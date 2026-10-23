Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756773;
	b=YcS/EaqHfuzQV9nBFzQ3xNKhsuD8Oh5NthIurcr2N9WmpATxhsL2Mr2/eed3IbE+R3H8
	 8B55KsidmpnklFufW8OBbJdqUvBvgC70C/RjL6mt1OaJXQU8ukStj3EPsBPBi+EuNpGiK
	 VGhcYY7nNx/75WAmSvR5VcJWZa7eUPshgU8s7TEazzgysPcvM63vNN6tHyz7pyeb9vgee
	 u2TMfyc29XR5dWsfa6XR4pqG9sw9U7HJ8kaiawZpvwUdxjv5dbtG9Pv9dYAoCx7CYpxvB
	 KXPRCtqXF9ESG7h30XoiMwrA1GIUi0s0LshkovKdNQQoddtmD/o3KGXJ87946N+2H4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
	b=kFrfqvr6JIEj75DdpoJ07w5akW0G3t40I5QmHvIbV/3nqjopxldyiOit1BCDXVZlBud1
	 TqVWA4TVkcInlMTWDLSxFUC8pUvzhSFBqIG1Pfm3QVSdYEjsukOQUQTm5HkMDO8z0LSp3
	 UhEyxbGrDxLTRU2NfpW6xsRK8B3n4Xq8CEII3AUTo3Fvu83rDD/KZcMa66xsCpCZJc5ng
	 LXaWpPQWEYAKOZ/izYjBDdYSKkTd8dj15BhV07c6+kccF76mhHwnByhGaRjQEPv27BaCU
	 9zPbaNB6wHziJkYNYUG2KXMLlt+dY8PmdK6WccpALM0wLQX4/r0O5SYSNOipZahsdhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=M9sCOydb;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D3606A333
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD8D3606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=M9sCOydb
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917997ab0d9so10410266d6.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756772; x=1793361572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
        b=M9sCOydbeZo/L1rAE1m1GWSuH49lDlJLjVsT+gC68h2o+bRv4aVFZAEwrwR8HL+sVV
         phcHu9Yp24IOxeANmE+KVo6kQ4Gd7htuoEAEI3feMOC8pEDyLHfs+1TrBrAItci5JZbZ
         HuqjAMdiMTfSWqGanJDPvoDDPu6kK+PyOW81U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756772; x=1793361572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SEgSB+fCrdDdR4pMioinv3V6z4wpylFB8adOgpawsaw=;
        b=WqlM6Lt0yVyjM3mB4C+Qcm6wcoWxL86uc+YUTOvxcaJSXSQeeS3U1qTOgEo9gS60dV
         7FgoQNpAgHpisi2tKfkR0+x5oS6zsM8BU7p9+wH2QiZuvBr5Iuziqhmmk2qqgJOQHPZO
         xVknaMh4QFSYBHLHI7+JAlKlWApAaSpvast/GEdusTw5QGNEwiPzXkS118w3hHuGXyWe
         qutjl83LYNqBzNg4BSM5w1XKoztfLPzgz/XbboHCHHiDLA+8Te+RXMGZOW7iAWJgQ67z
         aMPyJDPEEj8G9ugSE5MooeeuNI7R7dyZH4ut77EyOFlnoYeZwmiLLsthuywvh5uDx+7C
         avug==
X-Gm-Message-State: AFq9FYJvWp98QO0DpAHlcvCHzajxlv7v95ammVO5ZiCDJYhgLww0cgjX
	9l67ogh2+YdpfdQFhD0yNYVqjy1wbaSZF3ENpMDCTIVGOVjcYCyhwbjXE8h1Y6F/yvzgOS8NGX8
	o64I=
X-Gm-Gg: AYBFou35tbHy1tcrwrp2sz2vIq3qXoq8M8kL1IzvJyPuslSUXFDKtLtgKw4CkAYoXsl
	kKrHdZgx/kaiJKLkQi4e17C8z5GDYtmK+EqO5ZC9Ea4Yph+S1m/7lZkxGNx8/WTkfiBV+TfVHm9
	hoGHRvSxHhBtudfuwXg20WFb9TxlReaaAwTLj8p7D5cWc9d67pW/KGdvGoubruP9Ha2D6V3VarF
	9pdHda54yHkBk3ItPJLLeK7VuYNxg/ajH4SsJK4D2mW8BAPGEkzPOKbasKsNoPwldyQj7L9ToyT
	T9QuvIw1PvSL0d2e1w4AlFix8MN2JuSYMayWI03YshvHIFprYabqGcpTcVEzbmQUEP2kBXiY3T+
	5vQCLW1+egaSfnGy5t54VamsIQZHpbb0dDyAzQQtu1MFJVq48Ro2Tp/yl6rBTDhyZ2ST/ifT/Hy
	bS62nk1+kiWw/ZBArGPSXPBUojr6IMNzSuKksUrLec2hZviqI+VJDUbmgYLEi7OTAN91DtdR/Pk
	XLxGqGMJYvIEx2taH+tzHqiqCNRmDSDAqRm/mK6c+FspbwQbGNluM2UD+xhJbPKSg/NHRbxAIw7
	m1qyh8egd5wgLXzDxMsNGVh4AZ39v+i+3FlCCfQqHWjG6+KljK8KMHwNy0oFMgE=
X-Received: by 2002:a05:6214:da4:b0:915:e5c8:5663 with SMTP id 6a1803df08f44-91c3a643bb4mr26289136d6.4.1792756771660;
        Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/6] net/sched: act_mirred: reject redirects without a link-layer header
Date: Fri, 23 Oct 2026 07:59:18 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
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

The issue:
tcf_mirred_to_dev() may redirect a packet that has no link-layer header to
a device that expects one.  TUN builds a valid L3 skb with mac_len == 0;
mirred then pushes zero bytes and the IP header is parsed as Ethernet by
eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP chain
whose producer did not leave a full inner Ethernet header.

The Fix:
After the existing push/pull adjustment, when the target expects data at
the MAC header, require a link-layer header of at least
dev->min_header_len bytes and pull it into the linear area.  Drop the
packet otherwise.  This mirrors the check bpf_redirect() already performs
and keeps the legitimate push_eth-then-mirred case working.

Conditions to recreate the bug:
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach egress mirred redirect to an Ethernet device (for example lo);
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
The unfixed kernel parses the IP header as Ethernet and can BUG in
eth_type_trans() via loopback_xmit.

Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..e3e0e4aa70a1 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -316,6 +316,11 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		}
 	}
 
+	if (!expects_nh &&
+	    (unlikely(skb_network_offset(skb_to_send) < dev->min_header_len) ||
+	     !pskb_may_pull(skb_to_send, dev->min_header_len)))
+		goto err_cant_do;
+
 	skb_to_send->skb_iif = skb->dev->ifindex;
 	skb_to_send->dev = dev;
 
@@ -335,6 +340,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	return retval;
 
 err_cant_do:
+	if (skb_to_send != skb)
+		kfree_skb(skb_to_send);
 	if (is_redirect)
 		retval = TC_ACT_SHOT;
 	tcf_action_inc_overlimit_qstats(&m->common);
-- 
2.43.0


