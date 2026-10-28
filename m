Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223383;
	b=0/IEDbG9cQQXvRXp4AbGS+EVEvY3AmVjyq6F/PGNSRsarG3CavbsgkXLqhBfTx82oe2i
	 E/D0dwHlFapOpbol6x4mzwzyEN/oXuR3WJMONNx5xkZiEi+EVMbsHqVafoneljU9dsL7d
	 9QBgFrrms3gykHbVE8aU9nxPyXiMy5iIU5BTamgYtmsufuY43HE3a0qI161fbmMIjHepW
	 Fbev9NoLLEFxC2Y4W1tqrhiUXyvBg266DAjnXj3FanH3kZ/4Y+EcuJRqmtvHgvis9mC/T
	 aPnlZ8MDkCqPLAyvsR6XlgU6alOR4b6f18Y6QuUoQdAcnKAF7PgGcI9tnrC3KLY7l9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DRaEU9X7u2kKgzGCFR+7WnXnXObtsfCcW3cV0duCWvw=;
	b=XsDnBKY7TQeXBPGGkh2qRwkEvH5lKTg43OSTHTdR/yEktMRVQjlaWA57XtiU5/jPVLM8
	 r1AoBmdwxriYTF8fAf7F08FImFeXHj4Vr0Dqg57R3qeCpbo244DlHPBOsw5gx0l31Wx8r
	 jZa6//tdrPuazKe79gTPiV0qT3V4Xp9vFE3Z9WnWXavDHrPAUweY9YW9onrxgGNVFGQ1c
	 atVaPrfkQJS/4cx14DSyEfWSu3dQZqc3fnPXTyqRe5pzjoDUOwEIE/rzNOf6oW8wAFsst
	 2BDz86t0NQmfNGMocN9kPQ1boxuw+4mStmSUwxpHhUHxAbqCgSs87sIkE0bCbXib/bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7+rIjLU;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C72606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C72606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7+rIjLU
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so61761a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223382; x=1793828182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DRaEU9X7u2kKgzGCFR+7WnXnXObtsfCcW3cV0duCWvw=;
        b=D7+rIjLUXvHr1slSzSEx+f9OsxQDfVbZzeOCGJsAgJxQHUwwkAwuQJfjLoR5FdeYOK
         zWcg8JSiwPHWqGnSFz5hCSqAaquQMyHC5jFXTKkpZKwU68ra4zh6SXSe6kS4qMQ4FCWq
         XqNARcarq0qg6mH2v2iEvvTekhdAQVapS9/Nn1dE2ujbOhif7aYfu0zFVc4jB/G9nD2r
         q3mTYpwMDnVNW9NwMyyzDXFkKrcl6R+ZgyeJivnayfrWxckn0KSqE5GdRreaog7cOMvS
         Kxz785uI7qoDIqFfGUE5wtgqwxXtFJhcaPpsZY1oHFLMuP2Q+szbMwJxTjZWFRdIe9OB
         iwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223382; x=1793828182;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRaEU9X7u2kKgzGCFR+7WnXnXObtsfCcW3cV0duCWvw=;
        b=L3RDs1iHo1bwNWwrwdG393YU9b2a7OXJ5U3vxnWFk/juZEZextkeyLEaexnXBoAIhz
         wVkhz/FwDZnkfwDhlOHS/oZi9ScoX7OhKiiC8ZxEBorBm7hvbSjl74Rxhuz7Y5ZLDSMI
         6WEkt7h64uvrZCLjnVx+opnGZ31RKecMcvk++bOjsBTV4sMfcMwqAA97hNixBl+JWxg2
         stPqODlVGazPkj/SeJpWIsADn76c3mjvpxL9FtUb3MgEAppEDFnMxXrwgNBF60Q65J3n
         elubURzNpubS4o9DSOxLwec2Zxu7tsmTRwJFuLxXGOx9NZOsGWQtQEltjCRXPHn2XWPl
         sxSg==
X-Gm-Message-State: AFq9FYI95bTZQw1Eu4r1eDsXVKOFc4YbbhZdkMjSXQnguhtJ0bDkExwo
	trfiVcDx+/8gMVMdGEt7xrFw2iS9ojVx8ie78hQpejr5u33cb8H9wVN4
