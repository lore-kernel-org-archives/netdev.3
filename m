Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660955;
	b=dvlyXfdpSlur2Ic80pQ0VSl1FlUD6wTOYrXY8a9DX6Q+W0glf1vW4byn0iMSmjah1u96
	 qjjA98lkkIjUG2ccsJ0BjGa7MYtWN1gKxZTFgVaPb0WNyTGLQRUWh0rjFMajM2pVNutuw
	 UDXlNXzjQIoaSv7MboePYnl2Sx/fTWFM7MwNikxJvnO8uVLyJsp4xLF9IP3VJxB6FalNo
	 4hZje/pMKWEQfydCD92fr1gEMwMU6A4M7dsy3I2cuSeBwiLlahpRU78r008errPIRz2rD
	 1k9Zuy/SMT2Iu5SeAMPMaDV7Q4ggI+tRT2sQMqgTaRR+kd2Jo6Gk1UrEuptFAr4TWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
	b=ThYJJ52gGv0UVHEH/fV/H9IpLiAVRERqsp/C3BLccyBwarrQkpFK+6pHzywmxQovL/Mx
	 Pgf1ex7nNzWg+e1Hz3NYxw6Gdp0UC2EahmTkeBtW5wUNQhJrC7zBr/TJFirk93U6Pm8po
	 0CJdHLfMgNpUqiJMQkU9AJZwDPks2jNX5xFs/RVyf1yPHRg19HVKG21HZBo1LU9JOSicG
	 B/hGyWYSFTIpqn5toHfzW2Fj6wob/151UpnKd55NDX6JZMnC6+1PzN3/nc6dK4htJiXz0
	 JygHZQ1Pvs59fdix2tyBEPpC2FgKeDmvVQm03v5HwRDuXyu1fb0tCcRG8A6MoSONcrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="HO/kFuk7";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F760A2601
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 753F760A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HO/kFuk7
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93a40a9a01aso88116485a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660954; x=1793265754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
        b=HO/kFuk7FCO5dJFBDbR1SvBkEcbzi2qKZEppDLmcN9ag9nG2ZJduZ5IIrdsvHyADIn
         f6Uo6NRyOuNpiYjBJUEU80y2k2QwlNeezB2RuRIWT6F6p0wCPjwvR79vfnoTGEf3hcWJ
         VRjjCrpVxZQqC1LRJRd4KcCzM7RompyKCUXWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660954; x=1793265754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FU1XSWmj++ibIHIRMssfhNs6Kxu554Fq4tiwLZtw/UU=;
        b=UH6V+W+nLoEdimCmUz472IatCFdTVaiDVMFxv/1mTiPqNh4JCADxa3kgVhjMFTzArr
         p70hsao16wal7fhdip/p0X/mKPWXJRmnAfWgcnZ7lW2NH4Wa3r2++igtywpDu0mIhypD
         HjMwDK2yApuomsqUaYWsFs0PMUV6Auwj5re8w60tJsw4S96ZJxh2AAhC4dmKU80VqQLX
         +8gyYrtRr0ntCrnpdKtdCR4cA97KMkiZ5hn10hr5OqHuBx/MRFvCDw2b1x43xsI9Uw9/
         4TPyKx3D2LUWIgYnHvoqSNSc8ZTgbAkpIiWFYYWX9gFQDwrv+RHBIclnM/EjIwcL+8cX
         bbUg==
X-Gm-Message-State: AFq9FYKZ/w18DlqkOzywbAs+j/GvHNAZJRgC6EjtI0md/15Fe/NGBuYv
	XhwEucZnahIdBBMPIoN6g3NbQlLHUqHeLtkHf4+LiJcR798Vv3FivBxL3ov8FFbUGBCBmhViNJT
	WjsM=
X-Gm-Gg: AYBFou3e9MxGr6ikWgEUGKgB6cIbGJbjAffamtrxdZ+QkUy8GKkinaTAv4/tq8EcVPz
	7N5aheponxIgdotKmhZsKJix4NGOGKjY9up024vXZsbPfUucGhL5/1dTscOLPWJCvEt+pCf2688
	I3PPMgdSL9kzKZKxsgnSO9WG/gnEEgsoRuKorTPYhObcJdnkqGuUynP3+yj54CK5tky4ZU4JoG/
	hmamQzbnV5NyN6RETpH9/vRmtJkNMnDIljYVx1Fuxo1bMEYKCdSH38Eml/x7LsvQIg4ifeE1yWF
	MuZ+eyTgY5P7zSsF9WSj64UNSYt7BEoM8w850COdwJeXk3bXAcLMEymVPiYTtpiNupXjfCaDEHw
	rzr2dEosGfnhX2bsveT5iq8e/8NyIe2ESqe2A1hV/9CPNnSKJVZIbdFGA3x+62mtQm2QpoAwsXg
	pdzjt6VFSz8uyvhkdc7OvXN+d1pnYANNX5rhLeKrN/pWuFywrhGatRWEzyxyAx1ISTfCtihUvjp
	lVN9IOUb8KvBGFTNQ9MJZW2JtxFDpwNhSnArmaTJkMswdac1w5eIeuesZK/1mCw4v98UeYR7Rqz
	1msvB7AVbn/sEijSsYvrQlusRg==
X-Received: by 2002:a05:620a:4686:b0:93e:5534:e63 with SMTP id af79cd13be357-93f624de650mr270152185a.13.1792660954420;
        Thu, 22 Oct 2026 02:22:34 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:33 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net 4/5] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Thu, 22 Oct 2026 05:22:21 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
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
pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath now claims an Ethernet header it cannot access
linearly.

Output to an OVS internal vport then calls eth_type_trans(), which
pulls ETH_HLEN from an empty linear area and triggers the BUG in
__skb_pull():

  kernel BUG at ./include/linux/skbuff.h:2830!
  RIP: 0010:eth_type_trans+0x335/0x500
  internal_dev_recv
  ovs_vport_send
  do_output
  do_execute_actions
  ovs_execute_actions
  ovs_dp_process_packet
  ovs_vport_receive
  internal_dev_xmit

Conditions to recreate the bug:
On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
packet with one bottom-of-stack label and actions pop_eth,
pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
label, inner Ethernet and 4096 payload bytes.  The two pops consume the
linear headers and expose the inner Ethernet header in page fragments.

The Fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.

Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/actions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 27152bca8a8c..03b31e33e880 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw_flow_key *key,
 	if (err)
 		return err;
 
-	if (ethertype == htons(ETH_P_TEB))
+	if (ethertype == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
+	}
 
 	invalidate_flow_key(key);
 	return 0;
-- 
2.43.0

