Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815169;
	b=FEkYh8n1F6ytqkRNErykMMroDqkyc9gvrOyOOHFlPj5KUT+mvsnhmOZGjzOD92r2p7qv
	 Nod1OVrnN/QfuiIL/44m/eSPPUevu1MyUbdC2w/YQmeluxG1OixQHlW16nN2T7Zq7OGtw
	 gi7uC/oh+XCgF1N4RLG/kRu7PWbAiPiAXNvc102fUow4bdZgo9/mR9RETkwhY1QxvERTZ
	 X44DhE2oCzMRCx7JZ076G8GBE+8YcbXA4OEhOrMDQFxZsdaKpluxNEqdDT0Zc+mzvvYQN
	 sKrCqB8zLxc1zhstDKPOhH4IOWzZbIsNzUVKFevqujQvXj+h7YM+FUHzcWUPeMdKYwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=X1M/siCTn3ZLh8zIxLUgK0yfd9bXAU6J/pn6vvB+StE=;
	b=DZF039tnCRxawuXd6hd44o4VdCsF8kglQPwgROcYyZv/DyEmZxU56POq5B+iYDmaMIxz
	 PzrH9LjDXUkAckRHcQzhT45GciFEu6pq6UyDQaB+dmV4b+dBKTo3YXR14KMLjH8ZcawCM
	 5uesGEX1JkGBdAnlwjOWh673xqdC1Mpdy62tn+z5iW+D3CY5SVmvqooKTjG/HnMKL7T22
	 Jlhh4R9j57/L1JsQkgMu0fiMuUuYN+qLmKTZ21Mauk/ZM6u1o4CudzI64DOU0qECNfOf2
	 51ijwK/d+6C6N/IdGSMKmbprokQuiPYN3UXbFUfqjkv8xcYOXykGBZ8m03fBIMd4TKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xi6EUMcF;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE7606B084
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EE7606B084
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xi6EUMcF
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso485978a12.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815168; x=1794419968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X1M/siCTn3ZLh8zIxLUgK0yfd9bXAU6J/pn6vvB+StE=;
        b=Xi6EUMcFwTnxxWxDkSKZLeHEKlXbKQJD48d6CzHIzpY3Iz/f2kKQtTNiebfpWZ5Gvh
         q8sB/xn7JuXSUIM8EU/Na1rm1khelSVKl8POrajIQu32bxsT/CXQ+kXww2Jib2UQAIKi
         SIQukPGvZkJ3pgNFmNJ1HazapNy0z6zFb7x9DxeZfpMbz6aFTHtn1uGuwwYPWiJpH0Hn
         e9upWyLcTTfwTYwl+pfxpBzljDSgggWNjIBff9pNUYvKngN0C7xfLM2fAPKCZFmXbG7r
         32OXrikyIqOPub+AGfLRE8HS76qR4GVIbi0eoYJBKY0y4xTNa6OrbqQwwfXuYHdtxEb1
         ec9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815168; x=1794419968;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1M/siCTn3ZLh8zIxLUgK0yfd9bXAU6J/pn6vvB+StE=;
        b=2OfZCFRPjwBRVUX2FSf1ZRN3hQ0iNKWl40ePdFSoEf7s0bhR16cfwrS1YmLLvS2HkA
         GkR1mKLcAhjWahqn9yWEsNPF4LmtYHVJ9kkMizG410WqJnyVJHPm35Bl4EOmnNbgUY5k
         UDq/F+s7r8qVBNVLArOOjULQoYCC9PwKbiT1LodjJ5sIlepGgtwRpXWTGIwxiGbKM5qN
         Kt0Hp0QX+8Uxk6cc+/LE8vWPXRcITZJ1n2pOMWgp7txttOnF9EsURet4Ke7sF0EgTZ11
         jYyG+zdNjy5jVExOOuGfprBGJCAlXhIc5miSjMpThmCf5Wq3Ugxh1GF0rar71Q8i5Lli
         oG3A==