X-Gm-Gg: AYBFou1gNyw+nEK8ShfkNEaxGTezfhcLDQBjtrlnQ1HsiVrWSrsdd+obgqJXS6toQGR
	SOkD8YND+7jHy5anwpjXoxHdppnoE1WwCnEt75rSCWsh+jLgesa1BCPv86aDC/SzwOHb3/EevvH
	BdX0WnhArbDukJebpqkHf/L4pA2tTl/3c7+CWzEN4gvSggvNzJ8vfR3rkC/pthPITT7JjuM6X7t
	4o7PVClnJo4F7qWJyVZ8geExP0Ydt0xffnxHJ4hKcwTiLhhb5OC4QXOY1a+QcB/AhRgnJA9rU0F
	Ja6p8hwhcpmNFk6xJ8ay62ubgpwgf1Rwhj8X/NsFQQ76nwXM4a/hjLbQ0J9y5FTqlHz7uZSlwrH
	j5UcL3NcfN8cnV9QqlQVeU6CFKPHhhViaZeYkSegnC9QiqFhB5UXdSpqRW6OIvE6deB3BvYBTeE
	rfaFhP//6v+f2kUf6rhfRC5HqoAYoedp3INkZqGeAjvfp2l0UNFFSRVhnbyG6b6QeU3DEo4xqX+
	kWvAucNX5Smvsnc782AkGTizzIg+3NZ56k4u9zQDlp8vxV5z2ZCx9Msb8QV8biwL/Isd5hcTs26
	4J3llYKMIJvHM8RTc3wOIkRMJbtwfS2VHHIjd8Hyct8osUeYoWtTcfcO5h6b2tEeSxM03hLKrlv
	q0AiFcwBg5LWyOanq9Rdd8oupbOzD9aVdprfkrNnDLPLwtATaWVUi2KaBukkd3DzqXns=
X-Received: by 2002:a17:90b:3148:b0:3ad:dc36:c3d7 with SMTP id 98e67ed59e1d1-3ae6efd853emr459350a91.24.1793223382119;
        Wed, 28 Oct 2026 14:36:22 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm1027495a91.9.2026.10.28.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:36:21 -0700 (PDT)
Subject: [net PATCH 03/13] fbnic: Keep the all-multi MACDA entry out of the
 address lists
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:19 -0700
Message-ID: 
 <179322337944.40667.340791169611814458.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic_bmc_rpc_all_multi_config function installs the multicast
wildcard in the entry just below mac_addr_boundary and points the BMC
all-multi action rule at that index. It only installs the wildcard if
the entry is not already valid, and never checks what a valid entry
holds.

Both the unicast and the multicast list can hand that entry out. The
__fbnic_uc_sync function scans up from mac_addr_boundary - 1 and takes
it once the entries above are full, and the __fbnic_mc_sync function
takes it once the entries below are full. Once a host address sits there
the wildcard is never installed, the BMC loses all-multi, and the BMC
all-multi rule, which only delivers to the BMC, matches the host address
instead and steals its traffic. A unicast address there is not even
reachable by the fbnic_uc_unsync function, which starts its scan at
mac_addr_boundary.

Reserve the entry for the wildcard. The unicast scan now starts at
mac_addr_boundary, matching the fbnic_uc_unsync function, and the
multicast sync and unsync scans start one below it. This costs the
multicast list one entry; past that it falls back to all-multi as
before.

Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c    |    8 +++++---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h    |    6 +++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8a6703afca38..a40566029a86 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -170,7 +170,7 @@ static int fbnic_mc_unsync(struct net_device *netdev, const unsigned char *addr)
 	 * Skip over the address reserved for the BMC MAC and
 	 * exclude index 0 as that belongs to the broadcast address
 	 */
-	for (i = fbd->mac_addr_boundary, ret = -ENOENT;
+	for (i = fbd->mac_addr_boundary - 1, ret = -ENOENT;
 	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX && ret;) {
 		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index dc86b51f3583..0be71e6fd3d4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -477,8 +477,9 @@ struct fbnic_mac_addr *__fbnic_uc_sync(struct fbnic_dev *fbd,
 	/* Scan from middle of list to bottom, filling bottom up.
 	 * Skip the first entry which is reserved for dev_addr and
 	 * leave the last entry to use for promiscuous filtering.
+	 * The entry below the boundary is reserved for all-multi.
 	 */
-	for (i = fbd->mac_addr_boundary - 1;
+	for (i = fbd->mac_addr_boundary;
 	     i < FBNIC_RPC_TCAM_MACDA_HOST_ADDR_IDX; i++) {
 		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
 
@@ -507,9 +508,10 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
 
 	/* Scan from middle of list to top, filling top down.
 	 * Skip over the address reserved for the BMC MAC and
-	 * exclude index 0 as that belongs to the broadcast address
+	 * exclude index 0 as that belongs to the broadcast address.
+	 * The entry below the boundary is reserved for all-multi.
 	 */
-	for (i = fbd->mac_addr_boundary;
+	for (i = fbd->mac_addr_boundary - 1;
 	     --i > FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX;) {
 		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[i];
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index 3d4925b2ac75..679ba0a1058d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -156,9 +156,9 @@ enum {
  * always go top-down with unicast, and bottom-up with multicast so that
  * there should be free-space in the middle between the two.
  *
- * The entry at MADCA_DEFAULT_BOUNDARY is a special case as it can be used
- * for the ALL MULTI address if the list is full, or the BMC has requested
- * it.
+ * The entry just below the boundary is reserved for the ALL MULTI address,
+ * used if the list is full, or the BMC has requested it. Neither the unicast
+ * nor the multicast list allocates it.
  */
 #define FBNIC_RPC_TCAM_MACDA_MULTICAST_IDX	5
 #define FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY	24