X-Gm-Message-State: APuU4Z8CtcDzW73RNXKyER9toDMLf56kbbT5JPhUan+6MycXLGMliV2X
	g4Tpu5DV9SseCDX9fhgpvMdr+4ePmbtM2EFzxqP6UCXoh9Xqk3HtK8WWtTS+7w==
X-Gm-Gg: AYBFou2pN6kz1EkW0FP0fmiJqIEd5Qc0KFB73dh2IoNgH8wyvZ0AOp7kkdMiD+L+qQi
	CZhQaTzlwulWWdJ76g3K0BRbaLQFETIuERN5PDqw96GkHCLq7nqngUVNZg/g9iWKCbS1unNV/xu
	z9ymrheIwT78lHIs7MJXawqOqNzaiTapOtcb3f8E8eoi2dZ8WRZOAVmnNQeHGwrSFHMgnSHmyWb
	qMHwSawJ4b1pMY2ZeM4OuAizRJGLH4VqUgZFdQ05Rgxcp2tkChrA2p5v5YdxddGMvdOxc64HN8R
	3XZJW10GA+eoFcJJZuo7AbUuomjKI9R8QvdwTwZZZaX+0mUba5YWUlgDOK+ezUHgCN+6KR9j99q
	296b5mBkKLGvMI5/3NPSwQ4P4xcpp7lkYBo7sKo3+ou9j4/+qhPOvP3mZcKRE1ik3UDQlll2Sny
	lCf6OkX8vMBORm1+XNBhXHJAi+xckD3xylTnG7SqmeVS3x09ms0ZZ4l7m5Rwzqe/oTKsBakM26+
	hNkR7SmE8R2RAlcJgrfyfCwVpySHDZ1IKqqjXjHO206Oh0oo/pnCm54Vo+e5XfovNMHbxOz+KZs
	wfaQz2HtbHo/zjPYzricIZnWjt52Wkku2u+JR7mhxvl+w5E4d4x4TZrJoRO76knirjVAtHoUffO
	vnEVpPDvhCyrR/2uRI2lgZUVugo9sOAMPZCDjO/CgTXd5Ag==
X-Received: by 2002:a05:6a21:496:b0:3e2:c75:2349 with SMTP id adf61e73a8af0-3e928aaf75cmr12880556637.8.1793815168021;
        Wed, 04 Nov 2026 09:59:28 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46443e37sm1465785a12.1.2026.11.04.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:27 -0800 (PST)
Subject: [net PATCH 4/5] fbnic: Suspend phylink after taking the datapath down
 in ndo_stop
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:59:26 -0800
Message-ID: 
 <179381516644.9644.9042901965231900737.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
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

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_stop function calls the phylink_suspend function before the
fbnic_down function. With no BMC present that stops phylink, and the
fbnic_phylink_mac_link_down function disables the MAC and holds its Tx
and Rx clocks and FIFOs in reset. Only then does the fbnic_down function
stop the queues and wait for the Tx path to go idle, so anything still in
flight has to drain into a MAC that is no longer passing traffic, and the
fbnic_wait_all_queues_idle function can be left to time out and force a
flush. With a BMC present phylink leaves the link up but turns the carrier
off, which the phylink_suspend function notes assumes all packets have
already been sent.

It is also the reverse of how the interface comes up: the __fbnic_open
function resumes phylink last, and the fbnic_up function then enables the
queues and installs the host Rx filters.

Call the fbnic_down function first. The Tx path then drains with the link
still up, and Rx is still stopped first, as the fbnic_clear_rx_mode and
fbnic_clear_rules functions remove the host as a destination for its MAC
addresses in the RPC before the queues are disabled. The MAC IRQ is still
freed before phylink is suspended, so no link interrupt runs while the
link is taken down. The PM suspend path goes through ndo_stop and picks
up the same order.

Fixes: 6ede14a2c636 ("fbnic: Move phylink resume out of service_task and into open/close")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8a6703afca38..52244219d166 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -86,11 +86,11 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	fbnic_down(fbn);
+
 	fbnic_mac_free_irq(fbn->fbd);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
-	fbnic_down(fbn);
-
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
 


